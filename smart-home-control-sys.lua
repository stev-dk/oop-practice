Device = {
    new = function(self, o)
        o = o or {}
        o.name = o.name or "Unknown device"
        o.status = false
        setmetatable(o, self)
        self.__index = self
        return o
    end,

    getStatus = function(self)
        return self.status
    end,

    toggle = function(self)
        self.status = not self.status
    end
}

Device.__type = "Device" -- Good for type checking getmetatable(instance).__type == "Device"

Light = Device:new()

function Light:new(o)
    o = Device.new(self, o)
    o.name = o.name or "Unknown Lightsource"
    o.brightness = o.brightness or 0
    return o
end

function Light:setBrightness(level)
    if level <= 100 and level >= 0 then
        self.brightness = level
    end
end

Thermostat = Device:new()

function Thermostat:new(o)
    o = Device.new(self, o)
    o.name = o.name or "Unknown Thermostat"
    o.temperature = o.temperature or 22
    return o
end

function Thermostat:setTemperature(temp)
    if temp <= 32 and temp >= 15 then
        self.temperature = temp
    end
end

HomeController = {
    new = function(self, o)
        o = o or {}
        o.devices = o.devices or {}
        setmetatable(o, self)
        self.__index = self
        return o
    end,

    addDevice = function(self, newDevice)
        local mt = getmetatable(newDevice)
        if mt and mt.__type == "Device" then
            table.insert(self.devices, newDevice)
            return true
        else
            return false
        end
    end,

    statusReport = function(self)
        for i, device in ipairs(self.devices) do
            local name = device.name
            local status = device:getStatus()
            print(string.format("%s is currently %s", name, tostring(status)))
        end
    end,

    toggleAll = function(self)
        for i, device in ipairs(self.devices) do
            device:toggle()
        end
    end
}

-- Create devices
local lamp = Light:new({name = "Living Room Lamp", brightness = 60})
local hallwayLight = Light:new({name = "Hallway Light"})
local heater = Thermostat:new({name = "Main Heater", temperature = 20})

-- Set specific brightness and temperature
lamp:setBrightness(80) -- Set brightness to 80
heater:setTemperature(25) -- Set temp to 25 (within range)

-- Attempt invalid settings (should be ignored)
lamp:setBrightness(120)     -- Invalid, ignored
heater:setTemperature(40)   -- Invalid, ignored

-- Create controller and add devices
local controller = HomeController:new()
assert(controller:addDevice(lamp), "Failed to add lamp")
assert(controller:addDevice(hallwayLight), "Failed to add hallway light")
assert(controller:addDevice(heater), "Failed to add heater")

-- Status report (should all be off)
print("\nInitial status report:")
controller:statusReport()

-- Toggle all devices (should all turn on)
controller:toggleAll()
print("\nAfter toggling ON:")
controller:statusReport()

-- Toggle all devices again (should all turn off)
controller:toggleAll()
print("\nAfter toggling OFF:")
controller:statusReport()

-- Print specific device states
print("\nDevice-specific info:")
print("Lamp brightness:", lamp.brightness)               --> 80
print("Heater temperature:", heater.temperature)         --> 25
print("Hallway Light status:", hallwayLight:getStatus()) --> false
