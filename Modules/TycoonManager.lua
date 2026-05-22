-- ============================================
-- ELITE TYCOON MANAGER (Main controller)
-- ============================================

local TycoonManager = {}
local TycoonManager_mt = {__index = TycoonManager}

local CONFIG = require(game.ReplicatedStorage.CONFIG)
local EconomyManager = require(game.ReplicatedStorage.Modules.EconomyManager)
local EmployeeSystem = require(game.ReplicatedStorage.Modules.EmployeeSystem)
local DropperSystem = require(game.ReplicatedStorage.Modules.DropperSystem)

function TycoonManager.new(playerId, playerName)
    local self = setmetatable({}, TycoonManager_mt)
    
    self.playerId = playerId
    self.playerName = playerName
    self.currentFloor = 1
    self.startTime = tick()
    self.gameCompleted = false
    self.completionTime = 0
    self.floorStartTime = 0
    
    self.economy = EconomyManager.new(playerId)
    self.employeeSystem = nil
    self.dropperSystem = nil
    
    self:initializeFloor(1)
    
    return self
end

function TycoonManager:initializeFloor(floorNumber)
    if floorNumber == 1 then
        self.economy.cash = CONFIG.FLOOR_1.STARTING_CASH
        self.employeeSystem = EmployeeSystem.new(CONFIG.FLOOR_1, self.economy)
        self.dropperSystem = nil
        self.currentFloor = 1
        
    elseif floorNumber == 2 then
        self.employeeSystem = nil
        self.dropperSystem = DropperSystem.new(self.economy)
        self.currentFloor = 2
        
    elseif floorNumber == 3 then
        self.dropperSystem = nil
        self.employeeSystem = EmployeeSystem.new(CONFIG.FLOOR_3, self.economy)
        self.currentFloor = 3
    end
    
    self.floorStartTime = tick()
end

function TycoonManager:checkFloorCompletion()
    local config = self:getCurrentFloorConfig()
    return self.economy.cash >= config.END_GOAL
end

function TycoonManager:advanceFloor()
    if self.currentFloor >= 3 then
        return self:completeGame()
    end
    
    self:initializeFloor(self.currentFloor + 1)
    return true
end

function TycoonManager:completeGame()
    self.gameCompleted = true
    self.completionTime = tick() - self.startTime
    self.economy:addMoney(5000000000, "Completion Bonus")
    return true
end

function TycoonManager:launchRocket()
    if self.currentFloor ~= 3 then return false end
    
    local cost = CONFIG.FLOOR_3.ROCKET_LAUNCH.COST
    if not self.economy:canAfford(cost) then return false end
    
    if self.economy:spendMoney(cost, "Rocket") then
        self.economy:addMoney(cost * 10, "Rocket Bonus")
        return true
    end
    
    return false
end

function TycoonManager:getCurrentFloorConfig()
    if self.currentFloor == 1 then return CONFIG.FLOOR_1
    elseif self.currentFloor == 2 then return CONFIG.FLOOR_2
    elseif self.currentFloor == 3 then return CONFIG.FLOOR_3
    end
end

function TycoonManager:update(deltaTime)
    if self.currentFloor == 1 or self.currentFloor == 3 then
        if self.employeeSystem then
            self.employeeSystem:update(deltaTime)
        end
    elseif self.currentFloor == 2 then
        if self.dropperSystem then
            self.dropperSystem:update(deltaTime)
        end
    end
    
    if self:checkFloorCompletion() and self.currentFloor < 3 then
        self:advanceFloor()
    elseif self:checkFloorCompletion() and self.currentFloor == 3 then
        self:completeGame()
    end
end

function TycoonManager:getGameState()
    return {
        playerId = self.playerId,
        playerName = self.playerName,
        currentFloor = self.currentFloor,
        cash = self.economy:getCash(),
        totalCashEarned = self.economy.totalCashEarned,
        incomePerSecond = self.economy:getIncomePerSecond(),
        gameCompleted = self.gameCompleted,
        completionTime = self.completionTime,
        elapsedTime = tick() - self.startTime,
        floorTime = tick() - self.floorStartTime,
        moneyMultiplier = self.economy.moneyMultiplier,
        speedMultiplier = self.economy.speedMultiplier,
    }
end

return TycoonManager