-- ============================================
-- ELITE EMPLOYEE SYSTEM (Smooth upgrades)
-- ============================================

local EmployeeSystem = {}
local EmployeeSystem_mt = {__index = EmployeeSystem}

local CONFIG = require(game.ReplicatedStorage.CONFIG)

local Employee = {}
local Employee_mt = {__index = Employee}

function Employee.new(template, economyManager)
    local self = setmetatable({}, Employee_mt)
    self.name = template.NAME
    self.description = template.DESCRIPTION or "Worker"
    self.baseCost = template.BASE_COST
    self.incomePerSecond = template.INCOME_PER_SECOND
    self.levelMultiplier = template.LEVEL_MULTIPLIER
    self.maxLevel = template.MAX_LEVEL
    self.color = template.COLOR or Color3.new(1, 1, 1)
    self.level = 1
    self.hired = false
    self.economyManager = economyManager
    
    return self
end

function Employee:getHireCost()
    if self.hired then
        return math.floor(self.baseCost * math.pow(1.15, self.level - 1))
    else
        return self.baseCost
    end
end

function Employee:getCurrentIncome()
    return self.incomePerSecond * math.pow(self.levelMultiplier, self.level - 1) * CONFIG.EMPLOYEE_EFFICIENCY_MULTIPLIER
end

function Employee:hire()
    if self.hired then
        if self.level < self.maxLevel then
            self.level = self.level + 1
            return true, self.level
        else
            return false, "Max Level"
        end
    else
        self.hired = true
        return true, 1
    end
end

function Employee:generateIncome(deltaTime)
    if not self.hired then return 0 end
    return self:getCurrentIncome() * deltaTime
end

-- ============================================
-- EMPLOYEE SYSTEM
-- ============================================

function EmployeeSystem.new(floorConfig, economyManager)
    local self = setmetatable({}, EmployeeSystem_mt)
    self.employees = {}
    self.economyManager = economyManager
    
    if floorConfig.FREE_EMPLOYEE then
        local freeEmployee = Employee.new(floorConfig.FREE_EMPLOYEE, economyManager)
        freeEmployee.hired = true
        table.insert(self.employees, freeEmployee)
    end
    
    if floorConfig.EMPLOYEES then
        for _, template in ipairs(floorConfig.EMPLOYEES) do
            local employee = Employee.new(template, economyManager)
            table.insert(self.employees, employee)
        end
    end
    
    return self
end

function EmployeeSystem:hireEmployee(index)
    if not self.employees[index] then return false end
    
    local employee = self.employees[index]
    local cost = employee:getHireCost()
    
    if not self.economyManager:canAfford(cost) then
        return false, "Not enough money"
    end
    
    if self.economyManager:spendMoney(cost, "Employee") then
        local success, result = employee:hire()
        if success then
            return true, result
        end
    end
    
    return false
end

function EmployeeSystem:getEmployees()
    return self.employees
end

function EmployeeSystem:getTotalPassiveIncome()
    local total = 0
    for _, employee in ipairs(self.employees) do
        if employee.hired then
            total = total + employee:getCurrentIncome()
        end
    end
    return total
end

function EmployeeSystem:update(deltaTime)
    local income = 0
    for _, employee in ipairs(self.employees) do
        if employee.hired then
            income = income + employee:generateIncome(deltaTime)
        end
    end
    
    if income > 0 then
        self.economyManager:addMoney(income, "Employees")
    end
end

return EmployeeSystem