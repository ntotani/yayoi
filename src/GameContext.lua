local json = require("json")
local _ = require("underscore")

local GameContext = {}
GameContext = class("GameContext",function() return {} end)

function GameContext:ctor(ws, matchID, corner, form, seed)
    self._ws = ws
    self._matchID = matchID
    self._corner = corner
    local master = cc.FileUtils:getInstance():getStringFromFile("piece.json")
    master = json.decode(master)
    local jobs = {FIGHTER = 0, MAGE = 1, HEALER = 2}
    local colors = { SUN=0, MON=1, TUE=2, WED=3, THU=4, FRI=5, SAT=6 }
    for k, v in pairs(master) do
        local bs = {}
        bs["0"] = v[3]
        bs["1"] = v[4]
        bs["2"] = v[5]
        yayoi.Piece:setMaster(tonumber(k), jobs[v[1]], colors[v[2]], bs)
    end
    self:initMatch()
    ws:registerScriptHandler(function(msg)
        msg = json.decode(msg)
        if msg.event == "turn" then
            local data = json.decode(msg.data)
            local results = {}
            for i, e in ipairs(data) do
                local playerID = tonumber(e:sub(1, 1))
                local chipID = tonumber(e:sub(2, 2))
                local actor = _.detect(self._match:getPieces(), function(e)
                    return e:getIdInMatch() == playerID
                end)
                table.insert(results, self._match:applyChip(actor, chipID))
                if self._match:wonTeam() ~= 2 then
                    break
                end
            end
            for i, e in ipairs(self.listeners.turn) do
                e(results)
            end
        end
    end, cc.WEBSOCKET_MESSAGE)
end

function GameContext:initMatch()
    local iv = {}
    iv["0"] = 30
    iv["1"] = 30
    iv["2"] = 30
    local rKnight  = yayoi.Piece:new(0, iv, 0, 1, 0, false)
    local rKing    = yayoi.Piece:new(1, iv, 0, 2, 0, true)
    local rWitch   = yayoi.Piece:new(2, iv, 0, 3, 0, false)
    local bKnight  = yayoi.Piece:new(0, iv, 1, 1, 4, false)
    local bKing    = yayoi.Piece:new(1, iv, 1, 2, 4, true)
    local bWitch   = yayoi.Piece:new(2, iv, 1, 3, 4, false)
    local freq = {}
    freq[yayoi.Chip:new( 0,  1)] = 5 -- front
    freq[yayoi.Chip:new(-1,  1)] = 4 -- dfront
    freq[yayoi.Chip:new(-1,  0)] = 2 -- down
    freq[yayoi.Chip:new(-1, -1)] = 1 -- dback
    freq[yayoi.Chip:new( 0, -1)] = 2 -- back
    freq[yayoi.Chip:new( 1, -1)] = 1 -- uback
    freq[yayoi.Chip:new( 1,  1)] = 4 -- ufront
    freq[yayoi.Chip:new( 1,  0)] = 2 -- up
    self._match = yayoi.Match:new(0, {rKnight, rKing, rWitch, bKnight, bKing, bWitch}, 5, 5, freq)
    self.listeners = {}
end

function GameContext:getCorner()
    return self._corner
end

function GameContext:getMatch()
    return self._match
end

function GameContext:on(event, callback)
    if self.listeners[event] then
        table.insert(self.listeners[event], callback)
    else
        self.listeners[event] = {callback}
    end
end

function GameContext:act(playerID, chipID)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    xhr:setRequestHeader("X-Parse-Application-Id", "so6Tb3E5JowUXObTBdnRJaBWXf8ZQZjAslBlmdoE")
    xhr:setRequestHeader("X-Parse-REST-API-Key", "rkfvd1LPNsIvYV40EfWKZXnYwKrXBDHLJpFj6tj6")
    xhr:setRequestHeader("Content-Type", "application/json")
    xhr:open("PUT", "https://api.parse.com/1/classes/Match/" .. self._matchID)
    xhr:registerScriptHandler(function()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            --print(xhr.response)
        else
            print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
    end)
    xhr:send(json.encode({acts = {__op = "Add", objects = {playerID .. chipID}}}))
end

return GameContext
