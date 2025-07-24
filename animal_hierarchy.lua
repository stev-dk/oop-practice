Animal = {
    new = function(self, o)
        o = o or {}
        setmetatable(o, self)
        self.__index = self
        return o
    end,

    speak = function()
        return "Dum Dee Dum"
    end
}

Animal.__type = "Animal"

Dog = Animal:new()
Dog.__type = "Dog"

function Dog:new(o)
    o = Animal.new(self, o)
    o.speak = function(self)
        return "Woof!"
    end
    return o
end

Cat = Animal:new()
Cat.__type = "Cat"
function Cat:new(o)
    o = Animal.new(self, o)
    o.speak = function(self)
        return "Meow!"
    end
    return o
end

lab = Dog:new()
poodle = Dog:new()
cat = Cat:new()
another_cat = Cat:new()

animals = {lab, cat, poodle, another_cat}
for i, animal in ipairs(animals) do
    local animal_type = getmetatable(animal).__type
    print(string.format("%s says %s", animal_type, animal:speak()))
end
