local json = require("json")
local _ = require("underscore")

local GameContext = {}
GameContext = class("GameContext",function() return {} end)

function GameContext:ctor(ws, matchID, corner, form, seed)
    self._ws = ws
    self._matchID = matchID
    self._corner = corner
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
    self._match = yayoi.Match:new(seed, {red, blue}, 5, 5, freq)
    self.listeners = {}
    ws:registerScriptHandler(function(msg)
        msg = json.decode(msg)
        if msg.event == "turn" then
            local data = json.decode(msg.data)
            data = _.map(data, function(e)
                local playerID = tonumber(e:sub(1, 1))
                local chipID = tonumber(e:sub(2, 2))
                local actor = _.detect(self._match:getPieces(), function(e)
                    return e:getIdInMatch() == playerID
                end)
                return self._match:applyChip(actor, chipID)
            end)
            for i, e in ipairs(self.listeners.turn) do
                e(data)
            end
        end
    end, cc.WEBSOCKET_MESSAGE)
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
            print("ok")
        else
            print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
    end)
    xhr:send(json.encode({acts = {__op = "Add", objects = {playerID .. chipID}}}))
end

return GameContext
