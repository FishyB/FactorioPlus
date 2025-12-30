local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local movement_triggers = require("__factorioplus__.movement_triggers")

local tank_shift_y = 6
local flametank_shift_y = 6

require ("__factorioplus__.util-attack-helpers")
require("stats")

data.raw["spider-vehicle"]["spidertron"].chain_shooting_cooldown_modifier  = 0.25

local rsa = 0.02

local standard_train_wheels =
{
  rotated = util.sprite_load("__base__/graphics/entity/train-wheel/train-wheel",
    {
      priority = "very-low",
      direction_count = 256,
      scale = 0.5,
      shift = util.by_pixel(0, 8),
      usage = "train"
    }
  )
}

local locomotive_reflection = function()
  return
  {
    pictures =
    {
      filename = "__base__/graphics/entity/locomotive/reflection/locomotive-reflection.png",
      priority = "extra-high",
      width = 20,
      height = 52,
      shift = util.by_pixel(0, 40),
      variation_count = 1,
      scale = 5
    },
    rotate = true,
    orientation_to_variation = false
  }
end

local drive_over_tie = function()
  return
  {
    type = "play-sound",
    sound = sound_variations("__base__/sound/train-tie", 6, 0.4, { volume_multiplier("main-menu", 2.4), volume_multiplier("driving", 1.3) } )
  }
end

local rolling_stock_back_light = function()
  return
  {
    {
      minimum_darkness = 0.3,
      color = {1, 0.1, 0.05, 0},
      shift = {-0.6, 3.5},
      size = 2,
      intensity = 0.6,
      add_perspective = true
    },
    {
      minimum_darkness = 0.3,
      color = {1, 0.1, 0.05, 0},
      shift = {0.6, 3.5},
      size = 2,
      intensity = 0.6,
      add_perspective = true
    }
  }
end

local rolling_stock_stand_by_light = function()
  return
  {
    {
      minimum_darkness = 0.3,
      color = {0.05, 0.2, 1, 0},
      shift = {-0.6, -3.5},
      size = 2,
      intensity = 0.5,
      add_perspective = true
    },
    {
      minimum_darkness = 0.3,
      color = {0.05, 0.2, 1, 0},
      shift = {0.6, -3.5},
      size = 2,
      intensity = 0.5,
      add_perspective = true
    }
  }
end

local speeder_scale = 0.425

----------------------------------------------------------  SPEEDER  ----------------------------------------------------------
-- CAR FAST YES, GUN CAR NO

data:extend({
{
    type = "car",
    name = "scout",
    icon = "__factorioplus__/graphics/icons/speeder.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.4, result = "scout"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = speeder_health ,
    corpse = "car-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = speeder_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    resistances = speeder_resistances,
    collision_box = {{-0.5, -0.8}, {0.5, 0.8}},
    selection_box = {{-0.5, -0.8}, {0.5, 0.8}},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = speeder_effectivity,
    braking_power = speeder_braking,
	rotation_snap_angle = rsa,

    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 200,
          position = {0, 1.5},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = speeder_consumption,
    friction = speeder_friction,
    light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 1.5,
          width = 200,
          height = 200
        },
        shift = {0.4, -11},
        size = 2,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
	   {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 1.5,
          width = 200,
          height = 200
        },
        shift = {-0.4, -11},
        size = 2,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
    },
    render_layer = "object",
    animation =
    {
      layers =
      {
	 
        {
		  filename = "__factorioplus__/graphics/vehicles/speeder.png",
          priority = "low",
          width = 1800/8,
          height = 1744/8,
		  scale = 1 * speeder_scale,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
			  {
		  filename = "__factorioplus__/graphics/vehicles/speeder-mask.png",
          priority = "low",
		   
          width = 1800/8,
          height = 1744/8,
		  scale = 1 * speeder_scale,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  flags = { "mask" },
		  apply_runtime_tint = true,
		  
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
        },
  
		{
		  filename = "__factorioplus__/graphics/vehicles/speeder-shadow.png",
          priority = "low",
          width = 1800/8,
          height = 1744/8,
		  scale = 1.4 * speeder_scale,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  draw_as_shadow = true,
          shift = util.by_pixel(-0, -6),
          animation_speed = 8,
          max_advance = 0.2,
        },
      }
    },  
	
	light_animation =
    {
      filename = "__factorioplus__/graphics/vehicles/speeder-lights.png",
      priority = "low",
      blend_mode = "additive",
      draw_as_glow = true,
      width = 1800/8,
	  height = 1744/8,
      line_length = 8,
      direction_count = 64,
      scale = 1 * speeder_scale,
      shift = {0, 0},
      -- repeat_count = 2,
    },
	
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.6,
		speed = 1.5,
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.25,
    sound_scaling_ratio = 1.2,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.67,
		speed = 1.5,
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.67,
		speed = 1.5,
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.67,
		speed = 1.5,
      },
      match_speed_to_activity = true
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.4 },
    rotation_speed = speeder_turnrate,
    weight = speeder_weight,
    inventory_size = speeder_inventory_size,
    track_particle_triggers = movement_triggers_4wd(0.5, 0.8),
    water_reflection = car_reflection(1),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/speeder-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
  },
 })
 
 
local scale_transporter = 0.5
 
 data.extend({
-----------------------------  TRANSPORTER  -----------------------------
  -- SLOW CAR WITH LARGE TRUNK
{
    type = "car",
    name = "transporter",
    icon = "__factorioplus__/graphics/icons/transporter.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.75, result = "transporter"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = truck_health,
    corpse = "car-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = truck_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    resistances = truck_resistances,
    collision_box = {{-1.2, -2.0}, {1.2, 2.0}},
    selection_box = {{-1.2, -2.0}, {1.2, 2.0}},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = truck_effectivity,
    braking_power = truck_braking,
	rotation_snap_angle = rsa,
	trash_inventory_size = 40,

   energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 2,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 200,
          position = {0, 2},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = truck_consumption,
    friction = truck_friction,
    light =
    {
	
	-- FRONT LIGHT
	 {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {-1.1, -25},
        size = 2.5,
        intensity = 0.9,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {1.1, -25},
        size = 2.5,
        intensity = 0.9,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
	
	-- ROOF RACK LIGHT
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {-1.25, -19},
        size = 3,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
	   {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {0, -19},
        size = 3,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {1.25, -19},
        size = 3,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      }
    },
    render_layer = "object",
	 light_animation =
    {
		filename = "__factorioplus__/graphics/vehicles/transporter-lights.png",
		priority = "low",
		blend_mode = "additive",
		draw_as_glow = true,
		width = 2400/8,
		height = 2320/8,
		line_length = 8,
		direction_count = 64,
		scale = scale_transporter,
		shift = util.by_pixel(0,0),
		--repeat_count = 2,
    },
    animation =
    {
      layers =
      {
        {
		  filename = "__factorioplus__/graphics/vehicles/transporter.png",
          priority = "low",
          width = 2400/8,
			height = 2320/8,
		  scale = scale_transporter,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		 {
		  filename = "__factorioplus__/graphics/vehicles/transporter-mask.png",
          priority = "low",
          width = 2400/8,
		height = 2320/8,
		  scale = scale_transporter,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  flags = { "mask" },
		  apply_runtime_tint = true,
		  
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		{
		  filename = "__factorioplus__/graphics/vehicles/transporter.png",
          priority = "low",
         width = 2400/8,
		height = 2320/8,
		  scale = scale_transporter,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  draw_as_shadow = true,
          shift = {0.3, 0.05},
          animation_speed = 8,
          max_advance = 0.2,
        },
      }
	  
    },
   
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.7
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.1,
    sound_scaling_ratio = 0.5,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      match_speed_to_activity = true
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.4 },
    rotation_speed = truck_turnrate,
    weight = truck_weight,
    inventory_size = truck_inventory_size,
    track_particle_triggers = movement_triggers.car,
    water_reflection = car_reflection(1),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/truck-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
  },
-----------------------------  DOZER -----------------------------
-- ITS A BULLDOZER
{
    type = "car",
    name = "dozer",
    icon = "__factorioplus__/graphics/icons/dozer.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 1.25, result = "dozer"},
    mined_sound = {filename = "__core__/sound/deconstruct-large.ogg",volume = 0.8},
    max_health = 1500,
    corpse = "tank-remnants",
    dying_explosion = "tank-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    immune_to_tree_impacts = true,
    immune_to_rock_impacts = true,
    energy_per_hit_point = 0.025,
	has_belt_immunity = true,
    resistances =
    {
      {
        type = "fire",
        decrease = 15,
        percent = 40
      },
      {
        type = "physical",
        decrease = 15,
        percent = 75
      },
      {
        type = "impact",
        decrease = 60,
        percent = 98
      },
      {
        type = "explosion",
        decrease = 15,
        percent = 30
      },
      {
        type = "acid",
        decrease = 0,
        percent = 30
      }
    },
    collision_box = {{-2.1, -3.4}, {2.1, 3.4}},
    selection_box = {{-2.15, -3.45}, {2.15, 3.45}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box = {{-1.8, -1.8}, {1.8, 1.5}},
    effectivity = 0.7,
    braking_power = "2100kW",
	rotation_snap_angle = rsa,
	
    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 2,
      smoke =
      {
        {
          name = "tank-smoke",
          deviation = {0.25, 0.25},
          frequency = 50,
          position = {0, 1.5},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = "1800kW",
    terrain_friction_modifier = 0.25,
    friction = 0.007,
    light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {-0.6, -14 + tank_shift_y / 32},
        size = 2,
        intensity = 0.6,
        color = {r = 0.9, g = 1.0, b = 1.0}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {0.6, -14 + tank_shift_y / 32},
        size = 2,
        intensity = 0.6,
        color = {r = 0.9, g = 1.0, b = 1.0}
      }
    },
    
	animation =
    {
      layers =
      {
        {
		  filename = "__factorioplus__/graphics/vehicles/dozer.png",
          priority = "low",
          width = 4768/16,
          height = 2120/8,
		  scale = 1.0,
		  
         direction_count = 64,
		 frame_count = 2,
		 line_length = 16,
		  
          shift = {0, 0.1},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
				 {
		  filename = "__factorioplus__/graphics/vehicles/dozer-mask.png",
          priority = "low",
          width = 4768/16,
          height = 2120/8,
		  scale = 1.0,
		  
         direction_count = 64,
		frame_count = 2,
		line_length = 16,
		  
		  flags = { "mask" },
		  apply_runtime_tint = true,
		  
          shift = {0, 0.1},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		{
		  filename = "__factorioplus__/graphics/vehicles/dozer.png",
          priority = "low",
          width = 4768/16,
          height = 2120/8,
		  scale = 1.0,
		  
         direction_count = 64,
		frame_count = 2,
		line_length = 16,
		  
		  draw_as_shadow = true,
          shift = {0.3, 0.1},
          animation_speed = 8,
          max_advance = 0.2,
        },
      }
	  
    },
	
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/tank-no-fuel-1.ogg",
        volume = 0.4
      }
    },
    sound_minimum_speed = 0.1,
    sound_scaling_ratio = 0.25,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/fight/tank-engine.ogg",
        volume = 0.6
      },
      activate_sound =
      {
        filename = "__base__/sound/fight/tank-engine-start.ogg",
        volume = 0.6
      },
      deactivate_sound =
      {
        filename = "__base__/sound/fight/tank-engine-stop.ogg",
        volume = 0.6
      },
      match_speed_to_activity = true
    },
    stop_trigger_speed = 0.1,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/fight/tank-brakes.ogg",
            volume = 0.5
          }
        }
      }
    },
    open_sound = { filename = "__base__/sound/fight/tank-door-open.ogg", volume=0.48 },
    close_sound = { filename = "__base__/sound/fight/tank-door-close.ogg", volume = 0.43 },
    rotation_speed = 0.0025,
    tank_driving = true,
    weight = 25000,
    inventory_size = 4,
    track_particle_triggers = movement_triggers.tank,
    water_reflection = car_reflection(1.2),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/dozer-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
  },
  
  ---------------------------------------------------------- FLAME TANK  ----------------------------------------------------------
{
    type = "car",
    name = "flame-tank",
    icon = "__base__/graphics/icons/tank.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 1, result = "flame-tank"},
    mined_sound = {filename = "__core__/sound/deconstruct-large.ogg",volume = 0.8},
    max_health = flametank_health,
    corpse = "tank-remnants",
    dying_explosion = "tank-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    immune_to_tree_impacts = true,
    immune_to_rock_impacts = true,
    energy_per_hit_point = flametank_ephp,
	has_belt_immunity = true,
	equipment_grid = "small-equipment-grid",
	allow_remote_driving = true,
	trash_inventory_size = 10,
	
    resistances = flametank_resistances,
    collision_box = {{-0.9, -1.3}, {0.9, 1.3}},
    selection_box = {{-0.9, -1.3}, {0.9, 1.3}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box = {{-1.8, -1.8}, {1.8, 1.5}},
    effectivity = flametank_effectivity,
    braking_power = flametank_braking,
	rotation_snap_angle = rsa,
	
    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 2,
      smoke =
      {
        {
          name = "tank-smoke",
          deviation = {0.25, 0.25},
          frequency = 50,
          position = {0, 1.5},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = flametank_consumption,
    terrain_friction_modifier = flametank_friction_terrain_modifier,
    friction = flametank_friction,
    light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {-0.6, -14 + flametank_shift_y / 32},
        size = 2,
        intensity = 0.6,
        color = {r = 0.9, g = 1.0, b = 1.0}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {0.6, -14 + flametank_shift_y / 32},
        size = 2,
        intensity = 0.6,
        color = {r = 0.9, g = 1.0, b = 1.0}
      }
    },
     animation =
    {
      layers =
      {
        {
            priority = "low",
            width = 270,
            height = 212,
            frame_count = 2,
            direction_count = 64,
            shift = util.by_pixel(0, -16 + tank_shift_y),
            animation_speed = 8,
            max_advance = 1,
            stripes =
            {
              {
               filename = "__base__/graphics/entity/tank/tank-base-1.png",
               width_in_frames = 2,
               height_in_frames = 16
              },
              {
               filename = "__base__/graphics/entity/tank/tank-base-2.png",
               width_in_frames = 2,
               height_in_frames = 16
              },
              {
               filename = "__base__/graphics/entity/tank/tank-base-3.png",
               width_in_frames = 2,
               height_in_frames = 16
              },
              {
               filename = "__base__/graphics/entity/tank/tank-base-4.png",
               width_in_frames = 2,
               height_in_frames = 16
              }
            },
            scale = 0.5
          
        },
        {
		  
            priority = "low",
            width = 208,
            height = 166,
            frame_count = 2,
            apply_runtime_tint = true,
            direction_count = 64,
            shift = util.by_pixel(0, -27.5 + tank_shift_y),
            max_advance = 1,
            line_length = 2,
            stripes = util.multiplystripes(2,
            {
              {
                filename = "__base__/graphics/entity/tank/tank-base-mask-1.png",
                width_in_frames = 1,
                height_in_frames = 22
              },
              {
                filename = "__base__/graphics/entity/tank/tank-base-mask-2.png",
                width_in_frames = 1,
                height_in_frames = 22
              },
              {
                filename = "__base__/graphics/entity/tank/tank-base-mask-3.png",
                width_in_frames = 1,
                height_in_frames = 20
              }
            }),
            scale = 0.5
          
        },
        {
          
            priority = "low",
            width = 302,
            height = 194,
            frame_count = 2,
            draw_as_shadow = true,
            direction_count = 64,
            shift = util.by_pixel(22.5, 1 + tank_shift_y),
            max_advance = 1,
            stripes = util.multiplystripes(2,
            {
             {
              filename = "__base__/graphics/entity/tank/tank-base-shadow-1.png",
              width_in_frames = 1,
              height_in_frames = 16
             },
             {
              filename = "__base__/graphics/entity/tank/tank-base-shadow-2.png",
              width_in_frames = 1,
              height_in_frames = 16
             },
             {
              filename = "__base__/graphics/entity/tank/tank-base-shadow-3.png",
              width_in_frames = 1,
              height_in_frames = 16
             },
             {
              filename = "__base__/graphics/entity/tank/tank-base-shadow-4.png",
              width_in_frames = 1,
              height_in_frames = 16
             }
            }),
            scale = 0.5
          
		}
      }
    },
    turret_animation =
    {
      layers =
      {
        {
			filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-gun.png",
			priority = "low",
			counterclockwise = true,
			line_length = 8,
			width = 158,
			height = 126,
			frame_count = 1,
			axially_symmetrical = false,
			direction_count = 64,
			shift = util.by_pixel(2.25-2, -50.5 + flametank_shift_y),
			animation_speed = 8,
			scale = 0.5

        },
        {

			filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-gun-mask.png",
			flags = { "mask" },
			counterclockwise = true,
			line_length = 8,
			width = 144,
			height = 112,
			frame_count = 1,
			axially_symmetrical = false,
			apply_runtime_tint = true,
			direction_count = 64,
			shift = util.by_pixel(2-2, -51.5 + flametank_shift_y),
			scale = 0.5
          
        },
        {

			filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-gun-shadow.png",
			counterclockwise = true,
			line_length = 8,
			width = 182,
			height = 116,
			frame_count = 1,
			axially_symmetrical = false,
			draw_as_shadow = true,
			direction_count = 64,
			shift = util.by_pixel(58.25-2, 0.5 + flametank_shift_y),
			scale = 0.5
          
        }
      }
    },
    turret_rotation_speed = 1 / 60,
    turret_return_timeout = 300,
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/tank-no-fuel-1.ogg",
        volume = 0.4
      }
    },
    sound_minimum_speed = 0.2,
    sound_scaling_ratio = 0.8,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/fight/tank-engine.ogg",
        volume = 0.37
      },
      activate_sound =
      {
        filename = "__base__/sound/fight/tank-engine-start.ogg",
        volume = 0.37
      },
      deactivate_sound =
      {
        filename = "__base__/sound/fight/tank-engine-stop.ogg",
        volume = 0.37
      },
      match_speed_to_activity = true
    },
    stop_trigger_speed = 0.1,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/fight/tank-brakes.ogg",
            volume = 0.3
          }
        }
      }
    },
    open_sound = { filename = "__base__/sound/fight/tank-door-open.ogg", volume=0.48 },
    close_sound = { filename = "__base__/sound/fight/tank-door-close.ogg", volume = 0.43 },
    rotation_speed = flametank_turnrate,
    tank_driving = true,
    weight = flametank_weight,
    inventory_size = flametank_inventory_size,
    track_particle_triggers = movement_triggers.tank,
    guns = { "tank-flamethrower" },
    water_reflection = car_reflection(1.2),
	
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/tank-flame-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
	
  },
  
})

-----------------------------  VEHICLE OVERRIDES  -----------------------------

data.raw["car"]["car"].track_particle_triggers = movement_triggers.car
data.raw["car"]["car"].has_belt_immunity = true
data.raw["car"]["tank"].track_particle_triggers = movement_triggers.tank
data.raw["car"]["tank"].has_belt_immunity = true

----------------------------------------------------------  OVERRIDES  ----------------------------------------------------------

---------------------------------------------------------- ATTACK CAR  ----------------------------------------------------------
local car_animations =
{
      layers =
      {
        {
            priority = "low",
            width = 201,
            height = 172,
            frame_count = 2,
            scale = 0.5,
            direction_count = 64,
            shift = util.by_pixel(0+2, -11.5+8.5),
            animation_speed = 8,
            max_advance = 0.2,
            stripes =
            {
              {
                filename = "__base__/graphics/entity/car/car-1.png",
                width_in_frames = 2,
                height_in_frames = 11
              },
              {
                filename = "__base__/graphics/entity/car/car-2.png",
                width_in_frames = 2,
                height_in_frames = 11
              },
              {
                filename = "__base__/graphics/entity/car/car-3.png",
                width_in_frames = 2,
                height_in_frames = 11
              },
              {
                filename = "__base__/graphics/entity/car/car-4.png",
                width_in_frames = 2,
                height_in_frames = 11
              },
              {
                filename = "__base__/graphics/entity/car/car-5.png",
                width_in_frames = 2,
                height_in_frames = 11
              },
              {
                filename = "__base__/graphics/entity/car/car-6.png",
                width_in_frames = 2,
                height_in_frames = 9
              }
            }
          
        },
        {
        
            priority = "low",
            width = 199,
            height = 147,
            frame_count = 2,
            apply_runtime_tint = true,
            scale = 0.5,
            axially_symmetrical = false,
            direction_count = 64,
            max_advance = 0.2,
            shift = util.by_pixel(0+2, -11+8.5),
            line_length = 1,
            stripes = util.multiplystripes(2,
            {
              {
                filename = "__base__/graphics/entity/car/car-mask-1.png",
                width_in_frames = 1,
                height_in_frames = 13
              },
              {
                filename = "__base__/graphics/entity/car/car-mask-2.png",
                width_in_frames = 1,
                height_in_frames = 13
              },
              {
                filename = "__base__/graphics/entity/car/car-mask-3.png",
                width_in_frames = 1,
                height_in_frames = 13
              },
              {
                filename = "__base__/graphics/entity/car/car-mask-4.png",
                width_in_frames = 1,
                height_in_frames = 13
              },
              {
                filename = "__base__/graphics/entity/car/car-mask-5.png",
                width_in_frames = 1,
                height_in_frames = 12
              }
            })
          
        },
        {
          priority = "low",
          width = 114,
          height = 76,
          frame_count = 2,
          draw_as_shadow = true,
          direction_count = 64,
          shift = {0.28125, 0.25},
          max_advance = 0.2,
          stripes = util.multiplystripes(2,
          {
            {
              filename = "__base__/graphics/entity/car/car-shadow-1.png",
              width_in_frames = 1,
              height_in_frames = 22
            },
            {
              filename = "__base__/graphics/entity/car/car-shadow-2.png",
              width_in_frames = 1,
              height_in_frames = 22
            },
            {
              filename = "__base__/graphics/entity/car/car-shadow-3.png",
              width_in_frames = 1,
              height_in_frames = 20
            }
          })
        }
      }
    }

local gun_turret_scale = 0.5
local gun_turret_xy = {912/8, 832/8}
local gun_turret_shift_xy = {0, -25 }
local gun_turret_drone_shift_xy = {0, -8}

data:extend({
----------------------------------------------------------  SIMPLE CAR  ----------------------------------------------------------
{
    type = "car",
    name = "car-base",
    icon = "__base__/graphics/icons/car.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.4, result = "car-base"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = car_health,
    corpse = "car-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = car_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    resistances = car_resistances,
    collision_box = {{-0.7, -1}, {0.7, 1}},
    selection_box = {{-0.7, -1}, {0.7, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = car_effectivity,
    braking_power = car_braking,
	rotation_snap_angle = rsa,

    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 200,
          position = {0, 1.5},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = car_consumption,
    friction = car_friction,
    light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {-0.6, -14},
        size = 2,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {0.6, -14},
        size = 2,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      }
    },
    render_layer = "object",
    animation =car_animations,
    
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.6
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.25,
    sound_scaling_ratio = 0.8,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.67
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.67
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.67
      },
      match_speed_to_activity = true
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.4 },
    rotation_speed = car_turnrate,
    weight = car_weight,
    inventory_size = car_inventory_size,
    track_particle_triggers = movement_triggers.car,
    water_reflection = car_reflection(1)
  },

{
    type = "car",
    name = "car",
    icon = "__base__/graphics/icons/car.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.4, result = "car"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = car_health,
    corpse = "car-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = car_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    resistances = car_resistances,
    collision_box = {{-0.7, -1}, {0.7, 1}},
    selection_box = {{-0.7, -1}, {0.7, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = car_effectivity,
    braking_power = car_braking,
	rotation_snap_angle = rsa,

   energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 200,
          position = {0, 1.5},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = car_consumption,
    friction = car_friction,
    light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {-0.6, -14},
        size = 2,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {0.6, -14},
        size = 2,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      }
    },
    render_layer = "object",
    animation = car_animations,
	
	turret_rotation_speed = 0.75 / 60,
	guns = { "vehicle-machine-gun" },
    turret_animation =
    {
      layers =
      {
		{
          filename = "__factorioplus__/graphics/smg-turret/smg-turret.png",
          priority = "low",
          line_length = 8,
			width = gun_turret_xy[1],
			height = gun_turret_xy[2],
          frame_count = 1,
          direction_count = 64,
          shift = util.by_pixel(table.unpack(gun_turret_shift_xy) ),
          animation_speed = 8,
		  scale = gun_turret_scale,
		},
		{
		  filename ="__factorioplus__/graphics/smg-turret/smg-turret-mask.png",
		  flags = { "mask" },
			width = gun_turret_xy[1],
			height = gun_turret_xy[2],
		  direction_count = 64,
		  frame_count = 1,
		  line_length = 8,
		  run_mode =  "forward",
		  shift = util.by_pixel(table.unpack(gun_turret_shift_xy) ),
		  axially_symmetrical = false,
		  apply_runtime_tint = true,
		  scale =  gun_turret_scale,
		},
        {
          filename = "__base__/graphics/entity/car/car-turret-shadow.png",
          priority = "low",
          line_length = 8,
          width = 46,
          height = 31,
          frame_count = 1,
          draw_as_shadow = true,
          direction_count = 64,
          shift = {0.875, 0.359375}
        }
      }
    },

    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.6
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.25,
    sound_scaling_ratio = 0.8,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.67
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.67
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.67
      },
      match_speed_to_activity = true
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.4 },
    rotation_speed = car_turnrate,
    weight = car_weight,
    
    inventory_size = car_inventory_size,
    track_particle_triggers = movement_triggers.car,
    water_reflection = car_reflection(1)
  },
  
  ---------------------------------------------------------- SHOTGUN CAR  ----------------------------------------------------------
{
    type = "car",
    name = "car-shotgun",
    icon = "__base__/graphics/icons/car.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.4, result = "car-shotgun"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = car_health,
    corpse = "car-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = car_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    resistances = car_resistances,
    collision_box = {{-0.7, -1}, {0.7, 1}},
    selection_box = {{-0.7, -1}, {0.7, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = car_effectivity,
    braking_power = car_braking,
	rotation_snap_angle = rsa,

   energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 200,
          position = {0, 1.5},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = car_consumption,
    friction = car_friction,
    light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {-0.6, -14},
        size = 2,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {0.6, -14},
        size = 2,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      }
    },
    render_layer = "object",
    animation = car_animations,
    turret_animation =
    {
      layers =
      {
		{
			filename = "__factorioplus__/graphics/shotgun-turret/shotgun-turret.png",
			priority = "medium",
			width = 1328/8,
			height = 1208/8,
			direction_count = 64,
			frame_count = 1,
			line_length = 8,
			shift = util.by_pixel(0, -24 ),
			axially_symmetrical = false,
			scale =  0.4,
		},
        {
			filename = "__factorioplus__/graphics/shotgun-turret/shotgun-turret-mask.png",
			flags = { "mask" },
			width = 1328/8,
			height = 1208/8,
			direction_count = 64,
			frame_count = 1,
			line_length = 8,
			shift = util.by_pixel(0, -24 ),
			axially_symmetrical = false,
			apply_runtime_tint = true,
			scale =  0.4,
		},		
        {
			filename = "__factorioplus__/graphics/shotgun-turret/shotgun-turret-shadow.png",
			priority = "low",
			line_length = 8,
			width = 1328/8,
			height = 1208/8,
			frame_count = 1,
			draw_as_shadow = true,
			direction_count = 64,
			scale =  0.4,
			shift = {0.875, 0.359375}
        }
      }
    },
    turret_rotation_speed = 1 / 60,
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.6
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.25,
    sound_scaling_ratio = 0.8,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.67
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.67
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.67
      },
      match_speed_to_activity = true
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.4 },
    rotation_speed = car_turnrate,
    weight = car_weight,
    guns = { "shotgun-veh" },
    inventory_size = car_inventory_size,
    track_particle_triggers = movement_triggers.car,
    water_reflection = car_reflection(1)
  },
 
-----------------------------  ATV  -----------------------------
  -- early puttering around vehicle
{
    type = "car",
    name = "atv",
    icon = "__factorioplus__/graphics/icons/atv.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.4, result = "atv"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = atv_health,
	resistances = atv_resistances,
    corpse = "car-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = atv_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    collision_box = {{-0.6, -0.75}, {0.6, 0.75}},
    selection_box = {{-0.8, -1.0}, {0.8, 1.0}},
	--collision_mask = {"consider-tile-transitions","object-layer"},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = atv_effectivity,
    braking_power = atv_braking,
	rotation_snap_angle = rsa,

    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 100,
          position = {0, 1},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = atv_consumption,
    friction = atv_friction,
    light =
    {
	
	-- FRONT LIGHT
	 {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 1,
          width = 200,
          height = 200
        },
        shift = {-0.5, -8},
        size = 2.0,
        intensity = 0.7,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 1,
          width = 200,
          height = 200
        },
        shift = {0.5, -8},
        size = 2.0,
        intensity = 0.7,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
    },
    render_layer = "object",
	
	 light_animation =
    {
		filename = "__factorioplus__/graphics/vehicles/atv-lights.png",
		priority = "low",
		width = 1448/8,
		height = 1392/8,
		scale = 0.55,
		blend_mode = "additive",
		draw_as_glow = true,
		line_length = 8,
		direction_count = 64,
		shift = util.by_pixel(0,0),
		--repeat_count = 2,
    },
    animation =
    {
      layers =
      {
        {
		  filename = "__factorioplus__/graphics/vehicles/atv.png",
          priority = "low",
          width = 1448/8,
          height = 1392/8,
		  scale = 0.55,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = {0, 0.0},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		 {
		  filename = "__factorioplus__/graphics/vehicles/atv-mask.png",
          priority = "low",
			width = 1448/8,
          height = 1392/8,
		  scale = 0.55,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  flags = { "mask" },
		  apply_runtime_tint = true,
		  
          shift = {0, 0.0},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		{
		  filename = "__factorioplus__/graphics/vehicles/atv.png",
          priority = "low",
          width = 1448/8,
          height = 1392/8,
		  scale = 0.55,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  draw_as_shadow = true,
          shift = {0.2, 0.0},
          animation_speed = 8,
          max_advance = 0.2,
        },
      }
	  
    },
   
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.7,
		1.25,
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.1,
    sound_scaling_ratio = 0.5,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.5,
		speed = 1.25,
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.5,
		speed = 1.25,
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.5,
		speed = 1.25,
      },
      match_speed_to_activity = true
    },
    rotation_speed = atv_turnrate,
    weight = atv_weight,
    inventory_size = atv_inventory_size,
	
    track_particle_triggers = movement_triggers_4wd(0.5, 0.7),
    water_reflection = car_reflection(1),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/atv-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
	
	-- guns = {"vehicle-horn-small"},
 },

-----------------------------  ATV DRONE -----------------------------
  -- remote attack vehicle thing
{
    type = "car",
    name = "atv-drone",
    icon = "__factorioplus__/graphics/icons/atv.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.4, result = "atv-drone"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = atv_health * 1.5,
	hidden = true,
	resistances = atv_resistances,
    corpse = "small-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = atv_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    collision_box = {{-0.6, -0.75}, {0.6, 0.75}},
    selection_box = {{-0.8, -1.0}, {0.8, 1.0}},
	--collision_mask = {"consider-tile-transitions","object-layer"},
	
	allow_remote_driving = true,
	allow_passengers = false,
	chunk_exploration_radius = 3,
	is_military_target = true,
	
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = atv_effectivity,
    braking_power = atv_braking,
	rotation_snap_angle = rsa,

    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 100,
          position = {0, 1},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = atv_consumption,
    friction = atv_friction,
    light =
    {
	
	-- FRONT LIGHT
	 {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 1,
          width = 200,
          height = 200
        },
        shift = {-1.1, -10},
        size = 2.5,
        intensity = 0.9,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 1,
          width = 200,
          height = 200
        },
        shift = {1.1, -10},
        size = 2.5,
        intensity = 0.9,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
    },
    render_layer = "object",
    animation =
    {
      layers =
      {
        {
		  filename = "__factorioplus__/graphics/vehicles/atv_drone_base.png",
          priority = "low",
          width = 146,
          height = 144,
		  scale = 0.5,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = {0, 0.2},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		 {
		  filename = "__factorioplus__/graphics/vehicles/atv_drone_mask.png",
          priority = "low",
          width = 146,
          height = 144,
		  scale = 0.5,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  flags = { "mask" },
		  apply_runtime_tint = true,
		  
          shift = {0, 0.2},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		{
		  filename = "__factorioplus__/graphics/vehicles/atv_drone_base.png",
          priority = "low",
          width = 146,
          height = 144,
		  scale = 0.5,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  draw_as_shadow = true,
          shift = {0.2, 0.2},
          animation_speed = 8,
          max_advance = 0.2,
        },
      }
	  
    },
	
	turret_rotation_speed = 0.75 / 60,
	guns = { "vehicle-machine-gun" },
    turret_animation =
    {
      layers =
      {
		{
          filename = "__factorioplus__/graphics/smg-turret/smg-turret.png",
          priority = "low",
          line_length = 8,
			width = gun_turret_xy[1],
			height = gun_turret_xy[2],
          frame_count = 1,
          direction_count = 64,
          shift = util.by_pixel(table.unpack(gun_turret_drone_shift_xy) ),
          animation_speed = 8,
		  scale = gun_turret_scale,
		},
		{
		  filename ="__factorioplus__/graphics/smg-turret/smg-turret-mask.png",
		  flags = { "mask" },
			width = gun_turret_xy[1],
			height = gun_turret_xy[2],
		  direction_count = 64,
		  frame_count = 1,
		  line_length = 8,
		  run_mode =  "forward",
		  shift = util.by_pixel(table.unpack(gun_turret_drone_shift_xy) ),
		  axially_symmetrical = false,
		  apply_runtime_tint = true,
		  scale =  gun_turret_scale,
		},
        {
          filename = "__base__/graphics/entity/car/car-turret-shadow.png",
          priority = "low",
          line_length = 8,
          width = 46,
          height = 31,
          frame_count = 1,
          draw_as_shadow = true,
          direction_count = 64,
          shift = {0.875, 0.359375}
        }
      }
    },
   
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.7,
		1.25,
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.1,
    sound_scaling_ratio = 0.5,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.5,
		speed = 1.25,
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.5,
		speed = 1.25,
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.5,
		speed = 1.25,
      },
      match_speed_to_activity = true
    },
    rotation_speed = atv_turnrate,
    weight = atv_weight,
    inventory_size = atv_inventory_size,
	
    track_particle_triggers = movement_triggers_4wd(0.5, 0.7),
    water_reflection = car_reflection(1),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/atv-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
 },
 
 -----------------------------  ATV BOOM  -----------------------------
  -- early puttering around vehicle
  
{
    type = "car",
    name = "atv-exploding",
    icon = "__factorioplus__/graphics/icons/atv.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.4, result = "atv-exploding"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = atv_health,
	resistances = atv_resistances,
    corpse = "car-remnants",
	hidden = true,
	dying_trigger_effect = 
	{
		{
			type = "nested-result",
			action =
			{
				{
					type = "area",
					radius = 12,
					action_delivery =
					{
						type = "instant",
						target_effects =
						{
						type = "damage",
						damage = { amount = 150, type = "explosion"}
						},
					},
				},
				{
					type = "area",
					radius = 7,
					action_delivery =
					{
						type = "instant",
						target_effects =
						{
						type = "damage",
						damage = { amount = 150, type = "explosion"}
						},
					},
				},
				{
					type = "area",
					radius = 4,
					action_delivery =
					{
						type = "instant",
						target_effects =
						{
						type = "damage",
						damage = { amount = 150, type = "explosion"}
						},
					},
				},
			},

		},
	},
    dying_explosion = "massive-explosion",
	is_military_target = true,
	
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = atv_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    collision_box = {{-0.6, -0.75}, {0.6, 0.75}},
    selection_box = {{-0.8, -1.0}, {0.8, 1.0}},
	--collision_mask = {"consider-tile-transitions","object-layer"},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = atv_effectivity,
    braking_power = atv_braking,
	rotation_snap_angle = rsa,

    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 100,
          position = {0, 1},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = atv_consumption,
    friction = atv_friction,
    light =
    {
	
	-- FRONT LIGHT
	 {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 1,
          width = 200,
          height = 200
        },
        shift = {-1.1, -10},
        size = 2.5,
        intensity = 0.9,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 1,
          width = 200,
          height = 200
        },
        shift = {1.1, -10},
        size = 2.5,
        intensity = 0.9,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
    },
    render_layer = "object",
     animation =
    {
      layers =
      {
        {
		  filename = "__factorioplus__/graphics/vehicles/atv.png",
          priority = "low",
          width = 1448/8,
          height = 1392/8,
		  scale = 0.55,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = {0, 0.2},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		 {
		  filename = "__factorioplus__/graphics/vehicles/atv-mask.png",
          priority = "low",
			width = 1448/8,
          height = 1392/8,
		  scale = 0.55,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  flags = { "mask" },
		  apply_runtime_tint = true,
		  
          shift = {0, 0.2},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		{
		  filename = "__factorioplus__/graphics/vehicles/atv.png",
          priority = "low",
          width = 1448/8,
          height = 1392/8,
		  scale = 0.55,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  draw_as_shadow = true,
          shift = {0.2, 0.2},
          animation_speed = 8,
          max_advance = 0.2,
        },
      }
	  
    },
   
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.7,
		1.25,
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.1,
    sound_scaling_ratio = 0.5,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.5,
		speed = 1.25,
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.5,
		speed = 1.25,
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.5,
		speed = 1.25,
      },
      match_speed_to_activity = true
    },
    rotation_speed = atv_turnrate,
    weight = atv_weight,
    inventory_size = atv_inventory_size,
	
    track_particle_triggers = movement_triggers_4wd(0.5, 0.7),
    water_reflection = car_reflection(1),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/atv-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
 }, 
})

  -----------------------------  APC  -----------------------------
  -- Medium Car with armour and better weapons


local apc_xres = 3304/8
local apc_yres = 3032/8
local apc_y_shift = -28
local apc_scale = 0.35
local apc_x_shift_shadow = 8
local apc_y_shift_shadow = -24



local apc_images = function()
return
{ 
	layers =
	{
         {
		  filename = "__factorioplus__/graphics/vehicles/hr-apc.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(0, apc_y_shift),
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		 {
		  filename = "__factorioplus__/graphics/vehicles/hr-apc-mask.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
		  axially_symmetrical = false,
		  apply_runtime_tint = true,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(0, apc_y_shift),
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		{
		  filename = "__factorioplus__/graphics/vehicles/hr-apc.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(apc_x_shift_shadow, apc_y_shift_shadow),
          animation_speed = 8,
          max_advance = 0.2,
		  draw_as_shadow = true,
        },
    }
}	  
end


local apc_lights =
{
  {
	type = "oriented",
	minimum_darkness = 0.3,
	picture =
	{
	  filename = "__core__/graphics/light-cone.png",
	  priority = "extra-high",
	  flags = { "light" },
	  scale = 2,
	  width = 200,
	  height = 200
	},
	shift = {-0.6, -14},
	size = 2,
	intensity = 0.6,
	color = {0.92, 0.77, 0.3}
  },
  {
	type = "oriented",
	minimum_darkness = 0.3,
	picture =
	{
	  filename = "__core__/graphics/light-cone.png",
	  priority = "extra-high",
	  flags = { "light" },
	  scale = 2,
	  width = 200,
	  height = 200
	},
	shift = {0.6, -14},
	size = 2,
	intensity = 0.6,
	color = {0.92, 0.77, 0.3}
  }
}

data:extend({
{
    type = "car",
    name = "apc-base",
    icon = "__factorioplus__/graphics/icons/apc.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.6, result = "apc-base"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = apc_health,
    corpse = "car-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = apc_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
	guns = nil,
    resistances = apc_resistances,
    collision_box = {{-1.2, -2.75}, {1.2, 1.0}},
    selection_box = {{-1.2, -2.75}, {1.2, 1.0}},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = apc_effectivity,
    braking_power = apc_braking,
	equipment_grid = "small-equipment-grid",
	trash_inventory_size = 10,
	allow_passengers = true,
	terrain_friction_modifier = apc_friction_terrain_modifier,
	rotation_snap_angle = rsa,

   energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 200,
          position = {0, 2},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = apc_consumption,
    friction = apc_friction,
    light = apc_lights,
    render_layer = "object",
    animation =
    {
      layers =
      {
        {
		  filename = "__factorioplus__/graphics/vehicles/hr-apc.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(0, apc_y_shift),
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		 {
		  filename = "__factorioplus__/graphics/vehicles/hr-apc-mask.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
		  axially_symmetrical = false,
		  apply_runtime_tint = true,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(0, apc_y_shift),
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		{
		  filename = "__factorioplus__/graphics/vehicles/hr-apc.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  draw_as_shadow = true,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(apc_x_shift_shadow, apc_y_shift_shadow),
          animation_speed = 8,
          max_advance = 0.2,
        },
      }
	  
    },
   
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.7
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.1,
    sound_scaling_ratio = 0.5,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      match_speed_to_activity = true
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.4 },
    rotation_speed = apc_turnrate,
    weight = apc_weight,
    inventory_size = apc_inventory_size,
    track_particle_triggers = movement_triggers.car,
    water_reflection = car_reflection(1),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/halftrack-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
  },
  
  -----
  
  {
    type = "car",
    name = "apc-rocket",
    icon = "__factorioplus__/graphics/icons/apc.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.6, result = "apc-rocket"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = apc_health,
    corpse = "car-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = apc_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    resistances = apc_resistances,
    collision_box = {{-1.0, -2.3}, {1.0, 0.8}},
    selection_box = {{-1.2, -2.55}, {1.2, 1.0}},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = apc_effectivity,
    braking_power = apc_braking,
	allow_passengers = true,
	equipment_grid = "small-equipment-grid",
	trash_inventory_size = 10,
	allow_remote_driving = true,
	terrain_friction_modifier = apc_friction_terrain_modifier,
	rotation_snap_angle = rsa,

    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 200,
          position = {0, 2},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = apc_consumption,
    friction = apc_friction,
    light = apc_lights,
    render_layer = "object",
    animation =
    {
      layers =
      {
        {
		  filename = "__factorioplus__/graphics/vehicles/hr-apc.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(0, apc_y_shift),
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		 {
		  filename = "__factorioplus__/graphics/vehicles/hr-apc-mask.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
		  axially_symmetrical = false,
		  apply_runtime_tint = true,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(0, apc_y_shift),
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		{
		  filename = "__factorioplus__/graphics/vehicles/hr-apc.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(apc_x_shift_shadow, apc_y_shift_shadow),
          animation_speed = 8,
          max_advance = 0.2,
		  draw_as_shadow = true,
        },
      }
	  
    },
	turret_animation =
    {
      layers =
      {
        {
			filename = "__factorioplus__/graphics/rocket-turret/hr-rocket-turret.png",
			priority = "medium",
			width = 1824/8,
			height = 1720/8,
			direction_count = 64,
			frame_count = 1,
			line_length = 8,
			shift = util.by_pixel(0, -50),
			axially_symmetrical = false,
			scale =  0.4,
		},
        {
			  filename = "__factorioplus__/graphics/rocket-turret/hr-rocket-turret-mask.png",
			  flags = { "mask" },
			  width = 1824/8,
			height = 1720/8,
			  direction_count = 64,
			  frame_count = 1,
			  line_length = 8,
			  shift = util.by_pixel(0, -50),
			  axially_symmetrical = false,
			  apply_runtime_tint = true,
			scale =  0.4,
		},
      }
    },
    turret_rotation_speed = 0.35 / 60,
    turret_return_timeout = 300,
   
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.7
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.1,
    sound_scaling_ratio = 0.5,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      match_speed_to_activity = true
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.4 },
    rotation_speed = apc_turnrate,
    weight = apc_weight,
    inventory_size = apc_inventory_size,
	guns = { "rocket-launcher-veh", "rocket-launcher-veh"},
    track_particle_triggers = movement_triggers.car,
    water_reflection = car_reflection(1),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/halftrack-launcher-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
  },
})
  
  
  ----- TWIN SMG
  
 local twingun_turret_scale = 0.6
local twingun_turret_xy = {1216/8, 1112/8}
local twingun_turret_shift_xy = {0, -40 }


 data.extend({ 
  {
    type = "car",
    name = "apc-twinsmg",
    icon = "__factorioplus__/graphics/icons/apc.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.6, result = "apc-twinsmg"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = apc_health,
    corpse = "car-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = apc_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    resistances = apc_resistances,
    collision_box = {{-1.0, -2.3}, {1.0, 0.8}},
    selection_box = {{-1.2, -2.55}, {1.2, 1.0}},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = apc_effectivity,
    braking_power = apc_braking,
	allow_passengers = true,
	equipment_grid = "small-equipment-grid",
	trash_inventory_size = 10,
	allow_remote_driving = true,
	terrain_friction_modifier = apc_friction_terrain_modifier,
	rotation_snap_angle = rsa,

    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 200,
          position = {0, 2},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = apc_consumption,
    friction = apc_friction,
    light = apc_lights,
    render_layer = "object",
    animation =
    {
      layers =
      {
         {
		  filename = "__factorioplus__/graphics/vehicles/hr-apc.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(0, apc_y_shift),
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		 {
		  filename = "__factorioplus__/graphics/vehicles/hr-apc-mask.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
		  axially_symmetrical = false,
		  apply_runtime_tint = true,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(0, apc_y_shift),
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		{
		  filename = "__factorioplus__/graphics/vehicles/hr-apc.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
         shift = util.by_pixel(apc_x_shift_shadow, apc_y_shift_shadow),
          animation_speed = 8,
          max_advance = 0.2,
		  draw_as_shadow = true,
        },
      }
	  
    },
	turret_animation =
    {
      layers =
      {
		{
		filename = "__factorioplus__/graphics/smg-turret/smg-turret-heavy.png",
		priority = "medium",
		width = twingun_turret_xy[1],
		height = twingun_turret_xy[2],
		direction_count = 64,
		frame_count = 1,
		line_length = 8,
		run_mode =  "forward",
		shift = util.by_pixel(table.unpack(twingun_turret_shift_xy) ),
		axially_symmetrical = false,
		scale =  twingun_turret_scale,
		},
		{
		filename = "__factorioplus__/graphics/smg-turret/smg-turret-heavy-mask.png",
		flags = { "mask" },
		width = twingun_turret_xy[1],
		height = twingun_turret_xy[2],
		direction_count = 64,
		frame_count = 1,
		line_length = 8,
		run_mode =  "forward",
		shift = util.by_pixel(table.unpack(twingun_turret_shift_xy) ),
		axially_symmetrical = false,
		apply_runtime_tint = true,
		scale =  twingun_turret_scale,
		}
      }
    },
    turret_rotation_speed = 0.45 / 60,
    turret_return_timeout = 300,
   
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.7
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.1,
    sound_scaling_ratio = 0.5,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      match_speed_to_activity = true
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.4 },
    rotation_speed = apc_turnrate,
    weight = apc_weight,
    inventory_size = apc_inventory_size,
	guns = { "twin-smg", "twin-smg" },
    track_particle_triggers = movement_triggers.car,
    water_reflection = car_reflection(1),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/halftrack-twingun-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
  },
  
  ----- AUTOSHOTGUN
  
  
  {
    type = "car",
    name = "apc-autoshotgun",
    icon = "__factorioplus__/graphics/icons/apc.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.6, result = "apc-autoshotgun"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = apc_health,
    corpse = "car-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = apc_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    resistances = apc_resistances,
    collision_box = {{-1.0, -2.3}, {1.0, 0.8}},
    selection_box = {{-1.2, -2.55}, {1.2, 1.0}},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = apc_effectivity,
    braking_power = apc_braking,
	allow_passengers = true,
	equipment_grid = "small-equipment-grid",
		trash_inventory_size = 10,
		allow_remote_driving = true,
	terrain_friction_modifier = apc_friction_terrain_modifier,
	rotation_snap_angle = rsa,

   energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 200,
          position = {0, 2},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = apc_consumption,
    friction = apc_friction,
    light = apc_lights,
    render_layer = "object",
    animation =
    {
      layers =
      {
         {
		  filename = "__factorioplus__/graphics/vehicles/hr-apc.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(0, apc_y_shift),
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		 {
		  filename = "__factorioplus__/graphics/vehicles/hr-apc-mask.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
		  axially_symmetrical = false,
		  apply_runtime_tint = true,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(0, apc_y_shift),
          animation_speed = 8,
          max_advance = 0.2,
        },
		
		{
		  filename = "__factorioplus__/graphics/vehicles/hr-apc.png",
          priority = "low",
          width = apc_xres,
          height = apc_yres,
		  scale = apc_scale,
		  
         direction_count = 64,
		 frame_count = 1,
		 line_length = 8,
		  
          shift = util.by_pixel(apc_x_shift_shadow, apc_y_shift_shadow),
          animation_speed = 8,
          max_advance = 0.2,
		  draw_as_shadow = true,
        },
      }
	  
    },
	turret_animation =
    {
      layers =
      {
       {
			filename = "__factorioplus__/graphics/shotgun-turret/hr-autoshotgun-turret.png",
			priority = "medium",
			width = 888/8,
			height = 872/8,
			direction_count = 64,
			frame_count = 1,
			line_length = 8,
			shift = util.by_pixel(0, -48),
			axially_symmetrical = false,
			scale =  0.5,
		},
        {
			  filename = "__factorioplus__/graphics/shotgun-turret/hr-autoshotgun-turret-mask.png",
			  flags = { "mask" },
			width = 888/8,
			height = 872/8,
			  direction_count = 64,
			  frame_count = 1,
			  line_length = 8,
			  shift = util.by_pixel(0, -48),
			  axially_symmetrical = false,
			  apply_runtime_tint = true,
			scale =  0.5,
		},
      }
    },
    turret_rotation_speed = 1 / 60,
    turret_return_timeout = 300,
   
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.7
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.1,
    sound_scaling_ratio = 0.5,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.8,
		speed = 0.5,
      },
      match_speed_to_activity = true
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.4 },
    rotation_speed = apc_turnrate,
    weight = apc_weight,
    inventory_size = apc_inventory_size,
	guns = { "combat-shotgun-veh","combat-shotgun-veh" },
    track_particle_triggers = movement_triggers.car,
    water_reflection = car_reflection(1),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/halftrack-shotgun-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
  },
----------------------------------------------------------  TANK  ----------------------------------------------------------
{
    type = "car",
    name = "tank",
    icon = "__base__/graphics/icons/tank.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 1, result = "tank"},
    mined_sound = {filename = "__core__/sound/deconstruct-large.ogg",volume = 0.8},
    max_health = tank_health,
    corpse = "tank-remnants",
    dying_explosion = "tank-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    immune_to_tree_impacts = true,
    immune_to_rock_impacts = true,
    energy_per_hit_point = tank_ephp,
	has_belt_immunity = true,
    resistances = tank_resistances,
    collision_box = {{-1.4, -1.9}, {1.4, 1.9}},
    selection_box = {{-1.5, -2.1}, {1.5, 2.1}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box = {{-2.8, -2.8}, {2.8, 2.5}},
    effectivity = tank_effectivity,
    braking_power = tank_braking,
	rotation_snap_angle = rsa,
	
	equipment_grid = "medium-equipment-grid",
	allow_remote_driving = true,
	trash_inventory_size = 20,
	
    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 2,
      smoke =
      {
        {
          name = "tank-smoke",
          deviation = {0.25, 0.25},
          frequency = 50,
          position = {0, 1.5},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = tank_consumption,
    terrain_friction_modifier = tank_friction_terrain_modifier,
    friction = tank_friction,
    light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {-0.6, -14 + tank_shift_y / 32},
        size = 2,
        intensity = 0.6,
        color = {r = 0.9, g = 1.0, b = 1.0}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {0.6, -14 + tank_shift_y / 32},
        size = 2,
        intensity = 0.6,
        color = {r = 0.9, g = 1.0, b = 1.0}
      }
    },
    animation =
    {
      layers =
      {
        {
            priority = "low",
            width = 270,
            height = 212,
            frame_count = 2,
            direction_count = 64,
            shift = util.by_pixel(0, -16 + tank_shift_y),
            animation_speed = 8,
            max_advance = 1,
            stripes =
            {
              {
               filename = "__base__/graphics/entity/tank/tank-base-1.png",
               width_in_frames = 2,
               height_in_frames = 16
              },
              {
               filename = "__base__/graphics/entity/tank/tank-base-2.png",
               width_in_frames = 2,
               height_in_frames = 16
              },
              {
               filename = "__base__/graphics/entity/tank/tank-base-3.png",
               width_in_frames = 2,
               height_in_frames = 16
              },
              {
               filename = "__base__/graphics/entity/tank/tank-base-4.png",
               width_in_frames = 2,
               height_in_frames = 16
              }
            },
            scale = 0.75
          
        },
        {
		  
            priority = "low",
            width = 208,
            height = 166,
            frame_count = 2,
            apply_runtime_tint = true,
            direction_count = 64,
            shift = util.by_pixel(0, -33.5 + tank_shift_y),
            max_advance = 1,
            line_length = 2,
            stripes = util.multiplystripes(2,
            {
              {
                filename = "__base__/graphics/entity/tank/tank-base-mask-1.png",
                width_in_frames = 1,
                height_in_frames = 22
              },
              {
                filename = "__base__/graphics/entity/tank/tank-base-mask-2.png",
                width_in_frames = 1,
                height_in_frames = 22
              },
              {
                filename = "__base__/graphics/entity/tank/tank-base-mask-3.png",
                width_in_frames = 1,
                height_in_frames = 20
              }
            }),
            scale = 0.75
          
        },
        {
          
            priority = "low",
            width = 302,
            height = 194,
            frame_count = 2,
            draw_as_shadow = true,
            direction_count = 64,
            shift = util.by_pixel(22.5, 1 + tank_shift_y),
            max_advance = 1,
            stripes = util.multiplystripes(2,
            {
             {
              filename = "__base__/graphics/entity/tank/tank-base-shadow-1.png",
              width_in_frames = 1,
              height_in_frames = 16
             },
             {
              filename = "__base__/graphics/entity/tank/tank-base-shadow-2.png",
              width_in_frames = 1,
              height_in_frames = 16
             },
             {
              filename = "__base__/graphics/entity/tank/tank-base-shadow-3.png",
              width_in_frames = 1,
              height_in_frames = 16
             },
             {
              filename = "__base__/graphics/entity/tank/tank-base-shadow-4.png",
              width_in_frames = 1,
              height_in_frames = 16
             }
            }),
            scale = 0.75
          
		}
      }
    },
    turret_animation =
    {
      layers =
      {
        {

            filename = "__base__/graphics/entity/tank/tank-turret.png",
            priority = "low",
            line_length = 8,
            width = 179,
            height = 132,
            frame_count = 1,
            direction_count = 64,
            shift = util.by_pixel(2.25-2, -50.5 + tank_shift_y),
            animation_speed = 8,
            scale = 0.75

        },
        {

            filename = "__base__/graphics/entity/tank/tank-turret-mask.png",
            priority = "low",
            line_length = 8,
            width = 72,
            height = 66,
            frame_count = 1,
            apply_runtime_tint = true,
            direction_count = 64,
            shift = util.by_pixel(2-2, -51.5 + tank_shift_y),
            scale = 0.75
          
        },
        {

            filename = "__base__/graphics/entity/tank/tank-turret-shadow.png",
            priority = "low",
            line_length = 8,
            width = 193,
            height = 134,
            frame_count = 1,
            draw_as_shadow = true,
            direction_count = 64,
            shift = util.by_pixel(58.25-2, 0.5 + tank_shift_y),
            scale = 0.75
          
        }
      }
    },
    turret_rotation_speed = 0.35 / 60,
    turret_return_timeout = 300,
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/tank-no-fuel-1.ogg",
        volume = 0.4
      }
    },
    sound_minimum_speed = 0.2,
    sound_scaling_ratio = 0.8,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/fight/tank-engine.ogg",
        volume = 0.37
      },
      activate_sound =
      {
        filename = "__base__/sound/fight/tank-engine-start.ogg",
        volume = 0.37
      },
      deactivate_sound =
      {
        filename = "__base__/sound/fight/tank-engine-stop.ogg",
        volume = 0.37
      },
      match_speed_to_activity = true
    },
    stop_trigger_speed = 0.1,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/fight/tank-brakes.ogg",
            volume = 0.3
          }
        }
      }
    },
    open_sound = { filename = "__base__/sound/fight/tank-door-open.ogg", volume=0.48 },
    close_sound = { filename = "__base__/sound/fight/tank-door-close.ogg", volume = 0.43 },
    rotation_speed = tank_turnrate,
    tank_driving = true,
    weight = tank_weight,
    inventory_size = tank_inventory_size,
    track_particle_triggers = movement_triggers.tank,
    guns = { "tank-cannon", "tank-cannon"},
    water_reflection = car_reflection(1.2),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/tank-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.75,
    },
  },
  
  --- SOLAR TRAIN ---
  
 {
    type = "locomotive",
    name = "solar-train",
    icon = "__factorioplus__/graphics/icons/solar-train.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
    minable = {mining_time = 0.5, result = "solar-train"},
    mined_sound = sounds.deconstruct_large(0.8),
    max_health = 500,
    corpse = "locomotive-remnants",
    dying_explosion = "locomotive-explosion",
    damaged_trigger_effect = hit_effects.entity(),
    alert_icon_shift = util.by_pixel(0, -24),
	equipment_grid = "tiny-equipment-grid",
	allow_remote_driving = true,
	trash_inventory_size = 10,
	
    weight = 500,
    max_speed = 0.75,
    max_power = "500kW",
    reversing_power_modifier = 1,
    braking_force = 5,
    friction_force = 0.20,
    vertical_selection_shift = -0.5,
	allow_robot_dispatch_in_automatic_mode = true,
    air_resistance = 0.01, -- this is a percentage of current speed that will be subtracted

	-- The length between this rolling stocks front and rear joints. Joints are the point where connection_distance is measured from when rolling stock are connected to one another. Wheels sprite are placed based on the joint position.
	-- Maximum joint distance is 15.
	-- Note: There needs to be border at least 0.2 between the bounding box edge and joint. This means that the collision_box must be at must be at least {{-0,-0.2},{0,0.2}}.
    joint_distance = 4,
	
	collision_box = {{-0.6, -2.6}, {0.6, 2.6}},
    selection_box = {{-1, -3}, {1, 3}},
	drawing_box = {{-1, -4}, {1, 3}},
	
	connection_distance = 3,
	--The distance between the joint of this rolling stock and its connected rolling stocks joint.
	max_snap_to_train_stop_distance = 2,
	
    energy_per_hit_point = 2,
    resistances =
    {
      {
        type = "fire",
        decrease = 10,
        percent = 40
      },
      {
        type = "physical",
        decrease = 10,
        percent = 20
      },
      {
        type = "impact",
        decrease = 40,
        percent = 50
      },
      {
        type = "explosion",
        decrease = 10,
        percent = 20
      },
      {
        type = "acid",
        decrease = 2,
        percent = 10
      }
    },
    energy_source = {type = "void"},
	
    front_light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {-0.6, -16},
        size = 1.5,
        intensity = 0.5,
        color = {r = 1.0, g = 0.9, b = 0.9}
      },
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {0.6, -16},
        size = 1.5,
        intensity = 0.4,
        color = {r = 1.0, g = 0.9, b = 0.9}
      }
    },
    back_light = rolling_stock_back_light(),
    stand_by_light = rolling_stock_stand_by_light(),
    color = {r = 0.92, g = 0.07, b = 0, a = 0.5},
    pictures =
    {
	 rotated =
      {
		  layers =
		  {
			{
			  priority = "very-low",
			  -- width = 5120/16,
			  -- height = 2264/8,
			  width = 4392/8,
			  height = 4032/8,
			  direction_count = 64,
			  allow_low_quality_rotation = true,
			  filename = "__factorioplus__/graphics/vehicles/train-solar-32.png",

			  line_length = 8,
			  shift = {0.0, -0.25},
			  scale = 0.5,
			},
			{
			  flags = { "mask" },
			  priority = "very-low",
			  width = 4392/8,
			  height = 4032/8,
			  direction_count = 64,
			  allow_low_quality_rotation = true,
			  filename = "__factorioplus__/graphics/vehicles/train-solar-mask-32.png",

			  line_length = 8,
			  shift = {0.0, -0.25},
			  scale = 0.5,
			  apply_runtime_tint = true,
			},
			{
			  flags = { "mask" },
			  priority = "very-low",
			  width = 4392/8,
			  height = 4032/8,
			  direction_count = 64,
			  allow_low_quality_rotation = true,
			  filename = "__factorioplus__/graphics/vehicles/train-solar-shadow-32.png",
			  draw_as_shadow = true,
			  line_length = 8,
			  shift = {0.0, -0.25},
			  scale = 0.5,
			},
		  },
	  },
    },
    front_light_pictures =
    {
      rotated =
      {
        layers =
        {
          util.sprite_load("__base__/graphics/entity/locomotive/locomotive-lights",
            {
              dice = 4,
              priority = "very-low",
              blend_mode = "additive",
              draw_as_light = true,
              allow_low_quality_rotation = true,
              direction_count = 256,
              scale = 0.5
            }
          )
        }
      },
    },
      minimap_representation =
    {
      filename = "__factorioplus__/graphics/vehicles/etrain-map.png",
      flags = {"icon"},
      size = {64, 128},
      scale = 0.25
    },
    selected_minimap_representation =
    {
      filename = "__factorioplus__/graphics/vehicles/etrain-map-select.png",
      flags = {"icon"},
      size = {64, 128},
      scale = 0.25
    },
    wheels = standard_train_wheels,
    stop_trigger =
    {
      -- left side
      {
        type = "create-trivial-smoke",
        repeat_count = 125,
        smoke_name = "smoke-train-stop",
        initial_height = 0,
        -- smoke goes to the left
        speed = {-0.03, 0},
        speed_multiplier = 0.75,
        speed_multiplier_deviation = 1.1,
        offset_deviation = {{-0.75, -2.7}, {-0.3, 2.7}}
      },
      -- right side
      {
        type = "create-trivial-smoke",
        repeat_count = 125,
        smoke_name = "smoke-train-stop",
        initial_height = 0,
        -- smoke goes to the right
        speed = {0.03, 0},
        speed_multiplier = 0.75,
        speed_multiplier_deviation = 1.1,
        offset_deviation = {{0.3, -2.7}, {0.75, 2.7}}
      },
      {
        type = "play-sound",
        sound = sounds.train_brakes
      },
      {
        type = "play-sound",
        sound = sounds.train_brake_screech
      }
    },
    drive_over_tie_trigger = drive_over_tie(),
    tie_distance = 50,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/train-engine.ogg",
        volume = 0.1
      },
      deactivate_sound =
      {
        filename = "__base__/sound/train-engine-stop.ogg",
        volume = 0.35
      },
      match_speed_to_activity = true,
      max_sounds_per_type = 2,
      -- use_doppler_shift = false
    },
    open_sound = { filename = "__base__/sound/train-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/train-door-close.ogg", volume = 0.4 },
    sound_minimum_speed = 0.5,
    sound_scaling_ratio = 0.35,
    water_reflection = locomotive_reflection()
  },
  
   ----------------------------------------------------------  EQUIPMENT WAGON TRAIN  ----------------------------------------------------------
  
  {
    type = "cargo-wagon",
    name = "cargo-wagon-equipment",
    icon = "__factorioplus__/graphics/icons/equipment-wagon.png",
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
    inventory_size = 30,
    minable = {mining_time = 0.5, result = "cargo-wagon-equipment"},
    mined_sound = sounds.deconstruct_large(0.8),
    max_health = 3000,
	equipment_grid = "medium-equipment-grid",
	trash_inventory_size = 40,
    deliver_category = "vehicle",
    corpse = "cargo-wagon-remnants",
    dying_explosion = "cargo-wagon-explosion",
    -- factoriopedia_simulation = simulations.factoriopedia_cargo_wagon,
    collision_box = {{-0.6, -2.4}, {0.6, 2.4}},
    selection_box = {{-1, -2.703125}, {1, 3.296875}},
    damaged_trigger_effect = hit_effects.entity(),
	allow_robot_dispatch_in_automatic_mode = true,
    vertical_selection_shift = -0.796875,
    weight = 2500,
    max_speed = 1.5,
    braking_force = 3,
    friction_force = 0.50,
    air_resistance = 0.01,
    connection_distance = 3,
    joint_distance = 4,
    energy_per_hit_point = 5,
    resistances =
    {
      {
        type = "fire",
        decrease = 15,
        percent = 80
      },
      {
        type = "physical",
        decrease = 15,
        percent = 50
      },
      {
        type = "impact",
        decrease = 50,
        percent = 80
      },
      {
        type = "explosion",
        decrease = 15,
        percent = 50
      },
      {
        type = "acid",
        decrease = 3,
        percent = 40
      }
    },
    back_light = rolling_stock_back_light(),
    stand_by_light = rolling_stock_stand_by_light(),
    color = {r = 0.43, g = 0.23, b = 0, a = 1},
    pictures =
    {
      rotated =
      {
        layers =
        {
           {
			  priority = "very-low",
			  -- width = 5120/16,
			  -- height = 2264/8,
			  width = 3952/8,
			  height = 3856/8,
			  direction_count = 64,
			  allow_low_quality_rotation = true,
			  filename = "__factorioplus__/graphics/vehicles/equipment-wagon.png",
			  line_length = 8,
			  shift = {0.0, -0.75},
			  scale = 0.5,
			},    
			{
			  priority = "very-low",
			  -- width = 5120/16,
			  -- height = 2264/8,
			  width = 3952/8,
			  height = 3856/8,
			  direction_count = 64,
			  allow_low_quality_rotation = true,
			  filename = "__factorioplus__/graphics/vehicles/equipment-wagon-shadow.png",
			  draw_as_shadow = true,
			  line_length = 8,
			  shift = {0.0, -0.75},
			  scale = 0.55,
			},    			
        }
      }
    },
    minimap_representation =
    {
      filename = "__factorioplus__/graphics/vehicles/ewagon-map.png",
      flags = {"icon"},
      size = {64, 128},
      scale = 0.25
    },
    selected_minimap_representation =
    {
      filename = "__factorioplus__/graphics/vehicles/ewagon-map-select.png",
      flags = {"icon"},
      size = {64, 128},
      scale = 0.25
    },
    wheels = standard_train_wheels,
    drive_over_tie_trigger = drive_over_tie(),
    drive_over_tie_trigger_minimal_speed = 0.5,
    tie_distance = 50,
    working_sound = sounds.train_wagon_wheels,
    crash_trigger = crash_trigger(),
    open_sound = sounds.cargo_wagon_open,
    close_sound = sounds.cargo_wagon_close,
    impact_category = "metal-large",
    water_reflection = locomotive_reflection(),
    door_opening_sound =
    {
      sound =
      {
        filename = "__base__/sound/cargo-wagon/cargo-wagon-opening-loop.ogg",
        volume = 0.3,
        aggregation = {max_count = 1, remove = true, count_already_playing = true}
      },
      stopped_sound =
      {
        filename = "__base__/sound/cargo-wagon/cargo-wagon-opened.ogg",
        volume = 0.25,
        aggregation = {max_count = 1, remove = true, count_already_playing = true}
      }
    },
    door_closing_sound =
    {
      sound =
      {
        filename = "__base__/sound/cargo-wagon/cargo-wagon-closing-loop.ogg",
        volume = 0.3,
        aggregation = {max_count = 1, remove = true, count_already_playing = true}
      },
      stopped_sound =
      {
        filename = "__base__/sound/cargo-wagon/cargo-wagon-closed.ogg",
        volume = 0.3,
        aggregation = {max_count = 1, remove = true, count_already_playing = true}
      }
    }
  },
  
  ----------------------------------------------------------  HOVERCRAFT  ----------------------------------------------------------
-- FLOAT ON THROUGH BROTHER
{
    type = "car",
    name = "hovercraft",
    icon = "__factorioplus__/graphics/icons/hovercraft.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
	collision_mask = 
	{
		layers = { is_object = true, train=true, out_of_map=true}
	},
    minable = {mining_time = 0.4, result = "hovercraft"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg",volume = 0.8},
    max_health = speeder_health * 1.5 ,
    corpse = "car-remnants",
    dying_explosion = "car-explosion",
    alert_icon_shift = util.by_pixel(0, -13),
    energy_per_hit_point = speeder_ephp,
    crash_trigger = crash_trigger(),
	has_belt_immunity = true,
    resistances = speeder_resistances,
    collision_box = {{-1.2, -2.0}, {1.2, 2.0}},
    selection_box = {{-1.2, -2.0}, {1.2, 2.0}},
    damaged_trigger_effect = hit_effects.entity(),
    effectivity = speeder_effectivity/2,
    braking_power = speeder_braking,
	tank_driving = true,
	trash_inventory_size = 20,

    energy_source =
    {
      type = "burner",
      fuel_categories = {"chemical"},
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "car-smoke",
          deviation = {0.25, 0.25},
          frequency = 40,
          position = {0, 1.5},
          starting_frame = 0,
          starting_frame_deviation = 60
        }
      }
    },
    consumption = speeder_consumption,

    friction =  0.0003,
	rotation_speed = 0.004,
	
    light =
    {
      {
        type = "oriented",
        minimum_darkness = 0.3,
        picture =
        {
          filename = "__core__/graphics/light-cone.png",
          priority = "extra-high",
          flags = { "light" },
          scale = 2,
          width = 200,
          height = 200
        },
        shift = {0, -14},
        size = 2,
        intensity = 0.6,
        color = {r = 0.92, g = 0.77, b = 0.3}
      },
    },
    render_layer = "object",
    animation =
    {
      layers =
      {
	 
        {
		  filename = "__factorioplus__/graphics/vehicles/hovercraft.png",
          priority = "low",
          width = 4096/8,
          height = 4096/8,
		  scale = 0.35,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
        },
		
			  {
		  filename = "__factorioplus__/graphics/vehicles/hovercraft_mask.png",
          priority = "low",
		   
          width = 4096/8,
          height = 4096/8,
		   scale = 0.35,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  flags = { "mask" },
		  apply_runtime_tint = true,
		  
          shift = {0, 0},
          animation_speed = 8,
          max_advance = 0.2,
        },
  
		{
		  filename = "__factorioplus__/graphics/vehicles/hovercraft.png",
          priority = "low",
           width = 4096/8,
          height = 4096/8,
		   scale = 0.35,
		  
         direction_count = 64,
		frame_count = 1,
		line_length = 8,
		  
		  draw_as_shadow = true,
          shift = {0.3, 0.05},
          animation_speed = 8,
          max_advance = 0.2,
        },
      }
    },  
    sound_no_fuel =
    {
      {
        filename = "__base__/sound/fight/car-no-fuel-1.ogg",
        volume = 0.6,
		speed = 0.5,
      }
    },
    stop_trigger_speed = 0.15,
    stop_trigger =
    {
      {
        type = "play-sound",
        sound =
        {
          {
            filename = "__base__/sound/car-breaks.ogg",
            volume = 0.2
          }
        }
      }
    },
    sound_minimum_speed = 0.25,
    sound_scaling_ratio = 1.2,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/car-engine.ogg",
        volume = 0.47,
		speed = 0.5,
      },
      activate_sound =
      {
        filename = "__base__/sound/car-engine-start.ogg",
        volume = 0.47,
		speed = 1,
      },
      deactivate_sound =
      {
        filename = "__base__/sound/car-engine-stop.ogg",
        volume = 0.47,
		speed = 1,
      },
      match_speed_to_activity = true
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.4 },
    weight = speeder_weight*2,
    inventory_size = 20,
    track_particle_triggers = movement_triggers_4wd(0.5, 0.8),
    water_reflection = car_reflection(1),
	minimap_representation =
	{
      filename = "__factorioplus__/graphics/vehicles/hovercraft-map.png",
      flags = {"icon"},
      size = {64, 64},
      scale = 0.5,
    },
  },
  

  
  {
    type = "recipe",
    name = "hovercraft",
    enabled = false,
    energy_required = 25,
    ingredients =
    { 
      {type="item", name="transporter", amount=1},
      {type="item", name="low-density-structure", amount=20},
	  {type="item", name="plastic-bar", amount=20},
    },
    results = {{type="item", name="hovercraft", amount=1}},
  },

})