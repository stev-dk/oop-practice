-- Challenge 3: Game Entity System
Entity = {
    new = function(self, o)
        o = o or {}
        o.name = o.name or "Unknown"
        o.xPos = o.xPos or 1.0
        o.yPos = o.yPos or 1.0
        setmetatable(o, self)
        self.__index = self
        return o
    end,

    move = function(self, dx, dy)
        self.xPos = self.xPos + dx
        self.yPos = self.yPos + dy
    end
}

Entity.__type = "Entity"

Player = Entity:new()
Player.__type = "Player"
function Player:new(o)
    o = Entity.new(self, o)
    o.health = o.health or 100
    return o
end

function Player:takeDamage(amount)
    self.health = self.health - amount
end

Enemy = Entity:new()
Enemy.__type = "Enemy"
function Enemy:new(o)
    o = Entity.new(self, o)
    o.attackPower = o.attackPower or 15
    return o
end

function Enemy:attack(target)
    target:takeDamage(self.attackPower)
end

-- Create a player and enemy
local hero = Player:new({name = "Hero", xPos = 5, yPos = 10})
local goblin = Enemy:new({name = "Goblin", xPos = 7, yPos = 8, attackPower = 20})

print("--- Initial States ---")
print(string.format("%s at position (%.1f, %.1f) with %d HP", hero.name, hero.xPos, hero.yPos, hero.health))
print(string.format("%s at position (%.1f, %.1f)", goblin.name, goblin.xPos, goblin.yPos))

-- Move player
hero:move(1, -2)
print("\nAfter movement:")
print(string.format("%s moved to (%.1f, %.1f)", hero.name, hero.xPos, hero.yPos))

-- Goblin attacks hero
print("\nCombat:")
print(string.format("%s attacks %s for %d damage!", goblin.name, hero.name, goblin.attackPower))
goblin:attack(hero)

print(string.format("%s now has %d HP", hero.name, hero.health))

-- Check type tags
print("\nType Checks:")
print("Hero type:", getmetatable(hero).__type)    --> Player
print("Goblin type:", getmetatable(goblin).__type) --> Enemy
