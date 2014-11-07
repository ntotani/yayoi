
local GameLayer = {}
GameLayer = class("GameLayer",function()
    return CCBReaderLoad("GameLayer.ccbi", cc.CCBProxy:create(), nil)
end)

function GameLayer:ctor()
    local map = cc.TMXTiledMap:create("tmx/forest.tmx")
    self:addChild(map)
    local tile = cc.Sprite:create("img/tile.png")
    tile:setPosition(100, 200)
    self:addChild(tile)
    local player = CCBReaderLoad("PlayerNode.ccbi", cc.CCBProxy:create(), nil)
    player:setPosition(100, 200)
    player:setScaleX(-1)
    self:addChild(player)
end

function GameLayer.createScene()
    local scene = cc.Scene:create()
    scene:addChild(GameLayer.new())
    return scene
end

return GameLayer
