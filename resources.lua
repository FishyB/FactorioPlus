local sounds = require ("__base__.prototypes.entity.sounds")
local resource_autoplace = require("resource-autoplace")

---------------------------------------------------  FUEL OVERRIDES  ------------------------------------------------------------

data.raw["item"]["wood"].fuel_acceleration_multiplier = 0.5
data.raw["item"]["wood"].fuel_top_speed_multiplier = 0.5
data.raw["item"]["coal"].fuel_acceleration_multiplier = 0.7
data.raw["item"]["coal"].fuel_top_speed_multiplier = 0.8
data.raw["item"]["coal"].fuel_emissions_multiplier = 1.4
data.raw["item"]["solid-fuel"].fuel_acceleration_multiplier = 0.9
data.raw["item"]["solid-fuel"].fuel_top_speed_multiplier = 0.9
data.raw["item"]["rocket-fuel"].fuel_acceleration_multiplier = 2.0
data.raw["item"]["rocket-fuel"].fuel_top_speed_multiplier = 1.4
data.raw["item"]["nuclear-fuel"].fuel_acceleration_multiplier = 1.25
data.raw["item"]["nuclear-fuel"].fuel_top_speed_multiplier = 3.0

data.raw["item"]["rocket-fuel"].fuel_value = "50MJ"
data.raw["recipe"]["rocket-fuel"].ingredients = {{type="item", name="solid-fuel", amount= 5},{type="fluid", name="light-oil", amount=10},}
data.raw["item"]["rocket-fuel"].subgroup = "fuel-product"
data.raw["item"]["rocket-fuel"].order = "c[vehicle-fuel]"

data.raw["item"]["nuclear-fuel"].subgroup = "fuel-product"
data.raw["item"]["nuclear-fuel"].order = "f[vehicle-fuel]"

local gas_collision_box = {{-2.4, -2.4}, {2.4, 2.4}}
local gas_selection_box = {{-1.0, -1.0}, {1.0, 1.0}}


local gasicon = {
  {
    icon = "__factorioplus__/graphics/icons/fuel-cell.png",
    icon_size = 64
  },
  {
    icon = "__factorioplus__/graphics/icons/fuel-cell-inner-colour-mask.png",
    icon_size = 64,
    tint = { a = 0.75, r=0.3, g=0.1, b=0.3}
  },
  {
    icon = "__factorioplus__/graphics/icons/fuel-cell-glow-colour-mask.png",
    icon_size = 64,
    tint = { a = 0.15, r=0.8, g=0.8, b=0.8 }
  }
  }
  
  local truerocketfuelicon = {
  {
    icon = "__factorioplus__/graphics/icons/fuel-cell.png",
    icon_size = 64
  },
  {
    icon = "__factorioplus__/graphics/icons/fuel-cell-inner-colour-mask.png",
    icon_size = 64,
    tint = { a = 0.8, r=0.8, g=0.1, b=0.1}
  },
  {
    icon = "__factorioplus__/graphics/icons/fuel-cell-glow-colour-mask.png",
    icon_size = 64,
    tint = { a = 0.15, r=0.8, g=0.1, b=0.1 }
  }
  }
  
  local biofuel = {
  {
    icon = "__factorioplus__/graphics/icons/fuel-cell.png",
    icon_size = 64
  },
  {
    icon = "__factorioplus__/graphics/icons/fuel-cell-inner-colour-mask.png",
    icon_size = 64,
    tint = { a = 0.8, r=0.9, g=0.1, b=0.9}
  },
  {
    icon = "__factorioplus__/graphics/icons/fuel-cell-glow-colour-mask.png",
    icon_size = 64,
    tint = { a = 0.25, r=0.9, g=0.1, b=0.9 }
  }
  }
  
resource_autoplace.initialize_patch_set("forest", true)
resource_autoplace.initialize_patch_set("goblin-ore", false)
resource_autoplace.initialize_patch_set("geothermal-vent", false)
resource_autoplace.initialize_patch_set("aquifer", false)
resource_autoplace.initialize_patch_set("natural-gas", false)
resource_autoplace.initialize_patch_set("bauxite-ore", false)
resource_autoplace.initialize_patch_set("sand-ore", false)
 
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["forest"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["sand-ore"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["aquifer"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["geothermal-vent"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["natural-gas"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["bauxite-ore"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["goblin-ore"] = {}
 
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["entity"].settings["forest"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["entity"].settings["sand-ore"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["entity"].settings["aquifer"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["entity"].settings["geothermal-vent"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["entity"].settings["natural-gas"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["entity"].settings["bauxite-ore"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["entity"].settings["goblin-ore"] = {}

 if (mods["space-age"]) then
 
data.raw["planet"]["vulcanus"].map_gen_settings.autoplace_controls["vulcanus_geothermal"] = {}
data.raw["planet"]["vulcanus"].map_gen_settings.autoplace_settings["entity"].settings["geothermal-vent"] = {}

data.raw["planet"]["vulcanus"].map_gen_settings.autoplace_controls["vulcanus_bauxite"] = {}
data.raw["planet"]["vulcanus"].map_gen_settings.autoplace_settings["entity"].settings["bauxite-ore"] = {}

data.raw["planet"]["gleba"].map_gen_settings.autoplace_controls["gleba_natural_gas"] = {}
data.raw["planet"]["gleba"].map_gen_settings.autoplace_settings["entity"].settings["natural-gas"] = {}
	
data.extend({
	{
		type = "autoplace-control",
		name = "gleba_natural_gas",
		localised_name = {
			"",
			"[fluid=natural-gas] ",
			{
			  "entity-name.natural-gas"
			}
		  },
		richness = true,
		order = "c-a",
		category = "resource"
	},
	{
		type = "autoplace-control",
		name = "vulcanus_geothermal",
		localised_name = {
			"",
			"[fluid=steam] ",
			{
			  "entity-name.geothermal-vent"
			}
		  },
		richness = true,
		order = "b-c",
		category = "resource"
	},
	{
		type = "autoplace-control",
		name = "vulcanus_bauxite",
		localised_name = {
			"",
			"[item=bauxite-ore] ",
			{
			  "entity-name.bauxite-ore"
			}
		  },
		richness = true,
		order = "b-c",
		category = "resource"
	},
		
})
 end


data:extend
({
 {
    type = "recipe",
    name = "solid-fuel-from-petroleum-gas",
    category = "chemistry",
    energy_required = 2,
    ingredients =
    {
      {type="fluid", name="petroleum-gas", amount=25}
    },
    results=
    {
      {type="item", name="petroleum-fuel", amount=1}
    },
    icons = gasicon,
    icon_size = 64, icon_mipmaps = 4,
	enabled = false,
    subgroup = "fuel-product",
    order = "b[vehicle-fuel]",
	allow_productivity = true,
    crafting_machine_tint =
    {
      primary = {r = 0.768, g = 0.631, b = 0.768, a = 1.000}, -- #c3a0c3ff
      secondary = {r = 0.659, g = 0.592, b = 0.678, a = 1.000}, -- #a896acff
      tertiary = {r = 0.774, g = 0.631, b = 0.766, a = 1.000}, -- #c5a0c3ff
      quaternary = {r = 0.564, g = 0.364, b = 0.564, a = 1.000}, -- #8f5c8fff
    }
  },
    {
    type = "item",
    name = "petroleum-fuel",
   icons = gasicon,
	icon_mipmaps = 4,
    fuel_category = "chemical",
    fuel_value = "10MJ",
    fuel_acceleration_multiplier = 1.15,
    fuel_top_speed_multiplier = 1.1,
    subgroup = "fuel-product",
    order = "b[vehicle-fuel]",
    stack_size = 35,
	weight = 5 * kg,
  },
  
   ---------------------------------------------------  ROCKET FUEL 2  ------------------------------------------------------------

    {
    type = "recipe",
    name = "true-rocket-fuel",
    energy_required = 45,
	enabled = false,
	category = "advanced-crafting",
    ingredients =
    {
      {type="item", name="rocket-fuel", amount=2},
	  {type="item", name="explosives", amount=2},
	  {type="item", name="plastic-bar", amount=1},
    },
	results = {{type="item", name="true-rocket-fuel", amount=1}},
	allow_productivity = true,
  },
      {
    type = "item",
    name = "true-rocket-fuel",
   icons = truerocketfuelicon,
	icon_mipmaps = 4,
    fuel_category = "chemical",
    fuel_value = "200MJ",
    fuel_acceleration_multiplier = 4.0,
    fuel_top_speed_multiplier = 1.75,
    subgroup = "fuel-product",
    order = "d[vehicle-fuel]",
    stack_size = 10,
	weight = 10 * kg,
  },
  
     ---------------------------------------------------  BIO FUEL  ------------------------------------------------------------

    {
    type = "recipe",
    name = "bio-fuel",
    energy_required = 60,
	enabled = false,
    category = "advanced-crafting",
    ingredients =
    {
      {type="item", name="petroleum-fuel", amount=2},
	  {type="item", name="nat-gas-fuel", amount=2},
	  {type="item", name="meaty-chunks", amount=20},
    },
	results = {{type="item", name="bio-fuel", amount=1}},
	allow_productivity = true,
  },
      {
    type = "item",
    name = "bio-fuel",
	icons = biofuel,
	icon_mipmaps = 3,
    fuel_category = "chemical",
    fuel_value = "80MJ",
    fuel_acceleration_multiplier = 0.35,
    fuel_top_speed_multiplier = 0.55,
	fuel_emissions_multiplier = 0.2,
    subgroup = "fuel-product",
    order = "b[vehicle-fuel]",
    stack_size = 25,
	weight = 10 * kg,
  },
 ---------------------------------------------------  BAUXITE  ------------------------------------------------------------
{
   type = "item",
    name = "bauxite-ore",
    icon = "__factorioplus__/graphics/icons/bauxite-ore.png",
    subgroup = "raw-resource",
	pictures =
	{
      { size = 64, filename = "__factorioplus__/graphics/icons/bauxite-ore.png",   scale = 0.5, mipmap_count = 3 },
      { size = 64, filename = "__factorioplus__/graphics/icons/bauxite-ore-2.png", scale = 0.5, mipmap_count = 3 },
	  { size = 64, filename = "__factorioplus__/graphics/icons/bauxite-ore-3.png", scale = 0.5, mipmap_count = 3 },
    },
    order = "e[iron-ore]",
    stack_size = 50,
	weight = 2 * kg,	
},
{
	type = "autoplace-control",
	name = "bauxite-ore",
	localised_name = {
        "",
        "[item=bauxite-ore] ",
        {
          "entity-name.bauxite-ore"
        }
      },
	richness = true,
	order = "a-gf",
	category = "resource"	
},
{
    type = "resource",
    name = "bauxite-ore",
    icon = "__factorioplus__/graphics/icons/bauxite-ore.png",
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    walking_sound = sounds.ore,
	driving_sound = stone_driving_sound,
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 1.5,
      result = "bauxite-ore",
      fluid_amount = 10,
      required_fluid = "sulfuric-acid",
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "bauxite-ore",
      order = "c",
      base_density = 0.6,
      base_spots_per_km2 = 0.4,
      has_starting_area_placement = false,
      random_spot_size_minimum = 1,
      random_spot_size_maximum = 2,
      regular_rq_factor_multiplier = 1
    },
    stage_counts = {20000, 10000, 5000, 2500, 1250, 750, 400, 200},
    stages =
    {
      sheet =
      {
          filename = "__factorioplus__/graphics/bauxite-ore-new.png",
          priority = "extra-high",
          width = 128,
          height = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
      }
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    mining_visualisation_tint = {r = 0.9, g = 0.9, b = 0.9, a = 1.000}, -- #cfff7fff
    map_color = {0.9, 0.2, 0.05}
  },
   ---------------------------------------------------  GOBLIN ORE  ------------------------------------------------------------

{
   type = "item",
    name = "goblin-ore",
    icon = "__factorioplus__/graphics/icons/goblin-ore.png",
	hidden=true,
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "raw-resource",
    order = "e[iron-ore]",
    stack_size = 50  
},
{
	type = "autoplace-control",
	name = "goblin-ore",
	localised_name = {
        "",
        "[item=goblin-ore] ",
        {
          "entity-name.goblin-ore"
        }
      },
	richness = true,
	order = "a-h",
	category = "resource"	
},
{
    type = "resource",
    name = "goblin-ore",
    icon = "__factorioplus__/graphics/icons/goblin-ore.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    walking_sound = sounds.ore,
	resource_patch_search_radius = 10,
    minable =
    {
	-- IRON RICHEST, COPPER RICH, COAL LOW, STONE MED
      mining_particle = "stone-particle",
      mining_time = 1.5,
      results = 
	  {
		{
			type = "item",
			name = "stone",
			probability = 0.25,
			amount = 1
		},
		{
			type = "item",
			name = "iron-ore",
			probability = 0.5,
			amount = 1
		},
		{
			type = "item",
			name = "copper-ore",
			probability = 0.4,
			amount = 1
		},
		{
			type = "item",
			name = "coal",
			probability = 0.15,
			amount = 1
		},
	  },
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "goblin-ore",
	  seed1 = 100,
      order = "c",
      base_density = 6,
      base_spots_per_km2 = 0.75,
      has_starting_area_placement = false,
      random_spot_size_minimum = 2,
      random_spot_size_maximum = 6,
	  regular_blob_amplitude_multiplier =  5,
	  regular_rq_factor_multiplier = 0.5,
	  richness_post_multiplier = 0.05, 
    },
    stage_counts = {20000, 10000, 5000, 2900, 1550, 1150, 700, 300},
    stages =
    {
      sheet =
      {
        filename = "__factorioplus__/graphics/goblin-ore.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        frame_count = 8,
        variation_count = 8,
		scale = 0.5,
      }
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    mining_visualisation_tint = {r = 0.2, g = 0.1, b = 0.3, a = 1.000}, -- #cfff7fff
    map_color = {0.25, 0.1, 0.3}
  },
  {
    type = "resource",
    name = "goblin-ore-2",
	localised_name = {
        "",
        {
          "entity-name.goblin-ore"
        }
      },
	localised_description = {
        "",
        {
          "entity-description.goblin-ore"
        }
      },
    icon = "__factorioplus__/graphics/icons/goblin-ore.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    walking_sound = sounds.ore,
	resource_patch_search_radius = 10,
    minable =
    {
	-- STONE RICHEST, COAL RICH, IRON MED-LOW, COPPER MED
      mining_particle = "stone-particle",
      mining_time = 1.5,
      results = 
	  {
		{
			type = "item",
			name = "stone",
			probability = 0.45,
			amount = 1
		},
		{
		type = "item",
			name = "iron-ore",
			probability = 0.2,
			amount = 1
		},
		{
		type = "item",
			name = "copper-ore",
			probability = 0.15,
			amount = 1
		},
		{
		type = "item",
			name = "coal",
			probability = 0.35,
			amount = 1
		},
	  },
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "goblin-ore",
	  seed1 = 101,
      order = "c",
      base_density = 6,
      base_spots_per_km2 =  0.75,
      has_starting_area_placement = false,
      random_spot_size_minimum = 2,
      random_spot_size_maximum = 6,
	  regular_blob_amplitude_multiplier =  5,
	  regular_rq_factor_multiplier = 0.5,
	  richness_post_multiplier = 0.05, 
    },
    stage_counts = {20000, 10000, 5000, 2900, 1550, 1150, 700, 300},
    stages =
    {
      sheet =
      {
        filename = "__factorioplus__/graphics/goblin-ore.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        frame_count = 8,
        variation_count = 8,
		scale = 0.5,
      }
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    mining_visualisation_tint = {r = 0.2, g = 0.1, b = 0.3, a = 1.000}, -- #cfff7fff
    map_color = {0.25, 0.1, 0.3}
  },
  {
    type = "resource",
    name = "goblin-ore-3",
	localised_name = {
        "",
        {
          "entity-name.goblin-ore"
        }
      },
	localised_description = {
        "",
        {
          "entity-description.goblin-ore"
        }
      },
    icon = "__factorioplus__/graphics/icons/goblin-ore.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    walking_sound = sounds.ore,
	resource_patch_search_radius = 10,
    minable =
    {
		-- COAL RICHEST, COPPER RICH, IRON LOW, STONE LOW
      mining_particle = "stone-particle",
      mining_time = 1.5,
      results = 
	  {
		{
		type = "item",
			name = "stone",
			probability = 0.17,
			amount = 1
		},
		{
		type = "item",
			name = "iron-ore",
			probability = 0.22,
			amount = 1
		},
		{
		type = "item",
			name = "copper-ore",
			probability = 0.37,
			amount = 1
		},
		{
		type = "item",
			name = "coal",
			probability = 0.45,
			amount = 1
		},
	  },
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "goblin-ore",
	  seed1 = 102,
      order = "c",
      base_density = 6,
      base_spots_per_km2 =  0.75,
      has_starting_area_placement = false,
      random_spot_size_minimum = 2,
      random_spot_size_maximum = 6,
	  regular_blob_amplitude_multiplier =  5,
	  regular_rq_factor_multiplier = 0.5,
	  richness_post_multiplier = 0.05, 
    },
    stage_counts = {20000, 10000, 5000, 2900, 1550, 1150, 700, 300},
    stages =
    {
      sheet =
      {
        filename = "__factorioplus__/graphics/goblin-ore.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        frame_count = 8,
        variation_count = 8,
		scale = 0.5,
      }
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    mining_visualisation_tint = {r = 0.2, g = 0.1, b = 0.3, a = 1.000}, -- #cfff7fff
    map_color = {0.25, 0.1, 0.3}
  },
   ---------------------------------------------------  SAND  ------------------------------------------------------------
  {
   type = "item",
    name = "sand-ore",
	icon = "__factorioplus__/graphics/icons/sand.png",
    icon_size = 64,
    icon_mipmaps = 3,
	pictures =
	{
      { size = 64, filename = "__factorioplus__/graphics/icons/sand.png",   scale = 0.5, mipmap_count = 3 },
      { size = 64, filename = "__factorioplus__/graphics/icons/sand-1.png", scale = 0.5, mipmap_count = 3 },
	  { size = 64, filename = "__factorioplus__/graphics/icons/sand-2.png", scale = 0.5, mipmap_count = 3 },
    },
    subgroup = "raw-resource",
    order = "e[iron-ore]",
    stack_size = 100,
	weight = 1 * kg,	
},
{
	type = "autoplace-control",
	localised_name = {
        "",
        "[item=sand-ore] ",
        {
          "entity-name.sand-ore"
        }
      },
	name = "sand-ore",
	richness = true,
	order = "a-i",
	category = "resource"	
},
{
    type = "resource",
    name = "sand-ore",
    icon = "__factorioplus__/graphics/icons/sand.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    order="a-b-e",
    tree_removal_probability = 0.2,
    tree_removal_max_distance = 32 * 32,
    walking_sound = dirt_sounds,
	resource_patch_search_radius = 10,
    minable =
    {
      mining_particle = "sand-3-dust-particle",
      mining_time = 0.4,
      result = "sand-ore",
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "sand-ore",
      order = "c",
      base_density = 6,
      base_spots_per_km2 = 1.5,
      has_starting_area_placement = false,
      random_spot_size_minimum = 1,
      random_spot_size_maximum = 2,
	  regular_blob_amplitude_multiplier =  17, -- 1
      regular_rq_factor_multiplier = 0.5,
	  richness_post_multiplier = 0.005, 
    },
    stage_counts = {12000, 8000, 4000, 2000, 1200, 600, 300, 100},
    stages =
    {
      sheet =
      {
        filename = "__factorioplus__/graphics/sand-ore.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        frame_count = 8,
        variation_count = 8,
		scale = 0.5,
      }
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    mining_visualisation_tint = {r = 0.95, g = 0.85, b = 0.6, a = 1.000}, -- #cfff7fff
    map_color = {0.95, 0.85, 0.6}
  },
   ---------------------------------------------------  WATER  ------------------------------------------------------------
{
	type = "autoplace-control",
	localised_name = {
        "",
        "[entity=aquifer] ",
        {
          "entity-name.aquifer"
        }
      },
	name = "aquifer",
	richness = true,
	order = "a-i",
	category = "resource"	
},
	
   {
    type = "resource",
    name = "aquifer",
    icon = "__factorioplus__/graphics/icons/resource-aquifer.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    category = "basic-fluid",
    order="a-b-a",
    infinite = true,
    highlight = true,
    minimum = 20000,
    normal = 900000,
	remove_decoratives = "true",
    infinite_depletion_amount = 1,
    resource_patch_search_radius = 22,
    tree_removal_probability = 0.4,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_time = 1,
      results =
      {
        {
          type = "fluid",
          name = "water",
          amount_min = 50,
          amount_max = 50,
          probability = 1
        }
      }
    },
    walking_sound = sounds.oil,
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "aquifer",
      order = "c", -- Other resources are "b"; oil won't get placed if something else is already there.
      base_density = 0.3,
      base_spots_per_km2 = 0.4,
      random_probability = 1/50,
      random_spot_size_minimum = 1,
      random_spot_size_maximum = 2, -- don't randomize spot size
      additional_richness = 220000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
      has_starting_area_placement = false,
      regular_rq_factor_multiplier = 1
    },
    stage_counts = {5000000, 1500000 ,600000, 200000},
    stages =
    {
      sheet =
      {
        filename = "__factorioplus__/graphics/aquifer.png",
        priority = "extra-high",
        width = 512/4,
        height = 444/4,
        frame_count = 4,
        variation_count = 4,
		scale = 0.6,
        shift = util.by_pixel(0, -2),
      }
    },
    map_color = {0, 0.4, 0.8},
    map_grid = false

  },
   ---------------------------------------------------  STEAM  ------------------------------------------------------------
{
	type = "autoplace-control",
	name = "geothermal-vent",
	localised_name = {
        "",
        "[fluid=steam] ",
        {
          "entity-name.geothermal-vent"
        }
      },
	richness = true,
	order = "a-i",
	category = "resource"	
},
   {
    type = "resource",
    name = "geothermal-vent",
    icon = "__base__/graphics/icons/crude-oil-resource.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    category = "pressurized-gas",
    order="a-b-a",
    infinite = true,
    highlight = true,
	remove_decoratives = "true",
    minimum = 400000,
    normal = 900000,
    --infinite_depletion_amount = 5,
    resource_patch_search_radius = 32,
    tree_removal_probability = 0.9,
    tree_removal_max_distance = 92 * 92,
    minable =
    {
      mining_time = 1,
      results =
      {
        {
          type = "fluid",
          name = "steam",
          amount_min = 25,
          amount_max = 25,
		  temperature = 250,
          probability = 1
        }
      }
    },
    walking_sound = sounds.oil,
	collision_box = gas_collision_box,
    selection_box = gas_selection_box,
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "geothermal-vent",
      order = "c", -- Other resources are "b"; oil won't get placed if something else is already there.
      base_density = 0.2,
      base_spots_per_km2 = 0.2,
      random_probability = 1/80,
      random_spot_size_minimum = 2,
      random_spot_size_maximum = 4, 
      additional_richness = 1690000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
      has_starting_area_placement = false,
      regular_rq_factor_multiplier =1
    },
	stage_counts = {4000000, 1200000 ,500000, 100000},
    stages =
    {
	  sheet =
      {
        filename = "__factorioplus__/graphics/steam-vent.png",
        priority = "extra-high",
        width = 1308/4,
        height = 1136/4,
        frame_count = 4,
		variation_count = 4,
		line_length = 4, -- Default is the value of variation_count.
		scale = 0.5,
		--tint =  {r=0, g=0.9, b=0.9, a=1},
        shift = util.by_pixel(0, -8),
      }
    },

	draw_stateless_visualisation_under_building = false,
    stateless_visualisation =
    {
      {
        count = 1,
        render_layer = "smoke",
        animation = {
          filename = "__base__/graphics/entity/crude-oil/oil-smoke-outer.png",
          frame_count = 47,
          line_length = 16,
          width = 90,
          height = 188,
          animation_speed = 0.4,
          shift = util.by_pixel(-2, 24 -152),
          scale = 1.5,
          tint = util.multiply_color({r=0.9, g=0.9, b=0.9}, 0.2)
        }
      },
      {
        count = 1,
        render_layer = "smoke",
        animation = {
          filename = "__base__/graphics/entity/crude-oil/oil-smoke-inner.png",
          frame_count = 47,
          line_length = 16,
          width = 40,
          height = 84,
          animation_speed = 0.3,
          shift = util.by_pixel(0, 24 -78),
          scale = 1.25,
          tint = util.multiply_color({r=0.9, g=0.9, b=0.9}, 0.3)
        }
      }
    },

	
    map_color = {0.7, 0.7, 0.7},
    map_grid = false
  },
   ---------------------------------------------------  FORESTS  ------------------------------------------------------------
})


  
data:extend
({
{
	type = "autoplace-control",
	name = "forest",
	localised_name = {
        "",
        "[item=wood] ",
        {
          "entity-name.forest"
        }
      },
	richness = true,
	order = "a-d",
	category = "resource"	
},

{
    type = "resource",
    name = "forest",
    icon = "__base__/graphics/icons/wood.png",
    icon_size = 64,
    icon_mipmaps = 4,
	category = "wood-solid";
	minimum = 1,
    normal = 1,
	resource_patch_search_radius = 42,
	highlight = true,
	remove_decoratives = "true",
    flags = {"placeable-neutral"},
    order="a-b-e",
	collision_mask = 
	{
		layers=
		{
			item=true, 
			--object=true, 
			--player=true, 
			water_tile=true, 
			resource=true
		}
	},
    tree_removal_probability = 1,
    tree_removal_max_distance = 1024 * 128,
    walking_sound = sounds.wood,
	minable =
    {
      mining_particle = "green-croton-wooden-splinter-particle-small",
      mining_time = 1,
      results = {{type="item", name="wood", amount=1}},
    },
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
		tile_restriction = "",
		name = "forest",
		order = "b",
		base_density = 5,
		random_probability = 1/3, -- 1
		base_spots_per_km2 = 0.8, -- 2.5
		random_spot_size_minimum = 0.02, -- 0.25 scales with km
		random_spot_size_maximum = 0.04, -- 2.0 scales with km
		candidate_spot_count = 2, --21
		
		regular_blob_amplitude_multiplier =  18, -- 1
		starting_blob_amplitude_multiplier = 1.9, -- 1
		
		has_starting_area_placement = true,
		
		additional_richness = 0, -- 0
		minimum_richness = 0, -- 0
		richness_post_multiplier = 0.1, 
		-- 1 * control setting
		
		regular_rq_factor = 0.01, -- 1
		starting_rq_factor = 1.55, --1 

    },
    stage_counts = {6000,2000,500,200,100},
    stages =
    {
      sheets =
       {
		    {
				filename = "__factorioplus__/graphics/forest-1.png",
				priority = "extra-high",
				width = 384,
				height = 384,
				variation_count = 5,
				frame_count = 3,
				scale = 0.5,
			},
       },
	},
	map_grid = false,
    mining_visualisation_tint = {r = 0.6, g =  0.3, 0.15, a = 1.000}, -- #cfff7fff
    map_color = {0.8, 0.4, 0.15},
	
	draw_stateless_visualisation_under_building = false,
	stateless_visualisation =
	{
	
	   {
		count = 1,
		render_layer = "decals",
		animation = 
		{
			  filename = "__factorioplus__/graphics/forest-1-shadow.png",
			  width = 384,
			  height = 384,
			  scale = 0.4,
			 frame_count = 1,
		}
	  },
	  {
		count = 6,
		render_layer = "above-tiles",
		positions = 
		{
			{0,0},
			{-1.8,1.8},
			{1.8,-1.8},
			{1.1,1.8},
			{1.5,0},
			{0.7,1},
			{-1.3,-2},
			{-1.9,0},
			{0.8, -1.75},
			{0.25,-0.4},
			{1.1/2,1.8/2},
			{1.5/2,0},
			{0.7/2,1/2},
			{0.7/2,1/2},
			{-1.3/2,-2/2},
			{-1.9/2,0},
			{0.8/2, -1.75/2},
		},
		animation = 
		{
			  filename = "__factorioplus__/graphics/forest-1.png",
			  width = 384,
			  height = 384,
			  scale = 0.25,
			  x = 0,
			  y = 384 * 4,
				frame_count = 1,
				variation_count = 3,
		}
	  },
	   {
		count = 1,
		render_layer = "lower-object",
		animation = 
		{
			  filename = "__factorioplus__/graphics/forest-1.png",
			  width = 384,
			  height = 384,
			  scale = 0.35,
			  y = 384 * 4,
			 frame_count = 1,
			 variation_count = 3,
		}
	  },
	  	 {
		count = 3,
		render_layer = "object-under",
		positions = 
		{
			{0,0},
			{1.1/1.5,1.8/1.5},
			{0.7/1.5,1/1.5},
			{-1.3/1.5,-2/1.5},
			{-1.9/1.5,0},
			{0.8/1.5, -1.75/1.5},
		},
		animation = 
		{
			  filename = "__factorioplus__/graphics/forest-1.png",
			  width = 384,
			  height = 384,
			  scale = 0.25,
			  y = 384 * 4,
			 frame_count = 1,
			 variation_count = 3,
		}
	  },
	},

},
  
	
	{
    type = "recipe",
    name = "resin-extraction",
    category = "oil-processing",
    enabled = false,
    energy_required = 8,
    ingredients =
    {
      {type="item", name="wood", amount=10},
      {type="fluid", name="steam", amount=50}
    },
    results=
    {
      {type="fluid", name="light-oil", amount=25},
    },
    icon = "__factorioplus__/graphics/icons/wood-resin-processing.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-c[coal-liquefaction]",
	localised_name = {"recipe-name.resin-extraction"},
    allow_decomposition = false,
	allow_productivity = true,
  },
   ---------------------------------------------------  NATTY GAS  ------------------------------------------------------------
   {
    type = "fluid",
    name = "natural-gas",
    default_temperature = 25,
    max_temperature = 100,
 --   heat_capacity = "0.1KJ",
    icon = "__factorioplus__/graphics/icons/natural-gas.png",
    icon_size = 64, icon_mipmaps = 4,
    base_color = {r=0.0, g=0.7, b=0.9},
    flow_color = {r=0.0, g=1, b=1},
    order = "a[fluid]-e[crude-oil]",
    gas_temperature = 15,
    auto_barrel = false
  },
  {
	type = "autoplace-control",
	name = "natural-gas",
	localised_name = {
        "",
        "[fluid=natural-gas] ",
        {
          "entity-name.natural-gas"
        }
      },
	richness = true,
	order = "a-e",
	category = "resource"	
},
   {
    type = "resource",
    name = "natural-gas",
    icon = "__factorioplus__/graphics/icons/natural-gas.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    category = "pressurized-gas",
    order="a-b-a",
    infinite = true,
    highlight = true,
    minimum = 400000,
    normal = 600000,
	remove_decoratives = "true",
    infinite_depletion_amount = 5,
    resource_patch_search_radius = 22,
    tree_removal_probability = 0.9,
    tree_removal_max_distance = 64 * 64,
    minable =
    {
      mining_time = 1,
      results =
      {
        {
          type = "fluid",
          name = "natural-gas",
          amount_min = 30,
          amount_max = 30,
          probability = 1
        }
      }
    },
    walking_sound = sounds.oil,
	collision_box = gas_collision_box,
    selection_box = gas_selection_box,
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "natural-gas",
      order = "c", -- Other resources are "b"; oil won't get placed if something else is already there.
      base_density = 0.4,
      base_spots_per_km2 = 2,
      random_probability = 1/50,
      random_spot_size_minimum = 3,
      random_spot_size_maximum = 7, -- don't randomize spot size
      additional_richness = 190000, -- this increases the total everywhere, so base_density needs to be decreased to compensate
      has_starting_area_placement = false,
      regular_rq_factor_multiplier = 1,
    },
    stage_counts = {2000000, 800000 ,300000, 50000},
    stages =
    {
	  sheet =
      {
        filename = "__factorioplus__/graphics/gas-vent.png",
        priority = "extra-high",
        width = 1308/4,
        height = 1136/4,
        frame_count = 4,
		variation_count = 4,
		 line_length = 4, -- Default is the value of variation_count.
		scale = 0.5,
		--tint =  {r=0, g=0.9, b=0.9, a=1},
        shift = util.by_pixel(0, -8),
      }
    },
		draw_stateless_visualisation_under_building = false,
    stateless_visualisation =
    {
      {
        count = 1,
        render_layer = "smoke",
        animation = {
          filename = "__base__/graphics/entity/crude-oil/oil-smoke-outer.png",
          frame_count = 47,
          line_length = 16,
          width = 90,
          height = 188,
          animation_speed = 0.2,
          shift = util.by_pixel(5, 58 -152),
          scale = 0.8,
          tint = util.multiply_color({r=0.0, g=0.9, b=0.9}, 0.3)
        }
      },
      {
        count = 1,
        render_layer = "smoke",
        animation = {
          filename = "__base__/graphics/entity/crude-oil/oil-smoke-inner.png",
          frame_count = 47,
          line_length = 16,
          width = 40,
          height = 84,
          animation_speed = 0.25,
          shift = util.by_pixel(7, 58 -78),
          scale = 0.45,
          tint = util.multiply_color({r=0.0, g=0.9, b=0.9}, 0.5)
        }
      }
    },

	
    map_color = {0.0, 0.9, 0.9},
    map_grid = false
  },
  ---------------------------------------------------  NAT GAS FUEL   ------------------------------------------------------------
    {
    type = "item",
    name = "nat-gas-fuel",
   icons = 
   {
	  {
		icon = "__factorioplus__/graphics/icons/fuel-cell.png",
		icon_size = 64
	  },
	  {
		icon = "__factorioplus__/graphics/icons/fuel-cell-inner-colour-mask.png",
		icon_size = 64,
		tint = { a = 0.75, r=0.0, g=1, b=1}
	  },
	  {
		icon = "__factorioplus__/graphics/icons/fuel-cell-glow-colour-mask.png",
		icon_size = 64,
		tint = { a = 0.45, r=0.0, g=0.8, b=1 }
	  },
	},
	icon_mipmaps = 3,
    fuel_category = "chemical",
    fuel_value = "16MJ",
    fuel_acceleration_multiplier = 0.75,
    fuel_top_speed_multiplier = 0.8,
	fuel_emissions_multiplier = 0.8,
    subgroup = "intermediate-product",
    order = "p[rocket-fuel]",
    stack_size = 40,
	weight = 5 * kg,
  },
  
   {
    type = "recipe",
    name = "solid-fuel-from-nat-gas",
    category = "chemistry",
    energy_required = 10,
	enabled = false,
    ingredients =
    {
      {type="fluid", name="natural-gas", amount=40}
    },
    results=
    {
      {type="item", name="nat-gas-fuel", amount=1}
    },
    {
    icon = "__base__/graphics/icons/fluid/barreling/barrel-empty.png",
    icon_size = 32
  },
  {
    icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-side-mask.png",
    icon_size = 32,
    tint = { a = 0.75, b = 0, g = 0, r = 0 }
  },
  {
    icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-top-mask.png",
    icon_size = 32,
    tint = { a = 0.75, b = 0.5, g = 0.5, r = 0.5 }
  },
  {
    icon = "__factorioplus__/graphics/icons/natural-gas.png",
    icon_size = 32,
    scale = 0.5,
    shift = {7, 8 }
  },
    icon_mipmaps = 4,
    subgroup = "fuel-product",
    order = "a[vehicle-fuel]",
	allow_productivity = true,
    crafting_machine_tint =
    {
      primary = {r = 0, g = 1, b = 1.0 , a = 0.8}, -- #e2a090ff
      secondary = {r = 0, g = 0.92, b = 1, a = 0.7}, -- #ccaaa4ff
      tertiary = {r = 0, g = 0.85, b = 1, a = 0.6}, -- #d9a892ff
      quaternary = {r = 0, g = 0.8, b = 1, a = 0.5}, -- #ff6420ff
    }
  },
    --------------------------------------------------- CHARCOAL  ------------------------------------------------------------

    {
    type = "item",
    name = "charcoal",
    icon = "__factorioplus__/graphics/icons/charcoal.png",
    icon_size = 64,
    icon_mipmaps = 4,
    dark_background_icon = "__factorioplus__/graphics/icons/charcoal.png",
    pictures =
    {
      { size = 64, filename = "__factorioplus__/graphics/icons/charcoal.png",   scale = 0.5, mipmap_count = 4 },
	  { size = 64, filename = "__factorioplus__/graphics/icons/charcoal-1.png",   scale = 0.5, mipmap_count = 4 },
	  { size = 64, filename = "__factorioplus__/graphics/icons/charcoal-2.png",   scale = 0.5, mipmap_count = 4 },
	  { size = 64, filename = "__factorioplus__/graphics/icons/charcoal-3.png",   scale = 0.5, mipmap_count = 4 },
    },
    fuel_category = "chemical",
    fuel_value = "2MJ",
	fuel_acceleration_multiplier = 0.4,
    fuel_top_speed_multiplier = 0.6,
	fuel_emissions_multiplier = 1.1,
    subgroup = "raw-material",
    order = "9[charcoal]",
    stack_size = 200,
	weight = 1 * kg,
  },
	  ---------------------------------------------------  GAS PROCESSING  ------------------------------------------------------------

	{
    type = "recipe",
    name = "basic-natural-gas-processing",
    category = "oil-processing",
    energy_required = 8,
	enabled = false,
	allow_productivity = true,
    ingredients =
    {
      {type="fluid", name="natural-gas", amount=40, fluidbox_index = 2}
    },
    results=
    {
      {type="fluid", name="petroleum-gas", amount=25, fluidbox_index = 3},
	  {type="fluid", name="sulfuric-acid", amount=15, fluidbox_index = 1}
    },
    icon = "__factorioplus__/graphics/icons/natural-gas-processing.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-a[basic-oil-processing]",
    main_product = ""
  },
  
})
