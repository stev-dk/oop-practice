-- Challenge 4: Factory System
products = {
    toy = "toy",
    tool = "tool"
}

Factory = {
    name = "Factory",
    new = function(self, o)
        o = o or {}
        setmetatable(o, self)
        self.__index = self
        return o
    end,

    createProduct = function(self, type)
        if type == "toy" then
            return Toy:new()
        elseif type == "tool" then
            return Tool:new()
        else
            print("Unknown product.")
            return nil
        end
    end
}

Product = {
    name = "Product",
    new = function(self, o)
        o = o or {}
        setmetatable(o, self)
        self.__index = self
        return o
    end
}
Product.__type = "Product"

Toy = Product:new()
Toy.__type = "Toy"
function Toy:new(o)
    o = Product.new(self, o)
    return o
end

function Toy:play()
    print("Playing with toy.")
end

Tool = Product:new()
Tool.__type = "Tool"
function Tool:new(o)
    o = Product.new(self, o)
    return o
end

function Tool:use()
    print("Using tool.")
end

local f = Factory:new()

local myToy = f:createProduct(products.toy)
local myTool = f:createProduct(products.tool)

print("Toy type:", getmetatable(myToy).__type)   --> Toy
myToy:play()                                     --> Playing with toy.

print("Tool type:", getmetatable(myTool).__type) --> Tool
myTool:use()                                     --> Using tool.

-- Invalid product
local unknown = f:createProduct("gadget")        --> Optional: print warning or return nil
