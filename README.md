# 🚀 ELITE ROBLOX TYCOON GAME

**A Premium 3-Floor Progression Tycoon with PayPal → Tesla → SpaceX themes**

![Roblox](https://img.shields.io/badge/Roblox-000000?style=flat-square&logo=roblox)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua)
![Status](https://img.shields.io/badge/Status-Elite%20Build-brightgreen?style=flat-square)

---

## 📋 Features

### 🎮 Gameplay
- **3-Floor Progression**: PayPal (5-15 min) → Tesla (10-20 min) → SpaceX (30-45 min)
- **Employee System**: Hire and level up 8 workers per floor with passive income
- **Dropper System**: 7 Tesla droppers with tier upgrades (Model 3 → Truck → Roadster)
- **Rocket Launch Event**: Epic finale with sky darkening effect and server-wide notification
- **Smooth Progression**: 100K → 10B → 100B → 1T cash flow

### 💰 Economy
- **Passive Income**: Employees generate money automatically
- **Money Multipliers**: 2x, 5x, 10x boosts via Robux
- **Speed Boosts**: Accelerate progression (2x, 5x)
- **Daily Rewards**: Escalating 7-day login bonuses
- **Achievements**: 7 major achievements with cash rewards

### 🏆 Social Features
- **Multi-player**: Up to 6 players per server
- **Leaderboards**: Real-time stat tracking
- **Completion Broadcast**: All players see who finished
- **Server-wide Events**: Rocket launch visible to all

### 🛍️ P2W Shop
- Money multipliers (50-300 Robux)
- Speed boosts (50-150 Robux)
- Cosmetics: Elon avatar, flying carpet, cloud platform (80-150 Robux)
- VIP Pass: All-in-one premium (300 Robux)

---

## 📦 Installation

### Step 1: Create Roblox Place
1. Open Roblox Studio
2. Create a new blank place
3. Save with name: "Elite Tycoon"

### Step 2: Copy Code Files

**ServerScriptService:**
- Copy `ServerScriptService/GameManager.lua` into ServerScriptService

**ReplicatedStorage:**
1. Create folder: `Modules`
2. Copy all files from `Modules/` folder
3. Copy `CONFIG.lua` to root of ReplicatedStorage

### Step 3: Create UI (Basic Setup)

In **StarterPlayer > StarterPlayerScripts**, create a **LocalScript**:

```lua
local remote = game.ReplicatedStorage:WaitForChild("TycoonRemote")
local players = game:GetService("Players")
local player = players.LocalPlayer

-- Game loop
while true do
    local success, state = pcall(function()
        return remote:InvokeServer("get_state")
    end)
    
    if success and state then
        print("Cash: $" .. state.cash)
        print("Floor: " .. state.currentFloor)
    end
    
    task.wait(0.5)
end
```

### Step 4: Test
1. Click **Play** in Roblox Studio
2. Check Output console for initialization messages
3. Monitor player progression

---

## ⚙️ Configuration

All settings in `CONFIG.lua`:

```lua
-- Adjust difficulty
CONFIG.MONEY_GAIN_MULTIPLIER = 1.0 -- 0.5 = easier, 2.0 = harder
CONFIG.EMPLOYEE_EFFICIENCY_MULTIPLIER = 1.0

-- Change prices
CONFIG.ROBUX_SHOP.MONEY_MULTIPLIERS[1].ROBUX_COST = 50 -- 2x Money cost

-- Tweak timings
CONFIG.FLOOR_1.TARGET_TIME_MAX = 15 -- Max 15 minutes
```

---

## 📖 API Reference

### Remote Functions

```lua
local remote = game.ReplicatedStorage.TycoonRemote

-- Hire employee (Floor 1/3)
remote:InvokeServer("hire_employee", employeeIndex)

-- Buy dropper (Floor 2)
remote:InvokeServer("buy_dropper", dropperIndex)

-- Upgrade dropper tier
remote:InvokeServer("upgrade_dropper", dropperIndex, targetTier)

-- Launch rocket (Floor 3)
remote:InvokeServer("launch_rocket")

-- Get game state
local state = remote:InvokeServer("get_state")

-- Apply multiplier (P2W)
remote:InvokeServer("apply_multiplier", 5, 3600) -- 5x for 1 hour
```

### Modules

#### EconomyManager
```lua
local economy = player.TycoonData.TycoonManager.Value.economy

economy:addMoney(1000000, "Bonus")
economy:spendMoney(500000, "Upgrade")
economy:applyMoneyMultiplier(2, 1800)
economy:formatMoney(1500000) -- "$1.50M"
```

#### EmployeeSystem
```lua
local employees = tycoon.employeeSystem

employees:hireEmployee(1)
local income = employees:getTotalPassiveIncome()
employees:update(deltaTime)
```

#### DropperSystem
```lua
local droppers = tycoon.dropperSystem

droppers.droppers[1]:purchase()
droppers.droppers[1]:upgradeTier(2)
droppers:upgradeAllTo(3)
local purchased = droppers:getPurchasedCount()
```

---

## 🎯 Gameplay Guide

### Floor 1: PayPal Tycoon (5-15 min)
1. Start with $100K and free Intern
2. Hire 7 employees (Entry → CEO)
3. Each hire costs progressively more
4. Reach $10B to advance to Floor 2
5. **Strategy**: Hire higher-tier employees early for exponential growth

### Floor 2: Tesla Tycoon (10-20 min)
1. Start with $10B from Floor 1
2. Buy 7 droppers ($500M each)
3. Upgrade droppers: Model 3 → Truck → Roadster
4. Each tier drops higher-value vehicles
5. Reach $100B to advance to Floor 3
6. **Strategy**: Upgrade all droppers together for efficiency

### Floor 3: SpaceX Tycoon (30-45 min)
1. Start with $100B from Floor 2
2. Hire 5 specialized engineers
3. Accumulate $1T
4. Launch rocket (triggers server event)
5. Complete the game!
6. **Strategy**: Focus on high-tier employees first

---

## 💡 Tips for Players

- **Use Multipliers**: Buy 5x Money boost early for faster progression
- **Speed Runner**: Complete in under 1 hour for achievement
- **Daily Login**: Don't miss daily bonuses (100M on day 7!)
- **Level Up**: Upgrading employees is cheaper than hiring new ones

---

## 🔧 Customization

### Add New Floor
```lua
-- In CONFIG.lua
CONFIG.FLOOR_4 = {
    NAME = "Your Floor",
    STARTING_CASH = 1000000000000,
    END_GOAL = 10000000000000,
    -- ... add your config
}

-- In TycoonManager.lua, add to initializeFloor()
if floorNumber == 4 then
    -- Your code here
end
```

### Adjust Difficulty
```lua
-- Make game 2x harder
CONFIG.MONEY_GAIN_MULTIPLIER = 0.5

-- Make employees more efficient
CONFIG.EMPLOYEE_EFFICIENCY_MULTIPLIER = 1.5
```

---

## 📊 Performance

- **Tick Rate**: 20 updates/second (smooth gameplay)
- **Max Players**: 6 per server
- **Data Saves**: Every 30 seconds
- **Memory Usage**: ~5-10MB per player

---

## 🐛 Troubleshooting

**"TycoonRemote not found"**
- Ensure `GameManager.lua` is in ServerScriptService
- Check game is running in Studio

**Players not advancing floors**
- Check CONFIG.lua floor END_GOAL values
- Verify economy:addMoney() is being called

**No income generated**
- Ensure EmployeeSystem:update() is called each frame
- Check employee has hired = true

---

## 🎓 Learn More

- [Roblox Lua Documentation](https://create.roblox.com/docs)
- [Tycoon Game Design](https://www.reddit.com/r/roblox/)
- [Optimization Tips](https://create.roblox.com/docs/reference/engine)

---

## 📝 License

Open source for educational purposes. Feel free to customize!

---

**Made with ❤️ for elite Roblox developers**

*Questions? Check the CONFIG.lua file for all settings!*