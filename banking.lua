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
        end

        if toAccount then
            toAccount.balance = toAccount.balance + amount
            self.balance = self.balance - amount
            table.insert(self.transactions, string.format("[%s] Transfered to %s: %.2f", date, toAccount.name, amount))
        else
            table.insert(self.transactions, "Transfer error. Account not found.")
        end
    end
}
