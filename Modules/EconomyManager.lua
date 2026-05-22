-- ============================================
-- ELITE ECONOMY MANAGER (Smooth & Efficient)
-- ============================================

local EconomyManager = {}
EconomyManager.__index = EconomyManager

local CONFIG = require(game.ReplicatedStorage.CONFIG)

function EconomyManager.new(playerId)
    local self = setmetatable({}, EconomyManager)
    self.playerId = playerId
    self.cash = 0
    self.totalCashEarned = 0
    self.passiveIncome = 0
    self.moneyMultiplier = 1.0
    self.speedMultiplier = 1.0
    self.multiplierEndTime = 0
    self.pendingMoney = 0 -- Smooth animation queue
    
    return self
end

-- Add money with smooth animation support
function EconomyManager:addMoney(amount, source)
    if amount <= 0 then return 0 end
    
    local finalAmount = amount * self.moneyMultiplier * CONFIG.MONEY_GAIN_MULTIPLIER
    self.cash = self.cash + finalAmount
    self.totalCashEarned = self.totalCashEarned + finalAmount
    self.pendingMoney = finalAmount
    
    return finalAmount
end

-- Spend money with validation
function EconomyManager:spendMoney(amount, reason)
    if amount <= 0 then return false end
    if self.cash < amount then return false, "Insufficient funds" end
    
    self.cash = self.cash - amount
    return true
end

-- Manage passive income
function EconomyManager:addPassiveIncome(amount)
    self.passiveIncome = math.max(0, self.passiveIncome + amount)
end

-- Apply money multiplier with timer
function EconomyManager:applyMoneyMultiplier(multiplier, durationSeconds)
    self.moneyMultiplier = multiplier
    self.multiplierEndTime = tick() + durationSeconds
    
    task.delay(durationSeconds, function()
        if self.moneyMultiplier == multiplier then
            self.moneyMultiplier = 1.0
        end
    end)
    
    return true
end

-- Apply speed multiplier
function EconomyManager:applySpeedMultiplier(multiplier, durationSeconds)
    self.speedMultiplier = multiplier
    
    task.delay(durationSeconds, function()
        self.speedMultiplier = 1.0
    end)
end

-- Get income per second
function EconomyManager:getIncomePerSecond()
    return self.passiveIncome * self.moneyMultiplier
end

-- Format money beautifully
function EconomyManager:formatMoney(amount)
    if amount >= 1000000000000 then
        return string.format("$%.2fT", amount / 1000000000000)
    elseif amount >= 1000000000 then
        return string.format("$%.2fB", amount / 1000000000)
    elseif amount >= 1000000 then
        return string.format("$%.2fM", amount / 1000000)
    elseif amount >= 1000 then
        return string.format("$%.2fK", amount / 1000)
    else
        return string.format("$%.0f", amount)
    end
end

-- Get cash
function EconomyManager:getCash()
    return self.cash
end

-- Check affordability
function EconomyManager:canAfford(cost)
    return self.cash >= cost
end

return EconomyManager