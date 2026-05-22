-- ============================================
-- ELITE ROBLOX TYCOON GAME - CONFIG
-- ============================================
-- Central configuration for all game mechanics
-- Adjust these values to fine-tune gameplay

local CONFIG = {}

-- ============================================
-- GAME CONSTANTS
-- ============================================
CONFIG.MAX_PLAYERS_PER_SERVER = 6
CONFIG.PLOTS_PER_SERVER = 6
CONFIG.GAME_DURATION_TARGET_MINUTES = 90
CONFIG.DATA_SAVE_INTERVAL = 30
CONFIG.TICK_RATE = 0.05 -- 20 updates per second for smooth gameplay

-- ============================================
-- FLOOR 1: PAYPAL TYCOON (5-15 minutes)
-- ============================================
CONFIG.FLOOR_1 = {
    NAME = "PayPal Tycoon",
    THEME = "Office Building",
    TARGET_TIME_MIN = 5,
    TARGET_TIME_MAX = 15,
    STARTING_CASH = 100000,
    END_GOAL = 10000000000,
    
    FREE_EMPLOYEE = {
        NAME = "Intern",
        INCOME_PER_SECOND = 1000,
        LEVEL_MULTIPLIER = 1.5,
        MAX_LEVEL = 20,
        COLOR = Color3.fromRGB(100, 149, 237),
    },
    
    EMPLOYEES = {
        {
            NAME = "Entry Level",
            BASE_COST = 5000,
            INCOME_PER_SECOND = 50,
            LEVEL_MULTIPLIER = 1.3,
            MAX_LEVEL = 10,
            COLOR = Color3.fromRGB(0, 112, 192),
            DESCRIPTION = "Your first hire!"
        },
        {
            NAME = "Junior Dev",
            BASE_COST = 50000,
            INCOME_PER_SECOND = 500,
            LEVEL_MULTIPLIER = 1.35,
            MAX_LEVEL = 15,
            COLOR = Color3.fromRGB(52, 152, 219),
            DESCRIPTION = "Codes for cash"
        },
        {
            NAME = "Senior Dev",
            BASE_COST = 500000,
            INCOME_PER_SECOND = 5000,
            LEVEL_MULTIPLIER = 1.4,
            MAX_LEVEL = 20,
            COLOR = Color3.fromRGB(41, 128, 185),
            DESCRIPTION = "Experience matters"
        },
        {
            NAME = "Manager",
            BASE_COST = 5000000,
            INCOME_PER_SECOND = 50000,
            LEVEL_MULTIPLIER = 1.45,
            MAX_LEVEL = 25,
            COLOR = Color3.fromRGB(230, 126, 34),
            DESCRIPTION = "Supervises everything"
        },
        {
            NAME = "Director",
            BASE_COST = 50000000,
            INCOME_PER_SECOND = 500000,
            LEVEL_MULTIPLIER = 1.5,
            MAX_LEVEL = 30,
            COLOR = Color3.fromRGB(192, 57, 43),
            DESCRIPTION = "Sets the vision"
        },
        {
            NAME = "VP",
            BASE_COST = 500000000,
            INCOME_PER_SECOND = 5000000,
            LEVEL_MULTIPLIER = 1.55,
            MAX_LEVEL = 35,
            COLOR = Color3.fromRGB(155, 89, 182),
            DESCRIPTION = "Strategic leader"
        },
        {
            NAME = "CEO",
            BASE_COST = 5000000000,
            INCOME_PER_SECOND = 50000000,
            LEVEL_MULTIPLIER = 1.6,
            MAX_LEVEL = 40,
            COLOR = Color3.fromRGB(46, 204, 113),
            DESCRIPTION = "The boss"
        },
    },
}

-- ============================================
-- FLOOR 2: TESLA TYCOON (10-20 minutes)
-- ============================================
CONFIG.FLOOR_2 = {
    NAME = "Tesla Tycoon",
    THEME = "Electric Vehicle Factory",
    TARGET_TIME_MIN = 10,
    TARGET_TIME_MAX = 20,
    STARTING_CASH = 10000000000,
    END_GOAL = 100000000000,
    PREREQUISITE_FLOOR = 1,
    
    DROPPER_COUNT = 7,
    DROPPER_BASE_COST = 500000000,
    
    TIERS = {
        {
            NAME = "Tesla Model 3",
            DESCRIPTION = "Standard electric car",
            UPGRADE_COST_MULTIPLIER = 1,
            DROP_INTERVAL = 3,
            VALUE_PER_DROP = 100000000,
            SIZE_SCALE = 1,
            COLOR = Color3.fromRGB(255, 0, 0),
            VISUAL = "🚗",
        },
        {
            NAME = "Tesla Truck",
            DESCRIPTION = "Heavy duty truck",
            UPGRADE_COST_MULTIPLIER = 5,
            DROP_INTERVAL = 2.5,
            VALUE_PER_DROP = 500000000,
            SIZE_SCALE = 1.5,
            COLOR = Color3.fromRGB(255, 100, 0),
            VISUAL = "🚙",
        },
        {
            NAME = "Tesla Roadster",
            DESCRIPTION = "Ultra high performance",
            UPGRADE_COST_MULTIPLIER = 20,
            DROP_INTERVAL = 2,
            VALUE_PER_DROP = 2000000000,
            SIZE_SCALE = 2,
            COLOR = Color3.fromRGB(255, 200, 0),
            VISUAL = "🏎️",
        },
    },
}

-- ============================================
-- FLOOR 3: SPACEX TYCOON (30-45 minutes)
-- ============================================
CONFIG.FLOOR_3 = {
    NAME = "SpaceX Tycoon",
    THEME = "Rocket Manufacturing",
    TARGET_TIME_MIN = 30,
    TARGET_TIME_MAX = 45,
    STARTING_CASH = 100000000000,
    END_GOAL = 1000000000000,
    PREREQUISITE_FLOOR = 2,
    
    EMPLOYEES = {
        {
            NAME = "Engineer",
            BASE_COST = 1000000000,
            INCOME_PER_SECOND = 100000000,
            LEVEL_MULTIPLIER = 1.4,
            MAX_LEVEL = 30,
            COLOR = Color3.fromRGB(100, 149, 237),
            DESCRIPTION = "Builds the rockets"
        },
        {
            NAME = "Scientist",
            BASE_COST = 5000000000,
            INCOME_PER_SECOND = 500000000,
            LEVEL_MULTIPLIER = 1.45,
            MAX_LEVEL = 35,
            COLOR = Color3.fromRGB(123, 104, 238),
            DESCRIPTION = "Research & development"
        },
        {
            NAME = "Technician",
            BASE_COST = 10000000000,
            INCOME_PER_SECOND = 1000000000,
            LEVEL_MULTIPLIER = 1.5,
            MAX_LEVEL = 40,
            COLOR = Color3.fromRGB(138, 43, 226),
            DESCRIPTION = "Technical specialist"
        },
        {
            NAME = "Specialist",
            BASE_COST = 50000000000,
            INCOME_PER_SECOND = 5000000000,
            LEVEL_MULTIPLIER = 1.55,
            MAX_LEVEL = 45,
            COLOR = Color3.fromRGB(75, 0, 130),
            DESCRIPTION = "Expert level"
        },
        {
            NAME = "Mission Commander",
            BASE_COST = 100000000000,
            INCOME_PER_SECOND = 10000000000,
            LEVEL_MULTIPLIER = 1.6,
            MAX_LEVEL = 50,
            COLOR = Color3.fromRGB(139, 0, 139),
            DESCRIPTION = "Leads all operations"
        },
    },
    
    ROCKET_LAUNCH = {
        COST = 1000000000000,
        BUILD_TIME_SECONDS = 30,
        EVENT_DURATION_SECONDS = 60,
        SKY_DARKNESS = 0.7,
        ROCKET_SPEED = 100,
        CAMERA_SHAKE = 0.5,
    },
}

-- ============================================
-- PREMIUM ROBUX SHOP
-- ============================================
CONFIG.ROBUX_SHOP = {
    MONEY_MULTIPLIERS = {
        {
            NAME = "🔥 2x Money (30 min)",
            ROBUX_COST = 50,
            MULTIPLIER = 2,
            DURATION_SECONDS = 1800,
            DESCRIPTION = "Double your earnings"
        },
        {
            NAME = "⚡ 5x Money (1 hour)",
            ROBUX_COST = 150,
            MULTIPLIER = 5,
            DURATION_SECONDS = 3600,
            DESCRIPTION = "5x earnings boost"
        },
        {
            NAME = "💥 10x Money (2 hours)",
            ROBUX_COST = 300,
            MULTIPLIER = 10,
            DURATION_SECONDS = 7200,
            DESCRIPTION = "Maximum boost!"
        },
    },
    
    SPEED_BOOSTS = {
        {
            NAME = "⚙️ 2x Speed (30 min)",
            ROBUX_COST = 50,
            MULTIPLIER = 2,
            DURATION_SECONDS = 1800,
            DESCRIPTION = "Speed up progression"
        },
        {
            NAME = "🚀 5x Speed (1 hour)",
            ROBUX_COST = 150,
            MULTIPLIER = 5,
            DURATION_SECONDS = 3600,
            DESCRIPTION = "Fly through levels"
        },
    },
    
    COSMETICS = {
        {
            NAME = "👤 Elon Musk Avatar",
            ROBUX_COST = 150,
            TYPE = "AVATAR",
            DESCRIPTION = "Become a billionaire"
        },
        {
            NAME = "🧞 Flying Carpet",
            ROBUX_COST = 100,
            TYPE = "COSMETIC",
            DESCRIPTION = "Travel in style"
        },
        {
            NAME = "☁️ Cloud Platform",
            ROBUX_COST = 120,
            TYPE = "COSMETIC",
            DESCRIPTION = "Stand on clouds"
        },
        {
            NAME = "✨ Golden Aura",
            ROBUX_COST = 80,
            TYPE = "COSMETIC",
            DESCRIPTION = "Shine bright"
        },
    },
    
    VIP_PASS = {
        ROBUX_COST = 300,
        DURATION_SECONDS = 3600,
        DESCRIPTION = "Premium experience",
        BENEFITS = {
            MONEY_MULTIPLIER = 2,
            SPEED_MULTIPLIER = 2,
            DAILY_BONUS = 50000000,
            EXCLUSIVE_COSMETICS = true,
        },
    },
}

-- ============================================
-- DAILY LOGIN REWARDS (Escalating)
-- ============================================
CONFIG.DAILY_REWARDS = {
    { DAY = 1, CASH = 1000000, BONUS_TEXT = "Welcome Back! 👋" },
    { DAY = 2, CASH = 2000000, BONUS_TEXT = "On a Roll! 🔥" },
    { DAY = 3, CASH = 5000000, BONUS_TEXT = "Consistency Pays! 💰" },
    { DAY = 4, CASH = 10000000, BONUS_TEXT = "Great Streak! ⭐" },
    { DAY = 5, CASH = 20000000, BONUS_TEXT = "Amazing Dedication! 🚀" },
    { DAY = 6, CASH = 50000000, BONUS_TEXT = "Super Fan! 🎉" },
    { DAY = 7, CASH = 100000000, BONUS_TEXT = "Weekly Champion! 👑" },
}

-- ============================================
-- ACHIEVEMENTS (with progression tracking)
-- ============================================
CONFIG.ACHIEVEMENTS = {
    { ID = "first_hire", NAME = "Hired First", DESCRIPTION = "Hire your first employee", REWARD_CASH = 500000, ICON = "👔" },
    { ID = "floor_1_complete", NAME = "Office Master", DESCRIPTION = "Complete Floor 1", REWARD_CASH = 50000000, ICON = "🏢" },
    { ID = "floor_2_complete", NAME = "Tesla Titan", DESCRIPTION = "Complete Floor 2", REWARD_CASH = 500000000, ICON = "🚗" },
    { ID = "floor_3_complete", NAME = "Space Legend", DESCRIPTION = "Launch the rocket", REWARD_CASH = 5000000000, ICON = "🚀" },
    { ID = "speed_runner", NAME = "Speed Runner", DESCRIPTION = "Complete in under 1 hour", REWARD_CASH = 10000000000, ICON = "⚡" },
    { ID = "millionaire", NAME = "Millionaire", DESCRIPTION = "Earn 1M cash", REWARD_CASH = 1000000, ICON = "💰" },
    { ID = "billionaire", NAME = "Billionaire", DESCRIPTION = "Earn 1B cash", REWARD_CASH = 10000000, ICON = "🤑" },
}

-- ============================================
-- QUESTS (Daily/Speed challenges)
-- ============================================
CONFIG.QUESTS = {
    { ID = "hire_3", NAME = "Hire 3 Employees", DESCRIPTION = "Build your team", REQUIREMENT = 3, REWARD_CASH = 5000000, REWARD_ROBUX = 10, ICON = "👥" },
    { ID = "earn_100m", NAME = "Earn 100M", DESCRIPTION = "Accumulate wealth", REQUIREMENT = 100000000, REWARD_CASH = 25000000, REWARD_ROBUX = 25, ICON = "💵" },
    { ID = "floor_1_fast", NAME = "Speed Runner", DESCRIPTION = "Floor 1 in 10 min", REQUIREMENT = 600, REWARD_CASH = 50000000, REWARD_ROBUX = 50, ICON = "🏃" },
}

-- ============================================
-- UI/UX SETTINGS (Smooth animations)
-- ============================================
CONFIG.UI = {
    UPDATE_FREQUENCY = 0.05,
    NOTIFICATION_DURATION = 3,
    ANIMATION_SPEED = 0.3, -- Smooth tweens
    FONT = Enum.Font.GothamBold,
    TWEEN_STYLE = Enum.EasingStyle.Quad,
    TWEEN_DIRECTION = Enum.EasingDirection.Out,
    COLOR_SCHEME = {
        PRIMARY = Color3.fromRGB(0, 120, 215),
        SECONDARY = Color3.fromRGB(40, 167, 69),
        DANGER = Color3.fromRGB(220, 53, 69),
        WARNING = Color3.fromRGB(255, 193, 7),
        TEXT_DARK = Color3.fromRGB(33, 37, 41),
        TEXT_LIGHT = Color3.fromRGB(255, 255, 255),
        ACCENT = Color3.fromRGB(255, 69, 0),
    },
}

-- ============================================
-- LEADERBOARD (Real-time tracking)
-- ============================================
CONFIG.LEADERBOARD = {
    UPDATE_FREQUENCY = 2,
    DISPLAY_TOP = 10,
    TRACK_STATS = {
        "total_cash_earned",
        "completion_time",
        "current_floor",
    },
}

-- ============================================
-- BALANCE MULTIPLIERS (Fine-tune difficulty)
-- ============================================
CONFIG.DIFFICULTY_MULTIPLIER = 1.0
CONFIG.MONEY_GAIN_MULTIPLIER = 1.0
CONFIG.EMPLOYEE_EFFICIENCY_MULTIPLIER = 1.0
CONFIG.DROPPER_EFFICIENCY_MULTIPLIER = 1.0

-- ============================================
-- ANIMATION SETTINGS (Premium feel)
-- ============================================
CONFIG.ANIMATIONS = {
    MONEY_POP_SPEED = 0.2,
    BUTTON_CLICK_SPEED = 0.1,
    POPUP_SPEED = 0.3,
    SLIDE_SPEED = 0.4,
    FADE_SPEED = 0.25,
    BOUNCE_HEIGHT = 20,
}

return CONFIG