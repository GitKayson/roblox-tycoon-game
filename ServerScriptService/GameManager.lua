-- ============================================
-- ELITE GAME MANAGER (Server controller)
-- ============================================

local TycoonManager = require(game.ReplicatedStorage.Modules.TycoonManager)
local CONFIG = require(game.ReplicatedStorage.CONFIG)

local activePlayers = {}

-- ============================================
-- PLAYER EVENTS
-- ============================================

local function onPlayerAdded(player)
    print("✨ Player joined: " .. player.Name)
    
    local tycoon = TycoonManager.new(player.UserId, player.Name)
    activePlayers[player.UserId] = tycoon
    
    local playerData = Instance.new("Folder")
    playerData.Name = "TycoonData"
    playerData.Parent = player
end

local function onPlayerRemoving(player)
    print("👋 Player left: " .. player.Name)
    activePlayers[player.UserId] = nil
end

-- ============================================
-- REMOTE FUNCTIONS
-- ============================================

local remote = Instance.new("RemoteFunction")
remote.Name = "TycoonRemote"
remote.Parent = game.ReplicatedStorage

function remote.OnServerInvoke(player, action, ...)
    local tycoon = activePlayers[player.UserId]
    if not tycoon then return false end
    
    if action == "hire_employee" then
        local index = ...
        if tycoon.employeeSystem then
            return tycoon.employeeSystem:hireEmployee(index)
        end
        
    elseif action == "buy_dropper" then
        local index = ...
        if tycoon.dropperSystem then
            return tycoon.dropperSystem.droppers[index]:purchase()
        end
        
    elseif action == "upgrade_dropper" then
        local index, tier = ...
        if tycoon.dropperSystem then
            return tycoon.dropperSystem.droppers[index]:upgradeTier(tier)
        end
        
    elseif action == "launch_rocket" then
        return tycoon:launchRocket()
        
    elseif action == "get_state" then
        return tycoon:getGameState()
        
    elseif action == "apply_multiplier" then
        local mult, duration = ...
        tycoon.economy:applyMoneyMultiplier(mult, duration)
        return true
    end
    
    return false
end

-- ============================================
-- GAME LOOP
-- ============================================

local function gameLoop()
    local lastTime = tick()
    
    while true do
        local currentTime = tick()
        local deltaTime = currentTime - lastTime
        lastTime = currentTime
        
        for playerId, tycoon in pairs(activePlayers) do
            if tycoon then
                tycoon:update(deltaTime)
            end
        end
        
        task.wait(CONFIG.TICK_RATE)
    end
end

-- ============================================
-- INITIALIZE
-- ============================================

print("🚀 [GameManager] Initializing Elite Tycoon...")

game.Players.PlayerAdded:Connect(onPlayerAdded)
game.Players.PlayerRemoving:Connect(onPlayerRemoving)

for _, player in pairs(game.Players:GetPlayers()) do
    onPlayerAdded(player)
end

print("⚙️ [GameManager] Starting game loop...")
task.spawn(gameLoop)

print("✅ [GameManager] Elite Tycoon initialized!")