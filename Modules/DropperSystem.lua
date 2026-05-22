-- ============================================
-- ELITE DROPPER SYSTEM (Tesla floor)
-- ============================================

local DropperSystem = {}
local DropperSystem_mt = {__index = DropperSystem}

local CONFIG = require(game.ReplicatedStorage.CONFIG)

local Dropper = {}
local Dropper_mt = {__index = Dropper}

function Dropper.new(id, economyManager)
    local self = setmetatable({}, Dropper_mt)
    self.id = id
    self.tier = 1
    self.economyManager = economyManager
    self.purchased = false
    self.lastDropTime = tick()
    
    return self
end

function Dropper:getTierConfig()
    return CONFIG.FLOOR_2.TIERS[self.tier]
end

function Dropper:getPurchaseCost()
    return CONFIG.FLOOR_2.DROPPER_BASE_COST
end

function Dropper:getUpgradeCost(targetTier)
    if targetTier <= self.tier then return 0 end
    local cost = 0
    for tier = self.tier + 1, targetTier do
        cost = cost + (CONFIG.FLOOR_2.DROPPER_BASE_COST * CONFIG.FLOOR_2.TIERS[tier].UPGRADE_COST_MULTIPLIER)
    end
    return cost
end

function Dropper:purchase()
    if self.purchased then return false end
    local cost = self:getPurchaseCost()
    if not self.economyManager:canAfford(cost) then return false end
    
    if self.economyManager:spendMoney(cost, "Dropper") then
        self.purchased = true
        return true
    end
    return false
end

function Dropper:upgradeTier(targetTier)
    if not self.purchased or targetTier <= self.tier then return false end
    
    local cost = self:getUpgradeCost(targetTier)
    if not self.economyManager:canAfford(cost) then return false end
    
    if self.economyManager:spendMoney(cost, "Upgrade") then
        self.tier = targetTier
        return true
    end
    return false
end

function Dropper:dropVehicle()
    if not self.purchased then return 0 end
    local config = self:getTierConfig()
    return config.VALUE_PER_DROP
end

-- ============================================
-- DROPPER SYSTEM
-- ============================================

function DropperSystem.new(economyManager)
    local self = setmetatable({}, DropperSystem_mt)
    self.droppers = {}
    self.economyManager = economyManager
    
    for i = 1, CONFIG.FLOOR_2.DROPPER_COUNT do
        table.insert(self.droppers, Dropper.new(i, economyManager))
    end
    
    return self
end

function DropperSystem:update(deltaTime)
    local income = 0
    
    for _, dropper in ipairs(self.droppers) do
        if dropper.purchased then
            local config = dropper:getTierConfig()
            local adjustedInterval = config.DROP_INTERVAL / self.economyManager.speedMultiplier
            
            if tick() - dropper.lastDropTime >= adjustedInterval then
                income = income + dropper:dropVehicle()
                dropper.lastDropTime = tick()
            end
        end
    end
    
    if income > 0 then
        self.economyManager:addMoney(income, "Droppers")
    end
end

function DropperSystem:getPurchasedCount()
    local count = 0
    for _, d in ipairs(self.droppers) do
        if d.purchased then count = count + 1 end
    end
    return count
end

function DropperSystem:allPurchased()
    return self:getPurchasedCount() == CONFIG.FLOOR_2.DROPPER_COUNT
end

function DropperSystem:upgradeAllTo(targetTier)
    local totalCost = 0
    for _, d in ipairs(self.droppers) do
        if d.purchased then
            totalCost = totalCost + d:getUpgradeCost(targetTier)
        end
    end
    
    if not self.economyManager:canAfford(totalCost) then return false end
    
    if self.economyManager:spendMoney(totalCost, "Upgrade All") then
        for _, d in ipairs(self.droppers) do
            if d.purchased then
                d.tier = targetTier
            end
        end
        return true
    end
    return false
end

return DropperSystem