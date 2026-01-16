-- Space age overrides

-- RECIPE DIFFICULTY

if settings.startup["settings-recipe-cost"].value == "easy" then

	data.raw["recipe"]["space-science-pack"].ingredients =
	{
		{type = "item", name = "carbon", amount = 1},
		{type = "item", name = "ice", amount = 1}
	}
		
	data.raw["recipe"]["metallurgic-science-pack"].ingredients =
	{
	  {type = "item", name = "tungsten-carbide", amount = 3},
	  {type = "item", name = "tungsten-plate", amount = 2},
	  {type = "fluid", name = "molten-lava", amount = 200},
	}
	
	data.raw["recipe"]["agricultural-science-pack"].ingredients =
	{
		{type = "item", name = "bioflux", amount = 1},
		{type = "item", name = "spoilage", amount = 1}
	}
	
	data.raw["recipe"]["electromagnetic-science-pack"].ingredients =
    {
      {type = "item", name = "supercapacitor", amount = 1},
      {type = "item", name = "accumulator", amount = 1},
      {type = "fluid", name = "electrolyte", amount = 25},
    }
	
	data.raw["recipe"]["cryogenic-science-pack"].ingredients =
    {
      {type = "item", name = "lithium-plate", amount = 1},
      {type = "fluid", name = "fluoroketone-cold", amount = 6, ignored_by_stats = 3}
    }
	
		data.raw["recipe"]["promethium-science-pack"].ingredients =
    {
      {type = "item", name = "promethium-asteroid-chunk", amount = 25},
      {type = "item", name = "quantum-processor", amount = 1},
    }
		
		
elseif settings.startup["settings-recipe-cost"].value == "hard" then

	data.raw["recipe"]["space-science-pack"].ingredients =
	{
		{type = "item", name = "steel-plate", amount = 1},
		{type = "item", name = "carbon", amount = 1},
		{type = "item", name = "ice", amount = 1}
	}
		
	data.raw["recipe"]["metallurgic-science-pack"].ingredients =
	{
		{type = "item", name = "tungsten-carbide", amount = 3},
		{type = "item", name = "tungsten-plate", amount = 2},
		{type = "fluid", name = "molten-copper", amount = 200},
		{type = "item", name = "calcite", amount = 6},
	}
			
	data.raw["recipe"]["agricultural-science-pack"].ingredients =
	{
		{type = "item", name = "bioflux", amount = 1},
		{type = "item", name = "pentapod-egg", amount = 1},
		{type = "item", name = "nutrients", amount = 10},
	}
	
	data.raw["recipe"]["electromagnetic-science-pack"].ingredients =
    {
      {type = "item", name = "supercapacitor", amount = 1},
      {type = "item", name = "accumulator", amount = 1},
	  {type = "item", name = "holmium-plate", amount = 1},
      {type = "fluid", name = "electrolyte", amount = 25},
      {type = "fluid", name = "holmium-solution", amount = 25},
    }
		
	data.raw["recipe"]["cryogenic-science-pack"].ingredients =
    {
      {type = "item", name = "ice", amount = 3},
      {type = "item", name = "lithium-plate", amount = 1},
	  {type = "fluid", name = "ammonia", amount = 10},
      {type = "fluid", name = "fluoroketone-cold", amount = 6, ignored_by_stats = 3},
    }
	
	data.raw["recipe"]["promethium-science-pack"].ingredients =
    {
      {type = "item", name = "promethium-asteroid-chunk", amount = 25},
      {type = "item", name = "quantum-processor", amount = 1},
	  {type = "item", name = "supercapacitor", amount = 1},
      {type = "item", name = "biter-egg", amount = 10}
    }
	
elseif settings.startup["settings-recipe-cost"].value == "extreme" then
	
	data.raw["recipe"]["space-science-pack"].ingredients =
	{
		{type = "item", name = "steel-plate", amount = 1},
		{type = "item", name = "carbon", amount = 1},
		{type = "item", name = "ice", amount = 1},
		{type = "item", name = "carbonic-asteroid-chunk", amount = 1},
		{type = "item", name = "oxide-asteroid-chunk", amount = 1}
	}
	
	data.raw["recipe"]["metallurgic-science-pack"].ingredients =
	{
		{type = "item", name = "tungsten-carbide", amount = 3},
		{type = "item", name = "tungsten-plate", amount = 2},
		{type = "fluid", name = "molten-copper", amount = 200},
		{type = "item", name = "aluminium-plate", amount = 10},
		{type = "item", name = "calcite", amount = 6},
	}
	
		data.raw["recipe"]["agricultural-science-pack"].ingredients =
	{
		{type = "item", name = "bioflux", amount = 1},
		{type = "item", name = "pentapod-egg", amount = 1},
		{type = "item", name = "yumako-seed", amount = 1},
		{type = "item", name = "jellynut-seed", amount = 1},
		{type = "item", name = "nutrients", amount = 10},
	}
	
		data.raw["recipe"]["electromagnetic-science-pack"].ingredients =
    {
      {type = "item", name = "supercapacitor", amount = 1},
	  {type = "item", name = "superconductor", amount = 2},
      {type = "item", name = "accumulator", amount = 1},
	  {type = "item", name = "holmium-plate", amount = 1},
      {type = "fluid", name = "electrolyte", amount = 25},
      {type = "fluid", name = "holmium-solution", amount = 25},
    }
	
		data.raw["recipe"]["cryogenic-science-pack"].ingredients =
    {
      {type = "item", name = "ice", amount = 3},
      {type = "item", name = "lithium-plate", amount = 1},
	  {type = "item", name = "lithium", amount = 10},
	  {type = "fluid", name = "ammonia", amount = 10},
      {type = "fluid", name = "fluoroketone-cold", amount = 6, ignored_by_stats = 3},
    }
	
	data.raw["recipe"]["promethium-science-pack"].ingredients =
	{
      {type = "item", name = "promethium-asteroid-chunk", amount = 25},
      {type = "item", name = "quantum-processor", amount = 1},
	  {type = "item", name = "supercapacitor", amount = 1},
	  {type = "item", name = "carbon-fiber", amount = 4},
      {type = "item", name = "biter-egg", amount = 10}
    }
		
elseif settings.startup["settings-recipe-cost"].value == "insane" then

	data.raw["recipe"]["space-science-pack"].category = "crafting-with-fluid"
	data.raw["recipe"]["space-science-pack"].ingredients =
	{
		{type = "item", name = "steel-plate", amount = 1},
		{type = "item", name = "carbon", amount = 1},
		{type = "fluid", name = "water", amount = 20},
		{type = "item", name = "carbonic-asteroid-chunk", amount = 1},
		{type = "item", name = "oxide-asteroid-chunk", amount = 1}
	}

	data.raw["recipe"]["metallurgic-science-pack"].ingredients =
	{
		{type = "item", name = "tungsten-carbide", amount = 3},
		{type = "item", name = "tungsten-plate", amount = 2},
		{type = "fluid", name = "molten-copper", amount = 200},
		{type = "fluid", name = "molten-iron", amount = 200},
		{type = "item", name = "aluminium-plate", amount = 10},
		{type = "item", name = "calcite", amount = 6},
	}
	
		data.raw["recipe"]["agricultural-science-pack"].ingredients =
	{
		{type = "item", name = "bioflux", amount = 1},
		{type = "item", name = "pentapod-egg", amount = 1},
		{type = "item", name = "artificial-yumako-soil", amount = 1},
		{type = "item", name = "artificial-jellynut-soil", amount = 1},
		{type = "item", name = "nutrients", amount = 10},
	}
	
		data.raw["recipe"]["electromagnetic-science-pack"].ingredients =
    {
      {type = "item", name = "supercapacitor", amount = 1},
	  {type = "item", name = "superconductor", amount = 2},
      {type = "item", name = "accumulator", amount = 1},
	  {type = "item", name = "holmium-plate", amount = 1},
      {type = "fluid", name = "electrolyte", amount = 25},
      {type = "fluid", name = "holmium-solution", amount = 25},
	  {type = "item", name = "lightning-rod", amount = 1},
    }
	
		data.raw["recipe"]["cryogenic-science-pack"].ingredients =
	{
      {type = "item", name = "ice", amount = 3},
      {type = "item", name = "lithium-plate", amount = 1},
	  {type = "item", name = "lithium", amount = 1},
	  {type = "fluid", name = "lithium-brine", amount = 10},
	  {type = "fluid", name = "ammonia", amount = 10},
      {type = "fluid", name = "fluoroketone-cold", amount = 6, ignored_by_stats = 3},
    }
	
	data.raw["recipe"]["promethium-science-pack"].ingredients =
	{
      {type = "item", name = "promethium-asteroid-chunk", amount = 25},
      {type = "item", name = "quantum-processor", amount = 1},
	  {type = "item", name = "supercapacitor", amount = 1},
	  {type = "item", name = "carbon-fiber", amount = 4},
	  {type = "item", name = "tungsten-plate", amount = 2},
      {type = "item", name = "biter-egg", amount = 10}
    }
	
end

data.raw["recipe"]["casting-low-density-structure"].ingredients = 
    {
      {type = "fluid", name = "molten-iron", amount = 80},
      {type = "fluid", name = "molten-copper", amount = 250},
      {type = "item", name = "plastic-bar", amount = 4},
	  {type = "item", name = "aluminium-plate", amount = 6}
    }
	
data.extend({
	{
		type = "recipe",
		name = "molten-aluminium-from-lava",
		icon = "__factorioplus__/graphics/icons/molten-aluminium-from-lava.png",
		category = "metallurgy",
		subgroup = "vulcanus-processes",
		order = "a[melting]-b[lava-a]",
		auto_recycle = false,
		enabled = false,
		ingredients =
		{
		  {type = "fluid", name = "lava", amount = 500},
		  {type = "fluid", name = "sulfuric-acid", amount = 20},
		  {type = "item", name = "calcite", amount = 2},
		},
		energy_required = 24,
		results =
		{
		  {type = "fluid", name = "molten-aluminium", amount = 200},
		  {type = "item", name = "carbon", amount = 2},
		},
		allow_productivity = true
  },
  
	{
		type = "fluid",
		name = "molten-aluminium",
		icon = "__factorioplus__/graphics/icons/molten-aluminium.png",
		subgroup = "fluid",
		order = "b[new-fluid]-b[vulcanus]-b[molten-aluminium]",
		default_temperature = 2500,
		max_temperature = 3000,
		heat_capacity = "0.01kJ",
		base_color = {0.34, 0.34, 0.43},
		flow_color = {0.64, 0.68, 0.73},
		auto_barrel = false
	},

	{
		type = "recipe",
		name = "casting-aluminium",
		category = "metallurgy",
		subgroup = "vulcanus-processes",
		order = "b[casting]-b[casting-iron]",
		icon = "__factorioplus__/graphics/icons/aluminium-casting.png",
		enabled = false,
		ingredients =
		{
		  {type = "fluid", name = "molten-aluminium", amount = 40, fluidbox_multiplier = 10},
		},
		energy_required = 4,
		allow_decomposition = false,
		results = {{type = "item", name = "aluminium-plate", amount = 2}},
		allow_productivity = true
	},
})
  
-- Move pipe casting to pipe/fluid handling.

data.raw["recipe"]["casting-pipe"].subgroup = "pipes"
data.raw["recipe"]["casting-pipe-to-ground"].subgroup = "pipes"

-- Update turbo belt ingredients to match SA somewhat...

data.raw["recipe"]["turbo-transport-belt"].ingredients = 
{
	{type = "item", name = "tungsten-plate", amount = 10},
	{type = "item", name = "speed-module", amount=1},
	{type = "item", name = "express-transport-belt", amount = 2},
	{type = "fluid", name = "lubricant", amount = 20}
}

data.raw["recipe"]["turbo-splitter"].ingredients = 
{
	{type="item", name="express-splitter", amount=2},
	{type="item", name="tungsten-plate", amount=15},
	{type="item", name="speed-module", amount=2},
	{type="fluid", name="lubricant", amount=120}
}

data.raw["recipe"]["turbo-underground-belt"].ingredients =
{
	{type="item", name="express-underground-belt", amount=2},
	{type="item", name="tungsten-plate", amount=40},
	{type="item", name="speed-module", amount=1},
	{type="fluid", name="lubricant", amount=80}
}
	
-- Add turret base requirements to new turrets.
	
data.raw["recipe"]["railgun-turret"].ingredients = {
	{type = "item", name = "railgun", amount = 5},
	{type = "item", name = "carbon-fiber", amount = 30},
	{type = "item", name = "turret-base", amount = 10}
}
	
data.raw["recipe"]["tesla-turret"].ingredients = {
	 {type = "item", name = "teslagun", amount = 4},
	{type = "item", name = "supercapacitor", amount = 10},
      {type = "item", name = "processing-unit", amount = 10},
	  {type = "item", name = "turret-base", amount = 5}
}

data.extend({
  {
    type = "recipe",
    name = "glass-from-lava",
    category = "metallurgy",
    subgroup = "vulcanus-processes",
    order = "b[casting]-g[glass]",
    icon = "__factorioplus__/graphics/icons/glass-from-lava.png",
    enabled = false,
    ingredients =
    {
      {type = "fluid", name = "lava", amount = 500},
      {type = "fluid", name = "steam", amount = 200},
      {type = "item", name = "stone", amount = 20},
    },
    energy_required = 10,
    allow_decomposition = false,
    results = {{type = "item", name = "glass-plate", amount = 10}},
    allow_productivity = true
  },
})


-- this will allow fulgora to be rocket complete.
table.insert(data.raw["recipe"]["scrap-recycling"].results ,{type = "item", name = "explosives", amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false} )
table.insert(data.raw["recipe"]["scrap-recycling"].results ,{type = "item", name = "carbon", amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false} )

data.raw["furnace"]["recycler"].result_inventory_size = 14, -- Recycler needs the amount of free output slots as number of items recycled from scrap (default 12).

-- this will allow aquilo to be rocket complete.
table.insert(data.raw["technology"]["planet-discovery-aquilo"].effects , {type = "unlock-recipe", recipe = "ammonia-rocket-fuel-2"} )
data.raw["recipe"]["ammonia-rocket-fuel"].localised_name = {"recipe-name.ammonia-jet-fuel"}

data.extend({
  {
    type = "recipe",
    name = "ammonia-rocket-fuel-2",
    localised_name = {"recipe-name.ammonia-rocket-fuel"},
    icon = "__factorioplus__/graphics/icons/ammonia-true-rocket-fuel.png",
    energy_required = 20,
    enabled = false,
    category = "chemistry-or-cryogenics",
    subgroup = "aquilo-processes",
    order = "a[ammonia]-c[ammonia-rocket-fuel]",
    ingredients =
    {
      {type="item", name = "rocket-fuel", amount= 2},
      {type="fluid", name = "ammonia", amount = 1000}
    },
    results = {{type="item", name="true-rocket-fuel", amount=1}},
    allow_productivity = true,
    crafting_machine_tint =
    {
      primary = {r = 0.996, g = 0.442, b = 0.408, a = 1.000}, -- #febd68ff
      secondary = {r = 0.446, g = 0.192, b = 0.168, a = 1.000}, -- #71632aff
      tertiary = {r = 0.347, g = 0.188, b = 0.387, a = 1.000}, -- #586262ff
      quaternary = {r = 0.656, g = 0.362, b = 0.264, a = 1.000}, -- #a78f43ff
    }
  }
 })
 
-- this will allow gleba to be rocket complete.
data.raw["recipe"]["rocket-fuel-from-jelly"].localised_name = {"recipe-name.jet-fuel-from-jelly"}

data.extend({
  {
    type = "recipe",
    name = "bioexplosives",
    icon = "__factorioplus__/graphics/icons/bioexplosives.png",
    category = "organic",
    subgroup = "agriculture-products",
    order = "a[organic-products]-a[rocket-fuel-from-jelly]",
    auto_recycle = false,
    enabled = false,
    allow_productivity = true,
    energy_required = 8,
    ingredients =
    {
      {type = "item", name = "sulfur", amount = 1},
      {type = "item", name =  "carbon", amount = 3},
      {type = "item", name = "bioflux", amount = 1},
	  {type = "fluid", name = "water", amount = 15}
    },
    results = {{type="item", name="explosives", amount=1}},
    crafting_machine_tint =
    {
      primary = {r = 250, g = 66, b = 0, a = 1.000},
      secondary = {r = 0.8, g = 0.4, b = 0.1, a = 1.000},
    }
  },
  })
  
  
-- Allow alien chunks to be automated in space age (potentially merge with agrisci)
data.extend({
 {
    type = "recipe",
    name = "process-biter-egg-to-chunks",
    category = "crafting-with-fluid",
    enabled = false,
    allow_productivity = true,
    energy_required = 6,
    ingredients =
    {
      {type = "item", name = "biter-egg", amount = 1},
      {type="fluid", name="water", amount=50}
    },
    results = {{type="item", name="meaty-chunks", amount=5}}
  },
  })


-- Category updates 

data.raw.recipe["solar-panel"].category = "electronics"
data.raw.recipe["solar-array"].category = "electronics"
data.raw.recipe["solar-array-2"].category = "electronics"

data.raw.recipe["accumulator"].category = "electronics"
data.raw.recipe["accumulator-battery"].category = "electronics"
data.raw.recipe["adv-accumulator-battery"].category = "electronics"

data.raw.recipe["speed-module"].category = "electronics"
data.raw.recipe["speed-module-2"].category = "electronics"
data.raw.recipe["speed-module-3"].category = "electronics"
data.raw.recipe["speed-module-4"].category = "electronics"

data.raw.recipe["productivity-module"].category = "electronics"
data.raw.recipe["productivity-module-2"].category = "electronics"
data.raw.recipe["productivity-module-3"].category = "electronics"
data.raw.recipe["productivity-module-4"].category = "electronics"

data.raw.recipe["efficiency-module"].category = "electronics"
data.raw.recipe["efficiency-module-2"].category = "electronics"
data.raw.recipe["efficiency-module-3"].category = "electronics"
data.raw.recipe["efficiency-module-4"].category = "electronics"

data.raw.recipe["electronic-circuit"].category = "electronics"
data.raw.recipe["advanced-circuit"].category = "electronics"
data.raw.recipe["processing-unit"].category = "electronics-with-fluid"
data.raw.recipe["cpu-item"].category = "electronics"

data.raw.recipe["medium-wooden-electric-pole"].category = "electronics"
data.raw.recipe["electrical-distributor"].category = "electronics"
data.raw.recipe["huge-electric-pole"].category = "electronics"


--end