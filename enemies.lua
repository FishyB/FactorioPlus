require ("__factorioplus__.spawner-animation")
require ("__factorioplus__.enemies-stats")
require ("__base__.prototypes.entity.biter-animations")
require ("__base__.prototypes.entity.spitter-animations")
enemy_autoplace = require ("__base__.prototypes.entity.enemy-autoplace-utils")
require ("__base__.prototypes.entity.biter-ai-settings")
require ("__factorioplus__.spitter-projectiles")
require ("__factorioplus__.worm-animations")
require ("__factorioplus__.util-attack-helpers")
require ("__factorioplus__.explosions")


local powerscalingvalue = (settings.startup["settings-enemy-power-scaling"].value/100)

-- AI settings to fix wandering biters
biter_ai_settings = 
{ 
	destroy_when_commands_fail = true, 
	allow_try_return_to_spawner = true,
	do_separation = true,
	join_attacks = true,
	path_resolution_modifier = 0,
	size_in_group = 1.0
}

-- currently unused
-- TODO Use in the future.
-- Take in an enemy scale, and then change their path reolution accordingly to better path/optimizaitons.
function Create_AISettings(scale)
return
{ 
	destroy_when_commands_fail = true, 
	allow_try_return_to_spawner = true,
	do_separation = true,
	join_attacks = true,
	path_resolution_modifier = math.ceil( 1 - (scale * 1.25) ), 
	-- Defines how coarse the pathfinder's grid is, 
	-- where smaller values mean a coarser grid. Defaults to 0, 
	-- which equals a resolution of 1x1 tiles, centered on tile centers. 
	-- Values range from -8 to 8 inclusive, 
	-- where each integer increment doubles/halves the resolution. 
	-- So, a resolution of -8 equals a grid of 256x256 tiles, 
	-- and a resolution of 8 equals 1/256 of a tile.
	-- 1 = 1/2x1/2 0 = 1x1, -1 = 2x2, -2 =4x4, -3 = 8x8
	size_in_group = 0.25 + ( scale * 1 ) -- smaller units take up less space, larger take up more space. Generally this is related to power.
}
end


local sounds = require ("__base__.prototypes.entity.sounds")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")

-- Spawntime Setting

	local enemy_spawntime_scale = 1.0
	
	if settings.startup["settings-enemy-spawntime"].value == "easy" then
		enemy_spawntime_scale = 0.5
	elseif settings.startup["settings-enemy-spawntime"].value == "hard" then
		enemy_spawntime_scale = 1.5
	elseif settings.startup["settings-enemy-spawntime"].value == "extreme" then
		enemy_spawntime_scale = 2.0 
	elseif settings.startup["settings-enemy-spawntime"].value == "insane" then
		enemy_spawntime_scale = 3.0 
	end
	
	local enemy_health_scale = 1.0

	if settings.startup["settings-enemy-health"].value == "easy" then
		enemy_health_scale = 0.5
	elseif settings.startup["settings-enemy-health"].value == "hard" then
		enemy_health_scale = 1.5 
	elseif settings.startup["settings-enemy-health"].value == "extreme" then
		enemy_health_scale = 2.0 
	elseif settings.startup["settings-enemy-health"].value == "insane" then
		enemy_health_scale = 3.0 
	end

local function create_entity(entity, rad, probability, amount)
	return	
	{
		type = "nested-result",
		action =
		{
		  type = "cluster",
		  cluster_count = amount or 2,
		  distance = rad/3,
		  distance_deviation = rad/3,
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
			  {
					type = "create-entity",
					entity_name = entity,
					
					probability = probability * (settings.startup["settings-chunks-probability"].value/100) or 1 * (settings.startup["settings-chunks-probability"].value/100),
					as_enemy = false,
					--repeat_count = amount or 2,
					--repeat_count_deviation = math.ceil( amount),
					
					--check_buildability = true,
					--find_non_colliding_position  = true,
					--non_colliding_search_precision  = 0.25,
					--non_colliding_search_radius = 3,
					tile_collision_mask  = {not_colliding_with_itself = true, layers = {object = true} }
				}
			}
		  }
		}
	}
end

local count_deviation_mult_base = 2

function create_alien_package(data)
	local _size = data.size
	local _count = data.count or 1
	local _countdeviation_mult = data.count_deviation_mult or count_deviation_mult_base
	local _count_max = _count * _countdeviation_mult
	local _count_min = _count / _countdeviation_mult

	return
	{
		name = "alien-polyp".."-".._size,
		type = "simple-entity",
		
		localised_name = {"entity-name.alien-polyp"},
		localised_description = {"entity-description.alien-polyp"},
		
		flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
		icon = "__factorioplus__/graphics/icons/abandonment-package.png",
		icon_size = 64, icon_mipmaps = 4,
		
		collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
		selection_box = {{-1, -1}, {1, 1}},
		
		damaged_trigger_effect = hit_effects.biter(),
		impact_category = "organic",
		dying_explosion = "medium-biter-die",
		mined_sound = sounds.biter_dying(0.6),
		-- corpse = "small-remnants",
		minable =
		{
		  mining_time = 2,
		   results = 
		  {
			{type = "item", name = "chunky-meat" , amount_min = _count_min, amount_max = _count_max}, 
		  },
		},
		render_layer = "object",
		max_health = 300,
		resistances =
	   {
			{
			type = "acid",
			percent = 99
		  },
		  {
			type = "physical",
			percent = 25
		  },
		},
		animations  = 
		{
		
			layers =
			{
			  {
				filename = "__factorioplus__/graphics/enemies/alien_polyp_s.png",
				priority="high",
				width = 996/4,
				height = 438/2,
				frame_count = 8,
				line_length = 4,
				animation_speed = 0.1,
				run_mode = "forward-then-backward",
				shift = util.by_pixel(0, 0),
				scale = 0.4
			  },
			  {
				filename = "__factorioplus__/graphics/enemies/alien_polyp_s_shadow.png",
				priority="high",
				width = 996/4,
				height = 438/2,
				frame_count = 8,
				line_length = 4,
				animation_speed = 0.1,
				run_mode = "forward-then-backward",
				draw_as_shadow = true,
				shift = util.by_pixel(0, 0),
				scale = 0.4
			  }
			},
		},
    }	
end

data:extend({
	create_alien_package(
	{
		size = "small",
		count = 6,
	}),
	create_alien_package(
	{
		size = "medium",
		count = 10
	}),
	create_alien_package(
	{
		size = "big",
		count = 16
	}),
	create_alien_package(
	{
		size = "behemoth",
		count = 24
	}),
	create_alien_package(
	{
		size = "boss",
		count = 34
	}),
})

local make_unit_melee_ammo_type = function(damage_value)
local _showtooltip = false
if (damage_value ~= 0 ) then 
	_showtooltip = true 
end

  return
  {
    target_type = "entity",
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "damage",
		  show_in_tooltip = _showtooltip,
          damage = { amount = damage_value , type = "physical"}
        }
      }
    }
  }
end

local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

function makeenemyattack(name, type, damage, speed, scale, range, tint)

local mea_attack_speed = speed + ( (scale/3) * 60 )

	if (type == "bite") then
	return
	{
	  type = "projectile",
	  range = range * scale,
	  cooldown = mea_attack_speed,
	  cooldown_deviation = 0.1 * scale,
	  ammo_category = "melee",
	  ammo_type = make_unit_melee_ammo_type(damage),
	  sound = sounds.biter_roars(0.5 * scale),
	  animation = biterattackanimation(scale, tint, tint)
	}
	elseif (type == "sting") then
	return
	{
	  type = "projectile",
	  range = range * scale,
	  cooldown = mea_attack_speed,
	  cooldown_deviation = 0.1 * scale,
	  ammo_category = "melee",  
	  ammo_type =
	  {
		target_type = "entity",
		action =
		{
		  type = "direct",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
				{
				  type = "damage",
				  damage = { amount = damage , type = "physical"}
				},
				{
				  type = "create-sticker",
				  sticker = name .. "-sticker",
				  show_in_tooltip = true
				},
			}
		  }
		}
	  },
	  sound = sounds.biter_roars(0.5 * scale),
	  animation = biterattackanimation(scale, tint, tint)
	}
	elseif (type == "explode") then
	return 
	{
      type = "projectile",
      range = 1 * scale,
      cooldown = mea_attack_speed,
	  ammo_category = "melee",
      ammo_type = 
	    {
			category = "melee",
			target_type = "direction",
			action =
		  {
			{
			  type = "direct",
			  repeat_count = 1,
			  action_delivery =
			  {
				type = "projectile",
				projectile = name .. "-pellet",
				starting_speed = 1,
				starting_speed_deviation = 0,
				direction_deviation = 0,
				range_deviation = 0,
				max_range = 0,
			  }
			},
			
		  }
		},
      sound = sounds.biter_roars(0.35),
      animation = biterattackanimation(scale, tint, tint)
    }
	elseif (type == "spit") then
	return  
	spitter_attack_parameters(
		{
		name = name,
		ammo_category = "biological",
		acid_stream_name = "acid-stream".."-"..name,
		range = range,
		min_attack_distance = 10 * scale,
		cooldown = mea_attack_speed,
		cooldown_deviation = 0.15,
		--lifetime = 30 * scale,
		damage_modifier = damage,
		scale = scale,
		tint1 = tint,
		tint2 = tint,
		roarvolume = 0.4 * scale
		}
	)
	elseif (type == "web") then
	return  
	spitter_attack_parameters(
		{
		name = name,
		ammo_category = "biological",
		acid_stream_name = "web-stream".."-"..name,
		range = range,
		
		min_attack_distance = 12 * scale,
		cooldown = mea_attack_speed,
		cooldown_deviation = 0.15,
		--lifetime = 30 * scale,
		damage_modifier = damage,
		scale = scale,
		tint1 = tint,
		tint2 = tint,
		roarvolume = 0.4 * scale
		}
	)
	elseif (type == "flame") then
	return  
	spitter_attack_parameters(
		{
		name = name,
		ammo_category = "biological",
		acid_stream_name = "fire-stream".."-"..name,
		range = range,
		min_attack_distance = 10 * scale,
		cooldown = mea_attack_speed,
		cooldown_deviation = 0.15,
		--lifetime = 30 * scale,
		damage_modifier = damage,
		scale = scale,
		tint1 = tint,
		tint2 = tint,
		roarvolume = 0.5 * scale
		}
	)
	elseif (type == "egg") then
	return  
	spitter_attack_parameters(
		{
		name = name,
		ammo_category = "biological",
		acid_stream_name = "egg-stream".."-"..name,
		range = range,
		min_attack_distance = 10 * scale,
		cooldown = mea_attack_speed,
		cooldown_deviation = 0.15,
		--lifetime = 30 * scale,
		damage_modifier = damage,
		scale = scale,
		tint1 = tint,
		tint2 = tint,
		roarvolume = 0.5 * scale
		}
	)
	else
	return 
	{
	error("no type")
	}
	end
end

-- PROJECTILE HELPER

function makeblasterprojectile(n, d, r, hp)
return 
{
    type = "projectile",
    name = n,
    flags = {"not-on-map"},
    collision_box = {{-0.05, -0.05}, {0.05, 0.05}},
    acceleration = 0,
    direction_only = true,
    final_action =
    {
		{
			type = "area",
			radius = 2,
			show_in_tooltip = false,
			force = "same",
			action_delivery =
			{
			  type = "instant",
			  target_effects =
			  {
				{
				  type = "damage",
				  damage = {amount = hp * enemy_health_scale, type = "piercing"}
				},	
			  },	
			},
		},
		make_single_explosion_area(d, r, 1, 3, 3) ,
		make_single_explosion_area(d, r, 1, 3, 2) ,
		make_single_explosion_area(d, r, 1, 3, 1)
	}
}
end

-- Health Setting



data:extend({
  
  ----------------------------------------------------------  BITER SPAWNER  ----------------------------------------------------------

  {
    type = "unit-spawner",
    name = "biter-spawner",
    icon = "__base__/graphics/icons/biter-spawner.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "not-repairable"},
    max_health = 100,
    order="b-d-a",
    subgroup="enemies",
	loot = spawner_medium_loot,
    resistances =
    {
      {
        type = "physical",
        decrease = 2,
        percent = 30
      },
      {
        type = "explosion",
        decrease = 5,
        percent = 25
      },

    },
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/creatures/spawner.ogg",
          volume = 0.6
        }
      },
    },
    dying_sound =
    {
      {
        filename = "__base__/sound/creatures/spawner-death-1.ogg",
        volume = 1.0
      },
      {
        filename = "__base__/sound/creatures/spawner-death-2.ogg",
        volume = 1.0
      }
    },
    healing_per_tick = 0.02,
    collision_box = {{-3.2, -2.2}, {2.2, 2.2}},
    map_generator_bounding_box = {{-5.0, -5.0}, {5.0, 5.0}},
    selection_box = {{-3.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.biter(),
    -- in ticks per 1 pu
    absorptions_per_second = { pollution = { absolute = 20, proportional = 0.01 } },
    corpse = "biter-spawner-corpse",
    dying_explosion = "biter-spawner-die",
    max_count_of_owned_units = spawning_amount_biter,
    max_friends_around_to_spawn = spawning_amount_biter,
	graphics_set = 
	{
		animations =
		{
		  spawner_idle_animation(0, biter_spawner_tint),
		  spawner_idle_animation(1, biter_spawner_tint),
		  spawner_idle_animation(2, biter_spawner_tint),
		  spawner_idle_animation(3, biter_spawner_tint)
		},
	},
   
    integration =
    {
      sheet = spawner_integration()
    },
    result_units = (function()
                     local res = {}
                     res[1] = {"small-biter", {{0.0, 0.3}, {0.6, 0.1}}}
                     if not data.is_demo then
                       res[2] = {"medium-biter", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.2}}}
                       res[3] = {"big-biter", {{0.5, 0.0}, {1.0, 0.6}}}
                       res[4] = {"behemoth-biter", {{0.8, 0.0}, {1.0, 0.9}}}
					   res[5] = {"boss-biter", {{0.9, 0.0}, {1.0, 0.05}}}
                     end
                     return res
                   end)(),
    -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
    spawning_cooldown = {360, 150},
    spawning_radius = 10,
    spawning_spacing = 3,
    max_spawn_shift = 0,
    max_richness_for_spawn_shift = 100,
    --  autoplace = enemy_autoplace.enemy_spawner_autoplace(0.4),
	build_base_evolution_requirement = 10,
    call_for_help_radius = 50,
    spawn_decorations_on_expansion = true,
    spawn_decoration =
    {
      {
        decorative = "light-mud-decal",
        spawn_min = 0,
        spawn_max = 2,
        spawn_min_radius = 2,
        spawn_max_radius = 5,
      },
      {
        decorative = "dark-mud-decal",
        spawn_min = 0,
        spawn_max = 3,
        spawn_min_radius = 2,
        spawn_max_radius = 6,
      },
      {
        decorative = "enemy-decal",
        spawn_min = 3,
        spawn_max = 5,
        spawn_min_radius = 2,
        spawn_max_radius = 7,
      },
      {
        decorative = "enemy-decal-transparent",
        spawn_min = 4,
        spawn_max = 20,
        spawn_min_radius = 2,
        spawn_max_radius = 14,
        radius_curve = 0.9
      },
      {
        decorative = "muddy-stump",
        spawn_min = 2,
        spawn_max = 5,
        spawn_min_radius = 3,
        spawn_max_radius = 6,
      },
      {
        decorative = "red-croton",
        spawn_min = 2,
        spawn_max = 8,
        spawn_min_radius = 3,
        spawn_max_radius = 6,
      },
      {
        decorative = "red-pita",
        spawn_min = 1,
        spawn_max = 5,
        spawn_min_radius = 3,
        spawn_max_radius = 6,
      },
    }
  },

  {
    type = "corpse",
    name = "biter-spawner-corpse",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/biter-spawner-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    dying_speed = 0.04,
    time_before_removed = 15 * 60 * 60,
    subgroup="corpses",
    order = "c[corpse]-b[biter-spawner]",
    final_render_layer = "remnants",
    animation =
    {
      spawner_die_animation(0, biter_spawner_tint),
      spawner_die_animation(1, biter_spawner_tint),
      spawner_die_animation(2, biter_spawner_tint),
      spawner_die_animation(3, biter_spawner_tint)
    },
    ground_patch =
    {
      sheet = spawner_integration()
    }
  },
  
    ----------------------------------------------------------  spitter SPAWNER  ----------------------------------------------------------

  {
    type = "unit-spawner",
    name = "spitter-spawner",
    icon = "__base__/graphics/icons/spitter-spawner.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "not-repairable"},
    max_health = 100,
    order="b-d-b",
    subgroup="enemies",
	loot = spawner_medium_loot,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/creatures/spawner-spitter.ogg",
          volume = 0.6
        }
      },
    },
    dying_sound =
    {
      {
        filename = "__base__/sound/creatures/spawner-death-1.ogg",
        volume = 1.0
      },
      {
        filename = "__base__/sound/creatures/spawner-death-2.ogg",
        volume = 1.0
      }
    },
    resistances =
    {
      {
        type = "physical",
        decrease = 2,
        percent = 15
      },
      {
        type = "explosion",
        decrease = 5,
        percent = 15
      },
      {
        type = "fire",
        decrease = 3,
        percent = 60
      },
	  {
        type = "acid",
        percent = 100
      }
    },
    healing_per_tick = 0.02,
    collision_box = {{-3.2 * spitter_spawner_scale, -2.2* spitter_spawner_scale}, {2.2* spitter_spawner_scale, 2.2* spitter_spawner_scale}},
    map_generator_bounding_box = {{-6.0, -6.0}, {6.0, 6.0}},
    selection_box = {{-3.5* spitter_spawner_scale, -2.5* spitter_spawner_scale}, {2.5* spitter_spawner_scale, 2.5* spitter_spawner_scale}},
    damaged_trigger_effect = hit_effects.biter(),
    absorptions_per_second = { pollution = { absolute = 20, proportional = 0.01 } },
    corpse = "spitter-spawner-corpse",
    dying_explosion = "spitter-spawner-die",
    max_count_of_owned_units = spawning_amount_spitter,
    max_friends_around_to_spawn = spawning_amount_spitter,
	 graphics_set = 
	 {
		 animations =
		{
		  spawner_idle_animation(0, spitter_spawner_tint, spitter_spawner_scale),
		  spawner_idle_animation(1, spitter_spawner_tint, spitter_spawner_scale),
		  spawner_idle_animation(2, spitter_spawner_tint, spitter_spawner_scale),
		  spawner_idle_animation(3, spitter_spawner_tint, spitter_spawner_scale)
		},
	},
    
    integration = spawner_integration(spitter_spawner_scale),
    result_units = (function()
                     local res = {}
                     res[1] = {"small-spitter", {{0.0, 0.3}, {0.35, 0}}}
                     res[2] = {"small-spitter", {{0.25, 0.0}, {0.5, 0.3}, {0.7, 0.0}}}
                     res[3] = {"medium-spitter", {{0.4, 0.0}, {0.7, 0.3}, {0.9, 0.1}}}
                     res[4] = {"big-spitter", {{0.5, 0.0}, {1.0, 0.4}}}
                     res[5] = {"behemoth-spitter", {{0.8, 0.0}, {1.0, 0.7}}}
					 res[6] = {"boss-spitter", {{0.92, 0.0}, {1.0, 0.05}}}
                     return res
                   end)(),
    -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
    spawning_cooldown = {360, 150},
    spawning_radius = 10,
    spawning_spacing = 4,
    max_spawn_shift = 0,
    max_richness_for_spawn_shift = 100,
    -- distance_factor used to be 1, but Twinsen says:
    -- "The number or spitter spwners should be roughly equal to the number of biter spawners(regardless of difficulty)."
    -- (2018-12-07)
    -- autoplace = enemy_autoplace.enemy_spawner_autoplace(0.7),
	build_base_evolution_requirement = 10,
    call_for_help_radius = 50,
    spawn_decorations_on_expansion = true,
    spawn_decoration =
    {
      {
        decorative = "light-mud-decal",
        spawn_min = 0,
        spawn_max = 2,
        spawn_min_radius = 2,
        spawn_max_radius = 5,
      },
      {
        decorative = "dark-mud-decal",
        spawn_min = 0,
        spawn_max = 3,
        spawn_min_radius = 2,
        spawn_max_radius = 6,
      },
      {
        decorative = "enemy-decal",
        spawn_min = 3,
        spawn_max = 5,
        spawn_min_radius = 2,
        spawn_max_radius = 7,
      },
      {
        decorative = "enemy-decal-transparent",
        spawn_min = 4,
        spawn_max = 20,
        spawn_min_radius = 2,
        spawn_max_radius = 14,
        radius_curve = 0.9
      },
      {
        decorative = "muddy-stump",
        spawn_min = 2,
        spawn_max = 5,
        spawn_min_radius = 3,
        spawn_max_radius = 6,
      },
      {
        decorative = "red-croton",
        spawn_min = 2,
        spawn_max = 8,
        spawn_min_radius = 3,
        spawn_max_radius = 6,
      },
      {
        decorative = "red-pita",
        spawn_min = 1,
        spawn_max = 5,
        spawn_min_radius = 3,
        spawn_max_radius = 6,
      },
      {
        decorative = "lichen-decal",
        spawn_min = 1,
        spawn_max = 2,
        spawn_min_radius = 2,
        spawn_max_radius = 7
      },
    }
  },

  {
    type = "corpse",
    name = "spitter-spawner-corpse",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/biter-spawner-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    dying_speed = 0.04,
    time_before_removed = 15 * 60 * 60,
    subgroup="corpses",
    order = "c[corpse]-c[spitter-spawner]",
    final_render_layer = "remnants",
    animation =
    {
      spawner_die_animation(0, spitter_spawner_tint,spitter_spawner_scale),
      spawner_die_animation(1, spitter_spawner_tint,spitter_spawner_scale),
      spawner_die_animation(2, spitter_spawner_tint,spitter_spawner_scale),
      spawner_die_animation(3, spitter_spawner_tint,spitter_spawner_scale)
    },
    ground_patch =
    {
      sheet = spawner_integration(spitter_spawner_scale)
    }
  },
  
   ---------------------------------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------  WORMS  ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
  
   ----------------------------------------------------------  SMALL WORM  ----------------------------------------------------------
   
   {
    type = "turret",
    name = "small-worm-turret",
    icon = "__base__/graphics/icons/small-worm.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
    order="b-c-a",
    max_health = health_small_worm * enemy_health_scale,
    subgroup="enemies",
    resistances = 
	{
      {
        type = "physical",
		percent = math.ceil( 15 * scale_worm_small )
      },
	  	  {
        type = "piercing",
        percent =  math.ceil( 20 * scale_worm_small )
      },
      {
        type = "explosion",
        percent = math.ceil( 25 * scale_worm_small )
      },
      {
        type = "fire",
        percent =  math.ceil( 30 * scale_worm_small )
      },
	  {
        type = "acid",
        percent = 100
      }
	},
    healing_per_tick = 0.05 * scale_worm_small,
    collision_box = {{-0.9 * scale_worm_small, -0.8 * scale_worm_small }, {0.9 * scale_worm_small, 0.8 * scale_worm_small}},
    map_generator_bounding_box = {{-worm_collision_map_scale_base * scale_worm_small - worm_collision_map_scale_addition, -worm_collision_map_scale_base * scale_worm_small - worm_collision_map_scale_addition}, {worm_collision_map_scale_base * scale_worm_small + worm_collision_map_scale_addition, worm_collision_map_scale_base * scale_worm_small + worm_collision_map_scale_addition}},
    selection_box = {{-0.9 * scale_worm_small, -0.8  * scale_worm_small}, {0.9 * scale_worm_small, 0.8 * scale_worm_small}},
    damaged_trigger_effect = hit_effects.biter(),
    shooting_cursor_size = 3,
    corpse = "small-worm-corpse",
    dying_explosion = "small-worm-die",
	loot = boss_loot,
	graphics_set = {},
    dying_sound = sounds.worm_dying_small(1.0 * scale_worm_small),
    folded_speed = 0.02 / scale_worm_small,
    folded_speed_secondary = 0.02/ scale_worm_small,
    folded_animation = worm_folded_animation(scale_worm_small, tint_worm_small),
    preparing_speed = 0.02/ scale_worm_small,
    preparing_animation = worm_preparing_animation(scale_worm_small, tint_worm_small, "forward"),
    preparing_sound = sounds.worm_standup_small(1),
    prepared_speed = 0.02/ scale_worm_small,
    prepared_speed_secondary = 0.025 / scale_worm_small,
    prepared_sound = sounds.worm_breath(0.6 / scale_worm_small),
    prepared_animation = worm_prepared_animation(scale_worm_small, tint_worm_small),
    prepared_alternative_speed = 0.02/ scale_worm_small,
    prepared_alternative_speed_secondary = 0.025 / scale_worm_small,
    prepared_alternative_chance = 0.2/ scale_worm_small,
    prepared_alternative_animation = worm_prepared_alternative_animation(scale_worm_small, tint_worm_small),
    prepared_alternative_sound = sounds.worm_roar_alternative(0.64/ scale_worm_small),
    starting_attack_speed = 0.03/ scale_worm_small,
    starting_attack_animation = worm_start_attack_animation(scale_worm_small, tint_worm_small),
    starting_attack_sound = sounds.worm_roars(0.62/ scale_worm_small),
    ending_attack_speed = 0.02/ scale_worm_small,
    ending_attack_animation = worm_end_attack_animation(scale_worm_small, tint_worm_small),
    folding_speed = 0.02/ scale_worm_small,
    folding_animation =  worm_preparing_animation(scale_worm_small, tint_worm_small, "backward"),
    folding_sound = sounds.worm_fold(1),
    secondary_animation = true,
    random_animation_offset = true,
    attack_from_start_frame = true,

    integration = worm_integration(scale_worm_small),
    prepare_range = range_worm_small + prepare_range_worm_small,
    allow_turning_when_starting_attack = true,
    attack_parameters =
    {
      type = "stream",
      cooldown = worm_attack_speed_base * scale_worm_small,
      range = range_worm_small,--defined in spitter-projectiles.lua
      damage_modifier = damage_modifier_worm_small,--defined in spitter-projectiles.lua
      min_range = range_worm_small_min,
      projectile_creation_parameters = worm_shoot_shiftings(scale_worm_small, scale_worm_small * scale_worm_stream),
      use_shooter_direction = true,

      lead_target_for_projectile_speed = 0.2* 0.75 * 1.5 *1.5, -- this is same as particle horizontal speed of flamethrower fire stream

	ammo_category = "biological",
      ammo_type =
      {
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "acid-stream-worm-small",
            source_offset = {0.15, -0.5}
          }
        }
      },
    },
    autoplace = enemy_autoplace.enemy_worm_autoplace("enemy_autoplace_base("..autoplace_worm_small * powerscalingvalue..","..(autoplace_worm_small * powerscalingvalue )..")"),
    call_for_help_radius = 40,
    spawn_decorations_on_expansion = true,
    spawn_decoration =
    {
      {
        decorative = "worms-decal",
        spawn_min = 0,
        spawn_max = 2,
        spawn_min_radius = 1,
        spawn_max_radius = 2
      },
      {
        decorative = "shroom-decal",
        spawn_min = 1,
        spawn_max = 1,
        spawn_min_radius = 1,
        spawn_max_radius = 2
      },
      {
        decorative = "enemy-decal",
        spawn_min = 1,
        spawn_max = 2,
        spawn_min_radius = 0,
        spawn_max_radius = 1
      },
      {
        decorative = "enemy-decal-transparent",
        spawn_min = 2,
        spawn_max = 4,
        spawn_min_radius = 1,
        spawn_max_radius = 2
      }
    }
  },
   {
    type = "corpse",
    name = "small-worm-corpse",
    icon = "__base__/graphics/icons/small-worm-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selectable_in_game = false,
    dying_speed = 0.01,
    time_before_removed = 15 * 60 * 60,
    subgroup="corpses",
    order = "c[corpse]-c[worm]-a[small]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
    final_render_layer = "lower-object-above-shadow",
    animation = worm_die_animation(scale_worm_small, tint_worm_small),
    ground_patch =
    {
      sheet = worm_integration(scale_worm_small)
    }
  },
 
 ----------------------------------------------------------  MEDIUM WORM  ----------------------------------------------------------
 
  {
    type = "turret",
    name = "medium-worm-turret",
    icon = "__base__/graphics/icons/medium-worm.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
    order="b-c-b",
    subgroup="enemies",
    max_health = health_medium_worm * enemy_health_scale,
    resistances =
    {
      {
        type = "physical",
		percent = math.ceil( 15 * scale_worm_medium )
      },
	  {
        type = "piercing",
        percent =  math.ceil( 20 * scale_worm_medium )
      },
      {
        type = "explosion",
        percent = math.ceil( 25 * scale_worm_medium )
      },
      {
        type = "fire",
        percent =  math.ceil( 30 * scale_worm_medium )
      },

	  {
        type = "acid",
        percent = 100
      }
    },
    healing_per_tick = 0.05 * scale_worm_medium,
    collision_box = {{-0.9 * scale_worm_medium, -0.8 * scale_worm_medium }, {0.9 * scale_worm_medium, 0.8 * scale_worm_medium}},
    map_generator_bounding_box = {{-worm_collision_map_scale_base * scale_worm_medium - worm_collision_map_scale_addition, -worm_collision_map_scale_base * scale_worm_medium - worm_collision_map_scale_addition}, {worm_collision_map_scale_base * scale_worm_medium + worm_collision_map_scale_addition, worm_collision_map_scale_base * scale_worm_medium + worm_collision_map_scale_addition}},
    selection_box = {{-0.9 * scale_worm_medium, -0.8  * scale_worm_medium}, {0.9 * scale_worm_medium, 0.8 * scale_worm_medium}},
    damaged_trigger_effect = hit_effects.biter(),
    shooting_cursor_size = 3.5,
    rotation_speed = 1,
    corpse = "medium-worm-corpse",
	dying_explosion = "small-worm-die",
	loot = spawner_small_loot,
	graphics_set = {},
    dying_sound = sounds.worm_dying_small(1.0 * scale_worm_medium),
    folded_speed = 0.02 / scale_worm_medium,
    folded_speed_secondary = 0.02/ scale_worm_medium,
    folded_animation = worm_folded_animation(scale_worm_medium, tint_worm_small),
    preparing_speed = 0.02/ scale_worm_medium,
    preparing_animation = worm_preparing_animation(scale_worm_medium, tint_worm_small, "forward"),
    preparing_sound = sounds.worm_standup_small(1),
    prepared_speed = 0.02/ scale_worm_medium,
    prepared_speed_secondary = 0.025 / scale_worm_medium,
    prepared_sound = sounds.worm_breath(0.6 / scale_worm_medium),
    prepared_animation = worm_prepared_animation(scale_worm_medium, tint_worm_small),
    prepared_alternative_speed = 0.02/ scale_worm_medium,
    prepared_alternative_speed_secondary = 0.025 / scale_worm_medium,
    prepared_alternative_chance = 0.2/ scale_worm_medium,
    prepared_alternative_animation = worm_prepared_alternative_animation(scale_worm_medium, tint_worm_small),
    prepared_alternative_sound = sounds.worm_roar_alternative(0.64/ scale_worm_medium),
    starting_attack_speed = 0.03/ scale_worm_medium,
    starting_attack_animation = worm_start_attack_animation(scale_worm_medium, tint_worm_small),
    starting_attack_sound = sounds.worm_roars(0.62/ scale_worm_medium),
    ending_attack_speed = 0.02/ scale_worm_medium,
    ending_attack_animation = worm_end_attack_animation(scale_worm_medium, tint_worm_small),
    folding_speed = 0.02/ scale_worm_medium,
    folding_animation =  worm_preparing_animation(scale_worm_medium, tint_worm_small, "backward"),
    folding_sound = sounds.worm_fold(1),
	
    secondary_animation = true,
    random_animation_offset = true,
    attack_from_start_frame = true,

    integration = worm_integration(scale_worm_medium),
    prepare_range = range_worm_medium + prepare_range_worm_medium,
    allow_turning_when_starting_attack = true,

    attack_parameters =
    {
      type = "stream",
      cooldown = worm_attack_speed_base * scale_worm_medium,
      range = range_worm_medium,--defined in spitter-projectiles.lua
      damage_modifier = damage_modifier_worm_medium,--defined in spitter-projectiles.lua
      min_range = range_worm_medium_min,
      projectile_creation_parameters = worm_shoot_shiftings(scale_worm_medium, scale_worm_medium * scale_worm_stream),

      use_shooter_direction = true,

      lead_target_for_projectile_speed = 0.2* 0.75 * 1.5 *1.5, -- this is same as particle horizontal speed of flamethrower fire stream

	ammo_category = "biological",
      ammo_type =
      {
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "acid-stream-worm-medium",
            source_offset = {0.15, -0.5}
          }
        }
      }
    },
    build_base_evolution_requirement = 0.3,
    autoplace = enemy_autoplace.enemy_worm_autoplace("enemy_autoplace_base("..autoplace_worm_medium * powerscalingvalue..","..(autoplace_worm_medium * powerscalingvalue )..")"),
    call_for_help_radius = 40,
    spawn_decorations_on_expansion = true,
    spawn_decoration =
    {
      {
        decorative = "worms-decal",
        spawn_min = 1,
        spawn_max = 2,
        spawn_min_radius = 1,
        spawn_max_radius = 3
      },
      {
        decorative = "shroom-decal",
        spawn_min = 1,
        spawn_max = 2,
        spawn_min_radius = 1,
        spawn_max_radius = 2
      },
      {
        decorative = "enemy-decal",
        spawn_min = 1,
        spawn_max = 3,
        spawn_min_radius = 0,
        spawn_max_radius = 3
      },
      {
        decorative = "enemy-decal-transparent",
        spawn_min = 2,
        spawn_max = 4,
        spawn_min_radius = 1,
        spawn_max_radius = 3
      }
    }
  },
  
  
  {
    type = "corpse",
    name = "medium-worm-corpse",
    icon = "__base__/graphics/icons/medium-worm-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selectable_in_game = false,
    subgroup="corpses",
    order = "c[corpse]-c[worm]-b[medium]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
    dying_speed = 0.01,
    time_before_removed = 15 * 60 * 60,
    final_render_layer = "lower-object-above-shadow",
    animation = worm_die_animation(scale_worm_medium, tint_worm_medium),
    ground_patch =
    {
      sheet = worm_integration(scale_worm_medium)
    }
  },
  
 ----------------------------------------------------------  BIG WORM  ----------------------------------------------------------

  {
    type = "turret",
    name = "big-worm-turret",
    icon = "__base__/graphics/icons/big-worm.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
    max_health = health_big_worm * enemy_health_scale,
    order="b-c-c",
    subgroup="enemies",
    resistances =
    {
      {
        type = "physical",
		percent = math.ceil( 15 * scale_worm_big )
      },
	  {
        type = "piercing",
        percent =  math.ceil( 20 * scale_worm_big )
      },
      {
        type = "explosion",
        percent = math.ceil( 25 * scale_worm_big )
      },
      {
        type = "fire",
        percent =  math.ceil( 30 * scale_worm_big )
      },
	  {
        type = "acid",
        percent = 100
      }
    },
    healing_per_tick = 0.05 * scale_worm_big,
collision_box = {{-0.9 * scale_worm_big, -0.8 * scale_worm_big }, {0.9 * scale_worm_big, 0.8 * scale_worm_big}},
    map_generator_bounding_box = {{-worm_collision_map_scale_base * scale_worm_big - worm_collision_map_scale_addition, -worm_collision_map_scale_base * scale_worm_big - worm_collision_map_scale_addition}, {worm_collision_map_scale_base * scale_worm_big + worm_collision_map_scale_addition, worm_collision_map_scale_base * scale_worm_big + worm_collision_map_scale_addition}},
    selection_box = {{-0.9 * scale_worm_big, -0.8  * scale_worm_big}, {0.9 * scale_worm_big, 0.8 * scale_worm_big}},
    damaged_trigger_effect = hit_effects.biter(),
    shooting_cursor_size = 4,
    rotation_speed = 1,
    corpse = "big-worm-corpse",
    dying_explosion = "big-worm-die",
	loot = spawner_medium_loot,
    graphics_set = {},
    dying_sound = sounds.worm_dying_small(1.0 * scale_worm_big),
    folded_speed = 0.02 / scale_worm_big,
    folded_speed_secondary = 0.02/ scale_worm_big,
    folded_animation = worm_folded_animation(scale_worm_big, tint_worm_small),
    preparing_speed = 0.02/ scale_worm_big,
    preparing_animation = worm_preparing_animation(scale_worm_big, tint_worm_small, "forward"),
    preparing_sound = sounds.worm_standup_small(1),
    prepared_speed = 0.02/ scale_worm_big,
    prepared_speed_secondary = 0.025 / scale_worm_big,
    prepared_sound = sounds.worm_breath(0.6 / scale_worm_big),
    prepared_animation = worm_prepared_animation(scale_worm_big, tint_worm_small),
    prepared_alternative_speed = 0.02/ scale_worm_big,
    prepared_alternative_speed_secondary = 0.025 / scale_worm_big,
    prepared_alternative_chance = 0.2/ scale_worm_big,
    prepared_alternative_animation = worm_prepared_alternative_animation(scale_worm_big, tint_worm_small),
    prepared_alternative_sound = sounds.worm_roar_alternative(0.64/ scale_worm_big),
    starting_attack_speed = 0.03/ scale_worm_big,
    starting_attack_animation = worm_start_attack_animation(scale_worm_big, tint_worm_small),
    starting_attack_sound = sounds.worm_roars(0.62/ scale_worm_big),
    ending_attack_speed = 0.02/ scale_worm_big,
    ending_attack_animation = worm_end_attack_animation(scale_worm_big, tint_worm_small),
    folding_speed = 0.02/ scale_worm_big,
    folding_animation =  worm_preparing_animation(scale_worm_big, tint_worm_small, "backward"),
    folding_sound = sounds.worm_fold(1),
	
    integration = worm_integration(scale_worm_big),
    secondary_animation = true,
    random_animation_offset = true,
    attack_from_start_frame = true,

    prepare_range = range_worm_big + prepare_range_worm_big,
    allow_turning_when_starting_attack = true,
    attack_parameters =
    {
      type = "stream",
      damage_modifier = damage_modifier_worm_big,--defined in spitter-projectiles.lua
      cooldown = worm_attack_speed_base * scale_worm_big,
      range = range_worm_big,--defined in spitter-projectiles.lua
      min_range = range_worm_big_min,
      projectile_creation_parameters = worm_shoot_shiftings(scale_worm_big, scale_worm_big * scale_worm_stream),

      use_shooter_direction = true,

      lead_target_for_projectile_speed = 0.2* 0.75 * 1.5 * 1.5, -- this is same as particle horizontal speed of flamethrower fire stream
	
	ammo_category = "biological",
      ammo_type =
      {
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "acid-stream-worm-big",
            source_offset = {0.15, -0.5}
          }
        }
      }
    },
    build_base_evolution_requirement = 0.5,
    autoplace = enemy_autoplace.enemy_worm_autoplace("enemy_autoplace_base("..autoplace_worm_big * powerscalingvalue..","..(autoplace_worm_big * powerscalingvalue )..")"),
    call_for_help_radius = 40,
    spawn_decorations_on_expansion = true,
    spawn_decoration =
    {
      {
        decorative = "worms-decal",
        spawn_min = 1,
        spawn_max = 2,
        spawn_min_radius = 1,
        spawn_max_radius = 4
      },
      {
        decorative = "shroom-decal",
        spawn_min = 1,
        spawn_max = 2,
        spawn_min_radius = 1,
        spawn_max_radius = 2
      },
      {
        decorative = "enemy-decal",
        spawn_min = 1,
        spawn_max = 4,
        spawn_min_radius = 1,
        spawn_max_radius = 3
      },
      {
        decorative = "enemy-decal-transparent",
        spawn_min = 3,
        spawn_max = 5,
        spawn_min_radius = 1,
        spawn_max_radius = 4
      }
    }
  },
  {
    type = "corpse",
    name = "big-worm-corpse",
    icon = "__base__/graphics/icons/big-worm-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selectable_in_game = false,
    subgroup="corpses",
    order = "c[corpse]-c[worm]-c[big]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
    dying_speed = 0.01,
    time_before_removed = 15 * 60 * 60,
    final_render_layer = "lower-object-above-shadow",
    animation = worm_die_animation(scale_worm_big, tint_worm_big),
    ground_patch =
    {
      sheet = worm_integration(scale_worm_big)
    }
  },
  
   ----------------------------------------------------------  BOHEMOTH WORM  ----------------------------------------------------------
  
  {
    type = "turret",
    name = "behemoth-worm-turret",
    icon = "__base__/graphics/icons/behemoth-worm.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
    max_health = health_behemoth_worm * enemy_health_scale,
    order="b-c-d",
    subgroup="enemies",
    resistances =
    {
      {
        type = "physical",
		percent = math.ceil( 15 * scale_worm_behemoth )
      },
	  {
        type = "piercing",
        percent =  math.ceil( 20 * scale_worm_behemoth )
      },
      {
        type = "explosion",
        percent = math.ceil( 25 * scale_worm_behemoth )
      },
      {
        type = "fire",
        percent =  math.ceil( 30 * scale_worm_behemoth )
      },
	  {
        type = "acid",
        percent = 100
      }
    },
    healing_per_tick = 0.05 * scale_worm_behemoth,
	collision_box = {{-0.9 * scale_worm_behemoth, -0.8 * scale_worm_behemoth }, {0.9 * scale_worm_behemoth, 0.8 * scale_worm_behemoth}},
    map_generator_bounding_box = {{-worm_collision_map_scale_base * scale_worm_behemoth - worm_collision_map_scale_addition, -worm_collision_map_scale_base * scale_worm_behemoth - worm_collision_map_scale_addition}, {worm_collision_map_scale_base * scale_worm_behemoth + worm_collision_map_scale_addition, worm_collision_map_scale_base * scale_worm_behemoth + worm_collision_map_scale_addition}},
    selection_box = {{-0.9 * scale_worm_behemoth, -0.8  * scale_worm_behemoth}, {0.9 * scale_worm_behemoth, 0.8 * scale_worm_behemoth}},
    damaged_trigger_effect = hit_effects.biter(),
    shooting_cursor_size = 4,
    rotation_speed = 1,
    corpse = "behemoth-worm-corpse",
    dying_explosion = "behemoth-worm-die",
	loot = spawner_big_loot,
    graphics_set = {},
    dying_sound = sounds.worm_dying_small(1.0 * scale_worm_behemoth),
    folded_speed = 0.02 / scale_worm_behemoth,
    folded_speed_secondary = 0.02/ scale_worm_behemoth,
    folded_animation = worm_folded_animation(scale_worm_behemoth, tint_worm_small),
    preparing_speed = 0.02/ scale_worm_behemoth,
    preparing_animation = worm_preparing_animation(scale_worm_behemoth, tint_worm_small, "forward"),
    preparing_sound = sounds.worm_standup_small(1),
    prepared_speed = 0.02/ scale_worm_behemoth,
    prepared_speed_secondary = 0.025 / scale_worm_behemoth,
    prepared_sound = sounds.worm_breath(0.6 / scale_worm_behemoth),
    prepared_animation = worm_prepared_animation(scale_worm_behemoth, tint_worm_small),
    prepared_alternative_speed = 0.02/ scale_worm_behemoth,
    prepared_alternative_speed_secondary = 0.025 / scale_worm_behemoth,
    prepared_alternative_chance = 0.2/ scale_worm_behemoth,
    prepared_alternative_animation = worm_prepared_alternative_animation(scale_worm_behemoth, tint_worm_small),
    prepared_alternative_sound = sounds.worm_roar_alternative(0.64/ scale_worm_behemoth),
    starting_attack_speed = 0.03/ scale_worm_behemoth,
    starting_attack_animation = worm_start_attack_animation(scale_worm_behemoth, tint_worm_small),
    starting_attack_sound = sounds.worm_roars(0.62/ scale_worm_behemoth),
    ending_attack_speed = 0.02/ scale_worm_behemoth,
    ending_attack_animation = worm_end_attack_animation(scale_worm_behemoth, tint_worm_small),
    folding_speed = 0.02/ scale_worm_behemoth,
    folding_animation =  worm_preparing_animation(scale_worm_behemoth, tint_worm_small, "backward"),
    folding_sound = sounds.worm_fold(1),
	
    integration = worm_integration(scale_worm_behemoth),
    secondary_animation = true,
    random_animation_offset = true,
    attack_from_start_frame = true,

    prepare_range = range_worm_behemoth + prepare_range_worm_behemoth,
    allow_turning_when_starting_attack = true,
    attack_parameters =
    {
      type = "stream",
      ammo_category = "biological",
      damage_modifier = damage_modifier_worm_behemoth,--defined in spitter-projectiles.lua
      cooldown = worm_attack_speed_base * scale_worm_behemoth,
      range = range_worm_behemoth,--defined in spitter-projectiles.lua
      min_range = range_worm_behemoth_min,
      projectile_creation_parameters = worm_shoot_shiftings(scale_worm_behemoth, scale_worm_behemoth * scale_worm_stream),
      use_shooter_direction = true,

      lead_target_for_projectile_speed = 0.2* 0.75 * 1.5 * 1.5, -- this is same as particle horizontal speed of flamethrower fire stream

      ammo_type =
      {
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "acid-stream-worm-behemoth",
            source_offset = {0.15, -0.5}
          }
        }
      }
    },
    build_base_evolution_requirement = 0.9,
    autoplace = enemy_autoplace.enemy_worm_autoplace("enemy_autoplace_base("..autoplace_worm_behemoth * powerscalingvalue..", "..(autoplace_worm_behemoth * powerscalingvalue )..")"),
    --autoplace = enemy_autoplace.enemy_worm_autoplace(8),
    call_for_help_radius = 80,
    spawn_decorations_on_expansion = true,
    spawn_decoration =
    {
      {
        decorative = "worms-decal",
        spawn_min = 1,
        spawn_max = 3,
        spawn_min_radius = 1,
        spawn_max_radius = 5
      },
      {
        decorative = "shroom-decal",
        spawn_min = 1,
        spawn_max = 2,
        spawn_min_radius = 1,
        spawn_max_radius = 2
      },
      {
        decorative = "enemy-decal",
        spawn_min = 1,
        spawn_max = 4,
        spawn_min_radius = 1,
        spawn_max_radius = 4
      },
      {
        decorative = "enemy-decal-transparent",
        spawn_min = 3,
        spawn_max = 5,
        spawn_min_radius = 1,
        spawn_max_radius = 4
      }
    }
  },
  
   {
    type = "corpse",
    name = "behemoth-worm-corpse",
    icon = "__base__/graphics/icons/behemoth-worm-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selectable_in_game = false,
    subgroup="corpses",
    order = "c[corpse]-c[worm]-d[big]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
    dying_speed = 0.005,
    time_before_removed = 15 * 60 * 60,
    final_render_layer = "lower-object-above-shadow",
    animation = worm_die_animation(scale_worm_behemoth, tint_worm_behemoth),
    ground_patch =
    {
      sheet = worm_integration(scale_worm_behemoth)
    }
  }
   
})

function makeenemyspawner(spawnername, spawnerbasehealth, spawning_amount, spawnerscale, spawnertier, spawnerloot, spawnerresistances, spawnertint, spawnerautoplace, spawncooldownscalar)
	-- Spawnertierfator is a factor from 1 onwards, starting at 1.0 at tier 1
	-- e.g. 
	local _tierreductionfactor = 4
	local spawnertierfactor = 1 + ((spawnertier-1)/_tierreductionfactor)
	local build_base_tier = 0
	local hpt = 0.01

	local enemy_default_size = "small"
	local prefix = ""
	if (spawnertier == 1) then
	prefix = "small"
	enemy_default_size = "small"
	elseif (spawnertier == 2) then
	prefix = "medium"
	enemy_default_size = "medium"
	build_base_tier = 0.3
	elseif (spawnertier == 3) then
	prefix = "big"
	enemy_default_size = "big"
	build_base_tier = 0.6
	elseif (spawnertier == 4) then
	prefix = "behemoth"
	enemy_default_size = "behemoth"
	build_base_tier = 0.8
	elseif (spawnertier == 5) then
	prefix = "huge"
	enemy_default_size = "boss"
	build_base_tier = 0.95
	end

	_ap = enemy_autoplace.enemy_spawner_autoplace("enemy_autoplace_base(" .. (spawnerautoplace[1] ) * ( ( 1 + spawnertier * powerscalingvalue ) * spawnertier ) .."," .. spawnertier ..")")

	dte = nil
	_gs = 
		{
			 animations =
			{
			  spawner_idle_animation(0, spawnertint, (spawnerscale * spawnertierfactor)),
			  spawner_idle_animation(1, spawnertint, (spawnerscale * spawnertierfactor)),
			  spawner_idle_animation(2, spawnertint, (spawnerscale * spawnertierfactor)),
			  spawner_idle_animation(3, spawnertint, (spawnerscale * spawnertierfactor))
			},
		}
	if (string.find(spawnername, "swarmer")) then
		dte =
		{
		  {
			type = "create-entity",
			entity_name = enemy_default_size .. "-" .. spawnername,
			as_enemy = true,
			find_non_colliding_position = true,
			offsets =
			{
			  util.rotate_position({0,1*spawnerscale}, 0.1), 
			  util.rotate_position({0,1*spawnerscale}, 0.2),
			  util.rotate_position({0,1*spawnerscale}, 0.3),
			  util.rotate_position({0,1*spawnerscale}, 0.4),
			  util.rotate_position({0,1*spawnerscale}, 0.5),
			  util.rotate_position({0,1*spawnerscale}, 0.6),
			  util.rotate_position({0,1*spawnerscale}, 0.7),
			  util.rotate_position({0,1*spawnerscale}, 0.8),
			  util.rotate_position({0,1*spawnerscale}, 0.9),
			  util.rotate_position({0,1*spawnerscale}, 1.0),
			  util.rotate_position({0,2*spawnerscale}, 0.05),
			  util.rotate_position({0,2*spawnerscale}, 0.15),
			  util.rotate_position({0,2*spawnerscale}, 0.35),
			  util.rotate_position({0,2*spawnerscale}, 0.55),
			  util.rotate_position({0,2*spawnerscale}, 0.75),
			  util.rotate_position({0,2*spawnerscale}, 0.95),
			}
		  },
		}
		if (settings.startup["settings-chunks-probability"].value ~= 0) then
			table.insert(dte,create_entity("alien-polyp-"..enemy_default_size , 6 *spawnerscale , 0.1 , 2 + (1 * spawnertier)))
		end

		_ap.tile_restriction = {"sand-1","sand-2","sand-3","red-desert-0","red-desert-1","red-desert-2","red-desert-3"} 
	elseif (string.find(spawnername, "tanker")) then	
		hpt = hpt * 10
		if (settings.startup["settings-chunks-probability"].value ~= 0) then
			dte = {}
			table.insert(dte,create_entity("alien-polyp-"..enemy_default_size , 6 *spawnerscale , 0.1 , 2 + (1 * spawnertier)))
		end

	elseif (string.find(spawnername, "webber")) then
		dte =
		{
		  {
			type = "create-entity",
			entity_name = "web-splash-fire-web-" .. enemy_default_size,
			as_enemy = true,
			find_non_colliding_position = true,
			offsets =
			{
			  util.rotate_position({0,1*spawnerscale}, 0.1),
			  util.rotate_position({0,3*spawnerscale}, 0.3),
			  util.rotate_position({0,1*spawnerscale}, 0.9),
			  util.rotate_position({0,2*spawnerscale}, 0.05),
			  util.rotate_position({0,3*spawnerscale}, 0.15),
			  util.rotate_position({0,5*spawnerscale}, 0.35),
			  util.rotate_position({0,3*spawnerscale}, 0.55),
			  util.rotate_position({0,2*spawnerscale}, 0.75),
			  util.rotate_position({0,5*spawnerscale}, 0.95),
			  util.rotate_position({0,4*spawnerscale}, 0.25),
			}
		  },
		}
		if (settings.startup["settings-chunks-probability"].value ~= 0) then
			table.insert(dte,create_entity("alien-polyp-"..enemy_default_size , 6 *spawnerscale , 0.1 , 2 + (1 * spawnertier)) )
		end
	elseif (string.find(spawnername, "hatcher")) then	
		dte =
		{
		  {
			type = "create-entity",
			entity_name = "hatcher-egg-" ..enemy_default_size,
			as_enemy = true,
			find_non_colliding_position = false,
			offsets =
			{
			   util.rotate_position({0,1*spawnerscale}, 0.1),
			  util.rotate_position({0,2*spawnerscale}, 0.5),
			  util.rotate_position({0,2*spawnerscale}, 0.9),
			  util.rotate_position({0,3*spawnerscale}, 0.1),
			  util.rotate_position({0,3*spawnerscale}, 0.3),
			  util.rotate_position({0,3*spawnerscale}, 0.5),
			  util.rotate_position({0,4*spawnerscale}, 0.9),
			}
		  },
		}
		if (settings.startup["settings-chunks-probability"].value ~= 0) then
			table.insert(dte,create_entity("alien-polyp-"..enemy_default_size , 6 *spawnerscale , 0.1 , 2 + (1 * spawnertier)) )
		end
		_ap.tile_restriction = spawner_tilerestrictions_hatcher
	elseif (string.find(spawnername, "spitter")) then	
		dte =
		{
		  {
			type = "create-entity",
			entity_name = "acid-splash-fire-spitter-" .. enemy_default_size,
			as_enemy = true,
			find_non_colliding_position = true,
			offsets =
			{
			  util.rotate_position({0,1*spawnerscale}, 0.1),
			  util.rotate_position({0,3*spawnerscale}, 0.3),
			  util.rotate_position({0,1*spawnerscale}, 0.9),
			  util.rotate_position({0,2*spawnerscale}, 0.05),
			  util.rotate_position({0,3*spawnerscale}, 0.15),
			  util.rotate_position({0,5*spawnerscale}, 0.35),
			  util.rotate_position({0,3*spawnerscale}, 0.55),
			  util.rotate_position({0,2*spawnerscale}, 0.75),
			  util.rotate_position({0,5*spawnerscale}, 0.95),
			  util.rotate_position({0,4*spawnerscale}, 0.25),
			}
		  },
		}
		if (settings.startup["settings-chunks-probability"].value ~= 0) then
			table.insert(dte,create_entity("alien-polyp-"..enemy_default_size , 6 *spawnerscale , 0.1 , 2 + (1 * spawnertier)) )
		end
		_ap.tile_restriction = {"grass-1","grass-2","grass-3","grass-4" }
	elseif (string.find(spawnername, "stinger")) then	
		_ap.tile_restriction = {"grass-1","grass-2","grass-3","grass-4" }
		if (settings.startup["settings-chunks-probability"].value ~= 0) then
			dte = {}
			table.insert(dte,create_entity("alien-polyp-"..enemy_default_size , 6 *spawnerscale , 0.1 , 2 + (1 * spawnertier)) )
		end
		-- TODO make a ipair iterator to go through the tint colour and reduce the values by half(?).
	elseif (string.find(spawnername, "blaster")) then
		dte = make_explosion_trigger( damage_modifier_blaster_spawn * spawnertierfactor , damage_radius_blaster_spawn * spawnertierfactor , damage_falloff_blaster_spawn)
		_gs.animations[1].layers[4] = table.deepcopy(_gs.animations[1].layers[2])
		_gs.animations[2].layers[4] = table.deepcopy(_gs.animations[2].layers[2])
		_gs.animations[3].layers[4] = table.deepcopy(_gs.animations[3].layers[2])
		_gs.animations[4].layers[4] = table.deepcopy(_gs.animations[4].layers[2])
		_gs.animations[1].layers[4].tint = blaster_spawner_tint_light
		_gs.animations[2].layers[4].tint = blaster_spawner_tint_light
		_gs.animations[3].layers[4].tint = blaster_spawner_tint_light
		_gs.animations[4].layers[4].tint = blaster_spawner_tint_light
		_gs.animations[1].layers[4].draw_as_light = true
		_gs.animations[2].layers[4].draw_as_light = true
		_gs.animations[3].layers[4].draw_as_light = true
		_gs.animations[4].layers[4].draw_as_light = true
		
	elseif (string.find(spawnername, "flamer")) then
	dte =
		{
		  {
			type = "create-entity",
			entity_name = "flamer-fire-" .. enemy_default_size,
			find_non_colliding_position = true,
			as_enemy = true,
			offsets =
			{
			  util.rotate_position({0,0*spawnerscale}, 0.3),
			  util.rotate_position({0,0*spawnerscale}, 0.9),
			  util.rotate_position({0,1*spawnerscale}, 0.05),
			  util.rotate_position({0,1*spawnerscale}, 0.15),
			  util.rotate_position({0,1*spawnerscale}, 0.1),
			  util.rotate_position({0,1*spawnerscale}, 0.3),
			  util.rotate_position({0,2*spawnerscale}, 0.9),
			  util.rotate_position({0,2*spawnerscale}, 0.05),
			  util.rotate_position({0,2*spawnerscale}, 0.15),
			  util.rotate_position({0,2*spawnerscale}, 0.35),
			  util.rotate_position({0,3*spawnerscale}, 0.55),
			  util.rotate_position({0,3*spawnerscale}, 0.75),
			  util.rotate_position({0,4*spawnerscale}, 0.95),
			  util.rotate_position({0,4*spawnerscale}, 0.25),
			  util.rotate_position({0,5*spawnerscale}, 0.55),
			  util.rotate_position({0,5*spawnerscale}, 0.75),
			  util.rotate_position({0,5*spawnerscale}, 0.95),
			  util.rotate_position({0,6*spawnerscale}, 0.25),
			}
		  },
		}
		if (settings.startup["settings-chunks-probability"].value ~= 0) then
			table.insert(dte,create_entity("alien-polyp-"..enemy_default_size , 6 *spawnerscale , 0.1 , 2 + (1 * spawnertier)) )
		end
		_gs.animations[1].layers[4] = table.deepcopy(_gs.animations[1].layers[2])
		_gs.animations[2].layers[4] = table.deepcopy(_gs.animations[2].layers[2])
		_gs.animations[3].layers[4] = table.deepcopy(_gs.animations[3].layers[2])
		_gs.animations[4].layers[4] = table.deepcopy(_gs.animations[4].layers[2])
		_gs.animations[1].layers[4].tint = flamer_spawner_tint_light
		_gs.animations[2].layers[4].tint = flamer_spawner_tint_light
		_gs.animations[3].layers[4].tint = flamer_spawner_tint_light
		_gs.animations[4].layers[4].tint = flamer_spawner_tint_light
		_gs.animations[1].layers[4].draw_as_light = true
		_gs.animations[2].layers[4].draw_as_light = true
		_gs.animations[3].layers[4].draw_as_light = true
		_gs.animations[4].layers[4].draw_as_light = true
		
		_ap.tile_restriction = {"red-desert-0","red-desert-1","red-desert-2","red-desert-3"} 
	else if (string.find(spawnername, "biter")) then
			if (settings.startup["settings-chunks-probability"].value ~= 0) then
				dte = {}
				table.insert(dte,create_entity("alien-polyp-"..enemy_default_size , 6 *spawnerscale , 0.1 , 2 + (1 * spawnertier)) )
			end
		end
	end

-- (function() 
		-- local r = {}
			-- if (spawnername == "blaster") then
			-- r = make_explosion_trigger( damage_modifier_blaster_spawn * spawnertierfactor , damage_radius_blaster_spawn * spawnertierfactor , damage_falloff_blaster_spawn)
			-- else 
			-- r = nil
			-- end
		-- return r
		-- end)()

if (mods["space-age"]) then  
	cse = "captive-biter-spawner"
else
	cse = nil
end

local _corpse = nil
if (string.find(spawnername, "blaster")) then
	_corpse = nil
else
	_corpse = spawnername .. "-spawner-corpse-"..spawnertier
end

local res =
{
	{
		makespawnercorpse(spawnername, spawnerscale * spawnertierfactor, spawnertint, spawnertier),
	},
	{
		{
		type = "unit-spawner",
		name = spawnername .. "-spawner-"..spawnertier,
		--localised_name = { "", prefix , "", {"item-name.iron-plate"}, ": ", 60},
		localised_name = { "", {"factorioplus-adjectives." .. prefix } , " ", {"entity-name." .. spawnername  .. "-spawner"}}, 
		icon = "__base__/graphics/icons/biter-spawner.png",
		icon_size = 64, icon_mipmaps = 4,
		flags = {"placeable-player", "placeable-enemy", "not-repairable"},
		max_health = (spawnerbasehealth  * enemy_health_scale) * (1 + (spawnertier / 1.5)),
		order="b-d-a",
		subgroup="enemies",
		loot = spawnerloot,
		resistances = spawnerresistances or {},
		working_sound =
		{
		  sound =
		  {
			{
			  filename = "__base__/sound/creatures/spawner.ogg",
			  volume = 0.6 * spawnerscale
			}
		  },
		},
		dying_sound =
		{
		  {
			filename = "__base__/sound/creatures/spawner-death-1.ogg",
			volume = 1.0 * spawnerscale
		  },
		  {
			filename = "__base__/sound/creatures/spawner-death-2.ogg",
			volume = 1.0 * spawnerscale
		  }
		},
		build_base_evolution_requirement = build_base_tier,
		healing_per_tick = hpt * (spawnerscale * spawnertierfactor),
		collision_box = {{-3.2 * (spawnerscale * spawnertierfactor), -2.2 * (spawnerscale * spawnertierfactor)}, {2.2 * (spawnerscale * spawnertierfactor), 2.2 * (spawnerscale * spawnertierfactor)}},
		map_generator_bounding_box = {{-spawnerautoplace[2] * spawnertierfactor, -spawnerautoplace[2] * spawnertierfactor}, {spawnerautoplace[2] * spawnertierfactor, spawnerautoplace[2]* spawnertierfactor}},
		selection_box = {{-3.5* (spawnerscale * spawnertierfactor), -2.5* (spawnerscale * spawnertierfactor)}, {2.5* (spawnerscale * spawnertierfactor), 2.5* (spawnerscale * spawnertierfactor)}},
		damaged_trigger_effect = hit_effects.biter(),
		-- in ticks per 1 pu
		absorptions_per_second = { pollution = { absolute = 20 * spawnertierfactor, proportional = 0.01 * spawnertierfactor } },
		
		dying_trigger_effect = dte,
		dying_explosion = "biter-spawner-die",
		max_count_of_owned_units = math.ceil( spawning_amount *  spawnertierfactor ),
		max_friends_around_to_spawn = math.ceil( (spawning_amount * spawnertierfactor) / 1.5 ),
		graphics_set = _gs,	
		integration =
		{
		  sheet = spawner_integration(spawnerscale)
		},
		result_units = (function() 
						 local res = {}
						 if spawnertier <= 1 then
							res[1] = {"small-" .. spawnername, {{0.0, 0.5}, {0.9, 0.1}}}
							res[2] = {"medium-" .. spawnername, {{0.2 , 0.0}, {1.0, 0.4}}}
							res[3] = {"big-" .. spawnername, {{0.5 , 0.0}, {1.0, 0.75}}}
							res[4] = {"behemoth-".. spawnername, {{0.8 , 0.0}, {1.0, 0.1}}}
							res[5] = {"boss-".. spawnername, {{0.9 , 0.0}, {1.0, 0.01}}}
						 elseif spawnertier == 2 then
							res[1] = {"small-" .. spawnername, {{0.0, 0.4}, {0.6, 0.0}}}
							res[2] = {"medium-" .. spawnername, {{0.3 , 0.0}, {0.7, 0.8}}}
							res[3] = {"big-" .. spawnername, {{0.6 , 0.0}, {1.0, 0.2}}}
							res[4] = {"behemoth-".. spawnername, {{0.7 , 0.0}, {1.0, 0.2}}}
							res[5] = {"boss-".. spawnername, {{0.8 , 0.0}, {1.0, 0.01}}}
						 elseif spawnertier == 3 then
							res[1] = {"medium-" .. spawnername,  {{0.0, 0.3}, {0.5, 0.0}}}
							res[2] = {"big-" .. spawnername, {{0.2 , 0.0}, {0.7, 0.8}}}
							res[3] = {"behemoth-".. spawnername, {{0.5 , 0.0}, {1.0, 0.4}}}
							res[4] = {"boss-".. spawnername, {{0.7 , 0.0}, {1.0, 0.03}}}
						 elseif spawnertier == 4 then
							res[1] = {"medium-" .. spawnername, {{0.0 , 1.0}, {0.3, 0.0}}}
							res[2] = {"big-" .. spawnername,  {{0.1, 0.6}, {0.8, 0.4}}}
							res[3] = {"behemoth-".. spawnername,{{0.2 , 0.0}, {0.7, 0.8}}}
							res[4] = {"boss-".. spawnername, {{0.5 , 0.0}, {1.0, 0.04}}}
						 elseif spawnertier >= 5 then
							res[1] = {"medium-" .. spawnername, {{0.0 , 1.0}, {0.2, 0.0}}}
							res[2] = {"big-" .. spawnername, {{0.1 , 1.0}, {0.3, 0.0}}}
							res[3] = {"behemoth-".. spawnername,  {{0.2, 0.0}, {0.9, 0.9}}}
							res[4] = {"boss-".. spawnername, {{0.3 , 0.0}, {0.9, 0.05}}}
						 end                 					   
						 return res
					   end)(),				 
		-- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
		-- TODO link spawn cooldown to function
		spawning_cooldown = { ((spawning_time_slowest * spawncooldownscalar) / spawnertierfactor ) / enemy_spawntime_scale , ( (spawning_time_fastest * (spawncooldownscalar)) / spawnertierfactor ) / enemy_spawntime_scale  } ,
		spawning_radius = 10 * (spawnerscale * spawnertierfactor),
		spawning_spacing = 3 * (spawnerscale * spawnertierfactor),
		max_spawn_shift = 0,
		max_richness_for_spawn_shift = 100,
		autoplace = _ap,
		corpse = _corpse,
		captured_spawner_entity = cse,
		
		--enemy_autoplace.enemy_spawner_autoplace((spawnerautoplace[1] ) * ( (2* spawnertier) * spawnertier )),
		call_for_help_radius = 30 * spawnertierfactor,
		spawn_decorations_on_expansion = true,
		spawn_decoration =
		{
		  {
			decorative = "light-mud-decal",
			spawn_min = 0,
			spawn_max = 2,
			spawn_min_radius = 2,
			spawn_max_radius = 5,
		  },
		  {
			decorative = "dark-mud-decal",
			spawn_min = 0,
			spawn_max = 3,
			spawn_min_radius = 2,
			spawn_max_radius = 6,
		  },
		  {
			decorative = "enemy-decal",
			spawn_min = 3,
			spawn_max = 5,
			spawn_min_radius = 2,
			spawn_max_radius = 7,
		  },
		  {
			decorative = "enemy-decal-transparent",
			spawn_min = 4,
			spawn_max = 20,
			spawn_min_radius = 2,
			spawn_max_radius = 14,
			radius_curve = 0.9
		  },
		  {
			decorative = "muddy-stump",
			spawn_min = 2,
			spawn_max = 5,
			spawn_min_radius = 3,
			spawn_max_radius = 6,
		  },
		  {
			decorative = "red-croton",
			spawn_min = 2,
			spawn_max = 8,
			spawn_min_radius = 3,
			spawn_max_radius = 6,
		  },
		  {
			decorative = "red-pita",
			spawn_min = 1,
			spawn_max = 5,
			spawn_min_radius = 3,
			spawn_max_radius = 6,
		  },
		},
	  }
  }
} 
return res[1][1],res[2][1]
 end
 
 function makespawnercorpse(enemyname, enemyscale, enemytint, enemytier) 
return  
  {
    type = "corpse",
    name = enemyname .. "-spawner-corpse-"..enemytier,
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/biter-spawner-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    dying_speed = 0.04,
    time_before_removed = 15 * 60 * 60,
    subgroup="corpses",
    order = "c[corpse]-b[biter-spawner]",
    final_render_layer = "remnants",
    animation =
    {
      spawner_die_animation(0, enemytint,enemyscale),
      spawner_die_animation(1, enemytint,enemyscale),
      spawner_die_animation(2, enemytint,enemyscale),
      spawner_die_animation(3, enemytint,enemyscale)
    },
    ground_patch =
    {
      sheet = spawner_integration(enemyscale)
    },
  }
end

  ----------------------------------------------------------   BITER  ----------------------------------------------------------

function makeenemysbiter(enemyname, enemyhealth, enemyrange, enemydamage, enemyscale, enemytier, enemytint, enemyresistances)

	local _flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"}
	-- Attack params
	local ap = makeenemyattack(enemyname, "bite", 1, 30 * enemyscale, 1, 1, {1,1,1,1})
	-- light
	local lt = nil 
	-- base move speed
	local bms = 1 
	-- additional move speed
	local ams = 1 
	-- spawn time
	local stm = 1 
	-- healing per tick (+%)
	local hpt = 0.01
	-- affected by tiles?
	local abt = true
	if (enemyscale >= 1.5) then abt = false end
	-- run animation
	local ra = nil

	local enemy_size = nil
	if (string.find(enemyname, "small")) then
		enemy_size = "small"
	elseif (string.find(enemyname, "medium")) then
		enemy_size = "medium"
		hpt = hpt * 1.25
	elseif (string.find(enemyname, "big")) then
		enemy_size = "big"
		hpt = hpt * 1.5
	elseif (string.find(enemyname, "behemoth")) then
		enemy_size = "behemoth"
		hpt = hpt * 2.5
	elseif (string.find(enemyname, "boss")) then
		enemy_size = "boss"
		hpt = hpt * 4
	end

	-- Death Trigger effect.
	local dte = nil
	if (string.find(enemyname, "blaster")) then
		dte = make_explosion_trigger( enemydamage/2, enemyrange/2, 3)
	elseif (string.find(enemyname, "flamer")) then
		dte = 
		{
			type = "create-entity",
			entity_name = "flamer-fire-" .. enemy_size,
			as_enemy = true,
			offsets =
			{
			  {0,0},
			}
		  }
	elseif (string.find(enemyname, "hatcher")) then
		dte =
		{
		  {
			type = "create-entity",
			entity_name = enemy_size .. "-swarmer",
			as_enemy = true,
			offsets =
			{
			  util.rotate_position({0,1*enemyscale}, 0.1), 
			  --util.rotate_position({0,1*enemyscale}, 0.2),
			  util.rotate_position({0,1*enemyscale}, 0.3),
			  --util.rotate_position({0,1*enemyscale}, 0.4),
			  util.rotate_position({0,1*enemyscale}, 0.5),
			  --util.rotate_position({0,1*enemyscale}, 0.6),
			  util.rotate_position({0,1*enemyscale}, 0.7),
			 -- util.rotate_position({0,1*enemyscale}, 0.8),
			  util.rotate_position({0,1*enemyscale}, 0.9),
			 -- util.rotate_position({0,1*enemyscale}, 1.0),
			}
		  }
		}
	end 

	-- Corpse override.
	local cor = enemyname .. "-corpse"
	if (string.find(enemyname, "blaster")) then
		cor = nil
	end

	local _da = nil
	local _da_spit = add_spitter_die_animation(enemyscale, enemytint, enemytint,
		{
			type = "corpse",
			name = enemyname .. "-corpse",
			icon = "__base__/graphics/icons/big-biter-corpse.png",
			icon_size = 64, icon_mipmaps = 4,
			selectable_in_game = false,
			selection_box = {{-1, -1}, {1, 1}},
			subgroup="corpses",
			order = "c[corpse]-b[spitter]-a[small]",
			flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"}
		}
	)	  
	local _da_bite = add_biter_die_animation(enemyscale, enemytint, enemytint,
		{
			type = "corpse",
			name = enemyname .. "-corpse",
			icon = "__base__/graphics/icons/small-biter-corpse.png",
			icon_size = 64, icon_mipmaps = 4,
			selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
			selectable_in_game = false,
			subgroup="corpses",
			order = "c[corpse]-a[biter]-a[small]",
			flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"}
		}
	)



	if (string.find(enemyname, "blaster")) then
		ap = makeenemyattack(enemyname, "explode", enemydamage, attack_speed_blaster_base, enemyscale, enemyrange, enemytint)
		lt = {intensity = 0.5 * enemyscale , size = 4 * enemyscale, color=enemytint}
		bms = movement_speed_blaster_base
		ams = movement_speed_blaster 
		stm = spawning_time_scalar_blaster
		ra =  biterrunanimation(enemyscale, enemytint, enemytint)
		ra.layers[2].draw_as_light = true
		_da = _da_bite
	elseif (string.find(enemyname, "spitter")) then
		ap = makeenemyattack(enemyname, "spit",enemydamage, attack_speed_spitter_base , enemyscale, enemyrange, enemytint)
		bms = movement_speed_spitter_base
		ams = movement_speed_spitter
		stm = spawning_time_scalar_spitter
		ra = spitterrunanimation(enemyscale, enemytint, enemytint)
		_da = _da_spit
	elseif (string.find(enemyname, "hatcher")) then
		ap = makeenemyattack(enemyname, "egg", enemydamage, attack_speed_hatcher_base , enemyscale, enemyrange, enemytint)
		bms = movement_speed_hatcher_base
		ams = movement_speed_hatcher
		stm = spawning_time_scalar_hatcher
		ra = spitterrunanimation(enemyscale, enemytint, enemytint)
		_da = _da_spit
	elseif (string.find(enemyname, "biter")) then
		ap = makeenemyattack(enemyname, "bite",enemydamage, attack_speed_biter_base , enemyscale, enemyrange, enemytint)
		bms = movement_speed_biter_base
		ams = movement_speed_biter
		hpt = (hpt * 5 * enemyscale) / enemy_health_scale
		ra =  biterrunanimation(enemyscale, enemytint, enemytint)
		_da = _da_bite
	elseif (string.find(enemyname, "stinger")) then
		ap = makeenemyattack(enemyname, "sting",enemydamage, attack_speed_stinger_base , enemyscale, enemyrange, enemytint)
		bms = movement_speed_stinger_base
		ams = movement_speed_stinger
		ra =  biterrunanimation(enemyscale, enemytint, enemytint)
		_da = _da_bite
	elseif (string.find(enemyname, "swarmer")) then
		ap = makeenemyattack(enemyname, "bite",enemydamage, attack_speed_swarmer_base , enemyscale, enemyrange, enemytint)
		bms = movement_speed_swarmer_base
		ams = movement_speed_swarmer
		stm = spawning_time_scalar_swarmer
		ra =  biterrunanimation(enemyscale, enemytint, enemytint)
		_da = _da_bite
	elseif (string.find(enemyname, "tanker")) then
		ap = makeenemyattack(enemyname, "bite", enemydamage, attack_speed_tanker_base , enemyscale, enemyrange, enemytint)
		bms = movement_speed_tanker_base
		ams = movement_speed_tanker
		stm = spawning_time_scalar_tanker
		hpt = (hpt * 30 * enemyscale) / enemy_health_scale
		ra =  biterrunanimation(enemyscale, enemytint, enemytint)
		_da = _da_bite
	elseif (string.find(enemyname, "webber")) then
		ap = makeenemyattack(enemyname, "web", enemydamage, attack_speed_webber_base , enemyscale, enemyrange, enemytint)
		bms = movement_speed_webber_base
		ams = movement_speed_webber
		stm = spawning_time_scalar_webber
		ra = spitterrunanimation(enemyscale, enemytint, enemytint)
		_da = _da_spit
	elseif (string.find(enemyname, "flamer")) then
		ap = makeenemyattack(enemyname, "flame", enemydamage, attack_speed_flamer_base , enemyscale, enemyrange, enemytint)
		ap.animation.layers[2].draw_as_light = true
		lt = {intensity = 0.5 * enemyscale , size = 4 * enemyscale, color=enemytint}
		bms = movement_speed_flamer_base
		ams = movement_speed_flamer
		stm = spawning_time_scalar_flamer
		ra = spitterrunanimation(enemyscale, enemytint, enemytint)
		ra.layers[2].draw_as_light = true
		table.insert( _flags, "not-flammable")
		_da = _da_spit
	end

	if (string.find(enemyname, "small")) then
		stm = stm * spawning_time_small
	elseif (string.find(enemyname, "medium")) then
		stm = stm * spawning_time_medium
	elseif (string.find(enemyname, "big")) then
		stm = stm * spawning_time_big
	elseif (string.find(enemyname, "behemoth")) then
		stm = stm * spawning_time_behemoth
	elseif (string.find(enemyname, "boss")) then
		stm = stm * spawning_time_boss
	end
	
	-- meaty loot
	local droppedloot = nil
	if(settings.startup["settings-chunks-probability"].value ~= 0) then
		droppedloot = createmeatyloot(enemyscale,enemytier)
	end

	local res
	res = 
	{
		{ 
		   {
			type = "unit",
			name = enemyname,
			icons = {{ icon = "__base__/graphics/icons/small-biter.png", icon_size = 64, tint = enemytint }},
			flags = _flags,
			max_health = enemyhealth * enemy_health_scale,
			order = "b-a-a",
			subgroup="enemies",
			resistances = enemyresistances,
			spawning_time_modifier = stm,
			healing_per_tick = hpt,
			collision_box = {{-enemyscale, -enemyscale}, {enemyscale, enemyscale}},
			selection_box = {{-enemyscale, -enemyscale}, {enemyscale, enemyscale}},
			damaged_trigger_effect = hit_effects.biter(),
			affected_by_tiles = abt,
			attack_parameters = ap,
			loot = droppedloot,	 
			vision_distance = 20 * (1 + (enemytier/5)),
			movement_speed = bms + ( ams * (enemytier-1) ),
			distance_per_frame = 0.125 * enemyscale,
			absorptions_to_join_attack = { pollution = spawning_base_pollution_cost * enemyscale },
			distraction_cooldown = 300,
			min_pursue_time = 10 * 20 * (1 + (enemytier/5)),
			max_pursue_distance = 30 * (1 + (enemytier/5)),
			corpse = cor,
			dying_explosion = "small-biter-die",
			dying_sound =  sounds.biter_dying(0.2*enemyscale),
			working_sound =  sounds.biter_calls(0.4*enemyscale),
			run_animation = ra,
			running_sound_animation_positions = {2,},
			walking_sound = sounds.biter_walk(0.2*enemyscale),
			ai_settings = Create_AISettings(enemyscale),
			water_reflection = biter_water_reflection(enemyscale),
			dying_trigger_effect = dte,
			light = lt,
			hide_resistances = false,
		  },
	  },
	  {_da},
		
	 }
	 return res[2][1],res[1][1]
  end

data:extend({
makeblasterprojectile("small-blaster-pellet", damage_modifier_blaster_small, damage_radius_blaster_small, health_small_blaster),
makeblasterprojectile("medium-blaster-pellet", damage_modifier_blaster_medium, damage_radius_blaster_medium, health_medium_blaster),
makeblasterprojectile("big-blaster-pellet", damage_modifier_blaster_big, damage_radius_blaster_big, health_big_blaster),
makeblasterprojectile("behemoth-blaster-pellet", damage_modifier_blaster_behemoth, damage_radius_blaster_behemoth, health_behemoth_blaster),
makeblasterprojectile("boss-blaster-pellet", damage_modifier_blaster_boss, damage_radius_blaster_boss, health_boss_blaster),
})

-- Biter generation
data:extend({makeenemysbiter("small-biter", health_small_biter,  1 , damage_modifier_biter_small, small_biter_scale,1, biter_spawner_tint, biterresistances(1)) })
data:extend({makeenemysbiter("medium-biter", health_medium_biter,  1 , damage_modifier_biter_medium, medium_biter_scale,2, biter_spawner_tint, biterresistances(2)) })
data:extend({makeenemysbiter("big-biter", health_big_biter,  1, damage_modifier_biter_big, big_biter_scale,3, biter_spawner_tint, biterresistances(3)) })
data:extend({makeenemysbiter("behemoth-biter", health_behemoth_biter,  1 , damage_modifier_biter_behemoth, behemoth_biter_scale,4, biter_spawner_tint, biterresistances(4)) })
data:extend({makeenemysbiter("boss-biter", health_boss_biter,  1 , damage_modifier_biter_boss, boss_biter_scale,5, biter_spawner_tint, biterresistances(6)) })

data:extend({makeenemysbiter("small-spitter", health_small_spitter, range_spitter_small , damage_modifier_spitter_small, small_spitter_scale,1, spitter_spawner_tint, spitterresistances(1)) })
data:extend({makeenemysbiter("medium-spitter", health_medium_spitter, range_spitter_medium, damage_modifier_spitter_medium, medium_spitter_scale,2, spitter_spawner_tint, spitterresistances(2)) })
data:extend({makeenemysbiter("big-spitter", health_big_spitter, range_spitter_big , damage_modifier_spitter_big, big_spitter_scale,3, spitter_spawner_tint, spitterresistances(3)) })
data:extend({makeenemysbiter("behemoth-spitter", health_behemoth_spitter, range_spitter_behemoth , damage_modifier_spitter_behemoth, behemoth_spitter_scale,4, spitter_spawner_tint, spitterresistances(4)) })
data:extend({makeenemysbiter("boss-spitter", health_boss_spitter, range_spitter_boss , damage_modifier_spitter_boss, boss_spitter_scale,5, spitter_spawner_tint, spitterresistances(5)) })

data:extend({makeenemysbiter("small-tanker", health_small_tanker, 1 ,damage_modifier_tanker_small, small_tanker_scale,1, tanker_tint, tankerresistances(1) )})
data:extend({makeenemysbiter("medium-tanker", health_medium_tanker, 1 , damage_modifier_tanker_medium, medium_tanker_scale,2, tanker_tint, tankerresistances(2)  )})
data:extend({makeenemysbiter("big-tanker", health_big_tanker, 1 , damage_modifier_tanker_big, big_tanker_scale,3, tanker_tint, tankerresistances(3) )})
data:extend({makeenemysbiter("behemoth-tanker", health_behemoth_tanker, 1 , damage_modifier_tanker_behemoth, behemoth_tanker_scale,4, tanker_tint, tankerresistances(4) )})
data:extend({makeenemysbiter("boss-tanker", health_boss_tanker, 1 , damage_modifier_tanker_boss, boss_tanker_scale,5, tanker_tint, tankerresistances(5) )})

data:extend({makeenemysbiter("small-swarmer", health_small_swarmer, 1 , damage_modifier_swarmer_small, small_swarmer_scale, 1 , swarmer_spawner_tint, swarmerresistances(1)) })
data:extend({makeenemysbiter("medium-swarmer", health_medium_swarmer, 1 , damage_modifier_swarmer_medium, medium_swarmer_scale, 2 , swarmer_spawner_tint, swarmerresistances(2)) })
data:extend({makeenemysbiter("big-swarmer", health_big_swarmer, 1 , damage_modifier_swarmer_big, big_swarmer_scale, 3 , swarmer_spawner_tint, swarmerresistances(3)) })
data:extend({makeenemysbiter("behemoth-swarmer", health_behemoth_swarmer, 1 , damage_modifier_swarmer_behemoth, behemoth_swarmer_scale, 4 , swarmer_spawner_tint, swarmerresistances(4)) })
data:extend({makeenemysbiter("boss-swarmer", health_boss_swarmer, 1 , damage_modifier_swarmer_boss, boss_swarmer_scale, 5 , swarmer_spawner_tint, swarmerresistances(5)) })

data:extend({makeenemysbiter("small-blaster", health_small_blaster, damage_radius_blaster_small , damage_modifier_blaster_small, small_blaster_scale,1, blaster_spawner_tint, blasterresistances(1)) })
data:extend({makeenemysbiter("medium-blaster", health_medium_blaster, damage_radius_blaster_medium , damage_modifier_blaster_medium, medium_blaster_scale,2, blaster_spawner_tint, blasterresistances(2)) })
data:extend({makeenemysbiter("big-blaster", health_big_blaster, damage_radius_blaster_big , damage_modifier_blaster_big, big_blaster_scale,3, blaster_spawner_tint, blasterresistances(3)) })
data:extend({makeenemysbiter("behemoth-blaster", health_behemoth_blaster, damage_radius_blaster_behemoth , damage_modifier_blaster_behemoth, behemoth_blaster_scale,4, blaster_spawner_tint, blasterresistances(4)) })
data:extend({makeenemysbiter("boss-blaster", health_boss_blaster, damage_radius_blaster_boss , damage_modifier_blaster_boss, boss_blaster_scale,5, blaster_spawner_tint, blasterresistances(5)) })

data:extend({makeenemysbiter("small-webber", health_small_webber, range_webber_small , damage_webber_small, small_webber_scale,1, webber_spawner_tint, webberresistances(1)) })
data:extend({makeenemysbiter("medium-webber", health_medium_webber, range_webber_medium , damage_webber_medium, medium_webber_scale,2, webber_spawner_tint, webberresistances(2)) })
data:extend({makeenemysbiter("big-webber", health_big_webber, range_webber_big , damage_webber_big, big_webber_scale,3, webber_spawner_tint, webberresistances(3)) })
data:extend({makeenemysbiter("behemoth-webber", health_behemoth_webber, range_webber_behemoth , damage_webber_behemoth, behemoth_webber_scale,4, webber_spawner_tint, webberresistances(4)) })
data:extend({makeenemysbiter("boss-webber", health_boss_webber, range_webber_boss , damage_webber_boss, boss_webber_scale,5, webber_spawner_tint, webberresistances(5)) })

data:extend({makeenemysbiter("small-flamer", health_small_flamer, range_flamer_small , damage_flamer_small, small_flamer_scale,1, flamer_spawner_tint, flamerresistances(1)) })
data:extend({makeenemysbiter("medium-flamer", health_medium_flamer, range_flamer_medium , damage_flamer_medium, medium_flamer_scale,2, flamer_spawner_tint, flamerresistances(2)) })
data:extend({makeenemysbiter("big-flamer", health_big_flamer, range_flamer_big , damage_flamer_big, big_flamer_scale,3, flamer_spawner_tint, flamerresistances(3)) })
data:extend({makeenemysbiter("behemoth-flamer", health_behemoth_flamer, range_flamer_behemoth , damage_flamer_behemoth, behemoth_flamer_scale,4, flamer_spawner_tint, flamerresistances(4)) })
data:extend({makeenemysbiter("boss-flamer", health_boss_flamer, range_flamer_boss , damage_flamer_boss, boss_flamer_scale,5, flamer_spawner_tint, flamerresistances(5)) })

data:extend({makeenemysbiter("small-stinger", health_small_stinger, 1 , damage_stinger_small, small_stinger_scale,1, stinger_spawner_tint, stingerresistances(1)) })
data:extend({makeenemysbiter("medium-stinger", health_medium_stinger, 1 , damage_stinger_medium, medium_stinger_scale,2, stinger_spawner_tint, stingerresistances(2)) })
data:extend({makeenemysbiter("big-stinger", health_big_stinger, 1 , damage_stinger_big, big_stinger_scale,3, stinger_spawner_tint, stingerresistances(3)) })
data:extend({makeenemysbiter("behemoth-stinger", health_behemoth_stinger, 1 , damage_stinger_behemoth, behemoth_stinger_scale,4, stinger_spawner_tint, stingerresistances(4)) })
data:extend({makeenemysbiter("boss-stinger", health_boss_stinger, 1 , damage_stinger_boss, boss_stinger_scale,5, stinger_spawner_tint, stingerresistances(5)) })

data:extend({makeenemysbiter("small-hatcher", health_small_hatcher, range_hatcher_small ,damage_hatcher_small, small_hatcher_scale,1, hatcher_spawner_tint, hatcherresistances(1)) })
data:extend({makeenemysbiter("medium-hatcher", health_medium_hatcher, range_hatcher_medium, damage_hatcher_medium, medium_hatcher_scale,2, hatcher_spawner_tint, hatcherresistances(2)) })
data:extend({makeenemysbiter("big-hatcher", health_big_hatcher, range_hatcher_big , damage_hatcher_big, big_hatcher_scale,3, hatcher_spawner_tint, hatcherresistances(3)) })
data:extend({makeenemysbiter("behemoth-hatcher", health_behemoth_hatcher, range_hatcher_behemoth , damage_hatcher_behemoth, behemoth_hatcher_scale,4, hatcher_spawner_tint, hatcherresistances(4)) })
data:extend({makeenemysbiter("boss-hatcher", health_boss_hatcher, range_hatcher_boss , damage_hatcher_boss, boss_hatcher_scale,5, hatcher_spawner_tint, hatcherresistances(5)) })


-- Spawners generation

data:extend({makeenemyspawner("tanker", health_spawner_tanker, spawning_amount_tanker,tanker_spawner_scale, 1, spawner_medium_loot, tankerresistances(3),tanker_tint, autoplace_spacing_tanker, spawning_time_scalar_tanker )})
data:extend({makeenemyspawner("tanker", health_spawner_tanker, spawning_amount_tanker, tanker_spawner_scale, 2, spawner_medium_loot, tankerresistances(4),tanker_tint, autoplace_spacing_tanker, spawning_time_scalar_tanker)})
data:extend({makeenemyspawner("tanker", health_spawner_tanker, spawning_amount_tanker, tanker_spawner_scale, 3, spawner_big_loot, tankerresistances(5),tanker_tint, autoplace_spacing_tanker, spawning_time_scalar_tanker)})
data:extend({makeenemyspawner("tanker", health_spawner_tanker, spawning_amount_tanker, tanker_spawner_scale, 4, spawner_big_loot, tankerresistances(6),tanker_tint, autoplace_spacing_tanker, spawning_time_scalar_tanker)})
data:extend({makeenemyspawner("tanker", health_spawner_tanker, spawning_amount_tanker, tanker_spawner_scale, 5, spawner_big_loot, tankerresistances(7) ,tanker_tint, autoplace_spacing_tanker, spawning_time_scalar_tanker)})

data:extend({makeenemyspawner("biter", health_spawner_biter, spawning_amount_biter, biter_spawner_scale, 1, spawner_medium_loot, biterresistances(2),biter_spawner_tint, autoplace_spacing_biter, spawning_time_scalar_biter)})
data:extend({makeenemyspawner("biter", health_spawner_biter, spawning_amount_biter, biter_spawner_scale, 2, spawner_medium_loot, biterresistances(3),biter_spawner_tint, autoplace_spacing_biter, spawning_time_scalar_biter)})
data:extend({makeenemyspawner("biter", health_spawner_biter, spawning_amount_biter, biter_spawner_scale, 3, spawner_big_loot, biterresistances(4),biter_spawner_tint, autoplace_spacing_biter, spawning_time_scalar_biter)})
data:extend({makeenemyspawner("biter", health_spawner_biter, spawning_amount_biter, biter_spawner_scale, 4, spawner_big_loot, biterresistances(5),biter_spawner_tint, autoplace_spacing_biter, spawning_time_scalar_biter)})
data:extend({makeenemyspawner("biter", health_spawner_biter, spawning_amount_biter, biter_spawner_scale, 5, spawner_boss_loot, biterresistances(6),biter_spawner_tint, autoplace_spacing_biter, spawning_time_scalar_biter)})

data:extend({makeenemyspawner("spitter", health_spawner_spitter, spawning_amount_spitter, spitter_spawner_scale, 1, spawner_small_loot,  spitterresistances(2),spitter_spawner_tint, autoplace_spacing_spitter, spawning_time_scalar_spitter)})
data:extend({makeenemyspawner("spitter", health_spawner_spitter, spawning_amount_spitter, spitter_spawner_scale, 2, spawner_medium_loot,  spitterresistances(3),spitter_spawner_tint, autoplace_spacing_spitter, spawning_time_scalar_spitter)})
data:extend({makeenemyspawner("spitter", health_spawner_spitter, spawning_amount_spitter, spitter_spawner_scale, 3, spawner_medium_loot,  spitterresistances(4),spitter_spawner_tint, autoplace_spacing_spitter, spawning_time_scalar_spitter)})
data:extend({makeenemyspawner("spitter", health_spawner_spitter, spawning_amount_spitter, spitter_spawner_scale, 4, spawner_medium_loot,  spitterresistances(5),spitter_spawner_tint, autoplace_spacing_spitter, spawning_time_scalar_spitter)})
data:extend({makeenemyspawner("spitter", health_spawner_spitter, spawning_amount_spitter, spitter_spawner_scale, 5, spawner_big_loot,  spitterresistances(6),spitter_spawner_tint, autoplace_spacing_spitter, spawning_time_scalar_spitter)})

data:extend({makeenemyspawner("swarmer", health_spawner_swarmer, spawning_amount_swarmer, swarmer_spawner_scale, 1, spawner_small_loot,  swarmerresistances(2),swarmer_spawner_tint, autoplace_spacing_swarmer, spawning_time_scalar_swarmer)})
data:extend({makeenemyspawner("swarmer", health_spawner_swarmer, spawning_amount_swarmer, swarmer_spawner_scale, 2, spawner_small_loot,  swarmerresistances(3),swarmer_spawner_tint, autoplace_spacing_swarmer, spawning_time_scalar_swarmer)})
data:extend({makeenemyspawner("swarmer", health_spawner_swarmer, spawning_amount_swarmer, swarmer_spawner_scale, 3, spawner_small_loot,  swarmerresistances(4),swarmer_spawner_tint, autoplace_spacing_swarmer, spawning_time_scalar_swarmer)})
data:extend({makeenemyspawner("swarmer", health_spawner_swarmer, spawning_amount_swarmer, swarmer_spawner_scale, 4, spawner_medium_loot,  swarmerresistances(5),swarmer_spawner_tint, autoplace_spacing_swarmer, spawning_time_scalar_swarmer)})
data:extend({makeenemyspawner("swarmer", health_spawner_swarmer, spawning_amount_swarmer, swarmer_spawner_scale, 5, spawner_medium_loot,  swarmerresistances(6),swarmer_spawner_tint, autoplace_spacing_swarmer, spawning_time_scalar_swarmer)})

data:extend({makeenemyspawner("blaster", health_spawner_blaster, spawning_amount_blaster, blaster_spawner_scale, 1, spawner_medium_loot,  blasterresistances(2),blaster_spawner_tint, autoplace_spacing_blaster, spawning_time_scalar_blaster)})
data:extend({makeenemyspawner("blaster", health_spawner_blaster, spawning_amount_blaster, blaster_spawner_scale, 2, spawner_medium_loot, blasterresistances(3),blaster_spawner_tint, autoplace_spacing_blaster, spawning_time_scalar_blaster)})
data:extend({makeenemyspawner("blaster", health_spawner_blaster, spawning_amount_blaster, blaster_spawner_scale, 3, spawner_big_loot, blasterresistances(4),blaster_spawner_tint, autoplace_spacing_blaster, spawning_time_scalar_blaster)})
data:extend({makeenemyspawner("blaster", health_spawner_blaster, spawning_amount_blaster, blaster_spawner_scale, 4, spawner_big_loot, blasterresistances(5),blaster_spawner_tint, autoplace_spacing_blaster, spawning_time_scalar_blaster)})
data:extend({makeenemyspawner("blaster", health_spawner_blaster, spawning_amount_blaster, blaster_spawner_scale, 5, spawner_behemoth_loot, blasterresistances(6),blaster_spawner_tint, autoplace_spacing_blaster, spawning_time_scalar_blaster)})

data:extend({makeenemyspawner("webber", health_spawner_webber, spawning_amount_webber, webber_spawner_scale, 1, spawner_small_loot,  webberresistances(2),webber_spawner_tint, autoplace_spacing_webber, spawning_time_scalar_webber)})
data:extend({makeenemyspawner("webber", health_spawner_webber, spawning_amount_webber, webber_spawner_scale, 2, spawner_medium_loot, webberresistances(3),webber_spawner_tint, autoplace_spacing_webber, spawning_time_scalar_webber)})
data:extend({makeenemyspawner("webber", health_spawner_webber, spawning_amount_webber, webber_spawner_scale, 3, spawner_medium_loot, webberresistances(4),webber_spawner_tint, autoplace_spacing_webber, spawning_time_scalar_webber)})
data:extend({makeenemyspawner("webber", health_spawner_webber, spawning_amount_webber, webber_spawner_scale, 4, spawner_medium_loot, webberresistances(5),webber_spawner_tint, autoplace_spacing_webber, spawning_time_scalar_webber)})
data:extend({makeenemyspawner("webber", health_spawner_webber, spawning_amount_webber, webber_spawner_scale, 5, spawner_big_loot, webberresistances(6),webber_spawner_tint, autoplace_spacing_webber, spawning_time_scalar_webber)})

data:extend({makeenemyspawner("flamer", health_spawner_flamer, spawning_amount_flamer, flamer_spawner_scale, 1, spawner_small_loot,  flamerresistances(2),flamer_spawner_tint, autoplace_spacing_flamer, spawning_time_scalar_flamer)})
data:extend({makeenemyspawner("flamer", health_spawner_flamer, spawning_amount_flamer, flamer_spawner_scale, 2, spawner_medium_loot, flamerresistances(3),flamer_spawner_tint, autoplace_spacing_flamer, spawning_time_scalar_flamer)})
data:extend({makeenemyspawner("flamer", health_spawner_flamer, spawning_amount_flamer, flamer_spawner_scale, 3, spawner_medium_loot, flamerresistances(4),flamer_spawner_tint, autoplace_spacing_flamer, spawning_time_scalar_flamer)})
data:extend({makeenemyspawner("flamer", health_spawner_flamer, spawning_amount_flamer, flamer_spawner_scale, 4, spawner_medium_loot, flamerresistances(5),flamer_spawner_tint, autoplace_spacing_flamer, spawning_time_scalar_flamer)})
data:extend({makeenemyspawner("flamer", health_spawner_flamer, spawning_amount_flamer, flamer_spawner_scale, 5, spawner_big_loot, flamerresistances(6),flamer_spawner_tint, autoplace_spacing_flamer, spawning_time_scalar_flamer)})

data:extend({makeenemyspawner("stinger", health_spawner_stinger, spawning_amount_stinger, stinger_spawner_scale, 1, spawner_small_loot,  stingerresistances(2),stinger_spawner_tint, autoplace_spacing_stinger, spawning_time_scalar_stinger)})
data:extend({makeenemyspawner("stinger", health_spawner_stinger, spawning_amount_stinger, stinger_spawner_scale, 2, spawner_medium_loot, stingerresistances(3),stinger_spawner_tint, autoplace_spacing_stinger, spawning_time_scalar_stinger)})
data:extend({makeenemyspawner("stinger", health_spawner_stinger, spawning_amount_stinger, stinger_spawner_scale, 3, spawner_medium_loot, stingerresistances(4),stinger_spawner_tint, autoplace_spacing_stinger, spawning_time_scalar_stinger)})
data:extend({makeenemyspawner("stinger", health_spawner_stinger, spawning_amount_stinger, stinger_spawner_scale, 4, spawner_medium_loot, stingerresistances(5),stinger_spawner_tint, autoplace_spacing_stinger, spawning_time_scalar_stinger)})
data:extend({makeenemyspawner("stinger", health_spawner_stinger, spawning_amount_stinger, stinger_spawner_scale, 5, spawner_big_loot, stingerresistances(6),stinger_spawner_tint, autoplace_spacing_stinger, spawning_time_scalar_stinger)})

data:extend({makeenemyspawner("hatcher", health_spawner_hatcher, spawning_amount_hatcher, hatcher_spawner_scale, 1, spawner_small_loot,  hatcherresistances(2),hatcher_spawner_tint, autoplace_spacing_hatcher, spawning_time_scalar_hatcher)})
data:extend({makeenemyspawner("hatcher", health_spawner_hatcher, spawning_amount_hatcher, hatcher_spawner_scale, 2, spawner_medium_loot,  hatcherresistances(3),hatcher_spawner_tint, autoplace_spacing_hatcher, spawning_time_scalar_hatcher)})
data:extend({makeenemyspawner("hatcher", health_spawner_hatcher, spawning_amount_hatcher, hatcher_spawner_scale, 3, spawner_medium_loot,  hatcherresistances(4),hatcher_spawner_tint, autoplace_spacing_hatcher, spawning_time_scalar_hatcher)})
data:extend({makeenemyspawner("hatcher", health_spawner_hatcher, spawning_amount_hatcher, hatcher_spawner_scale, 4, spawner_medium_loot,  hatcherresistances(5),hatcher_spawner_tint, autoplace_spacing_hatcher, spawning_time_scalar_hatcher)})
data:extend({makeenemyspawner("hatcher", health_spawner_hatcher, spawning_amount_hatcher, hatcher_spawner_scale, 5, spawner_big_loot,  hatcherresistances(6),hatcher_spawner_tint, autoplace_spacing_hatcher, spawning_time_scalar_hatcher)})


function make_hatcher_egg(size,scale,tint)
return
{
    name = "hatcher-egg-"..size,
    type = "turret",
    flags = {"placeable-off-grid", "not-on-map"},
    icon = "__factorioplus__/graphics/icons/hatcher-egg.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "enemies",
    collision_box = {{-2 * scale, -2 * scale}, {2 * scale, 2 * scale}},
    selection_box = {{-2 * scale, -2 * scale}, {2 * scale, 2 * scale}},
	collision_mask = {layers={item=true, meltable=true, object=true, player=true, water_tile=true, is_object=true, is_lower_object=true, ghost=true}},
    render_layer = "object",
    max_health = math.floor((hatcher_egg_health_base * scale * scale)) * 10,
	healing_per_tick = -( 1 * scale),
	call_for_help_radius = 0,
	
	folded_animation = 
	{
		north =
		{
			  filename = "__factorioplus__/graphics/enemies/hatcher_egg.png",
			  width = 1,
			  height = 1,
			  scale = 0.25 * scale,
			  shift = {0,0},
		},
	},
	attack_parameters =
	{	
		
	  type = "projectile",
	  range = 0,
	  cooldown = 9999,
	  cooldown_deviation = 0.1 ,
	  ammo_category = "melee",
	  ammo_type = make_unit_melee_ammo_type(0),
		-- sound = sounds.biter_roars(0.5 * scale),
		-- animation = biterattackanimation(scale, tint, tint)
		
	},
		
	-- result_units = { 
	-- { "small-swarmer", {{0.99, 1.0}, {1.0, 1.0}} },
	-- },
	dying_explosion = "small-worm-die",
	amaged_trigger_effect = hit_effects.biter(),
	
	dying_trigger_effect = 
		{
	  {
		type = "create-entity",
		entity_name = size.."-swarmer",
		as_enemy = true,
		offsets =
		{
		  util.rotate_position({0,0}, 0), 
		}
	  }
	},
	
	graphics_set =
	{
		base_visualisation =
		{
			animation =
			{
				north =
				{
					layers =
					{
						{
						  filename = "__factorioplus__/graphics/enemies/hatcher_egg.png",
						  width = 186,
						  height = 214,
						  scale = 1 * scale,
						  shift = {0,0},
						  run_mode = "forward-then-backward",
						  frame_count = 8,
						  animation_speed = 0.05 / scale,
						},
						{
						  filename = "__factorioplus__/graphics/enemies/hatcher_egg_mask.png",
						  flags = { "mask" },
						  width = 186,
						  height = 214,
						  scale = 1 * scale,
						  shift = {0,0},
						  run_mode = "forward-then-backward",
						  tint = tint,
						  frame_count = 8,
						  animation_speed = 0.05 / scale,
						},
						{
						  filename = "__factorioplus__/graphics/enemies/hatcher_egg_shadow.png",
						  flags = { "shadow" },
						  width = 186,
						  height = 214,
						  scale = 1 * scale,
						  shift = {0,0},
						  run_mode = "forward-then-backward",
						  draw_as_shadow = true,
						  frame_count = 8,
						  animation_speed = 0.05 / scale,
						},
					}
				},
			},
		},
	},
}
end
  
data:extend({
make_hatcher_egg("small",small_swarmer_scale,swarmer_spawner_tint),
make_hatcher_egg("medium",medium_swarmer_scale,swarmer_spawner_tint),
make_hatcher_egg("big",big_swarmer_scale,swarmer_spawner_tint),
make_hatcher_egg("behemoth",behemoth_swarmer_scale,swarmer_spawner_tint),
make_hatcher_egg("boss",boss_swarmer_scale,swarmer_spawner_tint),

})

-- FISH
data.raw["fish"]["fish"].minable = {mining_time = 0.4, result = "raw-fish", count = 1}
data.raw["fish"]["fish"].autoplace = {  tile_restriction = {"water", "water-shallow"}, probability_expression = 0.01 }
data.raw["fish"]["fish"].pictures =
{
	sheet =
	{
		filename = "__factorioplus__/graphics/enemies/fish_simple.png",
		priority = "extra-high",
		width = 32,
		height = 32,
		variation_count = 8,
		line_length = 4,
	},
}

data:extend({
 {
    type = "fish",
    name = "fish-shoal",
    icon = "__base__/graphics/icons/fish-entity.png",
    flags = {"placeable-neutral", "not-on-map"},
     minable =
    {
      mining_time = 2,
       results = 
	  {
	  {type = "item", name = "raw-fish", amount_min = 12, amount_max = 30}, 
	  },
    },
    mined_sound = sounds.mine_fish,
    max_health = 150,
    subgroup = "creatures",
    order = "b-b",
    --factoriopedia_simulation = simulations.factoriopedia_fish,
    collision_box = {{-1.0, -1.0}, {1.0, 1.0}},
    selection_box = {{-1.3, -1.3}, {1.3, 1.3}},
    pictures =
    {
		sheet =
      {
        filename = "__factorioplus__/graphics/enemies/fish_shoal.png",
        priority = "extra-high",
        width = 128,
        height = 128,
		scale = 0.8,
      },
    },
    autoplace = { tile_restriction = { "deepwater", "oceanwater" }, probability_expression = 0.0005 },
    protected_from_tile_building = false
  },
})

data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["entity"].settings["fish-shoal"] = {}

---------------------------------------------------  ALIEN FURNACE  ------------------------------------------------------------

-- data.extend({
-- {
    -- type = "recipe",
    -- name = "rawfish-meat",
	-- category = "alien-furnace",
	-- hidden = true,
	-- energy_required = 10,
	-- ingredients =
	-- {
		-- {type="item", name="raw-fish", amount=1},
	-- },
		-- results = {{type="item", name="chunky-meat", amount=1}},
-- },

-- {
    -- type = "recipe",
    -- name = "cookedfish-meat",
	-- category = "alien-furnace",
	-- hidden = true,
	-- energy_required = 15,
	-- ingredients =
	-- {
		-- {type="item", name="cooked-fish", amount=1},
	-- },
		-- results = {{type="item", name="chunky-meat", amount=2}},
-- },
  
-- {
    -- type = "furnace",
    -- name = "alien-furnace",
    -- icon = "__factorioplus__/graphics/icons/big-furnace.png",
    -- icon_size = 64, icon_mipmaps = 4,
    -- flags = {"not-repairable"},
    -- minable =
    -- {
      -- mining_time = 3,
       -- results = 
	  -- {
	  -- {type = "item", name = "chunky-meat", amount_min = 10, amount_max = 20}, 
	  -- },
    -- },
    -- max_health = 600,
	-- allow_run_time_change_of_is_military_target = true,
    -- --corpse = "stone-furnace-remnants",
    -- --dying_explosion = "stone-furnace-explosion",
    -- -- repair_sound = sounds.manual_repair,
    -- --mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg",volume = 0.9},
    -- -- open_sound = sounds.machine_open,
    -- -- close_sound = sounds.machine_close,
    -- -- vehicle_impact_sound = sounds.car_stone_impact,
    -- working_sound =
    -- {
      -- sound =
      -- {
        -- {
          -- filename = "__base__/sound/furnace.ogg",
          -- volume = 0.9
        -- }
      -- },
      -- fade_in_ticks = 4,
      -- fade_out_ticks = 20,
      -- audible_distance_modifier = 0.6,
    -- },
    -- resistances =
    -- {
      -- {
        -- type = "acid",
        -- percent = 95
      -- },
      -- {
        -- type = "explosion",
        -- percent = 30
      -- },
      -- {
        -- type = "impact",
        -- percent = 30
      -- }
    -- },
    -- collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    -- selection_box = {{-1.4, -1.4}, {1.4, 1.4}},
    -- -- damaged_trigger_effect = hit_effects.rock(),
    -- crafting_categories = {"alien-furnace"},
    -- result_inventory_size = 1,
    -- crafting_speed = 1.0,
    -- source_inventory_size = 1,
	-- energy_usage = "63kW",
    -- energy_source = {type = "void"},
	-- graphics_set =
    -- {
		-- animation =
		-- {
		  -- layers =
		  -- {
			-- {
			  -- filename = "__factorioplus__/graphics/big-furnace.png",
			  -- priority = "extra-high",
			  -- width = 192,
			  -- height = 256,
			  -- frame_count = 1,
			  -- shift = util.by_pixel(0, -18),
			  -- scale = 0.5,
			-- },
			-- {
			  -- filename = "__factorioplus__/graphics/big-furnace-shadow.png",
			  -- priority = "extra-high",
			  -- width = 284,
			  -- height = 256,
			  -- frame_count = 1,
			  -- draw_as_shadow = true,
			  -- shift = util.by_pixel(22, -18),
			  -- scale = 0.5,
			-- }
		  -- }
		-- },
		-- working_visualisations =
		-- {
		  -- {
			-- north_position = {0.0, 0.0},
			-- east_position = {0.0, 0.0},
			-- south_position = {0.0, 0.0},
			-- west_position = {0.0, 0.0},
			-- animation =
			-- {
			  -- filename = "__factorioplus__/graphics/big-furnace-on.png",
			  -- priority = "extra-high",
			  -- line_length = 1,
			  -- width = 192,
			  -- height = 256,
			  -- frame_count = 1,
			  -- axially_symmetrical = false,
			  -- direction_count = 1,
			  -- shift = util.by_pixel(0, -18),
			  -- scale = 0.5,
			-- },
			-- light = {intensity = 1, size = 1, color = {r=1.0, g=1.0, b=1.0}}
		  -- }
		-- },
	-- },

    -- water_reflection =
    -- {
      -- pictures =
      -- {
        -- filename = "__base__/graphics/entity/stone-furnace/stone-furnace-reflection.png",
        -- priority = "extra-high",
        -- width = 16,
        -- height = 16,
        -- shift = util.by_pixel(0, 35),
        -- variation_count = 1,
        -- scale = 0.75,
      -- },
      -- rotate = false,
      -- orientation_to_variation = false
    -- }
  -- },
-- })