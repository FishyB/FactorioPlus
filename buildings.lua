local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local movement_triggers = require("__base__.prototypes.entity.movement-triggers")
require ("__base__.prototypes.entity.pipecovers")
require ("__factorioplus__.transport-belt-pictures")
require ("__factorioplus__.util-building-additions")


---------------------------------------------------  RAIL OVERRIDES  ------------------------------------------------------------
 
 table.insert(data.raw["legacy-straight-rail"]["legacy-straight-rail"].resistances ,  { type = "explosion", percent = 90 } )
 table.insert(data.raw["legacy-curved-rail"]["legacy-curved-rail"].resistances ,  { type = "explosion", percent = 90 } )
 table.insert(data.raw["legacy-straight-rail"]["legacy-straight-rail"].resistances ,  { type = "physical", percent = 90 } )
 table.insert(data.raw["legacy-curved-rail"]["legacy-curved-rail"].resistances ,  { type = "physical", percent = 90 } )
 
 if (data.raw["rail-chain-signal"]["rail-chain-signal"].resistances == nil)
 then data.raw["rail-chain-signal"]["rail-chain-signal"].resistances = {{ type = "explosion", percent = 90 }}
 else table.insert(data.raw["rail-chain-signal"]["rail-chain-signal"].resistances ,  { type = "explosion", percent = 90 } )
 end
 
  if (data.raw["rail-signal"]["rail-signal"].resistances == nil)
 then data.raw["rail-signal"]["rail-signal"].resistances = {{ type = "explosion", percent = 90 }}
 else table.insert(data.raw["rail-signal"]["rail-signal"].resistances ,  { type = "explosion", percent = 90 } )
 end
 
 table.insert(data.raw["straight-rail"]["straight-rail"].resistances ,  { type = "explosion", percent = 90 } )
 table.insert(data.raw["half-diagonal-rail"]["half-diagonal-rail"].resistances ,  { type = "explosion", percent = 90 } )
 table.insert(data.raw["straight-rail"]["straight-rail"].resistances ,  { type = "physical", percent = 90 } )
 table.insert(data.raw["half-diagonal-rail"]["half-diagonal-rail"].resistances ,  { type = "physical", percent = 90 } )
 
 table.insert(data.raw["curved-rail-a"]["curved-rail-a"].resistances ,  { type = "explosion", percent = 90 } )
 table.insert(data.raw["curved-rail-a"]["curved-rail-a"].resistances ,  { type = "physical", percent = 90 } )
 
  table.insert(data.raw["curved-rail-b"]["curved-rail-b"].resistances ,  { type = "explosion", percent = 90 } )
 table.insert(data.raw["curved-rail-b"]["curved-rail-b"].resistances ,  { type = "physical", percent = 90 } )
 
 ---------------------------------------------------  ELECTRIC POLE OVERRIDES  ------------------------------------------------------------

data.raw["electric-pole"]["big-electric-pole"].maximum_wire_distance = 32
data.raw["electric-pole"]["big-electric-pole"].fast_replaceable_group = "electric-pole"
data.raw["electric-pole"]["substation"].fast_replaceable_group = "electric-pole"

---------------------------------------------------  CONTAINER OVERRIDES  ------------------------------------------------------------
local chest_steel_size = 30
local hut_size = 50
local warehouse_size = 130

data.raw["container"]["wooden-chest"].inventory_size = 10
data.raw["container"]["iron-chest"].inventory_size = 20
data.raw["container"]["steel-chest"].inventory_size = chest_steel_size


data.raw["logistic-container"]["passive-provider-chest"].inventory_size = chest_steel_size
data.raw["logistic-container"]["active-provider-chest"].inventory_size = chest_steel_size
data.raw["logistic-container"]["storage-chest"].inventory_size = chest_steel_size
data.raw["logistic-container"]["buffer-chest"].inventory_size = chest_steel_size
data.raw["logistic-container"]["requester-chest"].inventory_size = chest_steel_size

---------------------------------------------------  BELT OVERRIDES  ------------------------------------------------------------

local basic_belt_animation_set =
{
  animation_set =
  {
    filename = "__base__/graphics/entity/transport-belt/transport-belt.png",
    priority = "extra-high",
    size = 128,
    scale = 0.5,
    frame_count = 16,
    direction_count = 20
  },
}
  
  local fast_belt_animation_set =
{
  animation_set =
  {
    filename = "__base__/graphics/entity/fast-transport-belt/fast-transport-belt.png",
    priority = "extra-high",
    size = 128,
    scale = 0.5,
    frame_count = 32,
    direction_count = 20
  }
}
local express_belt_animation_set =
{
  animation_set =
  {
    filename = "__base__/graphics/entity/express-transport-belt/express-transport-belt.png",
    priority = "extra-high",
    size = 128,
    scale = 0.5,
    frame_count = 32,
    direction_count = 20
  }
}

-- prototype "express-loader" (loader): next_upgrade target (turbo-loader) 
-- must have an item that builds it that isn't hidden.
  
-- 0.00208333333333333333333333333333 (1 item per second rate)
local const_beltpersec = 0.00208333333333333333333333333333

local speed_slowbelts = const_beltpersec * 8 -- Grey
local speed_basicbelts= const_beltpersec * 16 -- Yellow
local speed_fastbelts = const_beltpersec * 32 -- Red
local speed_expressbelts = const_beltpersec * 48 -- Blue
local speed_turbobelts = const_beltpersec * 64 -- Purple
local speed_superbelts = const_beltpersec * 80 -- Green
local speed_lightningbelts = const_beltpersec * 96 -- White

data.raw["underground-belt"]["underground-belt"].speed = speed_basicbelts
data.raw["splitter"]["splitter"].speed = speed_basicbelts
data.raw["transport-belt"]["transport-belt"].speed = speed_basicbelts

data.raw["underground-belt"]["fast-underground-belt"].speed = speed_fastbelts
data.raw["splitter"]["fast-splitter"].speed = speed_fastbelts
data.raw["transport-belt"]["fast-transport-belt"].speed = speed_fastbelts

data.raw["underground-belt"]["express-underground-belt"].speed = speed_expressbelts
data.raw["underground-belt"]["express-underground-belt"].next_upgrade = "turbo-underground-belt"
data.raw["splitter"]["express-splitter"].speed = speed_expressbelts

data.raw["splitter"]["express-splitter"].next_upgrade = "turbo-splitter"
data.raw["transport-belt"]["express-transport-belt"].speed = speed_expressbelts
data.raw["transport-belt"]["express-transport-belt"].next_upgrade = "turbo-transport-belt"

 if (data.raw["transport-belt"]["transport-belt"].resistances == nil)
 then data.raw["transport-belt"]["transport-belt"].resistances = {{ type = "explosion", percent = 90 },{ type = "fire", percent = 90 }}
 else table.insert(data.raw["transport-belt"]["transport-belt"].resistances ,  { type = "explosion", percent = 90 } )
		table.insert(data.raw["transport-belt"]["transport-belt"].resistances ,  { type = "fire", percent = 90 } )
 end
 
if (data.raw["transport-belt"]["fast-transport-belt"].resistances == nil)
 then data.raw["transport-belt"]["fast-transport-belt"].resistances = {{ type = "explosion", percent = 90 },{ type = "fire", percent = 90 }}
 else table.insert(data.raw["transport-belt"]["fast-transport-belt"].resistances ,  { type = "explosion", percent = 90 } )
		table.insert(data.raw["transport-belt"]["fast-transport-belt"].resistances ,  { type = "fire", percent = 90 } )
 end
 
 if (data.raw["transport-belt"]["express-transport-belt"].resistances == nil)
 then data.raw["transport-belt"]["express-transport-belt"].resistances = {{ type = "explosion", percent = 90 },{ type = "fire", percent = 90 }}
 else table.insert(data.raw["transport-belt"]["express-transport-belt"].resistances ,  { type = "explosion", percent = 90 } )
		table.insert(data.raw["transport-belt"]["express-transport-belt"].resistances ,  { type = "fire", percent = 90 } )
 end
 

---------------------------------------------------  MACHINE PRESS ASSEMBLER OVERRIDES  ------------------------------------------------------------

--table.insert(data.raw["assembling-machine"]["assembling-machine-1"].crafting_categories , "crafting-machinepress"  )
--table.insert(data.raw["assembling-machine"]["assembling-machine-2"].crafting_categories , "crafting-machinepress"  )
--table.insert(data.raw["assembling-machine"]["assembling-machine-3"].crafting_categories , "crafting-machinepress"  )

---------------------------------------------------  PUMP OVERRIDES  ------------------------------------------------------------

data.raw["offshore-pump"]["offshore-pump"].pumping_speed = 6


local lft_pipespacing = 2.5
local lft_pipespacing_y = lft_pipespacing - 1

---------------------------------------------------  LARGE FLUID TANK  ------------------------------------------------------------
data.extend({
{
    type = "storage-tank",
    name = "storage-tank-large",
    icon = "__factorioplus__/graphics/icons/storage-tank-large.png",
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "storage-tank-large"},
    max_health = 4000,
    corpse = "storage-tank-remnants",
    dying_explosion = "storage-tank-explosion",
    collision_box = {{-2.9, -2.9}, {2.9, 2.9}},
    selection_box = {{-3.0, -3.0}, {3.0, 3.0}},
    fast_replaceable_group = "storage-tank-large",
    damaged_trigger_effect = hit_effects.entity(),
    icon_draw_specification = {scale = 2, shift = {0, -0.3}},
    fluid_box =
    {
      volume = 25000 * 10,
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        { direction = defines.direction.north, position = {-lft_pipespacing_y, -lft_pipespacing} },
		{ direction = defines.direction.north, position = {lft_pipespacing_y, -lft_pipespacing} },
        { direction = defines.direction.east, position = {lft_pipespacing, lft_pipespacing_y} },
		{ direction = defines.direction.east, position = {lft_pipespacing,-lft_pipespacing_y} },
        { direction = defines.direction.south, position = {-lft_pipespacing_y, lft_pipespacing} },
		 { direction = defines.direction.south, position = {lft_pipespacing_y, lft_pipespacing} },
        { direction = defines.direction.west, position = {-lft_pipespacing, lft_pipespacing_y} },
		{ direction = defines.direction.west, position = {-lft_pipespacing, -lft_pipespacing_y} },
      },
      hide_connection_info = true
    },
    two_direction_only = true,
    window_bounding_box = {{0.5, 0.9}, {0.55, 2.55}},
    pictures =
    {
      picture =
      {
        sheets =
        {
          {
            filename = "__factorioplus__/graphics/largefluidtank.png",
            priority = "extra-high",
            frames = 1,
            width = 391,
            height = 400,
            shift = util.by_pixel(-0.25, 0),
            scale = 0.5
          },
            {
            filename = "__factorioplus__/graphics/largefluidtank-shadow.png",
            priority = "extra-high",
            frames = 1,
			draw_as_shadow = true,
            width = 512,
            height = 348,
            shift = util.by_pixel(32, 0),
            scale = 0.5
          },
        }
      },
      fluid_background =
      {
        filename = "__base__/graphics/entity/storage-tank/fluid-background.png",
        priority = "extra-high",
        width = 32,
        height = 15
      },
      window_background =
      {
        filename = "__factorioplus__/graphics/largefluidtank-fluid.png",
        priority = "extra-high",
        width = 48,
        height = 192,
        scale = 0.3
      },
      flow_sprite =
      {
        filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
        priority = "extra-high",
        width = 160,
        height = 20
      },
      gas_flow =
      {
        filename = "__base__/graphics/entity/pipe/steam.png",
        priority = "extra-high",
        line_length = 10,
        width = 48,
        height = 30,
        frame_count = 60,
        animation_speed = 0.25,
        scale = 0.5
      }
    },
    flow_length_in_ticks = 360,
    impact_category = "metal-large",
    open_sound = sounds.metal_large_open,
    close_sound = sounds.metal_large_close,
    working_sound =
    {
      sound = {filename = "__base__/sound/storage-tank.ogg", volume = 0.6, audible_distance_modifier = 0.5},
      match_volume_to_activity = true,
      max_sounds_per_prototype = 3
    },

    circuit_connector = circuit_connector_definitions["storage-tank"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/storage-tank/storage-tank-reflection.png",
        priority = "extra-high",
        width = 24,
        height = 24,
        shift = util.by_pixel(5, 35),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
})

---------------------------------------------------  AIR SCRUBBER  ------------------------------------------------------------
  
data.extend({
{
    type = "electric-energy-interface",
    name = "air-scrubber",
    icon = "__factorioplus__/graphics/icons/air_scrubber.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-player", "player-creation", "placeable-neutral", "not-rotatable"},
    map_color = {r = 0, g = 0.365, b = 0.58, a = 1},
	minable = {mining_time = 0.2, result = "air-scrubber"},
    max_health = 250,
    corpse = "medium-remnants",
    subgroup = "other",
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    allow_copy_paste = true,
	continuous_animation = true,
	energy_source =
    {
      type = "electric",
	  usage_priority = "secondary-input",
	  buffer_capacity = "275kW",
      input_flow_limit = "275kW",
      output_flow_limit = "0kW",
	  drain = "20kW",
      emissions_per_minute = {pollution = -6},	  
    },
	
    energy_usage = "275kW",	

    -- light = {intensity = 0.75, size = 6, color = {r = 1.0, g = 1.0, b = 1.0}, shift = {64/64, -140/64}},
    --continuous_animation = true,
    --integration_patch_render_layer = "decals",
    -- also 'pictures' for 4-way sprite is available, or 'animation' resp. 'animations'

    animation =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/air_scrubber.png",
            priority = crash_site_sprite_priority,
            width = 1120/4,
			height= 363,
			run_mode = "forward",
            frame_count = 4,
            line_length = 4,
            animation_speed =  1/2,
            shift = util.by_pixel(0, -16),
            scale = 0.3525
        }, 
		{
          filename = "__factorioplus__/graphics/air_scrubber_shadow.png",
            priority = crash_site_sprite_priority,
            width = 375,
			height= 363,
            frame_count = 1,
            line_length = 1,
            repeat_count = 4,
            animation_speed = crash_site_generator_animation_speed,
            shift = util.by_pixel(18, -16),
            scale = 0.3625,
			draw_as_shadow = true,
        },
      },
    },
    vehicle_impact_sound = sounds.generic_impact
  },
})

if (mods["space-age"]) then  
data.raw["electric-energy-interface"]["air-scrubber"].energy_source.emissions_per_minute = {pollution = -6, spores = -4 }
end


data.extend({


  ---------------------------------------------------  AIR SCRUBBER LARGE  ------------------------------------------------------------

{
    type = "electric-energy-interface",
    name = "air-scrubber-large",
    icon = "__factorioplus__/graphics/icons/air_scrubber_large.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-player", "player-creation", "placeable-neutral", "not-rotatable"},
    map_color = {r = 0, g = 0.365, b = 0.58, a = 1},
	minable = {mining_time = 0.4, result = "air-scrubber-large"},
    max_health = 800,
    corpse = "medium-remnants",
    subgroup = "other",
    collision_box = {{-3.8, -3.8}, {3.8, 3.8}},
    selection_box = {{-4, -4}, {4, 4}},
    allow_copy_paste = true,
	continuous_animation = true,
	energy_source =
    {
      type = "electric",
	  usage_priority = "secondary-input",
	  buffer_capacity = "550kW",
      input_flow_limit = "550kW",
      output_flow_limit = "0kW",
	  drain = "50kW",
      emissions_per_minute = {pollution = -64},	  
    },
    energy_usage = "550kW",	
	
    -- light = {intensity = 0.75, size = 6, color = {r = 1.0, g = 1.0, b = 1.0}, shift = {64/64, -140/64}},
    --continuous_animation = true,
    --integration_patch_render_layer = "decals",
    -- also 'pictures' for 4-way sprite is available, or 'animation' resp. 'animations'

    animation =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/air_scrubber_large.png",
          priority = crash_site_sprite_priority,
          width = 1800/4,
          height = 527,
          frame_count = 4,
          line_length = 4,
          shift = util.by_pixel(0, -4),
          animation_speed = 1/2,
		  scale = 0.55,
        },    
        {
          filename = "__factorioplus__/graphics/air_scrubber_large_shadow.png",
          priority = crash_site_sprite_priority,
          width = 591,
          height = 547,
          frame_count = 1,
          line_length = 1,
          repeat_count = 4,
          shift = util.by_pixel(20, -4),
          animation_speed = crash_site_generator_animation_speed,
		  scale = 0.5,
		  draw_as_shadow = true,
        },    
      },
    },
    vehicle_impact_sound = sounds.generic_impact
  },
})

if (mods["space-age"]) then  
data.raw["electric-energy-interface"][ "air-scrubber-large"].energy_source.emissions_per_minute = {pollution = -64, spores = -32 }
end


data.extend({  
  
  
  
---------------------------------------------------  FACTORY  ------------------------------------------------------------
{
    type = "assembling-machine",
    name = "factory-large",
    icon = "__factorioplus__/graphics/icons/factory.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 2.0, result = "factory-large"},
    max_health = 1600,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 80
      }
    },
    collision_box = {{-2.8, -2.8}, {2.8, 2.8}},
    selection_box = {{-2.95, -2.95}, {2.95, 2.95}},
    --damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "assembling-machine",
    --next_upgrade = "assembling-machine-2",
    alert_icon_shift = util.by_pixel(-3, -12),
	 graphics_set =
    {
		
		animation =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/factory-1.png",
			  priority="high",
			  width = 411,
			  height = 588,
			  frame_count = 1,
			  line_length = 1,
			  shift = util.by_pixel(0, -48),
			  scale = 0.5,
			},
			{
			  filename = "__factorioplus__/graphics/factory-1-shadow.png",
			  priority="high",
			  width = 640,
			  height = 264,
			  frame_count = 1,
			  line_length = 1,
			  repeat_count = 1,
			  draw_as_shadow = true,
			  shift = util.by_pixel(64, 32),
			  scale = 0.5,
			}
		  }
		},		
	},
	
    crafting_categories = {"crafting", "basic-crafting", "advanced-crafting"},
    crafting_speed = 2.5,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {pollution=8},
    },
    energy_usage = "1050kW",
    -- open_sound = sounds.machine_open,
    -- close_sound = sounds.machine_close,
    -- vehicle_impact_sound = sounds.generic_impact,
	effect_receiver = {
		base_effect = {
			productivity = 0.25,
		}
	},
	
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.8,
		  speed = 0.5
        },
      },
      audible_distance_modifier = 1.0,
      fade_in_ticks = 4,
      fade_out_ticks = 25
    },

    module_slots = 3,
	
	circuit_connector = circuit_connector_definitions["factory"],
   circuit_wire_max_distance = default_circuit_wire_max_distance,

    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"}
},
---------------------------------------------------  MINI ASSEMBLER  ------------------------------------------------------------
{
    type = "assembling-machine",
    name = "mini-assembling-machine-1",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "mini-assembling-machine-1"},
    max_health = 175,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 60
      }
    },
    collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selection_box = {{-1, -1}, {1, 1}},
    --damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "assembling-machine",
    --next_upgrade = "assembling-machine-2",
    alert_icon_shift = util.by_pixel(-3, -12),
	graphics_set =
    {
		animation =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/mini-assembler.png",
			  priority="high",
			  width = 1024/4,
			  height = 768/2,
			  frame_count = 8,
			  line_length = 4,
			  shift = util.by_pixel(0, -21),
			  scale = 0.275,
			},
			{
			  filename = "__factorioplus__/graphics/mini-assembler_shadow.png",
			  priority="high",
			  width = 192,
			  height = 128,
			  frame_count = 1,
			  line_length = 1,
			  repeat_count = 8,
			  draw_as_shadow = true,
			  shift = util.by_pixel(16, -4),
			  scale = 0.5,
			}
		  }
		},
	},
    crafting_categories = {"crafting", "basic-crafting", "advanced-crafting"},
    crafting_speed = 0.8,
	ingredient_count = 2,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {pollution=1},
    },
    energy_usage = "32kW",
    -- open_sound = sounds.machine_open,
    -- close_sound = sounds.machine_close,
    -- vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.4,
		  speed = 1.5
        },
      },
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
	
	circuit_connector = circuit_connector_definitions["mini-assembler"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
	
    module_slots = 3,
    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
	
	icon_draw_specification = {scale = 0.6},

},
})


data.extend({

--------------------------------------------------- HIGH POWERED MACHINE PRESS ------------------------------------------------------------
{
    type = "assembling-machine",
    name = "metal-press-machine",
    icon = "__factorioplus__/graphics/icons/metal-press-machine.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "metal-press-machine"},
    max_health = 240,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
	
	effect_receiver = {
		base_effect = {
			productivity = 1,
		}
	},
	
	scale_entity_info_icon = true,
    resistances =
    {
      {
        type = "fire",
        percent = 40
      }
    },
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    --damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "assembling-machine",
    alert_icon_shift = util.by_pixel(-3, -12),

	graphics_set =
    {
    animation =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/metal-press-machine.png",
          priority="high",
          width = 1620/9,
          height = 480/2,
          frame_count = 18,
          line_length = 9,
          shift = util.by_pixel(0, -16),
		  scale = 0.55,
        },
        {
          filename = "__factorioplus__/graphics/metal-press-machine-shadow.png",
          priority="high",
          width = 2880/9,
          height = 256/2,
          frame_count = 18,
          line_length = 9,
          draw_as_shadow = true,
          shift = util.by_pixel(39, 13),
		  scale = 0.55,
        }
      }
    },
	},
    crafting_categories = {"crafting-machinepress"},
	--"advanced-crafting"
    crafting_speed = 1,
	ingredient_count = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {pollution=6},
    },
    energy_usage = "650kW",
    -- open_sound = sounds.machine_open,
    -- close_sound = sounds.machine_close,
    -- vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
	  match_speed_to_activity = true,
      sound =
      {
        {
          filename = "__factorioplus__/sounds/hpmp.ogg",
          volume = 0.3,
		  min_speed = 0.1,
		  max_speed =1.4,
        },
      },
      audible_distance_modifier = 0.5,
    },
	circuit_connector = circuit_connector_definitions["hpmp"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
	
	allowed_effects = {"consumption", "speed", "productivity", "pollution"}
},

---------------------------------------------------  COMPRESSOR ------------------------------------------------------------
{
    type = "assembling-machine",
    name = "compressor",
    icon = "__factorioplus__/graphics/icons/compressor.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "compressor"},
    max_health = 400,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
	scale_entity_info_icon = true,
    resistances =
    {
      {
        type = "fire",
        percent = 40
      }
    },
	 fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = {{ flow_direction="input",direction = defines.direction.north, position = {0, - 2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = {{ flow_direction="output",direction = defines.direction.south, position = {0,2} }},
        secondary_draw_orders = { north = -1 }
      },
      
    },
	off_when_no_fluid_recipe = false,
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    --damaged_trigger_effect = hit_effects.entity(),
    -- fast_replaceable_group = "assembling-machine",
    --next_upgrade = "assembling-machine-2",
    alert_icon_shift = util.by_pixel(-3, -12),
	
	graphics_set =
	{
    animation =
    {
	   north =
	   {
		   layers =
		   {
			  {
				
				  filename = "__factorioplus__/graphics/compressor_working_v.png",
				  priority="high",
				  width = 2048/8,
				  height = 576/2,
				  frame_count = 16,
				  line_length = 8,
				  shift = util.by_pixel(0, -16),
				  scale = 0.75,
				  animation_speed = 1.5,       
			  },
			{
				  filename =  "__factorioplus__/graphics/compressor_working_v_shadow.png",
				  priority = "extra-high",
				  width = 2560/8,
				  height = 576/2,
				  frame_count = 16,
				  line_length = 8,
				  shift = util.by_pixel(32, -16),
				  scale = 0.75,
				  animation_speed = 1.5,     
				  draw_as_shadow = true,
			},
			},
		},
		south =
		{
		layers = 
		{
		  {
			
			  filename = "__factorioplus__/graphics/compressor_working_v.png",
			  priority="high",
			  width = 2048/8,
			  height = 576/2,
			  frame_count = 16,
			  line_length = 8,
			  shift = util.by_pixel(0, -16),
			  scale = 0.75,
			  animation_speed = 1.5,     
		  },
			{
			  filename =  "__factorioplus__/graphics/compressor_working_v_shadow.png",
			  priority = "extra-high",
			  width = 2560/8,
			  height = 576/2,
			  frame_count = 16,
			  line_length = 8,
			  shift = util.by_pixel(32, -16),
			  scale = 0.75,
			  animation_speed = 1.5,     
			  draw_as_shadow = true,
			},
			},
		},
	   east =	   
		{
			layers = 
			{
			  {
				  filename = "__factorioplus__/graphics/compressor_working_h.png",
				  priority="high",
				  width = 2048/8,
				  height = 576/2,
				  frame_count = 16,
				  line_length = 8,
				  shift = util.by_pixel(0, -16),
				  scale = 0.75,
				  animation_speed = 1.5,     
			  },
			   {
				  filename =  "__factorioplus__/graphics/compressor_working_h_shadow.png",
				  priority = "extra-high",
				  width = 2560/8,
				  height = 576/2,
				  frame_count = 16,
				  line_length = 8,
				  shift = util.by_pixel(32, -16),
				  scale = 0.75,
				  animation_speed = 1.5,     
				  draw_as_shadow = true,
				},
			},
		},
	   west =
	   
	   {
		   layers = 
			{
			  {
				
				  filename = "__factorioplus__/graphics/compressor_working_h.png",
				  priority="high",
				  width = 2048/8,
				  height = 576/2,
				  frame_count = 16,
				  line_length = 8,
				  shift = util.by_pixel(0, -16),
				  scale = 0.75,
				  animation_speed = 1.5,     
			  },
			   {
				  filename =  "__factorioplus__/graphics/compressor_working_h_shadow.png",
				  priority = "extra-high",
				  width = 2560/8,
				  height = 576/2,
				  frame_count = 16,
				  line_length = 8,
				  shift = util.by_pixel(32, -16),
				  scale = 0.75,
				  animation_speed = 1.5,     
				  draw_as_shadow = true,
				}
			},
		},
    },
	},
	
    crafting_categories = {"crafting-compressor"},
    crafting_speed = 0.5,
	ingredient_count = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {pollution=4},
    },
    energy_usage = "250kW",
    -- open_sound = sounds.machine_open,
    -- close_sound = sounds.machine_close,
    -- vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/assembling-machine-t3-1.ogg",
          volume = 0.7,
		  speed = 0.75,
        },
      },
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
	
	circuit_connector = circuit_connector_definitions["compressor"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
	
     module_slots = 2,
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
},

---------------------------------------------------  BIG FURNACE  ------------------------------------------------------------
{
    type = "furnace",
    name = "big-furnace",
    icon = "__factorioplus__/graphics/icons/big-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.75, result = "big-furnace"},
    max_health = 800,
    corpse = "stone-furnace-remnants",
    dying_explosion = "stone-furnace-explosion",
    -- repair_sound = sounds.manual_repair,
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.9},
    -- open_sound = sounds.machine_open,
    -- close_sound = sounds.machine_close,
    -- vehicle_impact_sound = sounds.car_stone_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/furnace.ogg",
          volume = 0.9
        }
      },
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      audible_distance_modifier = 0.6,
    },
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "explosion",
        percent = 40
      },
      {
        type = "impact",
        percent = 40
      }
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.4, -1.4}, {1.4, 1.4}},
    -- damaged_trigger_effect = hit_effects.rock(),
    crafting_categories = {"smelting"},
    result_inventory_size = 1,
    energy_usage = "175kW",
    crafting_speed = 4.0,
    source_inventory_size = 1,
    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 2,
      emissions_per_minute = { pollution = 8 },
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 18,
          position = {0.0, -1.4},
          starting_vertical_speed = 0.05,
          starting_frame_deviation = 60,
        }
      }
    },
	 graphics_set =
    {
    animation =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/big-furnace.png",
          priority = "extra-high",
          width = 192,
          height = 256,
          frame_count = 1,
          shift = util.by_pixel(0, -18),
		  scale = 0.5,
        },
        {
          filename = "__factorioplus__/graphics/big-furnace-shadow.png",
          priority = "extra-high",
          width = 284,
          height = 256,
          frame_count = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(22, -18),
		  scale = 0.5,
        }
      }
    },
	working_visualisations =
    {
      {
        north_position = {0.0, 0.0},
        east_position = {0.0, 0.0},
        south_position = {0.0, 0.0},
        west_position = {0.0, 0.0},
        animation =
        {
          filename = "__factorioplus__/graphics/big-furnace-on.png",
          priority = "extra-high",
          line_length = 1,
          width = 192,
          height = 256,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 1,
          shift = util.by_pixel(0, -18),
		  scale = 0.5,
        },
        light = {intensity = 1, size = 1, color = {r=1.0, g=1.0, b=1.0}}
      }
    },
	},
    
    fast_replaceable_group = "furnace",
    next_upgrade = "electric-furnace",
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/stone-furnace/stone-furnace-reflection.png",
        priority = "extra-high",
        width = 16,
        height = 16,
        shift = util.by_pixel(0, 35),
        variation_count = 1,
        scale = 0.75,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
  ---------------------------------------------------  STEEL FORGE  ------------------------------------------------------------
{
    type = "furnace",
    name = "steel-forge",
    icon = "__factorioplus__/graphics/icons/steel-forge.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1.75, result = "steel-forge"},
    max_health = 1800,
    corpse = "stone-furnace-remnants",
    dying_explosion = "stone-furnace-explosion",
    -- repair_sound = sounds.manual_repair,
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.9},
    -- open_sound = sounds.machine_open,
    -- close_sound = sounds.machine_close,
    -- vehicle_impact_sound = sounds.car_stone_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/furnace.ogg",
          volume = 0.9
        }
      },
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      audible_distance_modifier = 0.6,
    },
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "explosion",
        percent = 30
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-1.8, -1.8}, {1.8, 1.8}},
    selection_box = {{-1.95, -1.95}, {1.95, 1.95}},
    -- damaged_trigger_effect = hit_effects.rock(),
    crafting_categories = {"smelting"},
    result_inventory_size = 1,
    energy_usage = "365kW",
    crafting_speed = 8,
    source_inventory_size = 1,
    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 2,
     emissions_per_minute = { pollution = 24 },
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 42,
          position = {1.4, -1.9},
          starting_vertical_speed = 0.08,
          starting_frame_deviation = 60,
        }
      }
    },
	 graphics_set =
    {
    animation =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/steel-forge.png",
          priority = "extra-high",
          width = 256,
          height = 320,
          frame_count = 1,
          shift = util.by_pixel(0, -20),
		  scale = 0.5,
        },
        {
          filename = "__factorioplus__/graphics/steel-forge-shadow.png",
          priority = "extra-high",
          width = 400,
          height = 320,
          frame_count = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(40, -18),
		  scale = 0.5,
        }
      }
    },
	 working_visualisations =
    {
      {
        north_position = {0.0, 0.0},
        east_position = {0.0, 0.0},
        south_position = {0.0, 0.0},
        west_position = {0.0, 0.0},
        animation =
        {
          filename = "__factorioplus__/graphics/steel-forge-on.png",
          priority = "extra-high",
          line_length = 4,
          width = 256,
          height = 320,
          frame_count = 4,
          axially_symmetrical = false,
          direction_count = 1,
          shift = util.by_pixel(0, -20),
		  scale = 0.5,
		  animation_speed = electric_drill_animation_speed/2
        },
		
        light = {intensity = 1.25, size = 4, color = {r=1.0, g=1.0, b=1.0}}
		
      },
	  {
        draw_as_light = true,
        draw_as_sprite = false,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          filename = "__factorioplus__/graphics/steel-forge-on-glow.png",
          blend_mode = "additive",
          draw_as_sprite = false,
          width = 256,
          height = 316,
          repeat_count = 4,
		  scale = 0.5,
          shift = util.by_pixel(0, -20),
        },
      },
    },
	},
   
    fast_replaceable_group = "furnace",
    -- next_upgrade = "electric-foundry",
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/stone-furnace/stone-furnace-reflection.png",
        priority = "extra-high",
        width = 16,
        height = 16,
        shift = util.by_pixel(0, 35),
        variation_count = 1,
        scale = 0.75,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
   --------------------------------------------------- ELECTRIC FOUNDRY  ------------------------------------------------------------
  {
    type = "furnace",
    name = "electric-foundry",
    icon = "__factorioplus__/graphics/icons/electric-foundry.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1.5, result = "electric-foundry"},
    max_health = 1400,
    corpse = "electric-furnace-remnants",
    dying_explosion = "electric-furnace-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 80
      }
    },
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    selection_box = {{-2.45, -2.45}, {2.45, 2.45}},
    damaged_trigger_effect = hit_effects.entity(),

      module_slots = 4,
	  
    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    crafting_categories = {"smelting"},
    result_inventory_size = 1,
    crafting_speed = 3,
	effect_receiver = 
	{
		base_effect = 
		{
			productivity = 0.15,
		}
	},
    energy_usage = "500kW",
    source_inventory_size = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 2 },
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.8,
		speed = 0.55,
		advanced_volume_control = {attenuation = "exponential"},
        audible_distance_modifier = 0.5,
      },
	  max_sounds_per_prototype = 4,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
	 graphics_set =
    {
		animation =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/electric-foundry.png",
			  priority = "high",
			  width = 380,
			  height = 439,
			  frame_count = 1,
			  shift = util.by_pixel(0, -10),
			  scale = 0.425,
			},
			{
			  filename = "__factorioplus__/graphics/electric-foundry-shadow.png",
			  priority = "high",
			  width = 400,
			  height = 190,
			  frame_count = 1,
			  shift = util.by_pixel(36, 26),
			  scale = 0.6,
			  draw_as_shadow = true,
			}
		  }
		},
		working_visualisations =
		{
			{
				  fadeout = true,
				  effect = "flicker",
				  animation =
				  {
					filename = "__factorioplus__/graphics/electric-foundry-glow.png",
					priority = "high",
					width = 380,
					height = 439,
					draw_as_glow = true,
					shift = util.by_pixel(0, -10),
					scale = 0.425,
					blend_mode = "additive"
				  }
			},
		    {
				-- Fans etc. Is drawn on top. Can be a fire glow too.
				animation =
				{
				  filename = "__factorioplus__/graphics/electric-foundry-on.png",
					priority = "extra-high",
					line_length = 4,
					width = 380,
					height = 439,
					axially_symmetrical = false,
					direction_count = 1,
					shift = util.by_pixel(0, -10),
					scale = 0.425,
					frame_count = 4,
					animation_speed = 0.5,
				},
				light = {intensity = 0.5, size = 10, color = {r=1.0, g=1.0, b=0.8}}
		    }
		},
	},
	
    fast_replaceable_group = "furnace",
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-reflection.png",
        priority = "extra-high",
        width = 24,
        height = 24,
        shift = util.by_pixel(5, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
    --------------------------------------------------- HEAT PIPE FURNACE  ------------------------------------------------------------
  {
    type = "furnace",
    name = "heatpipe-furnace",
    icon = "__factorioplus__/graphics/icons/heatpipe-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1.25, result = "heatpipe-furnace"},
    max_health = 850,
    corpse = "electric-furnace-remnants",
    dying_explosion = "electric-furnace-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 80
      }
    },
	
	-- make it 2 x 6
    collision_box = {{-0.9, -2.4}, {0.9, 2.4}},
    selection_box = {{-1.0, -2.5}, {1.0, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),

      module_slots = 5,

    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    crafting_categories = {"smelting"},
	source_inventory_size = 1,
    result_inventory_size = 1,
    crafting_speed = 4.0,
	
    energy_usage = "0.5MW",
    energy_source =
    {
      type = "heat",
      max_temperature = 1000,
      specific_heat = "0.5MJ",
      max_transfer = "1GW",
      min_working_temperature = 750,
      minimum_glow_temperature = 600,
	  emissions_per_minute = { pollution = 4 },
      connections =
      {
        {
          position = {-0.5, 2.0},
          direction = defines.direction.south
        },
		 {
          position = {0.5, 2.0},
          direction = defines.direction.south
        },
      },
      pipe_covers =
        make_4way_animation_from_spritesheet(
        {

            filename = "__base__/graphics/entity/heat-exchanger/heatex-endings.png",
            width = 64,
            height = 64,
            direction_count = 4,
            scale = 0.5
        }),
      heat_pipe_covers =
        make_4way_animation_from_spritesheet(
        apply_heat_pipe_glow{
            filename = "__base__/graphics/entity/heat-exchanger/heatex-endings-heated.png",
            width = 64,
            height = 64,
            direction_count = 4,
            scale = 0.5

        }),
      -- heat_picture =
      -- {
        -- north = apply_heat_pipe_glow
        -- {

            -- filename = "__base__/graphics/entity/heat-exchanger/heatex-N-heated.png",
            -- priority = "extra-high",
            -- width = 44,
            -- height = 96,
            -- shift = util.by_pixel(-0.5, 8.5),
            -- scale = 0.5
        -- },
        -- east = apply_heat_pipe_glow
        -- {

            -- filename = "__base__/graphics/entity/heat-exchanger/heatex-E-heated.png",
            -- priority = "extra-high",
            -- width = 80,
            -- height = 80,
            -- shift = util.by_pixel(-21, -13),
            -- scale = 0.5
        -- },
        -- south = apply_heat_pipe_glow
        -- {
            -- filename = "__base__/graphics/entity/heat-exchanger/heatex-S-heated.png",
            -- priority = "extra-high",
            -- width = 28,
            -- height = 40,
            -- shift = util.by_pixel(-1, -30),
            -- scale = 0.5
        -- },
        -- west = apply_heat_pipe_glow
        -- {
            -- filename = "__base__/graphics/entity/heat-exchanger/heatex-W-heated.png",
            -- priority = "extra-high",
            -- width = 64,
            -- height = 76,
            -- shift = util.by_pixel(23, -13),
            -- scale = 0.5
        -- }
      -- }
    },
	
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.8,
		speed = 0.55
      },
      audible_distance_modifier = 0.6,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
	
	 graphics_set =
    {
    animation =
    {
		north =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/heatpipe-furnace-n.png",
			  priority = "high",
			  width = 327,
			  height = 341,
			  scale = 0.5,
			  frame_count = 1,
			  shift = util.by_pixel(0, -4),
			},
			{
			 filename = "__factorioplus__/graphics/heatpipe-furnace-n-shadow.png",
			  priority = "high",
			  width = 460,
			  height = 480,
			  scale = 0.5,
			  repeat_count = 1,
			  draw_as_shadow = true,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -4),
			},
		  },
		},
		south =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/heatpipe-furnace-s.png",
			  priority = "high",
			  width = 327,
			  height = 341,
			  scale = 0.5,
			  frame_count = 1,
			  shift = util.by_pixel(0, -8),
			},
			{
			 filename = "__factorioplus__/graphics/heatpipe-furnace-s-shadow.png",
			  priority = "high",
			  width = 460,
			  height = 480,
			  scale = 0.5,
			  repeat_count = 1,
			  draw_as_shadow = true,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -4),
			},
		  },
		},
		east =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/heatpipe-furnace-e.png",
			  priority = "high",
			  width = 327,
			  height = 341,
			  scale = 0.5,
			  frame_count = 1,
			  shift = util.by_pixel(0, -8),
			},
			{
			 filename = "__factorioplus__/graphics/heatpipe-furnace-e-shadow.png",
			  priority = "high",
			  width = 460,
			  height = 480,
			  scale = 0.5,
			  repeat_count = 1,
			  draw_as_shadow = true,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -4),
			},
			
		  },
		},
		west =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/heatpipe-furnace-w.png",
			  priority = "high",
			  width = 327,
			  height = 341,
			  scale = 0.5,
			  frame_count = 1,
			  shift = util.by_pixel(0, -8),
			},
			{
			 filename = "__factorioplus__/graphics/heatpipe-furnace-w-shadow.png",
			  priority = "high",
			  width = 460,
			  height = 480,
			  scale = 0.5,
			  repeat_count = 1,
			  draw_as_shadow = true,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -4),
			},
		  },
		},
    },
	working_visualisations =
    {
      {		
	-- Super lightweight images
		north_animation =
		{
		  layers =
		  {
			{
			 filename = "__factorioplus__/graphics/heatpipe-furnace-n-on.png",
			  priority = "high",
			  width = 1308/4,
			  height = 341,
			  scale = 0.5,
			  frame_count = 4,
			  line_length = 4,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -4),
			},
			{
			 filename = "__factorioplus__/graphics/heatpipe-furnace-n-shadow.png",
			  priority = "high",
			  width = 460,
			  height = 480,
			  scale = 0.5,
			  repeat_count = 4,
			  draw_as_shadow = true,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -4),
			},
			 {
                filename = "__factorioplus__/graphics/heatpipe-furnace-n-on-glow.png",
                blend_mode = "additive",
                width = 1308/4,
				height = 341,
                frame_count = 4,
			    line_length = 4,
				animation_speed = 1/6,
                draw_as_glow = true,
                shift = util.by_pixel(0, -4),
                scale = 0.5,
              },
		  },
		},
		south_animation =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/heatpipe-furnace-s-on.png",
			  priority = "high",
			  width = 1308/4,
			  height = 341,
			  scale = 0.5,
			   frame_count = 4,
			  line_length = 4,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -8),
			},
			{
			 filename = "__factorioplus__/graphics/heatpipe-furnace-s-shadow.png",
			  priority = "high",
			  width = 460,
			  height = 480,
			  scale = 0.5,
			  repeat_count = 4,
			  draw_as_shadow = true,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -4),
			},
		  {
                filename = "__factorioplus__/graphics/heatpipe-furnace-s-on-glow.png",
                blend_mode = "additive",
                width = 1308/4,
				height = 341,
                frame_count = 4,
			    line_length = 4,
				animation_speed = 1/6,
                draw_as_glow = true,
                shift = util.by_pixel(0, -8),
                scale = 0.5,
              },
			  },
		},
		east_animation =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/heatpipe-furnace-e-on.png",
			  priority = "high",
			  width = 1308/4,
			  height = 341,
			  scale = 0.5,
			   frame_count = 4,
			  line_length = 4,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -8),
			},
			{
			 filename = "__factorioplus__/graphics/heatpipe-furnace-e-shadow.png",
			  priority = "high",
			  width = 460,
			  height = 480,
			  scale = 0.5,
			  draw_as_shadow = true,
			  repeat_count = 4,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -4),
			},
			{
                filename = "__factorioplus__/graphics/heatpipe-furnace-e-on-glow.png",
                blend_mode = "additive",
                width = 1308/4,
				height = 341,
                frame_count = 4,
			    line_length = 4,
				animation_speed = 1/6,
                draw_as_glow = true,
               shift = util.by_pixel(0, -8),
                scale = 0.5,
              },
		  },
		},
		west_animation =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/heatpipe-furnace-w-on.png",
			  priority = "high",
			  width = 1308/4,
			  height = 341,
			  scale = 0.5,
			   frame_count = 4,
			  line_length = 4,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -8),
			},
			{
			 filename = "__factorioplus__/graphics/heatpipe-furnace-w-shadow.png",
			  priority = "high",
			  width = 460,
			  height = 480,
			  scale = 0.5,
			  draw_as_shadow = true,
			  repeat_count = 4,
			  animation_speed = 1/6,
			  shift = util.by_pixel(0, -4),
			},
			{
                filename = "__factorioplus__/graphics/heatpipe-furnace-w-on-glow.png",
                blend_mode = "additive",
                width = 1308/4,
				height = 341,
                frame_count = 4,
			    line_length = 4,
				animation_speed = 1/6,
                draw_as_glow = true,
                shift = util.by_pixel(0, -8),
                scale = 0.5,
              },
		  },
		},
        light = {intensity = 1, size = 4, color = {r=1.0, g=0.7, b=0.25}}
      }
    },
	},
	
	
    fast_replaceable_group = "furnace",
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-reflection.png",
        priority = "extra-high",
        width = 24,
        height = 24,
        shift = util.by_pixel(5, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
  
 ---------------------------------------------------  MINI ELECTRIC FURNACE ------------------------------------------------------------
  {
    type = "furnace",
    name = "mini-electric-furnace",
    icon = "__factorioplus__/graphics/icons/mini-electric-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "mini-electric-furnace"},
    max_health = 170,
    corpse = "electric-furnace-remnants",
    dying_explosion = "electric-furnace-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 80
      }
    },
    collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selection_box = {{-1.0, -1.0}, {1.0, 1.0}},
    damaged_trigger_effect = hit_effects.entity(),

    module_slots = 2,

    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    crafting_categories = {"smelting"},
    result_inventory_size = 1,
    crafting_speed = 1.5,
    energy_usage = "85kW",
    source_inventory_size = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 0.5 },
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.5,
		speed = 1.5,
      },
      audible_distance_modifier = 0.6,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
	 graphics_set =
    {
    animation =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/mini-electric-furnace.png",
          priority = "high",
          width = 335,
          height = 240,
		  scale = 0.35,
		  
          frame_count = 1,
          shift = util.by_pixel(0, -4),
        },
        {
          filename = "__factorioplus__/graphics/mini-electric-furnace-shadow.png",
          priority = "high",
          width = 224,
          height = 192,
		  scale = 0.5,
          frame_count = 1,
          shift = util.by_pixel(24, -16),
          draw_as_shadow = true,
        }
      }
    },
	working_visualisations =
    {
      {
        draw_as_light = true,
        fadeout = true,
        animation =
        {
          layers =
          {
            {
          filename = "__factorioplus__/graphics/mini-electric-furnace-on.png",
          priority = "high",
          width = 1340/4,
          height = 480/2,
		  scale = 0.35,
		  
		  frame_count = 8,
		  line_length = 4,
		  animation_speed = 0.5,
		 shift = util.by_pixel(0,-4),
		  
            },
            {
              filename = "__factorioplus__/graphics/mini-electric-furnace-glow.png",
              blend_mode = "additive",
              width = 1342/4,
			  height = 480/2,
			  scale = 0.35,
              repeat_count = 8,
			  draw_as_light = true,
              shift = util.by_pixel(0, -4),
            },
          }
        },
      },
    },
	},
	
    fast_replaceable_group = "furnace",
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-reflection.png",
        priority = "extra-high",
        width = 24,
        height = 24,
        shift = util.by_pixel(5, 40),
        variation_count = 1,
        scale = 3
      },
      rotate = false,
      orientation_to_variation = false
    },
	
		icon_draw_specification = {scale = 0.6},
  },
  
  ---------------------------------------------------  BASIC ELECTRIC FURNACE ------------------------------------------------------------
  {
    type = "furnace",
    name = "basic-electric-furnace",
    icon = "__factorioplus__/graphics/icons/basic-electric-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.75, result = "basic-electric-furnace"},
    max_health = 600,
    corpse = "electric-furnace-remnants",
    dying_explosion = "electric-furnace-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 80
      }
    },
    collision_box = {{-1.8, -1.8}, {1.8, 1.8}},
    selection_box = {{-2.0, -2.0}, {2.0, 2.0}},
    damaged_trigger_effect = hit_effects.entity(),

    module_slots = 2,

    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    crafting_categories = {"smelting"},
    result_inventory_size = 1,
    crafting_speed = 1,
    energy_usage = "400kW",
    source_inventory_size = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 3 },
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.5,
		speed = 0.75,
      },
      audible_distance_modifier = 0.6,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
	 graphics_set =
    {
    animation =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/basic-electric-furnace.png",
          priority = "high",
          width = 274,
          height = 312,
		  scale = 0.45,
		  
          frame_count = 1,
          shift = util.by_pixel(0, -4),
        },
        {
          filename = "__factorioplus__/graphics/basic-electric-furnace-shadow.png",
          priority = "high",
          width = 341,
          height = 312,
		  scale = 0.45,
          frame_count = 1,
          shift = util.by_pixel(16, -4),
          draw_as_shadow = true,
        }
      }
    },
	working_visualisations =
    {
      {
        draw_as_light = true,
        fadeout = true,
        animation =
        {
          layers =
          {
			  {
			  filename = "__factorioplus__/graphics/basic-electric-furnace-on.png",
			  priority = "high",
			  width = 1096/4,
			  height = 624/2,
			  scale = 0.45,
			  frame_count = 8,
			  line_length = 4,
			  animation_speed = 2,
			  frame_count = 8,
			  shift = util.by_pixel(0, -4),
			},
            {
              filename = "__factorioplus__/graphics/basic-electric-furnace-glow.png",
              blend_mode = "additive",
              width = 1096/4,
			  height = 624/2,
			  scale = 0.45,
              repeat_count = 8,
			  draw_as_light = true,
              shift = util.by_pixel(0, -4),
            },
          }
        },
      },
    },
	},
	
    
    fast_replaceable_group = "furnace",
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-reflection.png",
        priority = "extra-high",
        width = 24,
        height = 24,
        shift = util.by_pixel(5, 40),
        variation_count = 1,
        scale = 3
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
  
   ---------------------------------------------------  SINGLE STACK CHEST  ------------------------------------------------------------
  {
    type = "container",
    name = "singlestack-chest",
    icon = "__factorioplus__/graphics/icons/singlestack-chest.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1, result = "singlestack-chest"},
    max_health = 400,
    corpse =  "small-remnants",
    dying_explosion = "steel-chest-explosion",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.53 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.53 },
	enable_inventory_bar = false,
	icon_draw_specification = {scale = 0.75},
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
	   {
        type = "physical",
        percent = 70
      },
	   {
        type = "explosion",
        percent = 70
      },
	  {
        type = "acid",
        percent = 90
      },
      {
        type = "impact",
        percent = 70
      }
    },
    collision_box = {{-0.45, -0.45}, {0.45, 0.45}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    inventory_size = 2,
	fast_replaceable_group = "container",
    vehicle_impact_sound = sounds.generic_impact,
    picture =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/strongbox.png",
          priority = "extra-high",
          width = 163,
          height = 174,
		  frame_count = 1,
		  direction_count = 1,
          shift = util.by_pixel(0, -1),
		  scale = 0.225,
        },
        {
          filename = "__factorioplus__/graphics/strongbox-shadow.png",
          priority = "extra-high",
          width = 87,
          height = 53,
		  frame_count = 1,
		  direction_count = 1,
          shift = util.by_pixel(16, 1),
		  scale = 0.45,
		  draw_as_shadow = true,
        }
      }
    },
	hide_resistances = false,
    circuit_connector = circuit_connector_definitions["chest"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },
}) 
  
---------------------------------------------------  STORAGE HUT  ------------------------------------------------------------

local storage_hut_iconspec = { scale = 1.15, scale_for_many = 1.4}
local storage_warehouse_iconspec = { scale = 1.75, scale_for_many = 2.75}

data.extend({ 
	{
    type = "container",
    name = "storage-hut",
    icon = "__factorioplus__/graphics/icons/storage-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1.5, result = "storage-hut"},
    max_health = 650,
    corpse =  "hut-remnants",
    dying_explosion = "steel-chest-explosion",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.53 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.53 },
	icon_draw_specification = storage_hut_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 40
      },
      {
        type = "impact",
        percent = 40
      }
    },
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "container",
    inventory_size = hut_size,
    vehicle_impact_sound = sounds.generic_impact,
    picture =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/storage-1.png",
          priority = "extra-high",
          width = 128,
          height = 192,
		  frame_count = 1,
		  direction_count = 1,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
        {
          filename = "__factorioplus__/graphics/storage-1-shadow.png",
          priority = "extra-high",
          width = 192,
          height = 192,
		  frame_count = 1,
		  direction_count = 1,
          shift = util.by_pixel(16, -14),
		  scale = 0.5,
		  draw_as_shadow = true,
        }
      }
    },
	circuit_connector = circuit_connector_definitions["hut"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
	
  },
   {
    type = "corpse",
    name = "hut-remnants",
    icon = "__factorioplus__/graphics/icons/storage-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    subgroup = "storage-remnants",
    order = "a-c-a",
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    tile_width = 2,
    tile_height = 2,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = true,
    animation =
    {
		layers =
		{
			{
			  filename = "__factorioplus__/graphics/storage-1-wrecked.png",
			  priority = "extra-high",
			  width = 128,
			  height = 192,
			  frame_count = 1,
			  direction_count = 1,
			  shift = util.by_pixel(0, -16),
			  scale = 0.5,
			},
			-- {
			  -- filename = "__factorioplus__/graphics/storage-1-wrecked-shadow.png",
			  -- priority = "extra-high",
			  -- width = 192,
			  -- height = 192,
			  -- frame_count = 1,
			  -- direction_count = 1,
			  -- shift = util.by_pixel(16, -16),
			  -- scale = 0.5,
			  -- draw_as_shadow = true,
			-- },  
		},
	},

  },
  
  ---------------------------------------------------  LOGISTICS STORAGE HUT  ------------------------------------------------------------
  {
    type = "logistic-container",
    name = "logistic-storage-hut",
    icon = "__factorioplus__/graphics/icons/logistics-storage-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 1.5, result = "logistic-storage-hut"},
    max_health = 650,
    max_logistic_slots = 1,
    corpse =  "medium-remnants",
    dying_explosion = "storage-chest-explosion",
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
	icon_draw_specification = storage_hut_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = hut_size,
    logistic_mode = "storage",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
         {
          filename = "__factorioplus__/graphics/storage-logistics-1.png",
          priority = "extra-high",
          width = 128,
          height = 192,
		  frame_count = 8,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
        {
          filename = "__factorioplus__/graphics/storage-logistics-1-shadow.png",
          priority = "extra-high",
          width = 192,
          height = 128,
		  repeat_count = 8,
          shift = util.by_pixel(16, 0),
		  scale = 0.5,
		  draw_as_shadow = true,
        },     
      }
    },
	landing_location_offset = {0.5, -0.5},
    circuit_connector = circuit_connector_definitions["hut"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
	
	--map_generator_bounding_box = {{ -4, -4}, {4, 4}},
	
  },
  
  {
    type = "logistic-container",
    name = "logistic-active-provider-hut",
    icon = "__factorioplus__/graphics/icons/logistics-active-provider-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 1.5, result = "logistic-active-provider-hut"},
    max_health = 650,
    corpse =  "medium-remnants",
    dying_explosion = "storage-chest-explosion",
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
	icon_draw_specification = storage_hut_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = hut_size,
    logistic_mode = "active-provider",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
         {
          filename = "__factorioplus__/graphics/storage-logistics-hut-purple.png",
          priority = "extra-high",
          width = 128,
          height = 192,
		  frame_count = 8,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
        {
          filename = "__factorioplus__/graphics/storage-logistics-1-shadow.png",
          priority = "extra-high",
          width = 192,
          height = 128,
		  repeat_count = 8,
          shift = util.by_pixel(16, 0),
		  scale = 0.5,
		  draw_as_shadow = true,
        },     
      }
    }, 
	landing_location_offset = {0.5, -0.5},
    circuit_connector = circuit_connector_definitions["hut"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
  },
  
  {
    type = "logistic-container",
    name = "logistic-passive-provider-hut",
    icon = "__factorioplus__/graphics/icons/logistics-passive-provider-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 1.5, result = "logistic-passive-provider-hut"},
    max_health = 650,
    corpse =  "medium-remnants",
    dying_explosion = "storage-chest-explosion",
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
	icon_draw_specification = storage_hut_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = hut_size,
    logistic_mode = "passive-provider",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
         {
          filename = "__factorioplus__/graphics/storage-logistics-hut-red.png",
          priority = "extra-high",
          width = 128,
          height = 192,
		  frame_count = 8,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
        {
          filename = "__factorioplus__/graphics/storage-logistics-1-shadow.png",
          priority = "extra-high",
          width = 192,
          height = 128,
		  repeat_count = 8,
          shift = util.by_pixel(16, 0),
		  scale = 0.5,
		  draw_as_shadow = true,
        },     
      }
    },
	landing_location_offset = {0.5, -0.5},
    circuit_connector = circuit_connector_definitions["hut"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
	
  },
  
  {
    type = "logistic-container",
    name = "logistic-buffer-hut",
    icon = "__factorioplus__/graphics/icons/logistics-buffer-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 1.5, result = "logistic-buffer-hut"},
    max_health = 650,
    corpse =  "medium-remnants",
    dying_explosion = "storage-chest-explosion",
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
	icon_draw_specification = storage_hut_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = hut_size,
    logistic_mode = "buffer",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
         {
          filename = "__factorioplus__/graphics/storage-logistics-hut-green.png",
          priority = "extra-high",
          width = 128,
          height = 192,
		  frame_count = 8,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
        {
          filename = "__factorioplus__/graphics/storage-logistics-1-shadow.png",
          priority = "extra-high",
          width = 192,
          height = 128,
		  repeat_count = 8,
          shift = util.by_pixel(16, 0),
		  scale = 0.5,
		  draw_as_shadow = true,
        },     
      }
    },
	landing_location_offset = {0.5, -0.5},
    circuit_connector = circuit_connector_definitions["hut"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
	
  },
  
  {
    type = "logistic-container",
    name = "logistic-requester-hut",
    icon = "__factorioplus__/graphics/icons/logistics-requester-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 1.5, result = "logistic-requester-hut"},
    max_health = 650,
    corpse =  "medium-remnants",
    dying_explosion = "storage-chest-explosion",
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
	icon_draw_specification = storage_hut_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = hut_size,
    logistic_mode = "requester",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
         {
          filename = "__factorioplus__/graphics/storage-logistics-hut-blue.png",
          priority = "extra-high",
          width = 128,
          height = 192,
		  frame_count = 8,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
        {
          filename = "__factorioplus__/graphics/storage-logistics-1-shadow.png",
          priority = "extra-high",
          width = 192,
          height = 128,
		  repeat_count = 8,
          shift = util.by_pixel(16, 0),
		  scale = 0.5,
		  draw_as_shadow = true,
        },     
      }
    },
	landing_location_offset = {0.5, -0.5},
    circuit_connector = circuit_connector_definitions["hut"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
	
  },
})
 
   
---------------------------------------------------  BASIC WAREHOUSE  ------------------------------------------------------------

data.extend({
  {
    type = "container",
    name = "warehouse",
    icon =  "__factorioplus__/graphics/icons/warehouse.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 2, result = "warehouse"},
    max_health = 1250,
    corpse = "warehouse-remnants",
    dying_explosion = "steel-chest-explosion",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.53 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.53 },
	icon_draw_specification = storage_warehouse_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 40
      },
      {
        type = "impact",
        percent = 40
      }
    },
    collision_box = {{-2.25, -2.25}, {2.25, 2.25}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "container",
    inventory_size = warehouse_size,
    vehicle_impact_sound = sounds.generic_impact,
    picture =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/warehouse-1.png",
          priority = "extra-high",
          width = 320,
          height = 384,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
        {
            filename = "__factorioplus__/graphics/warehouse-shadow.png",
            priority = "extra-high",
			width = 384,
			height = 384,
            shift = util.by_pixel(16, -17),
            scale = 0.5,
			draw_as_shadow = true,
        }
      }
    },
    circuit_connector = circuit_connector_definitions["warehouse"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
  },
  
  {
    type = "corpse",
    name = "warehouse-remnants",
    icon = "__base__/graphics/icons/steel-chest.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    subgroup = "storage-remnants",
    order = "a-c-a",
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    tile_width = 5,
    tile_height = 5,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = true,
    animation =
    {
	 layers =
		{
			{
			  filename = "__factorioplus__/graphics/warehouse-1-wrecked.png",
			  priority = "extra-high",
			  width = 320,
			  height = 384,
			  frame_count = 1,
			  direction_count = 1,
			  shift = util.by_pixel(0, -16),
			  scale = 0.5,
			},
		},
    }
  },
  ---------------------------------------------------  LOGISTICS WAREHOUSE  ------------------------------------------------------------
  {
    type = "logistic-container",
    name = "logistic-warehouse",
    icon = "__factorioplus__/graphics/icons/logistics-warehouse-storage.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 2, result = "logistic-warehouse"},
    max_health = 1250,
    max_logistic_slots = 1,
    corpse = "big-remnants",
    dying_explosion = "storage-chest-explosion",
    collision_box = {{-2.25, -2.25}, {2.25, 2.25}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),
	icon_draw_specification = storage_warehouse_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = warehouse_size,
    logistic_mode = "storage",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
         {
          filename = "__factorioplus__/graphics/warehouse-logistics-1.png",
          priority = "extra-high",
          width = 320,
          height = 384,
		  frame_count = 8,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
		{
            filename = "__factorioplus__/graphics/warehouse-shadow.png",
            priority = "extra-high",
			width = 384,
			height = 384,
			repeat_count = 8,
            shift = util.by_pixel(16, -16),
            scale = 0.5,
			draw_as_shadow = true,
        },
      }
    },
	landing_location_offset = {1.5, -0.5},
    circuit_connector = circuit_connector_definitions["warehouse"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },
  
  {
    type = "logistic-container",
    name = "logistic-warehouse-passive-provider",
    icon = "__factorioplus__/graphics/icons/logistics-warehouse-passive-provider.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 2, result = "logistic-warehouse-passive-provider"},
    max_health = 1250,
    corpse = "big-remnants",
    dying_explosion = "storage-chest-explosion",
    collision_box = {{-2.25, -2.25}, {2.25, 2.25}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),
	icon_draw_specification = storage_warehouse_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = warehouse_size,
    logistic_mode = "passive-provider",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
         {
          filename = "__factorioplus__/graphics/storage-logistics-warehouse-red.png",
          priority = "extra-high",
          width = 320,
          height = 384,
		  frame_count = 8,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
		{
            filename = "__factorioplus__/graphics/warehouse-shadow.png",
            priority = "extra-high",
			width = 384,
			height = 384,
			repeat_count = 8,
            shift = util.by_pixel(16, -16),
            scale = 0.5,
			draw_as_shadow = true,
        },
      }
    },
	landing_location_offset = {1.5, -0.5},
    circuit_connector = circuit_connector_definitions["warehouse"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },
  
  {
    type = "logistic-container",
    name = "logistic-warehouse-active-provider",
    icon = "__factorioplus__/graphics/icons/logistics-warehouse-active-provider.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 2, result = "logistic-warehouse-active-provider"},
    max_health = 1250,
    corpse = "big-remnants",
    dying_explosion = "storage-chest-explosion",
    collision_box = {{-2.25, -2.25}, {2.25, 2.25}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),
	icon_draw_specification = storage_warehouse_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = warehouse_size,
    logistic_mode = "active-provider",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
         {
          filename = "__factorioplus__/graphics/storage-logistics-warehouse-purple.png",
          priority = "extra-high",
          width = 320,
          height = 384,
		  frame_count = 8,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
		{
            filename = "__factorioplus__/graphics/warehouse-shadow.png",
            priority = "extra-high",
			width = 384,
			height = 384,
			repeat_count = 8,
            shift = util.by_pixel(16, -16),
            scale = 0.5,
			draw_as_shadow = true,
        },
      }
    },
	landing_location_offset = {1.5, -0.5},
    circuit_connector = circuit_connector_definitions["warehouse"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },
  
   {
    type = "logistic-container",
    name = "logistic-warehouse-buffer",
    icon = "__factorioplus__/graphics/icons/logistics-warehouse-buffer.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 2, result = "logistic-warehouse-buffer"},
    max_health = 1250,
    corpse = "big-remnants",
    dying_explosion = "storage-chest-explosion",
    collision_box = {{-2.25, -2.25}, {2.25, 2.25}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),
	icon_draw_specification = storage_warehouse_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = warehouse_size,
    logistic_mode = "buffer",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
         {
          filename = "__factorioplus__/graphics/storage-logistics-warehouse-green.png",
          priority = "extra-high",
          width = 320,
          height = 384,
		  frame_count = 8,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
		{
            filename = "__factorioplus__/graphics/warehouse-shadow.png",
            priority = "extra-high",
			width = 384,
			height = 384,
			repeat_count = 8,
            shift = util.by_pixel(16, -16),
            scale = 0.5,
			draw_as_shadow = true,
        },
      }
    },
	landing_location_offset = {1.5, -0.5},
    circuit_connector = circuit_connector_definitions["warehouse"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },
  
   {
    type = "logistic-container",
    name = "logistic-warehouse-requester",
    icon = "__factorioplus__/graphics/icons/logistics-warehouse-requester.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 2, result = "logistic-warehouse-requester"},
    max_health = 1250,
    corpse = "big-remnants",
    dying_explosion = "storage-chest-explosion",
    collision_box = {{-2.25, -2.25}, {2.25, 2.25}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),
	icon_draw_specification = storage_warehouse_iconspec,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = warehouse_size,
    logistic_mode = "requester",
    open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.43 },
    close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
    animation_sound = sounds.logistics_chest_open,
    vehicle_impact_sound = sounds.generic_impact,
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
         {
          filename = "__factorioplus__/graphics/storage-logistics-warehouse-blue.png",
          priority = "extra-high",
          width = 320,
          height = 384,
		  frame_count = 8,
          shift = util.by_pixel(0, -16),
		  scale = 0.5,
        },
		{
            filename = "__factorioplus__/graphics/warehouse-shadow.png",
            priority = "extra-high",
			width = 384,
			height = 384,
			repeat_count = 8,
            shift = util.by_pixel(16, -16),
            scale = 0.5,
			draw_as_shadow = true,
        },
      }
    },
	landing_location_offset = {1.5, -0.5},
    circuit_connector = circuit_connector_definitions["warehouse"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },
  
  ---------------------------------------------------  LARGE SOLAR PANEL  ------------------------------------------------------------
  {
    type = "solar-panel",
    name = "solar-array",
    icon = "__factorioplus__/graphics/icons/solar-array.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1.25, result = "solar-array"},
    max_health = 400,
    corpse = "solar-panel-remnants",
    dying_explosion = "solar-panel-explosion",
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    -- damaged_trigger_effect = hit_effects.entity(),
    energy_source =
    {
      type = "electric",
      usage_priority = "solar"
    },
    picture =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/solar-array.png",
          priority = "high",
          width = 367,
          height = 352,
          shift = util.by_pixel(-2, 0),
		  scale = 0.5,
        },
		{
          filename = "__factorioplus__/graphics/solar-array-shadow.png",
          priority = "high",
          width = 367,
          height = 352,
          shift = util.by_pixel(-2, 0),
		  draw_as_shadow = true,
		  scale = 0.5,
        },
      }
    },
    --vehicle_impact_sound = sounds.generic_impact,
    production = "250kW"
  },
  ---------------------------------------------------  SOLAR ARRAY 2  ------------------------------------------------------------
  {
    type = "solar-panel",
    name = "solar-array-2",
    icon = "__factorioplus__/graphics/icons/solar-array-2.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1.75, result = "solar-array-2"},
    max_health = 1200,
    corpse = "solar-panel-remnants",
    dying_explosion = "solar-panel-explosion",
    collision_box = {{-5.2, -5.2}, {5.2, 5.2}},
    selection_box = {{-5.5, -5.5}, {5.5, 5.5}},
    -- damaged_trigger_effect = hit_effects.entity(),
    energy_source =
    {
      type = "electric",
      usage_priority = "solar"
    },
    picture =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/large-solar-array.png",
          priority = "high",
          width = 858,
          height = 799,
		  scale = 0.475,
          shift = util.by_pixel(0, -4),
        },
		        {
          filename = "__factorioplus__/graphics/large-solar-array-shadow.png",
          priority = "high",
          width = 858,
          height = 799,
		  scale = 0.475,
		  
		  draw_as_shadow = true,
          shift = util.by_pixel(0, -4),
        },
      },
    },
	overlay =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/solar-gleam.png",
          priority = "high",
          width = 128,
          height = 128,
		  --draw_as_shadow = true,
		  --blend_mode = "additive",
		  --flags = {"light"},
          shift = util.by_pixel(-3, -44),
		  scale = 1.0,
        },
      },
    },
    --vehicle_impact_sound = sounds.generic_impact,
    production = "1750kW"
  },
    ---------------------------------------------------  FLOOR LAMP  ------------------------------------------------------------
   {
    type = "lamp",
    name = "floor-lamp",
    icon = "__factorioplus__/graphics/icons/floor-lamp.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "not-flammable"},
    minable = {mining_time = 0.55, result = "floor-lamp"},
	collision_mask = {layers={object=true, water_tile=true}},
	remove_decoratives = "true",
    max_health = 150,
	resistances =
    {
      {
        type = "fire",
        percent = 50
      },
	  {
        type = "explosion",
        percent = 80
      },
    },
    corpse = "lamp-remnants",
    dying_explosion = "lamp-explosion",
    collision_box = {{-0.44, -0.44}, {0.44, 0.44}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    energy_source =
    {
      type = "electric",
      usage_priority = "lamp"
    },
    energy_usage_per_tick = "5kW",
    darkness_for_all_lamps_on = 0.5,
    darkness_for_all_lamps_off = 0.3,
    light = {intensity = 0.85, size = 25, color = {r=1.0, g=1.0, b=1.0}},
    light_when_colored = {intensity = 1, size = 6, color = {r=1.0, g=1.0, b=1.0}},
    glow_size = 4,
    glow_color_intensity = 0.185,
	integration_patch_render_layer = "floor",
	integration_patch =
	{
		sheet =
		{
		  filename = "__factorioplus__/graphics/floor-lamp-off.png",
		  priority = "high",
		  width = 64,
		  height = 49,
		  frames = 1,
		  axially_symmetrical = false,
		  shift = util.by_pixel(0,0),
		  scale = 0.6,
		},
	},
	
    picture_off =
    {
          filename = "__factorioplus__/graphics/floor-lamp-off.png",
          priority = "high",
		  width = 1,
          height = 1,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 1,
          shift = util.by_pixel(0,0),
		  scale = 0.1,
	},
	
    picture_on =
    {
          filename = "__factorioplus__/graphics/floor-lamp-on.png",
          priority = "high",
		  width = 64,
          height = 49,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 1,
          shift = util.by_pixel(0,0),
		  scale = 0.5,
		  draw_as_glow = true,
	},
    signal_to_color_mapping =
    {
      {type="virtual", name="signal-red", color={r=1,g=0,b=0}},
      {type="virtual", name="signal-green", color={r=0,g=1,b=0}},
      {type="virtual", name="signal-blue", color={r=0,g=0,b=1}},
      {type="virtual", name="signal-yellow", color={r=1,g=1,b=0}},
      {type="virtual", name="signal-pink", color={r=1,g=0,b=1}},
      {type="virtual", name="signal-cyan", color={r=0,g=1,b=1}}
    },

    circuit_connector = circuit_connector_definitions["lamp"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },
  
  ---------------------------------------------------  FLOODLIGHT  ------------------------------------------------------------
   {
    type = "lamp",
    name = "floodlight-lamp",
    icon = "__factorioplus__/graphics/icons/floodlight.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.75, result = "floodlight-lamp"},
    max_health = 350,
    corpse = "lamp-remnants",
    dying_explosion = "lamp-explosion",
    collision_box = {{-0.55, -0.55}, {0.55, 0.55}},
    selection_box = {{-0.9, -0.9}, {0.9, 0.9}},
    damaged_trigger_effect = hit_effects.entity(),
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    energy_source =
    {
      type = "electric",
      usage_priority = "lamp"
    },
    energy_usage_per_tick = "20kW",
    darkness_for_all_lamps_on = 0.5,
    darkness_for_all_lamps_off = 0.3,
    light = {intensity = 0.9, size = 120, color = {r=1.0, g=1.0, b=1.0}},
    light_when_colored = {intensity = 1, size = 6, color = {r=1.0, g=1.0, b=1.0}},
    glow_size = 2,
    glow_color_intensity = 0.285,
    picture_off =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/floodlight-off.png",
          priority = "high",
          width = 192,
          height = 304,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 1,
          shift = util.by_pixel(0,-54),
		  scale = 0.5,
        },
        {
          filename = "__factorioplus__/graphics/floodlight-shadow.png",
          priority = "high",
          width = 345,
          height = 94,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 1,
          shift = util.by_pixel(36,-1),
		  scale = 0.5,
          draw_as_shadow = true,
        }
      }
    },
    picture_on =
    {
          filename = "__factorioplus__/graphics/floodlight-on.png",
          priority = "high",
		  width = 192,
          height = 304,
          frame_count = 1,
          axially_symmetrical = false,
          direction_count = 1,
          shift = util.by_pixel(0,-54),
		  scale = 0.5,
	},
    signal_to_color_mapping =
    {
      {type="virtual", name="signal-red", color={r=1,g=0,b=0}},
      {type="virtual", name="signal-green", color={r=0,g=1,b=0}},
      {type="virtual", name="signal-blue", color={r=0,g=0,b=1}},
      {type="virtual", name="signal-yellow", color={r=1,g=1,b=0}},
      {type="virtual", name="signal-pink", color={r=1,g=0,b=1}},
      {type="virtual", name="signal-cyan", color={r=0,g=1,b=1}}
    },

    circuit_connector = circuit_connector_definitions["lamp"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },
    ---------------------------------------------------  BIG ACCUMULATOR ------------------------------------------------------------
 {
    type = "accumulator",
    name = "accumulator-battery",
    icon = "__factorioplus__/graphics/icons/accumulator-battery.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.5, result = "accumulator-battery"},
    max_health = 350,
    corpse = "accumulator-remnants",
    dying_explosion = "accumulator-explosion",
    collision_box = {{-1.95, -1.95}, {1.95, 1.95}},
    selection_box = {{-2, -2}, {2, 2}},
    damaged_trigger_effect = hit_effects.entity(),
	
    energy_source =
    {
      type = "electric",
      buffer_capacity = "60MJ",
      usage_priority = "tertiary",
      input_flow_limit = "1600kW",
      output_flow_limit = "1600kW"
    },
	
	 chargable_graphics =
    {
		picture =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/accumulator-battery-1.png",
			  priority = "high",
			  width = 256,
			  height = 317,
			  shift = util.by_pixel(0, -16),
			  scale = 0.5,
			},
			 {
			  filename = "__factorioplus__/graphics/accumulator-battery-1-shadow.png",
			  priority = "high",
			  width = 390,
			  height = 327,
			  shift = util.by_pixel(24, -11),
			  scale = 0.5,
			  draw_as_shadow = true,
			},
		  }
		},
		
		charge_cooldown = 30,
		charge_animation_is_looped = true,
		charge_light = {intensity = 0.3, size = 7, color = {r = 1.0, g = 1.0, b = 1.0}},
		
		charge_animation = 
		{
			layers =
			{  
			  {
				  filename = "__factorioplus__/graphics/accumulator-battery-1.png",
				  priority = "high",
				  width = 256,
				  height = 317,
				  shift = util.by_pixel(0, -16),
				  repeat_count = 12,
				  scale =  0.5,
				  animation_speed = 0.05,
				},
				{
				  filename = "__factorioplus__/graphics/accumulator-battery-1-shadow.png",
				  priority = "high",
				  width = 390,
				  height = 327,
				  shift = util.by_pixel(24, -11),
				  repeat_count = 12,
				  scale = 0.5,
				  draw_as_shadow = true,
				},
			  {
				filename = "__factorioplus__/graphics/accumulator-battery-1-charging.png",
				priority = "high",
				width = 32,
				height = 32,
				scale =  1.1,
				
				line_length = 6,
				frame_count = 12,
				--blend_mode = "additive",
				shift = util.by_pixel(0, 50),
				animation_speed = 0.05,
				draw_as_glow = true,
			  }
			}
	  },
		
		discharge_cooldown = 60,
		discharge_animation_is_looped = true,
		discharge_light = {intensity = 0.7, size = 7, color = {r = 1.0, g = 1.0, b = 1.0}},
		
		discharge_animation = 
		{
			layers =
			{
			  {
				  filename = "__factorioplus__/graphics/accumulator-battery-1.png",
				  priority = "high",
				  width = 256,
				  height = 317,
				  shift = util.by_pixel(0, -16),
				  repeat_count = 12,
				  scale = 0.5,
				  animation_speed = 0.05,
				},
				{
				  filename = "__factorioplus__/graphics/accumulator-battery-1-shadow.png",
				  priority = "high",
				  width = 390,
				  height = 327,
				  shift = util.by_pixel(24, -11),
				  repeat_count = 12,
				  scale = 0.5,
				  draw_as_shadow = true,
				},
			  {
				filename = "__factorioplus__/graphics/accumulator-battery-1-charging.png",
				priority = "high",
				width = 32,
				height = 32,
				scale =  1.1,
				
				line_length = 6,
				frame_count = 12,
				--blend_mode = "additive",
				shift = util.by_pixel(0, 50),
				run_mode = "backward",
				animation_speed =0.05,
				draw_as_glow = true,
			  },
		  },
		water_reflection = accumulator_reflection(),

		
		  -- {
		   -- filename = "__factorioplus__/graphics/accumulator-battery-1-electricity.png",
			-- priority = "high",
			-- repeat_count = 12,
			-- width = 257,
			-- height = 276,
			-- scale = 0.5,
			-- draw_as_glow = true,
			-- shift = util.by_pixel(-2, 0),
			-- },
		}
  },
   
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/accumulator-working.ogg",
        volume = 0.4
      },
      idle_sound =
      {
        filename = "__base__/sound/accumulator-idle.ogg",
        volume = 0.35
      },
      --persistent = true,
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },

    circuit_connector = circuit_connector_definitions["accumulator-battery"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,

    default_output_signal = {type = "virtual", name = "signal-A"}
  },
  
    ---------------------------------------------------  ADV BIG ACCUMULATOR ------------------------------------------------------------
 {
    type = "accumulator",
    name = "adv-accumulator-battery",
    icon = "__factorioplus__/graphics/icons/adv-accumulator-battery.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.75, result = "adv-accumulator-battery"},
    max_health = 600,
    corpse = "accumulator-remnants",
    dying_explosion = "accumulator-explosion",
    collision_box = {{-2.95, -2.95}, {2.95, 2.95}},
    selection_box = {{-3, -3}, {3, 3}},
    damaged_trigger_effect = hit_effects.entity(),
    energy_source =
    {
      type = "electric",
      buffer_capacity = "180MJ",
      usage_priority = "tertiary",
      input_flow_limit = "4800kW",
      output_flow_limit = "4800kW"
    },
	
    water_reflection = accumulator_reflection(),
   
	 chargable_graphics =
    {
      picture =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/accumulator-battery-advanced.png",
          priority = "high",
          width = 383,
          height = 406,
          shift = util.by_pixel(0, -8),
		  scale = 0.5,
        },
		{
          filename = "__factorioplus__/graphics/accumulator-battery-advanced-shadow.png",
          priority = "high",
          width = 501,
          height = 408,
          shift = util.by_pixel(24, -4),
		  scale = 0.5,
		  draw_as_shadow = true,
        },
      }
	},
	   charge_light = {intensity = 0.3, size = 10, color = {r = 1.0, g = 1.0, b = 1.0}},
      charge_animation = accumulator_charge(),
      charge_cooldown = 30,
	   charge_animation = 
	{
    layers =
    {  
	  {
           filename = "__factorioplus__/graphics/accumulator-battery-advanced.png",
          priority = "high",
          width = 383,
          height = 406,
		  repeat_count = 8,
          shift = util.by_pixel(0, -8),
		  scale = 0.5,
		  animation_speed = 0.05,
        },
      {
        filename = "__factorioplus__/graphics/accumulator-battery-2-charging.png",
        priority = "high",
       width = 256/8,
        height = 54,
		scale =  0.5,
		
        line_length = 8,
        frame_count = 8,
        --blend_mode = "additive",
        shift = util.by_pixel(-61, 52),
		animation_speed = 0.06,
		draw_as_glow = true,
      }
    }
  },
	discharge_light = {intensity = 0.9, size = 10, color = {r = 1.0, g = 1.0, b = 1.0}},
	discharge_cooldown = 60,		
      discharge_animation = 
		{
			layers =
			{
			  {
				  filename = "__factorioplus__/graphics/accumulator-battery-advanced.png",
				  priority = "high",
				  width = 383,
				  height = 406,
				  shift = util.by_pixel(0, -8),
				  scale = 0.5,
				  animation_speed = 0.05,
				  repeat_count = 8,
				},
			  {
				filename = "__factorioplus__/graphics/accumulator-battery-2-charging.png",
				priority = "high",
				width = 256/8,
				height = 54,
				scale =  0.5,
				
				line_length = 8,
				frame_count = 8,
				--blend_mode = "additive",
				shift = util.by_pixel(-61, 52),
				animation_speed = 0.06,
				draw_as_glow = true,
				run_mode = "backward",
			  }
			}
	  },
    },
	
  
   
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/accumulator-working.ogg",
        volume = 0.4
      },
      idle_sound =
      {
        filename = "__base__/sound/accumulator-idle.ogg",
        volume = 0.35
      },
      --persistent = true,
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },

    circuit_connector = circuit_connector_definitions["adv-accumulator-battery"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,

    default_output_signal = {type = "virtual", name = "signal-A"}
  },
  
  ---------------------------------------------------  WOODEN POLE 2  ------------------------------------------------------------
   {
    type = "electric-pole",
    name = "medium-wooden-electric-pole",
    icon = "__factorioplus__/graphics/icons/medium-wooden-electric-pole.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.4, result = "medium-wooden-electric-pole"},
    max_health = 180,
    corpse = "small-electric-pole-remnants",
    dying_explosion = "small-electric-pole-explosion",
    collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{-0.9, -0.9}, {0.9, 0.9}},
    damaged_trigger_effect = hit_effects.entity({{-0.2, -2.2}, {0.2, 0.2}}),
    drawing_box = {{-0.75, -2.6}, {0.75, 0.75}},
    maximum_wire_distance = 12,
    supply_area_distance = 5,
	impact_category = "wood",
    --vehicle_impact_sound = sounds.car_wood_impact(0.5),
    open_sound = sounds.electric_network_open,
    close_sound = sounds.electric_network_close,
    track_coverage_during_build_by_moving = true,
    fast_replaceable_group = "electric-pole",
	next_upgrade = "substation",
    pictures =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/medium-wooden-electric-pole.png",
          priority = "extra-high",
          width = 128,
          height = 320,
          direction_count = 4,
          shift = util.by_pixel(2, -52),
		  scale = 0.5,
        },
        {
          filename = "__factorioplus__/graphics/medium-wooden-electric-pole-shadow.png",
          priority = "extra-high",
          width = 1024/4,
          height = 73,
          direction_count = 4,
          shift = util.by_pixel(48, 2),
          draw_as_shadow = true,
		  scale = 0.6,
        }
      }
    },
    connection_points =
    {
      {
        shadow =
        {
          copper = util.by_pixel(98.5, 2.5),
          red = util.by_pixel(85.5, 4.0),
          green = util.by_pixel(111.0, 4.5)
        },
        wire =
        {
          copper = util.by_pixel(11, -110),
          red = util.by_pixel(0, -110),
          green = util.by_pixel(22, -110),
        }
      },
	  {
        shadow =
        {
          copper = util.by_pixel(99.5, 4.0),
          red = util.by_pixel(110.0, 9.0),
          green = util.by_pixel(92.5, -4.0)
        },
        wire =
        {
          copper = util.by_pixel(8, -99.0),
          red = util.by_pixel(-6.0, -89.5 -14),
          green = util.by_pixel(16.0, -76.0 -14)
        }
      },
      {
        shadow =
        {
          copper = util.by_pixel(100.5, 5.5),
          red = util.by_pixel(102.5, 14.5),
          green = util.by_pixel(103.5, -3.5)
        },
        wire =
        {
          copper = util.by_pixel(4.0, -99),
          red = util.by_pixel(4.0, -109.5),
          green = util.by_pixel(4.0, -89.5)
        }
      },
      {
        shadow =
        {
          copper = util.by_pixel(98.5, -1.5),
          red = util.by_pixel(88.0, 3.5),
          green = util.by_pixel(106.0, -9.0)
        },
        wire =
        {
          copper = util.by_pixel(0, -100),
          red = util.by_pixel(8.0, -93.5 -10),
          green = util.by_pixel(-8, -81.5-10)
        }
      }
    },
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      width = 12,
      height = 12,
      priority = "extra-high-no-scale"
    },
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/small-electric-pole/small-electric-pole-reflection.png",
        priority = "extra-high",
        width = 12,
        height = 28,
        shift = util.by_pixel(5, 40),
        variation_count = 4,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = true
    }
  },
  ---------------------------------------------------  SUBSTATION 2  ------------------------------------------------------------
{
    type = "electric-pole",
    name = "electrical-distributor",
    icon = "__factorioplus__/graphics/icons/electric-distributor.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1.4, result = "electrical-distributor"},
    max_health = 600,
    corpse = "substation-remnants",
    dying_explosion = "substation-explosion",
    track_coverage_during_build_by_moving = true,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-1.9, -1.9}, {1.9, 1.9}},
    selection_box = {{-2, -2}, {2, 2}},
    damaged_trigger_effect = hit_effects.entity({{-0.5, -2.5}, {0.5, 0.5}}),
    drawing_box = {{-1, -3}, {1, 1}},
    maximum_wire_distance = 16,
    supply_area_distance = 22,
    pictures =
    {
      layers =
      {

        {
          filename = "__factorioplus__/graphics/electric-distributor.png",
          priority = "high",
          width = 381,
          height = 384,
          direction_count = 1,
          shift = util.by_pixel(0, -8),
		  scale = 0.4,
         },
        {
          filename = "__factorioplus__/graphics/electric-distributor-shadow.png",
          priority = "high",
          width = 384,
          height = 271,
          direction_count = 1,
          shift = util.by_pixel(18, 10),
          draw_as_shadow = true,
		  scale = 0.44,
        }
      }
    },

    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.electric_network_open,
    close_sound = sounds.electric_network_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/substation.ogg",
        volume = 0.4,
      },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.32,
      fade_in_ticks = 30,
      fade_out_ticks = 40,
      use_doppler_shift = false
    },
    connection_points =
    {
      {
        shadow =
        {
          copper = util.by_pixel(236, 1),
          green = util.by_pixel(124, 8),
          red = util.by_pixel(151, 9)
        },
        wire =
        {
          copper = util.by_pixel(-32, -76),
          green = util.by_pixel(-32-26, -70+2),
          red = util.by_pixel(-32+26, -70+2)
        }
      },
    },
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      width = 10,
      height = 10,
      priority = "extra-high-no-scale"
    },
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/substation/substation-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 28,
        shift = util.by_pixel(0, 55),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  }, 
 
---------------------------------------------------  BURNER LONG INSERTER  ------------------------------------------------------------
 
  {
    type = "inserter",
    name = "long-handed-burner-inserter",
    icon = "__factorioplus__/graphics/icons/long-handed-burner-inserter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "long-handed-burner-inserter"},
    max_health = 120,
    corpse = "inserter-remnants",
    dying_explosion = "inserter-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
    selection_box = {{-0.4, -0.35}, {0.4, 0.45}},
    damaged_trigger_effect = hit_effects.entity(),
    pickup_position = {0, -2},
    insert_position = {0, 2.2},    
    energy_per_movement = "50kJ",
    energy_per_rotation = "50kJ",
    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
	  initial_fuel = "wood",
      initial_fuel_percent = 0.25,
      effectivity = 1,
      fuel_inventory_size = 1,
      light_flicker = {color = {0,0,0}},
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 9
        }
      }
    },
    extension_speed = 0.035,
	rotation_speed = 0.01,
    fast_replaceable_group = "long-handed-inserter",
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = sounds.inserter_long_handed,
    hand_base_picture =
    {
      filename = "__factorioplus__/graphics/entity/long-handed-burner-inserter/long-handed-inserter-hand-base.png",
      priority = "extra-high",
      width = 32,
	height = 136,
	scale = 0.25
    },
    hand_closed_picture =
    {
      filename = "__factorioplus__/graphics/entity/long-handed-burner-inserter/long-handed-inserter-hand-closed.png",
      priority = "extra-high",
      width = 72,
        height = 164,
        scale = 0.25
    },
    hand_open_picture =
    {
      filename = "__factorioplus__/graphics/entity/long-handed-burner-inserter/long-handed-inserter-hand-open.png",
      priority = "extra-high",
      width = 72,
        height = 164,
        scale = 0.25
    },
    hand_base_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-base-shadow.png",
      priority = "extra-high",
      width = 32,
        height = 132,
        scale = 0.25
    },
    hand_closed_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-closed-shadow.png",
      priority = "extra-high",
      width = 72,
        height = 164,
        scale = 0.25
    },
    hand_open_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-open-shadow.png",
      priority = "extra-high",
      width = 72,
        height = 164,
        scale = 0.25
    },
    platform_picture =
    {
      sheet =
      {
        filename = "__factorioplus__/graphics/entity/long-handed-burner-inserter/long-handed-inserter-platform.png",
        priority = "extra-high",
        width = 105,
          height = 79,
          shift = util.by_pixel(1.5, 7.5-1),
          scale = 0.5
      }
    },
    circuit_connectors = circuit_connector_definitions["inserter"],
    circuit_wire_max_distance = inserter_circuit_wire_max_distance,
    default_stack_control_input_signal = inserter_default_stack_control_input_signal
  },
  
  {
    type = "corpse",
    name = "long-burner-inserter-remnants",
    icon = "__factorioplus__/graphics/icons/long-handed-burner-inserter.png",
    hidden_in_factoriopedia = true,
    flags = {"placeable-neutral", "not-on-map"},
    subgroup = "inserter-remnants",
    order = "a-a-a",
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    tile_width = 1,
    tile_height = 1,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    animation = make_rotated_animation_variations_from_sheet (4,
    {
      filename = "__factorioplus__/graphics/entity/long-handed-burner-inserter/remnants/long-handed-inserter-remnants.png",
      line_length = 1,
      width = 134,
      height = 94,
      direction_count = 1,
      shift = util.by_pixel(3.5, -2),
      scale = 0.5
    })
  },
 
---------------------------------------------------  VERY LONG INSERTER  ------------------------------------------------------------
 
  {
    type = "inserter",
    name = "very-long-handed-inserter",
    icon = "__factorioplus__/graphics/icons/very-long-handed-inserter.png",
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "very-long-handed-inserter"},
    max_health = 180,
    corpse = "long-handed-inserter-remnants",
    dying_explosion = "long-handed-inserter-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
    selection_box = {{-0.4, -0.35}, {0.4, 0.45}},
    damaged_trigger_effect = hit_effects.entity(),
    pickup_position = {0, -3},
    insert_position = {0, 3.2},
    energy_per_movement = "8kJ",
    energy_per_rotation = "8kJ",
    extension_speed = 0.05,
    rotation_speed = 0.01,
    filter_count = 5,
    icon_draw_specification = {scale = 0.5},
    hand_size = 2.25,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      drain = "0.65kW"
    },
    fast_replaceable_group = "very-long-handed-inserter",
    impact_category = "metal",
    open_sound = sounds.inserter_open,
    close_sound = sounds.inserter_close,
    working_sound = sounds.inserter_long_handed,
    hand_base_picture =
    {
      filename = "__factorioplus__/graphics/entity/very-long-handed-inserter/very-long-handed-inserter-hand-base.png",
      priority = "extra-high",
      width = 32,
      height = 136,
      scale = 0.25
    },
    hand_closed_picture =
    {
      filename = "__factorioplus__/graphics/entity/very-long-handed-inserter/very-long-handed-inserter-hand-closed.png",
      priority = "extra-high",
      width = 72,
      height = 164,
      scale = 0.25
    },
    hand_open_picture =
    {
      filename = "__factorioplus__/graphics/entity/very-long-handed-inserter/very-long-handed-inserter-hand-open.png",
      priority = "extra-high",
      width = 72,
      height = 164,
      scale = 0.25
    },
    hand_base_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-base-shadow.png",
      priority = "extra-high",
      width = 32,
      height = 132,
      scale = 0.25
    },
    hand_closed_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-closed-shadow.png",
      priority = "extra-high",
      width = 72,
      height = 164,
      scale = 0.25
    },
    hand_open_shadow =
    {
      filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-open-shadow.png",
      priority = "extra-high",
      width = 72,
      height = 164,
      scale = 0.25
    },
    platform_picture =
    {
      sheet =
      {
        filename = "__factorioplus__/graphics/entity/very-long-handed-inserter/very-long-handed-inserter-platform.png",
        priority = "extra-high",
        width = 105,
        height = 79,
        shift = util.by_pixel(1.5, 7.5-1),
        scale = 0.5
      }
    },
    circuit_connector = circuit_connector_definitions["inserter"],
    circuit_wire_max_distance = inserter_circuit_wire_max_distance,
    default_stack_control_input_signal = inserter_default_stack_control_input_signal
  },
 ---------------------------------------------------  BASIC BELT  ------------------------------------------------------------
  {
    type = "transport-belt",
    name = "basic-transport-belt",
    icon = "__factorioplus__/graphics/icons/basic-transport-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "basic-transport-belt"},
    max_health = 100,
    corpse = "transport-belt-remnants",
    dying_explosion = "transport-belt-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/transport-belt.ogg",
        volume = 0.1,
		speed = 0.7,
      },
      persistent = true
    },
    animation_speed_coefficient = 32,
    belt_animation_set = slow_belt_animation_set,
    fast_replaceable_group = "transport-belt",
	next_upgrade = "transport-belt",
	related_underground_belt = "basic-underground-belt",
    speed = speed_slowbelts,
    connector_frame_sprites = transport_belt_connector_frame_sprites,
    circuit_connectors = circuit_connector_definitions["belt"],
    circuit_wire_max_distance = transport_belt_circuit_wire_max_distance
  },
  
    ------------------------------------------------------------------------------------------
  
  {
    type = "underground-belt",
    name = "basic-underground-belt",
    icon = "__factorioplus__/graphics/icons/basic-underground-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "basic-underground-belt"},
    max_health = 200,
    corpse = "fast-underground-belt-remnants",
    dying_explosion = "fast-underground-belt-explosion",
    max_distance = 3,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/underground-belt.ogg",
        volume = 0.3,
		speed =  0.7,
      },
      max_sounds_per_type = 2,
      audible_distance_modifier = 0.5,
      persistent = true,
      use_doppler_shift = false
    },
    underground_sprite =
    {
      filename = "__core__/graphics/arrows/underground-lines.png",
      priority = "high",
      width = 64,
      height = 64,
      x = 64,
      scale = 0.5
    },
    underground_remove_belts_sprite =
    {
      filename = "__core__/graphics/arrows/underground-lines-remove.png",
      priority = "high",
      width = 64,
      height = 64,
      x = 64,
      scale = 0.5
    },
    resistances =
    {
      {
        type = "fire",
        percent = 60
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    animation_speed_coefficient = 32,
    belt_animation_set = slow_belt_animation_set,
    fast_replaceable_group = "transport-belt",
	next_upgrade = "underground-belt",
    speed = speed_slowbelts,
    structure =
    {
      direction_in =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/basic-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192,
		  scale = 0.5,
        }
      },
      direction_out =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/basic-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
		  scale = 0.5,
        }
      },
      direction_in_side_loading =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/basic-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192*3,
		  scale = 0.5,
        }
      },
      direction_out_side_loading =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/basic-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192*2,
		  scale = 0.5,
        }
      },
      back_patch =
      {
        sheet =
        {
          filename = "__base__/graphics/entity/express-underground-belt/express-underground-belt-structure-front-patch.png",
          priority = "extra-high",
          width = 192,
          height = 192,
		  scale = 0.5,
        }
      },
      front_patch =
      {
        sheet =
        {
          filename = "__base__/graphics/entity/express-underground-belt/express-underground-belt-structure-front-patch.png",
          priority = "extra-high",
          width = 192,
          height = 192,
		  scale = 0.5,
        }
      }
    }
  },
  
   ------------------------------------------------------------------------------------------------------
   
  {
    type = "splitter",
    name = "basic-splitter",
    icon = "__factorioplus__/graphics/icons/basic-splitter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "basic-splitter"},
    max_health = 200,
    corpse = "fast-splitter-remnants",
    dying_explosion = "fast-splitter-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 60
      }
    },
	icon_draw_specification = { scale = 0.5},
    collision_box = {{-0.9, -0.4}, {0.9, 0.4}},
    selection_box = {{-0.9, -0.5}, {0.9, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    animation_speed_coefficient = 32,
    structure_animation_speed_coefficient = 1.2,
    structure_animation_movement_cooldown = 10,
    belt_animation_set = slow_belt_animation_set,
    fast_replaceable_group = "transport-belt",
	next_upgrade = "splitter",
    speed = speed_slowbelts,
    working_sound = sounds.fast_splitter,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    structure =
    {
      north =
      {
        filename = "__factorioplus__/graphics/belts/basic-splitter-north.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 1280/8,
        height = 280/4,
        shift = util.by_pixel(7, 0),
		scale = 0.5,
      },
      east =
      {
        filename = "__factorioplus__/graphics/belts/basic-splitter-east.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 720/8,
        height = 336/4,
        shift =  util.by_pixel(4, 13),
		scale = 0.5,
      },
      south =
      {
        filename = "__factorioplus__/graphics/belts/basic-splitter-south.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 1312/8,
        height = 256/4,
        shift = util.by_pixel(4, 0),
		scale = 0.5,
      },
      west =
      {
        filename = "__factorioplus__/graphics/belts/basic-splitter-west.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 752/8,
        height = 344/4,
        shift =  util.by_pixel(6, 12),
		scale = 0.5,
      }
    },
    structure_patch =
    {
      north = util.empty_sprite(),
      east =
      {
        filename = "__factorioplus__/graphics/belts/basic-splitter-east-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 720/8,
        height = 416/4,
        shift =  util.by_pixel(4, -20),
		scale = 0.5,
      },
      south = util.empty_sprite(),
      west =
      {
        filename = "__factorioplus__/graphics/belts/basic-splitter-west-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 752/8,
        height = 384/4,
        shift = util.by_pixel(6, -18),
		scale = 0.5,
      }
    }
  },
  
  ---------------------------------------------------  TURBO BELT  ------------------------------------------------------------
 {
    type = "transport-belt",
    name = "turbo-transport-belt",
    icon = "__factorioplus__/graphics/icons/turbo-transport-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "turbo-transport-belt"},
    max_health = 200,
    corpse = "transport-belt-remnants",
    dying_explosion = "transport-belt-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
	  { 
	  type = "explosion", 
	  percent = 90 
	  },
    },
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/express-transport-belt.ogg",
        volume = 0.3,
		speed = 1.25,
      },
      persistent = true
    },
    animation_speed_coefficient = 32,
    belt_animation_set = turbo_belt_animation_set,
    fast_replaceable_group = "transport-belt",
	next_upgrade = "supersonic-transport-belt",
	related_underground_belt = "turbo-underground-belt",
    speed = speed_turbobelts,
    connector_frame_sprites = transport_belt_connector_frame_sprites,
    circuit_connectors = circuit_connector_definitions["belt"],
    circuit_wire_max_distance = transport_belt_circuit_wire_max_distance
  },
  
   ------------------------------------------------------------------------------------------------------
  
  {
    type = "underground-belt",
    name = "turbo-underground-belt",
    icon = "__factorioplus__/graphics/icons/turbo-underground-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "turbo-underground-belt"},
    max_health = 200,
    corpse = "fast-underground-belt-remnants",
    dying_explosion = "fast-underground-belt-explosion",
    max_distance = 11,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/express-underground-belt.ogg",
        volume = 0.3,
		speed = 1.25,
      },
      max_sounds_per_type = 2,
      audible_distance_modifier = 0.5,
      persistent = true,
      use_doppler_shift = false
    },
    underground_sprite =
    {
      filename = "__core__/graphics/arrows/underground-lines.png",
      priority = "high",
      width = 64,
      height = 64,
      x = 64,
      scale = 0.5
    },
    underground_remove_belts_sprite =
    {
      filename = "__core__/graphics/arrows/underground-lines-remove.png",
      priority = "high",
      width = 64,
      height = 64,
      x = 64,
      scale = 0.5
    },
    resistances =
    {
      {
        type = "fire",
        percent = 60
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    animation_speed_coefficient = 32,
    belt_animation_set = turbo_belt_animation_set,
    fast_replaceable_group = "transport-belt",
	next_upgrade = "supersonic-underground-belt",
    speed = speed_turbobelts,
    structure =
    {
      direction_in =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/turbo-underground-belt-structure.png",
          priority = "extra-high",
			width = 192,
          height = 192,
          y = 192,
          scale = 0.5
        }
      },
      direction_out =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/turbo-underground-belt-structure.png",
          priority = "extra-high",
			width = 192,
          height = 192,
          y = 192,
          scale = 0.5
        }
      },
      direction_in_side_loading =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/turbo-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192*3,
		  scale = 0.5,
        }
      },
      direction_out_side_loading =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/turbo-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192*2,
		  scale = 0.5,
        }
      },
      back_patch =
      {
        sheet =
        {
          filename = "__base__/graphics/entity/express-underground-belt/express-underground-belt-structure-front-patch.png",
          priority = "extra-high",
          width = 192,
          height = 192,
		  scale = 0.5,
        }
      },
      front_patch =
      {
        sheet =
        {
          filename = "__base__/graphics/entity/express-underground-belt/express-underground-belt-structure-front-patch.png",
          priority = "extra-high",
          width = 192,
          height = 192,
		  scale = 0.5,
        }
      }
    }
  },
  
   ------------------------------------------------------------------------------------------------------
   
  {
    type = "splitter",
    name = "turbo-splitter",
    icon = "__factorioplus__/graphics/icons/turbo-splitter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "turbo-splitter"},
    max_health = 200,
    corpse = "fast-splitter-remnants",
    dying_explosion = "fast-splitter-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 60
      }
    },
    collision_box = {{-0.9, -0.4}, {0.9, 0.4}},
    selection_box = {{-0.9, -0.5}, {0.9, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    animation_speed_coefficient = 32,
    structure_animation_speed_coefficient = 1.2,
    structure_animation_movement_cooldown = 10,
    belt_animation_set = turbo_belt_animation_set,
    fast_replaceable_group = "transport-belt",
	next_upgrade = "supersonic-splitter",
    speed = speed_turbobelts,
    working_sound = sounds.fast_splitter,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    structure =
    {
      north =
      {
        filename = "__factorioplus__/graphics/belts/turbo-splitter-north.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 1280/8,
        height = 280/4,
		scale = 0.5,
        shift = util.by_pixel(6, 0),
      },
      east =
      {
        filename = "__factorioplus__/graphics/belts/turbo-splitter-east.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 720/8,
        height = 336/4,
		scale = 0.5,
        shift = util.by_pixel(4, 12),
      },
      south =
      {
        filename = "__factorioplus__/graphics/belts/turbo-splitter-south.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
		width = 1312/8,
        height = 256/4,
		scale = 0.5,
        shift = util.by_pixel(4, 0),
      },
      west =
      {
        filename = "__factorioplus__/graphics/belts/turbo-splitter-west.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
		width = 752/8,
        height = 344/4,
		scale = 0.5,
        shift = util.by_pixel(6, 12),
      }
    },
    structure_patch =
    {
      north = util.empty_sprite(),
      east =
      {
        filename = "__factorioplus__/graphics/belts/turbo-splitter-east-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 720/8,
        height = 416/4,
		scale = 0.5,
        shift = util.by_pixel(4, -20),
      },
      south = util.empty_sprite(),
      west =
      {
        filename = "__factorioplus__/graphics/belts/turbo-splitter-west-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 752/8,
        height = 384/4,
		scale = 0.5,
        shift = util.by_pixel(6, -18),
      }
    }
  },
  
  ---------------------------------------------------  SUPERSONIC BELT  ------------------------------------------------------------
 {
    type = "transport-belt",
    name = "supersonic-transport-belt",
    icon = "__factorioplus__/graphics/icons/supersonic-transport-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "supersonic-transport-belt"},
    max_health = 200,
    corpse = "transport-belt-remnants",
    dying_explosion = "transport-belt-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
	  { 
	  type = "explosion", 
	  percent = 90 
	  },
    },
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/express-transport-belt.ogg",
        volume = 0.3,
		speed = 1.25,
      },
      persistent = true
    },
    animation_speed_coefficient = 32,
    belt_animation_set = supersonic_belt_animation_set,
    fast_replaceable_group = "transport-belt",
	related_underground_belt = "supersonic-underground-belt",
    speed = speed_superbelts,
    connector_frame_sprites = transport_belt_connector_frame_sprites,
    circuit_connectors = circuit_connector_definitions["belt"],
    circuit_wire_max_distance = transport_belt_circuit_wire_max_distance
  },
  
   ------------------------------------------------------------------------------------------------------
  
  {
    type = "underground-belt",
    name = "supersonic-underground-belt",
    icon = "__factorioplus__/graphics/icons/supersonic-underground-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "supersonic-underground-belt"},
    max_health = 200,
    corpse = "fast-underground-belt-remnants",
    dying_explosion = "fast-underground-belt-explosion",
    max_distance = 13,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/express-underground-belt.ogg",
        volume = 0.3,
		speed = 1.25,
      },
      max_sounds_per_type = 2,
      audible_distance_modifier = 0.5,
      persistent = true,
      use_doppler_shift = false
    },
    underground_sprite =
    {
      filename = "__core__/graphics/arrows/underground-lines.png",
      priority = "high",
      width = 64,
      height = 64,
      x = 64,
      scale = 0.5
    },
    underground_remove_belts_sprite =
    {
      filename = "__core__/graphics/arrows/underground-lines-remove.png",
      priority = "high",
      width = 64,
      height = 64,
      x = 64,
      scale = 0.5
    },
    resistances =
    {
      {
        type = "fire",
        percent = 60
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    animation_speed_coefficient = 32,
    belt_animation_set = supersonic_belt_animation_set,
    fast_replaceable_group = "transport-belt",
    speed = speed_superbelts,
    structure =
    {
      direction_in =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/supersonic-underground-belt-structure.png",
          priority = "extra-high",
			width = 192,
          height = 192,
          y = 192,
          scale = 0.5
        }
      },
      direction_out =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/supersonic-underground-belt-structure.png",
          priority = "extra-high",
			width = 192,
          height = 192,
          y = 192,
          scale = 0.5,
        }
      },
      direction_in_side_loading =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/supersonic-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192*3,
		  scale = 0.5,
        }
      },
      direction_out_side_loading =
      {
        sheet =
        {
          filename = "__factorioplus__/graphics/belts/supersonic-underground-belt-structure.png",
          priority = "extra-high",
          width = 192,
          height = 192,
          y = 192*2,
		  scale = 0.5,
        }
      },
      back_patch =
      {
        sheet =
        {
          filename = "__base__/graphics/entity/express-underground-belt/express-underground-belt-structure-front-patch.png",
          priority = "extra-high",
          width = 192,
          height = 192,
		  scale = 0.5,
        }
      },
      front_patch =
      {
        sheet =
        {
          filename = "__base__/graphics/entity/express-underground-belt/express-underground-belt-structure-front-patch.png",
          priority = "extra-high",
          width = 192,
          height = 192,
		  scale = 0.5,
        }
      }
    }
  },
  
   ------------------------------------------------------------------------------------------------------
   
  {
    type = "splitter",
    name = "supersonic-splitter",
    icon = "__factorioplus__/graphics/icons/supersonic-splitter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "supersonic-splitter"},
    max_health = 200,
    corpse = "fast-splitter-remnants",
    dying_explosion = "fast-splitter-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 60
      }
    },
    collision_box = {{-0.9, -0.4}, {0.9, 0.4}},
    selection_box = {{-0.9, -0.5}, {0.9, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    animation_speed_coefficient = 32,
    structure_animation_speed_coefficient = 1.2,
    structure_animation_movement_cooldown = 10,
    belt_animation_set = supersonic_belt_animation_set,
    fast_replaceable_group = "transport-belt",
    speed = speed_superbelts,
    working_sound = sounds.fast_splitter,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    structure =
    {
      north =
      {
        filename = "__factorioplus__/graphics/belts/supersonic-splitter-north.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 1280/8,
        height = 280/4,
		scale = 0.5,
        shift = util.by_pixel(6, 0),
      },
      east =
      {
        filename = "__factorioplus__/graphics/belts/supersonic-splitter-east.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 720/8,
        height = 336/4,
		scale = 0.5,
        shift = util.by_pixel(4, 12),
      },
      south =
      {
        filename = "__factorioplus__/graphics/belts/supersonic-splitter-south.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
		width = 1312/8,
        height = 256/4,
		scale = 0.5,
        shift = util.by_pixel(4, 0),
      },
      west =
      {
        filename = "__factorioplus__/graphics/belts/supersonic-splitter-west.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
		width = 752/8,
        height = 344/4,
		scale = 0.5,
        shift = util.by_pixel(6, 12),
      }
    },
    structure_patch =
    {
      north = util.empty_sprite(),
      east =
      {
        filename = "__factorioplus__/graphics/belts/supersonic-splitter-east-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 720/8,
        height = 416/4,
		scale = 0.5,
        shift = util.by_pixel(4, -20),
      },
      south = util.empty_sprite(),
      west =
      {
        filename = "__factorioplus__/graphics/belts/supersonic-splitter-west-top_patch.png",
        frame_count = 32,
        line_length = 8,
        priority = "extra-high",
        width = 752/8,
        height = 384/4,
		scale = 0.5,
        shift = util.by_pixel(6, -18),
      }
    }
  },
})

   ---------------------------------------------------  HUGE ELECTRIC POLE  ------------------------------------------------------------

local hep_cw_y = -350

data.extend({
   {
    type = "electric-pole",
    name = "huge-electric-pole",
    icon = "__factorioplus__/graphics/icons/huge-electric-pole.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.8, result = "huge-electric-pole"},
    max_health = 450,
    corpse = "big-electric-pole-remnants",
    dying_explosion = "big-electric-pole-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 95
      },
	  {
        type = "impact",
        percent = 40
      }
    },
    collision_box = {{-1.25, -1.25}, {1.25, 1.25}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity({{-0.5, -2.5},{0.5, 0.5}}),
    drawing_box = {{-1.5, -3}, {1.5, 1}},
    maximum_wire_distance = 64,
    supply_area_distance = 3.5,
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.electric_network_open,
    close_sound = sounds.electric_network_close,
    pictures =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/huge-electric-pole.png",
          priority = "extra-high",
          width = 1216/4,
          height = 512,
		  scale = 0.5,
          direction_count = 4,
          shift = util.by_pixel(1, -70),
        },
        {
          filename = "__factorioplus__/graphics/huge-electric-pole-shadow.png",
          priority = "extra-high",
          width = 2048/4,
          height = 212,
          direction_count = 4,
          shift = util.by_pixel(49, 11),
          draw_as_shadow = true,
		  scale = 0.45,
         }
      }
    },
    connection_points =
    {
      {
        shadow =
        {
          copper = util.by_pixel_hr(0.0, -0.0),
          red = util.by_pixel_hr(0, -0.0),
          green = util.by_pixel_hr(0.0, -0.0)
        },
        wire =
        {
          copper = util.by_pixel_hr(-0, -340.0),
          red = util.by_pixel_hr(74.0, -304.0),
          green = util.by_pixel_hr(-74.0, -304.0)
        }
      },
	   {
        shadow =
        {
          copper = util.by_pixel_hr(0.0, -0.0),
          red = util.by_pixel_hr(0.0, -0.0),
          green = util.by_pixel_hr(0.0, -0.0)
        },
        wire =
        {
          copper = util.by_pixel_hr(-0, -340.0),
          red = util.by_pixel_hr(52.0, -264.0),
          green = util.by_pixel_hr(-52.0, -332.0)
        }
      },
	   {
        shadow =
        {
          copper = util.by_pixel_hr(0.0, -0.0),
          red = util.by_pixel_hr(0.0, -0.0),
          green = util.by_pixel_hr(0.0, -0.0)
        },
        wire =
        {
          copper = util.by_pixel_hr(-0, -340.0),
          red = util.by_pixel_hr(0, -260.0),
          green = util.by_pixel_hr(0, -360.0)
        }
      },
	   {
        shadow =
        {
          copper = util.by_pixel_hr(0.0, -0.0),
          red = util.by_pixel_hr(0.0, -0.0),
          green = util.by_pixel_hr(0.0, -0.0)
        },
        wire =
        {
          copper = util.by_pixel_hr(-0, -340.0),
          red = util.by_pixel_hr(-52.0, -264.0),
          green = util.by_pixel_hr(52.0, -332.0)
        }
      },
    },
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      width = 12,
      height = 12,
      priority = "extra-high-no-scale"
    },
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/big-electric-pole/big-electric-pole-reflection.png",
        priority = "extra-high",
        width = 16,
        height = 32,
        shift = util.by_pixel(0, 60),
        variation_count = 1,
        scale = 2,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
  
       --------------------------------------------------- SMALL ROBOPORT  ------------------------------------------------------------
{
    type = "roboport",
    name = "mini-roboport",
    icon = "__factorioplus__/graphics/icons/mini-roboport.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.25, result = "mini-roboport"},
    max_health = 300,
    corpse = "roboport-remnants",
    dying_explosion = "roboport-explosion",
    collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    resistances =
    {
      {
        type = "fire",
        percent = 60
      },
      {
        type = "impact",
        percent = 30
      }
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "1MW",
      buffer_capacity = "25MJ"
    },
	
    recharge_minimum = "20MJ",
    energy_usage = "25kW",
    -- per one charge slot
    charging_energy = "250kW",
    logistics_radius = 20,
    construction_radius = 40,
    charge_approach_distance = 3,
    robot_slots_count = 2,
    material_slots_count = 1,
    stationing_offset = {0, 0},
	radar_range = 1,
    charging_offsets =
    {
      {-1.5, -0.5}, {1.5, -0.5}, {1.5, 1.5}, {-1.5, 1.5}
    },
    base =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/mini-robo-port.png",
          width = 248,
          height = 294,
		  scale = 0.35,
		  
          shift = util.by_pixel(0, -16),
        },
        {
          filename = "__factorioplus__/graphics/mini-robo-port-shadow.png",
          width = 353,
          height = 294,
		  scale = 0.35,
          draw_as_shadow = true,
          shift = util.by_pixel(20, -16),
        }
      }
    },
    base_animation =
    {
      filename = "__base__/graphics/entity/roboport/roboport-base-animation.png",
      priority = "medium",
      width = 83,
      height = 59,
      frame_count = 8,
      animation_speed = 0.5,
	  scale = 0.2,
      shift = util.by_pixel(-8, -52),
    },
    door_animation_down =
    {
      filename = "__factorioplus__/graphics/mini-robo-port-door.png",
      priority = "medium",
      width = 1980/8,
      height = 294,
      frame_count = 8,
      shift = util.by_pixel(0, -16),
      scale = 0.35,
    },
	 door_animation_up =
    {
      filename = "__factorioplus__/graphics/mini-robo-port-door.png",
      priority = "medium",
      width = 1980/8,
      height = 294,
      frame_count = 8,
      shift = util.by_pixel(0, -16),
      scale = 0.35,
    },
    recharging_animation =
    {
      filename = "__base__/graphics/entity/roboport/roboport-recharging.png",
      draw_as_glow = true,
      priority = "high",
      width = 37,
      height = 35,
      frame_count = 16,
      scale = 1.0,
      animation_speed = 0.5,
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound = { filename = "__base__/sound/roboport-working.ogg", volume = 0.4 },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.75,
      --probability = 1 / (5 * 60) -- average pause between the sound is 5 seconds
    },
    recharging_light = {intensity = 0.2, size = 3, color = {0.5, 0.5, 1}},
    request_to_open_door_timeout = 15,
    spawn_and_station_height = 0.4,
    stationing_render_layer_swap_height = 0.87,

    draw_logistic_radius_visualization = true,
    draw_construction_radius_visualization = true,

    open_door_trigger_effect = sounds.roboport_door_open,
    close_door_trigger_effect = sounds.roboport_door_close,

    circuit_connector = circuit_connector_definitions["roboport"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,

    default_available_logistic_output_signal = {type = "virtual", name = "signal-X"},
    default_total_logistic_output_signal = {type = "virtual", name = "signal-Y"},
    default_available_construction_output_signal = {type = "virtual", name = "signal-Z"},
    default_total_construction_output_signal = {type = "virtual", name = "signal-T"},

    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/roboport/roboport-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 28,
        shift = util.by_pixel(0, 75),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
})

     --------------------------------------------------- MAJOR ROBOHUB  ------------------------------------------------------------

mrp_charge_offset_x = 0
mrp_charge_offset_y = 0

data.extend({ 
 {
    type = "roboport",
    name = "roboport-major",
    icon = "__factorioplus__/graphics/icons/robo-superport.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 1.5, result = "roboport-major"},
    max_health = 1000,
    corpse = "roboport-remnants",
    dying_explosion = "roboport-explosion",
    collision_box = {{-3.8, -3.8}, {3.8, 3.8}},
    selection_box = {{-4, -4}, {4, 4}},
    damaged_trigger_effect = hit_effects.entity(),
    resistances =
    {
      {
        type = "fire",
        percent = 60
      },
      {
        type = "impact",
        percent = 50
      }
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "40MW",
      buffer_capacity = "400MJ"
    },
    recharge_minimum = "60MJ",
    energy_usage = "200kW",
    -- per one charge slot
    charging_energy = "1500kW",
	charging_station_count = 12,
	charging_distance = 3,
    logistics_radius = 54,
    construction_radius = 128,
    charge_approach_distance = 6,
    robot_slots_count = 12,
    material_slots_count = 4,
	radar_range = 3,
    
	stationing_offset = {0.75, -1}, -- where the bots go into the station
	
	charging_station_shift = {1, -1.25},
    charging_offsets =
    {
      {-2.5 + mrp_charge_offset_x, -0 + mrp_charge_offset_y}, {1.5 + mrp_charge_offset_x, -0 + mrp_charge_offset_y},
	  {0 + mrp_charge_offset_x, 1.5 + mrp_charge_offset_y}, {0 + mrp_charge_offset_x, 1.5 + mrp_charge_offset_y},
	  {-1.33 + mrp_charge_offset_x, -0.33 + mrp_charge_offset_y}, {-1.33 + mrp_charge_offset_x, 0.33 + mrp_charge_offset_y},
	  {1.33 + mrp_charge_offset_x, -0.33 + mrp_charge_offset_y}, {1.33 + mrp_charge_offset_x, 0.33 + mrp_charge_offset_y}, 	
      {-0.33 + mrp_charge_offset_x, -1.33 + mrp_charge_offset_y}, {-0.33 + mrp_charge_offset_x, 1.33 + mrp_charge_offset_y},
	  {0.33 + mrp_charge_offset_x, -1.33 + mrp_charge_offset_y}, {0.33 + mrp_charge_offset_x, 1.33 + mrp_charge_offset_y}, 
    },
    base =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/robo-superport.png",
            width = 721,
            height = 782,
            shift = util.by_pixel(0,-16),
            scale = 0.375,
        },
        {
          filename = "__factorioplus__/graphics/robo-superport-shadow.png",
          width = 899,
            height = 782,
		  scale = 0.375,
          draw_as_shadow = true,
          shift = util.by_pixel(34,-16),
        }
      }
    },
    base_animation =
    {
      filename = "__base__/graphics/entity/roboport/roboport-base-animation.png",
      priority = "medium",
      width = 83,
      height = 59,
      frame_count = 8,
      animation_speed = 0.4,
	  scale = 0.5,
      shift = util.by_pixel(-67,-144),
    },
	 door_animation_up =
    {
      filename = "__factorioplus__/graphics/robo-superport-door.png",
      priority = "medium",
      width = 5768/8,
      height = 782,
      frame_count = 8,
      shift = util.by_pixel(0,-16),
      scale = 0.375,
    },
    door_animation_down =
    {
      filename = "__factorioplus__/graphics/robo-superport-door.png",
      priority = "medium",
      width = 5768/8,
      height = 782,
      frame_count = 8,
      shift = util.by_pixel(0,-16),
      scale = 0.375,
    },
    recharging_animation =
    {
      filename = "__base__/graphics/entity/roboport/roboport-recharging.png",
      priority = "high",
      width = 37,
      height = 35,
      frame_count = 16,
      scale = 1,
      animation_speed = 0.9
    },
	
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound = { filename = "__base__/sound/roboport-working.ogg", volume = 0.4 },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.75,
      --probability = 1 / (5 * 60) -- average pause between the sound is 5 seconds
    },
    recharging_light = {intensity = 0.4, size = 5, color = {r = 1.0, g = 1.0, b = 1.0}},
    request_to_open_door_timeout = 15,
    spawn_and_station_height = 0.2,

    draw_logistic_radius_visualization = true,
    draw_construction_radius_visualization = true,

    open_door_trigger_effect = sounds.roboport_door_open,
    close_door_trigger_effect = sounds.roboport_door_close,

    circuit_connector = circuit_connector_definitions["roboport"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,

    default_available_logistic_output_signal = {type = "virtual", name = "signal-X"},
    default_total_logistic_output_signal = {type = "virtual", name = "signal-Y"},
    default_available_construction_output_signal = {type = "virtual", name = "signal-Z"},
    default_total_construction_output_signal = {type = "virtual", name = "signal-T"},

    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/roboport/roboport-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 28,
        shift = util.by_pixel(0, 75),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
  
   --------------------------------------------------- LARGE OFFSHORE PUMP ------------------------------------------------------------
   
  {
    type = "offshore-pump",
    name = "offshore-pump-large",
    icon = "__factorioplus__/graphics/icons/offshore-pump-large.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "filter-directions"},
	collision_mask = {layers={object=true, train=true, is_object=true, is_lower_object=true}}, -- collide just with object-layer and train-layer which don't collide with water, this allows us to build on 1 tile wide ground
    tile_buildability_rules =
    {
      {area = {{-1.4, -0.4}, {1.4, 0.4}}, required_tiles = {layers={ground_tile=true}}, colliding_tiles = {layers={water_tile=true}}, remove_on_collision = true},
      {area = {{-2, -3}, {2, -1}}, required_tiles = {layers={water_tile=true}}, colliding_tiles = {layers={}}},
    },
	-- center_collision_mask = { "water-tile", "object-layer", "player-layer" }, -- to test that tile directly under the pump is ground
    -- fluid_box_tile_collision_test = { "ground-tile" },
    -- adjacent_tile_collision_test = { "water-tile" },
    -- adjacent_tile_collision_mask = { "ground-tile" }, -- to prevent building on edge of map :(
    -- adjacent_tile_collision_box = { { -2, -4 }, { 2, -1 } },
    minable = {mining_time = 0.5, result = "offshore-pump-large"},
    max_health = 450,
    corpse = "offshore-pump-remnants",
    dying_explosion = "offshore-pump-explosion",
    -- fluid = "water",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-1.5, -1.05}, {1.5, 0.3}},
    selection_box = {{-1.5, -1.49}, {1.5, 0.49}},
    damaged_trigger_effect = hit_effects.entity(),
	fluid_source_offset = {0, -1},
    fluid_box =
    {
      volume = 500,
	  pipe_picture = assembler2pipepictures(),
      pipe_covers = pipecoverspictures(),
      production_type = "output",
      -- filter = "water",
      pipe_connections =
      {
        {
          position = {1, 0},
		  direction = defines.direction.south,
          flow_direction = "output"
        },
		{
          position = {-1, 0},
		  direction = defines.direction.south,
         flow_direction = "output"
        },
      }
    },
	energy_source =
    {
      type = "void"
    },
	energy_usage = "160kW",
    pumping_speed = 26,
    tile_width = 1,
    tile_height = 1,
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/offshore-pump.ogg",
          volume = 0.7,
		  speed = 0.7,
        }
      },
      match_volume_to_activity = true,
      audible_distance_modifier = 0.7,
      max_sounds_per_type = 3,
      fade_in_ticks = 4,
      fade_out_ticks = 20,
    },
    min_perceived_performance = 0.5,
    always_draw_fluid = true,
    graphics_set =
    {
      underwater_layer_offset = 30,
      base_render_layer = "ground-patch",
      animation =
      {
        north =
        {
          layers =
          {
            {
              filename = "__factorioplus__/graphics/offshore-pump-large-n.png",
              priority = "high",
              line_length = 1,
              frame_count = 1,
              width = 208,
              height = 192,
              shift = util.by_pixel(0, -32),
			  scale = 0.5,
            },
          }
        },
        east =
        {
          layers =
          {
           {
              filename = "__factorioplus__/graphics/offshore-pump-large-e.png",
              priority = "high",
              line_length = 1,
              frame_count = 1,
              width = 256,
              height = 256,
			  scale = 0.5,
              shift = util.by_pixel(48,-16),
            },
          }
        },
        south =
        {
          layers =
          {
            {
              filename = "__factorioplus__/graphics/offshore-pump-large-s.png",
              priority = "high",
              line_length = 1,
              frame_count = 1,
              width = 208,
              height = 224,
			  scale = 0.5,
			  
              shift = util.by_pixel(0, 32),
            },
          }
        },
        west =
        {
          layers =
          {
            {
              filename = "__factorioplus__/graphics/offshore-pump-large-w.png",
              priority = "high",
              line_length = 1,
              frame_count = 1,
              width = 256,
              height = 256,
			  scale = 0.5,
			  
              shift = util.by_pixel(-48, -16),
            },
          }
        }
      },
      
    },
    placeable_position_visualization =
    {
      filename = "__core__/graphics/cursor-boxes-32x32.png",
      priority = "extra-high-no-scale",
      width = 64,
      height = 64,
      scale = 0.5,
      x = 3*64
    },
    circuit_connectors = circuit_connector_definitions["offshore-pump"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/offshore-pump/offshore-pump-reflection.png",
        priority = "extra-high",
        width = 132,
        height = 156,
        shift = util.by_pixel(0, 19),
        variation_count = 4,
        scale = 1,
      },
      rotate = false,
      orientation_to_variation = true
    }
  },

})
	
	
 ------------------------------------------ LOADERS 0 & 1 & 2 & 3 & 4 & 5 ------------------------------------------

if settings.startup["settings-loaders-active"].value then
data.extend({ 


--------------------------------------------------- LOADER BASIC ------------------------------------------------------------
   {
    type = "loader",
    name = "basic-loader",
    icon = "__factorioplus__/graphics/icons/basic-loader.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation" },
    minable = {mining_time = 0.1, result = "basic-loader"},
    max_health = 100,
    filter_count = 1,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = sounds.loader,
    corpse = "small-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 60
      }
    },
	icon_draw_specification = { scale = 0.5},
    collision_box = {{-0.45, -0.9}, {0.45, 0.9}},
    selection_box = {{-0.5, -1}, {0.5, 1}},
    animation_speed_coefficient = 32,
    belt_animation_set = slow_belt_animation_set,
    fast_replaceable_group = "loader",
    speed = speed_slowbelts,
	next_upgrade = "loader",
    structure =
    {
      direction_in =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/basic-loader.png",
          priority = "extra-high",
          width = 128,
          height = 128
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        }
		},
      },
      direction_out =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/basic-unloader.png",
          priority = "extra-high",
          width = 128,
          height = 128,
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        }
		},
		
      }
    },
		
    circuit_connector = circuit_connector_definitions["loader"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
  },



 --------------------------------------------------- LOADER ------------------------------------------------------------

   {
    type = "loader",
    name = "loader",
    icon = "__factorioplus__/graphics/icons/loader.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation" },
    minable = {mining_time = 0.1, result = "loader"},
    max_health = 150,
    filter_count = 2,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = sounds.loader,
    corpse = "small-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 60
      }
    },
	icon_draw_specification = { scale = 0.5},
    collision_box = {{-0.45, -0.9}, {0.45, 0.9}},
    selection_box = {{-0.5, -1}, {0.5, 1}},
    animation_speed_coefficient = 32,
    belt_animation_set = basic_belt_animation_set,
    fast_replaceable_group = "loader",
    speed = speed_basicbelts,
	next_upgrade = "fast-loader",
    -- structure_render_layer = "lower-object",
    structure =
    {
      direction_in =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/loader.png",
          priority = "extra-high",
          width = 128,
          height = 128
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        }
		},
      },
      direction_out =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/unloader.png",
          priority = "extra-high",
          width = 128,
          height = 128,
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        }
		},
		
      }
    },
	
	circuit_connector = circuit_connector_definitions["loader"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
  },
  
  --------------------------------------------------- LOADER FAST ------------------------------------------------------------

  {
    type = "loader",
    name = "fast-loader",
    icon = "__factorioplus__/graphics/icons/fast-loader.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation" },
    minable = {mining_time = 0.1, result = "fast-loader"},
    max_health = 200,
    filter_count = 3,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = sounds.fast_loader,
    corpse = "small-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 60
      }
    },
	icon_draw_specification = { scale = 0.5},
   collision_box = {{-0.45, -0.9}, {0.45, 0.9}},
    selection_box = {{-0.5, -1}, {0.5, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    animation_speed_coefficient = 32,
    belt_animation_set = fast_belt_animation_set,
    fast_replaceable_group = "loader",
	next_upgrade = "express-loader",
    speed = speed_fastbelts,
    --structure_render_layer = "lower-object",
    structure =
    {
      direction_in =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/fast-loader.png",
          priority = "extra-high",
          width = 128,
          height = 128
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        },
		},
      },
      direction_out =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/fast-unloader.png",
          priority = "extra-high",
          width = 128,
          height = 128,
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        },
		},
      }
    },
	
	circuit_connector = circuit_connector_definitions["loader"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
  },
  
    --------------------------------------------------- LOADER EXPRESS ------------------------------------------------------------

  {
    type = "loader",
    name = "express-loader",
    icon = "__factorioplus__/graphics/icons/express-loader.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation" },
    minable = {mining_time = 0.1, result = "express-loader"},
    max_health = 250,
    filter_count = 4,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = sounds.express_loader,
    corpse = "small-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 60
      }
    },
	icon_draw_specification = { scale = 0.5},
   collision_box = {{-0.45, -0.9}, {0.45, 0.9}},
    selection_box = {{-0.5, -1}, {0.5, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    animation_speed_coefficient = 32,
    belt_animation_set = express_belt_animation_set,
    fast_replaceable_group = "loader",
	next_upgrade = "turbo-loader",
    speed = speed_expressbelts,
    --structure_render_layer = "lower-object",
    structure =
    {
      direction_in =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/express-loader.png",
          priority = "extra-high",
          width = 128,
          height = 128
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        },
		}
      },
      direction_out =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/express-unloader.png",
          priority = "extra-high",
          width = 128,
          height = 128,
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        },
		}
      }
    },
	
	circuit_connector = circuit_connector_definitions["loader"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
  },
  
   --------------------------------------------------- LOADER TURBO ------------------------------------------------------------

  {
    type = "loader",
    name = "turbo-loader",
    icon = "__factorioplus__/graphics/icons/turbo-loader.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation" },
    minable = {mining_time = 0.1, result = "turbo-loader"},
    max_health = 300,
    filter_count = 5,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = sounds.express_loader,
    corpse = "small-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 60
      }
    },
	icon_draw_specification = { scale = 0.5},
    collision_box = {{-0.45, -0.9}, {0.45, 0.9}},
    selection_box = {{-0.5, -1}, {0.5, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    animation_speed_coefficient = 32,
    belt_animation_set = turbo_belt_animation_set,
    fast_replaceable_group = "loader",
	next_upgrade = "supersonic-loader",
    speed = speed_turbobelts,
    structure =
    {
     direction_in =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/turbo-loader.png",
          priority = "extra-high",
          width = 128,
          height = 128
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        },
		},
      },
      direction_out =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/turbo-unloader.png",
          priority = "extra-high",
          width = 128,
          height = 128,
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        },
		},
      }
    },
		
	circuit_connector = circuit_connector_definitions["loader"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
  },
  
  --------------------------------------------------- LOADER SUPERSONIC ------------------------------------------------------------

  {
    type = "loader",
    name = "supersonic-loader",
    icon = "__factorioplus__/graphics/icons/supersonic-loader.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation" },
    minable = {mining_time = 0.1, result = "supersonic-loader"},
    max_health = 350,
    filter_count = 5,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound = sounds.express_loader,
    corpse = "small-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 60
      }
    },
	icon_draw_specification = { scale = 0.5},
    collision_box = {{-0.45, -0.9}, {0.45, 0.9}},
    selection_box = {{-0.5, -1}, {0.5, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    animation_speed_coefficient = 32,
    belt_animation_set = supersonic_belt_animation_set,
    fast_replaceable_group = "loader",
    speed = speed_superbelts,
    structure =
    {
     direction_in =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/supersonic-loader.png",
          priority = "extra-high",
          width = 128,
          height = 128
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        },
		},
      },
      direction_out =
      {
        sheets =
		{
        {
          filename = "__factorioplus__/graphics/belts/supersonic-unloader.png",
          priority = "extra-high",
          width = 128,
          height = 128,
        },
		{
          filename = "__factorioplus__/graphics/belts/unloader-shadow.png",
          priority = "extra-high",
          width = 128,
          height = 128,
		  draw_as_shadow = true,
        },
		},
      }
    },
		
	circuit_connector = circuit_connector_definitions["loader"],
    circuit_wire_max_distance = default_circuit_wire_max_distance,
  },
  
}) 

	-- If loaders need electricity, give them these values:
	if settings.startup["settings-loaders-electricity"].value then
		data.raw["loader"]["basic-loader"].energy_per_item = "6kW"
		data.raw["loader"]["basic-loader"].energy_source =
		{
		  type = "electric",
		  usage_priority = "secondary-input",
		  drain = "10kW"
		}
		data.raw["loader"]["loader"].energy_per_item = "10kW"
		data.raw["loader"]["loader"].energy_source =
		{
		  type = "electric",
		  usage_priority = "secondary-input",
		  drain = "20kW"
		}
		data.raw["loader"]["fast-loader"].energy_per_item = "14kW"
		data.raw["loader"]["fast-loader"].energy_source =
		{
		  type = "electric",
		  usage_priority = "secondary-input",
		  drain = "40kW"
		}
		data.raw["loader"]["express-loader"].energy_per_item = "18kW"
		data.raw["loader"]["express-loader"].energy_source =
		{
		  type = "electric",
		  usage_priority = "secondary-input",
		  drain = "80kW"
		}
		data.raw["loader"]["turbo-loader"].energy_per_item = "22kW"
		data.raw["loader"]["turbo-loader"].energy_source =
		{
		  type = "electric",
		  usage_priority = "secondary-input",
		  drain = "160kW"
		}
		data.raw["loader"]["supersonic-loader"].energy_per_item = "26kW"
		data.raw["loader"]["supersonic-loader"].energy_source =
		{
		  type = "electric",
		  usage_priority = "secondary-input",
		  drain = "320kW"
		}
	end
   
   
end

if (mods["space-age"]) then
	for i, v in pairs(data.raw["loader"]) do		
		v.max_belt_stack_size = data.raw["utility-constants"]["default"].max_belt_stack_size or 4
		v.adjustable_belt_stack_size = true
	end
end

  --------------------------------------------------- SMALL RADAR ------------------------------------------------------------
data.extend({
{
    type = "radar",
    name = "listening-post",
    icon = "__factorioplus__/graphics/icons/listening-post.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "listening-post"},
    max_health = 150,
    corpse = "small-remnants",
    dying_explosion = "radar-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selection_box = {{-1.0, -1.0}, {1.0, 1.0}},
    damaged_trigger_effect = hit_effects.entity(),
    energy_per_sector = "400kJ",
    max_distance_of_sector_revealed = 5,
    max_distance_of_nearby_sector_revealed = 4,
    energy_per_nearby_scan = "20kJ",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "60kW",
    integration_patch =
    {
      filename = "__base__/graphics/entity/radar/radar-integration.png",
      priority = "low",
      width = 119,
      height = 108,
	  scale = 0.75,
      direction_count = 1,
      shift = util.by_pixel(1.5, 4),
    },
    pictures =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/listening-post.png",
          priority = "low",
          width = 128,
          height = 384,
		  scale = 0.5,
			
		  apply_projection = false,
          direction_count = 32,
          line_length = 8,
          shift = util.by_pixel(0, -64),
        },
		{
          filename = "__factorioplus__/graphics/listening-post-shadow.png",
          priority = "low",
          width = 384,
          height = 96,
		  scale = 0.5,
		  
		  apply_projection = false,
		  draw_as_shadow = true,
          direction_count = 32,
          line_length = 4,
          shift = util.by_pixel(64, 8),
        },
      },
	},
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/radar.ogg",
          volume = 0.6,
		  speed = 2.5,
        }
      },
    max_sounds_per_type = 3,
    --audible_distance_modifier = 0.8,
    use_doppler_shift = false
    },
    radius_minimap_visualisation_color = { r = 0.059, g = 0.092, b = 0.235, a = 0.275 },
    rotation_speed = 0.015,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/radar/radar-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 32,
        shift = util.by_pixel(5, 35),
        variation_count = 1,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = false
    },
  },
  
  
  --------------------------------------------------- LARGE RADAR ------------------------------------------------------------

{
    type = "radar",
    name = "radar-large",
    icon = "__factorioplus__/graphics/icons/large-radar.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.8, result = "radar-large"},
    max_health = 550,
    corpse = "big-remnants",
    dying_explosion = "radar-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = {{-2.8, -2.8}, {2.8, 2.8}},
    selection_box = {{-3, -3}, {3, 3}},
    damaged_trigger_effect = hit_effects.entity(),
    energy_per_sector = "40MJ",
    max_distance_of_sector_revealed = 28,
    max_distance_of_nearby_sector_revealed = 2,
    energy_per_nearby_scan = "400kJ",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "950kW",
   
      pictures =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/large-radar.png",
          priority = "low",
          width = 320,
          height = 384,
		  
          apply_projection = false,
          direction_count = 64,
          line_length = 8,
		  scale = .65,
		  shift = util.by_pixel(0, -30),
        },
		{
          filename = "__factorioplus__/graphics/large-radar-shadow.png",
          priority = "low",
          width = 384,
          height = 192,          
		  scale = 0.65,
		  
		  apply_projection = false,
		  draw_as_shadow = true,
          direction_count = 64,
          line_length = 8,
          shift = util.by_pixel(30, 20),
       },
      }
    },
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/radar.ogg",
		  speed = 0.5,
          volume =1
        }
      },
    max_sounds_per_type = 3,
    --audible_distance_modifier = 0.8,
    use_doppler_shift = false
    },
    radius_minimap_visualisation_color = { r = 0.059, g = 0.092, b = 0.235, a = 0.275 },
    rotation_speed = 0.005,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/radar/radar-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 32,
        shift = util.by_pixel(5, 35),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
  })
  ------------------------------------------------------------------------------------------------------
--------------------------------------------------- OVERRIDES ------------------------------------------------------------
------------------------------------------------------------------------------------------------------
 -- table.insert(data.raw["technology"]["advanced-circuit"].effects,{type = "unlock-recipe",recipe = "silicon-wafer"})
  
  table.insert( data.raw["lab"]["lab"].inputs, "bio-science-pack")
 
 if (mods["space-age"]) then
    table.insert( data.raw["lab"]["biolab"].inputs, "bio-science-pack")
end
 

data.extend({ 
  --------------------------------------------------- BASIC LABORATORY ------------------------------------------------------------

  {
    type = "lab",
    name = "basic-lab",
    icon = "__factorioplus__/graphics/icons/basic-lab.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.25, result = "basic-lab"},
    max_health = 100,
    corpse = "lab-remnants",
    dying_explosion = "lab-explosion",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    light = {intensity = 0.25, size = 6, color = {r = 0.25, g = 0.5, b = 1.0}},
	fast_replaceable_group = "lab",
	next_upgrade = "lab",
    on_animation =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/basic-lab/basic-lab.png",
          width = 2048/8,
          height = 512/2,
          frame_count = 16,
          line_length = 8,
          animation_speed = 1 / 3,
		  run_mode = "forward-then-backward",
          shift = util.by_pixel(0, 4),
		   scale = 0.4,
        },
        {
          filename = "__factorioplus__/graphics/basic-lab/basic_lab_shadow.png",
          width = 2048/8,
          height = 512/2,
          frame_count = 1,
          line_length = 1,
		  repeat_count = 30,
          animation_speed = 1 / 3,
          shift = util.by_pixel(4, 4),
          draw_as_shadow = true,
		  scale = 0.4,
        },
		{
		  filename = "__factorioplus__/graphics/basic-lab/basic-lab-mask.png",
          blend_mode = "additive",
          draw_as_light = true,
          width = 2048/8,
          height = 512/2,
          frame_count = 16,
          line_length = 8,
          animation_speed = 1 / 3,
		  run_mode = "forward-then-backward",
		  scale = 0.4,
          shift = util.by_pixel(0, 4),	  
		  },

      }
    },
    off_animation =
    {
      layers =
      {
		{
          filename = "__factorioplus__/graphics/basic-lab/basic-lab.png",
          width = 2048/8,
          height = 512/2,
		  frame_count = 1,
		  line_length = 1,
          shift = util.by_pixel(0, 4),
		   scale = 0.4,
        },
        {
          filename = "__factorioplus__/graphics/basic-lab/basic_lab_shadow.png",
          width = 2048/8,
          height = 512/2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(4, 4),
          draw_as_shadow = true,
		  scale = 0.4,
        },
      }
    },
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/lab.ogg",
        volume = 0.5,
		speed = 1.3,
      },
      audible_distance_modifier = 0.7,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.lab_open,
    close_sound = sounds.lab_close,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "25kW",
    researching_speed = 0.5,
    inputs = 
	{
    "automation-science-pack",
    "logistic-science-pack",
    "military-science-pack",
	"bio-science-pack",
    "chemical-science-pack",
    -- "production-science-pack",
    -- "utility-science-pack",
    -- "space-science-pack"
},

  },
  
  --------------------------------------------------- LARGE LABORATORY ------------------------------------------------------------
  
  {
    type = "lab",
    name = "lab-large",
    icon = "__factorioplus__/graphics/icons/lab-large.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.4, result = "lab-large"},
    max_health = 350,
    corpse = "lab-remnants",
    dying_explosion = "lab-explosion",
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),
    light = {intensity = 0.15, size = 10, color = {r = 0.2, g = 0.5, b = 1.0}},
    on_animation =
    {
      layers =
      {
        {
          filename = "__factorioplus__/graphics/large-lab/large-lab.png",
          width = 2880/6,
          height = 1398/3,
          frame_count = 17,
		  frame_sequence = { 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 },
          line_length = 6,
          animation_speed = 1 / 3,
          shift = util.by_pixel(0, 4),
		   scale = 0.4,
        },
        {
          filename = "__factorioplus__/graphics/large-lab/large-lab-shadow.png",
          width = 2880/6,
          height = 1398/3,
          frame_count = 1,
          line_length = 1,
		  repeat_count = 16,
          animation_speed = 1 / 3,
          shift = util.by_pixel(4, 4),
          draw_as_shadow = true,
		  scale = 0.4,
        },
		{
		  filename = "__factorioplus__/graphics/large-lab/large-lab-mask.png",
          blend_mode = "additive",
          draw_as_light = true,
          width = 2880/6,
          height = 1398/3,
          frame_count = 17,
		  frame_sequence = { 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17},
          line_length = 6,
          animation_speed = 1 / 3,
		  scale = 0.4,
          shift = util.by_pixel(0, 4),	  
		  },

      }
    },
    off_animation =
    {
      layers =
      {
		{
          filename = "__factorioplus__/graphics/large-lab/large-lab.png",
          width = 2880/6,
          height = 1398/3,
		  frame_count = 1,
		  line_length = 1,
          shift = util.by_pixel(0, 4),
		   scale = 0.4,
        },
        {
          filename = "__factorioplus__/graphics/large-lab/large-lab-shadow.png",
          width = 2880/6,
          height = 1398/3,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(4, 4),
          draw_as_shadow = true,
		  scale = 0.4,
        },
      }
    },
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/lab.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      audible_distance_modifier = 0.9,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    energy_usage = "350kW",
    researching_speed = 2.0,
    inputs = 
	{
    "automation-science-pack",
    "logistic-science-pack",
    "military-science-pack",
	"bio-science-pack",
    "chemical-science-pack",
    "production-science-pack",
    "utility-science-pack",
    "space-science-pack"
},

    module_slots = 4,

  },
})
  
if (mods["space-age"]) then
table.insert(data.raw.lab["lab-large"].inputs, "metallurgic-science-pack")
table.insert(data.raw.lab["lab-large"].inputs, "agricultural-science-pack")
table.insert(data.raw.lab["lab-large"].inputs, "electromagnetic-science-pack")
table.insert(data.raw.lab["lab-large"].inputs, "cryogenic-science-pack")
table.insert(data.raw.lab["lab-large"].inputs, "promethium-science-pack")
end

  --------------------------------------------------- NEW PIPES ------------------------------------------------------------




local function make_visualization(i)
  return
  {
    filename = "__base__/graphics/entity/pipe/visualization.png",
    priority = "extra-high",
    x = i * 64,
    size = 64,
    scale = 0.5,
    flags = {"icon"},
  }
end

local function make_disabled_visualization(i)
  return
  {
    filename = "__base__/graphics/entity/pipe/disabled-visualization.png",
    priority = "extra-high",
    x = i * 64,
    size = 64,
    scale = 0.5,
    flags = {"icon"},
  }
end

function pipespicture(pipetint,path)
  return
  {
    straight_vertical_single =
    {
      filename = path .. "pipe-straight-vertical-single.png",
      priority = "extra-high",
      width = 160,
      height = 160,
      scale = 0.5,
	  tint = pipetint
    },
    straight_vertical =
    {
      filename = path .. "pipe-straight-vertical.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    straight_vertical_window =
    {
      filename = path .. "pipe-straight-vertical-window.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    straight_horizontal_window =
    {
      filename = path .. "pipe-straight-horizontal-window.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    straight_horizontal =
    {
      filename = path .. "pipe-straight-horizontal.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    corner_up_right =
    {
      filename = path .. "pipe-corner-up-right.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    corner_up_left =
    {
      filename = path .. "pipe-corner-up-left.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    corner_down_right =
    {
      filename = path .. "pipe-corner-down-right.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    corner_down_left =
    {
      filename = path .. "pipe-corner-down-left.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    t_up =
    {
      filename = path .. "pipe-t-up.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    t_down =
    {
      filename = path .. "pipe-t-down.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    t_right =
    {
      filename = path .. "pipe-t-right.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    t_left =
    {
      filename = path .. "pipe-t-left.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    cross =
    {
      filename = path .. "pipe-cross.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    ending_up =
    {
      filename = path .. "pipe-ending-up.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    ending_down =
    {
      filename = path .. "pipe-ending-down.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    ending_right =
    {
      filename = path .. "pipe-ending-right.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    ending_left =
    {
      filename = path .. "pipe-ending-left.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5,
	  tint = pipetint
    },
    straight_vertical_single_visualization = make_visualization(0),
    straight_vertical_visualization = make_visualization(5),
    straight_vertical_window_visualization = make_visualization(5),
    straight_horizontal_window_visualization = make_visualization(10),
    straight_horizontal_visualization = make_visualization(10),
    corner_up_right_visualization = make_visualization(3),
    corner_up_left_visualization = make_visualization(9),
    corner_down_right_visualization = make_visualization(6),
    corner_down_left_visualization = make_visualization(12),
    t_up_visualization = make_visualization(11),
    t_down_visualization = make_visualization(14),
    t_right_visualization = make_visualization(7),
    t_left_visualization = make_visualization(13),
    cross_visualization = make_visualization(15),
    ending_up_visualization = make_visualization(1),
    ending_down_visualization = make_visualization(4),
    ending_right_visualization = make_visualization(2),
    ending_left_visualization = make_visualization(8),
    straight_vertical_single_disabled_visualization = make_disabled_visualization(0),
    straight_vertical_disabled_visualization = make_disabled_visualization(5),
    straight_vertical_window_disabled_visualization = make_disabled_visualization(5),
    straight_horizontal_window_disabled_visualization = make_disabled_visualization(10),
    straight_horizontal_disabled_visualization = make_disabled_visualization(10),
    corner_up_right_disabled_visualization = make_disabled_visualization(3),
    corner_up_left_disabled_visualization = make_disabled_visualization(9),
    corner_down_right_disabled_visualization = make_disabled_visualization(6),
    corner_down_left_disabled_visualization = make_disabled_visualization(12),
    t_up_disabled_visualization = make_disabled_visualization(11),
    t_down_disabled_visualization = make_disabled_visualization(14),
    t_right_disabled_visualization = make_disabled_visualization(7),
    t_left_disabled_visualization = make_disabled_visualization(13),
    cross_disabled_visualization = make_disabled_visualization(15),
    ending_up_disabled_visualization = make_disabled_visualization(1),
    ending_down_disabled_visualization = make_disabled_visualization(4),
    ending_right_disabled_visualization = make_disabled_visualization(2),
    ending_left_disabled_visualization = make_disabled_visualization(8),
    horizontal_window_background =
    {
      filename = "__base__/graphics/entity/pipe/pipe-horizontal-window-background.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5
    },
    vertical_window_background =
    {
      filename = "__base__/graphics/entity/pipe/pipe-vertical-window-background.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5
    },
    fluid_background =
    {
      filename = "__base__/graphics/entity/pipe/fluid-background.png",
      priority = "extra-high",
      width = 64,
      height = 40,
      scale = 0.5
    },
    low_temperature_flow =
    {
      filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
      priority = "extra-high",
      width = 160,
      height = 18
    },
    middle_temperature_flow =
    {
      filename = "__base__/graphics/entity/pipe/fluid-flow-medium-temperature.png",
      priority = "extra-high",
      width = 160,
      height = 18
    },
    high_temperature_flow =
    {
      filename = "__base__/graphics/entity/pipe/fluid-flow-high-temperature.png",
      priority = "extra-high",
      width = 160,
      height = 18
    },
    gas_flow =
    {
      filename = "__base__/graphics/entity/pipe/steam.png",
      priority = "extra-high",
      line_length = 10,
      width = 48,
      height = 30,
      frame_count = 60
    }
  }
end

local basicpipe_distance = 6
local pipe_distance = 12
local reinforcedpipe_distance = 24

-- BASE PIPE OVERRIDE 
data.raw["pipe-to-ground"]["pipe-to-ground"].fluid_box.pipe_connections[2].max_underground_distance = pipe_distance


data.raw["pipe"]["pipe"].max_health = 200
table.insert(data.raw["pipe"]["pipe"].resistances,
	{
		type = "physical",
		percent = 25
	}
)

data.raw["pipe-to-ground"]["pipe-to-ground"].max_health = 250
table.insert(data.raw["pipe-to-ground"]["pipe-to-ground"].resistances,
	{
		type = "physical",
		percent = 25
	}
)




-- F+ PIPES --


local basicpipetint = { 1, 1, 1 } 
local reinforcedpipetint = { 1, 1, 1 } 

data.extend({  
{
    type = "pipe",
    name = "pipe-basic",
    icons = { {icon = "__base__/graphics/icons/pipe.png", tint = basicpipetint} }, 
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "pipe"},
    max_health = 100,
    corpse = "pipe-remnants",
    dying_explosion = "pipe-explosion",
    icon_draw_specification = {scale = 0.5},
    resistances =
    {
      {
        type = "fire",
        percent = 50
      },
      {
        type = "impact",
        percent = 20
      }
    },
    fast_replaceable_group = "pipe",
    collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    fluid_box =
    {
      volume = 50,
      pipe_covers = pipecoverspictures(), -- in case a real pipe is connected to a ghost
      pipe_connections =
      {
        { direction = defines.direction.north, position = {0, 0} },
        { direction = defines.direction.east, position = {0, 0} },
        { direction = defines.direction.south, position = {0, 0} },
        { direction = defines.direction.west, position = {0, 0} }
      },
      hide_connection_info = true
    },
    impact_category = "metal",
    pictures = pipespicture(basicpipetint, "__factorioplus__/graphics/basic-pipe/"),
    working_sound = sounds.pipe,
    open_sound = sounds.metal_small_open,
    close_sound = sounds.metal_small_close,

    horizontal_window_bounding_box = {{-0.25, -0.28125}, {0.25, 0.15625}},
    vertical_window_bounding_box = {{-0.28125, -0.5}, {0.03125, 0.125}}
  },
  
  {
    type = "pipe-to-ground",
    name = "pipe-to-ground-basic",
	icons = { {icon = "__base__/graphics/icons/pipe-to-ground.png", tint = basicpipetint} }, 
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "pipe-to-ground"},
    max_health = 150,
    corpse = "pipe-to-ground-remnants",
    dying_explosion = "pipe-to-ground-explosion",
    -- factoriopedia_simulation = simulations.factoriopedia_pipe_to_ground,
    icon_draw_specification = {scale = 0.5},
    resistances =
    {
      {
        type = "fire",
        percent = 50
      },
      {
        type = "impact",
        percent = 20
      }

    },
    fast_replaceable_group = "pipe",
    collision_box = {{-0.29, -0.29}, {0.29, 0.2}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    fluid_box =
    {
      volume = 50,
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        { direction = defines.direction.north, position = {0, 0} },
        {
          connection_type = "underground",
          direction = defines.direction.south,
          position = {0, 0},
          max_underground_distance = basicpipe_distance
        }
      },
      hide_connection_info = true
    },
    impact_category = "metal",
    working_sound = sounds.pipe,
    open_sound = sounds.metal_small_open,
    close_sound = sounds.metal_small_close,
    pictures =
    {
      north =
      {
        filename = "__factorioplus__/graphics/basic-pipe/pipe-to-ground-up.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5,
		tint = basicpipetint
      },
      south =
      {
        filename = "__factorioplus__/graphics/basic-pipe/pipe-to-ground-down.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5,
		tint = basicpipetint
      },
      west =
      {
        filename = "__factorioplus__/graphics/basic-pipe/pipe-to-ground-left.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5,
		tint = basicpipetint
      },
      east =
      {
        filename = "__factorioplus__/graphics/basic-pipe/pipe-to-ground-right.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5,
		tint = basicpipetint
      }
    },
    visualization =
    {
      north =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 64,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      south =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 192,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      west =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 256,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      east =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 128,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
    },
    disabled_visualization =
    {
      north =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 64,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      south =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 192,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      west =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 256,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      east =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 128,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
    },
  },
})
  
  


 


-- PIPE TECHNOLOGY OVERRIDE --	

table.removetablewithmatchingentry(data.raw["technology"]["fluid-handling"].effects, "recipe", "pipe") 
table.removetablewithmatchingentry(data.raw["technology"]["fluid-handling"].effects, "recipe", "pipe-to-ground")

table.insert(data.raw["technology"]["steam-power"].effects,
	{
		type = "unlock-recipe",
		recipe = "pipe-basic"
	}
)

table.insert(data.raw["technology"]["steam-power"].effects,
	{
		type = "unlock-recipe",
		recipe = "pipe-basic"
	}
)

table.insert(data.raw["technology"]["fluid-handling"].effects,
	{
		type = "unlock-recipe",
		recipe = "pipe"
	}
)

table.insert(data.raw["technology"]["fluid-handling"].effects,
	{
		type = "unlock-recipe",
		recipe = "pipe-to-ground"
	}
)

-- PIPE RECIPE OVERRIDE --	

-- data.raw["recipe"]["pipe"].ingredients = 
-- {
	-- {type = "item", name = "pipe-basic", amount = 2},
	-- {type = "item", name = "copper-plate", amount = 2},
-- }
-- data.raw["recipe"]["pipe"].results = 
-- {
	-- {type="item", name="pipe", amount=2}
-- }


-- data.raw["recipe"]["pipe-to-ground"].ingredients =
-- {
  -- {type = "item", name = "pipe", amount = 12},
  -- {type = "item", name = "iron-plate", amount = 4}
-- }

-- data.raw["recipe"]["pipe-to-ground"].results = 
-- {
	-- {type="item", name="pipe-to-ground", amount=2}
-- }


-- REINFORCED PIPES --	

data.extend({ 
{
    type = "pipe",
    name = "pipe-reinforced",
    icons = { {icon = "__base__/graphics/icons/pipe.png", tint = reinforcedpipetint} }, 
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "pipe"},
    max_health = 400,
    corpse = "pipe-remnants",
    dying_explosion = "pipe-explosion",
    icon_draw_specification = {scale = 0.5},
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      },
	  {
        type = "physical",
        percent = 40
      },
	  {
        type = "explosion",
        percent = 40
      }
    },
    fast_replaceable_group = "pipe",
    collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    fluid_box =
    {
      volume = 50,
      pipe_covers = pipecoverspictures(), -- in case a real pipe is connected to a ghost
      pipe_connections =
      {
        { direction = defines.direction.north, position = {0, 0} },
        { direction = defines.direction.east, position = {0, 0} },
        { direction = defines.direction.south, position = {0, 0} },
        { direction = defines.direction.west, position = {0, 0} }
      },
      hide_connection_info = true
    },
    impact_category = "metal",
    pictures = pipespicture(reinforcedpipetint,  "__factorioplus__/graphics/reinforced-pipe/"),
    working_sound = sounds.pipe,
    open_sound = sounds.metal_small_open,
    close_sound = sounds.metal_small_close,

    horizontal_window_bounding_box = {{-0.25, -0.28125}, {0.25, 0.15625}},
    vertical_window_bounding_box = {{-0.28125, -0.5}, {0.03125, 0.125}}
  },
  
  {
    type = "pipe-to-ground",
    name = "pipe-to-ground-reinforced",
	icons = { {icon = "__base__/graphics/icons/pipe-to-ground.png", tint = reinforcedpipetint} }, 
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "pipe-to-ground"},
    max_health = 500,
    corpse = "pipe-to-ground-remnants",
    dying_explosion = "pipe-to-ground-explosion",
    -- factoriopedia_simulation = simulations.factoriopedia_pipe_to_ground,
    icon_draw_specification = {scale = 0.5},
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      },
	  {
        type = "physical",
        percent = 40
      },
	  {
        type = "explosion",
        percent = 40
      }

    },
    fast_replaceable_group = "pipe",
    collision_box = {{-0.29, -0.29}, {0.29, 0.2}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    fluid_box =
    {
      volume = 200,
      pipe_covers = pipecoverspictures(),
      pipe_connections =
      {
        { direction = defines.direction.north, position = {0, 0} },
        {
          connection_type = "underground",
          direction = defines.direction.south,
          position = {0, 0},
          max_underground_distance = reinforcedpipe_distance
        }
      },
      hide_connection_info = true
    },
    impact_category = "metal",
    working_sound = sounds.pipe,
    open_sound = sounds.metal_small_open,
    close_sound = sounds.metal_small_close,
    pictures =
    {
      north =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-up.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5,
		tint = reinforcedpipetint
      },
      south =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-down.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5,
		tint = reinforcedpipetint
      },
      west =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-left.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5,
		tint = reinforcedpipetint
      },
      east =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/pipe-to-ground-right.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        scale = 0.5,
		tint = reinforcedpipetint
      }
    },
    visualization =
    {
      north =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 64,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      south =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 192,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      west =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 256,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      east =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
        priority = "extra-high",
        x = 128,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
    },
    disabled_visualization =
    {
      north =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 64,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      south =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 192,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      west =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 256,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
      east =
      {
        filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
        priority = "extra-high",
        x = 128,
        size = 64,
        scale = 0.5,
        flags = {"icon"}
      },
    },
  },
  
})


  
  --------------------------------------------------- F+ ICON ------------------------------------------------------------
 
-- replace logos
 
if (mods["space-age"]) then
	data.raw["container"]["factorio-logo-11tiles"].picture.filename = "__factorioplus__/graphics/icons/factorioplus-space-age-logo-11tiles.png"
else 
	data.raw["container"]["factorio-logo-11tiles"].picture.filename = "__factorioplus__/graphics/icons/factorioplus-logo-11tiles.png"
end 
  
data.extend({
  {
    type = "container",
    name = "factorioplus-logo",
    icon = "__factorioplus__/graphics/icons/factorioplus-logo.png",
    flags = {"placeable-neutral", "player-creation"},
    --hidden = true,
    minable = {mining_time = 0.1},
    max_health = 100,
    collision_box = {{-3, -3}, {3, 3}},
    selection_box = {{-3, -3}, {3, 3}},
    inventory_size = 1,
    picture =
    {
	 layers =
      {
        {
           filename = "__factorioplus__/graphics/icon_mod.png",
		  priority = "very-low",
		  width = 256,
		  height = 217,
		  shift = util.by_pixel(0, 0),
		  scale = 0.5,
        },
        {
           filename = "__factorioplus__/graphics/icon_mod_shadow.png",
		  priority = "very-low",
		  width = 256,
		  height = 217,
		  shift = util.by_pixel(0, 0),
		  scale = 0.5,
          draw_as_shadow = true,
        }
      }
     
    },
    resistances =
    {
      {
        type = "fire",
        decrease = 0,
        percent = 99
      },
      {
        type = "physical",
        decrease = 0,
        percent = 99
      },
      {
        type = "impact",
        decrease = 0,
        percent = 99
      },
      {
        type = "explosion",
        decrease = 0,
        percent = 99
      },
      {
        type = "acid",
        decrease = 0,
        percent = 99
      },
      {
        type = "laser",
        decrease = 0,
        percent = 99
      },
      {
        type = "electric",
        decrease = 0,
        percent = 99
      },
    },
  },
  
  {
    type = "item",
    name = "factorioplus-logo",
    icon = "__factorioplus__/graphics/icons/factorioplus-logo.png",
    icon_size = 64, icon_mipmaps = 4,
	place_result = "factorioplus-logo",
    stack_size = 1
  },
  
})

  