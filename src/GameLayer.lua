local _ = require("underscore")
local ROW = 5
local COL = 5
local TILE_WIDTH = 50

local GameLayer = {}
GameLayer = class("GameLayer",function()
    return CCBReaderLoad("GameLayer.ccbi", cc.CCBProxy:create(), nil)
end)

function GameLayer:ctor()
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

    local myArea = 2
    local friendsNum = 3
    self.friendsLayer = cc.Layer:create()
    _.range(1, ROW * myArea):chain():map(function(i)
        return {i = i, lot = math.random()}
    end):sort(function(a, b)
        return a.lot < b.lot
    end):head(friendsNum):map(function(e)
        local player = CCBReaderLoad("PlayerNode.ccbi", cc.CCBProxy:create(), nil)
        local row = math.ceil(e.i / myArea)
        local col = e.i % myArea + 1
        player:setPosition(self:idx2tilePos(row, col))
        player:setScaleX(-1)
        player.tile = {i = row, j = col}
        player.hearts = _.range(1, 3):map(function(i)
            local heart = cc.Sprite:create("img/heart.png")
            heart:setPosition((i - 2) * heart:getContentSize().width, 20)
            player:addChild(heart)
            return heart
        end)
        self.friendsLayer:addChild(player)
    end)
    self:addChild(self.friendsLayer)

    self.myChips = {}
    _.range(1, 3):each(_.curry(self.drawChip, self))
    local deck = cc.Sprite:create("img/chip_reverse.png")
    deck:setPosition(self:idx2chipPos(4))
    self:addChild(deck)

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(_.curry(self.onTouchBegan, self), cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(_.curry(self.onTouchMoved, self), cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(_.curry(self.onTouchEnded, self), cc.Handler.EVENT_TOUCH_CANCELLED)
    listener:registerScriptHandler(_.curry(self.onTouchEnded, self), cc.Handler.EVENT_TOUCH_ENDED)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
end

function GameLayer:idx2tilePos(i, j)
    local x = self.visibleSize.width / 2 + (j - (COL / 2 + 0.5)) * TILE_WIDTH
    local y = self.visibleSize.height / 2 + (i - (ROW / 2 + 0.5)) * TILE_WIDTH
    return cc.p(x, y)
end

function GameLayer:idx2chipPos(idx)
    return cc.p(idx * 72, 80)
end

function GameLayer:drawChip(idx)
    local dirs = {front = {i=0, j=1}, back = {i=0, j=-1}, left = {i=1, j=0}, right = {i=-1, j=0}}
    local dir = _.keys(dirs)[math.random(1, 4)]
    local chip = cc.Sprite:create("img/chip_" .. dir .. ".png")
    chip.idx = idx
    chip.dir = dirs[dir]
    chip:setPosition(self:idx2chipPos(idx))
    self.myChips[idx] = chip
    self:addChild(chip)
end

function GameLayer:onTouchBegan(touch, event)
    self.holdChip = _.detect(self.myChips, function(e)
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
        local ni = player.tile.i + self.holdChip.dir.i
        local nj = player.tile.j + self.holdChip.dir.j
        if 0 < ni and ni <= ROW and 0 < nj and nj <= COL then
            local target = _.detect(self.friendsLayer:getChildren(), function(e)
                return e.tile.i == ni and e.tile.j == nj
            end)
            if target then
                if #target.hearts == 1 then
                    target:removeFromParent()
                else
                    _(target.hearts):pop():removeFromParent()
                end
            else
                player.tile.i = ni
                player.tile.j = nj
                player:setPosition(self:idx2tilePos(ni, nj))
            end
        end
        self:drawChip(self.holdChip.idx)
        self.holdChip:removeFromParent()
    else
        self.holdChip:setPosition(self:idx2chipPos(self.holdChip.idx))
    end
    self.holdChip = nil
end

function GameLayer.createScene()
    local scene = cc.Scene:create()
    scene:addChild(GameLayer.new())
    return scene
end

return GameLayer
