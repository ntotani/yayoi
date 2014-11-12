local _ = require("underscore")
local json = require("json")

local ROW = 4
local COL = 5
local TILE_WIDTH = 50
local DAMAGE = {
    Player = {Player = 1, Witch = 2, Tank = 1},
    Witch  = {Player = 1, Witch = 1, Tank = 2},
    Tank   = {Player = 2, Witch = 1, Tank = 1}
}
local DECK = { front = 6, up = 3, down = 3, ufront = 6, dfront = 6}

local GameLayer = {}
GameLayer = class("GameLayer",function()
    return CCBReaderLoad("GameLayer.ccbi", cc.CCBProxy:create(), nil)
end)

local function reverse(corner)
    return corner == "red" and "blue" or "red"
end

function GameLayer:ctor(ws, matchId, corner, form, seed)
    self.ws = ws
    self.matchId = matchId
    self.corner = corner
    self.turn = -1
    self.redDeck = {}
    self.blueDeck = {}
    randomSeed(seed)
    ws:registerScriptHandler(_.curry(self.onMessage, self), cc.WEBSOCKET_MESSAGE)

    self:addChild(cc.TMXTiledMap:create("tmx/forest.tmx"))
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.tiles = _.range(1, ROW):map(function(i)
        return _.range(1, COL):map(function(j)
            local tile = cc.Sprite:create("img/tile.png")
            tile:setPosition(self:idx2tilePos(i, j))
            self:addChild(tile)
            return tile
        end)
    end)

    self.friendsLayer = self:initHeros(-1, form, corner)
    self:addChild(self.friendsLayer)
    self.enemiesLayer = self:initHeros(1, form, reverse(corner))
    self:addChild(self.enemiesLayer)
    if corner == "red" then
        self.myChipsLayer = self:initChips(-1, "red")
        self.hisChipsLayer = self:initChips(1, "blue")
    else
        self.hisChipsLayer = self:initChips(1, "red")
        self.myChipsLayer = self:initChips(-1, "blue")
    end
    self:addChild(self.myChipsLayer)
    self:addChild(self.hisChipsLayer)

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(_.curry(self.onTouchBegan, self), cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(_.curry(self.onTouchMoved, self), cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(_.curry(self.onTouchEnded, self), cc.Handler.EVENT_TOUCH_CANCELLED)
    listener:registerScriptHandler(_.curry(self.onTouchEnded, self), cc.Handler.EVENT_TOUCH_ENDED)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
end

function GameLayer:initHeros(dir, form, corner)
    local layer = cc.Layer:create()
    local jobs = {"Player", "Witch", "Tank"}
    local id = (corner == "blue" and 4 or 1)
    _.each(form[corner], function(i)
        local job = _.shift(jobs)
        local player = CCBReaderLoad(job .. "Node.ccbi", cc.CCBProxy:create(), nil)
        local row = math.ceil(i / COL)
        local col = (i - 1) % COL + 1
        player:setPosition(self:idx2tilePos(row, col))
        player:setScaleX(dir)
        player.tile = {i = row, j = col}
        player.job = job
        player.id = id
        id = id + 1
        player.hearts = _.range(1, 3):map(function(i)
            local heart = cc.Sprite:create("img/heart.png")
            heart:setPosition((i - 2) * heart:getContentSize().width, 20)
            player:addChild(heart)
            return heart
        end)
        layer:addChild(player)
    end)
    return layer
end

function GameLayer:initChips(turn, corner)
    local layer = cc.Layer:create()
    _.range(1, 4):each(function(i)
        self:drawChip(i, layer, turn, corner)
    end)
    return layer
end

function GameLayer:idx2tilePos(i, j)
    if self.corner == "blue" then
        j = COL - j + 1
    end
    local x = self.visibleSize.width / 2 + (j - (COL / 2 + 0.5)) * TILE_WIDTH
    local y = self.visibleSize.height / 2 + (i - (ROW / 2 + 0.5)) * TILE_WIDTH
    return cc.p(x, y)
end

function GameLayer:idx2chipPos(idx, turn)
    local x = idx * 72
    local y = 80
    if turn > 0 then
        x = self.visibleSize.width - x
        y = self.visibleSize.height - y
    end
    return cc.p(x, y)
end

function GameLayer:drawChip(idx, layer, turn, corner)
    local deck = corner == "red" and self.redDeck or self.blueDeck
    if #deck < 1 then self:refillDeck(deck) end
    local dirs = {front = {i=0, j=1}, up = {i=1, j=0}, down = {i=-1, j=0}, ufront = {i=1, j=1}, dfront = {i=-1, j=1}}
    local dir = _.shift(deck)
    local chip = cc.Sprite:create("img/chip_" .. dir .. ".png")
    chip.idx = idx
    chip.dir = dirs[dir]
    chip.dir.j = (corner == "red" and 1 or -1) * chip.dir.j
    chip:setPosition(self:idx2chipPos(idx, turn))
    chip:setScaleX(-turn)
    layer:addChild(chip)
end

function GameLayer:refillDeck(deck)
    local chips = {}
    _(_.keys(DECK)):chain():sort():each(function(key)
        for i=1, DECK[key] do
            table.insert(chips, {chip = key, lot = random() % 100})
        end
    end)
    _(chips):chain():sort(function(a, b)
        return a.lot < b.lot
    end):each(function(e)
        _.push(deck, e.chip)
    end)
end

function GameLayer:onTouchBegan(touch, event)
    self.holdChip = _.detect(self.myChipsLayer:getChildren(), function(e)
        return cc.rectContainsPoint(e:getBoundingBox() ,touch:getLocation())
    end)
    return self.holdChip ~= nil
end

function GameLayer:onTouchMoved(touch, event)
    self.holdChip:setPosition(touch:getLocation())
end

function GameLayer:onTouchEnded(touch, event)
    local player = _.detect(self.friendsLayer:getChildren(), function(e)
        return cc.rectContainsPoint(self.tiles[e.tile.i][e.tile.j]:getBoundingBox(), cc.p(self.holdChip:getPosition()))
    end)
    if player then
        self:putAction(player.id .. self.holdChip.idx)
    end
    self.holdChip:setPosition(self:idx2chipPos(self.holdChip.idx, self.turn))
    self.holdChip = nil
end

function GameLayer:putAction(act)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    xhr:setRequestHeader("X-Parse-Application-Id", "so6Tb3E5JowUXObTBdnRJaBWXf8ZQZjAslBlmdoE")
    xhr:setRequestHeader("X-Parse-REST-API-Key", "rkfvd1LPNsIvYV40EfWKZXnYwKrXBDHLJpFj6tj6")
    xhr:setRequestHeader("Content-Type", "application/json")
    xhr:open("PUT", "https://api.parse.com/1/classes/Match/" .. self.matchId)
    xhr:registerScriptHandler(function()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            --print(xhr.response)
            print("ok")
        else
            print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
    end)
    xhr:send(json.encode({acts = {__op = "Add", objects = {act}}}))
end

function GameLayer:onMessage(msg)
    msg = json.decode(msg)
    if msg.event == "turn" then
        local data = json.decode(msg.data)
        local redIdx = 1
        local blueIdx = 1
        local func = function()end
        func = function(i)
            if i > #data then
                if self.corner == "red" then
                    self:drawChip(redIdx, self.myChipsLayer, -1, "red")
                    self:drawChip(blueIdx, self.hisChipsLayer, 1, "blue")
                else
                    self:drawChip(redIdx, self.hisChipsLayer, 1, "red")
                    self:drawChip(blueIdx, self.myChipsLayer, -1, "blue")
                end
            else
                local e = data[i]
                local actor = tonumber(e:sub(1, 1))
                local action = tonumber(e:sub(2, 2))
                local eq = function(e) return e.id == actor end
                local target = _.detect(self.friendsLayer:getChildren(), eq)
                target = target or _.detect(self.enemiesLayer:getChildren(), eq)
                local chips = target:getScaleX() < 0 and self.myChipsLayer or self.hisChipsLayer
                local chip = _.detect(chips:getChildren(), function(e) return e.idx == action end)
                self:action(target, chip, _.curry(func, i + 1))
                if actor <= 3 then
                    redIdx = action
                else
                    blueIdx = action
                end
            end
        end
        func(1)
    end
end

function GameLayer:action(player, chip, callback)
    chip:runAction(cc.Sequence:create(
        cc.MoveTo:create(0.5, cc.p(player:getPosition())),
        cc.CallFunc:create(function()
            local ni = player.tile.i + chip.dir.i
            local nj = player.tile.j + chip.dir.j
            local playerSeq = {
                cc.MoveTo:create(0.1, self:idx2tilePos(ni, nj)),
                cc.MoveTo:create(0.1, self:idx2tilePos(player.tile.i, player.tile.j)),
                cc.DelayTime:create(0.3)
            }
            if 0 < ni and ni <= ROW and 0 < nj and nj <= COL then
                local eq = function(e) return e.tile.i == ni and e.tile.j == nj end
                local target = _.detect(self.friendsLayer:getChildren(), eq)
                target = target or _.detect(self.enemiesLayer:getChildren(), eq)
                local gain = function()
                    table.insert(playerSeq, cc.MoveTo:create(0.5, self:idx2tilePos(ni, nj)))
                    table.insert(playerSeq, cc.CallFunc:create(function()
                        player.tile.i = ni
                        player.tile.j = nj
                    end))
                end
                if target then
                    local dmg = DAMAGE[player.job][target.job]
                    if #target.hearts <= dmg then
                        target:removeFromParent()
                        gain()
                    else
                        for i=1, dmg do
                            _(target.hearts):pop():removeFromParent()
                        end
                    end
                else
                    gain()
                end
            end
            table.insert(playerSeq, cc.CallFunc:create(callback))
            player:stopAllActions()
            player:runAction(cc.Sequence:create(playerSeq))
            chip:removeFromParent()
        end)
    ))
end

return GameLayer
