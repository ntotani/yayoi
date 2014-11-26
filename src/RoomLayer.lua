local _ = require("underscore")
local json = require("json")

local RoomLayer = {}
RoomLayer = class("RoomLayer",function()
    local layer = nil
    ccb.RoomLayer = {
        build = function()
            ccb.RoomLayer.number:setString("connecting...")
            ccb.RoomLayer.mAnimationManager:runAnimationsForSequenceNamed("wait")
            layer:initWebsocket(true)
        end,
        join = function()
            ccb.RoomLayer.mAnimationManager:runAnimationsForSequenceNamed("wait")
            layer:initWebsocket(false)
        end
    }
    for i=0, 9 do
        ccb.RoomLayer["num" .. i] = function()
            ccb.RoomLayer.mAnimationManager:runAnimationsForSequenceNamed("join")
            ccb.RoomLayer.number:setString(ccb.RoomLayer.number:getString() .. i)
        end
    end
    layer = CCBReaderLoad("RoomLayer.ccbi", cc.CCBProxy:create(), nil)
    return layer
end)

function RoomLayer:ctor()
    ccb.RoomLayer.number:setString("")
end

function RoomLayer:initWebsocket(isBuild)
    self.corner = isBuild and "red" or "blue"
    self.ws = cc.WebSocket:create("ws://ws.pusherapp.com/app/753bbbbb0ecb441ce3eb?protocol=7")
    if nil ~= self.ws then
        self.ws:registerScriptHandler(function(msg)
            cclog("WebScoket: " .. msg)
            msg = json.decode(msg)
            if msg.event == "pusher:connection_established" then
                local data = json.decode(msg.data)
                local channelId = isBuild and "" or ccb.RoomLayer.number:getString()
                self:cloudFunc("pusher", {socket_id = data.socket_id, channel_id = channelId}, function(ret)
                    self.ws:sendString(json.encode({
                        event = "pusher:subscribe",
                        data = {
                            channel = "private-" .. ret.channel_id,
                            auth = ret.auth
                        }
                    }))
                    if isBuild then
                        ccb.RoomLayer.number:setString(ret.channel_id)
                    end
                end)
            elseif msg.event == "pusher_internal:subscription_succeeded" then
                if not isBuild then
                    self:cloudFunc("start", {channel_id = ccb.RoomLayer.number:getString()}, function()end)
                end
            elseif msg.event == "start" then
                self.ws:unregisterScriptHandler(cc.WEBSOCKET_MESSAGE)
                local data = json.decode(msg.data)
                local scene = cc.Scene:create()
                local ctx = require("GameContext").new(self.ws, data.id, self.corner, data.form, data.seed)
                scene:addChild(require("GameLayer").new(ctx))
                cc.Director:getInstance():replaceScene(scene)
            end
        end, cc.WEBSOCKET_MESSAGE)
    end
end

function RoomLayer:cloudFunc(name, params, callback)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    xhr:setRequestHeader("X-Parse-Application-Id", "so6Tb3E5JowUXObTBdnRJaBWXf8ZQZjAslBlmdoE")
    xhr:setRequestHeader("X-Parse-REST-API-Key", "rkfvd1LPNsIvYV40EfWKZXnYwKrXBDHLJpFj6tj6")
    xhr:setRequestHeader("Content-Type", "application/json")
    xhr:open("POST", "https://api.parse.com/1/functions/" .. name)
    xhr:registerScriptHandler(function()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            local response = json.decode(xhr.response)
            callback(response.result)
        else
            print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
    end)
    xhr:send(json.encode(params))
end

return RoomLayer
