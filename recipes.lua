-- data.raw.recipe["cliff-explosives"].energy_required = 16
-- data.raw.recipe["cliff-explosives"].ingredients =
-- {
  -- {type = "item", name = "explosives", amount = 6},
  -- {type = "item", name = "calcite", amount = 10},
  -- {type = "item", name = "cliff-explosives-light", amount = 1},
-- }

-- data.extend({

   -- -- {
    -- -- type = "recipe",
    -- -- name = "cliff-explosives-light",
    -- -- enabled = false,
    -- -- energy_required = 10,
    -- -- ingredients =
    -- -- {
      -- -- {type = "item", name = "explosives", amount = 6},
      -- -- {type = "item", name = "grenade", amount = 1},
      -- -- {type = "item", name = "barrel", amount = 1}
    -- -- },
    -- -- results = {{type="item", name="cliff-explosives-light", amount=1}}
  -- -- },
  
-- }) 


data.extend({
   {
    type = "recipe",
    name = "rocket-turret",
	enabled = false,
    energy_required = 15,
      ingredients =
	{
		{type="item", name="turret-base", amount=2},
		{type="item", name="rocket-launcher", amount=1},	
	},
	results = {{type="item", name="rocket-turret", amount=1}},
  },
}) 



----------- BASIC RECIPE OVERRIDES ----------

data.raw["recipe"]["explosives"].ingredients =
    {
      {type = "item", name = "sulfur", amount = 1},
      {type = "item", name = "basic-explosive", amount = 2},
      {type = "fluid", name = "water", amount = 15}
    }

data.raw["recipe"]["iron-stick"].enabled = true
  
data.raw["recipe"]["pistol"].enabled = true
data.raw["recipe"]["pistol"].hidden = false
data.raw["recipe"]["pistol"].ingredients[1].amount = 2

 ---------------------------------------------------  INSERTER OVERRIDES  ------------------------------------------------------------

data.raw["recipe"]["locomotive"].ingredients =   
{
  {type="item", name="vehicle-chassis", amount=6},
  {type="item", name="electronic-circuit", amount=10},
}

 ---------------------------------------------------  INSERTER OVERRIDES  ------------------------------------------------------------

data.raw["recipe"]["inserter"].energy_required = 1
data.raw["recipe"]["fast-inserter"].energy_required = 2

data.raw["recipe"]["long-handed-inserter"].icon = "__factorioplus__/graphics/icons/long-handed-inserter.png"
data.raw["item"]["long-handed-inserter"].icon = "__factorioplus__/graphics/icons/long-handed-inserter.png"
data.raw["inserter"]["long-handed-inserter"].icon = "__factorioplus__/graphics/icons/long-handed-inserter.png"
data.raw["recipe"]["long-handed-inserter"].energy_required = 2

data.raw["recipe"]["bulk-inserter"].energy_required = 3

 ---------------------------------------------------  ASSEMBLING MACHINE OVERRIDES  ------------------------------------------------------------

data.raw["recipe"]["assembling-machine-1"].energy_required = 1
data.raw["recipe"]["assembling-machine-2"].energy_required = 2
data.raw["recipe"]["assembling-machine-3"].energy_required = 4

 ---------------------------------------------------  MODULE OVERRIDES  ------------------------------------------------------------

data.raw["recipe"]["speed-module"].ingredients = 
{ 
	{type = "item", name = "electronic-circuit", amount = 10}, 
	{type = "item", name = "plastic-bar", amount = 2} 
}
data.raw["recipe"]["productivity-module"].ingredients = 
{ 
	{type = "item", name = "electronic-circuit", amount = 10}, 
	{type = "item", name = "plastic-bar", amount = 2} 
}

data.raw["recipe"]["efficiency-module"].ingredients = 
{ 
	{type = "item", name = "electronic-circuit", amount = 10 },
	{type = "item", name = "plastic-bar", amount = 2} 
}

data.raw["recipe"]["speed-module-2"].ingredients = 
{ 
	{type = "item", name = "electronic-circuit", amount = 10}, 
	{type = "item", name = "advanced-circuit", amount = 5}, 
	{type = "item", name = "speed-module", amount = 4}
}
data.raw["recipe"]["productivity-module-2"].ingredients = 
{ 
	{type = "item", name = "electronic-circuit", amount = 10}, 
	{type = "item", name = "advanced-circuit", amount = 5}, 
	{type = "item", name = "productivity-module", amount = 4}  
}
data.raw["recipe"]["efficiency-module-2"].ingredients = 
{ 
	{type = "item", name = "electronic-circuit", amount = 10}, 
	{type = "item", name = "advanced-circuit", amount = 5}, 
	{type = "item", name = "efficiency-module", amount = 4}  
}

if (mods["quality"]) then
	data.raw["recipe"]["quality-module"].ingredients = 
	{ 
		{type = "item", name = "electronic-circuit", amount = 10}, 
		{type = "item", name = "plastic-bar", amount = 2} 
	}
	data.raw["recipe"]["quality-module-2"].ingredients = 
	{ 
		{type = "item", name = "electronic-circuit", amount = 10}, 
		{type = "item", name = "advanced-circuit", amount = 5}, 
		{type = "item", name = "quality-module", amount = 4}  
	}
end


 ---------------------------------------------------  MACHINEPRESS OVERRIDES  ------------------------------------------------------------



data:extend
({
  {
    type = "recipe",
    name = "machinepress-iron-gear-wheel",
	category = "crafting-machinepress",
	icon = "__factorioplus__/graphics/icons/double-iron-gear-wheel.png",
  ingredients = {{type="item", name="iron-plate", amount=2}},
  hide_from_player_crafting = true,
  results = {{type="item", name="iron-gear-wheel", amount=1}},
  },
   {
    type = "recipe",
    name = "machinepress-iron-stick",
	category = "crafting-machinepress",
	icon = "__factorioplus__/graphics/icons/double-iron-stick.png",
	hide_from_player_crafting = true,
    ingredients = {{type="item", name="iron-plate", amount=1}},
    results = {{type="item", name="iron-stick", amount=2}},
  },
  {
    type = "recipe",
    name = "machinepress-copper-cable",
	category = "crafting-machinepress",
	icon = "__factorioplus__/graphics/icons/double-copper-cable.png",
	hide_from_player_crafting = true,
    ingredients = {{type="item", name="copper-plate", amount=1}},
    results = {{type="item", name="copper-cable", amount=2}},
  },
   {
    type = "recipe",
    name = "stone-crushing",
	enabled = false,
    category = "crafting-machinepress",
    energy_required = 2,
    ingredients = 
	{
	{type="item", name="stone", amount=1},
	},
    results = {{type="item", name="sand-ore", amount=2}},
	icon = "__factorioplus__/graphics/icons/stonetosand.png",
    icon_size = 64, icon_mipmaps = 4,
  },

})

 ---------------------------------------------------  FACTORIOPLUS RECIPES  ------------------------------------------------------------

--  BASIC PIPE RECIPES --	
 
 data.extend({  
  {
	hidden = true, -- REMOVE ONCE IMPLEMENTED
    type = "recipe",
    name = "pipe-basic",
    ingredients = {{type = "item", name = "iron-plate", amount = 1}},
    results = {{type="item", name="pipe-basic", amount=2}},
    enabled = false
  },
  
  {
	hidden = true, -- REMOVE ONCE IMPLEMENTED
    type = "recipe",
    name = "pipe-to-ground-basic",
    enabled = false,
    ingredients =
    {
      {type = "item", name = "pipe-basic", amount = 6},
      {type = "item", name = "iron-plate", amount = 2}
    },
    results = {{type="item", name="pipe-to-ground-basic", amount=2}}
  },
})

 
 data.extend({  
  {
    type = "recipe",
    name = "pipe-reinforced",
    ingredients = 
	{
		{type = "item", name = "pipe", amount = 1},
		{type = "item", name = "steel-plate", amount = 1}
	},
    results = {{type="item", name="pipe-reinforced", amount=1}},
    enabled = false
  },
  
  {
    type = "recipe",
    name = "pipe-to-ground-reinforced",
    enabled = false,
    ingredients =
    {
      {type = "item", name = "pipe-reinforced", amount = 24},
      {type = "item", name = "steel-plate", amount = 6}
    },
    results = {{type="item", name="pipe-to-ground-reinforced", amount=1}}
  },
})


data:extend
({
	{
	type = "recipe",
	name = "fish-processing",
	energy_required = 30,
	enabled = false,
	category = "crafting-with-fluid",
	ingredients = {{type = "fluid", name = "water", amount = 3000}},
	icon = "__factorioplus__/graphics/icons/fish-processing.png",
	icon_size = 64, icon_mipmaps = 4,
	subgroup = "raw-material",
	order = "k[fish-processing]",
	allow_productivity = true,
	results =
	{
	  {
		type="item",
		name = "raw-fish",
		probability = 0.2,
		amount = 1
	  },
	}
	},
	
	{
    type = "recipe",
    name = "productivity-module-4",
    enabled = false,
    ingredients =
    {
      {type="item", name="productivity-module-3", amount=6},
      {type="item", name="processing-unit", amount=5},
	  {type="item", name="cpu-item", amount=4},
    },
    energy_required = 120,
    results = {{type="item", name="productivity-module-4", amount=1}},
  },
  {
    type = "recipe",
    name = "speed-module-4",
    enabled = false,
    ingredients =
    {
      {type="item", name="speed-module-3", amount=6},
      {type="item", name="processing-unit", amount=5},
	  {type="item", name="cpu-item", amount=4},
    },
    energy_required = 120,
    results = {{type="item", name="speed-module-4", amount=1}},
  },
  {
    type = "recipe",
    name = "efficiency-module-4",
    enabled = false,
    ingredients =
    {
      {type="item", name="efficiency-module-3", amount=6},
      {type="item", name="processing-unit", amount=5},
	  {type="item", name="cpu-item", amount=4},
    },
    energy_required = 120,
    results = {{type="item", name="efficiency-module-4", amount=1}},
  },
{
    type = "recipe",
    name = "mini-roboport",
    enabled = false,
    energy_required = 3,
    ingredients =
    {
      {type="item", name="aluminium-plate", amount=10},
      {type="item", name="iron-gear-wheel", amount=15},
      {type="item", name="electronic-circuit", amount=30}
    },
    results = {{type="item", name="mini-roboport", amount=1}},
  },
  {
    type = "recipe",
    name = "mini-electric-furnace",
	enabled = false,
    ingredients = {{type="item", name="aluminium-plate",  amount=6}, {type="item", name="advanced-circuit",  amount=3}, {type="item", name="stone-brick", amount=5}},
    results = {{type="item", name="mini-electric-furnace", amount=1}},
  },
  {
    type = "recipe",
    name = "basic-electric-furnace",
	enabled = false,
    ingredients = {
	{type="item", name="steel-plate",  amount=6}, 
	{type="item", name="electronic-circuit",  amount=10}, 
	{type="item", name="stone-brick", amount=8}
	},
    results = {{type="item", name="basic-electric-furnace", amount=1}},
  },
  
  {
    type = "recipe",
    name = "listening-post",
	energy_required = 2,
	enabled = false,
    ingredients =
    {
      {type="item", name="electronic-circuit", amount=2},
      {type="item", name="iron-plate", amount=2},
      {type="item", name="iron-stick", amount=4}
    },
    results = {{type="item", name="listening-post", amount=1}},
  },
  {
    type = "recipe",
    name = "radar-large",
	energy_required = 20,
	enabled = false,
    ingredients =
    {
      {type="item", name="advanced-circuit", amount=5},
      {type="item", name="steel-plate", amount=5},
      {type="item", name="radar", amount=10}
    },
    results = {{type="item", name="radar-large", amount=1}},
  },
-- {
    -- type = "recipe",
    -- name = "crane-inserter",
	-- energy_required = 10,
	-- enabled = false,
    -- ingredients =
    -- {
      -- {type="item", name="electronic-circuit", amount=1},
      -- {type="item", name="iron-gear-wheel", amount=1},
      -- {type="item", name="iron-plate", amount=1}
    -- },
    -- results = {{type="item", name="crane-inserter", amount=1}},
  -- },
{
    type = "recipe",
    name = "air-scrubber",
	energy_required = 20,
    enabled = false,
    ingredients =
    {
	  {type="item", name="electronic-circuit", amount=15},    
	  {type="item", name="low-density-structure", amount=20},
	  {type="item", name="wood", amount=300},
    },
    results = {{type="item", name="air-scrubber", amount=1}},
  },
  {
    type = "recipe",
    name = "air-scrubber-large",
	energy_required = 50,
    enabled = false,
	category = "crafting-with-fluid",
    ingredients =
    {
      {type="item", name="air-scrubber", amount=3},
	  {type="item", name="advanced-circuit", amount=30},  
	  {type="fluid", name="water", amount=30000}
    },
    results = {{type="item", name="air-scrubber-large", amount=1}},
  },
{
    type = "recipe",
    name = "offshore-pump-large",
	energy_required = 20,
    enabled = false,
    ingredients =
    {
      {type="item", name="offshore-pump", amount=4},
      {type="item", name="advanced-circuit", amount=10},
      {type="item", name="electric-engine-unit", amount=4},
    },
    results = {{type="item", name="offshore-pump-large", amount=1}},
  },
{
    type = "recipe",
    name = "factory-large",
	energy_required = 30,
	enabled = false,

      ingredients =
      {
        {type="item", name="productivity-module-3", amount=4},
		{type="item", name="assembling-machine-2", amount=6},
		{type="item", name="concrete", amount=140},
      },
      results = {{type="item", name="factory-large", amount=1}},

},
{
    type = "recipe",
    name = "mini-assembling-machine-1",
	energy_required = 6,
	enabled = false,
      ingredients =
      {
		{type="item", name="aluminium-plate", amount=6},
        {type="item", name="efficiency-module", amount=2},
        {type="item", name="assembling-machine-2", amount=1}
      },
      results = {{type="item", name="mini-assembling-machine-1", amount=1}},
},
{
    type = "recipe",
    name = "metal-press-machine",
	energy_required = 15,
	category = "crafting-with-fluid",
	enabled = false,
      ingredients =
      {
        {type="item", name="steel-plate", amount=20},
		{type="item", name="iron-gear-wheel", amount=20},
		{type="fluid", name="lubricant", amount=80},
        {type="item", name="productivity-module-2", amount=8}
      },
      results = {{type="item", name="metal-press-machine", amount=1}},
},
{
    type = "recipe",
    name = "compressor",
	energy_required = 20,
	category = "crafting-with-fluid",
	enabled = false,
      ingredients =
      {
        {type="item", name="steel-plate", amount=20},
		{type="item", name="iron-gear-wheel", amount=50},
		{type="fluid", name="lubricant", amount=200},
      },
      results = {{type="item", name="compressor", amount=1}},
},
{
    type = "recipe",
    name = "singlestack-chest",
	energy_required = 1,
	enabled = true,

      ingredients =
      {
        {type="item", name="iron-plate", amount=8},
		{type="item", name="stone-brick", amount=8},
      },
      results = {{type="item", name="singlestack-chest", amount=1}},
},
{
    type = "recipe",
    name = "storage-hut",
	energy_required = 4,
	enabled = false,

      ingredients =
      {
		{type="item", name="steel-chest", amount=1},
        {type="item", name="iron-plate", amount=12},
		{type="item", name="stone-brick", amount=16}
      },
      results = {{type="item", name="storage-hut", amount=1}},
},
{
    type = "recipe",
    name = "storage-tank-large",
	energy_required = 8,
	enabled = false,

      ingredients =
      {
		{type="item", name="storage-tank", amount=2},
		{type="item", name="steel-plate", amount=12},
		{type="item", name="concrete", amount=60}
      },
      results = {{type="item", name="storage-tank-large", amount=1}},
},
{
    type = "recipe",
    name = "logistic-passive-provider-hut",
	energy_required = 8,
	enabled = false, 
      ingredients =
     {
      {type="item", name="storage-hut", amount=1},
      {type="item", name="electronic-circuit", amount=6},
      {type="item", name="advanced-circuit", amount=2}
    },
      results = {{type="item", name="logistic-passive-provider-hut", amount=1}},
    
},
{
    type = "recipe",
    name = "logistic-active-provider-hut",
	energy_required = 8,
	enabled = false, 
      ingredients =
     {
      {type="item", name="storage-hut", amount=1},
      {type="item", name="electronic-circuit", amount=6},
      {type="item", name="advanced-circuit", amount=2}
    },
      results = {{type="item", name="logistic-active-provider-hut", amount=1}},
    
},
{
    type = "recipe",
    name = "logistic-buffer-hut",
	energy_required = 8,
	enabled = false, 
      ingredients =
     {
      {type="item", name="storage-hut", amount=1},
      {type="item", name="electronic-circuit", amount=6},
      {type="item", name="advanced-circuit", amount=2}
    },
      results = {{type="item", name="logistic-buffer-hut", amount=1}},
    
},
{
    type = "recipe",
    name = "logistic-requester-hut",
	energy_required = 8,
	enabled = false, 
      ingredients =
     {
      {type="item", name="storage-hut", amount=1},
      {type="item", name="electronic-circuit", amount=6},
      {type="item", name="advanced-circuit", amount=2}
    },
      results = {{type="item", name="logistic-requester-hut", amount=1}},
    
},
{
    type = "recipe",
    name = "logistic-storage-hut",
	energy_required = 8,
	enabled = false, 
      ingredients =
     {
      {type="item", name="storage-hut", amount=1},
      {type="item", name="electronic-circuit", amount=6},
      {type="item", name="advanced-circuit", amount=2}
    },
      results = {{type="item", name="logistic-storage-hut", amount=1}},
    
},
{
    type = "recipe",
    name = "warehouse",
	energy_required = 5,
	enabled = false,
      ingredients =
      {
		{type="item", name="storage-hut", amount=1},
        {type="item", name="steel-plate", amount=20},
		{type="item", name="concrete", amount=50},
      },
      results = {{type="item", name="warehouse", amount=1}},
},
{
    type = "recipe",
    name = "logistic-warehouse-passive-provider",
	energy_required = 8,
	enabled = false, 
      ingredients =
     {
      {type="item", name="warehouse", amount=1},
      {type="item", name="electronic-circuit", amount=12},
      {type="item", name="advanced-circuit", amount=4}
    },
      results = {{type="item", name="logistic-warehouse-passive-provider", amount=1}},
    
},
{
    type = "recipe",
    name = "logistic-warehouse-active-provider",
	energy_required = 8,
	enabled = false, 
      ingredients =
     {
      {type="item", name="warehouse", amount=1},
      {type="item", name="electronic-circuit", amount=12},
      {type="item", name="advanced-circuit", amount=4}
    },
      results = {{type="item", name="logistic-warehouse-active-provider", amount=1}},
    
},
{
    type = "recipe",
    name = "logistic-warehouse-buffer",
	energy_required = 8,
	enabled = false, 
      ingredients =
     {
      {type="item", name="warehouse", amount=1},
      {type="item", name="electronic-circuit", amount=12},
      {type="item", name="advanced-circuit", amount=4}
    },
      results = {{type="item", name="logistic-warehouse-buffer", amount=1}},
    
},
{
    type = "recipe",
    name = "logistic-warehouse",
	energy_required = 8,
	enabled = false, 
      ingredients =
     {
      {type="item", name="warehouse", amount=1},
      {type="item", name="electronic-circuit", amount=12},
      {type="item", name="advanced-circuit", amount=4}
    },
      results = {{type="item", name="logistic-warehouse", amount=1}},
    
},
{
    type = "recipe",
    name = "logistic-warehouse-requester",
	energy_required = 8,
	enabled = false, 
      ingredients =
     {
      {type="item", name="warehouse", amount=1},
      {type="item", name="electronic-circuit", amount=12},
      {type="item", name="advanced-circuit", amount=4}
    },
      results = {{type="item", name="logistic-warehouse-requester", amount=1}},
    
},

{
    type = "recipe",
    name = "big-furnace",
	energy_required = 10,
	enabled = false,
    ingredients = {
	{type="item", name="stone-furnace", amount=2}, 
	{type="item", name="stone-brick", amount=10}, 
	{type="item", name="iron-plate", amount=4}
	},
    results = {{type="item", name="big-furnace", amount=1}},
},
{
    type = "recipe",
    name = "steel-forge",
	energy_required = 20,
	enabled = false,
    ingredients = {
	{type="item", name="steel-furnace", amount=2}, 
	{type="item", name="concrete", amount=40},
	{type="item", name="steel-plate", amount=20}
	},
    results = {{type="item", name="steel-forge", amount=1}},
},
  {
    type = "recipe",
    name = "electric-foundry",
	enabled = false,
	energy_required = 20,
    ingredients = {
	{type="item", name="electric-furnace", amount=4}, 
	{type="item", name="productivity-module-2", amount=6}, 
	{type="item", name="speed-module-2", amount=4}, 
	{type="item", name="concrete", amount=60}
	},
    results = {{type="item", name="electric-foundry", amount=1}},
},
  {
    type = "recipe",
    name = "heatpipe-furnace",
	enabled = false,
	energy_required = 20,
    ingredients = {
	{type="item", name="electric-furnace", amount=2}, 
	{type="item", name="heat-exchanger", amount=2},  
	{type="item", name="concrete", amount=40}
	},
    results = {{type="item", name="heatpipe-furnace", amount=1}},
},
   {
    type = "recipe",
    name = "solar-panel",
    energy_required = 10,
    enabled = false,
    ingredients =
    {
      {type="item", name="steel-plate", amount=4},
      {type="item", name="electronic-circuit", amount=10},
      {type="item", name="glass-plate", amount=10}
    },
    results = {{type="item", name="solar-panel", amount=1}},
  },
 {
    type = "recipe",
    name = "solar-array",
    energy_required = 30,
    enabled = false,
    ingredients =
    {
      {type="item", name="solar-panel", amount=2},
      {type="item", name="advanced-circuit", amount=10},
      {type="item", name="steel-plate", amount=6}
    },
    results = {{type="item", name="solar-array", amount=1}},
  },
   {
    type = "recipe",
    name = "solar-array-2",
    energy_required = 60,
    enabled = false,
    ingredients =
    {
      {type="item", name="solar-array", amount=4},
      {type="item", name="processing-unit", amount=10},
      {type="item", name="aluminium-plate", amount=16}
    },
    results = {{type="item", name="solar-array-2", amount=1}},
  },
  {
    type = "recipe",
    name = "floodlight-lamp",
	energy_required = 4,
	enabled = false,
    ingredients =
    {
      {type="item", name="small-lamp", amount=4},
      {type="item", name="electronic-circuit", amount=1},
      {type="item", name="steel-plate", amount=2}
    },
    results = {{type="item", name="floodlight-lamp", amount=1}},
  },
  {
    type = "recipe",
    name = "floor-lamp",
	energy_required = 2,
	enabled = false,
    ingredients =
    {
      {type="item", name="small-lamp", amount=1},
      {type="item", name="landfill", amount=1},
      {type="item", name="iron-plate", amount=2}
    },
    results = {{type="item", name="floor-lamp", amount=1}},
  },
  {
    type = "recipe",
    name = "aluminium-plate",
	enabled = false,
    category = "smelting",
    energy_required = 15,
    ingredients = {{type="item", name="bauxite-ore", amount=2}},
    results = {{type="item", name="aluminium-plate", amount=1}},
	allow_productivity = true,
  },
    {
    type = "recipe",
    name = "glass-plate",
	enabled = false,
    category = "smelting",
    energy_required = 8,
    ingredients = {{type="item", name="sand-ore", amount=4}},
    results = {{type="item", name="glass-plate", amount=1}},
	allow_productivity = true,
  },
      {
    type = "recipe",
    name = "barrel-recycling",
	enabled = false,
    category = "smelting",
    energy_required = 8,
    ingredients = {{type="item", name="barrel", amount=1}},
    results = {{type="item", name="iron-plate", amount=3}},
	localised_name = {"recipe-name.barrel-recycling"},
  },
  {
    type = "recipe",
    name = "stone-compression",
	enabled = false,
    category = "crafting-compressor",
    energy_required = 4,
    ingredients = 
	{
	{type="item", name="sand-ore", amount=5},
	},
    results = {{type="item", name="stone", amount=1}},
	icon = "__factorioplus__/graphics/icons/sandtostone.png",
    icon_size = 64, icon_mipmaps = 4,
  },
   {
    type = "recipe",
    name = "sulfer-compression",
	enabled = false,
    category = "crafting-compressor",
    energy_required = 4,
    ingredients = 
	{
	{type="fluid", name="sulfuric-acid", amount=10}
	},
    results = {{type="item", name="sulfur", amount=1}},
	icon = "__factorioplus__/graphics/icons/acidtosulfer.png",
    icon_size = 64, icon_mipmaps = 4,
  },
   {
    type = "recipe",
    name = "steam-compression",
	enabled = false,
    category = "crafting-compressor",
	subgroup = "fluid-recipes",
    energy_required = 8,
    ingredients = 
	{
	{type="fluid", name="steam", amount=100}
	},
   results=
    {
      {type="fluid", name="water", amount=10}
    },
	icon = "__factorioplus__/graphics/icons/steamtowater.png",
    icon_size = 64, icon_mipmaps = 4,
  },
    {
    type = "recipe",
    name = "basic-explosive",
	enabled = false,
    category = "crafting",
    energy_required = 2,
    ingredients =  
	{
	  {type="item", name="coal", amount=4},
      {type="item", name="iron-plate", amount=1},
    },
    results = {{type="item", name="basic-explosive", amount=2}},
	allow_productivity = true,
  },
  {
    type = "recipe",
    name = "silicon-wafer",
	enabled = false,
    category = "smelting",
    energy_required = 20,
    ingredients = {{type="item", name="glass-plate", amount=3}},
    results = {{type="item", name="silicon-wafer", amount=1}},
	allow_productivity = true,
  },
    {
    type = "recipe",
    name = "tarmac",
    energy_required = 10,
    enabled = false,
    category = "crafting-with-fluid",
    ingredients =
    {
      {type="item", name="concrete", amount=4},
      {type="item", name="sand-ore", amount=10},
      {type="fluid", name="light-oil", amount=20}
    },
	results = {{type="item", name="tarmac", amount=10}},
  },
  {
    type = "recipe",
    name = "landfill-deep",
	enabled = false,
    energy_required = 10,
    category = "advanced-crafting",
    ingredients =
    {
	  {type="item", name="sand-ore", amount=6},
      {type="item", name="landfill", amount=1},
	  {type="item", name="concrete", amount=2}
    },
	results = {{type="item", name="landfill-deep", amount=1}},
  },
  {
    type = "recipe",
    name = "waterfill-barrel",
	enabled = false,
    energy_required = 30,
    category = "crafting-with-fluid",
    ingredients =
    {
	  {type="item", name="barrel", amount=10},
	  {type="item", name="cliff-explosives", amount=3},
	  {type="fluid", name="water", amount=5000}
    },
	results = {{type="item", name="waterfill-barrel", amount=10}},
  },
}) 

 
if (mods["space-age"]) then  

data.extend({
   {
    type = "recipe",
    name = "accumulator-battery",
	enabled = false,
    energy_required = 15,
    ingredients =
    {
      {type="item", name="accumulator", amount=8},
      {type="item", name="electronic-circuit", amount=6},
	  {type="item", name="advanced-circuit", amount=4}
    },
    results = {{type="item", name="accumulator-battery", amount=1}},
  },
})

else

 data.extend({
   {
    type = "recipe",
    name = "accumulator-battery",
	enabled = false,
    energy_required = 15,
    ingredients =
    {
      {type="item", name="accumulator", amount=8},
      {type="item", name="electronic-circuit", amount=6},
	  {type="item", name="advanced-circuit", amount=4}
    },
    results = {{type="item", name="accumulator-battery", amount=1}},
  },
})

end

if (mods["space-age"]) then  

data.extend({
  {
    type = "recipe",
    name = "adv-accumulator-battery",
	enabled = false,
    energy_required = 25,
    ingredients =
    {
      {type="item", name="accumulator-battery", amount=2},
	  {type="item", name="supercapacitor", amount=4},
	  {type="item", name="advanced-circuit", amount=8},
	  {type="item", name="processing-unit", amount=4},	  
    },
    results = {{type="item", name="adv-accumulator-battery", amount=1}},
  },
})

else

data.extend({
  {
    type = "recipe",
    name = "adv-accumulator-battery",
	enabled = false,
    energy_required = 25,
    ingredients =
    {
      {type="item", name="accumulator-battery", amount=4},
	  {type="item", name="advanced-circuit", amount=8},
	  {type="item", name="processing-unit", amount=4},	  
    },
    results = {{type="item", name="adv-accumulator-battery", amount=1}},
  },
})

end
  
data.extend({
  {
    type = "recipe",
    name = "scout",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="vehicle-chassis", amount=2},
      {type="item", name="electric-engine-unit", amount=6},
	  {type="item", name="speed-module", amount=4},
    },
    results = {{type="item", name="scout", amount=1}},
  },
  {
    type = "recipe",
    name = "transporter",
    enabled = false,
    energy_required = 16,
    ingredients =
    {
      {type="item", name="vehicle-chassis", amount=4},
      {type="item", name="steel-chest", amount=4}
    },
    results = {{type="item", name="transporter", amount=1}},
  },
  {
    type = "recipe",
    name = "dozer",
	enabled = false,
    energy_required = 20,
      ingredients =
	{
		{type="item", name="vehicle-chassis", amount=8},
		{type="item", name="steel-plate", amount=20},
	},
	results = {{type="item", name="dozer", amount=1}},

  },
     {
    type = "recipe",
    name = "pistol-turret",
	enabled = false,
    energy_required = 4,
      ingredients =
	{
		{type="item", name="iron-plate", amount=2},
		{type="item", name="electronic-circuit", amount=1},
		{type="item", name="pistol", amount=1},	
	},
	results = {{type="item", name="pistol-turret", amount=1}},
  },
   {
    type = "recipe",
    name = "cannon-turret",
	enabled = false,
    energy_required = 40,
      ingredients =
	{
		{type="item", name="turret-base", amount=6},
		{type="item", name="cannon", amount=1},	
	},
	results = {{type="item", name="cannon-turret", amount=1}},
  },
  {
    type = "recipe",
    name = "chaingun-turret",
	enabled = false,
    energy_required = 35,
      ingredients =
	{
		{type="item", name="turret-base", amount=4},
		{type="item", name="mini-gun", amount=1},	
	},
	results = {{type="item", name="chaingun-turret", amount=1}},
  },
  })


  
   data.extend({
  {
    type = "recipe",
    name = "mortar-turret",
	enabled = false,
    energy_required = 15,
      ingredients =
	{
		{type="item", name="turret-base", amount=3},
		{type="item", name="grenade-launcher", amount=1},
        {type="item", name="listening-post", amount=1},		
	},
	results = {{type="item", name="mortar-turret", amount=1}},
  },
  {
    type = "recipe",
    name = "shotgun-turret",
	enabled = false,
    energy_required = 10,
      ingredients =
	{
		{type="item", name="turret-base", amount=1},
		{type="item", name="shotgun", amount=1},		
	},
	results = {{type="item", name="shotgun-turret", amount=1}},
  },
    {
    type = "recipe",
    name = "sniper-turret",
	enabled = false,
    energy_required = 20,
      ingredients =
	{
		{type="item", name="turret-base", amount=3},
		{type="item", name="sniper-rifle", amount=1},
        {type="item", name="listening-post", amount=1},		
	},
	results = {{type="item", name="sniper-turret", amount=1}},
  },
  {
    type = "recipe",
    name = "large-laser-turret",
	enabled = false,
    energy_required = 45,
      ingredients =
	{
		{type="item", name="turret-base", amount=6},
		{type="item", name="laser", amount=12},
        {type="item", name="accumulator-battery", amount=6},		
	},
	results = {{type="item", name="large-laser-turret", amount=1}},
  },
  {
    type = "recipe",
    name = "large-burner-mining-drill",
    energy_required = 5,
	enabled = false,
    ingredients =
    {
		{type="item", name="burner-mining-drill", amount=2},
        {type="item", name="iron-gear-wheel", amount=6},
        {type="item", name="steel-plate", amount=8}
    },
      results = {{type="item", name="large-burner-mining-drill", amount=1}},

  },
   {
    type = "recipe",
    name = "electric-grinder",
	enabled = false,
    energy_required = 10,
    ingredients =
      {    
        {type="item", name="electric-mining-drill", amount=2},
        {type="item", name="iron-gear-wheel", amount=20},
		{type="item", name="efficiency-module", amount=4},
		{type="item", name="productivity-module", amount=4},
      },
      results = {{type="item", name="electric-grinder", amount=1}},
    },
   {
    type = "recipe",
    name = "steam-turbine-miner",
    energy_required = 12,
	enabled = false,
    ingredients =
      {
        {type="item", name="large-burner-mining-drill", amount=2},
        {type="item", name="steam-turbine", amount=1},
		{type="item", name="pipe", amount=10},
      },
      results = {{type="item", name="steam-turbine-miner", amount=1}},
  },
   {
    type = "recipe",
    name = "electric-sawmill",
    energy_required = 5,
	enabled = false,
    ingredients =
      {
        {type="item", name="electronic-circuit", amount=2},
        {type="item", name="iron-gear-wheel", amount=10},
        {type="item", name="iron-plate", amount=12},
      },
      results = {{type="item", name="electric-sawmill", amount=1}},
  },
  {
    type = "recipe",
    name = "gas-extractor",
	enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type="item", name="steel-plate", amount=6},
      {type="item", name="iron-gear-wheel", amount=20},
      {type="item", name="electronic-circuit", amount=2},
      {type="item", name="pipe", amount=20}
    },
    results = {{type="item", name="gas-extractor", amount=1}},
  },
  {
    type = "recipe",
    name = "repair-pack-advanced",
	energy_required = 10,
	category = "crafting-with-fluid",
	enabled = false,
    ingredients =
    {
      {type="item", name="repair-pack", amount=1},
	  {type="item", name="advanced-circuit", amount=1},
      {type = "fluid", name = "lubricant", amount = 10}
    },
    results = {{type="item", name="repair-pack-advanced", amount=1}},
  },
  
  {
    type = "recipe",
    name = "long-handed-burner-inserter",
	enabled = false,
    ingredients =
    {
	  {type="item", name="burner-inserter", amount=1},
      {type="item", name="iron-plate", amount=1},
      {type="item", name="iron-gear-wheel", amount=1}
    },
    results = {{type="item", name="long-handed-burner-inserter", amount=1}},
  },
  
   {
    type = "recipe",
    name = "very-long-handed-inserter",
	enabled = false,
    ingredients =
    {
	  {type="item", name="long-handed-inserter", amount=1},
      {type="item", name="electronic-circuit", amount=6},
      {type="item", name="steel-plate", amount = 2},
    },
    results = {{type="item", name="very-long-handed-inserter", amount=1}},
  },
  
  --- BELTS
  -- BASIC 0
  
  {
    type = "recipe",
    name = "basic-transport-belt",
    ingredients =
    {
      {type="item", name="iron-plate", amount=1},
      {type="item", name="iron-gear-wheel", amount=1}
    },
    results = {{type="item", name="basic-transport-belt", amount=4}},
  },
  {
    type = "recipe",
    name = "basic-splitter",
    enabled = false,
    ingredients =
    {
      {type="item", name="electronic-circuit", amount=1},
      {type="item", name="iron-plate", amount=2},
      {type="item", name="basic-transport-belt", amount=4}
    },
    results = {{type="item", name="basic-splitter", amount=1}},
  },
   {
    type = "recipe",
    name = "basic-underground-belt",
    enabled = false,
    ingredients =
    {
	  {type="item", name="iron-plate", amount=4},
      {type="item", name="basic-transport-belt", amount=4}
    },
    results = {{type="item", name="basic-underground-belt", amount=2}},
  },
  
   -- NORMAL 1

    {
    type = "recipe",
    name = "transport-belt",
    ingredients =
    {
      {type="item", name="basic-transport-belt", amount=2},
      {type="item", name="iron-gear-wheel", amount=2}
    },
    results = {{type="item", name="transport-belt", amount=2}},
	enabled = false,
  },
   {
    type = "recipe",
    name = "splitter",
    enabled = false,
    energy_required = 1,
    ingredients =
    {
	  {type="item", name="basic-splitter", amount=1},
      {type="item", name="electronic-circuit", amount=2},
      {type="item", name="iron-plate", amount=4},
    },
    results = {{type="item", name="splitter", amount=1}},
  },
  {
    type = "recipe",
    name = "underground-belt",
    enabled = false,
    energy_required = 1,
    ingredients =
    {
      {type="item", name="iron-gear-wheel", amount=4},
      {type="item", name="basic-underground-belt", amount=2}
    },
    results = {{type="item", name="underground-belt", amount=2}},
  },
  
    -- FAST 2
	
  {
    type = "recipe",
    name = "fast-transport-belt",
    enabled = false,
    ingredients =
    {
      {type="item", name="iron-gear-wheel", amount=4},
      {type="item", name="transport-belt", amount=1}
    },
    results = {{type="item", name="fast-transport-belt", amount=1}},
  },
  
    {
    type = "recipe",
    name = "fast-splitter",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {type="item", name="splitter", amount=1},
      {type="item", name="iron-gear-wheel", amount=4},
      {type="item", name="electronic-circuit", amount=4}
    },
    results = {{type="item", name="fast-splitter", amount=1}},
  },
  
   {
    type = "recipe",
    name = "fast-underground-belt",
    energy_required = 2,
    enabled = false,
    ingredients =
    {
      {type="item", name="iron-gear-wheel", amount=8},
      {type="item", name="underground-belt", amount=2}
    },
    results = {{type="item", name="fast-underground-belt", amount=2}},
  },
  
  -- EXPRESS 3
  
  {
    type = "recipe",
    name = "express-transport-belt",
    category = "crafting-with-fluid",
	  enabled = false,

	  ingredients =
	  {
		{type="item", name="iron-gear-wheel", amount=8},
		{type="item", name="fast-transport-belt", amount=1},
		{type="fluid", name="lubricant", amount=20}
	  },
	  results = {{type="item", name="express-transport-belt", amount=1}},
  },
  
  {
    type = "recipe",
    name = "express-splitter",
    category = "crafting-with-fluid",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {type="item", name="fast-splitter", amount=1},
      {type="item", name="iron-gear-wheel", amount=8},
      {type="item", name="advanced-circuit", amount=8},
      {type="fluid", name="lubricant", amount=80}
    },
    results = {{type="item", name="express-splitter", amount=1}},
	},
  
  {
    type = "recipe",
    name = "express-underground-belt",
    energy_required = 2,
    category = "crafting-with-fluid",
    enabled = false,
    ingredients =
    {
      {type="item", name="iron-gear-wheel", amount=16},
      {type="item", name="fast-underground-belt", amount=2},
      {type="fluid", name="lubricant", amount=40}
    },
    results = {{type="item", name="express-underground-belt", amount=2}},
  },
  
  -- TURBO 4
  
  {
    type = "recipe",
    name = "turbo-transport-belt",
	enabled = false,
	category = "crafting-with-fluid",
	energy_required = 4,
    ingredients =
    {
	  {type="item", name="express-transport-belt", amount=2},
	  {type="item", name="iron-gear-wheel", amount=32},
      {type="item", name="speed-module", amount=1},
      {type="fluid", name="lubricant", amount=60}
    },
    results = {{type="item", name="turbo-transport-belt", amount=2}},
  },
   {
    type = "recipe",
    name = "turbo-splitter",
    enabled = false,
	category = "crafting-with-fluid",
	energy_required = 4,
    ingredients =
    {
      {type="item", name="express-splitter", amount=2},
	  {type="item", name="iron-gear-wheel", amount=32},
      {type="item", name="speed-module", amount=2},
      {type="fluid", name="lubricant", amount=120}
    },
    results = {{type="item", name="turbo-splitter", amount=2}},
  },
   {
    type = "recipe",
    name = "turbo-underground-belt",
    enabled = false,
	category = "crafting-with-fluid",
	energy_required = 4,
    ingredients =
    {
	  {type="item", name="express-underground-belt", amount=2},
      {type="item", name="iron-gear-wheel", amount=32},
	  {type="item", name="speed-module", amount=1},
      {type="fluid", name="lubricant", amount=80}
    },
    results = {{type="item", name="turbo-underground-belt", amount=2}},
  },
  
  -- SUPERSONIC 5
  
  {
    type = "recipe",
    name = "supersonic-transport-belt",
	enabled = false,
	category = "crafting-with-fluid",
	energy_required = 4,
    ingredients =
    {
	  {type="item", name="turbo-transport-belt", amount=2},
	  {type="item", name="iron-gear-wheel", amount=48},
      {type="item", name="speed-module-2", amount=1},
      {type="fluid", name="lubricant", amount=120}
    },
    results = {{type="item", name="supersonic-transport-belt", amount=2}},
  },
   {
    type = "recipe",
    name = "supersonic-splitter",
    enabled = false,
	category = "crafting-with-fluid",
	energy_required = 4,
    ingredients =
    {
      {type="item", name="turbo-splitter", amount=2},
	  {type="item", name="iron-gear-wheel", amount=48},
      {type="item", name="speed-module-2", amount=1},
      {type="fluid", name="lubricant", amount=240}
    },
    results = {{type="item", name="supersonic-splitter", amount=2}},
  },
   {
    type = "recipe",
    name = "supersonic-underground-belt",
    enabled = false,
	category = "crafting-with-fluid",
	energy_required = 4,
    ingredients =
    {
	  {type="item", name="turbo-underground-belt", amount=2},
      {type="item", name="iron-gear-wheel", amount=48},
	  {type="item", name="speed-module-2", amount=1},
      {type="fluid", name="lubricant", amount=160}
    },
    results = {{type="item", name="supersonic-underground-belt", amount=2}},
  },
})
------------------------------------------- OVERRIDES ------------------------------------------- 
---- LOADERS ---

local loader_cost_mult = 1
if settings.startup["settings-loaders-cost"].value == "expensive" then
loader_cost_mult = 2
end

local loader_inserter_count = 8
local loader_belt_count = 10

if settings.startup["settings-loaders-active"].value then
data:extend
({
{
    type = "recipe",
    name = "basic-loader",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {type="item", name="burner-inserter", amount= loader_inserter_count * loader_cost_mult},
      {type="item", name="electronic-circuit", amount=2 * loader_cost_mult},
      {type="item", name="basic-transport-belt", amount=loader_belt_count * loader_cost_mult}
    },
    results = {{type="item", name="basic-loader", amount=1}},
  },
{
    type = "recipe",
    name = "loader",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
      {type="item", name="inserter", amount=loader_inserter_count * loader_cost_mult},
      {type="item", name="transport-belt", amount=loader_belt_count * loader_cost_mult},
	  {type="item", name="basic-loader", amount=1}
    },
    results = {{type="item", name="loader", amount=1}},
  },
  {
    type = "recipe",
    name = "fast-loader",
    enabled = false,
    energy_required = 8,
    ingredients =
    {
	  {type="item", name="long-handed-inserter", amount=loader_inserter_count * loader_cost_mult},
      {type="item", name="fast-transport-belt", amount=loader_belt_count * loader_cost_mult},
      {type="item", name="loader", amount=1}
    },
    results = {{type="item", name="fast-loader", amount=1}},
  },
  {
    type = "recipe",
    name = "express-loader",
    enabled = false,
	category = "crafting-with-fluid",
    energy_required = 14,
    ingredients =
    {
	{type="fluid", name="lubricant", amount=15 * loader_cost_mult},
	  {type="item", name="fast-inserter", amount=loader_inserter_count * loader_cost_mult},
      {type="item", name="express-transport-belt", amount=loader_belt_count * loader_cost_mult},
      {type="item", name="fast-loader", amount=1}
    },
    results = {{type="item", name="express-loader", amount=1}},
  },
    {
    type = "recipe",
    name = "turbo-loader",
    enabled = false,
	category = "crafting-with-fluid",
    energy_required = 22,
    ingredients =
    {
	  {type="fluid", name="lubricant", amount=30 * loader_cost_mult},
      {type="item", name="turbo-transport-belt", amount=loader_belt_count * loader_cost_mult},
	  {type="item", name="bulk-inserter", amount=loader_inserter_count * loader_cost_mult},
      {type="item", name="express-loader", amount=1}
    },
    results = {{type="item", name="turbo-loader", amount=1}},
  },
      {
    type = "recipe",
    name = "supersonic-loader",
    enabled = false,
	category = "crafting-with-fluid",
    energy_required = 32,
    ingredients =
    {
	  {type="fluid", name="lubricant", amount=60 * loader_cost_mult},
      {type="item", name="supersonic-transport-belt", amount=loader_belt_count * loader_cost_mult},
	  {type="item", name="very-long-handed-inserter", amount=loader_inserter_count * loader_cost_mult},
      {type="item", name="turbo-loader", amount=1}
    },
    results = {{type="item", name="supersonic-loader", amount=1}},
  },
})
end
  
  -- OTHERS
 data:extend
({ 
{
    type = "recipe",
    name = "steam-turbine",
    enabled = false,
	category = "crafting-with-fluid",
    energy_required = 5,
    ingredients = {{type="item", name="iron-gear-wheel", amount=40}, {type="item", name="copper-plate", amount=20}, {type="item", name="pipe", amount=20}, {type="fluid", name="lubricant", amount=20}},
    results = {{type="item", name="steam-turbine", amount=1}},
  },
  {
    type = "recipe",
    name = "basic-lab",
	enabled = false,
    energy_required = 3,
    ingredients =
    {
      {type="item", name="electronic-circuit", amount=6},
      {type="item", name="iron-stick", amount=8},
      {type="item", name="basic-transport-belt", amount=12}
    },
    results = {{type="item", name="basic-lab", amount=1}},
  },
{
    type = "recipe",
    name = "lab",
    energy_required = 9,
	enabled = false,
    ingredients =
    {
	  {type="item", name="basic-lab", amount=1},
      {type="item", name="advanced-circuit", amount=8},
      {type="item", name="iron-plate", amount=12},
      {type="item", name="fast-transport-belt", amount=12}
    },
    results = {{type="item", name="lab", amount=1}},
  },
  {
    type = "recipe",
    name = "lab-large",
    energy_required = 18,
	enabled = false,
    ingredients =
    {
	  {type="item", name="lab", amount=1},
      {type="item", name="processing-unit", amount=10},
      {type="item", name="steel-plate", amount=16},
      {type="item", name="express-transport-belt", amount=12}
    },
    results = {{type="item", name="lab-large", amount=1}},
  },
 {
    type = "recipe",
    name = "small-lamp",
    enabled = false,
    ingredients =
    {
      {type="item", name="copper-cable", amount=4},
      {type="item", name="glass-plate", amount=1},
      {type="item", name="iron-plate", amount=1}
    },
    results = {{type="item", name="small-lamp", amount=1}},
  },
   {
    type = "recipe",
    name = "radar",
	energy_required = 8,
	 enabled = false,
    ingredients =
    {
      {type="item", name="electronic-circuit", amount=5},
      {type="item", name="iron-gear-wheel", amount=5},
      {type="item", name="iron-plate", amount=10}
    },
    results = {{type="item", name="radar", amount=1}},
  },
  -- {
    -- type = "recipe",
    -- name = "steel-furnace",
    -- ingredients = {{type="item", name="steel-plate", amount=4}, {type="item", name="stone-brick", amount=6}, {type="item", name="stone-furnace", amount=1}},
    -- results = {{type="item", name="steel-furnace", amount=1}},
    -- enabled = false
  -- },
  {
    type = "recipe",
    name = "low-density-structure",
    category = "crafting",
	energy_required = 20,
	enabled = false,
	ingredients =
	{
	{type="item", name="steel-plate", amount=2},
	{type="item", name="copper-plate", amount=10},
	{type="item", name="plastic-bar", amount=4},
	{type="item", name="aluminium-plate", amount=6}
	},
	 results = {{type="item", name="low-density-structure", amount=1}},
	 allow_productivity = true
  },

	
  {
    type = "recipe",
    name = "advanced-circuit",
	enabled = false,
	energy_required = 6,
	ingredients =
	{
	{type="item", name="electronic-circuit", amount=2},
	{type="item", name="plastic-bar", amount=2},
	{type="item", name="copper-cable", amount=4},
	--{type="item", name="silicon-wafer", amount=1},
	},
	results = {{type="item", name="advanced-circuit", amount=1}},
	allow_productivity = true,
  },
 {
    type = "recipe",
    name = "bio-science-pack",
	 --category = "crafting-with-fluid",
    enabled = false,
    energy_required = 25,
    ingredients =
    {
      {type="item", name="wood", amount= 15},
      {type="item", name="meaty-chunks", amount = 20},
      {type = "item", name = "raw-fish", amount = 1}
    },
    results = {{type="item", name="bio-science-pack", amount=2}},
	allow_productivity = true,
  },
  
   {
    type = "recipe",
    name = "chunky-meat-processing",
    enabled = false,
    energy_required = 16,
    ingredients =
    {
      {type="item", name="chunky-meat", amount=1},
    },
    results = {{type="item", name="meaty-chunks", amount=10}},
	allow_productivity = true,
  },
  {
    type = "recipe",
    name = "processing-unit",
    category = "crafting-with-fluid",

      enabled = false,
      energy_required = 10,
      ingredients =
      {
        {type="item", name="electronic-circuit", amount=6},
        {type="item", name="advanced-circuit", amount=1},
		{type="item", name="silicon-wafer", amount=1},
        {type = "fluid", name = "sulfuric-acid", amount = 5}
      },
      results = {{type="item", name="processing-unit", amount=1}},
	allow_productivity = true,
   },
   {
    type = "recipe",
    name = "cpu-item",

      enabled = false,
      energy_required = 20,
	  category = "advanced-crafting",
      ingredients =
      {
		{type="item", name="advanced-circuit", amount=2},
        {type="item", name="processing-unit", amount=2},
		{type="item", name="silicon-wafer", amount=2},
		{type="item", name="aluminium-plate", amount=2},
      },
      results = {{type="item", name="cpu-item", amount=1}},
	  allow_productivity = true,
   },
  {
    type = "recipe",
    name = "medium-wooden-electric-pole",
	enabled = false,
    ingredients =
    {
	  {type="item", name="iron-plate", amount=1},
	  {type="item", name="wood", amount=2},
      {type="item", name="copper-cable", amount=4}
    },
    results = {{type="item", name="medium-wooden-electric-pole", amount=1}},
  },
   {
    type = "recipe",
    name = "electrical-distributor",
	enabled = false,
    ingredients =
    {
      {type="item", name="substation", amount=1},
      {type="item", name="processing-unit", amount=8},
      {type="item", name="accumulator", amount=2}
    },
    results = {{type="item", name="electrical-distributor", amount=1}},
  },
    {
    type = "recipe",
    name = "huge-electric-pole",
	enabled = false,
    ingredients =
    {
      {type="item", name="big-electric-pole", amount=1},
      {type="item", name="aluminium-plate", amount=6},
      {type="item", name="concrete", amount=10},
    },
    results = {{type="item", name="huge-electric-pole", amount=1}},
  },
   -- {
    -- type = "recipe",
    -- name = "railgun",
    -- energy_required = 18,
	-- enabled = false,
    -- ingredients =
    -- {
      -- {type="item", name="steel-plate", amount=15},
      -- {type="item", name="copper-plate", amount=15},
      -- {type="item", name="electronic-circuit", amount=10},
      -- {type="item", name="advanced-circuit", amount=5}
    -- },
    -- results = {{type="item", name="railgun", amount=1}},
  -- },
  
       -- {
    -- type = "recipe",
    -- name = "laser-gun",
	-- enabled = false,
    -- energy_required = 15,
    -- ingredients =
    -- {
      -- {type="item", name="steel-plate", amount=5},
	  -- {type="item", name="laser", amount=1},
      -- {type="item", name="battery", amount=2},
    -- },
    -- results = {{type="item", name="laser-gun", amount=1}},
  -- },
  
   {
    type = "recipe",
    name = "plasma-gun",
	enabled = false,
    energy_required = 15,
    ingredients =
    {
	  {type="item", name="aluminium-plate", amount=20},
      {type="item", name="processing-unit", amount=10},
	  {type="item", name="laser", amount=4},
      {type="item", name="accumulator", amount=4},
    },
    results = {{type="item", name="plasma-gun", amount=1}},
  },
   
   {
    type = "recipe",
    name = "mini-gun",
    energy_required = 20,
	enabled = false,
    ingredients =
    {
      {type="item", name="steel-plate", amount=15},
      {type="item", name="iron-gear-wheel", amount=30},
	  {type="item", name="pipe", amount=20},
    },
    results = {{type="item", name="mini-gun", amount=1}},
  },
   
    {
    type = "recipe",
    name = "roboport-major",
    energy_required = 30,
	enabled = false,
    ingredients =
    {
      {type="item", name="roboport", amount=5},
      {type="item", name="accumulator-battery", amount=10},
      {type="item", name="processing-unit", amount=40}
    },
    results = {{type="item", name="roboport-major", amount=1}},
  },
   {
    type = "recipe",
    name = "landfill",
    energy_required = 6,
    enabled = false,
    category = "crafting",
    ingredients =
    {
      {type="item", name="stone", amount=6}
    },
	results = {{type="item", name="landfill", amount=1}},
  },
   {
    type = "recipe",
    name = "vehicle-chassis",
    energy_required = 4,
	enabled = false,
    ingredients =
    {
      {type="item", name="engine-unit", amount=4},
      {type="item", name="iron-plate", amount=10},
      {type="item", name="steel-plate", amount=4}
    },
    results = {{type="item", name="vehicle-chassis", amount=1}},
	allow_productivity = true,
  },
   {
    type = "recipe",
    name = "cannon",
	enabled = false,
    energy_required = 4,
    ingredients =
    {
		{type="item", name="iron-gear-wheel", amount=10},
		{type="item", name="steel-plate", amount=12},
		{type="item", name="pipe", amount=6},
    },
    results = {{type="item", name="cannon", amount=1}},
	allow_productivity = true,
  },
  {
    type = "recipe",
    name = "laser",
    energy_required = 4,
	enabled = false,
    ingredients =
    {
      {type="item", name="electronic-circuit", amount=12},
      {type="item", name="battery", amount=8},
	  {type="item", name="glass-plate", amount=4}
    },
    results = {{type="item", name="laser", amount=1}},
	allow_productivity = true,
  },
   {
    type = "recipe",
    name = "turret-base",
    energy_required = 4,
	enabled = false,
    ingredients =
    {
		{type="item", name="iron-gear-wheel", amount=6},
		{type="item", name="iron-plate", amount=6},
		{type="item", name="electronic-circuit", amount=1},
    },
    results = {{type="item", name="turret-base", amount=1}},
	allow_productivity = true,
  },
  {
    type = "recipe",
    name = "basic-wall",
    enabled = true,
	energy_required = 0.5,
    ingredients = {{type="item", name="stone", amount=8}},
    results = {{type="item", name="basic-wall", amount=4}},
  },
  -- {
    -- type = "recipe",
    -- name = "reinforced-wall",
    -- enabled = false,
    -- ingredients = 
	-- {
	-- {type="item", name="refined-concrete", amount=8},
	-- {type="item", name="steel-plate", amount=2},
	-- },
    -- results = {{type="item", name="reinforced-wall", amount=1}},
  -- },

  {
    type = "recipe",
    name = "grenade-launcher",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {type="item", name="iron-plate", amount=6},
      {type="item", name="pipe", amount=10},
      {type="item", name="steel-plate", amount=12}
    },
    results = {{type="item", name="grenade-launcher", amount=1}},
  },
  
  {
    type = "recipe",
    name = "multirocket-launcher",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {type="item", name="advanced-circuit", amount=15},
      {type="item", name="rocket-launcher", amount=4},
      {type="item", name="steel-plate", amount=40}
    },
    results = {{type="item", name="multirocket-launcher", amount=1}},
  },
  
    {
    type = "recipe",
    name = "charcoal",
	category = "smelting",
    energy_required = 15,
	allow_productivity = true,
    ingredients =
    {
      {type="item", name="wood", amount=4},
    },
    results = {{type="item", name="charcoal", amount=10}},
  },
   {
    type = "recipe",
    name = "uzi-gun",
	enabled = false,
    energy_required = 8,
    ingredients =
    {
      {type="item", name="steel-plate", amount=2},
	  {type="item", name="iron-gear-wheel", amount=6},
	  {type = "item", name = "iron-plate", amount = 8},
    },
    results = {{type="item", name="uzi-gun", amount=1}},
  },
    {
    type = "recipe",
    name = "magnum",
	enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="steel-plate", amount=8},
	  {type="item", name="iron-gear-wheel", amount=1},
      {type="item", name="wood", amount=2},
    },
    results = {{type="item", name="magnum", amount=1}},
  },
      {
    type = "recipe",
    name = "blunderbuss",
	enabled = false,
    energy_required = 16,
    ingredients =
    {
      {type="item", name="steel-plate", amount=18},
	  {type="item", name="aluminium-plate", amount=8},
      {type="item", name="wood", amount=4},
    },
    results = {{type="item", name="blunderbuss", amount=1}},
  },
      {
    type = "recipe",
    name = "sniper-rifle",
	enabled = false,
    energy_required = 20,
    ingredients =
    {
      {type="item", name="steel-plate", amount=10},
	  {type="item", name="aluminium-plate", amount=12},
      {type="item", name="wood", amount=5},
    },
    results = {{type="item", name="sniper-rifle", amount=1}},
  },
})

 ---------------------------------------------------  OVERRIDES  ------------------------------------------------------------
 
data:extend({
 {
    type = "recipe",
    name = "night-vision-equipment",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="advanced-circuit", amount=2},
      {type="item", name="steel-plate", amount=6},
	  {type="item", name="glass-plate", amount=2},
    },
    results = {{type="item", name="night-vision-equipment", amount=1}},
  },
  {
    type = "recipe",
    name = "fission-reactor-equipment",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {type="item", name="processing-unit", amount=5},
      {type="item", name="low-density-structure", amount=40},
	  {type="item", name="uranium-fuel-cell", amount=3}
    },
    results = {{type="item", name="fission-reactor-equipment", amount=1}},
  },



})
  
--

if (mods["space-age"]) then

	data.raw.recipe["rocket-part"].energy_required = data.raw.recipe["rocket-part"].energy_required * 2
	data.raw["rocket-silo"]["rocket-silo"].rocket_parts_required = 20

	data.raw.recipe["rocket-part"].ingredients =
	{
	  {type = "item", name = "processing-unit", amount = 2},
	  {type = "item", name = "low-density-structure", amount = 2},
	  {type = "item", name = "true-rocket-fuel", amount = 1}
	}

else
	-- Multiply by the mod settings.
	data.raw.recipe["rocket-part"].energy_required = data.raw.recipe["rocket-part"].energy_required * settings.startup["settings-rocket-recipe-energy"].value
	data.raw.recipe["rocket-part"].ingredients =
	{
		  {type="item", name="processing-unit", amount=10*settings.startup["settings-rocket-recipe"].value},
		  {type="item", name="low-density-structure", amount=10*settings.startup["settings-rocket-recipe"].value},
		  {type="item", name="true-rocket-fuel", amount=5*settings.startup["settings-rocket-recipe"].value }
	}
end


  
  -- {
    -- type = "recipe",
    -- name = "rocket-part",
    -- energy_required = settings.startup["settings-rocket-recipe-energy"].value,
    -- enabled = false,
    -- hidden = true,
	-- allow_productivity = true,
    -- category = "rocket-building",
    -- ingredients =
    -- {
      -- {type="item", name="processing-unit", amount=settings.startup["settings-rocket-recipe"].value},
      -- {type="item", name="low-density-structure", amount=settings.startup["settings-rocket-recipe"].value},
      -- {type="item", name="true-rocket-fuel", amount=math.floor( settings.startup["settings-rocket-recipe"].value/2 ) }
    -- },
	-- results = {{type="item", name="rocket-part", amount=1}},
  -- },
  
data.extend({
  {
    type = "recipe",
    name = "car-base",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
      {type="item", name="vehicle-chassis", amount=1},
	  {type="item", name="iron-plate", amount=4}
    },
    results = {{type="item", name="car-base", amount=1}},
  },
  {
    type = "recipe",
    name = "car",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
      {type="item", name="car-base", amount=1},
      {type="item", name="submachine-gun", amount=1},
    },
    results = {{type="item", name="car", amount=1}},
  },
   {
    type = "recipe",
    name = "car-shotgun",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
      {type="item", name="car-base", amount=1},
      {type="item", name="shotgun", amount=1},
    },
    results = {{type="item", name="car-shotgun", amount=1}},
  },
   {
    type = "recipe",
    name = "atv",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
		{type="item", name="steel-plate", amount=4},
		{type="item", name="iron-gear-wheel", amount=4},
		{type="item", name="electronic-circuit", amount=2}
    },
    results = {{type="item", name="atv", amount=1}},
  },
    {
    type = "recipe",
    name = "atv-drone",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
		{type="item", name="atv", amount=1},
		{type="item", name="submachine-gun", amount=1},
		{type="item", name="advanced-circuit", amount=3}
    },
    results = {{type="item", name="atv-drone", amount=1}},
  },
    {
    type = "recipe",
    name = "atv-exploding",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
		{type="item", name="atv", amount=1},
		{type="item", name="grenade", amount=20}
    },
    results = {{type="item", name="atv-exploding", amount=1}},
  },
  {
    type = "recipe",
    name = "apc-base",
    enabled = false,
    energy_required = 6,
    ingredients =
    {
      {type="item", name="vehicle-chassis", amount=3},
	  {type="item", name="electronic-circuit", amount=6}
    },
    results = {{type="item", name="apc-base", amount=1}},
  },
    {
    type = "recipe",
    name = "apc-twinsmg",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
      {type="item", name="apc-base", amount=1},
	  {type="item", name="submachine-gun", amount=4}
    },
    results = {{type="item", name="apc-twinsmg", amount=1}},
  },
     {
    type = "recipe",
    name = "apc-autoshotgun",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
      {type="item", name="apc-base", amount=1},
	  {type="item", name="combat-shotgun", amount=1}
    },
    results = {{type="item", name="apc-autoshotgun", amount=1}},
  },
  {
    type = "recipe",
    name = "apc-rocket",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
      {type="item", name="apc-base", amount=1},
	  {type="item", name="rocket-launcher", amount=1}
    },
    results = {{type="item", name="apc-rocket", amount=1}},
  },
  {
    type = "recipe",
    name = "tank",
  enabled = false,
  energy_required = 30,
  ingredients =
  {
	{type="item", name="vehicle-chassis", amount=20},
	{type="item", name="cannon", amount=1},
	{type="item", name="advanced-circuit", amount=30}
  },
  results = {{type="item", name="tank", amount=1}},
  },
   {
    type = "recipe",
    name = "flame-tank",
  energy_required = 16,
  enabled = false,
  ingredients =
  {
	{type="item", name="vehicle-chassis", amount=10},
	{type="item", name="flamethrower", amount=2},
	{type="item", name="pipe", amount=8}
  },
  results = {{type="item", name="flame-tank", amount=1}},
  },
{
    type = "recipe",
    name = "gun-turret",
    enabled = false,
    energy_required = 8,
    ingredients =
    {
      {type="item", name="turret-base", amount=1},
      {type="item", name="submachine-gun", amount=1},
    },
    results = {{type="item", name="gun-turret", amount=1}},
  },
  {
    type = "recipe",
    name = "heavygun-turret",
    enabled = false,
    energy_required = 16,
    ingredients =
    {
      {type="item", name="turret-base", amount=2},
	  {type="item", name="gun-turret", amount=2},
      {type="item", name="submachine-gun", amount=2},
    },
    results = {{type="item", name="heavygun-turret", amount=1}},
  },
{
    type = "recipe",
    name = "laser-turret",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {type="item", name="turret-base", amount=1},
      {type="item", name="laser", amount=1},
    },
    results = {{type="item", name="laser-turret", amount=1}},
  },
  {
    type = "recipe",
    name = "flamethrower",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="steel-plate", amount=5},
      {type="item", name="iron-gear-wheel", amount=5},
	  {type="item", name="pipe", amount=4}
    },
    results = {{type="item", name="flamethrower", amount=1}},
  },
  {
    type = "recipe",
    name = "flamethrower-turret",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {type="item", name="turret-base", amount=1},
      {type="item", name="flamethrower", amount=1},
      {type="item", name="engine-unit", amount=2}
    },
    results = {{type="item", name="flamethrower-turret", amount=1}},
  },
  {
    type = "recipe",
    name = "artillery-turret",
    enabled = false,
    energy_required = 40,
    ingredients =
    {
      {type="item", name="turret-base", amount=4},
      {type="item", name="concrete", amount=60},
      {type="item", name="advanced-circuit", amount=20}
    },
    results = {{type="item", name="artillery-turret", amount=1}},
  },
    {
    type = "recipe",
    name = "cooked-fish",
	enabled = true,
    category = "smelting",
    energy_required = 10,
    ingredients = {{type="item", name="raw-fish", amount=1}},
    results = {{type="item", name="cooked-fish", amount=1}},
  },
     {
    type = "recipe",
    name = "med-pack",
	enabled = false,
    energy_required = 20,
    ingredients = 
	{
	{type="item", name="meaty-chunks", amount=10},
	{type="item", name="cooked-fish", amount=1},
	{type="item", name="iron-plate", amount=2}
	},
    results = {{type="item", name="med-pack", amount=1}},
  },
   {
    type = "recipe",
    name = "solar-train",
	enabled = false,
    energy_required = 25,
    ingredients = 
	{
	{type="item", name="vehicle-chassis", amount=4},
	{type="item", name="solar-panel", amount=20},
	{type="item", name="accumulator", amount=10}
	},
    results = {{type="item", name="solar-train", amount=1}},
  },
  {
    type = "recipe",
    name = "cargo-wagon-equipment",
	enabled = false,
    energy_required = 35,
    ingredients = 
	{
	{type="item", name="cargo-wagon", amount=1},
	{type="item", name="advanced-circuit", amount= 40},
	{type = "item", name = "steel-plate", amount = 40}
	},
    results = {{type="item", name="cargo-wagon-equipment", amount=1}},
  },
  
})

-- RECIPE DIFFICULTY

if settings.startup["settings-recipe-cost"].value == "easy" then

	data.raw["recipe"]["automation-science-pack"].ingredients =
		{
			{type = "item", name = "copper-plate", amount = 1},
			{type = "item", name = "iron-plate", amount = 1}
		}
	data.raw["recipe"]["logistic-science-pack"].ingredients =
		{
		  {type = "item", name = "burner-inserter", amount = 1},
		  {type = "item", name = "basic-transport-belt", amount = 1}
		}
	data.raw["recipe"]["military-science-pack"].ingredients =	
		{
		  {type = "item", name = "firearm-magazine", amount = 1},
		  {type = "item", name = "grenade", amount = 1},
		  {type = "item", name = "stone-wall", amount = 1}
		}
	data.raw["recipe"]["bio-science-pack"].ingredients =	
		{
		  {type="item", name="wood", amount= 5},
		  {type="item", name="meaty-chunks", amount = 10},
		}
	data.raw["recipe"]["chemical-science-pack"].ingredients =	
		{
		  {type = "item", name = "steel-plate", amount = 3},
		  {type = "item", name = "plastic-bar", amount = 3},
		  {type = "item", name = "petroleum-fuel", amount = 1}
		}
	data.raw["recipe"]["production-science-pack"].ingredients =	
		{
		  {type = "item", name = "advanced-circuit", amount = 4},
		  {type = "item", name = "basic-electric-furnace", amount = 1},
		  {type = "item", name = "rail", amount = 20}
		}
	data.raw["recipe"]["utility-science-pack"].ingredients =	
		{
		  {type = "item", name = "aluminium-plate", amount = 6},
		  {type = "item", name = "processing-unit", amount = 2},
		  {type = "item", name = "electric-engine-unit", amount = 1}
		}
		
elseif settings.startup["settings-recipe-cost"].value == "hard" then

	data.raw["recipe"]["automation-science-pack"].ingredients =
		{
			{type = "item", name = "electronic-circuit", amount = 1},
			{type = "item", name = "iron-gear-wheel", amount = 1}
		}
	data.raw["recipe"]["logistic-science-pack"].ingredients =
		{
		  {type = "item", name = "inserter", amount = 1},
		  {type = "item", name = "transport-belt", amount = 1},
		   {type = "item", name = "small-electric-pole", amount = 2}
		}
	data.raw["recipe"]["military-science-pack"].ingredients =	
		{
		  {type = "item", name = "piercing-rounds-magazine", amount = 1},
		  {type = "item", name = "submachine-gun", amount = 1},
		  {type = "item", name = "grenade", amount = 2},
		  {type = "item", name = "stone-wall", amount = 2}
		}
	data.raw["recipe"]["bio-science-pack"].ingredients =	
		{
			{type="item", name="charcoal", amount= 10},
			{type="item", name="meaty-chunks", amount = 20},
			{type="item", name = "cooked-fish", amount = 1},
		}
	data.raw["recipe"]["chemical-science-pack"].ingredients =	
	 {
		  {type = "item", name = "engine-unit", amount = 2},
		  {type = "item", name = "advanced-circuit", amount = 3},
		  {type = "item", name = "silicon-wafer", amount = 2},
		  {type = "item", name = "sulfur", amount = 1}
		}
	data.raw["recipe"]["production-science-pack"].ingredients =	
		{
		  {type = "item", name = "electric-furnace", amount = 1},
		  {type = "item", name = "productivity-module", amount = 1},
		  {type = "item", name = "rail", amount = 30},
		  {type = "item", name = "concrete", amount = 10},
		}
	data.raw["recipe"]["utility-science-pack"].ingredients =	
		{
		  {type = "item", name = "low-density-structure", amount = 3},
		  {type = "item", name = "processing-unit", amount = 2},
		  {type = "item", name = "flying-robot-frame", amount = 1},
		  {type = "item", name = "laser", amount = 1}
		}
	
elseif settings.startup["settings-recipe-cost"].value == "extreme" then

	data.raw["recipe"]["automation-science-pack"].ingredients =
		{
			{type = "item", name = "electronic-circuit", amount = 1},
			{type = "item", name = "stone-brick", amount = 1},
			{type = "item", name = "iron-gear-wheel", amount = 1}
		}
	data.raw["recipe"]["logistic-science-pack"].ingredients =
		{
			{type = "item", name = "inserter", amount = 1},
			{type = "item", name = "transport-belt", amount = 1},
			{type = "item", name = "small-lamp", amount = 2},
			{type = "item", name = "small-electric-pole", amount = 2}
		}
	data.raw["recipe"]["military-science-pack"].ingredients =	
		{
		  {type = "item", name = "piercing-rounds-magazine", amount = 1},
		  {type = "item", name = "gun-turret", amount = 1},
		  {type = "item", name = "grenade", amount = 2},
		  {type = "item", name = "stone-wall", amount = 2}
		}
	data.raw["recipe"]["bio-science-pack"].ingredients =	
		{
			{type="item", name="charcoal", amount= 10},
			{type="item", name="meaty-chunks", amount = 20},
			{type="item", name="nat-gas-fuel", amount = 1},
			{type = "item", name = "cooked-fish", amount = 1},
		}
	data.raw["recipe"]["chemical-science-pack"].ingredients =	
	 {
		  {type = "item", name = "engine-unit", amount = 2},
		  {type = "item", name = "advanced-circuit", amount = 3},
		  {type = "item", name = "silicon-wafer", amount = 2},
		  {type = "item", name = "explosives", amount = 1}
		}
	data.raw["recipe"]["production-science-pack"].ingredients =	
		{
		  {type = "item", name = "electric-furnace", amount = 1},
		  {type = "item", name = "productivity-module", amount = 1},
		  {type = "item", name = "rail", amount = 30},
		  {type = "item", name = "landfill-deep", amount = 6},
		}
	data.raw["recipe"]["utility-science-pack"].ingredients =	
		{
		  {type = "item", name = "low-density-structure", amount = 3},
		  {type = "item", name = "processing-unit", amount = 2},
		  {type = "item", name = "logistic-robot", amount = 1},
		  {type = "item", name = "construction-robot", amount = 1},
		  {type = "item", name = "laser", amount = 1}
		}
	
end

