-- This exists already in the game 

if (mods["space-age"]) then
	-- Spoilage percent multiplier
-- data:extend({
	-- {
        -- type = "int-setting",
        -- name = "settings-spoilage-multiplier",
        -- setting_type = "startup",
		-- allowed_values = {50, 100, 200, 500, 1000},
        -- default_value = 100,
    -- },
-- })
else
	--	Base game Rocket Recipe
	data:extend({
		{
			type = "int-setting",
			name = "settings-rocket-recipe",
			setting_type = "startup",
			allowed_values = {1, 5, 10, 25, 50, 100, 500, 1000},
			default_value = 1,
		},
		{
			type = "int-setting",
			name = "settings-rocket-recipe-energy",
			setting_type = "startup",
			allowed_values = {1, 5, 10, 25, 50, 100, 500, 1000},
			default_value = 1,
		},
	})
end


data:extend({


	-- Combat things
	
	{
		type = "int-setting",
		name = "settings-combat-friendlyfire-percent",
		setting_type = "startup",
		allowed_values = {0, 5, 10, 25, 50, 100},
		default_value = 10,
    },
	
	{
		type = "int-setting",
		name = "settings-enemy-power-scaling",
		order = "d-a[crashsite]",
		setting_type = "startup",
		allowed_values = {50, 75, 100, 150, 200, 250},
		default_value = 100,
    },


	
	-- Crashsite Stuff (Equipment, Scrap, Items etc.)
    {
        type = "bool-setting",
        name = "settings-crashsite",
		order = "b-a[crashsite]",
        setting_type = "startup",
        default_value = true
    },
		{
        type = "string-setting",
        name = "settings-crashsite-bonus-buildingstats",
		order = "b-b[crashsite]",
        setting_type = "startup",
		default_value = "normal",
		allowed_values = {"normal", "more", "extra"},
    },
	{
        type = "string-setting",
        name = "settings-crashsite-bonus-equipment",
		order = "b-c[crashsite]",
        setting_type = "startup",
		default_value = "normal",
		allowed_values = {"normal", "more", "extra"},
    },
	{
        type = "string-setting",
        name = "settings-crashsite-bonus-scrap",
		order = "b-d[crashsite]",
        setting_type = "startup",
		default_value = "normal",
		allowed_values = {"normal", "more", "extra"},
    },
	{
        type = "bool-setting",
        name = "settings-crashsite-robots",
		order = "b-e[crashsite]",
        setting_type = "startup",
		default_value = false,
    },
	{
        type = "int-setting",
        name = "settings-crashsite-x-players",
		order = "b-f[crashsite]",
        setting_type = "startup",
		allowed_values = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
		default_value = 1,
    },
	
	
	

	
	
	-- Enemies	
	{
        type = "string-setting",
        name = "settings-enemy-spawntime",
		order = "d-b[enemies]",
        setting_type = "startup",
		default_value = "normal",
		allowed_values = {"easy", "normal", "hard", "extreme", "insane"},
    },
	{
        type = "string-setting",
        name = "settings-enemy-health",
		order = "d-c[enemies]",
        setting_type = "startup",
		default_value = "normal",
		allowed_values = {"easy", "normal", "hard", "extreme", "insane"},
    },
	
		-- Biter Stuff
	{
		type = "int-setting",
		name = "settings-chunks-probability",
		order = "d-c[enemies]",
		setting_type = "startup",
		allowed_values = {0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
		default_value = 50,
    },
	{
		type = "int-setting",
		name = "settings-chunks-multiplier",
		order = "d-d[enemies]",
		setting_type = "startup",
		allowed_values = {1, 2, 3, 4, 5, 10},
		default_value = 1,
    },
	
	
	
	
	-- Tech
	{
        type = "string-setting",
        name = "settings-recipe-cost",
        setting_type = "startup",
		default_value = "normal",
		allowed_values = {"easy", "normal", "hard", "extreme", "insane"},
    },	
	
	
	-- Warehouse Stuff
	{
		type = "bool-setting",
		name = "settings-warehouse-abandonments",
		setting_type = "startup",
		default_value = true,
    },
	{
		type = "string-setting",
		name = "settings-warehouse-spacing",
		setting_type = "startup",
		allowed_values = { "dense", "common" , "normal", "uncommon", "sparse", "rare"},
		default_value = "normal",
		-- { 14, 18, 22, 26, 30}
    },
	-- {
		-- type = "int-setting",
		-- name = "settings-warehouse-scaling",
		-- setting_type = "startup",
		-- allowed_values = {75, 100, 125, 150, 175, 200},
		-- default_value = 100,3
    -- },
	
	{
		type = "bool-setting",
		name = "settings-warehouse-barren",
		setting_type = "startup",
		default_value = true,
    },
	
	-- Character
	
    {
        type = "string-setting",
        name = "settings-character-selection",
        setting_type = "startup",
		default_value = "default",
		allowed_values = {"default","kobold","nimble","constructor","soldier","hauler","tank"},
    },
	
	
	
	-- Loaders
	{
        type = "bool-setting",
        name = "settings-loaders-active",
        setting_type = "startup",
		default_value = true,
    },
	{
        type = "bool-setting",
        name = "settings-loaders-electricity",
        setting_type = "startup",
		default_value = false,
    },
	{
        type = "string-setting",
        name = "settings-loaders-cost",
        setting_type = "startup",
		default_value = "normal",
		allowed_values = {"normal","expensive"},
    },
	
	
	
	-- Turret Veterancy
	{
        type = "string-setting",
        name = "settings-turrets-vet-kill-damage-check-type",
		order = "c-a[veterancy]",
        setting_type = "startup",
		default_value = "both",
		allowed_values = {"kill","damage","both","either"},
    },
	{
        type = "string-setting",
        name = "settings-turrets-vet-bonus-increase",
		order = "c-b[veterancy]",
        setting_type = "startup",
		default_value = "default",
		allowed_values = {"half","default","double"},
    },
	{
        type = "string-setting",
        name = "settings-turrets-vet-damage-milestones",
		order = "c-c[veterancy]",
        setting_type = "startup",
		default_value = "default",
		allowed_values = {"half","default","double"},
    },
		{
        type = "string-setting",
        name = "settings-turrets-vet-kill-milestones",
		order = "c-d[veterancy]",
        setting_type = "startup",
		default_value = "default",
		allowed_values = {"half","default","double"},
    },
	
	
	
	-- Quality of life changes
	{
        type = "string-setting",
        name = "settings-status-panels",
        setting_type = "startup",
		default_value = "electric-only",
		allowed_values = {"none","electric-only","all"},
    },
	
	
	
	-- World Settings
	{
        type = "string-setting",
        name = "settings-world-daynightcycle",
        setting_type = "startup",
		default_value = "normal",
		allowed_values = {"short", "normal", "long"},
    },
})