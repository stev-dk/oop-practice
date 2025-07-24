BankAccount = {
    name = "John Doe",
    maxWithdrawLimit = 200,

    new = function(self, o)
        o = o or {}
        o.balance = o.balance or 0
        o.transactions = o.transactions or {}
        setmetatable(o, self)
        self.__index = self
        return o
    end,

    deposit = function(self, amount)
        local date = os.date("%Y-%m-%d %H:%M:%S")
        if amount > 0 then
            self.balance = self.balance + amount
            table.insert(self.transactions, string.format("[%s] Deposit: %.2f", date, amount))
        else
            table.insert(self.transactions, string.format("[%s] Attempted to deposit: %.2f", date, amount))
        end
    end,

    withdraw = function(self, amount)
        local date = os.date("%Y-%m-%d %H:%M:%S")
        if self.balance >= amount and amount <= self.maxWithdrawLimit then
            self.balance = self.balance - amount
            table.insert(self.transactions, string.format("[%s] Withdraw: %.2f", date, amount))
        else
            table.insert(self.transactions, string.format("[%s] Attempted to withdraw: %.2f", date, amount))
        end
    end,

    getBalance = function(self)
        return self.balance
    end,

    printTransactions = function(self)
        for i, v in ipairs(self.transactions) do
            print(v)
        end
    end,

    transfer = function(self, toAccount, amount)
        local date = os.date("%Y-%m-%d %H:%M:%S")
        if self.balance < amount then
            table.insert(self.transactions, string.format("[%s] Attempted to transfer: %.2f", date, amount))
            return
        end

        if toAccount then
            toAccount.balance = toAccount.balance + amount
            self.balance = self.balance - amount
            table.insert(self.transactions, string.format("[%s] Transfered to %s: %.2f", date, toAccount.name, amount))
            table.insert(toAccount.transactions, string.format("[%s] Transfered from %s: %.2f", date, self.name, amount))
        else
            table.insert(self.transactions, string.format("[%s] Transfer error. Account not found.", date))
        end
    end
}

-- Create two accounts
local alice = BankAccount:new({name = "Alice", balance = 1000})
local bob = BankAccount:new({name = "Bob", balance = 300})

-- Perform some transactions
alice:deposit(200)        -- Balance: 1200
alice:withdraw(150)       -- Balance: 1050
alice:withdraw(1000)      -- Fails: would drop below 0, ignored
alice:withdraw(300)       -- Fails: exceeds withdraw limit (200), ignored

-- Transfer money to Bob
alice:transfer(bob, 100)  -- Alice: 950, Bob: 400
alice:transfer(bob, 2000) -- Fails: not enough funds
alice:transfer(nil, 50)   -- Fails: invalid target

-- Print balances
print("\nFinal Balances:")
print("Alice:", alice:getBalance()) -- 950
print("Bob:", bob:getBalance())     -- 400

-- Print transaction logs
print("\nAlice's Transactions:")
alice:printTransactions()

print("\nBob's Transactions:")
bob:printTransactions()
