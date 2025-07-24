-- Challenge 1: Vehicle Base + Bicycle Subclass

Vehicle = {
    new = function(self, o)
        o = o or {}
        o.speed = o.speed or 0
        setmetatable(o, self)
        self.__index = self
        return o
    end,

    accelerate = function(self, amount)
        self.speed = self.speed + amount
    end,

    getSpeed = function(self)
        return self.speed
    end
}

Vehicle.__type = "Unknown Vehicle"

Bicycle = Vehicle:new()
Bicycle.__type = "Bicycle"

function Bicycle:new(o)
    o = Vehicle.new(self, o)
    o.gear = o.gear or 1
    return o
end

function Bicycle:setGear(newGear)
    self.gear = newGear
end

function Bicycle:getGear()
    return self.gear
end

Car = Vehicle:new()
Car.__type = "Car"
function Car:new(o)
    o = Vehicle.new(self, o)
    o.hp = o.hp or 72
    o.brand = o.brand or "Unknown Brand"
    o.model = o.model or "Unknown Model"
    return o
end

function Car:carDetails()
    print(string.format("%s %s with %d horsepower", self.brand, self.model, self.hp))
end

-- TEST CASES FOR VEHICLE, BICYCLE, AND CAR

print("\n--- Vehicle Test ---")
local generic = Vehicle:new({speed = 10})
print("Generic vehicle speed:", generic:getSpeed()) -- 10
generic:accelerate(15)
print("Generic vehicle speed after accelerating:", generic:getSpeed()) -- 25
print("Type:", getmetatable(generic).__type) -- Unknown Vehicle

print("\n--- Bicycle Test ---")
local bike = Bicycle:new({speed = 5, gear = 3})
print("Bike speed:", bike:getSpeed()) -- 5
print("Bike gear:", bike:getGear()) -- 3
bike:setGear(5)
print("Bike new gear:", bike:getGear()) -- 5
bike:accelerate(10)
print("Bike speed after accelerating:", bike:getSpeed()) -- 15
print("Type:", getmetatable(bike).__type) -- Bicycle

print("\n--- Car Test ---")
local sedan = Car:new({
    speed = 0,
    hp = 150,
    brand = "Toyota",
    model = "Corolla"
})

print("Car speed:", sedan:getSpeed()) -- 0
sedan:accelerate(60)
print("Car speed after accelerating:", sedan:getSpeed()) -- 60
sedan:carDetails() -- Toyota Corolla with 150 horsepower
print("Type:", getmetatable(sedan).__type) -- Car
