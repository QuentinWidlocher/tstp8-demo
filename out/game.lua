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
Vector2.zero = __TS__New(Vector2, 0, 0)
Vector2.up = __TS__New(Vector2, 0, 1)
Vector2.down = __TS__New(Vector2, 0, -1)
Vector2.left = __TS__New(Vector2, 1, 0)
Vector2.right = __TS__New(Vector2, -1, 0)
local Player = __TS__Class()
Player.name = "Player"
__TS__ClassExtends(Player, GameObject)
function Player.prototype.____constructor(self, position, size)
    GameObject.prototype.____constructor(self)
    self.velocity = Vector2.zero
    self.jumpForce = 10
    self.gravity = 1
    self.rect = __TS__New(Rectangle, {position = position, size = size, color = 12})
end
function Player.prototype.update(self)
    self.velocity:subtract(Vector2:multipliedBy(Vector2.down, self.gravity))
    if btnp(4) then
        self.rect.color = 8
        self.velocity.y = -self.jumpForce
    else
        self.rect.color = 12
    end
    self.rect.position:add(self.velocity)
end
function Player.prototype.draw(self)
    self.rect:draw()
end
local player = __TS__New(
    Player,
    __TS__New(Vector2, 10, 10),
    __TS__New(Vector2, 10, 10)
)
local function _init(self)
    GameObjectManager:init()
    GameObjectManager.instance:push(player)
end
local function _update(self)
    GameObjectManager.instance:_update()
end
local function _draw(self)
    cls()
    GameObjectManager.instance:_draw()
end
do
    do
        do
            local ____ = _update
            local ____ = _init
        end
        local ____ = _draw
    end
end
