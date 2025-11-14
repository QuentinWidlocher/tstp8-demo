-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        asyncDispose = __TS__Symbol("Symbol.asyncDispose"),
        dispose = __TS__Symbol("Symbol.dispose"),
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local __TS__Iterator
do
    local function iteratorGeneratorStep(self)
        local co = self.____coroutine
        local status, value = coroutine.resume(co)
        if not status then
            error(value, 0)
        end
        if coroutine.status(co) == "dead" then
            return
        end
        return true, value
    end
    local function iteratorIteratorStep(self)
        local result = self:next()
        if result.done then
            return
        end
        return true, result.value
    end
    local function iteratorStringStep(self, index)
        index = index + 1
        if index > #self then
            return
        end
        return index, string.sub(self, index, index)
    end
    function __TS__Iterator(iterable)
        if type(iterable) == "string" then
            return iteratorStringStep, iterable, 0
        elseif iterable.____coroutine ~= nil then
            return iteratorGeneratorStep, iterable
        elseif iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            return iteratorIteratorStep, iterator
        else
            return ipairs(iterable)
        end
    end
end

local function __TS__ArrayFilter(self, callbackfn, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            len = len + 1
            result[len] = self[i]
        end
    end
    return result
end

local function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not not classTbl[Symbol.hasInstance](classTbl, obj)
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end

local function __TS__ArrayPush(self, ...)
    local items = {...}
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

local function __TS__ArraySome(self, callbackfn, thisArg)
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            return true
        end
    end
    return false
end
-- End of Lua Library inline imports
local GameObject = __TS__Class()
GameObject.name = "GameObject"
function GameObject.prototype.____constructor(self)
    self.layer = 0
    self.id = tostring(rnd(1000))
    self.parent = nil
    self.components = {}
    self.debug = false
end
function GameObject.prototype.update(self)
end
function GameObject.prototype.updateDebug(self)
end
function GameObject.prototype._update(self)
    local ____opt_0 = self.update
    if ____opt_0 ~= nil then
        ____opt_0(self)
    end
    if self.debug then
        local ____opt_2 = self.updateDebug
        if ____opt_2 ~= nil then
            ____opt_2(self)
        end
    end
    for ____, child in ipairs(self.components) do
        child:_update()
    end
end
function GameObject.prototype.init(self)
end
function GameObject.prototype.initDebug(self)
end
function GameObject.prototype._init(self)
    local ____opt_4 = self.init
    if ____opt_4 ~= nil then
        ____opt_4(self)
    end
    if self.debug then
        local ____opt_6 = self.initDebug
        if ____opt_6 ~= nil then
            ____opt_6(self)
        end
    end
    for ____, child in ipairs(self.components) do
        child:_init()
    end
end
function GameObject.prototype.draw(self)
end
function GameObject.prototype.drawDebug(self)
end
function GameObject.prototype._draw(self)
    local ____opt_8 = self.draw
    if ____opt_8 ~= nil then
        ____opt_8(self)
    end
    if self.debug then
        local ____opt_10 = self.drawDebug
        if ____opt_10 ~= nil then
            ____opt_10(self)
        end
    end
    for ____, child in ipairs(self.components) do
        child:_draw()
    end
end
function GameObject.prototype.addComponent(self, child)
    local ____self_components_12 = self.components
    ____self_components_12[#____self_components_12 + 1] = child
    child.parent = self
    return child
end
function GameObject.prototype.withDebugEnabled(self, enabled)
    if enabled == nil then
        enabled = true
    end
    self.debug = enabled
    return self
end
local GameObjectManager = __TS__Class()
GameObjectManager.name = "GameObjectManager"
__TS__ClassExtends(GameObjectManager, GameObject)
function GameObjectManager.prototype.____constructor(self, ____debug)
    if ____debug == nil then
        ____debug = false
    end
    GameObject.prototype.____constructor(self)
    self.debug = ____debug
end
function GameObjectManager.init(self, ____debug)
    if ____debug == nil then
        ____debug = false
    end
    GameObjectManager.instance = __TS__New(GameObjectManager, ____debug)
end
function GameObjectManager.prototype.register(self, gameObjects)
    for ____, g in __TS__Iterator(gameObjects) do
        self:push(g)
    end
end
function GameObjectManager.prototype.push(self, gameObject)
    self:addComponent(gameObject)
end
function GameObjectManager.prototype.findGameObject(self, predicate)
    return self.components:find(function(____, gameObject) return predicate(_G, gameObject) end)
end
function GameObjectManager.prototype.findGameObjects(self, predicate)
    return __TS__ArrayFilter(
        self.components,
        function(____, gameObject) return predicate(_G, gameObject) end
    )
end
function GameObjectManager.prototype.findGameObjectsOfType(self, instanceOf, predicate)
    return __TS__ArrayFilter(
        self.components,
        function(____, gameObject)
            local ____TS__InstanceOf_result_17 = __TS__InstanceOf(gameObject, instanceOf.constructor)
            if ____TS__InstanceOf_result_17 then
                local ____opt_result_15
                if predicate ~= nil then
                    ____opt_result_15 = predicate(_G, gameObject)
                end
                local ____opt_result_15_16 = ____opt_result_15
                if ____opt_result_15_16 == nil then
                    ____opt_result_15_16 = true
                end
                ____TS__InstanceOf_result_17 = ____opt_result_15_16
            end
            return ____TS__InstanceOf_result_17
        end
    )
end
function GameObjectManager.prototype.getGameObject(self, id)
    return self:findGameObject(function(____, gameObject) return gameObject.id == id end)
end
local ScreenSize = 128
local Rectangle = __TS__Class()
Rectangle.name = "Rectangle"
function Rectangle.prototype.____constructor(self, ____bindingPattern0)
    local color
    local size
    local position
    position = ____bindingPattern0.position
    size = ____bindingPattern0.size
    color = ____bindingPattern0.color
    if color == nil then
        color = 7
    end
    self.position = position
    self.size = size
    self.color = color
end
function Rectangle.prototype.intersects(self, other)
    return self.position.x < other.position.x + other.size.x and self.position.x + self.size.x > other.position.x and self.position.y < other.position.y + other.size.y and self.position.y + self.size.y > other.position.y
end
function Rectangle.prototype.contains(self, point)
    return point.x >= self.position.x and point.x <= self.position.x + self.size.x and point.y >= self.position.y and point.y <= self.position.y + self.size.y
end
function Rectangle.prototype.draw(self, mode)
    if mode == nil then
        mode = "fill"
    end
    if mode == "fill" then
        rectfill(
            self.position.x,
            self.position.y,
            self.position.x + self.size.x,
            self.position.y + self.size.y,
            self.color
        )
    else
        rect(
            self.position.x,
            self.position.y,
            self.position.x + self.size.x,
            self.position.y + self.size.y,
            self.color
        )
    end
end
local function lerp(self, a, b, t)
    return a + (b - a) * t
end
local Vector2 = __TS__Class()
Vector2.name = "Vector2"
function Vector2.prototype.____constructor(self, x, y)
    self.x = x
    self.y = y
end
function Vector2.square(self, x)
    return __TS__New(Vector2, x, x)
end
function Vector2.fromTuple(self, ____bindingPattern0)
    local y
    local x
    x = ____bindingPattern0[1]
    y = ____bindingPattern0[2]
    return __TS__New(Vector2, x, y)
end
function Vector2.lerp(self, a, b, t)
    return __TS__New(
        Vector2,
        lerp(_G, a.x, b.x, t),
        lerp(_G, a.y, b.y, t)
    )
end
function Vector2.plus(self, a, b)
    return __TS__New(Vector2, a.x + b.x, a.y + b.y)
end
function Vector2.prototype.add(self, other)
    self.x = self.x + other.x
    self.y = self.y + other.y
end
function Vector2.minus(self, a, b)
    return __TS__New(Vector2, a.x - b.x, a.y - b.y)
end
function Vector2.prototype.subtract(self, other)
    self.x = self.x - other.x
    self.y = self.y - other.y
end
function Vector2.dividedBy(self, a, factor)
    return __TS__New(Vector2, a.x / factor, a.y / factor)
end
function Vector2.prototype.divideBy(self, factor)
    self.x = self.x / factor
    self.y = self.y / factor
end
function Vector2.multipliedBy(self, a, factor)
    return __TS__New(Vector2, a.x * factor, a.y * factor)
end
function Vector2.prototype.multiplyBy(self, factor)
    self.x = self.x * factor
    self.y = self.y * factor
end
function Vector2.prototype.lerp(self, other, t)
    self.x = lerp(_G, self.x, other.x, t)
    self.y = lerp(_G, self.y, other.y, t)
end
function Vector2.prototype.magnitude(self)
    return math.sqrt(self.x * self.x + self.y * self.y)
end
function Vector2.prototype.normalized(self)
    local mag = self:magnitude()
    return __TS__New(Vector2, self.x / mag, self.y / mag)
end
function Vector2.prototype.reset(self)
    self.x = 0
    self.y = 0
end
function Vector2.prototype.__tostring(self)
    return ((("{ x: " .. tostring(self.x)) .. ", y: ") .. tostring(self.y)) .. " }"
end
Vector2.zero = __TS__New(Vector2, 0, 0)
Vector2.up = __TS__New(Vector2, 0, 1)
Vector2.down = __TS__New(Vector2, 0, -1)
Vector2.left = __TS__New(Vector2, 1, 0)
Vector2.right = __TS__New(Vector2, -1, 0)
local Event = __TS__Class()
Event.name = "Event"
function Event.prototype.____constructor(self)
    self.subscribers = {}
end
function Event.prototype.subscribe(self, callback)
    local ____self_subscribers_18 = self.subscribers
    ____self_subscribers_18[#____self_subscribers_18 + 1] = callback
end
function Event.prototype.emit(self, data)
    for ____, subscriber in ipairs(self.subscribers) do
        subscriber(_G, data)
    end
end
local Player = __TS__Class()
Player.name = "Player"
__TS__ClassExtends(Player, GameObject)
function Player.prototype.____constructor(self)
    GameObject.prototype.____constructor(self)
    self.velocity = Vector2.zero
    self.jumpForce = 2
    self.gravity = 0.1
    self.onDeath = __TS__New(Event)
end
function Player.prototype.init(self)
    self:reset()
end
function Player.prototype.reset(self)
    self.rect = __TS__New(
        Rectangle,
        {
            position = __TS__New(Vector2, 10, 10),
            size = __TS__New(Vector2, 10, 10),
            color = 10
        }
    )
    self.velocity:reset()
end
function Player.prototype.update(self)
    self.velocity:subtract(Vector2:multipliedBy(Vector2.down, self.gravity))
    if btnp(4) or btnp(5) then
        self.velocity.y = -self.jumpForce
    end
    if self.rect.position.y + self.rect.size.y < 0 or self.rect.position.y - self.rect.size.y > ScreenSize then
        self.onDeath:emit()
    end
    self.rect.position:add(self.velocity)
end
function Player.prototype.draw(self)
    self.rect:draw()
end
local Walls = __TS__Class()
Walls.name = "Walls"
__TS__ClassExtends(Walls, GameObject)
function Walls.prototype.____constructor(self, player)
    GameObject.prototype.____constructor(self)
    self.rectangles = {}
    self.width = 20
    self.vGap = 10
    self.hGap = ScreenSize
    self.gapOffset = 50
    self.scrollSpeed = 2
    self.onWallPassed = __TS__New(Event)
    self.onWallTouched = __TS__New(Event)
    self.player = player
end
function Walls.prototype.init(self)
    self:reset()
end
function Walls.prototype.reset(self)
    self.rectangles = {}
    self:spawnWall(self.hGap)
end
function Walls.prototype.update(self)
    self:spawnNextWall()
    for ____, rect2 in ipairs(self.rectangles) do
        rect2.position:subtract(Vector2:multipliedBy(Vector2.left, self.scrollSpeed))
        self:checkForCollisions(rect2)
    end
end
function Walls.prototype.draw(self)
    for ____, rect2 in ipairs(self.rectangles) do
        rect2:draw()
    end
end
function Walls.prototype.spawnWall(self, x)
    local gapOffset = rnd(self.gapOffset) - self.gapOffset / 2
    __TS__ArrayPush(
        self.rectangles,
        __TS__New(
            Rectangle,
            {
                position = Vector2:fromTuple({x, 0}),
                size = Vector2:fromTuple({self.width, ScreenSize / 4 + gapOffset}),
                color = 11
            }
        ),
        __TS__New(
            Rectangle,
            {
                position = Vector2:fromTuple({x, ScreenSize / 2 + gapOffset + self.vGap}),
                size = Vector2:fromTuple({self.width, ScreenSize - (ScreenSize / 2 + gapOffset + self.vGap)}),
                color = 11
            }
        )
    )
end
function Walls.prototype.spawnNextWall(self)
    if __TS__ArraySome(
        self.rectangles,
        function(____, rect2) return rect2.position.x < -self.width end
    ) then
        deli(self.rectangles, 1)
        deli(self.rectangles, 1)
        self:spawnWall(self.hGap)
        self.onWallPassed:emit()
    end
end
function Walls.prototype.checkForCollisions(self, rectangle)
    if not self.player then
        return
    end
    if rectangle:intersects(self.player.rect) then
        self.onWallTouched:emit()
    end
end
local function printOutlinedLight(self, text, x, y, bodyColor, outlineColor)
    if bodyColor == nil then
        bodyColor = 7
    end
    if outlineColor == nil then
        outlineColor = 0
    end
    print(text, x - 1, y, outlineColor)
    print(text, x + 1, y, outlineColor)
    print(text, x, y - 1, outlineColor)
    print(text, x, y + 1, outlineColor)
    print(text, x, y, bodyColor)
end
local function printOutlinedBold(self, text, x, y, bodyColor, outlineColor)
    if bodyColor == nil then
        bodyColor = 7
    end
    if outlineColor == nil then
        outlineColor = 0
    end
    print(text, x - 1, y - 1, outlineColor)
    print(text, x + 1, y + 1, outlineColor)
    print(text, x + 1, y - 1, outlineColor)
    print(text, x - 1, y + 1, outlineColor)
    printOutlinedLight(
        _G,
        text,
        x,
        y,
        bodyColor,
        outlineColor
    )
end
local Score = __TS__Class()
Score.name = "Score"
__TS__ClassExtends(Score, GameObject)
function Score.prototype.____constructor(self, ...)
    GameObject.prototype.____constructor(self, ...)
    self.score = 0
    self.maxScore = 0
end
function Score.prototype.draw(self)
    printOutlinedBold(
        _G,
        "score: " .. tostring(self.score),
        5,
        5
    )
    if self.maxScore > 0 then
        printOutlinedBold(
            _G,
            "max: " .. tostring(self.maxScore),
            5,
            13
        )
    end
end
function Score.prototype.increment(self)
    self.score = self.score + 1
end
function Score.prototype.reset(self)
    self.maxScore = max(self.score, self.maxScore)
    self.score = 0
end
local function _init(self)
    GameObjectManager:init()
    local player = __TS__New(Player)
    local walls = __TS__New(Walls, player)
    local score = __TS__New(Score)
    local function resetGame(self)
        player:reset()
        walls:reset()
        score:reset()
    end
    walls.onWallPassed:subscribe(function() return score:increment() end)
    walls.onWallTouched:subscribe(function() return resetGame(_G) end)
    player.onDeath:subscribe(function() return resetGame(_G) end)
    GameObjectManager.instance:register({player, walls, score})
    GameObjectManager.instance:_init()
end
local function _update60(self)
    GameObjectManager.instance:_update()
end
local function _draw(self)
    cls(12)
    GameObjectManager.instance:_draw()
end
do
    do
        do
            local ____ = _update60
            local ____ = _init
        end
        local ____ = _draw
    end
end
