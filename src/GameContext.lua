local json = require("json")

local GameContext = {}
GameContext = class("GameContext",function() return {} end)

function GameContext:ctor(ws, matchID, corner, form, seed)
    self._ws = ws
    self._matchID = matchID
    self._corner = corner
    self._form = form
    self.listeners = {}
    randomSeed(seed)
    ws:registerScriptHandler(function(msg)
        msg = json.decode(msg)
        if msg.event == "turn" then
            local data = json.decode(msg.data)
            for i, e in ipairs(self.listeners.turn) do
                e(data)
            end
        end
    end, cc.WEBSOCKET_MESSAGE)
end

function GameContext:getCorner()
    return self._corner
end

function GameContext:getForm()
    return self._form
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
