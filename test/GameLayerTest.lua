
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

    local master = cc.FileUtils:getInstance():getStringFromFile("piece.json")
    master = require("json").decode(master)
    local jobs = {FIGHTER = 0, MAGE = 1, HEALER = 2}
    local colors = { SUN=0, MON=1, TUE=2, WED=3, THU=4, FRI=5, SAT=6 }
    for k, v in pairs(master) do
        local bs = {}
        bs["0"] = v[3]
        bs["1"] = v[4]
        bs["2"] = v[5]
        yayoi.Piece:setMaster(tonumber(k), jobs[v[1]], colors[v[2]], bs)
    end
    local iv = {}
    iv["0"] = 30
    iv["1"] = 30
    iv["2"] = 30
    local rKnight  = yayoi.Piece:new(0, iv, 0, 1, 0, false)
    local rKing    = yayoi.Piece:new(1, iv, 0, 2, 0, true)
    local rWitch   = yayoi.Piece:new(2, iv, 0, 3, 0, false)
    local bKnight  = yayoi.Piece:new(0, iv, 1, 0, 4, false)
    local bKing    = yayoi.Piece:new(1, iv, 1, 2, 4, true)
    local bWitch   = yayoi.Piece:new(2, iv, 1, 3, 4, false)
    local freq = {}
    freq[yayoi.Chip:new( 0, 1)] = 6 -- front
    freq[yayoi.Chip:new( 1, 0)] = 3 -- up
    freq[yayoi.Chip:new(-1, 0)] = 3 -- down
    freq[yayoi.Chip:new( 1, 1)] = 6 -- ufront
    freq[yayoi.Chip:new(-1, 1)] = 6 -- dfront
    local match = yayoi.Match:new(0, {rKnight, rKing, rWitch, bKnight, bKing, bWitch}, 5, 5, freq)
    local ctx = {
        on = function(self, event, callback) self.callback = callback end,
        getCorner = function(self) return "red" end,
        act = function(self, playerID, chipID)
            local p = match:getPieces()[playerID + 1]
            self.callback({match:applyChip(p, chipID), match:applyChip(bKnight, 0)})
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
