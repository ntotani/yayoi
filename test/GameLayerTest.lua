
cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")
cc.FileUtils:getInstance():addSearchPath("res/ccbi")

-- CC_USE_DEPRECATED_API = true
require "cocos.init"

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    -- initialize director
    local director = cc.Director:getInstance()

    --turn on display FPS
    director:setDisplayStats(true)

    director:getOpenGLView():setDesignResolutionSize(360, 640, cc.ResolutionPolicy.FIXED_WIDTH)

    local ctx = {
        on = function(self, event, callback) print("ctx.on", event) end,
        getCorner = function(self) return "red" end,
        getForm = function(self) return {red = {1, 6, 11}, blue = {20, 15, 10}} end,
        act = function(self, playerID, chipID) print("ctx.act", playerID, chipID) end
    }

    --create scene
    local layer = require("GameLayer").new(ctx)
    local scene = cc.Scene:create()
    scene:addChild(layer)

    if director:getRunningScene() then
        director:replaceScene(scene)
    else
        director:runWithScene(scene)
    end

end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
