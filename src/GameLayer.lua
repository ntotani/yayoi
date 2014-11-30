local _ = require("underscore")
local json = require("json")

local TILE_WIDTH = 50
local DAMAGE = {
    Player = {Player = 1, Witch = 2, Tank = 1},
    Witch  = {Player = 1, Witch = 1, Tank = 2},
    Tank   = {Player = 2, Witch = 1, Tank = 1}
}

local GameLayer = {}
GameLayer = class("GameLayer",function()
    return CCBReaderLoad("GameLayer.ccbi", cc.CCBProxy:create(), nil)
end)

local function reverse(corner)
    return corner == "red" and "blue" or "red"
end

function GameLayer:ctor(ctx)
    self.ctx = ctx
    self.turn = -1
    self.canTouch = true
    ctx:on("turn", _.curry(self.onTurn, self))
    local corner = ctx:getCorner()

    self:addChild(cc.TMXTiledMap:create("tmx/forest.tmx"))
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.tiles = _.range(0, ctx:getMatch():getRow() - 1):map(function(i)
        return _.range(0, ctx:getMatch():getCol() - 1):map(function(j)
            local tile = cc.Sprite:create("img/tile.png")
            tile:setPosition(self:idx2tilePos(i, j))
            self:addChild(tile)
            return tile
        end)
    end)

    self.friendsLayer = self:initHeros(-1, corner)
    self:addChild(self.friendsLayer)
    self.enemiesLayer = self:initHeros(1, reverse(corner))
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

function GameLayer:initHeros(dir, corner)
    local layer = cc.Layer:create()
    local jobs = {"Player", "Witch", "Tank"}
    local id = -1
    local pieces = self.ctx:getMatch():getPieces()
    local myTeam = corner == "red" and 0 or 1
    _.each(pieces, function(e)
        id = id + 1
        if e:getTeam() ~= myTeam then return end
        local job = _.shift(jobs)
        local player = CCBReaderLoad(job .. "Node.ccbi", cc.CCBProxy:create(), nil)
        local row = e:getPosition().first
        local col = e:getPosition().second
        player:setPosition(self:idx2tilePos(row, col))
        player:setScaleX(dir)
        player.tile = {i = row + 1, j = col + 1}
        player.job = job
        player.id = id
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
    if self.ctx:getCorner() == "blue" then
        j = self.ctx:getMatch():getCol() - j + 1
    end
    local x = self.visibleSize.width / 2 + (j - (self.ctx:getMatch():getCol() / 2 - 0.5)) * TILE_WIDTH
    local y = self.visibleSize.height / 2 + (i - (self.ctx:getMatch():getRow() / 2 - 0.5)) * TILE_WIDTH
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
    local deck = self.ctx:getMatch():getDeck(corner == "red" and 0 or 1)
    local dir = deck[idx]:getDir()
    local name = ""
    if dir.second == 1 then
        if dir.first == 1 then
            name = "ufront"
        elseif dir.first == -1 then
            name = "dfront"
        else
            name = "front"
        end
    else
        name = dir.first > 0 and "up" or "down"
    end
    local chip = cc.Sprite:create("img/chip_" .. name .. ".png")
    chip.idx = idx - 1
    chip.dir = {i = dir.first, j = dir.second}
    chip.dir.j = (corner == "red" and 1 or -1) * chip.dir.j
    chip:setPosition(self:idx2chipPos(idx, turn))
    chip:setScaleX(-turn)
    layer:addChild(chip)
end

function GameLayer:onTouchBegan(touch, event)
    self.holdChip = _.detect(self.myChipsLayer:getChildren(), function(e)
        return cc.rectContainsPoint(e:getBoundingBox() ,touch:getLocation())
    end)
    return self.holdChip ~= nil and self.canTouch
end

function GameLayer:onTouchMoved(touch, event)
    self.holdChip:setPosition(touch:getLocation())
end

function GameLayer:onTouchEnded(touch, event)
    local player = _.detect(self.friendsLayer:getChildren(), function(e)
        return cc.rectContainsPoint(self.tiles[e.tile.i][e.tile.j]:getBoundingBox(), cc.p(self.holdChip:getPosition()))
    end)
    if player then
        self.canTouch = false
        self.ctx:act(player.id, self.holdChip.idx)
    end
    self.holdChip:setPosition(self:idx2chipPos(self.holdChip.idx + 1, self.turn))
    self.holdChip = nil
end

function GameLayer:onTurn(data)
    local redIdx = 1
    local blueIdx = 1
    local func = function()end
    func = function(i)
        if i > #data then
            if self.ctx:getCorner() == "red" then
                self:drawChip(redIdx, self.myChipsLayer, -1, "red")
                self:drawChip(blueIdx, self.hisChipsLayer, 1, "blue")
            else
                self:drawChip(redIdx, self.hisChipsLayer, 1, "red")
                self:drawChip(blueIdx, self.myChipsLayer, -1, "blue")
            end
            self.canTouch = true
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
            if self.ctx:getMatch():getPieces()[actor + 1]:getTeam() == 0 then
                redIdx = action
            else
                blueIdx = action
            end
        end
    end
    func(1)
end

function GameLayer:action(player, chip, callback)
    chip:runAction(cc.Sequence:create(
        cc.MoveTo:create(0.5, cc.p(player:getPosition())),
        cc.CallFunc:create(function()
            local ni = player.tile.i - 1 + chip.dir.i
            local nj = player.tile.j - 1 + chip.dir.j
            local playerSeq = {}
            local lush = function()
                table.insert(playerSeq, cc.MoveTo:create(0.1, self:idx2tilePos(ni, nj)))
                table.insert(playerSeq, cc.MoveTo:create(0.1, self:idx2tilePos(player.tile.i, player.tile.j)))
                table.insert(playerSeq, cc.DelayTime:create(0.3))
            end
            local gain = function()
                table.insert(playerSeq, cc.MoveTo:create(0.5, self:idx2tilePos(ni, nj)))
                table.insert(playerSeq, cc.CallFunc:create(function()
                    player.tile.i = ni
                    player.tile.j = nj
                end))
            end
            if 0 < ni and ni <= self.ctx:getMatch():getRow() and 0 < nj and nj <= self.ctx:getMatch():getCol() then
                local eq = function(e) return e.tile.i == ni and e.tile.j == nj end
                local target = _.detect(self.friendsLayer:getChildren(), eq)
                target = target or _.detect(self.enemiesLayer:getChildren(), eq)
                if target then
                    lush()
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
            else
                lush()
            end
            table.insert(playerSeq, cc.CallFunc:create(callback))
            player:stopAllActions()
            player:runAction(cc.Sequence:create(playerSeq))
            chip:removeFromParent()
        end)
    ))
end

return GameLayer
