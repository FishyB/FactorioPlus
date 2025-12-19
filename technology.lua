require("stats")
local physical_projectile_damage_1_icon = "__base__/graphics/technology/physical-projectile-damage-1.png"
local physical_projectile_damage_2_icon = "__base__/graphics/technology/physical-projectile-damage-2.png"
local stronger_explosives_1_icon = "__base__/graphics/technology/stronger-explosives-1.png"
local stronger_explosives_2_icon = "__base__/graphics/technology/stronger-explosives-2.png"
local stronger_explosives_3_icon = "__base__/graphics/technology/stronger-explosives-3.png"
local refined_flammables_icon = "__base__/graphics/technology/refined-flammables.png"
local energy_weapons_damage_1_icon = "__base__/graphics/technology/energy-weapons-damage.png"
local energy_weapons_damage_2_icon = "__base__/graphics/technology/energy-weapons-damage.png"
local energy_weapons_damage_3_icon = "__base__/graphics/technology/energy-weapons-damage.png"
local weapon_shooting_speed_1_icon = "__base__/graphics/technology/weapon-shooting-speed-1.png"
local weapon_shooting_speed_2_icon = "__base__/graphics/technology/weapon-shooting-speed-2.png"
local weapon_shooting_speed_3_icon = "__base__/graphics/technology/weapon-shooting-speed-3.png"
local laser_shooting_speed_icon = "__base__/graphics/technology/laser-shooting-speed.png"

function util.technology_icon_constant_health(technology_icon)
  local icons =
  {
    {
      icon = technology_icon,
      icon_size = 256, icon_mipmaps = 4
    },
    {
      icon = "__factorioplus__/graphics/technology/health-constant.png",
      icon_size = 128,
      scale = 0.5,
      shift = {50, 50}
    }
  }
  return icons
end

if (mods["quality"]) and not (mods["space-age"]) then
data.raw.technology["recycling"].prerequisites = {"chemical-science-pack", "advanced-circuit", "concrete"}

data.raw.technology["recycling"].unit =
{
  count = 500,
  ingredients =
  {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 },
  },
  time = 20
}

data.raw.technology["epic-quality"].prerequisites = { "production-science-pack", "quality-module" }
data.raw.technology["epic-quality"].unit =
{
  count = 1000,
  ingredients =
  {
	{ "automation-science-pack", 1 },
	{ "logistic-science-pack", 1 },
	{ "chemical-science-pack", 1 },
	{ "production-science-pack", 1 },
  },
  time = 60
}

data.raw.technology["legendary-quality"].prerequisites = { "utility-science-pack", "epic-quality" }
data.raw.technology["legendary-quality"].unit =
    {
      count = 2000,
      ingredients =
      {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 },
        { "utility-science-pack", 1 },
      },
      time = 60
    }
	
data.raw.recipe["recycler"].ingredients =
{
  {type = "item", name = "advanced-circuit", amount = 20},
  {type = "item", name = "steel-plate", amount = 20},
  {type = "item", name = "iron-gear-wheel", amount = 40},
  {type = "item", name = "concrete", amount = 20}
}

end

if (mods["space-age"]) then

-- data.raw.technology["cliff-explosives"].prerequisites =
-- {
  -- "cliff-explosives-light",
  -- "military-science-pack",
  -- "metallurgic-science-pack"
-- }

-- data.extend({

 -- {
    -- type = "technology",
    -- name = "cliff-explosives-light",
    -- icon = "__factorioplus__/graphics/technology/cliff-explosives-light.png",
    -- icon_size = 256,
    -- prerequisites = {"explosives", "military-2"},
    -- unit =
    -- {
      -- count = 200,
      -- ingredients =
      -- {
        -- {"automation-science-pack", 1},
        -- {"logistic-science-pack", 1}
      -- },
      -- time = 15
    -- },
    -- effects =
    -- {
      -- {
        -- type = "unlock-recipe",
        -- recipe = "cliff-explosives-light"
      -- },
    -- }
  -- },
  
-- }) 

else
end

-- MODULE 2 OVERRIDE

table.removeentry(data.raw["technology"]["speed-module-2"].prerequisites, "processing-unit") 
table.insert(data.raw["technology"]["speed-module-2"].prerequisites,"chemical-science-pack")

table.removeentry(data.raw["technology"]["productivity-module-2"].prerequisites, "processing-unit") 
table.insert(data.raw["technology"]["productivity-module-2"].prerequisites,"chemical-science-pack")

table.removeentry(data.raw["technology"]["efficiency-module-2"].prerequisites, "processing-unit") 
table.insert(data.raw["technology"]["efficiency-module-2"].prerequisites,"chemical-science-pack")

-- FLUID HANDLING OVERRIDE

table.insert(data.raw["technology"]["fluid-handling"].effects,
{
        type = "unlock-recipe",
        recipe = "barrel-recycling"
}
)

-- FACTORIOPLUS TECHNOLOGIES

data:extend
({

{
      type = "technology",
      name = "molotov",
      icon_size = 256,
      icon = "__factorioplus__/graphics/technology/molotovs.png",
      effects =
      {
        {
        type = "unlock-recipe",
        recipe = "molotov"
        }
      },
      prerequisites = {"flammables", "glass-processing"},
      unit =
      {
        count = 150,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"military-science-pack", 1}
        },
        time = 30
      },
      upgrade = true,
      order = "e-j-a"
    },

 {
      type = "technology",
      name = "explosive-ammo-1",
      icon_size = 256,
      icon = "__factorioplus__/graphics/technology/explosive-ammo.png",
      effects =
      {
        {
        type = "unlock-recipe",
        recipe = "explosive-rounds-magazine"
        }
      },
      prerequisites = {"military-2","explosives"},
      unit =
      {
        count = 200,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"military-science-pack", 1}
        },
        time = 30
      },
      upgrade = true,
      order = "e-j-a"
    },
	
	 {
      type = "technology",
      name = "explosive-ammo-2",
      icon_size = 256,
      icon = "__factorioplus__/graphics/technology/explosive-ammo.png",
      effects =
      {
        {
        type = "unlock-recipe",
        recipe = "explosive-shotgun-shell"
        }
      },
      prerequisites = {"explosive-ammo-1"},
      unit =
      {
        count = 400,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"military-science-pack", 1}
        },
        time = 30
      },
      upgrade = true,
      order = "e-j-a"
    },
	
	{
    type = "technology",
    name = "explosive-rocketry",
	enabled = false,
    icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/explosive-rocketry.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "explosive-rocket"
      }
    },
    prerequisites = {"rocketry", "military-4"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 30
    },
    order = "e-h"
  },
	
	{
      type = "technology",
      name = "explosive-ammo-3",
      icon_size = 256,
      icon = "__factorioplus__/graphics/technology/explosive-ammo-2.png",
      effects =
      {
        {
        type = "unlock-recipe",
        recipe = "explosive-cannon-shell"
        },
		{
        type = "unlock-recipe",
        recipe = "explosive-rocket"
        },
      },
      prerequisites = {"military-4","tank","explosive-ammo-2"},
      unit =
      {
        count = 600,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
		  {"military-science-pack", 1},
		  {"chemical-science-pack", 1}
        },
        time = 30
      },
      upgrade = true,
      order = "e-j-a"
    },
	
	{
    type = "technology",
    name = "uranium-ammo",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/depleted-uranium-ammo.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "uranium-rounds-magazine"
      },
	        {
        type = "unlock-recipe",
        recipe = "depleted-shotgun-shell"
      },
      {
        type = "unlock-recipe",
        recipe = "uranium-cannon-shell"
      },
	  {
        type = "unlock-recipe",
        recipe = "sniper-shell-uranium"
      },

    },
    prerequisites = {"uranium-processing", "military-5", "tank"},
    unit =
    {
      count = 1000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 45
    },
    order = "e-a-b"
  },
  
  	{
    type = "technology",
    name = "nuclear-ammo",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/uranium-ammo.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "nuke-rounds-magazine"
      },
	        {
        type = "unlock-recipe",
        recipe = "nuke-shotgun-shell"
      },
      {
        type = "unlock-recipe",
        recipe = "explosive-uranium-cannon-shell"
      }

    },
    prerequisites = {"uranium-ammo","kovarex-enrichment-process","atomic-bomb"},
    unit =
    {
      count = 2000,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 45
    },
    order = "e-a-b"
  },
       
	
------------------------------------------------------------------------------------
------------------------------------------ BIOSCIENCE ------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------ BIOSCIENCE PACKS ------------------------------------------

 {
    type = "technology",
    name = "bio-science",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/bio-science.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "bio-science-pack"
      }
    },
	prerequisites = {"fish-processing", "military"},
    unit =
    {
      count = 100,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  },
      time = 20
    },
    order = "a-h-a"
  },
  
  {
    type = "technology",
    name = "chunky-meat-processing",
    icon_size = 256,
	visible_when_disabled = true,
    icon = "__factorioplus__/graphics/technology/meaty-chunk-processing.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "chunky-meat-processing"
      }
    },
	 research_trigger =
    {
      type = "craft-item",
      item = "bio-science-pack"
    },
	prerequisites = {"bio-science"},
    order = "a-h-a"
  },
  
  {
    type = "technology",
    name = "medkits",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/healthkits.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "med-pack"
      }
    },
	prerequisites = {"health-upgrade-4"},
    unit =
    {
      count = 300,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
   {
    type = "technology",
    name = "bio-weaponry-1",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/bio-military-1.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "slowdown-capsule"
      },
	  {
        type = "unlock-recipe",
        recipe = "poison-capsule"
      },
    },
	prerequisites = {"military-2","advanced-oil-processing","bio-science"},
    unit =
    {
      count = 100,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"military-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
        {
    type = "technology",
    name = "bio-weaponry-2",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/bio-military-2.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "healing-capsule"
      },
	  {
        type = "unlock-recipe",
        recipe = "rocket-slowdown"
      },
	  {
        type = "unlock-recipe",
        recipe = "rocket-poison"
      },
    },
	prerequisites = {"military-4","sulfur-processing","bio-weaponry-1"},
    unit =
    {
      count = 200,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"military-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
  
  {
    type = "technology",
    name = "air-purification",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/air-purification-1.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "air-scrubber"
      }
    },
	prerequisites = {"low-density-structure","bio-science"},
    unit =
    {
      count = 500,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
   {
    type = "technology",
    name = "air-purification-2",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/air-purification-2.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "air-scrubber-large"
      }
    },
	prerequisites = {"air-purification","production-science-pack"},
    unit =
    {
      count = 800,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 80
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "bio-fuel",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/biofuel.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "bio-fuel"
      },
	  {
        type = "unlock-recipe",
        recipe = "resin-extraction"
      },  
    },
	prerequisites = {"low-density-structure","bio-science"},
    unit =
    {
      count = 800,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
})

local player_tech_icon = "__factorioplus__/graphics/technology/player.png"

if (mods["space-age"]) then
	 player_tech_icon = "__space-age__/graphics/technology/health.png" 
end

data.extend({  
   {
    type = "technology",
    name = "speed-upgrade-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed(player_tech_icon),
    effects =
    {
      {
        type = "character-running-speed",
        modifier = 0.1
      }
    },
	prerequisites = {"bio-science"},
    unit =
    {
      count = 100,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 30
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "speed-upgrade-2",
     icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed(player_tech_icon),
    effects =
    {
      {
        type = "character-running-speed",
        modifier = 0.1
      }
    },
	prerequisites = {"speed-upgrade-1"},
    unit =
    {
      count = 200,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 30
    },
    order = "a-h-a"
  },
  
  {
    type = "technology",
    name = "speed-upgrade-3",
     icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed(player_tech_icon),
    effects =
    {
      {
         type = "character-running-speed",
        modifier = 0.1
      }
    },
	prerequisites = {"speed-upgrade-2","chemical-science-pack"},
    unit =
    {
      count = 300,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 40
    },
    order = "a-h-a"
  },

  {
    type = "technology",
    name = "speed-upgrade-4",
     icon_size = 256, icon_mipmaps = 4,
    icons =util.technology_icon_constant_movement_speed(player_tech_icon),
    effects =
    {
      {
         type = "character-running-speed",
        modifier = 0.1
      }
    },
	prerequisites = {"speed-upgrade-3",},
    unit =
    {
      count = 400,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 40
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "speed-upgrade-5",
     icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed(player_tech_icon),
    effects =
    {
      {
        type = "character-running-speed",
        modifier = 0.1
      }
    },
	prerequisites = {"speed-upgrade-4","production-science-pack"},
    unit =
    {
      count = 500,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 50
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "speed-upgrade-6",
     icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed(player_tech_icon),
    effects =
    {
      {
        type = "character-running-speed",
        modifier = 0.1
      }
    },
	prerequisites = {"speed-upgrade-5",},
    unit =
    {
      count = 600,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 50
    },
    order = "a-h-a"
  },
  
  {
    type = "technology",
    name = "speed-upgrade-7",
     icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed(player_tech_icon),
    effects =
    {
      {
        type = "character-running-speed",
        modifier = 0.1
      }
    },
	prerequisites = {"speed-upgrade-6","utility-science-pack"},
    unit =
    {
      count = 700,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"utility-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
  
  {
    type = "technology",
    name = "speed-upgrade-8",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed(player_tech_icon),
    effects =
    {
      {
        type = "character-running-speed",
        modifier = 0.1
      }
    },
	prerequisites = {"speed-upgrade-7"},
    unit =
    {
      count = 800,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"utility-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "speed-upgrade-9",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed(player_tech_icon),
    effects =
    {
      {
         type = "character-running-speed",
        modifier = 0.1
      }
    },
	prerequisites = {"speed-upgrade-8","space-science-pack"},
    unit =
    {
      count = 900,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"utility-science-pack", 1},
	  {"space-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "speed-upgrade-10",
     icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_movement_speed(player_tech_icon),
    effects =
    {
      {
         type = "character-running-speed",
        modifier = 0.1
      }
    },
	prerequisites = {"speed-upgrade-9"},
    unit =
    {
      count = 1000,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"utility-science-pack", 1},
	  {"space-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "health-upgrade-1",
    icon_size = 256, icon_mipmaps = 4,
	icons = util.technology_icon_constant_health(player_tech_icon),
    effects =
    {
      {
        type = "character-health-bonus",
        modifier = 25
      }
    },
	prerequisites = {"bio-science"},
    unit =
    {
      count = 100,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 30
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "health-upgrade-2",
    icon_size = 256, icon_mipmaps = 4,
	icons = util.technology_icon_constant_health(player_tech_icon),
    effects =
    {
      {
        type = "character-health-bonus",
        modifier = 25
      }
    },
	prerequisites = {"health-upgrade-1"},
    unit =
    {
      count = 200,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 30
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "health-upgrade-3",
    icon_size = 256, icon_mipmaps = 4,
	icons = util.technology_icon_constant_health(player_tech_icon),
    effects =
    {
      {
        type = "character-health-bonus",
        modifier = 25
      }
    },
	prerequisites = {"health-upgrade-2","chemical-science-pack"},
    unit =
    {
      count = 300,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 40
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "health-upgrade-4",
    icon_size = 256, icon_mipmaps = 4,
	icons = util.technology_icon_constant_health(player_tech_icon),
    effects =
    {
      {
        type = "character-health-bonus",
        modifier = 25
      }
    },
	prerequisites = {"health-upgrade-3",},
    unit =
    {
      count = 400,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 40
    },
    order = "a-h-a"
  },
  
  {
    type = "technology",
    name = "health-upgrade-5",
    icon_size = 256, icon_mipmaps = 4,
	icons = util.technology_icon_constant_health(player_tech_icon),
    effects =
    {
      {
        type = "character-health-bonus",
        modifier = 25
      }
    },
	prerequisites = {"health-upgrade-4","production-science-pack"},
    unit =
    {
      count = 500,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 50
    },
    order = "a-h-a"
  },
  
  {
    type = "technology",
    name = "health-upgrade-6",
    icon_size = 256, icon_mipmaps = 4,
	icons = util.technology_icon_constant_health(player_tech_icon),
    effects =
    {
      {
        type = "character-health-bonus",
        modifier = 25
      }
    },
	prerequisites = {"health-upgrade-5",},
    unit =
    {
      count = 600,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 50
    },
    order = "a-h-a"
  },
  
  {
    type = "technology",
    name = "health-upgrade-7",
   icon_size = 256, icon_mipmaps = 4,
	icons = util.technology_icon_constant_health(player_tech_icon),
    effects =
    {
      {
        type = "character-health-bonus",
        modifier = 25
      }
    },
	prerequisites = {"health-upgrade-6","utility-science-pack"},
    unit =
    {
      count = 700,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"utility-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
  
  {
    type = "technology",
    name = "health-upgrade-8",
   icon_size = 256, icon_mipmaps = 4,
	icons = util.technology_icon_constant_health(player_tech_icon),
    effects =
    {
      {
        type = "character-health-bonus",
        modifier = 25
      }
    },
	prerequisites = {"health-upgrade-7"},
    unit =
    {
      count = 800,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"utility-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "health-upgrade-9",
   icon_size = 256, icon_mipmaps = 4,
	icons = util.technology_icon_constant_health(player_tech_icon),
    effects =
    {
      {
        type = "character-health-bonus",
        modifier = 25
      }
    },
	prerequisites = {"health-upgrade-8", "space-science-pack"},
    unit =
    {
      count = 900,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"utility-science-pack", 1},
	  {"space-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
  
   {
    type = "technology",
    name = "health-upgrade-10",
    icon_size = 256, icon_mipmaps = 4,
	icons = util.technology_icon_constant_health(player_tech_icon),
    effects =
    {
      {
        type = "character-health-bonus",
        modifier = 25
      }
    },
	prerequisites = {"health-upgrade-9"},
    unit =
    {
      count = 1000,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  {"chemical-science-pack", 1},
	  {"production-science-pack", 1},
	  {"utility-science-pack", 1},
	  {"space-science-pack", 1},
	  {"bio-science-pack", 1},
	  },
      time = 60
    },
    order = "a-h-a"
  },
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- table.insert(data.raw["technology"]["military-4"].effects,{type = "unlock-recipe",recipe = "grenade-launcher"})
-- table.insert(data.raw["technology"]["military-4"].effects,{type = "unlock-recipe",recipe = "grenade-rounds"})

{
    type = "technology",
    name = "mortar-turret",
     icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/mortar-turret.png",
    effects =
    {	
	  {
        type = "unlock-recipe",
        recipe = "mortar-turret"
      },
	  {
        type = "unlock-recipe",
        recipe = "grenade-launcher"
      },
	  {
        type = "unlock-recipe",
        recipe = "grenade-rounds"
      },
    },
	prerequisites = {"military-3","stronger-explosives-2"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 30
	  },
  },
  
  })
  
  
data.raw["technology"]["radar"].unit = 
{
      count = 100,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  },
      time = 30
}

data.raw["technology"]["radar"].prerequisites = {"military","logistic-science-pack","electronics"}
-- INSERT ENTRY table.insert(data.raw["technology"]["advanced-circuit"].effects,{type = "unlock-recipe",recipe = "silicon-wafer"})

------------------------------------------ RADAR TECH  ------------------------------------------
 -- {
    -- type = "technology",
    -- name = "radar-tech",
    -- icon_size = 256,
    -- icon = "__factorioplus__/graphics/technology/radar.png",
    -- effects =
    -- {
      -- {
        -- type = "unlock-recipe",
        -- recipe = "radar"
      -- }
    -- },
	-- prerequisites = {"military","logistics","electronics"},
    -- unit =
    -- {
      -- count = 100,
      -- ingredients = 
	  -- {
	  -- {"automation-science-pack", 1},
	  -- {"logistic-science-pack", 1},
	  -- },
      -- time = 30
    -- },
    -- order = "a-h-a"
  -- },
  
data.extend({
------------------------------------------ ADV RADAR TECH  ------------------------------------------
 {
    type = "technology",
    name = "advanced-radar-tech",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/large-radar.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "radar-large"
      }
    },
	prerequisites = {"military-4", "robotics","radar"},
    unit =
    {
      count = 300,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
	  },
      time = 30
    },
    order = "a-h-a"
  },
------------------------------------------ TARMAC ------------------------------------------
 {
    type = "technology",
    name = "tarmac",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/tarmac.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "tarmac"
      }
    },
	prerequisites = {"concrete", "advanced-oil-processing"},
    unit =
    {
      count = 250,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
	  },
      time = 20
    },
    order = "a-h-a"
  },
  
------------------------------------------ LIGHTING ------------------------------------------
 {
    type = "technology",
    name = "lighting",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/lighting.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "floodlight-lamp"
      }
    },
	prerequisites = {"steel-processing", "lamp"},
    unit =
    {
      count = 50,
      ingredients = {{"automation-science-pack", 1}},
      time = 20
    },
    order = "a-h-a"
  },
  
  ------------------------------------------ FLOOR LIGHTING ------------------------------------------
 {
    type = "technology",
    name = "floor-lamp",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/floor-lamp.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "floor-lamp"
      }
    },
	prerequisites = {"lighting", "landfill"},
    unit =
    {
      count = 50,
      ingredients = {{"automation-science-pack", 1},  {"logistic-science-pack", 1}},
	  
      time = 30
    },
    order = "a-h-a"
  },
  
  
	------------------------------------------ GLASS PROCESSING ------------------------------------------
{
    type = "technology",
    name = "glass-processing",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/glass-processing.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "glass-plate"
      },
    },

    -- unit =
    -- {
      -- count = 50,
      -- ingredients = {{"automation-science-pack", 1}},
      -- time = 5
    -- },
	
	research_trigger =
		{
		  type = "mine-entity",
		  entity = "sand-ore",
		},
    order = "c-a"
  },
	------------------------------------------ STORAGE 1 ------------------------------------------
 {
    type = "technology",
    name = "storage-1",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/storage-1.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "storage-hut"
      },
    },
    prerequisites = {"steel-processing","advanced-material-processing","logistic-science-pack"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "a-b-c"
  },
  	------------------------------------------ STORAGE 2 ------------------------------------------
 {
    type = "technology",
    name = "storage-2",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/storage-2.png",
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "warehouse"
      }
    },
    prerequisites = {"storage-1","concrete"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "a-b-c"
  },
  	------------------------------------------ LOGISTICS STORAGE 3 ------------------------------------------
 {
    type = "technology",
    name = "storage-3",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/storage-logistics-1.png",
    effects =
    {
	   {
        type = "unlock-recipe",
        recipe = "logistic-storage-hut"
      },
	  {
        type = "unlock-recipe",
        recipe = "logistic-passive-provider-hut"
      }
    },
    prerequisites = {"storage-1", "logistic-robotics", "advanced-circuit"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "a-b-c"
  },
    	------------------------------------------ LOGISTICS STORAGE 4 ------------------------------------------
 {
    type = "technology",
    name = "storage-4",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/storage-logistics-2.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "logistic-warehouse"
      },
	  {
        type = "unlock-recipe",
        recipe = "logistic-warehouse-passive-provider"
      },
    },
    prerequisites = {"storage-2"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "a-b-c"
  },
  
      	------------------------------------------ LOGISTICS STORAGE 5 ------------------------------------------
{
    type = "technology",
    name = "storage-5",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/storage-logistics-3.png",
    effects =
    {
	   {
        type = "unlock-recipe",
        recipe = "logistic-active-provider-hut"
      },
	  {
        type = "unlock-recipe",
        recipe = "logistic-buffer-hut"
      },
	   {
        type = "unlock-recipe",
        recipe = "logistic-requester-hut"
      }
    },
    prerequisites = {"storage-3","logistic-system"},
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"utility-science-pack", 1},
      },
      time = 30
    },
    order = "a-b-c"
  },
  
      	------------------------------------------ LOGISTICS STORAGE 6 ------------------------------------------
 {
    type = "technology",
    name = "storage-6",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/storage-logistics-4.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "logistic-warehouse-active-provider"
      },
	  {
        type = "unlock-recipe",
        recipe = "logistic-warehouse-buffer"
      },
	  {
        type = "unlock-recipe",
        recipe = "logistic-warehouse-requester"
      },
    },
    prerequisites = {"storage-4","logistic-system"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"utility-science-pack", 1},
      },
      time = 30
    },
    order = "a-b-c"
  },
	------------------------------------------ MASS PRODUCTION ------------------------------------------
 {
    type = "technology",
    name = "mass-production",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/mass-production.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "factory-large"
      }
    },
    prerequisites = {"logistics-3","productivity-module-3", "production-science-pack","computing-units"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
        {"production-science-pack", 1}
      },
      time = 60
    },
    order = "a-b-c"
  },
   ------------------------------------------ SOLAR TRAINS ------------------------------------------
	{
    type = "technology",
    name = "solar-train",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/train-solar.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "solar-train"
      }
    },
	prerequisites = {"solar-energy", "electric-energy-accumulators", "railway"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 30
    },
    order = "a-d-d"
	},
	------------------------------------------ EQUIPMENT WAGON ------------------------------------------
	{
    type = "technology",
    name = "equipment-wagon",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/equipment-wagon.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "cargo-wagon-equipment"
      }
    },
	prerequisites = {"modular-armor", "railway"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "a-d-d"
	},
})
	  ------------------------------------------ SOLAR ENERGY 1 ------------------------------------------
	  
table.insert(data.raw["technology"]["solar-energy"].prerequisites, "glass-processing" )

data.extend({	  
   ------------------------------------------ SOLAR ENERGY 2 ------------------------------------------
	{
    type = "technology",
    name = "solar-energy-2",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/solar_2.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "solar-array"
      }
    },
	prerequisites = {"solar-energy", "electric-energy-accumulators", "advanced-circuit","chemical-science-pack"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
      },
      time = 30
    },
    order = "a-d-d"
	},
	 ------------------------------------------ SOLAR ENERGY 3 ------------------------------------------
	{
    type = "technology",
    name = "solar-energy-3",
    icon_size = 256,
    icon =  "__factorioplus__/graphics/technology/solar_3.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "solar-array-2"
      }
    },
	prerequisites = {"solar-energy-2", "electric-energy-accumulators-2", "advanced-circuit","production-science-pack"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"production-science-pack", 1},
      },
      time = 30
    },
    order = "a-d-d"
	},
  ------------------------------------------ ACCUMULATOR 2 ------------------------------------------
	{
    type = "technology",
    name = "electric-energy-accumulators-2",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/battery_2.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "accumulator-battery"
      },
	   {
        type = "worker-robot-battery",
        modifier = 0.5
      },
	   {
        type = "follower-robot-lifetime",
        modifier = 0.5
      },
    },
	prerequisites = {"electric-energy-accumulators", "chemical-science-pack"},
    unit =
    {
      count = 300,
      ingredients =
      {
         {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1}
      },
      time = 30
    },
    order = "a-d-d"
	},
	 ------------------------------------------ ACCUMULATOR 3 ------------------------------------------
	{
    type = "technology",
    name = "electric-energy-accumulators-3",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/battery_3.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "adv-accumulator-battery"
      },
	  {
        type = "worker-robot-battery",
        modifier = 0.5
      },
	   {
        type = "follower-robot-lifetime",
        modifier = 0.5
      },
    },
	prerequisites = {"electric-energy-accumulators-2", "processing-unit", "utility-science-pack"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"utility-science-pack", 1}
      },
      time = 30
    },
    order = "a-d-d"
	},
	------------------------------------------ MINITURIZATION ------------------------------------------
	{
    type = "technology",
    name = "miniturization",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/miniturization-1.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "mini-assembling-machine-1"
      },
	   {
        type = "character-crafting-speed",
        modifier = 1
      },
    },
	prerequisites = {"steel-processing", "efficiency-module", "automation-2"},
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 35
    },
    order = "a-d-d"
	},
	
	------------------------------------------ MINITURIZATION 2------------------------------------------
	{
    type = "technology",
    name = "miniturization-2",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/miniturization-2.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "mini-roboport"
      },
	  {
        type = "unlock-recipe",
        recipe = "mini-electric-furnace"
      },
	   {
        type = "character-crafting-speed",
        modifier = 1
      },
    },
	prerequisites = {"miniturization", "construction-robotics", "advanced-material-processing-2"},
    unit =
    {
      count = 350,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
      },
      time = 45
    },
    order = "a-d-d"
	},
	------------------------------------------ METAL PRESS ------------------------------------------
	{
    type = "technology",
    name = "metal-pressing",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/hpmp.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "metal-press-machine"
      },
	  {
        type = "unlock-recipe",
        recipe = "stone-crushing"
      }
    },
	prerequisites = {"productivity-module-2", "efficiency-module-2", "miniturization"},
    unit =
    {
      count = 350,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
      },
      time = 45
    },
    order = "a-d-d"
	},
	------------------------------------------ LANDFILL 2 ------------------------------------------
	 {
    type = "technology",
    name = "landfill-2",
    icon_size = 128,
    icon = "__factorioplus__/graphics/technology/landfill-2.png",
    prerequisites = {"landfill","cliff-explosives","chemical-science-pack","concrete"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
      },
      time = 45
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "waterfill-barrel"
      },
	  {
        type = "unlock-recipe",
        recipe = "landfill-deep"
      }
    },
    order = "b-d"
  },
  
   ------------------------------------------ POWER TOOLS 1 ------------------------------------------
  {
    type = "technology",
    name = "upgraded-tools",
    icon_size = 128,
    icon = "__factorioplus__/graphics/technology/powertools-1.png",
    effects =
    {
	  {
        type = "character-mining-speed",
        modifier = 0.5
      },
	  {
        type = "character-build-distance",
        modifier = 2
      },
	  {
        type = "character-reach-distance",
        modifier = 2
      },
	   {
        type = "character-loot-pickup-distance",
        modifier = 0.5
      },
	   {
        type = "character-resource-reach-distance",
        modifier = 0.5
      },
    },
    prerequisites = {"toolbelt","steel-axe"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 15
    },
    order = "a-d-b"
  },
  ------------------------------------------ POWER TOOLS 2 ------------------------------------------
  {
    type = "technology",
    name = "advanced-repair-kits",
    icon_size = 128,
    icon = "__factorioplus__/graphics/technology/powertools-1.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "repair-pack-advanced"
      },
	  {
        type = "character-mining-speed",
        modifier = 1
      },
	  {
        type = "character-build-distance",
        modifier = 4
      },
	  {
        type = "character-reach-distance",
        modifier = 4
      },
	   {
        type = "character-loot-pickup-distance",
        modifier = 0.5
      },
	   {
        type = "character-resource-reach-distance",
        modifier = 0.5
      },
    },
    prerequisites = {"lubricant","advanced-circuit","upgraded-tools"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
      },
      time = 15
    },
    order = "a-d-b"
  },
   ------------------------------------------ POWER TOOLS 2 ------------------------------------------
  {
    type = "technology",
    name = "portable-drill",
    icon_size = 128,
    icon = "__factorioplus__/graphics/technology/powertools-2.png",
    effects =
    {
      {
        type = "character-mining-speed",
        modifier = 1
      },
	   {
        type = "character-build-distance",
        modifier = 4
      },
	  {
        type = "character-reach-distance",
        modifier = 4
      },
	   {
        type = "character-loot-pickup-distance",
        modifier = 0.5
      },
	   {
        type = "character-resource-reach-distance",
        modifier = 0.5
      },
    },
    prerequisites = {"advanced-repair-kits", "utility-science-pack"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 30
    },
    order = "c-c-a"
  },
  
   ------------------------------------------ POWER TOOLS 3 ------------------------------------------
   
   {
    type = "technology",
    name = "power-tools-upgrade",
    icon_size = 128,
    icon = "__factorioplus__/graphics/technology/powertools-2.png",
    effects =
    {
      {
        type = "character-mining-speed",
        modifier = 1
      },
	   {
        type = "character-build-distance",
        modifier = 4
      },
	  {
        type = "character-reach-distance",
        modifier = 4
      },
	   {
        type = "character-loot-pickup-distance",
        modifier = 0.5
      },
	   {
        type = "character-resource-reach-distance",
        modifier = 0.5
      },
    },
    prerequisites = {"portable-drill"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
		{"production-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 30
    },
    order = "c-c-a"
  },
  
------------------------------------------ POWER TOOLS 4 ------------------------------------------
   
   {
    type = "technology",
    name = "super-power-tools-upgrade",
    icon_size = 128,
    icon = "__factorioplus__/graphics/technology/powertools-2.png",
    effects =
    {
      {
        type = "character-mining-speed",
        modifier = 1
      },
	   {
        type = "character-build-distance",
        modifier = 4
      },
	  {
        type = "character-reach-distance",
        modifier = 4
      },
	   {
        type = "character-loot-pickup-distance",
        modifier = 0.5
      },
	   {
        type = "character-resource-reach-distance",
        modifier = 0.5
      },
    },
    prerequisites = {"power-tools-upgrade","space-science-pack"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
		{"production-science-pack", 1},
        {"utility-science-pack", 1},
		{"space-science-pack", 1}
      },
      time = 30
    },
    order = "c-c-a"
  },
   ------------------------------------------ COMPRESSION TECH ------------------------------------------
  {
    type = "technology",
    name = "Compression-tech",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/compressor.png",
    effects =
    {
       {
        type = "unlock-recipe",
        recipe = "compressor"
       },
	   {
        type = "unlock-recipe",
        recipe = "steam-compression"
       },
	   {
        type = "unlock-recipe",
        recipe = "sulfer-compression"
       },
	   {
        type = "unlock-recipe",
        recipe = "stone-compression"
       },
    },
    prerequisites = {"metal-pressing", "production-science-pack"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1}
      },
      time = 30
    },
    order = "c-c-a"
  },
})
   ------------------------------------------ LOADERS 0 & 1 & 2 & 3 & 4 & 5 ------------------------------------------

if settings.startup["settings-loaders-active"].value then
data.extend({
 {
    type = "technology",
    name = "loaders-basic",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/basicloaders.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "basic-loader"
      }
    },
	 prerequisites = {"logistics-basic"},
    unit =
    {
      count = 50,
      ingredients = {{"automation-science-pack", 1}},
      time = 15
    },
    order = "a-f-a"
  },
      
	{
    type = "technology",
    name = "loaders",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/loaders.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "loader"
      }
    },
	 prerequisites = {"logistics", "loaders-basic"},
    unit =
    {
      count = 100,
      ingredients = {{"automation-science-pack", 1}},
      time = 15
    },
    order = "a-f-a"
  },
  
  {
    type = "technology",
    name = "loaders-2",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/fastloaders.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "fast-loader"
      }
    },
    prerequisites = {"logistics-2", "loaders"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "a-f-b"
  },
  
   {
    type = "technology",
    name = "loaders-3",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/expressloaders.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "express-loader"
      }
    },
    prerequisites = {"logistics-3", "loaders-2"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1}
      },
      time = 15
    },
    order = "a-f-c"
  },
  
   {
    type = "technology",
    name = "loaders-4",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/turboloaders.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "turbo-loader"
      },
    },
    prerequisites = {"logistics-4", "loaders-3"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
		{"utility-science-pack", 1}
      },
      time = 30
    },
    order = "a-f-c"
  },

{
    type = "technology",
    name = "loaders-5",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/supersonicloaders.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "supersonic-loader"
      },
    },
    prerequisites = {"logistics-5", "loaders-4"},
    unit =
    {
      count = 600,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
		{"utility-science-pack", 1},
		{"space-science-pack", 1}
      },
      time = 30
    },
    order = "a-f-c"
  },
})
end
  
  ------------------------------------------ LOGISTICS 4 ------------------------------------------
data.extend({ 
  {
    type = "technology",
    name = "logistics-4",
    icon_size = 128,
    icon = "__factorioplus__/graphics/technology/logistics-4.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "turbo-transport-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "turbo-underground-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "turbo-splitter"
      }
    },
    prerequisites = {"utility-science-pack", "logistics-3"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
		{"utility-science-pack", 1}
      },
      time = 30
    },
    order = "a-f-c"
  },
  
    ------------------------------------------ LOGISTICS 5 ------------------------------------------
  
  {
    type = "technology",
    name = "logistics-5",
    icon_size = 128,
    icon = "__factorioplus__/graphics/technology/logistics-5.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "supersonic-transport-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "supersonic-underground-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "supersonic-splitter"
      }
    },
    prerequisites = {"space-science-pack", "logistics-4"},
    unit =
    {
      count = 600,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
		{"utility-science-pack", 1},
		{"space-science-pack", 1}
      },
      time = 30
    },
    order = "a-f-c"
  },
  
  ------------------------------------------ ELECTRIC DISTRO 3 ------------------------------------------
  
   {
    type = "technology",
    name = "electric-energy-distribution-3",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/electro_distro_3.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "electrical-distributor"
      },
	  {
        type = "unlock-recipe",
        recipe = "huge-electric-pole"
      }
    },
    prerequisites = {"electric-energy-distribution-2", "advanced-circuit", "production-science-pack"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
		{"production-science-pack", 1}
      },
      time = 45
    },
    order = "c-e-c"
  },
  
  ------------------------------------------ ATTACK CAR ------------------------------------------
  {
    type = "technology",
    name = "automobilism-military-1",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/automobilism.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "car"
      },
	  {
        type = "unlock-recipe",
        recipe = "car-shotgun"
      }
    },
    prerequisites = {"automobilism", "military-science-pack"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"military-science-pack", 1}
      },
      time = 30
    },
    order = "e-b"
  }, 
   {
    type = "technology",
    name = "automobilism-military-2",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/automobilism-2-military.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "apc-rocket"
      },
	   {
        type = "unlock-recipe",
        recipe = "apc-twinsmg"
      },
	   {
        type = "unlock-recipe",
        recipe = "apc-autoshotgun"
      },
	  
    },
    prerequisites = {"automobilism-2"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"military-science-pack", 1}
      },
      time = 30
    },
    order = "e-b"
  },
  
    ------------------------------------------ AUTOMOBILISM 2 & 3 ------------------------------------------
	
    {
    type = "technology",
    name = "automobilism-2",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/automobilism-2.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "dozer"
      },
	  {
        type = "unlock-recipe",
        recipe = "apc-base"
      },
	  {
        type = "unlock-recipe",
        recipe = "transporter"
      },
	  {
        type = "unlock-recipe",
        recipe = "hovercraft"
      },
    },
    prerequisites = {"automobilism", "steel-processing"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "e-b"
  },
  {
    type = "technology",
    name = "automobilism-3",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/automobilism-3.png",
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "scout"
      }
    },
    prerequisites = {"automobilism-2", "electric-engine", "speed-module"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1}
      },
      time = 30
    },
    order = "e-b"
  },
  
  ------------------------------------------ CONSTRUCTION ROBOTICS 2 ------------------------------------------
  
  {
    type = "technology",
    name = "construction-robotics-2",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/super-roboport.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "roboport-major"
      },
    },
    prerequisites = {"construction-robotics","electric-energy-accumulators-2", "advanced-circuit", "utility-science-pack"},
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
		{"utility-science-pack", 1},
      },
      time = 45
    },
    order = "c-k-a"
  },
  
  ------------------------------------------ GAS EXTRACTION & PROCESSING ------------------------------------------
  
   {
    type = "technology",
    name = "gas-extraction",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/extractors.png",
    prerequisites = {"fluid-handling"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "gas-extractor"
      },
    },
    unit =
    {
      count = 100,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
      time = 30
    },
    order = "d-a"
  },
  {
    type = "technology",
    name = "gas-processing",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/gas-processing.png",
    prerequisites = {"gas-extraction"},
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "oil-refinery"
      },
      {
        type = "unlock-recipe",
        recipe = "chemical-plant"
      },
	  {
        type = "unlock-recipe",
        recipe = "basic-natural-gas-processing"
      },
      {
        type = "unlock-recipe",
        recipe = "nat-gas-fuel"
      },
	  {
        type = "unlock-recipe",
        recipe = "petroleum-fuel"
      },

    },
	    research_trigger =
    {
      type = "mine-entity",
      entity = "natural-gas"
    },
    -- unit =
    -- {
      -- count = 200,
      -- ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
      -- time = 30
    -- },
    order = "d-a",
  },


	{
    type = "technology",
    name = "fluid-handling-advanced",
    icon = "__factorioplus__/graphics/technology/largefluidtank.png",
    icon_size = 256,
    prerequisites = {"fluid-handling", "concrete", "chemical-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "storage-tank-large"
      },
    },
    unit =
    {
      count = 50,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1} },
      time = 15
    }
	},
  
}) 
  ------------------------------------------ TRUE ROCKET FUEL ------------------------------------------
  
  if (mods["space-age"]) then
  
   data.extend({ 
 {
    type = "technology",
    name = "true-rocket-fuel",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/truerocketfuel.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "true-rocket-fuel"
      }
    },
    prerequisites = {"explosives", "rocket-fuel"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 45
    },
    order = "k-a"
  }
}) 

else
 
 data.extend({ 
 {
    type = "technology",
    name = "true-rocket-fuel",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/truerocketfuel.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "true-rocket-fuel"
      }
    },
    prerequisites = {"explosives", "rocket-fuel", "utility-science-pack"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
		{"utility-science-pack", 1},
      },
      time = 45
    },
    order = "k-a"
  }
}) 
end

  
 
  
  ------------------------------------------ GRINDERS ------------------------------------------
 data.extend({  
  {
    type = "technology",
    name = "mining-grinders",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/grinders.png",
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "electric-grinder"
      }
    },
    prerequisites = {"efficiency-module","productivity-module","mining-productivity-1"},
    unit =
    {
      count = 150,
      ingredients =
      {
         {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 60
    },
    order = "c-k-f-e"
  },
  
    
  ------------------------------------------ HEAT PIPE FURNACE------------------------------------------
  
  {
    type = "technology",
    name = "heatpipe-furnace",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/heatpipe-furnaces.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "heatpipe-furnace"
      },
         },
    prerequisites = {"nuclear-power","advanced-material-processing-2"},
    unit =
    {
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30,
      count = 400
    },
    order = "e-p-b-c"
  },
  })
  

	
  ------------------------------------------ NUKE POWER OVERRIDE ------------------------------------------
  
table.insert(data.raw["technology"]["sulfur-processing"].effects, { type = "mining-with-fluid", modifier = true} )
  
data.raw["technology"]["nuclear-power"].effects = 
{
  {
	type = "unlock-recipe",
	recipe = "nuclear-reactor"
  },
  {
	type = "unlock-recipe",
	recipe = "heat-exchanger"
  },
  {
	type = "unlock-recipe",
	recipe = "heat-pipe"
  },
  {
	type = "unlock-recipe",
	recipe = "uranium-fuel-cell"
  },
}

data.raw["technology"]["nuclear-power"].prerequisites = 
{"uranium-processing","steam-turbines"}

data.extend({
  
  ------------------------------------------ STEAM TURBINES ------------------------------------------
  
  {
    type = "technology",
    name = "steam-turbines",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/steamturbine.png",
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "steam-turbine"
      }
    },
    prerequisites = {"gas-extraction","lubricant"},
    unit =
    {
      count = 250,
      ingredients =
      {
         {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1}
      },
      time = 60
    },
    order = "c-k-f-e"
  },
  
  ------------------------------------------ STEAM POWERED MINING ------------------------------------------
  
  {
    type = "technology",
    name = "steam-powered-mining",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/steam_mining.png",
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "steam-turbine-miner"
      }
    },
    prerequisites = {"steam-turbines","mining-productivity-2",},
    unit =
    {
      count = 350,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1}
      },
      time = 60
    },
    order = "c-k-f-e"
  },
  ------------------------------------------ ADVANCED PUMP ------------------------------------------
  {
    type = "technology",
    name = "advanced-pumping",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/large-pump.png",
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "offshore-pump-large"
      }
    },
    prerequisites = {"electric-engine"},
    unit =
    {
      count = 150,
      ingredients =
      {
         {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    order = "c-k-f-e"
  },
  ------------------------------------------ BACKPACK STORAGE ------------------------------------------
    {
    type = "technology",
    name = "backpack-storage",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/backpack-storage.png",
    prerequisites = {"toolbelt","steel-processing"},
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "backpack"
      },
    },
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 45
    },
    order = "c-k-m"
  },
  
  {
    type = "technology",
    name = "backpack-storage-2",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/backpack-storage.png",
    prerequisites = {"backpack-storage","modular-armor","chemical-science-pack"},
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "backpack-2"
      },
    },
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1}
      },
      time = 45
    },
    order = "c-k-m"
  },
  {
    type = "technology",
    name = "toolbelt-2",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_capacity("__base__/graphics/technology/toolbelt.png"),
    prerequisites = {"toolbelt","chemical-science-pack"},
    effects =
    {
      {
        type = "character-inventory-slots-bonus",
        modifier = 10
      }
    },
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1}
      },
      time = 45
    },
    order = "c-k-m"
  },
   {
    type = "technology",
    name = "toolbelt-3",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_capacity("__base__/graphics/technology/toolbelt.png"),
    prerequisites = {"toolbelt-2","production-science-pack" },
    effects =
    {
      {
        type = "character-inventory-slots-bonus",
        modifier = 10
      }
    },
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"production-science-pack", 1},
      },
      time = 60
    },
    order = "c-k-m"
  },
     {
    type = "technology",
    name = "toolbelt-4",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_capacity("__base__/graphics/technology/toolbelt.png"),
    prerequisites = {"toolbelt-3","utility-science-pack"},
    effects =
    {
      {
        type = "character-inventory-slots-bonus",
        modifier = 10
      }
    },
    unit =
    {
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"production-science-pack", 1},
		 {"utility-science-pack", 1}
      },
      time = 60
    },
    order = "c-k-m"
  },
  ------------------------------------------ SNIPER TOWERS ------------------------------------------
  {
    type = "technology",
    name = "sniper-turrets",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/sniper-towers.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "sniper-turret"
      },

    },
    prerequisites = {"military-4"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 30
	  },
    order = "e-a-b"
  },
  
  ------------------------------------------ GAUSS CANNONS ------------------------------------------
  
   {
    type = "technology",
    name = "large-laser-turrets",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/gauss-turrets.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "large-laser-turret"
      },

    },
    prerequisites = {"military-5", "laser-turret", "electric-energy-accumulators-2"},
    unit =
    {
      count = 750,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
		{"utility-science-pack", 1}
      },
      time = 45
	  },
    order = "e-a-b"
  },
  
  ------------------------------------------ FISHING ------------------------------------------
  
  {
    type = "technology",
    name = "fish-processing",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/fish-processing.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "fish-processing"
      }
    },
	prerequisites = {"automation-2"},
    unit =
    {
      count = 50,
      ingredients = 
	  {
	  {"automation-science-pack", 1},
	  {"logistic-science-pack", 1},
	  },
      time = 20
    },
    order = "a-h-a"
  },
  

  
})
------------------------------------------------------------------------------------
------------------------------------------ OVERRIDES / EXTENDINGS / CHANGES ------------------------------------------
------------------------------------------------------------------------------------

-- REPLACE ENTRY data.raw["electric-pole"]["big-electric-pole"].maximum_wire_distance = 32
-- INSERT ENTRY table.insert(data.raw["technology"]["advanced-circuit"].effects,{type = "unlock-recipe",recipe = "silicon-wafer"})
  
table.insert(data.raw["technology"]["logistics-2"].effects,{type = "unlock-recipe",recipe = "very-long-handed-inserter"})
 
table.insert(data.raw["technology"]["steel-processing"].effects,{type = "unlock-recipe",recipe = "large-burner-mining-drill"})

-- table.insert(data.raw["technology"]["personal-roboport-mk2-equipment"].effects,{type = "unlock-recipe",recipe = "personal-long-range-roboport-equipment"})

  ------------------------------------------ OIL PROCESSING OVERRIDE ------------------------------------------

-- Remove the base game solid petrol fuel things

--table.removetablewithmatchingentry(data.raw["technology"]["oil-processing"].effects, "recipe", "solid-fuel-from-petroleum-gas")
data.raw["recipe"]["solid-fuel-from-petroleum-gas"].hidden = true
--data.raw["item"]["solid-fuel-from-petroleum-gas"].hidden = true 

-- Insert our own petrol vehicle fuel item.
table.insert(data.raw["technology"]["oil-processing"].effects,{type = "unlock-recipe",recipe = "petroleum-fuel"})

  
    ------------------------------------------ LOGISTIC SCIENCE PACK OVERRIDE ------------------------------------------
	
  data:extend
({
	{
    type = "technology",
    name = "logistic-science-pack",
    localised_name = {"technology-name.logistic-science-pack"},
    localised_description = {"technology-description.logistic-science-pack"},
    icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/logistic-science-pack.png",
	 prerequisites = {"logistics"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "logistic-science-pack"
      }
    },
    unit =
    {
      count = 75,
      ingredients = {{"automation-science-pack", 1}},
      time = 5
    },
    order = "c-a"
  },
  
   {
    type = "technology",
    name = "personal-longrangeroboport-equipment",
    icons = util.technology_icon_constant_equipment("__base__/graphics/technology/personal-roboport-equipment.png"),
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "personal-long-range-roboport-equipment"
      }
    },
    prerequisites = {"personal-roboport-equipment", "low-density-structure", "production-science-pack"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
		{"production-science-pack", 1},
      },
      time = 30
    }
  },
  
  {
    type = "technology",
    name = "personal-roboport-mk3-equipment",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_equipment("__base__/graphics/technology/personal-roboport-equipment.png"),
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "personal-roboport-mk3-equipment"
      },
    },
    prerequisites = { "personal-roboport-mk2-equipment", "production-science-pack", "construction-robotics-2", "computing-units"},
    unit =
    {
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"utility-science-pack", 1},
		{"production-science-pack", 1},
      },
      time = 30
    },
    order = "c-k-d-zz"
  },
  
})

table.insert(data.raw["technology"]["military"].effects,{type = "unlock-recipe",recipe = "basic-explosive"})

table.insert(data.raw["technology"]["military-2"].effects,{type = "unlock-recipe",recipe = "magnum"})
table.insert(data.raw["technology"]["military-2"].effects,{type = "unlock-recipe",recipe = "uzi-gun"})

table.removetablewithmatchingentry(data.raw["technology"]["electronics"].effects, "recipe", "lab") 
table.insert(data.raw["technology"]["electronics"].effects,{type = "unlock-recipe",recipe = "basic-lab"})
table.insert(data.raw["technology"]["electronics"].effects,{type = "unlock-recipe",recipe = "listening-post"})
table.insert(data.raw["technology"]["electronics"].effects,{type = "unlock-recipe",recipe = "pistol-turret"})
 
table.removetablewithmatchingentry(data.raw["technology"]["military-3"].effects, "recipe", "poison-capsule") 
table.removetablewithmatchingentry(data.raw["technology"]["military-3"].effects, "recipe", "slowdown-capsule") 
table.removetablewithmatchingentry(data.raw["technology"]["military-3"].effects, "recipe", "combat-shotgun") 
table.insert(data.raw["technology"]["military-3"].effects,{type = "unlock-recipe",recipe = "longrange-rounds-magazine"})
table.insert(data.raw["technology"]["military-3"].effects,{type = "unlock-recipe",recipe = "piercing-shotgun-shell"})
table.insert(data.raw["technology"]["military-3"].effects,{type = "unlock-recipe",recipe = "flak-grenade"})
table.insert(data.raw["technology"]["military-3"].effects,{type = "unlock-recipe",recipe = "blunderbuss"})



table.removeentry(data.raw["technology"]["military-3"].prerequisites, "chemical-science-pack") 
table.insert(data.raw["technology"]["military-3"].prerequisites,"military-2")

data.raw["technology"]["military-3"].unit =
 {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 20
    }
	
table.insert(data.raw["technology"]["distractor"].effects,{type = "unlock-recipe",recipe = "disruptor-capsule"})
table.insert(data.raw["technology"]["distractor"].effects,{type = "unlock-recipe",recipe = "denier-capsule"})

table.insert(data.raw["technology"]["gun-turret"].effects,{type = "unlock-recipe",recipe = "shotgun-turret"})
data.raw["technology"]["gun-turret"].icon = "__factorioplus__/graphics/technology/smg-turret.png"
data.raw["technology"]["gun-turret"].prerequisites = {"military"}

table.removetablewithmatchingentry(data.raw["technology"]["military-4"].effects, "recipe", "piercing-shotgun-shell") 


table.insert(data.raw["technology"]["military-4"].effects,{type = "unlock-recipe",recipe = "combat-shotgun"})
table.insert(data.raw["technology"]["military-4"].effects,{type = "unlock-recipe",recipe = "shotgun-shell-birdshot"})
table.insert(data.raw["technology"]["military-4"].effects,{type = "unlock-recipe",recipe = "sniper-rifle"})
table.insert(data.raw["technology"]["military-4"].effects,{type = "unlock-recipe",recipe = "sniper-shell"})


table.removeentry(data.raw["technology"]["military-4"].prerequisites, "utility-science-pack") 

table.insert(data.raw["technology"]["military-4"].prerequisites,"chemical-science-pack")

data.raw["technology"]["military-4"].unit =
{
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 30
}
  
  
data:extend
({ 	
  
  {
    type = "technology",
    name = "military-5",
     icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/military.png",
    effects =
    {

	  {
        type = "unlock-recipe",
        recipe = "rocket-micro"
      },
	    {
        type = "unlock-recipe",
        recipe = "cannon-shell-auto"
      },
	   {
        type = "unlock-recipe",
        recipe = "piercing-cannon-shell"
      },
      {
        type = "unlock-recipe",
        recipe = "he-grenade"
      },
	  {
        type = "unlock-recipe",
        recipe = "mini-gun"
      },
	   {
        type = "unlock-recipe",
        recipe = "chaingun-ammo"
      },
	   {
        type = "unlock-recipe",
        recipe = "sniper-shell-piercing"
      },


    },
    prerequisites = {"military-4", "utility-science-pack", "explosives"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 45
    },
    order = "e-a-e"
  },
  
  {
    type = "technology",
    name = "military-6",
     icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/military.png",
    effects =
    {
	   {
        type = "unlock-recipe",
        recipe = "chaingun-ammo-piercing"
      } ,
	  {
        type = "unlock-recipe",
        recipe = "mirv-grenade"
      },
	  	  {
        type = "unlock-recipe",
        recipe = "plasma-gun"
      },
	   {
        type = "unlock-recipe",
        recipe = "plasma-cell"
      },
	  {
        type = "unlock-recipe",
        recipe = "multirocket-launcher"
      },
    },
    prerequisites = {"military-5"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
		{"production-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 45
    },
    order = "e-a-e"
  },

})

data.raw["technology"]["laser"].effects = 
{
	{
		type = "unlock-recipe",
		recipe = "laser"
	},
}
 
-- data:extend
-- ({
  
-- {
    -- type = "technology",
    -- name = "laser",
     -- icon_size = 256, icon_mipmaps = 4,
    -- icon = "__base__/graphics/technology/laser.png",
	  -- effects =
    -- {
      -- {
        -- type = "unlock-recipe",
        -- recipe = "laser"
      -- },
    -- },
    -- prerequisites = {"lamp", "battery", "chemical-science-pack"},
    -- unit =
    -- {
      -- count = 100,
      -- ingredients =
      -- {
        -- {"automation-science-pack", 1},
        -- {"logistic-science-pack", 1},
        -- {"chemical-science-pack", 1}
      -- },
      -- time = 30
    -- },
    -- order = "a-h-b"
  -- },
  
-- })
 
 -- table.insert( data.raw["technology"]["lamp"].prerequisites = {"glass-processing"})
 
-- data.raw["technology"]["lamp"].prerequisites = {"glass-processing"}
--error("table : " .. serpent.block(data.raw["technology"]["lamp"].prerequisites ) )

 -- function table.addorreplaceifempty(t,v)
	-- if t then
	-- table.insert( t, v )	
	-- else
	-- t = v
	-- end
-- end

--table.addorreplaceifempty( data.raw["technology"]["lamp"].prerequisites , "glass-processing" )

--error("table block => " .. serpent.block(data.raw["technology"]["lamp"].prerequisites))

-- aai industry support -> check for glass processing.
if table.contains(data.raw["technology"]["lamp"].prerequisites,"glass-processing" ) then
	-- do nothing
	else
	if  data.raw["technology"]["lamp"].prerequisites then
		table.insert( data.raw["technology"]["lamp"].prerequisites, "glass-processing" )
		else
		data.raw["technology"]["lamp"].prerequisites = {"glass-processing"}
	end
end
 
 data:extend
({  

  
  {
    type = "technology",
    name = "computing-units",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/computing-unit.png",
    prerequisites = {"advanced-circuit","production-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "cpu-item"
      }
    },
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
		{"production-science-pack", 1}
      },
      time = 45
    },
    order = "a-d-c"
  },
    {
    type = "technology",
    name = "speed-module-4",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/speed-module-4.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "speed-module-4"
      }
    },
    prerequisites = {"speed-module-3","computing-units","utility-science-pack"},
    unit =
    {
      count = 600,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
		{"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "i-c-c"
  },
   {
    type = "technology",
    name = "productivity-module-4",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/productivity-module-4.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "productivity-module-4"
      }
    },
    prerequisites = {"productivity-module-3","computing-units","utility-science-pack"},
    unit =
    {
      count = 600,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
		{"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "i-e-c"
  },
  {
    type = "technology",
    name = "efficiency-module-4",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/efficiency-module-4.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "efficiency-module-4"
      }
    },
    prerequisites = {"efficiency-module-3","computing-units","utility-science-pack"},
    unit =
    {
      count = 600,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
		{"utility-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "i-g-c"
  },
 
})
 
table.insert(data.raw["technology"]["advanced-material-processing"].effects,{type = "unlock-recipe",recipe = "aluminium-plate"})  
 
 data:extend
({
  {
     type = "technology",
    name = "mass-smelting-1",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/mass-smelt-1.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "big-furnace"
      }
    },
    prerequisites = {"flammables"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 30
    },
    order = "c-c-b"
  },
  {
     type = "technology",
    name = "mass-smelting-2",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/mass-smelt-2.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "steel-forge"
      }
    },
    prerequisites = {"chemical-science-pack","advanced-material-processing"},
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
      },
      time = 40
    },
    order = "c-c-b"
  },
  {
     type = "technology",
    name = "mass-smelting-3",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/mass-smelt-3.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "electric-foundry"
      }
    },
    prerequisites = {"advanced-material-processing-2","concrete","speed-module-2","productivity-module-2","production-science-pack"},
    unit =
    {
      count = 350,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},
		{"production-science-pack", 1}
      },
      time = 30
    },
    order = "c-c-b"
  },
  
  {
    type = "technology",
    name = "logistics-basic",
     icon_size = 128, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/logistics-0.png",
	prerequisites = {"automation-science-pack"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "basic-underground-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "basic-splitter"
      },
	   {
        type = "unlock-recipe",
        recipe = "long-handed-burner-inserter"
      },
    },
    unit =
    {
      count = 25,
      ingredients = {{"automation-science-pack", 1}},
      time = 15
    },
    order = "a-f-a"
  },
})

data.raw["technology"]["logistics"].unit = { count = 100, ingredients = { {"automation-science-pack", 1}, }, time = 20 }
data.raw["technology"]["logistics"].prerequisites = {"logistics-basic"}
table.insert(data.raw["technology"]["logistics"].effects,{type = "unlock-recipe",recipe = "transport-belt"})  
 
table.removeentry(data.raw["technology"]["railway"].prerequisites, "logistics-2")  

table.insert(data.raw["technology"]["railway"].prerequisites,"logistics")  

data:extend
({


  {
    type = "technology",
    name = "sawmills",
     icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/sawmills.png",
	prerequisites = {"electronics"},
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "electric-sawmill"
      },
    },
	unit =
    {
      count = 10,
      ingredients = {{"automation-science-pack", 1}},
      time = 15
    },
	-- research_trigger =
		-- {
		  -- type = "mine-entity",
		  -- entity = "forest",
		-- },
    order = "a-f-a"
  },
  

  {
    type = "technology",
    name = "lab",
     icon_size = 256, icon_mipmaps = 4,
    icon = "__base__/graphics/technology/research-speed.png",
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "lab"
      },
    },
	prerequisites = {"research-speed-2", "advanced-circuit"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 30
    },
    order = "a-f-a"
  },
  
   {
    type = "technology",
    name = "advanced-lab",
     icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/large-lab.png",
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "lab-large"
      },
    },
	prerequisites = {"logistics-3","lab","processing-unit"},
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1}
      },
      time = 30
    },
    order = "a-f-a"
  },
  
  {
    type = "technology",
    name = "basic-electric-energy-distribution",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/electro_distro_basic.png",
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "medium-wooden-electric-pole"
      },
    },
    prerequisites = {"electronics"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
      },
      time = 30
    },
    order = "c-e-b"
  },
  
   {
    type = "technology",
    name = "basic-electric-furnace",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/basic-electric-furnace.png",
    effects =
    {
	  {
        type = "unlock-recipe",
        recipe = "basic-electric-furnace"
      },
    },
    prerequisites = {"advanced-material-processing","electric-energy-distribution-1"},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
		{"logistic-science-pack", 1},
      },
      time = 30
    },
    order = "c-e-b"
  },
  
  
})

-- data.raw["technology"]["logistics"].unit = { count = 100, ingredients = { {"automation-science-pack", 1}, }, time = 20 }
-- data.raw["technology"]["logistics"].prerequisites = {"logistics-basic"}
-- table.insert(data.raw["technology"]["logistics"].effects,{type = "unlock-recipe",recipe = "transport-belt"});  



data.raw["technology"]["electric-energy-distribution-1"].unit = 
{ 
count = 150, ingredients = 
	{ 
	{"automation-science-pack", 1},{"logistic-science-pack", 1}, 
	}, 
	time = 30 	
}

table.removeentry(data.raw["technology"]["electric-energy-distribution-1"].prerequisites, "electronics")  
table.insert(data.raw["technology"]["electric-energy-distribution-1"].prerequisites,"basic-electric-energy-distribution")

table.insert(data.raw["technology"]["automobilism"].prerequisites,"automobilism-basic")
table.removeentry(data.raw["technology"]["automobilism"].prerequisites, "logistics-2")  
data.raw["technology"]["automobilism"].effects = 
 {
	  {
        type = "unlock-recipe",
        recipe = "vehicle-chassis"
      },
	  {
        type = "unlock-recipe",
        recipe = "car-base"
      },
}

data:extend
({

   {
    type = "technology",
    name = "automobilism-basic",
     icon_size = 256, icon_mipmaps = 4,
    icon = "__factorioplus__/graphics/technology/automobilism-basic.png",
    effects =
    {
	{
        type = "unlock-recipe",
        recipe = "atv"
      },
    },
    prerequisites = {"steel-processing","logistic-science-pack"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 15
    },
    order = "e-b"
  },
  
  })

table.removetablewithmatchingentry(data.raw["technology"]["tank"].effects, "recipe", "cannon-shell") 
table.removetablewithmatchingentry(data.raw["technology"]["tank"].effects, "recipe", "explosive-cannon-shell") 

table.insert(data.raw["technology"]["tank"].effects,
	{
		type = "unlock-recipe",
		recipe = "flame-tank"
	}
)

table.insert(data.raw["technology"]["tank"].prerequisites,"cannons")
  
table.insert(data.raw["technology"]["gun-turret"].effects,
	{
		type = "unlock-recipe",
		recipe = "turret-base"
	}
)  

-- Update power armor mk2 tech req
table.removeentry(data.raw["technology"]["power-armor-mk2"].prerequisites, "military-4") 
table.insert(data.raw["technology"]["power-armor-mk2"].prerequisites,"military-5")


-- Updated Rocket Turrets and Space age

data:extend
({    

	{
		type = "technology",
		name = "rocket-turret",
		 icon_size = 256, icon_mipmaps = 4,
		icon = "__factorioplus__/graphics/technology/rocket-turret.png",
		effects =
		{
		  {
			type = "unlock-recipe",
			recipe = "rocket-turret"
		  }, 
		},
		prerequisites = {"rocketry"},
		unit =
		{
		  count = 200,
		  ingredients =       
		  {
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
			{"military-science-pack", 1}
		  },
		  time = 30
		},
		order = "a-j-a"
	}
})


if (mods["space-age"]) then
data:extend
({    
	{
    type = "technology",
    name = "rocket-battery",
    icon = "__space-age__/graphics/technology/rocket-turret.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rocket-battery"
      },
      {
        type = "unlock-recipe",
        recipe = "coal-synthesis"
      }
    },
    prerequisites = {"rocket-turret", "carbon-fiber", "stronger-explosives-2"},
    unit =
    {
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"agricultural-science-pack", 1}
      },
      time = 30,
      count = 1000
    }
  },
})
end

 
data:extend
({    
  
  {
    type = "technology",
    name = "cannons",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/cannons.png",
    effects =
    {

      {
        type = "unlock-recipe",
        recipe = "cannon-shell"
      },
	  {
        type = "unlock-recipe",
        recipe = "cannon"
      },
	  {
        type = "unlock-recipe",
        recipe = "cannon-turret"
      },
    },
    prerequisites = { "military-4", "explosives"},
    unit =
    {
      count = 250,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1}
      },
      time = 30
    },
    order = "e-c-c"
  },
  
    {
    type = "technology",
    name = "heavy-gun-turrets",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/heavy-smg-turret.png",
    effects =
    {

      {
        type = "unlock-recipe",
        recipe = "heavygun-turret",
      },
    },
    prerequisites = { "military-4", "chemical-science-pack"},
    unit =
    {
       count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
      },
      time = 45
    },
    order = "e-c-c"
  },
  
  {
    type = "technology",
    name = "chaingun-turrets",
    icon_size = 256,
    icon = "__base__/graphics/technology/gun-turret.png",
    effects =
    {

      {
        type = "unlock-recipe",
        recipe = "chaingun-turret"
      },
    },
    prerequisites = { "military-5", "tank"},
    unit =
    {
       count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 45
    },
    order = "e-c-c"
  },
  
})

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
------------------------------------------ OVERRIDE BASE GAME ------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

------------------------------------------ OVERRIDE ROCKET SILO ------------------------------------------

-- Switch out Old rocket fuel (now jet fuel) with True Rocket fuel
table.removeentry(data.raw["technology"]["rocket-silo"].prerequisites, "rocket-fuel")
table.insert(data.raw["technology"]["rocket-silo"].prerequisites, "true-rocket-fuel")

------------------------------------------ OVERRIDE MODULES ------------------------------------------


data.raw["technology"]["modules"].prerequisites = { "plastics", "electronics"}
  
data.raw["technology"]["automation-science-pack"].research_trigger = 
{
  type = "craft-item",
  item = "iron-gear-wheel",
  count = 20,
}

  
------------------------------------------ OVERRIDE ENERGY WEAPONS DAMAGE------------------------------------------

data.raw["technology"]["laser-weapons-damage-1"].effects = 
{ 
	{
		type = "ammo-damage",
		ammo_category = "laser",
		modifier = 0.1
	 }
 }
 
data.raw["technology"]["laser-weapons-damage-2"].effects = 
{ 
	{
		type = "ammo-damage",
		ammo_category = "laser",
		modifier = 0.1
	 }
 }

 
data.raw["technology"]["laser-weapons-damage-3"].effects = 
{ 
	{
		type = "ammo-damage",
		ammo_category = "laser",
		modifier = 0.1
	 }
 }
 
data.raw["technology"]["laser-weapons-damage-4"].effects = 
{ 
	{
		type = "ammo-damage",
		ammo_category = "laser",
		modifier = 0.1
	 }
 }
 
data.raw["technology"]["laser-weapons-damage-5"].effects = 
{ 
	{
		type = "ammo-damage",
		ammo_category = "laser",
		modifier = 0.1
	 },
	 {
        type = "ammo-damage",
        ammo_category = "beam",
        modifier = 0.1
      }
 }
 
data.raw["technology"]["laser-weapons-damage-6"].effects = 
{ 
	{
		type = "ammo-damage",
		ammo_category = "laser",
		modifier = 0.1
	 },
	 {
        type = "ammo-damage",
        ammo_category = "beam",
        modifier = 0.1
      },
	   {
        type = "ammo-damage",
        ammo_category = "plasma-cell",
        modifier = 0.1
      },
	  {
        type = "ammo-damage",
        ammo_category = "beam",
        modifier = 0.1
      }
 }
 
 data.raw["technology"]["laser-weapons-damage-7"].effects = 
{ 
	{
		type = "ammo-damage",
		ammo_category = "laser",
		modifier = 0.1
	 },
	 {
        type = "ammo-damage",
        ammo_category = "beam",
        modifier = 0.1
      },
	   {
        type = "ammo-damage",
        ammo_category = "plasma-cell",
        modifier = 0.1
      },
	  {
        type = "ammo-damage",
        ammo_category = "beam",
        modifier = 0.1
      }
 }


------------------------------------------ OVERRIDE ENERGY WEAPONS SPEED------------------------------------------

data.raw["technology"]["laser-shooting-speed-1"].effects = 
{ 
	 {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.2
      }
 }
 
 data.raw["technology"]["laser-shooting-speed-2"].effects = 
{ 
	 {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.2
      }
 }
 
  data.raw["technology"]["laser-shooting-speed-3"].effects = 
{ 
	 {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.2
      },
	  
 }
 
  data.raw["technology"]["laser-shooting-speed-4"].effects = 
{ 
	 {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.2
      },
	    {
        type = "gun-speed",
        ammo_category = "plasma-cell",
        modifier = 0.2
      },
	  {
        type = "gun-speed",
        ammo_category = "beam",
        modifier = 0.2
      }
 }
 
   data.raw["technology"]["laser-shooting-speed-5"].effects = 
{ 
	 {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.2
      },
	    {
        type = "gun-speed",
        ammo_category = "plasma-cell",
        modifier = 0.2
      },
	  {
        type = "gun-speed",
        ammo_category = "beam",
        modifier = 0.2
      }
 }
 
   data.raw["technology"]["laser-shooting-speed-6"].effects = 
{ 
	 {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.2
      },
	    {
        type = "gun-speed",
        ammo_category = "plasma-cell",
        modifier = 0.2
      },
	  {
        type = "gun-speed",
        ammo_category = "beam",
        modifier = 0.2
      }
 }

  data.raw["technology"]["laser-shooting-speed-7"].effects = 
{ 
	 {
        type = "gun-speed",
        ammo_category = "laser",
        modifier = 0.2
      },
	    {
        type = "gun-speed",
        ammo_category = "plasma-cell",
        modifier = 0.2
      },
	  {
        type = "gun-speed",
        ammo_category = "beam",
        modifier = 0.2
      }
 }
 
------------------------------------------ OVERRIDE EXPLOSIVE DAMAGE------------------------------------------


data.raw.technology["stronger-explosives-1"].effects = 
 {
	{
	  type = "ammo-damage",
	  ammo_category = "grenade",
	  modifier = 0.2
	}
}

data.raw.technology["stronger-explosives-2"].effects = 
{
  {
	type = "ammo-damage",
	ammo_category = "grenade",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "landmine",
	modifier = 0.2
  }
}

data.raw.technology["stronger-explosives-3"].effects = 
{
  {
	type = "ammo-damage",
	ammo_category = "rocket",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "grenade",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "grenade-shell",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "landmine",
	modifier = 0.2
  }
}

data.raw.technology["stronger-explosives-4"].effects = 
{
  {
	type = "ammo-damage",
	ammo_category = "rocket",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "grenade",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "grenade-shell",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "landmine",
	modifier = 0.2
  },
   {
	type = "ammo-damage",
	ammo_category = "cannon-shell",
	modifier = 0.2
  },
}
 
data.raw.technology["stronger-explosives-5"].effects = 
{
  {
	type = "ammo-damage",
	ammo_category = "rocket",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "grenade",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "grenade-shell",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "landmine",
	modifier = 0.2
  },
   {
	type = "ammo-damage",
	ammo_category = "cannon-shell",
	modifier = 0.2
  },
}

data.raw.technology["stronger-explosives-6"].effects = 
{
  {
	type = "ammo-damage",
	ammo_category = "rocket",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "grenade",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "grenade-shell",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "landmine",
	modifier = 0.2
  },
   {
	type = "ammo-damage",
	ammo_category = "cannon-shell",
	modifier = 0.2
  },
}

data.raw.technology["stronger-explosives-7"].effects = 
{
  {
	type = "ammo-damage",
	ammo_category = "rocket",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "grenade",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "grenade-shell",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "landmine",
	modifier = 0.2
  },
   {
	type = "ammo-damage",
	ammo_category = "cannon-shell",
	modifier = 0.2
  },
}

------------------------------------------ OVERRIDE FIRE DAMAGE------------------------------------------
  
data.raw.technology["refined-flammables-1"].effects = 
{
	{
	type = "ammo-damage",
	ammo_category = "flamethrower",
	modifier = 0.2
	},
	{
	type = "turret-attack",
	turret_id = "flamethrower-turret",
	modifier = 0.2
	}
}

data.raw.technology["refined-flammables-2"].effects = 
{
	{
	type = "ammo-damage",
	ammo_category = "flamethrower",
	modifier = 0.2
	},
	{
	type = "turret-attack",
	turret_id = "flamethrower-turret",
	modifier = 0.2
	}
}

data.raw.technology["refined-flammables-3"].effects = 
{
	{
	type = "ammo-damage",
	ammo_category = "flamethrower",
	modifier = 0.2
	},
	{
	type = "turret-attack",
	turret_id = "flamethrower-turret",
	modifier = 0.2
	},
		{
	type = "unlock-recipe",
	recipe = "flamethrower-ammo-napalm"
	},
	{
	type = "unlock-recipe",
	recipe = "mortar-rounds-fire"
	},  
}

data.raw.technology["refined-flammables-4"].effects = 
{
	{
	type = "ammo-damage",
	ammo_category = "flamethrower",
	modifier = 0.2
	},
	{
	type = "turret-attack",
	turret_id = "flamethrower-turret",
	modifier = 0.2
	},

}

data.raw.technology["refined-flammables-5"].effects = 
{
	{
	type = "ammo-damage",
	ammo_category = "flamethrower",
	modifier = 0.2
	},
	{
	type = "turret-attack",
	turret_id = "flamethrower-turret",
	modifier = 0.2
	},
}

data.raw.technology["refined-flammables-6"].effects = 
{
	{
	type = "ammo-damage",
	ammo_category = "flamethrower",
	modifier = 0.2
	},
	{
	type = "turret-attack",
	turret_id = "flamethrower-turret",
	modifier = 0.2
	},
}

data.raw.technology["refined-flammables-7"].effects = 
{
	{
	type = "ammo-damage",
	ammo_category = "flamethrower",
	modifier = 0.2
	},
	{
	type = "turret-attack",
	turret_id = "flamethrower-turret",
	modifier = 0.2
	},
}


------------------------------------------ OVERRIDE GUN DAMAGE------------------------------------------

data.raw.technology["physical-projectile-damage-1"].effects = 
{
  {
	type = "ammo-damage",
	ammo_category = "bullet",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "shotgun-shell",
	modifier = 0.2
  }
}

data.raw.technology["physical-projectile-damage-2"].effects = 
{
  {
	type = "ammo-damage",
	ammo_category = "bullet",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "shotgun-shell",
	modifier = 0.2
  }
}

data.raw.technology["physical-projectile-damage-3"].effects = 
{
  {
	type = "ammo-damage",
	ammo_category = "bullet",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "shotgun-shell",
	modifier = 0.2
  }
}

data.raw.technology["physical-projectile-damage-4"].effects = 
{
  {
	type = "ammo-damage",
	ammo_category = "bullet",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "shotgun-shell",
	modifier = 0.2
  }
}

data.raw.technology["physical-projectile-damage-5"].effects = 
{
  {
	type = "ammo-damage",
	ammo_category = "bullet",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "shotgun-shell",
	modifier = 0.2
  },
  {
	type = "ammo-damage",
	ammo_category = "sniper-shell",
	modifier = 0.2
  },
}

data.raw.technology["physical-projectile-damage-6"].effects = 
{
	{
	type = "ammo-damage",
	ammo_category = "bullet",
	modifier = 0.2
	},
	{
	type = "ammo-damage",
	ammo_category = "shotgun-shell",
	modifier = 0.2
	},
	{
	type = "ammo-damage",
	ammo_category = "sniper-shell",
	modifier = 0.2
	},
	{
	type = "ammo-damage",
	ammo_category = "beltfed-bullet",
	modifier = 0.2
	},
}

data.raw.technology["physical-projectile-damage-7"].effects = 
{
	{
	type = "ammo-damage",
	ammo_category = "bullet",
	modifier = 0.2
	},
	{
	type = "ammo-damage",
	ammo_category = "shotgun-shell",
	modifier = 0.2
	},
	{
	type = "ammo-damage",
	ammo_category = "sniper-shell",
	modifier = 0.2
	},
	{
	type = "ammo-damage",
	ammo_category = "beltfed-bullet",
	modifier = 0.2
	},
}

------------------------------------------ OVERRIDE PHYSICAL GUN SPEED------------------------------------------

data.raw.technology["weapon-shooting-speed-1"].effects = 
{
  {
	type = "gun-speed",
	ammo_category = "bullet",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "shotgun-shell",
	modifier = 0.1
  }
}

data.raw.technology["weapon-shooting-speed-2"].effects = 
{
  {
	type = "gun-speed",
	ammo_category = "bullet",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "shotgun-shell",
	modifier = 0.1
  }
}

data.raw.technology["weapon-shooting-speed-3"].effects = 
{
  {
	type = "gun-speed",
	ammo_category = "bullet",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "shotgun-shell",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "rocket",
	modifier = 0.1
  }
}

data.raw.technology["weapon-shooting-speed-4"].effects = 
{
  {
	type = "gun-speed",
	ammo_category = "bullet",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "shotgun-shell",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "rocket",
	modifier = 0.1
  },
}

data.raw.technology["weapon-shooting-speed-5"].effects = 
{
  {
	type = "gun-speed",
	ammo_category = "bullet",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "shotgun-shell",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "cannon-shell",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "rocket",
	modifier = 0.1
  },
	   {
	type = "gun-speed",
	ammo_category = "sniper-shell",
	modifier = 0.1
  },
}

data.raw.technology["weapon-shooting-speed-6"].effects = 
{
  {
	type = "gun-speed",
	ammo_category = "bullet",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "shotgun-shell",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "cannon-shell",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "rocket",
	modifier = 0.1
  },
  {
	type = "gun-speed",
	ammo_category = "beltfed-bullet",
	modifier = 0.1
  },
	   {
	type = "gun-speed",
	ammo_category = "sniper-shell",
	modifier = 0.1
  },
}

data.extend({
{
    type = "technology",
    name = "weapon-shooting-speed-7",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed(weapon_shooting_speed_3_icon),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "bullet",
        modifier = 0.1
      },
      {
        type = "gun-speed",
        ammo_category = "shotgun-shell",
        modifier = 0.1
      },
      {
        type = "gun-speed",
        ammo_category = "cannon-shell",
        modifier = 0.1
      },
      {
        type = "gun-speed",
        ammo_category = "rocket",
        modifier = 0.1
      },
	  {
        type = "gun-speed",
        ammo_category = "beltfed-bullet",
        modifier = 0.1
      },
	  	   {
        type = "gun-speed",
        ammo_category = "sniper-shell",
        modifier = 0.1
      },
    },
    prerequisites = {"weapon-shooting-speed-6","space-science-pack"},
    unit =
    {
      count = 100*8,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
		{"space-science-pack", 1}
      },
      time = 60
    },
    upgrade = true,
    order = "e-l-f"
  }
})

------------------------------------------ POISON ------------------------------------------

-- data.extend({
-- {
    -- type = "technology",
    -- name = "poison-damage-1",
    -- icon_size = 256, icon_mipmaps = 4,
    -- icons = util.technology_icon_constant_damage("__factorioplus__/graphics/technology/poison.png"),
    -- effects =
    -- {
      -- {
		-- type = "ammo-damage",
		-- ammo_category = "poison-rocket",
		-- modifier = 0.2
      -- },
	  -- {
		-- type = "ammo-damage",
		-- ammo_category = "poison-capsule",
		-- modifier = 0.2
      -- },
    -- },
    -- prerequisites = {"bio-weaponry-2"},
    -- unit =
    -- {
      -- count = 100*2,
      -- ingredients =
      -- {
        -- {"automation-science-pack", 1},
        -- {"logistic-science-pack", 1},
        -- {"chemical-science-pack", 1},
        -- {"military-science-pack", 1},
        -- {"bio-science-pack", 1},
      -- },
      -- time = 60
    -- },
    -- upgrade = true,
    -- order = "e-l-f"
  -- }
-- })

------------------------------------------ OVERRIDE ARTILLERY ------------------------------------------

data:extend({
  {
    type = "technology",
    name = "artillery-shell-range-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_range("__base__/graphics/technology/artillery-range.png"),
    effects =
    {
      {
        type = "artillery-range",
        modifier = 0.1
      }
    },
    prerequisites = {"artillery", "space-science-pack"},
    unit =
    {
      count_formula = "2^L*1000",
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    },
    max_level = "infinite",
    order = "e-k-d"
  },
  {
    type = "technology",
    name = "artillery-shell-speed-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_speed("__base__/graphics/technology/artillery-speed.png"),
    effects =
    {
      {
        type = "gun-speed",
        ammo_category = "artillery-shell",
        modifier = 0.25
      }
    },
    prerequisites = {"artillery", "space-science-pack"},
    unit =
    {
      count_formula = "1000+3^(L-1)*1000",
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    },
    max_level = "infinite",
    order = "e-k-k"
  }
})

table.insert(data.raw["technology"]["advanced-circuit"].effects,
	{
        type = "unlock-recipe",
        recipe = "silicon-wafer"
	}
)

table.insert(data.raw["technology"]["railway"].effects,
	{
        type = "unlock-recipe",
        recipe = "vehicle-chassis"
	}
)


------------------------------------------ OVERRIDE COMBAT ROBOTICS ------------------------------------------

-- REPLACE ENTRY data.raw["electric-pole"]["big-electric-pole"].maximum_wire_distance = 32
-- INSERT ENTRY table.insert(data.raw["technology"]["advanced-circuit"].effects,{type = "unlock-recipe",recipe = "silicon-wafer"})

-- You need explosive cannon shells to make artillery shells. So make it a prereq.
table.insert(data.raw["technology"]["artillery"].prerequisites,"explosive-ammo-3")

-- Make the default follower count 1. This is 'initialized' on the first combat robot tech.
data.raw["technology"]["defender"].effects[2]["modifier"] = 1

-- Destroyer tech (Combat robot 3) requires utility science, add that as a prereq
table.insert(data.raw["technology"]["destroyer"].prerequisites, "utility-science-pack")

  
function create_follower_upgrade(level, pack1, pack2, pack3, military_pack, high_tech_pack, production_pack, count, addition)
  local result =
  {
    type = "technology",
    name = "follower-robot-count-1",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_followers("__base__/graphics/technology/follower-robots.png"),
    effects =
    {
      {
        type = "maximum-following-robots-count",
        modifier = addition
      }
    },
    prerequisites = {"defender"},
    unit =
    {
      ingredients = {},
      time = 30
    },
    upgrade = true,
    order = "e-p-b-c"
  }
  result.name = "follower-robot-count-" .. level
  if level == 1 then
    result.prerequisites = {"defender"}
  else
    result.prerequisites = {"follower-robot-count-" .. (level - 1)}
    if level == 5 then
      result.prerequisites[#result.prerequisites + 1] = "destroyer"
    end
  end
  result.unit.count = count
  if pack1 ~= 0 then
    table.insert(result.unit.ingredients, {"automation-science-pack", pack1})
  end
  if pack2 ~= 0 then
    table.insert(result.unit.ingredients, {"logistic-science-pack", pack2})
  end
  if pack3 ~= 0 then
    table.insert(result.unit.ingredients, {"chemical-science-pack", pack3})
  end
  if military_pack ~= 0 then
    table.insert(result.unit.ingredients, {"military-science-pack", military_pack})
  end
  if high_tech_pack ~= 0 then
    table.insert(result.unit.ingredients, {"utility-science-pack", high_tech_pack})
  end
  if production_pack ~= 0 then
    table.insert(result.unit.ingredients, {"production-science-pack", production_pack})
  end
  return result
end

 data:extend(
{
  create_follower_upgrade(1, 1, 1, 0, 1, 0, 0, 200, 1),
  create_follower_upgrade(2, 1, 1, 0, 1, 0, 0, 300, 1),

  create_follower_upgrade(3, 1, 1, 1, 1, 0, 0, 400, 1),
  create_follower_upgrade(4, 1, 1, 1, 1, 0, 0, 600, 1),

  create_follower_upgrade(5, 1, 1, 1, 1, 1, 0, 800, 1),
  create_follower_upgrade(6, 1, 1, 1, 1, 1, 0, 1000, 1)
})

data:extend
({
  {
    type = "technology",
    name = "follower-robot-count-7",
    icon_size = 256, icon_mipmaps = 4,
    icons = util.technology_icon_constant_followers("__base__/graphics/technology/follower-robots.png"),
    effects =
    {
      {
        type = "maximum-following-robots-count",
        modifier = 1
      }
    },
    prerequisites = {"follower-robot-count-6", "space-science-pack"},
    unit =
    {
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 30,
      count_formula = "2^(L-7)*1000"
    },
    max_level = "infinite",
    upgrade = true,
    order = "e-p-b-c"
  },
})

-- WORKER ROBOT SPEED
local robot_speed_per_level = robot_speed_per_tech_level

data.raw.technology["worker-robots-speed-1"].effects[1].modifier = robot_speed_per_level
data.raw.technology["worker-robots-speed-2"].effects[1].modifier = robot_speed_per_level
data.raw.technology["worker-robots-speed-3"].effects[1].modifier = robot_speed_per_level
data.raw.technology["worker-robots-speed-4"].effects[1].modifier = robot_speed_per_level
data.raw.technology["worker-robots-speed-5"].effects[1].modifier = robot_speed_per_level
data.raw.technology["worker-robots-speed-6"].effects[1].modifier = robot_speed_per_level
