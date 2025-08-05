--[[
Exercise 4 – Employee Management System

Create a base class Employee with:
    name and salary properties.
    getSalary() method.

Create a Manager subclass with:
    bonus property.
    Override getSalary() to return salary + bonus.

Create a Developer subclass with:
    programmingLanguage property.
    A getInfo() method that prints "<name> codes in <language>".

Demonstrate creating one of each and printing salaries and info.
--]]

Employee = {}
Employee.__index = Employee
Employee.__type = "Base Employee"
function Employee:new(o)
    o = o or {}
    o.name = o.name or "Unnamed Employee"
    o.salary = o.salary or 1000
    setmetatable(o, self)
    self.__index = self
    return o
end

function Employee:getSalary()
    return self.salary
end

Manager = setmetatable({}, {__index = Employee})
Manager.__type = "Manager"
function Manager:new(o)
    o = Employee.new(self, o)
    o.name = o.name or "Unnamed Manager"
    o.bonus = o.bonus or 500
    return o
end

function Manager:getSalary()
    return self.salary + self.bonus
end

Developer = setmetatable({}, {__index = Employee})
Developer.__type = "Developer"
function Developer:new(o)
    o = Employee.new(self, o)
    o.programmingLanguage = o.programmingLanguage or "Junior (no language yet)"
    return o
end

function Developer:getInfo()
    return string.format("%s codes in %s", self.name, self.programmingLanguage)
end

-- Test cases for Employee, Manager, and Developer

-- Create base employee
local emp = Employee:new({name = "Alice", salary = 1200})
print(string.format("%s earns $%d", emp.name, emp:getSalary())) -- Alice earns $1200

-- Create manager
local boss = Manager:new({name = "Bob", salary = 2000, bonus = 800})
print(string.format("%s earns $%d", boss.name, boss:getSalary())) -- Bob earns $2800

-- Create developer
local dev = Developer:new({name = "Charlie", salary = 1500, programmingLanguage = "Lua"})
print(string.format("%s earns $%d", dev.name, dev:getSalary())) -- Charlie earns $1500
print(dev:getInfo()) -- Charlie codes in Lua

-- Optional: Print types using metatables
local function getType(obj)
    return getmetatable(obj).__type or "Unknown"
end

print(string.format("%s is a %s", emp.name, getType(emp)))   -- Alice is a Base Employee
print(string.format("%s is a %s", boss.name, getType(boss))) -- Bob is a Manager
print(string.format("%s is a %s", dev.name, getType(dev)))   -- Charlie is a Developer
