local _ = require("underscore")
local json = require("json")

local TILE_WIDTH = 50

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
    local pieces = self.ctx:getMatch():getPieces()
    local myTeam = corner == "red" and 0 or 1
    _.each(pieces, function(e)
        if e:getTeam() ~= myTeam then return end
        local job = _.shift(jobs)
        local player = CCBReaderLoad(job .. "Node.ccbi", cc.CCBProxy:create(), nil)
        local row = e:getPosition().first
        local col = e:getPosition().second
        player:setPosition(self:idx2tilePos(row, col))
        player:setScaleX(dir)
        player.model = e
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
    chip.model = deck[idx]
    chip.idx = idx
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
        local pos = e.model:getPosition()
        return cc.rectContainsPoint(self.tiles[pos.first + 1][pos.second + 1]:getBoundingBox(), cc.p(self.holdChip:getPosition()))
    end)
    if player then
        self.canTouch = false
        self.ctx:act(player.model:getIdInMatch(), self.holdChip.idx - 1)
    end
    self.holdChip:setPosition(self:idx2chipPos(self.holdChip.idx, self.turn))
    self.holdChip = nil
end

function GameLayer:onTurn(data)
    local func = function()end
    func = function(i)
        if i > #data then
            local shift = function(chips, deck, turn)
                for i, chip in ipairs(chips:getChildren()) do
                    local idx = 0
                    for j, e in ipairs(deck) do
                        if chip.model == e then
                            idx = j
                            break
                        end
                    end
                    chip.idx = idx
                    chip:runAction(cc.MoveTo:create(0.5, self:idx2chipPos(idx, turn)))
                end
            end
            local c = self.ctx:getCorner()
            shift(self.myChipsLayer, self.ctx:getMatch():getDeck(c == "red" and 0 or 1), -1)
            shift(self.hisChipsLayer, self.ctx:getMatch():getDeck(c == "red" and 1 or 0), 1)
            self:drawChip(4, self.myChipsLayer, -1, c)
            self:drawChip(4, self.hisChipsLayer, 1, reverse(c))
            self.canTouch = true
        else
            local ar = data[i]
            local eq = function(e) return e.model == ar:getActor() end
            local target = _.detect(self.friendsLayer:getChildren(), eq)
            target = target or _.detect(self.enemiesLayer:getChildren(), eq)
            local chips = target:getScaleX() < 0 and self.myChipsLayer or self.hisChipsLayer
            local chip = _.detect(chips:getChildren(), function(e) return e.model == ar:getChip() end)
            self:action(ar, target, chip, _.curry(func, i + 1))
        end
    end
    func(1)
end

function GameLayer:action(ar, player, chip, callback)
    chip:runAction(cc.Sequence:create(
        cc.MoveTo:create(0.5, cc.p(player:getPosition())),
        cc.CallFunc:create(function()
            local playerSeq = {}
            local lush = function()
                local pos = player.model:getPosition()
                local move = ar:getMove()
                table.insert(playerSeq, cc.MoveTo:create(0.1, self:idx2tilePos(pos.first + move.first, pos.second + move.second)))
                table.insert(playerSeq, cc.MoveTo:create(0.1, self:idx2tilePos(pos.first, pos.second)))
                table.insert(playerSeq, cc.DelayTime:create(0.3))
            end
            local gain = function()
                local pos = player.model:getPosition()
                table.insert(playerSeq, cc.MoveTo:create(0.5, self:idx2tilePos(pos.first, pos.second)))
            end
            local type = ar:getType()
            if type == 0 then -- MOVE
                gain()
            elseif type == 1 then -- WALL
                lush()
            else
                lush()
                local eq = function(e) return e.model == ar:getTarget() end
                local target = _.detect(self.friendsLayer:getChildren(), eq)
                target = target or _.detect(self.enemiesLayer:getChildren(), eq)
                local dmg = 1
                if type == 3 then -- KILL
                    target:removeFromParent()
                    gain()
                else -- ATTACK
                    for i=1, dmg do _(target.hearts):pop():removeFromParent() end
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
