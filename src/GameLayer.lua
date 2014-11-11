local _ = require("underscore")
local ROW = 4
local COL = 5
local TILE_WIDTH = 50
local DAMAGE = {
    Player = {Player = 1, Witch = 2, Tank = 1},
    Witch  = {Player = 1, Witch = 1, Tank = 2},
    Tank   = {Player = 2, Witch = 1, Tank = 1}
}
local DECK = { front = 6, up = 3, down = 3, ufront = 6, dfront = 6}

local GameLayer = {}
GameLayer = class("GameLayer",function()
    return CCBReaderLoad("GameLayer.ccbi", cc.CCBProxy:create(), nil)
end)

local function reverse(corner)
    return corner == "red" and "blue" or "red"
end

function GameLayer:ctor(corner, form, seed)
    self.corner = corner
    self.turn = -1
    self.redDeck = {}
    self.blueDeck = {}
    math.randomseed(seed)

    self:addChild(cc.TMXTiledMap:create("tmx/forest.tmx"))
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.tiles = _.range(1, ROW):map(function(i)
        return _.range(1, COL):map(function(j)
            local tile = cc.Sprite:create("img/tile.png")
            tile:setPosition(self:idx2tilePos(i, j))
            self:addChild(tile)
            return tile
        end)
    end)

    self.friendsLayer = self:initHeros(-1, form[corner])
    self:addChild(self.friendsLayer)
    self.enemiesLayer = self:initHeros(1, form[reverse(corner)])
    self:addChild(self.enemiesLayer)
    self.myChipsLayer = self:initChips(-1, self.redDeck)
    self:addChild(self.myChipsLayer)
    self.hisChipsLayer = self:initChips(1, self.blueDeck)
    self:addChild(self.hisChipsLayer)

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(_.curry(self.onTouchBegan, self), cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(_.curry(self.onTouchMoved, self), cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(_.curry(self.onTouchEnded, self), cc.Handler.EVENT_TOUCH_CANCELLED)
    listener:registerScriptHandler(_.curry(self.onTouchEnded, self), cc.Handler.EVENT_TOUCH_ENDED)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
end

function GameLayer:initHeros(dir, form)
    local layer = cc.Layer:create()
    local jobs = {"Player", "Witch", "Tank"}
    _.each(form, function(i)
        local job = _.shift(jobs)
        local player = CCBReaderLoad(job .. "Node.ccbi", cc.CCBProxy:create(), nil)
        local row = math.ceil(i / COL)
        local col = (i - 1) % COL + 1
        player:setPosition(self:idx2tilePos(row, col))
        player:setScaleX(dir)
        player.tile = {i = row, j = col}
        player.job = job
        player.hearts = _.range(1, 3):map(function(i)
            local heart = cc.Sprite:create("img/heart.png")
            heart:setPosition((i - 2) * heart:getContentSize().width, 20)
            player:addChild(heart)
            return heart
        end)
        layer:addChild(player)
    end)
    return layer
end

function GameLayer:initChips(turn, deck)
    local layer = cc.Layer:create()
    _.range(1, 4):each(function(i)
        self:drawChip(i, layer, turn, deck)
    end)
    return layer
end

function GameLayer:idx2tilePos(i, j)
    if self.corner == "blue" then
        j = COL - j + 1
    end
    local x = self.visibleSize.width / 2 + (j - (COL / 2 + 0.5)) * TILE_WIDTH
    local y = self.visibleSize.height / 2 + (i - (ROW / 2 + 0.5)) * TILE_WIDTH
    return cc.p(x, y)
end

function GameLayer:idx2chipPos(idx, turn)
    local x = idx * 72
    local y = 80
    if turn > 0 then
        x = self.visibleSize.width - x
        y = self.visibleSize.height - y
    end
    return cc.p(x, y)
end

function GameLayer:drawChip(idx, layer, turn, deck)
    if #deck < 1 then deck = self:refillDeck() end
    local dirs = {front = {i=0, j=1}, up = {i=1, j=0}, down = {i=-1, j=0}, ufront = {i=1, j=1}, dfront = {i=-1, j=1}}
    local dir = _.shift(deck)
    local chip = cc.Sprite:create("img/chip_" .. dir .. ".png")
    chip.idx = idx
    chip.dir = dirs[dir]
    chip.dir.j = -turn * chip.dir.j
    chip:setPosition(self:idx2chipPos(idx, turn))
    chip:setScaleX(-turn)
    layer:addChild(chip)
end

function GameLayer:refillDeck()
    local deck = {}
    for key, var in pairs(DECK) do
        for i=1, var do
            table.insert(deck, {chip = key, lot = math.random(1, 100)})
        end
    end
    return _(deck):chain():sort(function(a, b)
        return a.lot < b.lot
    end):map(function(e)
        return e.chip
    end):value()
end

function GameLayer:onTouchBegan(touch, event)
    local layer = self.turn < 0 and self.myChipsLayer or self.hisChipsLayer
    self.holdChip = _.detect(layer:getChildren(), function(e)
        return cc.rectContainsPoint(e:getBoundingBox() ,touch:getLocation())
    end)
    return self.holdChip ~= nil
end

function GameLayer:onTouchMoved(touch, event)
    self.holdChip:setPosition(touch:getLocation())
end

function GameLayer:onTouchEnded(touch, event)
    local heros = self.turn < 0 and self.friendsLayer or self.enemiesLayer
    local player = _.detect(heros:getChildren(), function(e)
        return cc.rectContainsPoint(self.tiles[e.tile.i][e.tile.j]:getBoundingBox(), cc.p(self.holdChip:getPosition()))
    end)
    if player then
        local ni = player.tile.i + self.holdChip.dir.i
        local nj = player.tile.j + self.holdChip.dir.j
        if 0 < ni and ni <= ROW and 0 < nj and nj <= COL then
            local eq = function(e) return e.tile.i == ni and e.tile.j == nj end
            local target = _.detect(self.friendsLayer:getChildren(), eq)
            target = target or _.detect(self.enemiesLayer:getChildren(), eq)
            local gain = function()
                player.tile.i = ni
                player.tile.j = nj
                player:setPosition(self:idx2tilePos(ni, nj))
            end
            if target then
                local dmg = DAMAGE[player.job][target.job]
                if #target.hearts <= dmg then
                    target:removeFromParent()
                    gain()
                else
                    for i=1, dmg do
                        _(target.hearts):pop():removeFromParent()
                    end
                end
            else
                gain()
            end
        end
        self:drawChip(self.holdChip.idx, self.turn < 0 and self.myChipsLayer or self.hisChipsLayer, self.turn)
        self.holdChip:removeFromParent()
        self.turn = self.turn * -1
    else
        self.holdChip:setPosition(self:idx2chipPos(self.holdChip.idx, self.turn))
    end
    self.holdChip = nil
end

return GameLayer
