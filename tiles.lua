require ("__base__.prototypes.entity.entity-util")
local resource_autoplace = require("resource-autoplace")

local tile_sounds = require("__base__/prototypes/tile/tile-sounds")
local tile_trigger_effects = require("__base__.prototypes.tile.tile-trigger-effects")
local tile_graphics = require("__base__/prototypes/tile/tile-graphics")
local tile_spritesheet_layout = tile_graphics.tile_spritesheet_layout
local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")
local tile_pollution = require("__base__/prototypes/tile/tile-pollution-values")

local walking_speed_stone = 1.4
local walking_speed_concrete = 1.6
local walking_speed_tarmac = 1.6
local walking_speed_refinedconcrete = 1.8

local stone_path_vehicle_speed_modifier = 1.1
local concrete_vehicle_speed_modifier = 0.9
local tarmac_vehicle_speed_modifier = 0.6

local water_shallow_vehicle_friction_modifier = 4.0
local water_vehicle_friction_modifier = 8.0

local grass_vehicle_speed_modifier = 1.2
local dirt_vehicle_speed_modifier = 1.6
local sand_vehicle_speed_modifier = 2.3
local snow_vehicle_speed_modifier = 2.7

table.insert(water_tile_type_names, "oceanwater")
table.insert(water_tile_type_names, "oceanwater-green")

-- data.raw["tile"]["grass"].vehicle_friction_modifier = water_vehicle_friction_modifier
-- data.raw["tile"]["dirt"].vehicle_friction_modifier = water_vehicle_friction_modifier
-- data.raw["tile"]["sand"].vehicle_friction_modifier = water_vehicle_friction_modifier


---------------------------------------
-- SPACE AGE OVERRIDES AND EDIT HERE --
---------------------------------------

if (mods["space-age"]) then

table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "water-mud")
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "water-shallow")
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "wetland-light-green-slime")
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "wetland-green-slime")
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "wetland-light-dead-skin")
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "wetland-dead-skin")
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "wetland-pink-tentacle")
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "wetland-red-tentacle")
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "wetland-yumako")
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "wetland-jellynut")
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "wetland-blue-slime");
table.insert(data.raw.item.landfill.place_as_tile.tile_condition, "gleba-deep-lake");
data.raw.recipe.landfill.auto_recycle = false
end


--Cliff explosives, this is where you can make new types of cliff explosives for different cliffs

-- if (mods["space-age"]) then
-- data.raw["cliff"]["cliff"].cliff_explosive = "cliff-explosives-light"
-- --data.raw["cliff"]["cliff-vulcanus"].cliff_explosive = "cliff-explosives"
-- --data.raw["cliff"]["cliff-fulgora"].cliff_explosive = "cliff-explosives"
-- --data.raw["cliff"]["cliff-gleba"].cliff_explosive = "cliff-explosives"
-- end

local pollution_ocean = { pollution = 0.00008 }
local pollution_deepwater = { pollution = 0.00004 }
 
data.raw["tile"]["stone-path"].walking_speed_modifier = walking_speed_stone
data.raw["tile"]["concrete"].walking_speed_modifier = walking_speed_concrete
data.raw["tile"]["hazard-concrete-left"].walking_speed_modifier = walking_speed_concrete
data.raw["tile"]["hazard-concrete-right"].walking_speed_modifier = walking_speed_concrete
data.raw["tile"]["refined-concrete"].walking_speed_modifier = walking_speed_refinedconcrete
data.raw["tile"]["refined-hazard-concrete-left"].walking_speed_modifier = walking_speed_refinedconcrete
data.raw["tile"]["refined-hazard-concrete-right"].walking_speed_modifier = walking_speed_refinedconcrete


function update_tile_map_color(tile) 
	data.raw["tile"][tile].map_color = {
	data.raw["tile"][tile].map_color[1]* data.raw["tile"][tile].tint[1],
	data.raw["tile"][tile].map_color[2]* data.raw["tile"][tile].tint[2],
	data.raw["tile"][tile].map_color[3]* data.raw["tile"][tile].tint[3] 
	}
end

-- Lush Grass

data.raw["tile"]["grass-1"].tint = { 0.9, 1 , 0.95}
data.raw["tile"]["grass-1"].absorptions_per_second["pollution"] = tile_pollution.grass["pollution"] * 1.2 

update_tile_map_color ("grass-1")


-- Red Rocky Desert 

data.raw["tile"]["grass-2"].tint = { 1, 0.85 , 1}

data.raw["tile"]["dirt-4"].tint = { 1, 0.95 , 0.90}

data.raw["tile"]["red-desert-0"].tint = { 1, 0.9 , 0.8}
data.raw["tile"]["red-desert-1"].tint = { 1, 0.85 , 0.6}
data.raw["tile"]["red-desert-2"].tint = { 1, 0.80 , 0.7}
data.raw["tile"]["red-desert-3"].tint = { 1, 0.75 , 0.9}

update_tile_map_color ("red-desert-0")
update_tile_map_color ("red-desert-1")
update_tile_map_color ("red-desert-2")
update_tile_map_color ("red-desert-3")
update_tile_map_color ("dirt-4")
update_tile_map_color ("grass-2")

-- data.raw["tile"]["red-desert-3"].map_color = { 
-- data.raw["tile"]["red-desert-3"].map_color[1]* data.raw["tile"]["red-desert-0"].tint[1],
-- data.raw["tile"]["red-desert-3"].map_color[2]* data.raw["tile"]["red-desert-0"].tint[2],
-- data.raw["tile"]["red-desert-3"].map_color[3]* data.raw["tile"]["red-desert-0"].tint[3] }

-- Yellow Sandy Desert

data.raw["tile"]["sand-1"].tint = { 1, 1 , 1}
data.raw["tile"]["sand-2"].tint = { 1, 1 , 1}
data.raw["tile"]["sand-3"].tint = { 1, 1 , 1}

data.raw["tile"]["dirt-1"].tint = { 0.85, 0.8 , 1}
data.raw["tile"]["dirt-2"].tint = { 1, 1 , 1}
data.raw["tile"]["dirt-3"].tint = { 0.85, 0.9 , 1}

-- Neutral Transition

data.raw["tile"]["dry-dirt"].tint = { 0.80, 0.85 , 1}

data.raw["tile"]["dirt-5"].tint = { 0.7, 0.8 , 1}
data.raw["tile"]["dirt-6"].tint = { 0.8, 0.9 , 1}

update_tile_map_color ("dry-dirt")
update_tile_map_color ("dirt-5")
update_tile_map_color ("dirt-6")

--local newpath = util.copy(data.raw["tile"]["stone-path"])
--local treetile = util.table.deepcopy(data.raw["tile"]["grass-2"])
local treetile = util.table.deepcopy(data.raw["tile"]["grass-2"])
treetile.name = "forest-floor"
treetile.tint = { 0.7, 0.55 , 0.85}
treetile.vehicle_friction_modifier = 6.0
treetile.walking_speed_modifier = 0.65
treetile.layer = 99,

data:extend
({  
	treetile,
})
	
update_tile_map_color ("forest-floor")
-- New tiles
-- Use deepcopies with tints to same storage cap.

-- data:extend
-- ({
-- -- 
  -- {
    -- type = "noise-layer",
    -- name = "snow-tundra-1"
  -- },
  -- {
    -- type = "noise-layer",
    -- name = "snow-1"
  -- },
    -- {
    -- type = "noise-layer",
    -- name = "snow-2"
  -- },
    -- {
    -- type = "noise-layer",
    -- name = "snow-3"
  -- },
 
  
  -- {
    -- type = "noise-layer",
    -- name = "concrete"
  -- },
  -- {
    -- type = "noise-layer",
    -- name = "abandonedbase"
  -- },
-- })
-- red desert (0.55, 0.35, 11, 0.5) ->  (0.8, -10, 11, 0.2)
-- grass (0.45, 0.45, 11, 0.8 -> (-10, 0.5, 0.55, 0.7)

 -- name = "expression_in_range_base",
-- temp min, moisture min, temp max, moist max
-- parameters = {"aux_from", "moisture_from", "aux_to", "moisture_to"},

-- data:extend
-- ({  
  
  -- ------- TUNDRA 1
  -- {
    -- name = "tundra-1",
    -- type = "tile",
    -- order = "b[natural]-c[tundra]-a[tundra-1]",
    -- subgroup = "nauvis-tiles",
    -- collision_mask = tile_collision_masks.ground(),
    -- autoplace = {probability_expression = 'expression_in_range_base(-5, 0.0, 0, 0.25) + noise_layer_noise(36)'},
    -- layer = 11,

    -- variants = tile_variations_template(
       -- "__factorioplus__/graphics/tiles/tundra-1.png", "__base__/graphics/terrain/masks/transition-4.png",
      -- {
        -- max_size = 4,
        -- [1] = { probability = 1, weights = {0.025, 0.010, 0.013, 0.025, 0.025, 0.100, 0.100, 0.005, 0.010, 0.010, 0.005, 0.005, 0.001, 0.015, 0.020, 0.020} },
        -- [2] = { probability = 0.20, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} },
        -- [4] = { probability = 0.10, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
      -- }
    -- ),

    -- transitions = sand_transitions,
    -- transitions_between_transitions = sand_transitions_between_transitions,

    -- walking_sound = sand_sounds,
    -- driving_sound = sand_driving_sound,
    -- map_color={90, 90, 90},
    -- scorch_mark_color = {r = 0.588, g = 0.451, b = 0.272, a = 1.000},
    -- absorptions_per_second = tile_pollution.sand,
    -- vehicle_friction_modifier = sand_vehicle_speed_modifier,

    -- trigger_effect = tile_trigger_effects.sand_trigger_effect(),

  -- },
  -- ------- TUNDRA 2
  -- {
    -- name = "tundra-2",
    -- type = "tile",
    -- order = "b[natural]-c[tundra]-b[tundra-2]",
    -- subgroup = "nauvis-tiles",
    -- collision_mask = tile_collision_masks.ground(),
    -- autoplace = {probability_expression = 'expression_in_range_base(-10, 0.0, -5, 0.2) + noise_layer_noise(37)'},
    -- layer = 12,

    -- variants = tile_variations_template(
       -- "__factorioplus__/graphics/tiles/tundra-2.png", "__base__/graphics/terrain/masks/transition-4.png",
      -- {
        -- max_size = 4,
        -- [1] = { probability = 1, weights = {0.025, 0.010, 0.013, 0.025, 0.025, 0.100, 0.100, 0.005, 0.010, 0.010, 0.005, 0.005, 0.001, 0.015, 0.020, 0.020} },
        -- [2] = { probability = 0.20, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} },
        -- [4] = { probability = 0.10, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
      -- }
    -- ),
    -- factoriopedia_alternative = "tundra-1",

    -- transitions = sand_transitions,
    -- transitions_between_transitions = sand_transitions_between_transitions,

    -- walking_sound = sand_sounds,
    -- driving_sound = sand_driving_sound,
    -- map_color={128, 128, 128},
    -- scorch_mark_color = {r = 0.600, g = 0.440, b = 0.252, a = 1.000},
    -- absorptions_per_second = tile_pollution.sand,
    -- vehicle_friction_modifier = sand_vehicle_speed_modifier,

    -- trigger_effect = tile_trigger_effects.sand_trigger_effect()
  -- },
  -- ------- TUNDRA 3
  -- {
    -- name = "tundra-3",
    -- type = "tile",
    -- order = "b[natural]-c[tundra]-c[tundra-3]",
    -- subgroup = "nauvis-tiles",
    -- collision_mask = tile_collision_masks.ground(),
    -- autoplace = {probability_expression = 'expression_in_range_base(-20, 0.0, -10, 0.1) + noise_layer_noise(36)'},
    -- layer = 13,
    -- variants = tile_variations_template(
      -- "__factorioplus__/graphics/tiles/tundra-3.png", "__base__/graphics/terrain/masks/transition-4.png",
      -- {
        -- max_size = 4,
        -- [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        -- [2] = { probability = 0.39, weights = {0.025, 0.010, 0.013, 0.025, 0.025, 0.100, 0.100, 0.005, 0.010, 0.010, 0.005, 0.005, 0.001, 0.015, 0.020, 0.020}, },
        -- [4] = { probability = 0.39, weights = {0.025, 0.010, 0.013, 0.025, 0.025, 0.100, 0.100, 0.005, 0.010, 0.010, 0.005, 0.005, 0.001, 0.015, 0.020, 0.020}, },
        -- --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
      -- }
    -- ),
    -- factoriopedia_alternative = "tundra-1",

    -- transitions = sand_transitions,
    -- transitions_between_transitions = sand_transitions_between_transitions,

    -- walking_sound = sand_sounds,
    -- driving_sound = sand_driving_sound,
    -- map_color={200, 200, 200},
    -- scorch_mark_color = {r = 0.620, g = 0.472, b = 0.279, a = 1.000},
    -- absorptions_per_second = tile_pollution.sand,
    -- vehicle_friction_modifier = sand_vehicle_speed_modifier,

    -- trigger_effect = tile_trigger_effects.sand_trigger_effect()
  -- },
 -- })
 
 -- data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["tile"].settings["tundra-1"] = {}
-- data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["tile"].settings["tundra-2"] = {}
-- data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["tile"].settings["tundra-3"] = {}
 

local abandonmentstonepath = util.table.deepcopy(data.raw["tile"]["stone-path"])
abandonmentstonepath.name = "stone-path-abandonment"
abandonmentstonepath.can_be_part_of_blueprint = false
abandonmentstonepath.hidden = true
data:extend({abandonmentstonepath})

local oceanwater = util.table.deepcopy(data.raw["tile"]["deepwater"])
oceanwater.name = "oceanwater"

---------------------------------- CLOUDS ------------------------------------

data.raw["planet"]["nauvis"].surface_render_parameters.clouds.scale = 1/6
data.raw["planet"]["nauvis"].surface_render_parameters.clouds.opacity = 0.2
	
---------------------------------- DEEP WATER ------------------------------------
data:extend
({  
	{
	  type = "collision-layer",
	  name = "deep_water_tile",
	},
})

table.insert(data.raw["tile"]["deepwater"].collision_mask, { deep_water_tile = true } )

data.raw["tile"]["deepwater"].autoplace = {probability_expression = "water_base(-3, 100)"}
data.raw["tile"]["deepwater"].absorptions_per_second = pollution_deepwater
data.raw["tile"]["deepwater"].walking_speed_modifier = 0.4
data.raw["tile"]["deepwater"].effect_color = {21, 99, 111}
data.raw["tile"]["deepwater"].effect_color_secondary = { 35, 68, 45 }
data.raw["tile"]["deepwater"].allowed_neighbors = { "water", "oceanwater" }
data.raw["tile"]["deepwater"].variants =
{
  main =
  {
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater1.png",
	  count = 1,
	  scale = 0.5,
	  size = 1
	},
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater2.png",
	  count = 1,
	  scale = 0.5,
	  size = 2
	},
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater4.png",
	  count = 1,
	  scale = 0.5,
	  size = 4
	}
  },
  empty_transitions = true
}

data.raw["tile"]["deepwater-green"].effect_color = { 35, 58, 25 }
data.raw["tile"]["deepwater-green"].variants =
{
  main =
  {
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater-green1.png",
	  count = 1,
	  scale = 0.5,
	  size = 1
	},
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater-green2.png",
	  count = 1,
	  scale = 0.5,
	  size = 2
	},
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater-green4.png",
	  count = 1,
	  scale = 0.5,
	  size = 4
	}
  },
  empty_transitions = true
}

---------------------------------- OCEAN WATER ------------------------------------


data:extend
({  
	{
	  type = "collision-layer",
	  name = "ocean_water_tile",
	},	
	oceanwater,
})


table.insert(data.raw["tile"]["oceanwater"].collision_mask, { ocean_water_tile = true } )

data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["tile"].settings["oceanwater"] = {}
data.raw["tile"]["oceanwater"].absorptions_per_second = pollution_ocean
data.raw["tile"]["oceanwater"].autoplace = {probability_expression = "water_base(-30, 200)"}
data.raw["tile"]["oceanwater"].effect_color = {21/1.5, 99/1.5, 111/1.5}
data.raw["tile"]["oceanwater"].effect_color_secondary = { 35/1.5, 68/1.5, 45/1.5 }
data.raw["tile"]["oceanwater"].map_color = {38/1.5, 64/1.5, 73/1.5}
-- data.raw["tile"]["oceanwater"].transition_merges_with_tile = "deepwater"
data.raw["tile"]["oceanwater"].allowed_neighbors = { "deepwater" }

-- allowed to be covered by space-age advanced foundation tiles
if (mods["space-age"]) then
	data.raw["tile"]["oceanwater"].default_cover_tile = "foundation"
	table.insert(data.raw["item"]["foundation"].place_as_tile.tile_condition, "oceanwater")
end

data.raw["tile"]["oceanwater"].variants =
{
  main =
  {
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater1.png",
	  count = 1,
	  scale = 0.5,
	  size = 1
	},
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater2.png",
	  count = 1,
	  scale = 0.5,
	  size = 2
	},
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater4.png",
	  count = 1,
	  scale = 0.5,
	  size = 4
	}
  },
  empty_transitions = true
}

local oceanwatergreen = util.table.deepcopy(data.raw["tile"]["deepwater-green"])
oceanwatergreen.name = "oceanwater-green"

data:extend
({  
	oceanwatergreen,
})

data.raw["tile"]["oceanwater-green"].effect_color = { 35/1.5, 58/1.5, 25/1.5 }
data.raw["tile"]["oceanwater-green"].absorptions_per_second = pollution_ocean
data.raw["tile"]["oceanwater-green"].variants =
{
  main =
  {
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater-green1.png",
	  count = 1,
	  scale = 0.5,
	  size = 1
	},
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater-green2.png",
	  count = 1,
	  scale = 0.5,
	  size = 2
	},
	{
	  picture = "__factorioplus__/graphics/tiles/deepwater-green4.png",
	  count = 1,
	  scale = 0.5,
	  size = 4
	}
  },
  empty_transitions = true
}


---------------------------------- WATER ------------------------------------


data.raw["tile"]["water"].walking_speed_modifier = 0.6
data.raw["tile"]["water"].vehicle_friction_modifier = water_vehicle_friction_modifier
data.raw["tile"]["water"].autoplace = {probability_expression = "water_base(-1, 50)"}
data.raw["tile"]["water"].walking_sound = tile_sounds.walking.shallow_water
data.raw["tile"]["water"].driving_sound = tile_sounds.driving.shallow_water
data.raw["tile"]["water"].trigger_effect = tile_trigger_effects.water_trigger_effect()
data.raw["tile"]["water"].destroys_dropped_items = false

data.raw["tile"]["water"].collision_mask = 
{layers={
	  water_tile=true,
	  resource=true,
	  item=true,
	  doodad=true,
	  floor=true
}}

data.raw["tile"]["water-green"].walking_speed_modifier = 0.5
data.raw["tile"]["water-green"].walking_sound = tile_sounds.walking.shallow_water
data.raw["tile"]["water-green"].driving_sound = tile_sounds.driving.shallow_water
data.raw["tile"]["water-green"].trigger_effect = tile_trigger_effects.water_trigger_effect()
data.raw["tile"]["water-green"].destroys_dropped_items = false
data.raw["tile"]["water-green"].collision_mask =
{layers={
	  water_tile=true,
	  resource=true,
	  item=true,
	  doodad=true,
	  floor=true
}}

--data.raw["tile"]["water"].is_foundation = false
--data.raw["tile"]["water-green"].is_foundation = false
---data.raw["tile"]["deepwater"].is_foundation = false
--data.raw["tile"]["deepwater-green"].is_foundation = false

---------------------------------- SHALLOW WATER ------------------------------------

data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["tile"].settings["water-shallow"] = {}
data.raw["tile"]["water-shallow"].walking_speed_modifier = 0.8
data.raw["tile"]["water-shallow"].vehicle_friction_modifier = water_shallow_vehicle_friction_modifier
data.raw["tile"]["water-shallow"].tint ={r=1, g=1, b=1, a=1}
data.raw["tile"]["water-shallow"].autoplace = {probability_expression = "water_base(0, 5)"}  
data.raw["tile"]["water-shallow"].collision_mask =
{layers={
	  water_tile=true,
	  resource=true,
	  item=true,
	  doodad=true,
	  floor=true
}}

local tarmac_tint = { a = 1, r=0.25, g=0.25, b=0.25}
 
data:extend
({
    
  {
    type = "tile",
    name = "tarmac",
    order = "a-b-a",
    needs_correction = false,
    minable = {mining_time = 0.1, result = "tarmac"},
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.8},
    collision_mask = tile_collision_masks.ground(),
    walking_speed_modifier = walking_speed_tarmac,
   vehicle_friction_modifier = tarmac_vehicle_speed_modifier,
    layer = 59,
    transition_overlay_layer_offset = 2, -- need to render border overlay on top of hazard-concrete
    decorative_removal_probability = 1.0,
	
	variants =
    {
      transition =
      {
        overlay_layout =
        {
          inner_corner =
          {
            spritesheet = "__factorioplus__/graphics/tiles/hr-tarmac-inner-corner.png",
            count = 16,
			tint = tarmac_tint,
            scale = 0.5
          },
          outer_corner =
          {
            spritesheet = "__factorioplus__/graphics/tiles/hr-tarmac-outer-corner.png",
            count = 8,
			tint = tarmac_tint,
            scale = 0.5
          },
          side =
          {
            spritesheet = "__factorioplus__/graphics/tiles/hr-tarmac-side.png",
            count = 16,
			tint = tarmac_tint,
            scale = 0.5
          },
          u_transition =
          {
            spritesheet = "__factorioplus__/graphics/tiles/hr-tarmac-u.png",
            count = 8,
			tint = tarmac_tint,
            scale = 0.5
          },
          o_transition =
          {
            spritesheet = "__factorioplus__/graphics/tiles/hr-tarmac-o.png",
            count = 4,
			tint = tarmac_tint,
            scale = 0.5
          }
        },
        mask_layout =
        {
          inner_corner =
          {
            spritesheet = "__base__/graphics/terrain/concrete/concrete-inner-corner-mask.png",
            count = 16,
			tint = tarmac_tint,
            scale = 0.5
          },
          outer_corner =
          {
            spritesheet = "__base__/graphics/terrain/concrete/concrete-outer-corner-mask.png",
            count = 8,
			tint = tarmac_tint,
            scale = 0.5
          },
          side =
          {
            spritesheet = "__base__/graphics/terrain/concrete/concrete-side-mask.png",
            count = 16,
			tint = tarmac_tint,
            scale = 0.5
          },
          u_transition =
          {
            spritesheet = "__base__/graphics/terrain/concrete/concrete-u-mask.png",
            count = 8,
			tint = tarmac_tint,
            scale = 0.5
          },
          o_transition =
          {
            spritesheet = "__base__/graphics/terrain/concrete/concrete-o-mask.png",
            count = 4,
			tint = tarmac_tint,
            scale = 0.5
          }
        }
      },

      material_background =
      {
        picture = "__factorioplus__/graphics/tiles/hr-tarmac.png",
        count = 8,
		tint = tarmac_tint,
        scale = 0.5
      }
    },

    transitions = concrete_transitions,
    transitions_between_transitions = concrete_transitions_between_transitions,

    walking_sound = concrete_sounds,
	driving_sound = concrete_driving_sound,
    build_sound = concrete_tile_build_sounds,
    map_color={r=23, g=21, b=29},
    scorch_mark_color = {r = 0.273, g = 0.207, b = 0.243, a = 1.000},	
 

    trigger_effect = tile_trigger_effects.concrete_trigger_effect(),
  }
  
})


-- orientations.north_to_south.pictures.layers.tint

-- local redcliff = util.copy(data.raw["cliff"]["cliff"])
-- redcliff.name = redcliff.name .. "-" .. "red"

 -- for i, v in pairs(redcliff.orientations) do
	-- for j, k in pairs(v.pictures) do
		-- for l, m in pairs(k.layers) do
			-- m.tint = {1, 0.75 , 0.6}
		-- end
	-- end
	-- for j, k in pairs(v.pictures_lower) do
		-- for l, m in pairs(k.layers) do
			-- m.tint = {1, 0.75 , 0.6}
		-- end
	-- end
 -- end

-- data:extend{redcliff}

-- data.raw["cliff"]["cliff"].autoplace.tile_restriction = {"sand-1","sand-2","sand-3","dirt-3","dirt-2","dirt-1","grass-1","grass-2","grass-3","grass-4","dirt-5","dirt-6","dirt-7","dry-dirt"} 