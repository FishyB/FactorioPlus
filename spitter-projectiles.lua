require ("__base__.prototypes.entity.spitter-animations")
require ("__factorioplus__.enemies-stats")
local fireutil = require("__base__.prototypes.fire-util")
local util_firestickers = require("__factorioplus__.util-fire-stickers")

local math3d = require "math3d"




function flamer_fire_bomblet_projectile(data)
return
{
    type = "projectile",
    name = data.name,
    flags = {"not-on-map"},
    acceleration = 0.00,
    action =
    {
	   {
        type = "area",
        radius = data.bomblet_radius,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-sticker",
              sticker = data.bomblet_sticker,
              show_in_tooltip = true
            },
            {
              type = "damage",
              damage = { amount = data.bomblet_damage, type = data.bomblet_damage_type },
              apply_damage_to_trees = false
            }
          }
        }
      },
	  {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-fire",
              entity_name = data.bomblet_groundfire,
              show_in_tooltip = true,
              initial_ground_flame_count = 10
            }
          }
        }
      }

    },
    -- light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__base__/graphics/entity/grenade/grenade.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 26,
      height = 28,
      shift = util.by_pixel(1, 1),
      priority = "high",
	  scale = 0.3,

    },
    shadow =
    {
      filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 26,
      height = 20,
      shift = util.by_pixel(2, 6),
      priority = "high",
      draw_as_shadow = true,
    },
  }
end
 
 
 
function add_fire_graphics_and_effects(data)
return
	fireutil.add_basic_fire_graphics_and_effects_definitions
   {
	  type = "fire",
	  name = data.name,
	  flags = {"placeable-off-grid", "not-on-map"},
	  --collision_box = {{-4, -4}, {4, 4}},
	  damage_per_tick = {amount = data.dps or 0, type = data.damage_type or "fire"},
	  maximum_damage_multiplier = data.max_multiplier or 1,
	  damage_multiplier_increase_per_added_fuel = 1,
	  damage_multiplier_decrease_per_tick = 0.25 / 60,

	  spawn_entity = "fire-flame",

	  spread_delay = 100,
	  spread_delay_deviation = 80,
	  maximum_spread_count = 1000,

	  emissions_per_second = { pollution = 0.005 },

	  initial_lifetime = data.duration * 60,
	  lifetime_increase_by = 150,
	  lifetime_increase_cooldown = 4,
	  maximum_lifetime = data.duration_max * 60,
	  delay_between_initial_flames = 10,
	  limit_overlapping_particles = true,
	  
	}
end
  
function spitter_attack_parameters(data)
  return
  {
    type = "stream",
    ammo_category = data.ammo_category or "biological",
    cooldown = data.cooldown,
    cooldown_deviation = data.cooldown_deviation,
    range = data.range,
    range_mode = data.range_mode,
    min_attack_distance = data.min_attack_distance,
    --projectile_creation_distance = 1.9,
    damage_modifier = data.damage_modifier,
    warmup = 30,
    projectile_creation_parameters = spitter_shoot_shiftings(data.scale, data.scale * scale_spitter_stream),
    use_shooter_direction = true,

    lead_target_for_projectile_speed = 0.2* 0.75 * 1.5 *1.5, -- this is same as particle horizontal speed of flamethrower fire stream

    ammo_type =
    {
      category = data.ammo_category or "biological",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "stream",
          stream = data.acid_stream_name
        }
      }
    },
    cyclic_sound = spitter_sounds(data.name, data.scale),
    --sound = sounds.spitter_roars(data.roarvolume),
    animation = spitterattackanimation(data.scale, data.tint1, data.tint2)
  }
end

function spitter_soundscale(scale)
return 0.2 + (scale * 0.2)
end

function spitter_sounds(name, scale) 
	name = name or "small" 
	if string.find(name, "medium") then
	return 
	{
		  begin_sound =
		  {
			{
			  filename = "__base__/sound/creatures/spitter-spit-start-mid-1.ogg",
			  volume = spitter_soundscale(scale)
			},
			{
			  filename = "__base__/sound/creatures/spitter-spit-start-mid-2.ogg",
			  volume = spitter_soundscale(scale)
			},
			{
			  filename = "__base__/sound/creatures/spitter-spit-start-mid-3.ogg",
			  volume = spitter_soundscale(scale)
			},
			{
			  filename = "__base__/sound/creatures/spitter-spit-start-mid-5.ogg",
			  volume = spitter_soundscale(scale)
			},
		  },
		  middle_sound =
		  {
			{
			  filename = "__base__/sound/fight/flamethrower-mid.ogg",
			  volume = 0
			}
		  },
		  end_sound =
		  {
			{
			  filename = "__base__/sound/creatures/spitter-spit-end-1.ogg",
          volume = spitter_soundscale(scale)
			}
		  }
    }
	elseif string.find(name, "big") then
	return
	{
      begin_sound =
      {
        {
          filename = "__base__/sound/creatures/spitter-spit-start-big-1.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-big-2.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-big-3.ogg",
          volume =spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-big-4.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-big-5.ogg",
          volume =spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-big-6.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-big-7.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-big-8.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-big-9.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-big-10.ogg",
          volume = spitter_soundscale(scale)
        }
      },
      middle_sound =
      {
        {
          filename = "__base__/sound/fight/flamethrower-mid.ogg",
          volume = 0
        }
      },
      end_sound =
      {
        {
          filename = "__base__/sound/creatures/spitter-spit-end-1.ogg",
          volume = spitter_soundscale(scale)
        }
      }
    }
	elseif string.find(name, "behemoth") then
	return
	{
      begin_sound =
      {
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-1.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-2.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-3.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-4.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-5.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-6.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-7.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-8.ogg",
          volume = spitter_soundscale(scale)
        }
      },
      middle_sound =
      {
        {
          filename = "__base__/sound/fight/flamethrower-mid.ogg",
          volume = 0
        }
      },
      end_sound =
      {
        {
          filename = "__base__/sound/creatures/spitter-spit-end-big-1.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-end-big-2.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-end-big-3.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-end-big-4.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-end-big-5.ogg",
          volume = spitter_soundscale(scale)
        }
      }
    }
	elseif string.find(name, "boss") then
	return
	{
      begin_sound =
      {
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-1.ogg",
          volume = spitter_soundscale(scale),
		  speed = 0.25 + (1/scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-2.ogg",
          volume = spitter_soundscale(scale),
		  speed = 0.25 + (1/scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-3.ogg",
          volume = spitter_soundscale(scale),
		  speed = 0.25 + (1/scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-4.ogg",
          volume = spitter_soundscale(scale),
		  speed = 0.25 + (1/scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-5.ogg",
          volume = spitter_soundscale(scale),
		  speed = 0.25 + (1/scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-6.ogg",
          volume = spitter_soundscale(scale),
		  speed = 0.25 + (1/scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-7.ogg",
          volume = spitter_soundscale(scale),
		  speed = 0.25 + (1/scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-behemoth-8.ogg",
          volume = spitter_soundscale(scale),
		  speed = 0.25 + (1/scale)
        }
      },
      middle_sound =
      {
        {
          filename = "__base__/sound/fight/flamethrower-mid.ogg",
          volume = 0
        }
      },
      end_sound =
      {
        {
          filename = "__base__/sound/creatures/spitter-spit-end-big-1.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-end-big-2.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-end-big-3.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-end-big-4.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-end-big-5.ogg",
          volume = spitter_soundscale(scale)
        }
      }
    }
	else
	return
	{
      begin_sound =
      {
        {
          filename = "__base__/sound/creatures/spitter-spit-start-1.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-2.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-3.ogg",
          volume = spitter_soundscale(scale)
        },
        {
          filename = "__base__/sound/creatures/spitter-spit-start-4.ogg",
          volume = spitter_soundscale(scale)
        }
      },
      middle_sound =
      {
        {
          filename = "__base__/sound/fight/flamethrower-mid.ogg",
          volume = 0
        }
      },
      end_sound =
      {
        {
          filename = "__base__/sound/creatures/spitter-spit-end-1.ogg",
          volume = spitter_soundscale(scale)
        }
      }
    }
	end
end

function fire_stream(data)

local damage_type = data.damage_type or "fire"

local _cluster = nil

	if(data.cluster == true) then
	_cluster =
		{
			type = "cluster",
			cluster_count = data.cluster_amount,
			distance = data.cluster_distance,
			distance_deviation = data.cluster_distance_deviation,
			action_delivery =
			{
			  type = "projectile",
			  projectile = data.cluster_projectile,
			  direction_deviation = 0.6,
			  starting_speed = 0.35,
			  starting_speed_deviation = 0.3
			}
		}
	end
  
return
 {
    type = "stream",
	name = data.name,
    flags = {"not-on-map"},
    hidden = true,

    smoke_sources =
    {
      {
        name = "soft-fire-smoke",
        frequency = 0.05, --0.25,
        position = {0.0, 0}, -- -0.8},
        starting_frame_deviation = 60
      }
    },
	
	particle_buffer_size = 90,
    particle_spawn_interval = data.particle_spawn_interval,
    particle_spawn_timeout = data.particle_spawn_timeout,
    particle_vertical_acceleration = (0.01) * 0.60 *1.5, --x
    particle_horizontal_speed = 0.2 * 0.75 * 1.5 * 1.5, --x
    particle_horizontal_speed_deviation = 0.005 * 0.40,
    particle_start_alpha = 0.5,
    particle_end_alpha = 1,
    particle_alpha_per_part = 0.8,
    particle_scale_per_part = 0.8,
    particle_loop_frame_count = 15,
    --particle_fade_out_threshold = 0.95,
    particle_fade_out_duration = 2,
    particle_loop_exit_threshold = 0.25,
	
    initial_action =
    {
      {
        type = "area",
        radius = data.blast_radius,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-sticker",
              sticker = data.sticker_name,
              show_in_tooltip = true
            },
            {
              type = "damage",
              damage = { amount = data.damage, type = damage_type },
              apply_damage_to_trees = false
            },
			{
              type = "damage",
              damage = { amount = data.damage, type = "physical" },
              apply_damage_to_trees = true
            }
          }
        }
      },
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-fire",
              entity_name = data.entity_name,
              show_in_tooltip = true,
              initial_ground_flame_count = 8
            }
          }
        }
      },
	  _cluster,
    },
    spine_animation = util.draw_as_glow
  {
		filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-fire-stream-spine.png",
		blend_mode = "normal",
		tint = {r=1, g=1, b=1, a=0.2},
		line_length = 6,
		width = 54,
		height = 26,
		frame_count = 36,
		animation_speed = 2,
		shift = {0, 0},
		scale = data.scale or 1.0,
  },
  
    shadow = 
	{
		filename = "__base__/graphics/entity/acid-projectile/projectile-shadow.png",
		line_length = 5,
		width = 28,
		height = 16,
		frame_count = 33,
		priority = "high",
		shift = {-0.09, 0.395},
		scale = data.scale or 1.0,
		
   },
    particle = 
	{
		filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
		priority = "extra-high",
		blend_mode = "normal",
		tint = {r=0.9, g=0.9, b=0.9, a=0.55},
		line_length = 6,
		width = 124,
		height = 108,
		frame_count = 36,
		scale = 0.25 * data.scale or 1.0,
   },
	
    oriented_particle = true,
    shadow_scale_enabled = true,
  }
end



function acid_stream(data)

local damage_type = data.damage_type or "acid"

  return
  {
    type = "stream",
    name = data.name,
    flags = {"not-on-map"},
    particle_buffer_size = 90,
    particle_spawn_interval = data.particle_spawn_interval,
    particle_spawn_timeout = data.particle_spawn_timeout,
    particle_vertical_acceleration = 0.005 * 0.60 *1.5, --x
    particle_horizontal_speed = 0.2* 0.75 * 1.5 * 1.5, --x
    particle_horizontal_speed_deviation = 0.005 * 0.70,
    particle_start_alpha = 0.5,
    particle_end_alpha = 1,
    particle_alpha_per_part = 0.8,
    particle_scale_per_part = 0.8,
    particle_loop_frame_count = 15,
    --particle_fade_out_threshold = 0.95,
    particle_fade_out_duration = 2,
    particle_loop_exit_threshold = 0.25,
    special_neutral_target_damage = {amount = 1, type = damage_type},
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/fight/projectile-acid-burn-loop.ogg",
          volume = 0.4
        }
      }
    },
	
--  ROOT.stream.small-acid-stream-stomper.initial_action[1].action_delivery.target_effects[0].damage

    initial_action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "play-sound",
              sound =
              {
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg",
                  volume = 0.65
                },
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg",
                  volume = 0.65
                },
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
                  volume = 0.6
                },
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
                  volume = 0.6
                }
              }
            },
            {
              type = "create-fire",
              entity_name = data.splash_fire_name,
              tile_collision_mask = {layers={ water_tile=true }},
              show_in_tooltip = true
            },
            {
              type = "create-entity",
              entity_name = "water-splash",
              tile_collision_mask = {layers={ ground_tile=true }},
            }
          }
        }
      },
	  {
		type = "cluster",
		cluster_count = 1 + math.floor(2 * data.spit_radius),
		distance = data.spit_radius / 2,
		distance_deviation = data.spit_radius / 3,
		 action_delivery =
		 {
			type = "instant",
          target_effects =
		  {
		    {
              type = "create-fire",
              entity_name = data.splash_fire_name,
			  probability = 0.5,
              tile_collision_mask = {layers={ water_tile=true }},
              show_in_tooltip = true
            },
		  },
		 },
	  },
      {
        type = "area",
        radius = data.spit_radius,
        force = "enemy",
        ignore_collision_condition = true,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
			{
              type = "damage",
              damage = {amount = 1, type =  damage_type}
            },
            {
              type = "create-sticker",
              sticker = data.sticker_name
            },
          }
        }
      }
    },
    particle =
    {
        filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
        draw_as_glow = true,
        line_length = 5,
        width = 42,
        height = 164,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(-2, 31), data.scale),
        tint = data.tint,
        priority = "high",
        scale = 0.5 * data.scale,
        animation_speed = 1
    },
    spine_animation =
    {

        filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
        draw_as_glow = true,
        line_length = 5,
        width = 132,
        height = 20,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(0, -1), data.scale),
        tint = data.tint,
        priority = "high",
        scale = 0.5 * data.scale,
        animation_speed = 1

    },
    shadow =
    {

        filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
        line_length = 15,
        width = 42,
        height = 164,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(-2, 31), data.scale),
        draw_as_shadow = true,
        priority = "high",
        scale = 0.5 * data.scale,
        animation_speed = 1

    },

    oriented_particle = true,
    shadow_scale_enabled = true
  }
end


function hatcher_stream(data)

local damage_type = data.damage_type or "physical"

  return
  {
    type = "stream",
    name = data.name,
    flags = {"not-on-map"},
    particle_buffer_size = 90,
    particle_spawn_interval = data.particle_spawn_interval,
    particle_spawn_timeout = data.particle_spawn_timeout,
    particle_vertical_acceleration = 0.005 * 0.60 *1.5, --x
    particle_horizontal_speed = 0.2* 0.75 * 1.5 * 1.5, --x
    particle_horizontal_speed_deviation = 0.005 * 0.70,
    particle_start_alpha = 0.5,
    particle_end_alpha = 1,
    particle_alpha_per_part = 0.8,
    particle_scale_per_part = 0.8,
    particle_loop_frame_count = 15,
    --particle_fade_out_threshold = 0.95,
    particle_fade_out_duration = 2,
    particle_loop_exit_threshold = 0.25,
    -- special_neutral_target_damage = {amount = 1, type = damage_type},
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/fight/projectile-acid-burn-loop.ogg",
          volume = 0.4
        }
      }
    },
	
--  ROOT.stream.small-acid-stream-stomper.initial_action[1].action_delivery.target_effects[0].damage

    initial_action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "play-sound",
              sound =
              {
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg",
                  volume = 0.65
                },
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg",
                  volume = 0.65
                },
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
                  volume = 0.6
                },
                {
                  filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
                  volume = 0.6
                }
              }
            },
            {
              type = "create-fire",
              entity_name = data.splash_fire_name,
              tile_collision_mask = {layers={ water_tile=true }},
              show_in_tooltip = false,
            },
            {
              type = "create-entity",
              entity_name = "water-splash",
              tile_collision_mask = {layers={ ground_tile=true }},
			  show_in_tooltip = false,
            },
			{
              type = "create-entity",
              entity_name = "hatcher-egg-"..data.size,
			  find_non_colliding_position = true,
			  check_buildability  = true,
              tile_collision_mask = {layers= {water_tile=true, ghost=true }},
			  show_in_tooltip = true
            },

          }
        }
      },
	  {
        type = "area",
        radius = 2,
        force = "not-same",
        -- ignore_collision_condition = true,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
			{
              type = "damage",
              damage = {amount = 10, type = damage_type}
            },
          }
        }
      },
    },
    particle =
    {
        filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
        draw_as_glow = true,
        line_length = 5,
        width = 42,
        height = 164,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(-2, 31), data.scale),
        tint = data.tint,
        priority = "high",
        scale = 0.5 * data.scale,
        animation_speed = 1
    },
    spine_animation =
    {

        filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
        draw_as_glow = true,
        line_length = 5,
        width = 132,
        height = 20,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(0, -1), data.scale),
        tint = data.tint,
        priority = "high",
        scale = 0.5 * data.scale,
        animation_speed = 1

    },
    shadow =
    {

        filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
        line_length = 15,
        width = 42,
        height = 164,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(-2, 31), data.scale),
        draw_as_shadow = true,
        priority = "high",
        scale = 0.5 * data.scale,
        animation_speed = 1

    },

    oriented_particle = true,
    shadow_scale_enabled = true
  }
end



function acid_splash_fire(data)

local pics
local pics2
local _scale = 0.2 + (0.2 * data.scale)

if string.find(data.name,"web" ) then 
pics = 
{
      {
        layers =
        {
          {
          
              filename = "__factorioplus__/graphics/web-splash/hr-web-splash-1.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 210,
              height = 224,
              frame_count = 26,
              shift = util.mul_shift(util.by_pixel(-12, -8), _scale),
              tint = data.tint,
              scale = _scale

          },
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 266,
              height = 188,
              frame_count = 26,
              shift = util.mul_shift(util.by_pixel(2, 2), _scale),
              draw_as_shadow = true,
              scale = _scale

          }
        }
      },
      {
        layers =
        {
          {

              filename = "__factorioplus__/graphics/web-splash/hr-web-splash-2.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 174,
              height = 150,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(-9, -17), _scale),
              tint = data.tint,
              scale = _scale

          },
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 238,
              height = 266,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(6, 29), _scale),
              draw_as_shadow = true,
              scale = _scale

          }
        }
      },
      {
        layers =
        {
          {
 
              filename = "__factorioplus__/graphics/web-splash/hr-web-splash-3.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 236,
              height = 208,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(22, -16), _scale),
              tint = data.tint,
              scale = _scale

          },
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 214,
              height = 140,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(17, 2), _scale),
              draw_as_shadow = true,
              scale = _scale

          }
        }
      },
      {
        layers =
        {
          {
 
              filename = "__factorioplus__/graphics/web-splash/hr-web-splash-4.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 252,
              height = 154,
              frame_count = 24,
              shift = util.mul_shift(util.by_pixel(17, -19), _scale),
              tint = data.tint,
              scale = _scale

          },
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 248,
              height = 160,
              frame_count = 24,
              shift = util.mul_shift(util.by_pixel(18, -16), _scale),
              draw_as_shadow = true,
              scale = _scale

          }
        }
      }
    }

else 
pics = 
{
      {
        layers =
        {
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 210,
              height = 224,
              frame_count = 26,
              shift = util.mul_shift(util.by_pixel(-12, -8), _scale),
              tint = data.tint,
              scale = _scale

          },
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 266,
              height = 188,
              frame_count = 26,
              shift = util.mul_shift(util.by_pixel(2, 2), _scale),
              draw_as_shadow = true,
              scale = _scale

          }
        }
      },
      {
        layers =
        {
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 174,
              height = 150,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(-9, -17), _scale),
              tint = data.tint,
              scale = _scale

          },
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 238,
              height = 266,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(6, 29), _scale),
              draw_as_shadow = true,
              scale =  _scale

          }
        }
      },
      {
        layers =
        {
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 236,
              height = 208,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(22, -16), _scale),
              tint = data.tint,
              scale = _scale

          },
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 214,
              height = 140,
              frame_count = 29,
              shift = util.mul_shift(util.by_pixel(17, 2), _scale),
              draw_as_shadow = true,
              scale = _scale

          }
        }
      },
      {
        layers =
        {
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
              draw_as_glow = true,
              line_length = 8,
              direction_count = 1,
              width = 252,
              height = 154,
              frame_count = 24,
              shift = util.mul_shift(util.by_pixel(17, -19), _scale),
              tint = data.tint,
              scale = _scale

          },
          {

              filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
              line_length = 8,
              direction_count = 1,
              width = 248,
              height = 160,
              frame_count = 24,
              shift = util.mul_shift(util.by_pixel(18, -16),_scale),
              draw_as_shadow = true,
              scale = _scale

          }
        }
      }
    }
end


if string.find(data.name,"webber" ) 
	then 
		pics2 = {
		  {
			layers =
			{
			  {

				  filename = "__factorioplus__/graphics/web-splash/hr-web-splash-1.png",
				  draw_as_glow = true,
				  line_length = 8,
				  direction_count = 1,
				  width = 210,
				  height = 224,
				  frame_count = 26,
				  shift = util.mul_shift(util.by_pixel(-12, -8), _scale),
				  tint = util.multiply_color(data.tint , data.patch_tint_multiplier),
				  scale = _scale
				
			  },
			  {

				  filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
				  line_length = 8,
				  direction_count = 1,
				  width = 266,
				  height = 188,
				  frame_count = 26,
				  shift = util.mul_shift(util.by_pixel(2, 2), _scale),
				  draw_as_shadow = true,
				  scale =_scale
				
			  }
			}
		  },
		  {
			layers =
			{
			  {

				  filename = "__factorioplus__/graphics/web-splash/hr-web-splash-2.png",
				  draw_as_glow = true,
				  line_length = 8,
				  direction_count = 1,
				  width = 174,
				  height = 150,
				  frame_count = 29,
				  shift = util.mul_shift(util.by_pixel(-9, -17), _scale),
				  tint = util.multiply_color(data.tint , data.patch_tint_multiplier),
				  scale = _scale
				
			  },
			  {

				  filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
				  line_length = 8,
				  direction_count = 1,
				  width = 238,
				  height = 266,
				  frame_count = 29,
				  shift = util.mul_shift(util.by_pixel(6, 29), _scale),
				  draw_as_shadow = true,
				  scale =  _scale
				
			  }
			}
		  },
		  {
			layers =
			{
			  {

				  filename = "__factorioplus__/graphics/web-splash/hr-web-splash-3.png",
				  draw_as_glow = true,
				  line_length = 8,
				  direction_count = 1,
				  width = 236,
				  height = 208,
				  frame_count = 29,
				  shift = util.mul_shift(util.by_pixel(22, -16), _scale),
				  tint = util.multiply_color(data.tint , data.patch_tint_multiplier),
				  scale = _scale
				
			  },
			  {

				  filename = "__base__/graphics/entity/acid-splash/hr-web-splash-3-shadow.png",
				  line_length = 8,
				  direction_count = 1,
				  width = 214,
				  height = 140,
				  frame_count = 29,
				  shift = util.mul_shift(util.by_pixel(17, 2), _scale),
				  draw_as_shadow = true,
				  scale = _scale
				
			  }
			}
		  },
		  {
			layers =
			{
			  {

				  filename = "__factorioplus__/graphics/web-splash/hr-web-splash-4.png",
				  draw_as_glow = true,
				  line_length = 8,
				  direction_count = 1,
				  width = 252,
				  height = 154,
				  frame_count = 24,
				  shift = util.mul_shift(util.by_pixel(17, -19),_scale),
				  tint = util.multiply_color(data.tint , data.patch_tint_multiplier),
				  scale = _scale
				
			  },
			  {

				  filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
				  line_length = 8,
				  direction_count = 1,
				  width = 248,
				  height = 160,
				  frame_count = 24,
				  shift = util.mul_shift(util.by_pixel(18, -16), _scale),
				  draw_as_shadow = true,
				  scale = _scale
				
			  }
			}
		  }
		}
	else
		pics2 = {
		  {
			layers =
			{
			  {

				  filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
				  draw_as_glow = true,
				  line_length = 8,
				  direction_count = 1,
				  width = 210,
				  height = 224,
				  frame_count = 26,
				  shift = util.mul_shift(util.by_pixel(-12, -8),_scale),
				  tint = util.multiply_color(data.tint , data.patch_tint_multiplier),
				  scale = _scale
				
			  },
			  {

				  filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
				  line_length = 8,
				  direction_count = 1,
				  width = 266,
				  height = 188,
				  frame_count = 26,
				  shift = util.mul_shift(util.by_pixel(2, 2), _scale),
				  draw_as_shadow = true,
				  scale = _scale
				
			  }
			}
		  },
		  {
			layers =
			{
			  {

				  filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
				  draw_as_glow = true,
				  line_length = 8,
				  direction_count = 1,
				  width = 174,
				  height = 150,
				  frame_count = 29,
				  shift = util.mul_shift(util.by_pixel(-9, -17), _scale),
				  tint = util.multiply_color(data.tint , data.patch_tint_multiplier),
				  scale = _scale
				
			  },
			  {

				  filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
				  line_length = 8,
				  direction_count = 1,
				  width = 238,
				  height = 266,
				  frame_count = 29,
				  shift = util.mul_shift(util.by_pixel(6, 29), _scale),
				  draw_as_shadow = true,
				  scale = _scale
				
			  }
			}
		  },
		  {
			layers =
			{
			  {

				  filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
				  draw_as_glow = true,
				  line_length = 8,
				  direction_count = 1,
				  width = 236,
				  height = 208,
				  frame_count = 29,
				  shift = util.mul_shift(util.by_pixel(22, -16), _scale),
				  tint = util.multiply_color(data.tint , data.patch_tint_multiplier),
				  scale = _scale

			  },
			  {

				  filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
				  line_length = 8,
				  direction_count = 1,
				  width = 214,
				  height = 140,
				  frame_count = 29,
				  shift = util.mul_shift(util.by_pixel(17, 2), _scale),
				  draw_as_shadow = true,
				  scale = _scale
				
			  }
			}
		  },
		  {
			layers =
			{
			  {

				  filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
				  draw_as_glow = true,
				  line_length = 8,
				  direction_count = 1,
				  width = 252,
				  height = 154,
				  frame_count = 24,
				  shift = util.mul_shift(util.by_pixel(17, -19), _scale),
				  tint = util.multiply_color(data.tint , data.patch_tint_multiplier),
				  scale = _scale
				
			  },
			  {

				  filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
				  line_length = 8,
				  direction_count = 1,
				  width = 248,
				  height = 160,
				  frame_count = 24,
				  shift = util.mul_shift(util.by_pixel(18, -16), _scale),
				  draw_as_shadow = true,
				  scale = _scale
				
			  }
			}
		  }
		}
end

local damage_type = data.damage_type or "acid"

local _firesticker = nil
if data.sticker_name then
	_firesticker =
	{
			type = "create-sticker",
			sticker = data.sticker_name,
			show_in_tooltip = true
	}
end
	
return
  {
    type = "fire",
    name = data.name,
    localised_name = {"entity-name.acid-splash"},
    flags = {"placeable-off-grid", "not-on-map"},
    damage_per_tick = {amount = data.damage or 0, type = damage_type},
    maximum_damage_multiplier = 1,
    damage_multiplier_increase_per_added_fuel = 1,
    damage_multiplier_decrease_per_tick = 0.005,

    --spawn_entity = "fire-flame-on-tree",
    uses_alternative_behavior = true,
    limit_overlapping_particles = true,
    initial_render_layer = "object",
    render_layer = "lower-object-above-shadow",
    secondary_render_layer = "higher-object-above",
    secondary_picture_fade_out_start = 30,
    secondary_picture_fade_out_duration = 60,

    spread_delay = 300,
    spread_delay_deviation = 180,
    maximum_spread_count = 100,

    particle_alpha = 0.6,
    particle_alpha_blend_duration = 60*5,
    --flame_alpha = 0.35,
    --flame_alpha_deviation = 0.05,

    emissions_per_second = { pollution = 0 },

    add_fuel_cooldown = 10,
    fade_in_duration = 1,
    fade_out_duration = 30,

    initial_lifetime = 60 * ( data.duration or 2),--120,
    lifetime_increase_by = 0,
    lifetime_increase_cooldown = 4,
    maximum_lifetime = 1800,
    delay_between_initial_flames = 10,
    initial_flame_count = 1,
    burnt_patch_lifetime = 0,

-- "small-acid-splash-fire-stomper" (fire): 
-- Key "type" not found in property tree at 
-- ROOT.fire.small-acid-splash-fire-stomper.on_damage_tick_effect.action_delivery.target_effects[1].damage
-- ROOT.stream.small-acid-stream-stomper.initial_action[1].action_delivery.target_effects[1].damage
-- "all"	
-- "enemy"	
-- "ally"	
-- "friend"	
-- "not-friend"	
-- "same"	
-- "not-same"

   on_damage_tick_effect =
    {
      type = "direct",
      force = "enemy",
      ignore_collision_condition = true,
      trigger_target_mask = { "common"},
  --	trigger_target_mask = { "ground-unit", "floor" },
      filter_enabled = true,
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "damage",
            damage = { amount = data.splash_damage_per_tick, type = damage_type },
            apply_damage_to_trees = true
          },
		  _firesticker,	 
        }
      }
    },

    pictures = pics,    
    secondary_pictures = pics2,    
  }
end

function acid_sticker(data)
  return
  {
    type = "sticker",
    name = data.name,
    flags = {"not-on-map"},
	damage_interval = 30,
	stickers_per_square_meter = data.stickers_per_square_meter or 15,
	damage_per_tick = { amount = data.sticker_damage or 0 , type = "poison" },
	damage_interval = data.sticker_damage_interval or 1,
    animation =
    {
        filename = "__base__/graphics/entity/acid-sticker/acid-sticker.png",
        draw_as_glow = true,
        line_length = 5,
        width = 30,
        height = 34,
        frame_count = 50,
        animation_speed = 0.5,
        tint = data.tint, -- #b6aa4abe
        shift = util.by_pixel(1.5, 0),
        scale = data.sticker_scale or 0.5 
    },
    duration_in_ticks = data.slow_seconds * 60,
    target_movement_modifier_from = data.slow_player_movement,
    target_movement_modifier_to = 1,
    vehicle_speed_modifier_from = data.slow_vehicle_speed,
    vehicle_speed_modifier_to = 1,
    vehicle_friction_modifier_from = data.slow_vehicle_friction,
    vehicle_friction_modifier_to = 1,
  }
end

data:extend({

  -- W O R M   S T R E A M S --------------------------------------------------------------------------------------------------------
  
  acid_stream({
    name = "acid-stream-worm-small",
    scale = scale_worm_small,
    tint = spitter_spawner_tint,
    corpse_name = "acid-splash-worm-small",
    spit_radius = stream_radius_worm_small * spitter_hit_splash_radius_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "acid-splash-fire-worm-small",
    sticker_name = "acid-sticker-small",
	damage_type = "acid",
  }),
  acid_stream({
    name = "acid-stream-worm-medium",
    scale = scale_worm_medium,
    tint = spitter_spawner_tint,
    corpse_name = "acid-splash-worm-medium",
    spit_radius = stream_radius_worm_medium * spitter_hit_splash_radius_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "acid-splash-fire-worm-medium",
    sticker_name = "acid-sticker-medium",
	damage_type = "acid",
  }),
  acid_stream({
    name = "acid-stream-worm-big",
    scale = scale_worm_big,
    tint = spitter_spawner_tint,
    corpse_name = "acid-splash-worm-big",
    spit_radius = stream_radius_worm_big * spitter_hit_splash_radius_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "acid-splash-fire-worm-big",
    sticker_name = "acid-sticker-big",
	damage_type = "acid",
  }),
  acid_stream({
    name = "acid-stream-worm-behemoth",
    scale = scale_worm_behemoth,
    tint = spitter_spawner_tint,
    corpse_name = "acid-splash-worm-behemoth",
    spit_radius = stream_radius_worm_behemoth * spitter_hit_splash_radius_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "acid-splash-fire-worm-behemoth",
    sticker_name = "acid-sticker-behemoth",
	damage_type = "acid",
  }),
  
  -- S P I T T E R   S T R E A M S --------------------------------------------------------------------------------------------------------
 
 acid_stream({
    name = "acid-stream-small-spitter",
    scale = small_spitter_scale,
    tint = spitter_spawner_tint,
    corpse_name = "acid-splash-spitter-small",
    spit_radius = stream_radius_spitter_small * spitter_hit_splash_radius_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "acid-splash-fire-spitter-small",
    sticker_name = "acid-sticker-small",
	damage_type = "acid",
  }),
  acid_stream({
    name = "acid-stream-medium-spitter",
    scale = medium_spitter_scale,
    tint = stream_tint_spitter_medium ,
    corpse_name = "acid-splash-spitter-medium",
    spit_radius = stream_radius_spitter_medium * spitter_hit_splash_radius_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "acid-splash-fire-spitter-medium",
    sticker_name = "acid-sticker-medium",
	damage_type = "acid",
  }),
  acid_stream({
    name = "acid-stream-big-spitter",
    scale = big_spitter_scale,
    tint = stream_tint_spitter_big,
    corpse_name = "acid-splash-spitter-big",
    spit_radius = stream_radius_spitter_big * spitter_hit_splash_radius_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "acid-splash-fire-spitter-big",
    sticker_name = "acid-sticker-big",
	damage_type = "acid",
  }),
  acid_stream({
    name = "acid-stream-behemoth-spitter",
    scale = behemoth_spitter_scale,
    tint = stream_tint_spitter_behemoth,
    corpse_name = "acid-splash-spitter-behemoth",
    spit_radius = stream_radius_spitter_behemoth * spitter_hit_splash_radius_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "acid-splash-fire-spitter-behemoth",
    sticker_name = "acid-sticker-behemoth",
	damage_type = "acid",
  }),
   acid_stream({
    name = "acid-stream-boss-spitter",
    scale = boss_spitter_scale,
    tint = spitter_spawner_tint,
    corpse_name = "acid-splash-spitter-behemoth",
    spit_radius = stream_radius_spitter_boss * spitter_hit_splash_radius_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "acid-splash-fire-spitter-behemoth",
    sticker_name = "acid-sticker-behemoth",
	damage_type = "acid",
  }),

  -- A C I D   S P L A S H   F I R E ------------------------------------------------------------------------------------------------------
  acid_splash_fire({
    name = "acid-splash-fire-worm-small",
    scale = scale_worm_small,
    tint = spitter_spawner_tint,
    ground_patch_scale = scale_worm_small * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_worm_small,
	damage_type = "acid",
    sticker_name = "acid-sticker-small",
	duration = spitter_ground_patch_duration
  }),
  acid_splash_fire({
    name = "acid-splash-fire-worm-medium",
    scale = scale_worm_medium,
    tint = spitter_spawner_tint,
    ground_patch_scale = scale_worm_medium * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_worm_medium,
	damage_type = "acid",
    sticker_name = "acid-sticker-medium",
	duration = spitter_ground_patch_duration
  }),
  acid_splash_fire({
    name = "acid-splash-fire-worm-big",
    scale = scale_worm_big,
    tint = spitter_spawner_tint,
    ground_patch_scale = scale_worm_big * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_worm_big,
	damage_type = "acid",
    sticker_name = "acid-sticker-big",
	duration = spitter_ground_patch_duration
  }),
  acid_splash_fire({
    name = "acid-splash-fire-worm-behemoth",
    scale = scale_worm_behemoth,
    tint = spitter_spawner_tint,
    ground_patch_scale = scale_worm_behemoth * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_worm_behemoth,
	damage_type = "acid",
    sticker_name = "acid-sticker-behemoth",
	duration = spitter_ground_patch_duration
  }),
  ------------------------------------------------------------------
  acid_splash_fire({
    name = "acid-splash-fire-spitter-small",
    scale = small_spitter_scale ,
    tint = spitter_spawner_tint,
    ground_patch_scale = small_spitter_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_spitter_small,
	damage_type = "acid",
    sticker_name = "acid-sticker-small",
	duration = spitter_ground_patch_duration
  }),
  acid_splash_fire({
    name = "acid-splash-fire-spitter-medium",
    scale = medium_spitter_scale ,
    tint = spitter_spawner_tint,
    ground_patch_scale = medium_spitter_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_spitter_medium,
	damage_type = "acid",
    sticker_name = "acid-sticker-medium",
	duration = spitter_ground_patch_duration
  }),
  acid_splash_fire({
    name = "acid-splash-fire-spitter-big",
    scale = big_spitter_scale ,
    tint = spitter_spawner_tint,
    ground_patch_scale = big_spitter_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_spitter_big,
	damage_type = "acid",
    sticker_name = "acid-sticker-big",
	duration = spitter_ground_patch_duration
  }),
  acid_splash_fire({
    name = "acid-splash-fire-spitter-behemoth",
    scale = behemoth_spitter_scale ,
    tint = spitter_spawner_tint,
    ground_patch_scale = behemoth_spitter_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_spitter_behemoth,
	damage_type = "acid",
    sticker_name = "acid-sticker-behemoth",
	duration = spitter_ground_patch_duration
  }),
    acid_splash_fire({
    name = "acid-splash-fire-spitter-boss",
    scale = boss_spitter_scale ,
    tint = spitter_spawner_tint,
    ground_patch_scale = boss_spitter_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_spitter_boss,
	damage_type = "acid",
    sticker_name = "acid-sticker-boss",
	duration = spitter_ground_patch_duration
  }),
  
  ---------------------------SPAWNER SPLASH FIRE---------------------------------------
  acid_splash_fire({
    name = "acid-splash-fire-spitter-spawner-small",
    scale = medium_spitter_scale ,
    tint = spitter_spawner_tint,
    ground_patch_scale = small_spitter_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_spitter_small,
	damage = damage_splash_spitter_small * 3 ,
	damage_type = "acid",
    sticker_name = "acid-sticker-small",
	duration = spitter_ground_patch_duration
  }),
  acid_splash_fire({
    name = "acid-splash-fire-spitter-spawner-medium",
    scale = medium_spitter_scale ,
    tint = spitter_spawner_tint,
    ground_patch_scale = medium_spitter_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_spitter_medium,
	damage = damage_splash_spitter_medium * 3,
	damage_type = "acid",
    sticker_name = "acid-sticker-medium",
	duration = spitter_ground_patch_duration
  }),
  acid_splash_fire({
    name = "acid-splash-fire-spitter-spawner-big",
    scale = big_spitter_scale ,
    tint = spitter_spawner_tint,
    ground_patch_scale = big_spitter_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_spitter_big,
	damage = damage_splash_spitter_big * 3,
	damage_type = "acid",
    sticker_name = "acid-sticker-big",
	duration = spitter_ground_patch_duration
  }),
  acid_splash_fire({
    name = "acid-splash-fire-spitter-spawner-behemoth",
    scale = behemoth_spitter_scale ,
    tint = spitter_spawner_tint,
    ground_patch_scale = behemoth_spitter_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_spitter_behemoth,
	damage = damage_splash_spitter_behemoth * 3,
	damage_type = "acid",
    sticker_name = "acid-sticker-behemoth",
	duration = spitter_ground_patch_duration
  }),
    acid_splash_fire({
    name = "acid-splash-fire-spitter-spawner-boss",
    scale = boss_spitter_scale ,
    tint = spitter_spawner_tint,
    ground_patch_scale = boss_spitter_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = patch_opacity,
    splash_damage_per_tick = damage_splash_spitter_boss ,
	damage = damage_splash_spitter_boss * 3,
	damage_type = "acid",
    sticker_name = "acid-sticker-boss",
	duration = spitter_ground_patch_duration
  }),

  -- A C I D   S T I C K E R --------------------------------------------------------------------------------------------------------------
  acid_sticker({
    name = "acid-sticker-small",
    tint = spitter_spawner_tint,
    slow_player_movement = slow_movement_multiplier_spitter,
    slow_vehicle_speed = slow_movement_multiplier_spitter,
    slow_vehicle_friction = 1/slow_movement_multiplier_spitter,
    slow_seconds = slow_movement_time_spitter
  }),
  acid_sticker({
    name = "acid-sticker-medium",
    tint = spitter_spawner_tint,
    slow_player_movement = slow_movement_multiplier_spitter,
    slow_vehicle_speed = slow_movement_multiplier_spitter,
    slow_vehicle_friction = 1/slow_movement_multiplier_spitter,
    slow_seconds = slow_movement_time_spitter
  }),
  acid_sticker({
    name = "acid-sticker-big",
    tint = spitter_spawner_tint,
    slow_player_movement = slow_movement_multiplier_spitter,
    slow_vehicle_speed = slow_movement_multiplier_spitter,
    slow_vehicle_friction = 1/slow_movement_multiplier_spitter,
    slow_seconds = slow_movement_time_spitter
  }),
  acid_sticker({
    name = "acid-sticker-behemoth",
    tint = spitter_spawner_tint,
    slow_player_movement = slow_movement_multiplier_spitter,
    slow_vehicle_speed = slow_movement_multiplier_spitter,
    slow_vehicle_friction = 1/slow_movement_multiplier_spitter,
    slow_seconds = slow_movement_time_spitter
  }),
  acid_sticker({
    name = "acid-sticker-boss",
    tint = spitter_spawner_tint,
    slow_player_movement = slow_movement_multiplier_spitter,
    slow_vehicle_speed = slow_movement_multiplier_spitter,
    slow_vehicle_friction = 1/slow_movement_multiplier_spitter,
    slow_seconds = slow_movement_time_spitter
  }),
  
    -- WEB SHOT --------------------------------------------------------------------------------------------------------------
  
  acid_stream({
    name = "web-stream-small-webber",
    scale = small_webber_scale,
    tint = webber_web_tint,
    corpse_name = "acid-splash-webber-small",
    spit_radius = stream_radius_webber_small * ground_patch_scale_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "web-splash-fire-web-small",
    sticker_name = "web-sticker-small",
	damage_type = "physical",
  }),
  acid_stream({
    name = "web-stream-medium-webber",
    scale = medium_webber_scale,
    tint = webber_web_tint,
    corpse_name = "acid-splash-webber-medium",
    spit_radius = stream_radius_webber_medium * ground_patch_scale_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "web-splash-fire-web-medium",
    sticker_name = "web-sticker-medium",
	damage_type = "physical",
  }), 
  acid_stream({
    name = "web-stream-big-webber",
    scale = big_webber_scale,
    tint = webber_web_tint,
    corpse_name = "acid-splash-webber-big",
    spit_radius = stream_radius_webber_big * ground_patch_scale_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "web-splash-fire-web-big",
    sticker_name = "web-sticker-big",
	damage_type = "physical",
  }),  
  acid_stream({
    name = "web-stream-behemoth-webber",
    scale = behemoth_webber_scale,
    tint = webber_web_tint,
    corpse_name = "acid-splash-webber-behemoth",
    spit_radius = stream_radius_webber_behemoth * ground_patch_scale_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "web-splash-fire-web-behemoth",
    sticker_name = "web-sticker-behemoth",
	damage_type = "physical",
  }),
  acid_stream({
    name = "web-stream-boss-webber",
    scale = boss_webber_scale,
    tint = webber_web_tint,
    corpse_name = "acid-splash-webber-boss",
    spit_radius = stream_radius_webber_boss * ground_patch_scale_modifier,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    splash_fire_name = "web-splash-fire-web-boss",
    sticker_name = "web-sticker-boss",
	damage_type = "physical",
  }),
  -- WEB FIRE --------------------------------------------------------------------------------------------------------------

  acid_splash_fire({
    name = "web-splash-fire-web-small",
    scale = small_webber_scale ,
    tint = webber_web_tint,
    ground_patch_scale = small_webber_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = 1,
    splash_damage_per_tick = 0,
	damage_type = "physical",
    sticker_name = "web-sticker-small",
	duration = webber_ground_patch_duration
  }),
  acid_splash_fire({
    name = "web-splash-fire-web-medium",
    scale = medium_webber_scale ,
    tint = webber_web_tint,
    ground_patch_scale = medium_webber_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = 1,
    splash_damage_per_tick = 0,
	damage_type = "physical",
    sticker_name = "web-sticker-medium",
	duration = webber_ground_patch_duration
  }),
  acid_splash_fire({
    name = "web-splash-fire-web-big",
    scale = big_spitter_scale ,
    tint = webber_web_tint,
    ground_patch_scale = big_webber_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = 1,
    splash_damage_per_tick = 0,
	damage_type = "physical",
    sticker_name = "web-sticker-big",
	duration = webber_ground_patch_duration
  }),
  acid_splash_fire({
    name = "web-splash-fire-web-behemoth",
    scale = behemoth_webber_scale ,
    tint = webber_web_tint,
    ground_patch_scale = behemoth_webber_scale * ground_patch_scale_modifier,
    patch_tint_multiplier = 1,
    splash_damage_per_tick = 0,
	damage_type = "physical",
    sticker_name = "web-sticker-behemoth",
	duration = webber_ground_patch_duration
  }),
    acid_splash_fire({
    name = "web-splash-fire-web-boss",
    scale = boss_webber_scale ,
    tint = webber_web_tint,
    ground_patch_scale = boss_webber_scale * ground_webber_scale_modifier,
    patch_tint_multiplier = 1,
    splash_damage_per_tick = 0,
	damage_type = "physical",
    sticker_name = "web-sticker-boss",
	duration = webber_ground_patch_duration
  }),

  -- WEB STICKER ------------------------------------------------------------------
  
  acid_sticker({
    name = "web-sticker-small",
    tint = webber_web_tint,
    slow_player_movement = slow_movement_multiplier_webber,
    slow_vehicle_speed = slow_movement_multiplier_webber,
    slow_vehicle_friction = 1/slow_movement_multiplier_webber,
    slow_seconds = slow_movement_time_webber
  }),
  acid_sticker({
    name = "web-sticker-medium",
    tint = webber_web_tint,
    slow_player_movement = slow_movement_multiplier_webber ^ 1.5,
    slow_vehicle_speed = slow_movement_multiplier_webber,
    slow_vehicle_friction = 1/slow_movement_multiplier_webber,
    slow_seconds = slow_movement_time_webber
  }),
  acid_sticker({
    name = "web-sticker-big",
    tint = webber_web_tint,
    slow_player_movement = slow_movement_multiplier_webber ^ 2.0,
    slow_vehicle_speed = slow_movement_multiplier_webber,
    slow_vehicle_friction = 1/slow_movement_multiplier_webber,
    slow_seconds = slow_movement_time_webber
  }),
  acid_sticker({
    name = "web-sticker-behemoth",
    tint = webber_web_tint,
    slow_player_movement = slow_movement_multiplier_webber ^  2.5, 
    slow_vehicle_speed = slow_movement_multiplier_webber,
    slow_vehicle_friction = 1/slow_movement_multiplier_webber,
    slow_seconds = slow_movement_time_webber
  }),
  acid_sticker({
    name = "web-sticker-boss",
    tint = webber_web_tint,
    slow_player_movement = slow_movement_multiplier_webber ^ 3,
    slow_vehicle_speed = slow_movement_multiplier_webber,
    slow_vehicle_friction = 1/slow_movement_multiplier_webber,
    slow_seconds = slow_movement_time_webber
  }),
})


data.extend({ 

  util_firestickers.makefiresticker("flamer-fire-sticker-small", 1, damage_dps_flamer_small, flamer_sticker_duration, 1.0, "fire-flame-on-tree", { r = 0.5, g = 0.5, b = 0.5, a = 0.18 }), 
  util_firestickers.makefiresticker("flamer-fire-sticker-medium", 1, damage_dps_flamer_medium, flamer_sticker_duration, 1.0, "fire-flame-on-tree", { r = 0.5, g = 0.5, b = 0.5, a = 0.18 }), 
  util_firestickers.makefiresticker("flamer-fire-sticker-big", 1, damage_dps_flamer_big, flamer_sticker_duration, 1.0, "fire-flame-on-tree", { r = 0.5, g = 0.5, b = 0.5, a = 0.18 }), 
  util_firestickers.makefiresticker("flamer-fire-sticker-behemoth", 1, damage_dps_flamer_behemoth, flamer_sticker_duration, 1.0, "fire-flame-on-tree", { r = 0.5, g = 0.5, b = 0.5, a = 0.18 }), 
  util_firestickers.makefiresticker("flamer-fire-sticker-boss", 1, damage_dps_flamer_boss, flamer_sticker_duration, 1.0, "fire-flame-on-tree", { r = 0.5, g = 0.5, b = 0.5, a = 0.18 }), 


  add_fire_graphics_and_effects({
	name = "flamer-fire-small",
	dps = damage_dps_flamer_small,
	damage_type = "fire",
	max_multiplier = damage_dps_maxstackamount_flamer,
	duration = flamer_ground_patch_duration,
	duration_max = flamer_ground_patch_duration,
  }),
  
   add_fire_graphics_and_effects({
	name = "flamer-fire-medium",
	dps = damage_dps_flamer_medium,
	damage_type = "fire",
	max_multiplier = damage_dps_maxstackamount_flamer,
	duration = flamer_ground_patch_duration,
	duration_max = flamer_ground_patch_duration,
  }),
  
   add_fire_graphics_and_effects({
	name = "flamer-fire-big",
	dps = damage_dps_flamer_big,
	damage_type = "fire",
	max_multiplier = damage_dps_maxstackamount_flamer,
	duration = flamer_ground_patch_duration,
	duration_max = flamer_ground_patch_duration,
  }),
  
     add_fire_graphics_and_effects({
	name = "flamer-fire-behemoth",
	dps = damage_dps_flamer_behemoth,
	damage_type = "fire",
	max_multiplier = damage_dps_maxstackamount_flamer,
	duration = flamer_ground_patch_duration,
	duration_max = flamer_ground_patch_duration,
  }),
  
     add_fire_graphics_and_effects({
	name = "flamer-fire-boss",
	dps = damage_dps_flamer_boss,
	damage_type = "fire",
	max_multiplier = damage_dps_maxstackamount_flamer,
	duration = flamer_ground_patch_duration,
	duration_max = flamer_ground_patch_duration,
  }),
  
  	flamer_fire_bomblet_projectile({
		name = "flamer-small-fire-bomblet",
		bomblet_radius = 2 ,
		bomblet_sticker = "flamer-fire-sticker-small" , -- fire sticker
		bomblet_damage = 0,
		bomblet_damage_type = "fire",
		bomblet_groundfire = "flamer-fire-small" , -- ground fire
	}),

	flamer_fire_bomblet_projectile({
		name = "flamer-medium-fire-bomblet" ,
		bomblet_radius = 2 ,
		bomblet_sticker = "flamer-fire-sticker-medium" , -- fire sticker
		bomblet_damage = 0,
		bomblet_damage_type = "fire",
		bomblet_groundfire = "flamer-fire-medium" , -- ground fire
	}),

	flamer_fire_bomblet_projectile({
		name = "flamer-big-fire-bomblet" ,
		bomblet_radius = 2 ,
		bomblet_sticker = "flamer-fire-sticker-big" , -- fire sticker
		bomblet_damage = 0,
		bomblet_damage_type = "fire",
		bomblet_groundfire = "flamer-fire-big" , -- ground fire
	}),

	flamer_fire_bomblet_projectile({
		name = "flamer-behemoth-fire-bomblet" ,
		bomblet_radius = 2 ,
		bomblet_sticker = "flamer-fire-sticker-behemoth" , -- fire sticker
		bomblet_damage = 0,
		bomblet_damage_type = "fire",
		bomblet_groundfire = "flamer-fire-behemoth" , -- ground fire
	}),

	flamer_fire_bomblet_projectile({
		name = "flamer-boss-fire-bomblet" ,
		bomblet_radius = 2 ,
		bomblet_sticker = "flamer-fire-sticker-boss" , -- fire sticker
		bomblet_damage = 0,
		bomblet_damage_type = "fire",
		bomblet_groundfire = "flamer-fire-boss" , -- ground fire
	}),

  -- fire_stream({
    -- name = "fire-stream-small-flamer",
	
-- --   scale = small_flamer_scale,
 -- --   tint = flamer_fire_tint,
-- -- corpse_name = "acid-splash-flamer-small",
    -- spit_radius = stream_radius_flamer_small,
    -- particle_spawn_interval = 1,
    -- particle_spawn_timeout = 6,
    -- --splash_fire_name = "fire-splash-fire-fire-small",
   -- sticker_name = "flamer-fire-sticker-small",
	-- damage_type = "fire",
	-- entity_name = "flamer-fire-small"
  -- }),
    fire_stream({
    name = "fire-stream-small-flamer",
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6*stream_radius_flamer_small,
    sticker_name = "flamer-fire-sticker-small",
	blast_radius = stream_blastradius_flamer_small,
	damage = damage_modifier_flamer_small,
	damage_type = "fire",
	entity_name = "flamer-fire-small",
	scale = stream_radius_flamer_small,
	cluster = true,
	cluster_amount = cluster_amount_flamer_small,
	cluster_distance = 1,
	cluster_distance_deviation = 1 ,
	cluster_projectile =  "flamer-small-fire-bomblet" , 
  }),
    fire_stream({
    name = "fire-stream-medium-flamer",
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6*stream_radius_flamer_medium,
   sticker_name = "flamer-fire-sticker-medium",
   blast_radius = stream_blastradius_flamer_medium,
	damage_type = "fire",
	damage = damage_modifier_flamer_medium,
	entity_name = "flamer-fire-medium",
	scale = stream_radius_flamer_medium,
	cluster = true,
	cluster_amount = cluster_amount_flamer_medium,
	cluster_distance = 2,
	cluster_distance_deviation = 2 ,
	cluster_projectile =  "flamer-medium-fire-bomblet" , 
  }),
    fire_stream({
    name = "fire-stream-big-flamer",
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6*stream_radius_flamer_big,
   sticker_name = "flamer-fire-sticker-big",
   blast_radius = stream_blastradius_flamer_big,
   	damage = damage_modifier_flamer_big,
	damage_type = "fire",
	entity_name = "flamer-fire-big",
	scale = stream_radius_flamer_big,
	cluster = true,
	cluster_amount = cluster_amount_flamer_medium,
	cluster_distance = 3,
	cluster_distance_deviation = 3 ,
	cluster_projectile =  "flamer-big-fire-bomblet" , 
  }),
   fire_stream({
    name = "fire-stream-behemoth-flamer",
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6*stream_radius_flamer_behemoth,
   sticker_name = "flamer-fire-sticker-behemoth",
   blast_radius = stream_blastradius_flamer_behemoth,
  	damage = damage_modifier_flamer_behemoth,
	damage_type = "fire",
	entity_name = "flamer-fire-behemoth",
	scale = stream_radius_flamer_behemoth,
	cluster = true,
	cluster_amount = cluster_amount_flamer_behemoth,
	cluster_distance = 4,
	cluster_distance_deviation = 4 ,
	cluster_projectile =  "flamer-behemoth-fire-bomblet" , 
  }),
    fire_stream({
    name = "fire-stream-boss-flamer",
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6*stream_radius_flamer_boss,
   sticker_name = "flamer-fire-sticker-boss",
   blast_radius = stream_blastradius_flamer_boss,
   	damage = damage_modifier_flamer_boss,
	damage_type = "fire",
	entity_name = "flamer-fire-boss",
	scale = stream_radius_flamer_boss,
	cluster = true,
	cluster_amount = cluster_amount_flamer_boss,
	cluster_distance = 7,
	cluster_distance_deviation = 7 ,
	cluster_projectile =  "flamer-boss-fire-bomblet" , 
  }),
  
   -- POISON   S T I C K E R --------------------------------------------------------------------------------------------------------------
  
  acid_sticker({
    name = "small-stinger-sticker",
    tint = stinger_spawner_tint,
    slow_player_movement = slow_movement_multiplier_stinger,
    slow_seconds = slow_movement_time_stinger,
	stickers_per_square_meter = 10,
	sticker_scale = 0.75,
	sticker_damage = damage_stinger_small/5,
	sticker_damage_interval = 20,
  }),
  acid_sticker({
    name = "medium-stinger-sticker",
    tint = stinger_spawner_tint,
    slow_player_movement = slow_movement_multiplier_stinger ^ 1.2,
    slow_seconds = slow_movement_time_stinger + 1,
	stickers_per_square_meter = 10,
	sticker_scale = 0.75,
	sticker_damage = damage_stinger_medium/5,
	sticker_damage_interval = 20,
  }),
  acid_sticker({
    name = "big-stinger-sticker",
    tint = stinger_spawner_tint,
    slow_player_movement = slow_movement_multiplier_stinger ^ 1.4,
    slow_seconds = slow_movement_time_stinger + 2,
	stickers_per_square_meter = 10,
	sticker_scale = 0.75,
	sticker_damage = damage_stinger_big/5,
	sticker_damage_interval = 20,
  }),
  acid_sticker({
    name = "behemoth-stinger-sticker",
    tint = stinger_spawner_tint,
    slow_player_movement = slow_movement_multiplier_stinger ^ 1.6,
    slow_seconds = slow_movement_time_stinger + 3,
	stickers_per_square_meter = 10,
	sticker_scale = 0.75,
	sticker_damage = damage_stinger_behemoth/5,
	sticker_damage_interval = 20,
  }),
  acid_sticker({
    name = "boss-stinger-sticker",
    tint = stinger_spawner_tint,
    slow_player_movement = slow_movement_multiplier_stinger ^ 2.0,
    slow_seconds = slow_movement_time_stinger + 5,
	stickers_per_square_meter = 10,
	sticker_scale = 0.75,
	sticker_damage = damage_stinger_boss/5,
	sticker_damage_interval = 20,
  }),
  
  	-- HATCHER STREAM
  
   hatcher_stream({
		name = "egg-stream-small-hatcher",
		scale = small_hatcher_scale,
		tint = hatcher_spawner_tint,
		corpse_name = "hatcher-splash-stream-small",
		particle_spawn_interval = 1,
		particle_spawn_timeout = 6,
		splash_fire_name = "hatcher-splash-stream-small",
		damage_type = "physical",
		size = "small",
   }),
     hatcher_stream({
		name = "egg-stream-medium-hatcher",
		scale = medium_hatcher_scale,
		tint = hatcher_spawner_tint,
		corpse_name = "hatcher-splash-stream-medium",
		particle_spawn_interval = 1,
		particle_spawn_timeout = 6,
		splash_fire_name = "hatcher-splash-stream-medium",
		damage_type = "physical",
		size = "medium",
   }),
     hatcher_stream({
		name = "egg-stream-big-hatcher",
		scale = big_hatcher_scale,
		tint = hatcher_spawner_tint,
		corpse_name = "hatcher-splash-stream-big",
		particle_spawn_interval = 1,
		particle_spawn_timeout = 6,
		splash_fire_name = "hatcher-splash-stream-big",
		damage_type = "physical",
		size = "big",
   }),
     hatcher_stream({
		name = "egg-stream-behemoth-hatcher",
		scale = behemoth_hatcher_scale,
		tint = hatcher_spawner_tint,
		corpse_name = "hatcher-splash-stream-behemoth",
		particle_spawn_interval = 1,
		particle_spawn_timeout = 6,
		splash_fire_name = "hatcher-splash-stream-behemoth",
		damage_type = "physical",
		size = "behemoth",
   }),
     hatcher_stream({
		name = "egg-stream-boss-hatcher",
		scale = boss_hatcher_scale,
		tint = hatcher_spawner_tint,
		corpse_name = "hatcher-splash-stream-boss",
		particle_spawn_interval = 1,
		particle_spawn_timeout = 6,
		splash_fire_name = "hatcher-splash-stream-boss",
		damage_type = "physical",
		size = "boss",
   }),
  
	-- HATCHER SPLASH
  
    acid_splash_fire({
		name = "hatcher-splash-stream-small",
		scale = small_hatcher_scale ,
		tint = hatcher_spawner_tint,
		ground_patch_scale = small_hatcher_scale,
		patch_tint_multiplier = patch_opacity,
		splash_damage_per_tick = 0,
		damage_type = "physical",
		-- sticker_name = "acid-sticker-small",
		duration = 4,
	}),
	    acid_splash_fire({
		name = "hatcher-splash-stream-medium",
		scale = medium_hatcher_scale ,
		tint = hatcher_spawner_tint,
		ground_patch_scale = medium_hatcher_scale,
		patch_tint_multiplier = patch_opacity,
		splash_damage_per_tick = 0,
		damage_type = "physical",
		-- sticker_name = "acid-sticker-medium",
		duration = 4,
	}),
	    acid_splash_fire({
		name = "hatcher-splash-stream-big",
		scale = big_hatcher_scale ,
		tint = hatcher_spawner_tint,
		ground_patch_scale = big_hatcher_scale,
		patch_tint_multiplier = patch_opacity,
		splash_damage_per_tick = 0,
		damage_type = "physical",
		-- sticker_name = "acid-sticker-big",
		duration = 4,
	}),
	    acid_splash_fire({
		name = "hatcher-splash-stream-behemoth",
		scale = behemoth_hatcher_scale ,
		tint = hatcher_spawner_tint,
		ground_patch_scale = behemoth_hatcher_scale,
		patch_tint_multiplier = patch_opacity,
		splash_damage_per_tick = 0,
		damage_type = "physical",
		-- sticker_name = "acid-sticker-behemoth",
		duration = 4,
	}),
	    acid_splash_fire({
		name = "hatcher-splash-stream-boss",
		scale = boss_hatcher_scale ,
		tint = hatcher_spawner_tint,
		ground_patch_scale = boss_hatcher_scale,
		patch_tint_multiplier = patch_opacity,
		splash_damage_per_tick = 0,
		damage_type = "physical",
		-- sticker_name = "acid-sticker-boss",
		duration = 4,
	}),
  
})
