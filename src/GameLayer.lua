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
    for i=1, ROW do
        for j=1, COL do
            local tile = cc.Sprite:create("img/tile.png")
            tile:setPosition(self:idx2tilePos(i, j))
            self:addChild(tile)
        end
    end

    local player = CCBReaderLoad("PlayerNode.ccbi", cc.CCBProxy:create(), nil)
    player:setPosition(self:idx2tilePos(1, 1))
    player:setScaleX(-1)
    self:addChild(player)

    self.myChips = _.range(1, 3):map(function(i)
        local chip = cc.Sprite:create("img/chip_front.png")
        chip:setPosition(self:idx2chipPos(i))
        chip.idx = i
        self:addChild(chip)
        return chip
    end)
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

function GameLayer:onTouchBegan(touch, event)
    self.holdChip = _(self.myChips):detect(function(e)
        return cc.rectContainsPoint(e:getBoundingBox() ,touch:getLocation())
    end)
    return self.holdChip ~= nil
end

function GameLayer:onTouchMoved(touch, event)
    self.holdChip:setPosition(touch:getLocation())
end

function GameLayer:onTouchEnded(touch, event)
    self.holdChip:setPosition(self:idx2chipPos(self.holdChip.idx))
    self.holdChip = nil
end

function GameLayer.createScene()
    local scene = cc.Scene:create()
    scene:addChild(GameLayer.new())
    return scene
end

return GameLayer
