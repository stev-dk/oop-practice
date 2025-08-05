--[[
Create a base class Shape with:
    A constructor (new) that sets a name property.
    A getName() method that returns the name.

Create two subclasses:
    Circle with a radius property and an area() method.
    Rectangle with width and height properties and an area() method.

Create an instance of each and print their names and areas.
--]]

local Shape = {}
Shape.__index = Shape

function Shape:new(o)
    o = o or {}
    o.name = o.name or "Default shape"
    setmetatable(o, self)
    self.__index = self
    return o
end

function Shape:getName()
    return self.name
end

local Circle = setmetatable({}, {__index = Shape})
Circle.__index = Circle
function Circle:new(o)
    o = Shape.new(self, o)
    o.name = "Circle"
    o.radius = o.radius or 0
    self.__index = self
    return o
end

function Circle:area()
    return self.radius^2*3.141692
end

local Rectangle = setmetatable({}, {__index = Shape})
Rectangle.__index = Rectangle
function Rectangle:new(o)
    o = Shape.new(self, o)
    o.name = "Rectangle"
    o.width = o.width or 10
    o.height = o.height or 10
    self.__index = self
    return o
end

function Rectangle:area()
    return self.width * self.height
end

local circle = Circle:new({radius = 5})
print(circle:getName())
print(circle:area())

local rect = Rectangle:new({width = 5, height = 13})
print(rect:getName())
print(rect:area())
