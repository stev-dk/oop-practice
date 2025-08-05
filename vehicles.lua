--[[
Exercise 2 – Vehicle Inheritance
Create a base class Vehicle with:
    brand and speed properties.
    accelerate(amount) and getSpeed() methods.

Create a Car subclass with:
    numDoors property.
    honk() method that prints "Beep!".

Create a Bicycle subclass with:
    gear property.
    ringBell() method that prints "Ring ring!".

Demonstrate creating one of each and using their methods.
--]]

-- Challenge 1: Vehicle Base + Bicycle Subclass

Vehicle = {}
Vehicle.__index = Vehicle
Vehicle.__type = "Unknown Vehicle"
function Vehicle:new(o)
    o = o or {}
    o.speed = o.speed or 0
    setmetatable(o, self)
    self.__index = self
    return o
end

function Vehicle:accelerate(amount)
    self.speed = self.speed + amount
end

function Vehicle:getSpeed()
    return self.speed
end

Bicycle = setmetatable({}, {__index = Vehicle})
Bicycle.__type = "Bicycle"
function Bicycle:new(o)
    o = Vehicle.new(self, o)
    o.gear = o.gear or 1
    return o
end

function Bicycle:setGear(newGear)
    self.gear = newGear
end

function Bicycle:ringBell()
    print("Ring Ring!")
end

function Bicycle:getGear()
    return self.gear
end

Car = setmetatable({}, {__index = Vehicle})
Car.__type = "Car"
function Car:new(o)
    o = Vehicle.new(self, o)
    o.hp = o.hp or 72
    o.numDoors = o.numDoors or 2
    o.brand = o.brand or "Unknown Brand"
    o.model = o.model or "Unknown Model"
    return o
end

function Car:honk()
    print("Beep!")
end

function Car:carDetails()
    print(string.format("%s %s with %d horsepower", self.brand, self.model, self.hp))
end

-- TEST CASES FOR VEHICLE, BICYCLE, AND CAR

print("\n--- Exercise 2: Vehicle Inheritance Tests ---")

-- Bicycle test
local bike = Bicycle:new({ speed = 10, gear = 3 })
print("Initial bike speed:", bike:getSpeed())     -- 10
bike:accelerate(5)
print("Bike speed after acceleration:", bike:getSpeed()) -- 15
print("Bike gear:", bike:getGear())               -- 3
bike:setGear(5)
print("Bike new gear:", bike:getGear())           -- 5
bike:ringBell()                                   -- Ring Ring!

-- Car test
local car = Car:new({
    speed = 20,
    hp = 150,
    brand = "Toyota",
    model = "Corolla",
    numDoors = 4
})
print("Initial car speed:", car:getSpeed())       -- 20
car:accelerate(40)
print("Car speed after acceleration:", car:getSpeed()) -- 60
car:honk()                                        -- Beep!
car:carDetails()                                  -- Toyota Corolla with 150 horsepower
print("Car has", car.numDoors, "doors")           -- 4
