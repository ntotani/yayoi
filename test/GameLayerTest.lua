
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

    local bs = {}
    bs["0"] = 10
    bs["1"] = 11
    bs["2"] = 12
    local red  = yayoi.Piece:new(1, 1, bs, bs, 0, 2, 0, true)
    local blue = yayoi.Piece:new(1, 1, bs, bs, 1, 2, 4, true)
    local freq = {}
    freq[yayoi.Chip:new( 0, 1)] = 6 -- front
    freq[yayoi.Chip:new( 1, 0)] = 3 -- up
    freq[yayoi.Chip:new(-1, 0)] = 3 -- down
    freq[yayoi.Chip:new( 1, 1)] = 6 -- ufront
    freq[yayoi.Chip:new(-1, 1)] = 6 -- dfront
    local match = yayoi.Match:new(0, {red, blue}, 5, 5, freq)
    local ctx = {
        on = function(self, event, callback) self.callback = callback end,
        getCorner = function(self) return "red" end,
        act = function(self, playerID, chipID)
            local p = match:getPieces()[playerID + 1]
            match:applyChip(p, chipID)
            self.callback({playerID .. chipID, "10"})
        end,
        getMatch = function(self) return match end
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
