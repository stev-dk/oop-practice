--[[
Exercise 3 – Animal Sound System

Create a base class Animal with:
    name property.
    speak() method that prints "Some generic animal sound".

Create subclasses:
    Dog that overrides speak() with "Woof!".
    Cat that overrides speak() with "Meow!".

Store several animals (both cats and dogs) in a table, loop over them, and call speak() on each.
--]]

Animal = {}
Animal.__index = Animal
Animal.__type = "Animal"
function Animal:new(o)
    o = o or {}
    o.name = o.name or "No name"
    setmetatable(o, self)
    self.__index = self
    return o
end

function Animal:speak()
    return "Dum Dee Dum"
end

Dog = setmetatable({}, {__index = Animal})
Dog.__type = "Dog"

function Dog:new(o)
    o = Animal.new(self, o)
    o.name = o.name or "Mr. Dog"
    return o
end

function Dog:speak()
    return "Woof woof!"
end

Cat = setmetatable({}, {__index = Animal})
Cat.__type = "Cat"
function Cat:new(o)
    o = Animal.new(self, o)
    o.name = o.name or "Mrs. Pussycat"
    return o
end

function Cat:speak()
    return "Meow meow!"
end

local benny = Dog:new({name = "Benny"})
local jenny = Cat:new({name = "Jenny"})
local patrick = Dog:new({name = "Patrick"})

local animals = {benny, jenny, patrick}
for _,animal in ipairs(animals) do
    print(string.format("%s the %s says %s", animal.name, animal.__type, animal:speak()))
end
