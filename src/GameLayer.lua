
local GameLayer = {}
GameLayer = class("GameLayer",function()
    return CCBReaderLoad("GameLayer.ccbi", cc.CCBProxy:create(), nil)
end)

function GameLayer.createScene()
    local scene = cc.Scene:create()
    scene:addChild(GameLayer.new())
    return scene
end

return GameLayer
