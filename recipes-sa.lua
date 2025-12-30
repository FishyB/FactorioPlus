-- Space age overrides


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
      {type = "fluid", name = "steam", amount = 100},
      {type = "item", name = "stone", amount = 10},
    },
    energy_required = 10,
    allow_decomposition = false,
    results = {{type = "item", name = "glass-plate", amount = 4}},
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