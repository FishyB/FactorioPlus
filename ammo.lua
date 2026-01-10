
local sounds = require("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local explosion_animations = require("__base__.prototypes.entity.explosion-animations")
local math3d = require "math3d"
local fireutil = require("__base__.prototypes.fire-util")
local firestickerutil = require("__factorioplus__.util-fire-stickers")
local beams = require("__base__.prototypes.entity.beams")
require ("__factorioplus__.util-attack-helpers")
require("stats")

data.raw["beam"]["laser-beam"].working_sound.sound.speed = 2.0

local shotgun_hit_layers = {layers={ train=true, is_object=true, trigger_target=true}}

local bullet_trail_blend_mode = "additive-soft"

function make_bullet_trail(name, scale, color)
local trail_color = color or {1,1,1,1}
  local result =
  {
    type = "beam",
    flags = {"not-on-map"},
    hidden = true,
    width = scale,
    damage_interval = 1,
    random_target_offset = true,
    action_triggered_automatically = false,
    graphics_set =
    {
	  desired_segment_length = 1 * scale,
      beam =
      {
        
        body =
        {
          {
            layers =
            {
              {
                filename = "__factorioplus__/graphics/entity/bullet_trails/trail-body-basic.png",
                flags = { "trilinear-filtering" },
                line_length = 8,
                width = 64,
                height = 12,
                frame_count = 8,
                scale = scale,
                animation_speed = 0.5,
				tint = trail_color,
                blend_mode = bullet_trail_blend_mode,
              },
            }
          }
        },
        -- render_layer = "projectile"
      },
   
    }
  }

    result.working_sound =
    {
      sound =
      {
        category = "weapon",
        filename = "__factorioplus__/sounds/bullet-whiff-1.ogg",
        volume = 0.7,
        modifiers = volume_multiplier("main-menu", 2.5)
      },
      max_sounds_per_type = 2
    }
    result.name = name

  return result
end


local bullet_trail_regular_color = {0.3,0.3,0.1, 0.4}
local bullet_trail_explosive_color = {0.4,0.3,0.2, 0.5}
local bullet_trail_piercing_color = {0.4,0.4,0.2, 0.5}
local bullet_trail_uranium_color = {0.15,0.4,0.15, 0.5}
local bullet_trail_nuke_color = {0.2,0.8,0.2, 0.7}
local bullet_trail_duration = 2

data.extend({
make_bullet_trail("regular_bullet_trail",0.2, bullet_trail_regular_color),
make_bullet_trail("piercing_bullet_trail",0.3, bullet_trail_piercing_color),
make_bullet_trail("explosive_bullet_trail",0.45, bullet_trail_explosive_color),
make_bullet_trail("uranium_bullet_trail",0.3, bullet_trail_uranium_color),
make_bullet_trail("nuke_bullet_trail",0.45, bullet_trail_nuke_color),
})



local explosive_wave_helper = function (name,damage,radius)
  return
  {
  data.extend({ 
  make_explosive_damage_wave_projectile(name.."-inner",damage/4,radius),
  make_explosive_damage_wave_projectile(name.."-outer",damage/10,radius),
  })
  }
end
  
explosive_wave_helper ("cannon-explosive", cannon_shell_explosive_damage_explosive,3)
explosive_wave_helper ("rocket-explosive", rocket_explosive_damage_explosive,3)

local stream_sprites =
{
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
    shift = {0, 0}
  },

  shadow =
  {
    filename = "__base__/graphics/entity/acid-projectile/projectile-shadow.png",
    line_length = 5,
    width = 28,
    height = 16,
    frame_count = 33,
    priority = "high",
    shift = {-0.09, 0.395}
  },

  particle = util.draw_as_glow
  {
    filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
    priority = "extra-high",
    blend_mode = "normal",
    tint = {r=0.9, g=0.9, b=0.9, a=0.55},
    line_length = 6,
    width = 124,
    height = 108,
    frame_count = 36,
    scale = 0.666,
  }
}

if (mods["space-age"]) then  
data.raw["ammo"]["railgun-ammo"].ammo_type.action.range = data.raw["ammo"]["railgun-ammo"].ammo_type.action.range * 1.25
end


data:extend({
  {
    type = "damage-type",
    name = "piercing"
  },
  {
    type = "ammo-category",
    name = "beltfed-bullet",
	icon = "__factorioplus__/graphics/icons/ammo-category-mini-gun.png",
	subgroup = "ammo-category"
  },
  {
    type = "ammo-category",
    name = "grenade-shell",
	icon = "__factorioplus__/graphics/icons/ammo-category-mortar.png",
	subgroup = "ammo-category"
  },
    {
    type = "ammo-category",
    name = "railgun"
  },
  {
    type = "ammo-category",
    name = "battery-ammo"
  },
  {
    type = "ammo-category",
    name = "brick",
	hidden = true
  },
     {
    type = "ammo-category",
    name = "sniper-shell",
	icon = "__factorioplus__/graphics/icons/ammo-category-sniper.png",
	subgroup = "ammo-category"
  },
  {
    type = "ammo-category",
    name = "plasma-cell",
	icon = "__factorioplus__/graphics/icons/ammo-category-plasma.png",
	subgroup = "ammo-category"
  },
    -- {
    -- type = "ammo-category",
    -- name = "poison-rocket",
	-- icon = "__factorioplus__/graphics/icons/ammo-category-poison.png",
	-- subgroup = "ammo-category"
  -- },
      -- {
    -- type = "ammo-category",
    -- name = "poison-capsule",
	-- icon = "__factorioplus__/graphics/icons/ammo-category-poison.png",
	-- subgroup = "ammo-category"
  -- },

----------------------------- NAPALM AMMO -----------------------------  

firestickerutil.makefiresticker("napalm-fire-sticker", mortar_napalm_firestickerapplyradius, mortar_napalm_firedps, mortar_napalm_fireburnsticker_time, 0.60, nil, nil),
  
  
  fireutil.add_basic_fire_graphics_and_effects_definitions
  {
  type = "fire",
  name = "napalm-ground-fire-flame",
  flags = {"placeable-off-grid", "not-on-map"},
  --collision_box = {{-4, -4}, {4, 4}},
  damage_per_tick = {amount = mortar_napalm_firedps / 60, type = "fire"},
  maximum_damage_multiplier = 6,
  damage_multiplier_increase_per_added_fuel = 1,
  damage_multiplier_decrease_per_tick = 0.25 / 60,

  spawn_entity = "fire-flame",

  spread_delay = 100,
  spread_delay_deviation = 80,
  maximum_spread_count = 1000,

  emissions_per_second = { pollution = 0.01 },

  initial_lifetime = mortar_napalm_fireground_time * 60,
  lifetime_increase_by = 150,
  lifetime_increase_cooldown = 4,
  maximum_lifetime = mortar_napalm_fireground_time * 60,
  delay_between_initial_flames = 10,
  limit_overlapping_particles = true,
  
},
  
   {
    type = "recipe",
    name = "flamethrower-ammo-napalm",
	category = "chemistry",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
	{type="item", name="flamethrower-ammo", amount=1},
	{type="item", name="plastic-bar", amount=4},
	{type = "fluid", name = "heavy-oil", amount = 60}
    },
    results = {{type="item", name="flamethrower-ammo-napalm", amount=1}},
	    crafting_machine_tint =
    {
      primary = {r = 1.000, g = 0.735, b = 0.643, a = 1.000}, -- #ffbba4ff
      secondary = {r = 0.749, g = 0.557, b = 0.490, a = 1.000}, -- #bf8e7dff
      tertiary = {r = 0.637, g = 0.637, b = 0.637, a = 1.000}, -- #a2a2a2ff
      quaternary = {r = 0.283, g = 0.283, b = 0.283, a = 1.000}, -- #484848ff
    }
  },
  
  {
    type = "ammo",
    name = "flamethrower-ammo-napalm",
    icon = "__factorioplus__/graphics/icons/flamethrower-ammo-napalm.png",
    ammo_category = "flamethrower",
    ammo_type =
    {
      {
        source_type = "default",
        target_type = "position",
        clamp_position = true,

        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "handheld-flamethrower-napalm-stream"
          }
        }
      },
      {
        source_type = "vehicle",
        consumption_modifier = 1.25,
        target_type = "position",
        clamp_position = true,

        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "tank-flamethrower-napalm-stream"
          }
        }
      }
    },
    magazine_size = 50,
    subgroup = "ammo",
    order = "eb[flamethrower]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    stack_size = 50,
    weight = 10*kg
  },
  
  {
    type = "stream",
    name = "handheld-flamethrower-napalm-stream",
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

    --stream_light = {intensity = 1, size = 4 * 0.8},
    --ground_light = {intensity = 0.8, size = 4 * 0.8},

    particle_buffer_size = 65,
    particle_spawn_interval = 2,
    particle_spawn_timeout = 2,
    particle_vertical_acceleration = 0.005 * 0.6,
    particle_horizontal_speed = 0.25,
    particle_horizontal_speed_deviation = 0.0035,
    particle_start_alpha = 0.5,
    particle_end_alpha = 1,
    particle_start_scale = 0.2,
    particle_loop_frame_count = 3,
    particle_fade_out_threshold = 0.9,
    particle_loop_exit_threshold = 0.25,
    action =
    {
      {
        type = "area",
        radius = 2.5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-sticker",
              sticker = "napalm-fire-sticker",
              show_in_tooltip = true
            },
            {
              type = "damage",
              damage = { amount = 2, type = "fire" },
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
              entity_name = "napalm-ground-fire-flame",
              show_in_tooltip = true,
              initial_ground_flame_count = 8
            }
          }
        }
      }
    },
    spine_animation = stream_sprites.spine_animation,
    shadow = stream_sprites.shadow,
    particle = stream_sprites.particle
  },
  
  {
    type = "stream",
    name = "tank-flamethrower-napalm-stream",
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

    --stream_light = {intensity = 1, size = 4 * 0.8},
    --ground_light = {intensity = 0.8, size = 4 * 0.8},

    particle_buffer_size = 65,
    particle_spawn_interval = 2,
    particle_spawn_timeout = 2,
    particle_vertical_acceleration = 0.005 * 0.3,
    particle_horizontal_speed = 0.55,
    particle_horizontal_speed_deviation = 0.0035,
    particle_start_alpha = 0.5,
    particle_end_alpha = 1,
    particle_start_scale = 0.35,
    particle_loop_frame_count = 3,
    particle_fade_out_threshold = 0.9,
    particle_loop_exit_threshold = 0.25,
    action =
    {
      {
        type = "area",
        radius = 2.5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-sticker",
              sticker = "napalm-fire-sticker",
              show_in_tooltip = true
            },
            {
              type = "damage",
              damage = { amount = 2, type = "fire" },
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
              entity_name = "napalm-ground-fire-flame",
              show_in_tooltip = true,
              initial_ground_flame_count = 10
            }
          }
        }
      }
    },
    spine_animation = stream_sprites.spine_animation,
    shadow = stream_sprites.shadow,
    particle = stream_sprites.particle
  },
  ----------------------------- BULLETS -----------------------------
  {
    type = "ammo",
    name = "firearm-magazine",
    icon = "__base__/graphics/icons/firearm-magazine.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "bullet",
    ammo_type =
    {
      category = "bullet",
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
			{
				-- Bullet trail
				type = "beam",
				beam = "regular_bullet_trail",
				max_length = 100,
				duration = bullet_trail_duration,
				source_offset = {0, -0.8 },
				add_to_shooter = false,
				destroy_with_source_or_target = false
			},
            {
              type = "instant",
              source_effects =
              {
                {
                  type = "create-explosion",
                  entity_name = "explosion-gunshot"
                }
              },
			  
              target_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "explosion-hit",
                  offsets = {{0, 1}},
                  offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
                },
                {
                  type = "damage",
                  damage = { amount = bullet_regular_physical , type = "physical"}
                }
              }
            }
          }
        }
      }
    },
    magazine_size = bullet_magazinesize,
	reload_time = bullet_reloadtime,
    subgroup = "ammo",
    order = "a[basic-clips]-a[firearm-magazine]",
    stack_size = bullet_stacksize,
	weight = 10*kg
  },
  
  {
    type = "recipe",
    name = "firearm-magazine",
    energy_required = 1,
    ingredients = {{type="item", name="iron-plate", amount=4}},
    results = {{type="item", name="firearm-magazine", amount=1}},
  },
    ----------------------------- PIERCING BULLETS -----------------------------
  {
    type = "ammo",
    name = "piercing-rounds-magazine",
    icon = "__factorioplus__/graphics/icons/magazine-piercing.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "bullet",
	--piercing_damage = 3,
    ammo_type =
    {
      category = "bullet",
      action =
      {
        type = "direct",
        action_delivery =
		{
		{
			-- Bullet trail
			type = "beam",
			beam = "piercing_bullet_trail",
			max_length = 100,
			duration = bullet_trail_duration,
			source_offset = {0, -0.8 },
			add_to_shooter = false,
			destroy_with_source_or_target = false
		},
        {
          type = "instant",
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-hit",
              offsets = {{0, 1}},
              offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
            },
            {
              type = "damage",
              damage = { amount = bullet_piercing_physical, type = "physical"}
            },
			{
			  type = "damage",
			  damage = { amount = bullet_piercing_piercing , type = "piercing"}
            }
          }
        }
		}
      }
    },
    magazine_size = bullet_magazinesize,
	reload_time = bullet_reloadtime,
    subgroup = "ammo",
    order = "a[basic-clips]-b[piercing-rounds-magazine]",
    stack_size = bullet_stacksize,
	weight = 10*kg
  },
  
  {
    type = "recipe",
    name = "piercing-rounds-magazine",
    enabled = false,
    energy_required = 3,
    ingredients =
    {
      {type="item", name="firearm-magazine", amount=1},
      {type="item", name="steel-plate", amount=1},
      {type="item", name="copper-plate", amount=5}
    },
    results = {{type="item", name="piercing-rounds-magazine", amount=1}},
  },
  
     ----------------------------- LR BULLETS -----------------------------
  {
    type = "ammo",
    name = "longrange-rounds-magazine",
    icon = "__factorioplus__/graphics/icons/magazine-longrange.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "bullet",
    ammo_type =
    {
		range_modifier = bullet_longrange_range_modifier,
		cooldown_modifier = bullet_longrange_cooldown_modifier,
		consumption_modifier = 1,
		category = "bullet",
		action =
		{
			type = "direct",
			action_delivery =
			{
				{
					-- Bullet trail
					type = "beam",
					beam = "piercing_bullet_trail",
					max_length = 100,
					duration = bullet_trail_duration,
					source_offset = {0, -0.8 },
					add_to_shooter = false,
					destroy_with_source_or_target = false
				},
				{
				  type = "instant",
				  source_effects =
				  {
					type = "create-explosion",
					entity_name = "explosion-gunshot"
				  },
				  target_effects =
				  {
					{
					  type = "create-entity",
					  entity_name = "explosion-hit",
					  offsets = {{0, 1}},
					  offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
					},
					{
					  type = "damage",
					  damage = { amount = bullet_longrange_physical, type = "physical"}
					},
					{
					  type = "damage",
					  damage = { amount = bullet_longrange_piercing , type = "piercing"}
					}
				  }
				}
			}
      }
    },
    magazine_size = bullet_longrange_magazine_size,
	reload_time = bullet_reloadtime,
    subgroup = "ammo",
    order = "a[basic-clips]-b[piercing-rounds-magazine]",
    stack_size = bullet_stacksize,
	weight = 10*kg
  },
  
  {
    type = "recipe",
    name = "longrange-rounds-magazine",
    enabled = false,
    energy_required = 6,
    ingredients =
    {
      {type="item", name="firearm-magazine", amount=1},
      {type="item", name="aluminium-plate", amount=4},
    },
    results = {{type="item", name="longrange-rounds-magazine", amount=1}},
  },
  
  
  ----------------------------- EXPLOSIVE BULLETS -----------------------------
  {
    type = "ammo",
    name = "explosive-rounds-magazine",
    icon = "__factorioplus__/graphics/icons/magazine-explosive.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "bullet",
    ammo_type =
    {
      category = "bullet",
	  cooldown_modifier = bullet_explosive_cooldown_modifier,
	  consumption_modifier = 1,
      action =
      {
		  type = "direct",
		  action_delivery =
		  {
			{
				-- Bullet trail
				type = "beam",
				beam = "explosive_bullet_trail",
				max_length = 100,
				duration = bullet_trail_duration,
				source_offset = {0, -0.8 },
				add_to_shooter = false,
				destroy_with_source_or_target = false
			},
			{
				type = "instant",
				target_effects =
				{
					{
					  type = "damage",
					  damage = { amount = bullet_explosive_physical, type = "physical"}
					},
				}
			},
			{
			  
				type = "instant",	
				source_effects =
					  {
						type = "create-explosion",
						entity_name = "explosion-gunshot"
					  },
				target_effects =
				{
					  {
						type = "create-entity",
						entity_name = "grenade-explosion"
					  },
					  
					  {
						type = "nested-result",
						action =
						{
						  type = "area",
						  radius = bullet_explosive_radius,
						  force = "not-same",
						  action_delivery =
						  {
							type = "instant",
							target_effects =
							{
							  {
								type = "damage",
								damage = {amount = bullet_explosive_explosive, type = "explosion"}
							  },
							  {
								type = "create-entity",
								entity_name = "explosion"
							  }
							}
						  }
						},
					  },
					   {
						type = "nested-result",
						action =
						{
						  type = "area",
						  radius = bullet_explosive_radius / friendly_fire_radius_reduction_factor,
						  show_in_tooltip = false,
						  force = "same",
						  action_delivery =
						  {
							type = "instant",
							target_effects =
							{
							  {
								type = "damage",
								damage = {amount = bullet_explosive_explosive * friendly_fire_modifier, type = "explosion"}
							  },
							}
						  }
						},
					  },
				  -- {
				  -- type = "invoke-tile-trigger",
				  -- repeat_count = 1,
				  -- },
				  {
					type = "create-trivial-smoke",
					smoke_name = "artillery-smoke",
					initial_height = 0,
					speed_from_center = 0.1,
					speed_from_center_deviation = 0.005,
					offset_deviation = {{-1, -1}, {1, 1}},
					max_radius = 1.5,
					repeat_count = 2 * 4
					},
				}
			  }
		  }
    },
    },
    magazine_size = bullet_explosive_magazinesize,
	reload_time = bullet_reloadtime,
    subgroup = "ammo",
    order = "a[basic-clips]-d[explosive-rounds-magazine]",
    stack_size = bullet_stacksize,
	weight = 10*kg
  },
  
  {
    type = "recipe",
    name = "explosive-rounds-magazine",
    enabled = false,
    energy_required = 6,
    ingredients =
    {
      {type="item", name="firearm-magazine", amount=1},
      {type="item", name="explosives", amount=2},
    },
    results = {{type="item", name="explosive-rounds-magazine", amount=1}},
  },
  
      ----------------------------- URANIUM BULLETS -----------------------------
    
	{
    type = "ammo",
    name = "uranium-rounds-magazine",
    icon = "__factorioplus__/graphics/icons/magazine-depleted.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "bullet",
    ammo_type =
    {
      
      action =
      {
        type = "direct",
        action_delivery =
		{
			{
					-- Bullet trail
					type = "beam",
					beam = "uranium_bullet_trail",
					max_length = 100,
					duration = bullet_trail_duration,
					source_offset = {0, -0.8 },
					add_to_shooter = false,
					destroy_with_source_or_target = false
			},
			{
			  type = "instant",
			  source_effects =
			  {
				type = "create-explosion",
				entity_name = "uranium-explosion-gunshot"
			  },
			  target_effects =
			  {
				{
				  type = "create-entity",
				  entity_name = "uranium-small-explosion",
				  offsets = {{0, 1}},
				  offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
				},
				{
				  type = "damage",
				  damage = { amount = bullet_uranium_physical, type = "physical"}
				},
				{
				  type = "damage",
				  damage = { amount = bullet_uranium_piercing , type = "piercing"}
				}
			  }
			}
		}
      }
    },
	reload_time = bullet_reloadtime,
    magazine_size = bullet_uranium_magazinesize,
    subgroup = "ammo",
    order = "a[basic-clips]-c[uranium-rounds-magazine]",
    stack_size = bullet_uranium_stacksize,
	weight = 10*kg
  },
  
   {
    type = "recipe",
    name = "uranium-rounds-magazine",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="piercing-rounds-magazine", amount=1},
      {type="item", name="uranium-238", amount=1}
    },
    results = {{type="item", name="uranium-rounds-magazine", amount=1}},
  },
  
      ----------------------------- NUKE BULLETS -----------------------------
  {
    type = "ammo",
    name = "nuke-rounds-magazine",
    icon = "__factorioplus__/graphics/icons/magazine-nuke.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "bullet",
    ammo_type =
    {
      category = "bullet",
	  cooldown_modifier = 2.0,
      action =
      {
      type = "direct",
      action_delivery =
	  {
	  {
				-- Bullet trail
				type = "beam",
				beam = "nuke_bullet_trail",
				max_length = 100,
				duration = bullet_trail_duration,
				source_offset = {0, -0.8 },
				add_to_shooter = false,
				destroy_with_source_or_target = false
		},
      {
	  
        type = "instant",
		source_effects =
          {
            type = "create-explosion",
            entity_name = "uranium-explosion-gunshot"
          },
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "uranium-medium-explosion"
          },
		  -- ENEMIES DAMAGE
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = bullet_nuke_radius,
			  force = "not-same",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
				{
                    type = "damage",
                    damage = {amount = bullet_nuke_physical, type = "physical"}
                  },
                  {
                    type = "damage",
                    damage = {amount = bullet_nuke_explosive, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "uranium-explosion"
                  }
                }
              }
            },
          },
		  -- PLAYER DAMAGE
		   {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = bullet_nuke_radius / friendly_fire_radius_reduction_factor,
			  show_in_tooltip = false,
			  force = "same",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
				{
                    type = "damage",
                    damage = {amount = bullet_nuke_physical * friendly_fire_modifier, type = "physical"}
                  },
                  {
                    type = "damage",
                    damage = {amount = bullet_nuke_explosive * friendly_fire_modifier, type = "explosion"}
                  },
                }
              }
            },
          },
		  {
            type = "set-tile",
            tile_name = "nuclear-ground",
            radius = 2,
            apply_projection = true,
            tile_collision_mask = {layers={water_tile=true}},
          },
          {
            type = "destroy-cliffs",
            radius = 1,
            explosion = "explosion"
          },
          {
            type = "camera-effect",
            effect = "screen-burn",
            duration = 60,
            ease_in_duration = 5,
            ease_out_duration = 60,
            delay = 0,
            strength = 1.25,
            full_strength_max_distance = 100,
            max_distance = 400
          },
          {
          type = "invoke-tile-trigger",
          repeat_count = 1,
          },
		  {
            type = "create-entity",
            entity_name = "small-scorchmark-tintable",
            check_buildability = true
          },
		  {
          type = "destroy-decoratives",
          from_render_layer = "decorative",
          to_render_layer = "object",
          include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
          include_decals = false,
          invoke_decorative_trigger = true,
          decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
          radius = 1 -- large radius for demostrative purposes
          },
		  {
            type = "create-trivial-smoke",
            smoke_name = "artillery-smoke",
            initial_height = 0,
            speed_from_center = 0.2,
            speed_from_center_deviation = 0.005,
            offset_deviation = {{-2, -2}, {2, 2}},
            max_radius = 2.5,
            repeat_count = 2 * 2 * 6
            },
        }
      }
	  }
    },
    },
    magazine_size = bullet_nuke_magazinesize,
	reload_time = bullet_reloadtime,
    subgroup = "ammo",
    order = "a[basic-clips]-e[nuke-rounds-magazine]",
    stack_size = bullet_nuke_stacksize,
	weight = 10*kg
  },
  
  {
    type = "recipe",
    name = "nuke-rounds-magazine",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {type="item", name="explosive-rounds-magazine", amount=2},
      {type="item", name="explosives", amount=4},
      {type="item", name="uranium-235", amount=1}
    },
    results = {{type="item", name="nuke-rounds-magazine", amount=1}},
  },
  
  ----------------------------- SNIPER SHELL -----------------------------
   {
    type = "ammo",
    name = "sniper-shell",
    icon = "__factorioplus__/graphics/icons/snipershell.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "sniper-shell",
    ammo_type =
    {
      category = "sniper-shell",
      target_type = "position",
      clamp_position = true,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = 1,
          action_delivery =
          {
            type = "projectile",
            projectile = "sniper-pellet",
            starting_speed = 2,
            starting_speed_deviation = 0,
            direction_deviation = 0,
            range_deviation = 0,
            max_range = sniperbullet_range
          }
        }
      }
    },
	final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    magazine_size = sniperbullet_magazinesize,
	reload_time = sniperbullet_reloadtime,
    subgroup = "ammo",
    order = "c-a[sniper]",
    stack_size = sniperbullet_stacksize,
	weight = 10*kg
  },
  
  {
    type = "projectile",
    name = "sniper-pellet",
    flags = {"not-on-map"},
    collision_box = {{-0.2, -0.45}, {0.2, 0.45}},
    acceleration = 0,
    direction_only = true,
	-- hit_collision_mask
	force_condition = "not-same",
	piercing_damage = sniperbullet_piercing_damage,
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
			  damage = {amount = sniperbullet_regular_piercing, type = "piercing"}
			},
		},
      },
    },
	final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    animation =
    {
      filename = "__base__/graphics/entity/piercing-bullet/piercing-bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
	  scale = 2.0,
      priority = "high"
    }
  },
  
  {
    type = "recipe",
    name = "sniper-shell",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="aluminium-plate", amount=8},
      {type="item", name="copper-plate", amount=6},
    },
    results = {{type="item", name="sniper-shell", amount=1}},
  },
  
   ----------------------------- SNIPER SHELL PIERCING -----------------------------
   {
    type = "ammo",
    name = "sniper-shell-piercing",
    icon = "__factorioplus__/graphics/icons/snipershell_piercing.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "sniper-shell",
    ammo_type =
    {
      category = "sniper-shell",
      target_type = "position",
      clamp_position = true,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = 1,
          action_delivery =
          {
            type = "projectile",
            projectile = "sniper-pellet-piercing",
            starting_speed = 2.25,
            starting_speed_deviation = 0,
            direction_deviation = 0,
            range_deviation = 0,
            max_range = sniperbullet_range
          }
        }
      }
    },
	final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    magazine_size = sniperbullet_magazinesize,
	reload_time = sniperbullet_reloadtime,
    subgroup = "ammo",
    order = "c-b[sniper]",
    stack_size = sniperbullet_stacksize,
	weight = 10*kg
  },
  
  {
    type = "projectile",
    name = "sniper-pellet-piercing",
    flags = {"not-on-map"},
    collision_box = {{-0.25, -0.45}, {0.25, 0.45}},
    acceleration = 0,
    direction_only = true,
	-- hit_collision_mask
	force_condition = "not-same",
	piercing_damage = sniperbullet_piercing_damage * 2,
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
			  damage = {amount = sniperbullet_regular_piercing * 2, type = "piercing"}
			},
		},
      },
    },
	final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    animation =
    {
      filename = "__base__/graphics/entity/piercing-bullet/piercing-bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
	  scale = 2.5,
      priority = "high"
    }
  },
  
  {
    type = "recipe",
    name = "sniper-shell-piercing",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="sniper-shell", amount=1},
      {type="item", name="copper-plate", amount=8},
	  {type="item", name="steel-plate", amount=4},
    },
    results = {{type="item", name="sniper-shell-piercing", amount=1}},
  },
  
     ----------------------------- SNIPER SHELL URANIUM -----------------------------
   {
    type = "ammo",
    name = "sniper-shell-uranium",
    icon = "__factorioplus__/graphics/icons/snipershell_uranium.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "sniper-shell",
    ammo_type =
    {
      category = "sniper-shell",
      target_type = "position",
      clamp_position = true,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = 1,
          action_delivery =
          {
            type = "projectile",
            projectile = "sniper-pellet-uranium",
            starting_speed = 2.5,
            starting_speed_deviation = 0,
            direction_deviation = 0,
            range_deviation = 0,
            max_range = sniperbullet_range
          }
        }
      }
    },
	final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    magazine_size = sniperbullet_magazinesize,
	reload_time = sniperbullet_reloadtime,
    subgroup = "ammo",
    order = "c-c[sniper]",
    stack_size = sniperbullet_stacksize,
	weight = 10*kg
  },
  
  {
    type = "projectile",
    name = "sniper-pellet-uranium",
    flags = {"not-on-map"},
    collision_box = {{-0.3, -0.45}, {0.3, 0.45}},
    acceleration = 0,
    direction_only = true,
	-- hit_collision_mask
	force_condition = "not-same",
	piercing_damage = sniperbullet_piercing_damage * 4,
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
			  damage = {amount = sniperbullet_regular_piercing * 4, type = "piercing"}
			},
		},
      },
    },
	final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    animation =
    {
      filename = "__base__/graphics/entity/piercing-bullet/piercing-bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
	  scale = 3,
	  tint = {0.2,0.9,0.2},
      priority = "high"
    }
  },
  
  {
    type = "recipe",
    name = "sniper-shell-uranium",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {type="item", name="sniper-shell-piercing", amount=1},
      {type="item", name="uranium-238", amount=2},
    },
    results = {{type="item", name="sniper-shell-uranium", amount=1}},
  },
  
  -----------------------------  SHOTGUN SHELL -----------------------------
  {
    type = "ammo",
    name = "shotgun-shell",
    icon = "__factorioplus__/graphics/icons/shotgun-shell.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "shotgun-shell",
    ammo_type =
    {
      category = "shotgun-shell",
      target_type = "direction",
      clamp_position = true,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = shell_regular_pellets/2,
          action_delivery =
          {
            type = "projectile",
            projectile = "shotgun-pellet",
            starting_speed = 1,
            starting_speed_deviation = 0.1,
            direction_deviation = shell_regular_arc,
            range_deviation = 1.5,
            max_range = shell_range
          }
        },
		 {
          type = "direct",
          repeat_count = shell_regular_pellets/2,
          action_delivery =
          {
            type = "projectile",
            projectile = "shotgun-pellet",
            starting_speed = 1,
            starting_speed_deviation = 0.1,
            direction_deviation = shell_regular_arc/3,
            range_deviation = 1.5,
            max_range = shell_range
          }
        },
      }
    },
    magazine_size = shell_magazinesize,
	reload_time = shell_reloadtime,
    subgroup = "ammo",
    order = "b[shotgun]-a[basic]",
    stack_size = shell_stacksize,
	weight = 10*kg
  },
  
    {
    type = "projectile",
    name = "shotgun-pellet",
    flags = {"not-on-map"},
    collision_box = {{-0.05, -0.25}, {0.05, 0.25}},
	hit_collision_mask = shotgun_hit_layers,
    acceleration = 0,
    direction_only = true,
	hit_at_collision_position = true,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "damage",
          damage = {amount = shell_regular_physical, type = "physical"}
        }
      }
    },
	final_action = 
  {
	  {
		  type = "direct",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
			  {
				type = "create-entity",
				entity_name = "gunshot-hit-puff-light"
			  },
			},
		  },
	  },
	},
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    }
  },

  {
    type = "recipe",
    name = "shotgun-shell",
    enabled = false,
    energy_required = 3,
    ingredients =
    {
      {type="item", name="copper-plate", amount=3},
      {type="item", name="iron-plate", amount=3}
    },
    results = {{type="item", name="shotgun-shell", amount=1}},
  },
   -----------------------------  SHOTGUN SHELL BIRDSHOT -----------------------------
  {
    type = "ammo",
    name = "shotgun-shell-birdshot",
    icon = "__factorioplus__/graphics/icons/shotgun-shell-birdshot.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "shotgun-shell",
    ammo_type =
    {
      category = "shotgun-shell",
      target_type = "direction",
	  cooldown_modifier = shell_explosive_cooldown_modifier,
      clamp_position = true,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = shell_regular_pellets*6,
          action_delivery =
          {
            type = "projectile",
            projectile = "shotgun-pellet-birdshot",
            starting_speed = 1,
            starting_speed_deviation = 0.15,
            direction_deviation = shell_regular_arc*2,
            range_deviation = 5,
            max_range = shell_range / 2
          } 
        },
      }
    },
	
    magazine_size = shell_magazinesize/2,
	reload_time = shell_reloadtime,
    subgroup = "ammo",
    order = "b[shotgun]-a[basic]",
    stack_size = shell_stacksize/2,
	weight = 10*kg
  },
  
    {
    type = "projectile",
    name = "shotgun-pellet-birdshot",
    flags = {"not-on-map"},
    collision_box = {{-0.05, -0.25}, {0.05, 0.25}},
	hit_collision_mask = shotgun_hit_layers,
    acceleration = 0,
    direction_only = true,
	hit_at_collision_position = true,
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
			  damage = {amount = shell_regular_physical, type = "physical"}
			},
			{
			  type = "damage",
			  damage = {amount = shell_piercing_piercing/2, type = "piercing"}
			},
		},
      }
    },
		final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    }
  },

  {
    type = "recipe",
    name = "shotgun-shell-birdshot",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
      {type="item", name="shotgun-shell", amount=4},
      {type="item", name="aluminium-plate", amount=5}
    },
    results = {{type="item", name="shotgun-shell-birdshot", amount=1}},
  },
  
   ----------------------------- PIERCING SHOTGUN SHELL -----------------------------
   {
    type = "ammo",
    name = "piercing-shotgun-shell",
    icon = "__base__/graphics/icons/piercing-shotgun-shell.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "shotgun-shell",
    ammo_type =
    {
      category = "shotgun-shell",
      target_type = "direction",
      clamp_position = true,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = shell_piercing_pellets/2,
          action_delivery =
          {
            type = "projectile",
            projectile = "piercing-shotgun-pellet",
            starting_speed = 1,
            starting_speed_deviation = 0.1,
            direction_deviation = shell_piercing_arc,
            range_deviation = 0.5,
            max_range = shell_range
          }
        },
		{
          type = "direct",
          repeat_count = shell_piercing_pellets/2,
          action_delivery =
          {
            type = "projectile",
            projectile = "piercing-shotgun-pellet",
            starting_speed = 1,
            starting_speed_deviation = 0.1,
            direction_deviation = shell_piercing_arc/3,
            range_deviation = 0.5,
            max_range = shell_range
          }
        },
      }
    },
	final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    magazine_size = shell_magazinesize,
	reload_time = shell_reloadtime,
    subgroup = "ammo",
    order = "b[shotgun]-b[piercing]",
    stack_size = shell_stacksize,
	weight = 10*kg
  },
  
  {
    type = "projectile",
    name = "piercing-shotgun-pellet",
    flags = {"not-on-map"},
    collision_box = {{-0.05, -0.25}, {0.05, 0.25}},
	hit_collision_mask = shotgun_hit_layers,
    acceleration = 0,
    direction_only = true,
	hit_at_collision_position = true,
	piercing_damage = 50, 
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
			  damage = {amount = shell_piercing_physical, type = "physical"}
			},
			{
			  type = "damage",
			  damage = {amount = shell_piercing_piercing, type = "piercing"}
			},
		},
      },
    },
	final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    animation =
    {
      filename = "__base__/graphics/entity/piercing-bullet/piercing-bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    }
  },
  
  {
    type = "recipe",
    name = "piercing-shotgun-shell",
    enabled = false,
    energy_required = 8,
    ingredients =
    {
      {type="item", name="shotgun-shell", amount=1},
      {type="item", name="copper-plate", amount=6},
      {type="item", name="steel-plate", amount=2}
    },
    results = {{type="item", name="piercing-shotgun-shell", amount=1}},
  },
  
  ----------------------------- EXPLOSIVE SHOTGUN SHELL -----------------------------
  {
    type = "ammo",
    name = "explosive-shotgun-shell",
    icon = "__factorioplus__/graphics/icons/shotgun-shell-explosive.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "shotgun-shell",
    ammo_type =
    {
      category = "shotgun-shell",
      target_type = "direction",
	  cooldown_modifier = shell_explosive_cooldown_modifier,
      clamp_position = true,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
		-- OUTER CONE
        {
          type = "direct",
          repeat_count = shell_explosive_pellets/2,
          action_delivery =
          {
            type = "projectile",
            projectile = "explosive-shotgun-pellet",
            starting_speed = 1,
            starting_speed_deviation = 0.1,
            direction_deviation = shell_explosive_arc,
            range_deviation = 1.0,
            max_range = shell_range 
          }
        },
		-- INNER CONE
		{
          type = "direct",
          repeat_count = shell_explosive_pellets/2,
          action_delivery =
          {
            type = "projectile",
            projectile = "explosive-shotgun-pellet",
            starting_speed = 1,
            starting_speed_deviation = 0.1,
            direction_deviation = shell_explosive_arc/3,
            range_deviation = 1.0,
            max_range = shell_range 
          }
        },
      }
    },
    magazine_size = shell_explosive_magazinesize,
	reload_time = shell_reloadtime,
    subgroup = "ammo",
    order = "b[shotgun]-d[explosive]",
    stack_size = shell_explosive_stacksize,
	weight = 10*kg
  },
  
    {
    type = "projectile",
    name = "explosive-shotgun-pellet",
    flags = {"not-on-map"},
    collision_box = {{-0.05, -0.25}, {0.05, 0.25}},
	hit_collision_mask = shotgun_hit_layers,
    acceleration = 0,
    direction_only = true,
	hit_at_collision_position = true,
    action =
    {
		type = "direct",
		action_delivery =
		{
			type = "instant",
			target_effects =
			{
			  type = "damage",
			  damage = {amount = shell_explosive_physical, type = "physical"}
			},
			{
				type = "create-entity",
				entity_name = "explosion"
		    }
		}	  
    },
	final_action =
    {
		  {
		  type = "direct",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
			  {
				type = "create-entity",
				entity_name = "explosion"
			  },
			  {
				type = "nested-result",
				action =
				{
				  type = "area",
				  radius = shell_explosive_radius,
				  force = "not-same",
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = shell_explosive_explosive, type = "explosion"}
					  },
					  {
						type = "create-entity",
						entity_name = "explosion"
					  },
					  {
						type = "create-trivial-smoke",
						smoke_name = "artillery-smoke",
						initial_height = 0,
						speed_from_center = 0.1,
						speed_from_center_deviation = 0.005,
						offset_deviation = {{-4, -4}, {4, 4}},
						max_radius = 1.5,
						repeat_count = 2 * 2 * 15
					  },
					}
				  }
				}
			  },
			   {
				type = "nested-result",
				action =
				{
				  type = "area",
				  radius = shell_explosive_radius / friendly_fire_radius_reduction_factor,
				  show_in_tooltip = false,
				  force = "same",
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = shell_explosive_explosive * friendly_fire_modifier, type = "explosion"}
					  },
					}
				  }
				}
			  },
			  {
				type = "create-entity",
				entity_name = "small-scorchmark-tintable",
				check_buildability = true
			  },
			  {
			  type = "invoke-tile-trigger",
			  repeat_count = 1,
			  },
			  {
			  type = "destroy-decoratives",
			  from_render_layer = "decorative",
			  to_render_layer = "object",
			  include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
			  include_decals = false,
			  invoke_decorative_trigger = true,
			  decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
			  radius = 1 -- large radius for demostrative purposes
			  },
			  {
				type = "create-trivial-smoke",
				smoke_name = "artillery-smoke",
				initial_height = 0,
				speed_from_center = 0.1,
				speed_from_center_deviation = 0.005,
				offset_deviation = {{-4, -4}, {4, 4}},
				max_radius = 2.5,
				repeat_count = 2 * 2 * 10
				},
			}
		  }
	  },
	  -- SIMPLE FALLOFF
	  {
		  type = "area",
		  radius = shell_explosive_radius*2,
		  force_condition = "not-same",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
				{
				type = "damage",
				damage = {amount = shell_explosive_explosive/4, type = "explosion"}
				},
				{
				type = "create-trivial-smoke",
				smoke_name = "artillery-smoke",
				initial_height = 0,
				speed_from_center = 0.2,
				speed_from_center_deviation = 0.005,
				offset_deviation = {{-4, -4}, {4, 4}},
				max_radius = 2.5,
				repeat_count = 1 * 2 * 4
				},
			}
		  }
       },
	   {
		  type = "area",
		  radius = (shell_explosive_radius*2)/friendly_fire_radius_reduction_factor,
		  show_in_tooltip = false,
		  force = "same",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
				{
				type = "damage",
				damage = {amount = (shell_explosive_explosive/4) * friendly_fire_modifier, type = "explosion"}
				},
			}
		  }
       },
	   
    },

	
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    }
  },
 

  {
    type = "recipe",
    name = "explosive-shotgun-shell",
    enabled = false,
    energy_required = 12,
    ingredients =
    {
      {type="item", name="shotgun-shell", amount=2},
      {type="item", name="explosives", amount=4}
    },
    results = {{type="item", name="explosive-shotgun-shell", amount=1}},
  },
  
  ----------------------------- DEPLETED SHOTGUN SHELL -----------------------------
   {
    type = "ammo",
    name = "depleted-shotgun-shell",
    icon = "__factorioplus__/graphics/icons/shotgun-shell-depleted.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "shotgun-shell",
    ammo_type =
    {
      category = "shotgun-shell",
      target_type = "direction",
      clamp_position = true,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "uranium-explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = shell_piercing_pellets/2,
          action_delivery =
          {
            type = "projectile",
            projectile = "depleted-shotgun-pellet",
            starting_speed = 1,
            starting_speed_deviation = 0.1,
            direction_deviation = shell_depleted_arc,
            range_deviation = 0.5,
            max_range = shell_range
          }
        },
		 {
          type = "direct",
          repeat_count = shell_piercing_pellets/2,
          action_delivery =
          {
            type = "projectile",
            projectile = "depleted-shotgun-pellet",
            starting_speed = 1,
            starting_speed_deviation = 0.1,
            direction_deviation = shell_depleted_arc/3,
            range_deviation = 0.5,
            max_range = shell_range
          }
        },
      }
    },
    magazine_size = shell_magazinesize,
	reload_time = shell_reloadtime,
    subgroup = "ammo",
    order = "b[shotgun]-c[uranium]",
    stack_size = shell_stacksize,
	weight = 10*kg
  },
  
  {
    type = "projectile",
    name = "depleted-shotgun-pellet",
    flags = {"not-on-map"},
    collision_box = {{-0.05, -0.25}, {0.05, 0.25}},
	hit_collision_mask = shotgun_hit_layers,
    acceleration = 0,
    direction_only = true,
	hit_at_collision_position = true,
	piercing_damage = shell_depleted_piercing,
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
			  damage = {amount = shell_depleted_physical, type = "physical"}
			},
			{
			  type = "damage",
			  damage = {amount = shell_depleted_piercing, type = "piercing"}
			},
		},
      }
    },
	final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    animation =
    {
      filename = "__base__/graphics/entity/piercing-bullet/piercing-bullet.png",
	  tint = {r = 0.4, g = 1, b = 0.4},
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    }
  },
  
  {
    type = "recipe",
    name = "depleted-shotgun-shell",
    enabled = false,
    energy_required = 16,
    ingredients =
    {
      {type="item", name="piercing-shotgun-shell", amount=2},
      {type="item", name="uranium-238", amount=3},
    },
    results = {{type="item", name="depleted-shotgun-shell", amount=2}},
  },
  
   ----------------------------- NUKE SHOTGUN SHELL -----------------------------
  {
    type = "ammo",
    name = "nuke-shotgun-shell",
    icon = "__factorioplus__/graphics/icons/shotgun-shell-nuke.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "shotgun-shell",
    ammo_type =
    {
      category = "shotgun-shell",
      target_type = "direction",
	  cooldown_modifier = shell_nuke_cooldown_modifier,
      clamp_position = true,
	  range_modifier = shell_nuke_range_modifier,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "uranium-explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          repeat_count = shell_nuke_pellets/2,
          action_delivery =
          {
            type = "projectile",
            projectile = "nuke-shotgun-pellet",
            starting_speed = 1,
            starting_speed_deviation = 0.1,
            direction_deviation = shell_nuke_arc,
            range_deviation = 0.6,
            max_range = shell_range * shell_nuke_range_modifier
          }
        },
	    {
          type = "direct",
          repeat_count = shell_nuke_pellets/2,
          action_delivery =
          {
            type = "projectile",
            projectile = "nuke-shotgun-pellet",
            starting_speed = 1,
            starting_speed_deviation = 0.1,
            direction_deviation = shell_nuke_arc/3,
            range_deviation = 0.6,
            max_range = shell_range * shell_nuke_range_modifier
          }
        },
      }
    },
    magazine_size = shell_nuke_magazinesize,
	reload_time = shell_reloadtime,
    subgroup = "ammo",
    order = "b[shotgun]-e[nuke]",
    stack_size = shell_nuke_stacksize,
	weight = 10*kg
  },
  
    {
    type = "projectile",
    name = "nuke-shotgun-pellet",
    flags = {"not-on-map"},
    collision_box = {{-0.05, -0.25}, {0.05, 0.25}},
	hit_collision_mask = shotgun_hit_layers,
    acceleration = 0,
    direction_only = true,
	hit_at_collision_position = true,
    action =
    {
		type = "direct",
		action_delivery =
		{
			type = "instant",
			target_effects =
			{
			  type = "damage",
			  damage = {amount = shell_nuke_physical, type = "physical"}
			},
			{
				type = "create-entity",
				entity_name = "uranium-cannon-shell-explosion"
		    }
		}	  
    },
	
	final_action =
    {
	  {
      type = "direct",
      action_delivery =
		  {
			type = "instant",
			target_effects =
			{
			  {
				type = "create-entity",
				entity_name = "uranium-cannon-shell-explosion"
			  },
			  {
				type = "nested-result",
				action =
				{
				  type = "area",
				  radius = shell_nuke_radius,
				  show_in_tooltip = true,
				  force = "not-same",
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = shell_nuke_explosive, type = "explosion"}
					  },
					  {
						type = "create-entity",
						entity_name = "uranium-cannon-explosion"
					  }
					}
				  }
				}
			  },
			   {
				type = "nested-result",
				action =
				{
				  type = "area",
				  radius = shell_nuke_radius / friendly_fire_radius_reduction_factor,
				  show_in_tooltip = false,
				  force = "same",
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = shell_nuke_explosive * friendly_fire_modifier, type = "explosion"}
					  },
					}
				  }
				}
			  },
			   {
				type = "set-tile",
				tile_name = "nuclear-ground",
				radius = 2,
				apply_projection = true,
				tile_collision_mask = {layers={water_tile=true}},
			  },
			  {
				type = "destroy-cliffs",
				radius = 1,
				explosion = "explosion"
			  },
			  {
				type = "camera-effect",
				effect = "screen-burn",
				duration = 40,
				ease_in_duration = 5,
				ease_out_duration = 40,
				delay = 0,
				strength = 4,
				full_strength_max_distance = 100,
				max_distance = 500
			  },
			  {
				type = "create-entity",
				entity_name = "small-scorchmark-tintable",
				check_buildability = true
			  },
			  {
			  type = "invoke-tile-trigger",
			  repeat_count = 1,
			  },
			  {
			  type = "destroy-decoratives",
			  from_render_layer = "decorative",
			  to_render_layer = "object",
			  include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
			  include_decals = false,
			  invoke_decorative_trigger = true,
			  decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
			  radius = 1 -- large radius for demostrative purposes
			  },
			  {
				type = "create-trivial-smoke",
				smoke_name = "artillery-smoke",
				initial_height = 0,
				speed_from_center = 0.2,
				speed_from_center_deviation = 0.005,
				offset_deviation = {{-4, -4}, {4, 4}},
				max_radius = 5.5,
				repeat_count = 2 * 2 * 15
				},
			}
		  }
	  },
	  -- BASIC FALLOFF
	  {
		  type = "area",
		  radius = shell_nuke_radius*2,
		  show_in_tooltip = true,
		  force_condition = "not-same",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
				{
				type = "damage",
				damage = {amount = shell_nuke_explosive/4, type = "explosion"}
				},
				{
				type = "create-trivial-smoke",
				smoke_name = "artillery-smoke",
				initial_height = 0,
				speed_from_center = 0.2,
				speed_from_center_deviation = 0.005,
				offset_deviation = {{-4, -4}, {4, 4}},
				max_radius = 2.5,
				repeat_count = 1 * 2 * 4
				},
			}
		  }
       },
	   {
		  type = "area",
		  radius = (shell_nuke_radius*2) / friendly_fire_radius_reduction_factor,
		  show_in_tooltip = false,
		  force = "same",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
				{
				type = "damage",
				damage = {amount = (shell_nuke_explosive/4) * friendly_fire_modifier, type = "explosion"}
				},
			}
		  }
       },
    },

	
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    }
  },
 

  {
    type = "recipe",
    name = "nuke-shotgun-shell",
    enabled = false,
    energy_required = 12,
    ingredients =
    {
      {type="item", name="explosive-shotgun-shell", amount=3},
      {type="item", name="explosives", amount=8},
	  {type="item", name="uranium-235", amount=2}
    },
    results = {{type="item", name="nuke-shotgun-shell", amount=2}},
  },
  
   -----------------------------  LASER (UNUSED?) -----------------------------
     -- {
    -- type = "item",
    -- name = "battery",
    -- icon = "__base__/graphics/icons/battery.png",
    -- icon_size = 64, icon_mipmaps = 4,
    -- subgroup = "raw-material",
    -- order = "h[battery]",
    -- stack_size = 200
  -- }
  
  -- WHAT USES THIS ???
  
  {
    type = "projectile",
    name = "laser",
    flags = {"not-on-map"},
    acceleration = 0.03,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "laser-bubble"
          },
          {
            type = "damage",
            damage = { amount = 4, type = "laser"}
          }
        }
      }
    },
    -- light = {intensity = 0.5, size = 10},
    animation =
    {
      filename = "__base__/graphics/entity/laser/laser-to-tint-medium.png",
	  draw_as_glow = true,
      tint = {r=1.0, g=0.0, b=0.0},
      frame_count = 1,
      width = 12,
      height = 33,
      priority = "high",
      blend_mode = "additive"
    }
  },
  
     ----------------------------- BLUE LASER (UNUSED?) -----------------------------
  
  {
    type = "projectile",
    name = "blue-laser",
    flags = {"not-on-map"},
    acceleration = 0.02,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "laser-bubble"
          },
          {
            type = "damage",
            damage = {amount = 8, type = "laser"}
          }
        }
      }
    },
    light = {intensity = 0.5, size = 10},
    animation =
    {
      filename = "__base__/graphics/entity/blue-laser/blue-laser.png",
      frame_count = 1,
      width = 7,
      height = 14,
      priority = "high"
    }
  },
  
  })


  data.extend({ 
  
     ----------------------------- RED LASER BEAM -----------------------------
	 
  {
    type = "beam",
	name = "laser-beam",
    flags = {"not-on-map"},
    width = 0.5,
    damage_interval = laserbeam_red_damage_interval,
    random_target_offset = true,
    action_triggered_automatically = false,
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
            damage = { amount = laserbeam_red_damage, type = "laser"}
          }
        }
      }
    },
	working_sound =
    {
      sound =
      {
        filename = "__base__/sound/fight/laser-beam.ogg",
        volume = 0.75
      },
      max_sounds_per_type = 1
    },
	graphics_set =
    {
      beam =
      {
        head =
        {
          layers =
          {
            {
              filename = "__base__/graphics/entity/laser-turret/laser-body.png",
              flags = beam_non_light_flags,
              line_length = 8,
              width = 64,
              height = 12,
              frame_count = 8,
              scale = 0.5,
              animation_speed = 0.5,
              blend_mode = bullet_trail_blend_mode
            },
            {
              filename = "__base__/graphics/entity/laser-turret/laser-body-light.png",
              draw_as_light = true,
              flags = {"light"},
              line_length = 8,
              width = 64,
              height = 12,
              frame_count = 8,
              scale = 0.5,
              animation_speed = 0.5
            }
          }
        },
        tail =
        {
          layers =
          {
            {
              filename = "__base__/graphics/entity/laser-turret/laser-end.png",
              flags = beam_non_light_flags,
              width = 110,
              height = 62,
              frame_count = 8,
              shift = util.by_pixel(11.5, 1),
              scale = 0.5,
              animation_speed = 0.5,
              blend_mode = bullet_trail_blend_mode
            },
            {
              filename = "__base__/graphics/entity/laser-turret/laser-end-light.png",
              draw_as_light = true,
              flags = {"light"},
              width = 110,
              height = 62,
              frame_count = 8,
              shift = util.by_pixel(11.5, 1),
              scale = 0.5,
              animation_speed = 0.5
            }
          }
        },
        body =
        {
          {
            layers =
            {
              {
                filename = "__base__/graphics/entity/laser-turret/laser-body.png",
                flags = beam_non_light_flags,
                line_length = 8,
                width = 64,
                height = 12,
                frame_count = 8,
                scale = 0.5,
                animation_speed = 0.5,
                blend_mode = bullet_trail_blend_mode
              },
              {
                filename = "__base__/graphics/entity/laser-turret/laser-body-light.png",
                draw_as_light = true,
                flags = {"light"},
                line_length = 8,
                width = 64,
                height = 12,
                frame_count = 8,
                scale = 0.5,
                animation_speed = 0.5
              }
            }
          }
        },
        -- render_layer = "projectile"
      },

      ground =
      {
        head =
        {
          filename = "__base__/graphics/entity/laser-turret/laser-ground-light-head.png",
          draw_as_light = true,
          flags = {"light"},
          line_length = 1,
          width = 256,
          height = 256,
          repeat_count = 8,
          scale = 0.5,
          shift = util.by_pixel(-32, 0),
          animation_speed = 0.5,
          tint = {0.5, 0.05, 0.05}
        },
        tail =
        {
          filename = "__base__/graphics/entity/laser-turret/laser-ground-light-tail.png",
          draw_as_light = true,
          flags = {"light"},
          line_length = 1,
          width = 256,
          height = 256,
          repeat_count = 8,
          scale = 0.5,
          shift = util.by_pixel(32, 0),
          animation_speed = 0.5,
          tint = {0.5, 0.05, 0.05}
        },
        body =
        {
          filename = "__base__/graphics/entity/laser-turret/laser-ground-light-body.png",
          draw_as_light = true,
          flags = {"light"},
          line_length = 1,
          width = 64,
          height = 256,
          repeat_count = 8,
          scale = 0.5,
          animation_speed = 0.5,
          tint = {0.5, 0.05, 0.05}
        }
        -- render_layer = "projectile"
      }
    },

	
    light_animations =
    {
      head =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-body-light.png",
        line_length = 8,
        width = 64,
        height = 12,
        frame_count = 8,
        scale = 0.5,
        animation_speed = 0.5,
      },
      tail =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-end-light.png",
        width = 110,
        height = 62,
        frame_count = 8,
        shift = util.by_pixel(11.5, 1),
        scale = 0.5,
        animation_speed = 0.5,
      },
      body =
      {
        {
          filename = "__base__/graphics/entity/laser-turret/laser-body-light.png",
          line_length = 8,
          width = 64,
          height = 12,
          frame_count = 8,
          scale = 0.5,
          animation_speed = 0.5,
        }
      }
    },

    ground_light_animations =
    {
      head =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-ground-light-head.png",
        line_length = 1,
        width = 256,
        height = 256,
        repeat_count = 8,
        scale = 0.5,
        shift = util.by_pixel(-32, 0),
        animation_speed = 0.5,
        tint = {0.5, 0.05, 0.05}
      },
      tail =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-ground-light-tail.png",
        line_length = 1,
        width = 256,
        height = 256,
        repeat_count = 8,
        scale = 0.5,
        shift = util.by_pixel(32, 0),
        animation_speed = 0.5,
        tint = {0.5, 0.05, 0.05}
      },
      body =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-ground-light-body.png",
        line_length = 1,
        width = 64,
        height = 256,
        repeat_count = 8,
        scale = 0.5,
        animation_speed = 0.5,
        tint = {0.5, 0.05, 0.05}
      }
    }
  },
  
  })


  data.extend({ 
  
     ----------------------------- BIG RED LASER BEAM -----------------------------
	 
  {
    type = "beam",
	name = "large-laser-beam",
    flags = {"not-on-map"},
    width = 0.5,
    damage_interval = laserbeam_red_large_firerate,
    random_target_offset = true,
    action_triggered_automatically = false,
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
            damage = { amount = laserbeam_red_large_damage, type = "laser"}
          }
        }
      }
    },
	working_sound =
    {
      sound =
      {
        filename = "__factorioplus__/sounds/megalaser-1.ogg",
        volume = 1,
		speed = 0.9,
      },
      max_sounds_per_type = 3
    },
	
    graphics_set =
    {
      beam =
      {
        head =
        {
          layers =
          {
            {
              filename = "__base__/graphics/entity/laser-turret/laser-body.png",
              flags = beam_non_light_flags,
              line_length = 8,
              width = 64,
              height = 12,
              frame_count = 8,
              scale = 0.5,
              animation_speed = 0.5,
              blend_mode = bullet_trail_blend_mode
            },
            {
              filename = "__base__/graphics/entity/laser-turret/laser-body-light.png",
              draw_as_light = true,
              flags = {"light"},
              line_length = 8,
              width = 64,
              height = 12,
              frame_count = 8,
              scale = 0.5,
              animation_speed = 0.5
            }
          }
        },
        tail =
        {
          layers =
          {
            {
              filename = "__base__/graphics/entity/laser-turret/laser-end.png",
              flags = beam_non_light_flags,
              width = 110,
              height = 62,
              frame_count = 8,
              shift = util.by_pixel(11.5, 1),
              scale = 0.5,
              animation_speed = 0.5,
              blend_mode = bullet_trail_blend_mode
            },
            {
              filename = "__base__/graphics/entity/laser-turret/laser-end-light.png",
              draw_as_light = true,
              flags = {"light"},
              width = 110,
              height = 62,
              frame_count = 8,
              shift = util.by_pixel(11.5, 1),
              scale = 0.5,
              animation_speed = 0.5
            }
          }
        },
        body =
        {
          {
            layers =
            {
              {
                filename = "__base__/graphics/entity/laser-turret/laser-body.png",
                flags = beam_non_light_flags,
                line_length = 8,
                width = 64,
                height = 12,
                frame_count = 8,
                scale = 0.5,
                animation_speed = 0.5,
                blend_mode = bullet_trail_blend_mode
              },
              {
                filename = "__base__/graphics/entity/laser-turret/laser-body-light.png",
                draw_as_light = true,
                flags = {"light"},
                line_length = 8,
                width = 64,
                height = 12,
                frame_count = 8,
                scale = 0.5,
                animation_speed = 0.5
              }
            }
          }
        },
        -- render_layer = "projectile"
      },

      ground =
      {
        head =
        {
          filename = "__base__/graphics/entity/laser-turret/laser-ground-light-head.png",
          draw_as_light = true,
          flags = {"light"},
          line_length = 1,
          width = 256,
          height = 256,
          repeat_count = 8,
          scale = 0.5,
          shift = util.by_pixel(-32, 0),
          animation_speed = 0.5,
          tint = {0.5, 0.05, 0.05}
        },
        tail =
        {
          filename = "__base__/graphics/entity/laser-turret/laser-ground-light-tail.png",
          draw_as_light = true,
          flags = {"light"},
          line_length = 1,
          width = 256,
          height = 256,
          repeat_count = 8,
          scale = 0.5,
          shift = util.by_pixel(32, 0),
          animation_speed = 0.5,
          tint = {0.5, 0.05, 0.05}
        },
        body =
        {
          filename = "__base__/graphics/entity/laser-turret/laser-ground-light-body.png",
          draw_as_light = true,
          flags = {"light"},
          line_length = 1,
          width = 64,
          height = 256,
          repeat_count = 8,
          scale = 0.5,
          animation_speed = 0.5,
          tint = {0.5, 0.05, 0.05}
        }
        -- render_layer = "projectile"
      }
    },
	
    light_animations =
    {
      head =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-body-light.png",
        line_length = 8,
        width = 64,
        height = 12,
        frame_count = 8,
        scale = 2,
        animation_speed = 0.5,
      },
      tail =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-end-light.png",
        width = 110,
        height = 62,
        frame_count = 8,
        shift = util.by_pixel(11.5, 1),
        scale = 2,
        animation_speed = 0.5,
      },
      body =
      {
        {
          filename = "__base__/graphics/entity/laser-turret/laser-body-light.png",
          line_length = 8,
          width = 64,
          height = 12,
          frame_count = 8,
          scale = 2,
          animation_speed = 0.5,
        }
      }
    },

    ground_light_animations =
    {
      head =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-ground-light-head.png",
        line_length = 1,
        width = 256,
        height = 256,
        repeat_count = 8,
        scale = 2,
        shift = util.by_pixel(-32, 0),
        animation_speed = 0.5,
        tint = {0.5, 0.05, 0.05}
      },
      tail =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-ground-light-tail.png",
        line_length = 1,
        width = 256,
        height = 256,
        repeat_count = 8,
        scale = 2,
        shift = util.by_pixel(32, 0),
        animation_speed = 0.5,
        tint = {0.5, 0.05, 0.05}
      },
      body =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-ground-light-body.png",
        line_length = 1,
        width = 64,
        height = 256,
        repeat_count = 8,
        scale = 2,
        animation_speed = 0.5,
        tint = {0.5, 0.05, 0.05}
      }
    }
  },
  
  
  -----------------------------  MORTAR ROUNDS -----------------------------
{
    type = "ammo",
    name = "grenade-rounds",
    icon = "__factorioplus__/graphics/icons/grenade-rounds.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "grenade-shell",
    ammo_type =
    {
      {
        source_type = "default",
        category = "grenade-shell",
        target_type = "position",
        clamp_position = false,

        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "grenade-arc"
          }
        }
      },
	},
	magazine_size = mortar_magazinesize,
	-- reload_time = mortar_reloadtime,
    subgroup = "ammo",
    order = "c[grenaderounds]-a[basic]",
    stack_size = mortar_stacksize,
	weight = 10*kg
  },
  
   ---- MORTAR PROJECTILE ---
  {
    type = "stream",
    name = "grenade-arc",
    flags = {"not-on-map"},

    smoke_sources =
    {
      {
        name = "soft-fire-smoke",
        frequency = 0.05, --0.25,
        position = {0.0, 0}, -- -0.8},
        starting_frame_deviation = 60
      }
    },

    stream_light = {intensity = 0.1, size = 4 * 0.8},
    ground_light = {intensity = 0.6, size = 4 * 0.8},

    particle_buffer_size = 30,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 1,
    particle_vertical_acceleration = 0.01 * 0.6,
    particle_horizontal_speed = 0.45 * projectile_mortar_turret_speed_modifier,
    particle_horizontal_speed_deviation = 0.0035,
    particle_start_alpha = 1,
    particle_end_alpha = 1,
    particle_start_scale = 0.2,
    particle_loop_frame_count = 3,
    particle_fade_out_threshold = 0.9,
    particle_loop_exit_threshold = 0.25,
	
    initial_action =
    {
	  
      type = "direct",
      action_delivery =
      {
	  
        type = "instant",
        target_effects =
        {	 
		
          {
            type = "nested-result",
            action =
            {
				{
				  type = "area",
				  radius = mortar_regular_damageradius,
				  force = "not-same",
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = mortar_regular_explosivedamage , type = "explosion"}
					  },
					},
				  },
				},
				{
				  type = "area",
				  radius = mortar_regular_damageradius / friendly_fire_radius_reduction_factor,
				  show_in_tooltip = false,
				  force = "same",
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = mortar_regular_explosivedamage * friendly_fire_modifier , type = "explosion"}
					  },
					},
				  },
				},
				
				{
				  type = "area",
				  radius = mortar_regular_damageradius/2,
				  force = "not-same",
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = mortar_hit_physicaldamage , type = "explosion"}
					  },
					},
				  },
				},
				{
				  type = "area",
				  radius = (mortar_regular_damageradius/2) / friendly_fire_radius_reduction_factor,
				  show_in_tooltip = false,
				  force = "same",
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = mortar_hit_physicaldamage * friendly_fire_modifier , type = "explosion"}
					  },
					},
				  },
				},
				
				{
				  type = "area",
				  radius = 1,
				  force = "not-same",
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = mortar_hit_physicaldamage , type = "physical"}
					  },
					},
				  },
				},
				{
				  type = "area",
				  radius = 1 / friendly_fire_radius_reduction_factor,
				  show_in_tooltip = false,
				  force = "same",
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = mortar_hit_physicaldamage * friendly_fire_modifier , type = "physical"}
					  },
					},
				  },
				},
            },
          },
          {
            type = "create-trivial-smoke",
            smoke_name = "artillery-smoke",
            initial_height = 0,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.005,
            offset_deviation = {{-4, -4}, {4, 4}},
            max_radius = 3.5,
            repeat_count = 2 * 2 * 10
          },
          {
            type = "create-entity",
            entity_name = "medium-explosion"
          },
		  {
            type = "create-entity",
            entity_name =  "small-scorchmark-tintable",
			check_buildability = true
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 1,
          },	 
        },
      },

    },

    spine_animation =
    {
      filename = "__factorioplus__/graphics/grenade-round.png",
      --blend_mode = "additive",
      --tint = {r=1, g=1, b=1, a=0.5},
      line_length = 1,
      width = 16,
      height = 16,
      frame_count = 1,
      axially_symmetrical = false,
      direction_count = 1,
      animation_speed = 1,
      scale = 0.4,
      shift = {0, 0}
    },

    shadow =
    {
	  filename = "__base__/graphics/entity/artillery-projectile/shell-shadow.png",
      width = 64,
      height = 64,
      scale = 0.5,
      priority = "high",
    },
  },
  
   {
    type = "recipe",
    name = "grenade-rounds",
    enabled = false,
    energy_required = 8,
    ingredients =
    {
      {type="item", name="grenade", amount=6},
      {type="item", name="plastic-bar", amount=3},
      {type="item", name="steel-plate", amount=1}
    },
    results = {{type="item", name="grenade-rounds", amount=2}},
  },
  
   ----------------------------- NAPALM MORTAR ROUNDS -----------------------------

  {
    type = "projectile",
    name = "napalm_bomblet",
    flags = {"not-on-map"},
    acceleration = -0.00,
    action =
    {
	   {
        type = "area",
        radius = 4,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-sticker",
              sticker = "napalm-fire-sticker",
              show_in_tooltip = true
            },
            {
              type = "damage",
              damage = { amount = 2, type = "fire" },
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
              entity_name = "mortar-ground-fire-flame",
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
  },
  
  --- FIRE
  
{
    type = "ammo",
    name = "mortar-rounds-fire",
    icon = "__factorioplus__/graphics/icons/mortar-rounds-fire.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "grenade-shell",
    ammo_type =
    {
      {
        source_type = "default",
        category = "grenade-shell",
        target_type = "position",
        clamp_position = false,

        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "mortar-rounds-fire-arc"
          }
        }
      },
	},
	magazine_size = mortar_magazinesize,
	-- reload_time = mortar_reloadtime,
    subgroup = "ammo",
    order = "c[grenaderounds]-a[basic]",
    stack_size = mortar_stacksize,
	weight = 10*kg
  },
  
   ---- PROJ ---
  {
    type = "stream",
    name = "mortar-rounds-fire-arc",
    flags = {"not-on-map"},

    smoke_sources =
    {
      {
        name = "soft-fire-smoke",
        frequency = 0.05, --0.25,
        position = {0.0, 0}, -- -0.8},
        starting_frame_deviation = 60
      }
    },

    stream_light = {intensity = 0.1, size = 4 * 0.8},
    ground_light = {intensity = 0.6, size = 4 * 0.8},

    particle_buffer_size = 65,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 1,
    particle_vertical_acceleration = 0.01 * 0.6,
    particle_horizontal_speed = 0.45 * projectile_mortar_turret_speed_modifier,
    particle_horizontal_speed_deviation = 0.0035,
    particle_start_alpha = 1,
    particle_end_alpha = 1,
    particle_start_scale = 0.2,
    particle_loop_frame_count = 3,
    particle_fade_out_threshold = 0.9,
    particle_loop_exit_threshold = 0.25,
	initial_action =
	{
		{
        type = "cluster",
        cluster_count = mortar_napalm_bomblet_count,
        distance = mortar_napalm_bomblet_scatter_radius,
        distance_deviation = mortar_napalm_bomblet_scatter_deviation,
        action_delivery =
        {
          type = "projectile",
          projectile = "napalm_bomblet",
          direction_deviation = 0.6,
          starting_speed = 0.35,
          starting_speed_deviation = 0.3
        }
      }
		
    },

	
    action =
    {
		
      type = "direct",
      action_delivery =
      {
	  
        type = "instant",
        target_effects =
        {	 
		
		
          {
            type = "nested-result",
            action =
            {
              type = "area",
			  force = "not-same",
              radius = mortar_napalm_explosivedamageradius,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                    type = "damage",
                    damage = {amount = mortar_napalm_explosivedamage , type = "explosive"}
                }
              },
			  type = "area",
			  force = "same",
			  show_in_tooltip = false,
              radius = mortar_napalm_explosivedamageradius / friendly_fire_radius_reduction_factor,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                    type = "damage",
                    damage = {amount = mortar_napalm_explosivedamage * friendly_fire_modifier , type = "explosive"}
                }
              },
			  type = "area",
              radius = mortar_napalm_firestickerapplyradius,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
					{
					  type = "create-sticker",
					  sticker = "mortar-fire-sticker",
					  show_in_tooltip = true
					},
                }
              }
            },
          },
          {
            type = "create-trivial-smoke",
            smoke_name = "artillery-smoke",
            initial_height = 0,
            speed_from_center = 0.08,
            speed_from_center_deviation = 0.005,
            offset_deviation = {{-4, -4}, {4, 4}},
            max_radius = 3.5,
            repeat_count = 2 * 2 * 10
          },
          {
            type = "create-entity",
            entity_name = "medium-explosion"
          },
		   {
            type = "create-entity",
            entity_name =  "small-scorchmark-tintable",
			check_buildability = true
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 1,
          },	
		  {
              type = "create-fire",
              entity_name = "mortar-ground-fire-flame",
              show_in_tooltip = true,
              initial_ground_flame_count = 25
           },
        },
      },
    },

    spine_animation =
    {
      filename = "__factorioplus__/graphics/grenade-round.png",
      --blend_mode = "additive",
      --tint = {r=1, g=1, b=1, a=0.5},
      line_length = 1,
      width = 16,
      height = 16,
      frame_count = 1,
      axially_symmetrical = false,
      direction_count = 1,
      animation_speed = 1,
      scale = 0.4,
      shift = {0, 0}
    },

    shadow =
    {
	  filename = "__base__/graphics/entity/artillery-projectile/shell-shadow.png",
      width = 64,
      height = 64,
      scale = 0.25,
      priority = "high",
    },
  },
  
  --- MORTAR FIRE EXPLOSION STICKER
	firestickerutil.makefiresticker("mortar-fire-sticker", mortar_napalm_firestickerapplyradius, mortar_napalm_firedps, mortar_napalm_fireburnsticker_time, 0.75, nil, nil),
  
  
  fireutil.add_basic_fire_graphics_and_effects_definitions
  {
  type = "fire",
  name = "mortar-ground-fire-flame",
  flags = {"placeable-off-grid", "not-on-map"},
  --collision_box = {{-4, -4}, {4, 4}},
  damage_per_tick = {amount = mortar_napalm_firedps / 60, type = "fire"},
  maximum_damage_multiplier = 6,
  damage_multiplier_increase_per_added_fuel = 1,
  damage_multiplier_decrease_per_tick = 0.25 / 60,

  spawn_entity = "fire-flame",

  spread_delay = 100,
  spread_delay_deviation = 80,
  maximum_spread_count = 1000,

  emissions_per_second = { pollution = 0.005 },

  initial_lifetime = mortar_napalm_fireground_time * 60,
  lifetime_increase_by = 150,
  lifetime_increase_cooldown = 4,
  maximum_lifetime = mortar_napalm_fireground_time * 60,
  delay_between_initial_flames = 10,
  limit_overlapping_particles = true,
  
},
  
   {
    type = "recipe",
    name = "mortar-rounds-fire",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
      {type="item", name="grenade-rounds", amount=1},
      {type="item", name="flamethrower-ammo-napalm", amount=2},
    },
    results = {{type="item", name="mortar-rounds-fire", amount=1}},
  },
 
 
 -----------------------------------------------------------------
----------------------------- ROCKETS ----------------------------
------------------------------------------------------------------
 
 ----------------------------- ROCKET ----------------------------
 
 {
    type = "ammo",
    name = "rocket",
    icon = "__base__/graphics/icons/rocket.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "rocket",
    ammo_type =
    {
      category = "rocket",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "rocket",
          starting_speed = rocket_speed_initial,
          source_effects =
          {
            type = "create-entity",
            entity_name = "explosion-hit",
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-a[basic]",
    stack_size = rocket_stacksize,
    weight = 40*kg
  },
  
 {
    type = "projectile",
    name = "rocket",
    flags = {"not-on-map"},
    acceleration = rocket_speed_acceleration,
    turn_speed = 0.003,
    turning_speed_increases_exponentially_with_projectile_speed = true,
    action =
    {
	  {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "grenade-explosion",
            only_when_visible = true
          },
          {
            type = "damage",
			force = "same",
			show_in_tooltip = false,
            damage = {amount = rocket_damage_physical * friendly_fire_modifier, type = "physical"}
          },
		 {
            type = "damage",
			force = "not-same",
            damage = {amount = rocket_damage_physical, type = "physical"}
          },
		  {
			type = "create-trivial-smoke",
			smoke_name = "artillery-smoke",
			initial_height = 0,
			speed_from_center = 0.05,
			speed_from_center_deviation = 0.005,
			offset_deviation = {{-4, -4}, {4, 4}},
			max_radius = 2.5,
			repeat_count = 2 * 4 * 8
			},
		  {
			type = "create-trivial-smoke",
			smoke_name = "artillery-smoke",
			initial_height = 0,
			speed_from_center = 0.2,
			speed_from_center_deviation = 0.01,
			offset_deviation = {{-4, -4}, {4, 4}},
			max_radius = 4.5,
			repeat_count = 2 * 4 * 8
			},
          {
            type = "create-entity",
            entity_name = "small-scorchmark-tintable",
            check_buildability = true
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 1,
          },
          {
            type = "destroy-decoratives",
            from_render_layer = "decorative",
            to_render_layer = "object",
            include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
            include_decals = false,
            invoke_decorative_trigger = true,
            decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
            radius = 1.5 -- large radius for demostrative purposes
          },
		  {
            type = "nested-result",
            action =
            {
				{
				  type = "area",
				  radius = rocket_radius,
				  force = "not-same",
				  --show_in_tooltip = false
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = rocket_damage_explosive, type = "explosion"}
					  },
					  {
						type = "create-entity",
						entity_name = "explosion"
					  }
					}
				  },
			  },
			  {
				  type = "area",
				  radius = rocket_radius / friendly_fire_radius_reduction_factor,
				  force = "same",
				  show_in_tooltip = false,
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = rocket_damage_explosive * friendly_fire_modifier, type = "explosion"}
					  },
					  {
						type = "create-entity",
						entity_name = "explosion"
					  }
					}
				  },
			  },
            },
		  }
        }
      }
	  },
	  {
		  type = "area",
		  radius = rocket_radius*2,
		  force = "not-same",
		  --show_in_tooltip = false
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
				{
				type = "damage",
				damage = {amount = rocket_damage_explosive/4, type = "explosion"}
				},
				{
				type = "create-trivial-smoke",
				smoke_name = "artillery-smoke",
				initial_height = 0,
				speed_from_center = 0.2,
				speed_from_center_deviation = 0.005,
				offset_deviation = {{-4, -4}, {4, 4}},
				max_radius = 2.5,
				repeat_count = 1 * 2 * 4
				},
			}
		  }
       },
	   {
		  type = "area",
		  radius = (rocket_radius*2) / friendly_fire_radius_reduction_factor,
		  force = "same",
		  show_in_tooltip = false,
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
				{
				type = "damage",
				damage = {amount = (rocket_damage_explosive/4) * friendly_fire_modifier, type = "explosion"}
				},
			}
		  }
       },
    },
    light = {intensity = 0.5, size = 4},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({1, 0.8, 0.3}),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
  },
  
  {
    type = "recipe",
    name = "rocket",
    enabled = false,
    energy_required = 8,
    ingredients =
    {
      --{type="item", name="electronic-circuit", amount=1},
      {type="item", name="explosives", amount=4},
      {type="item", name="iron-plate", amount=2}
    },
    results = {{type="item", name="rocket", amount=1}},
  },
  
   ----------------------------- MICRO ROCKET ----------------------------
 
 {
    type = "ammo",
    name = "rocket-micro",
    icon = "__factorioplus__/graphics/icons/rocket-micro-missile.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "rocket",
    ammo_type =
    {
      category = "rocket",
	  cooldown_modifier = rocket_micro_cooldown_modifier,
      action =
      {
        type = "direct",
		repeat_count = 1,
        action_delivery =
        {
          type = "projectile",
          projectile = "rocket-micro",
          starting_speed = rocket_micro_speed_initial,
		  direction_deviation = 0.05,
          source_effects =
          {
            type = "create-entity",
            entity_name = "explosion-hit",
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-c[basic]",
    stack_size = rocket_micro_stacksize,
    weight = 40*kg
  },
  
 {
    type = "projectile",
    name = "rocket-micro",
    flags = {"not-on-map"},
    acceleration = rocket_micro_speed_acceleration,
    turn_speed = 0.006,
    turning_speed_increases_exponentially_with_projectile_speed = true,
    action =
    {
		{
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "explosion"
          },
          {
            type = "damage",
            damage = {amount = rocket_micro_damage_physical, type = "physical"}
          },
          {
            type = "create-entity",
            entity_name = "small-scorchmark-tintable",
            check_buildability = true
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 1,
          },
          {
            type = "destroy-decoratives",
            from_render_layer = "decorative",
            to_render_layer = "object",
            include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
            include_decals = false,
            invoke_decorative_trigger = true,
            decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
            radius = 1 -- large radius for demostrative purposes
          },
		  {
            type = "nested-result",
            action =
            {
			 {
				  type = "area",
				   force = "not-same",
				  radius = rocket_micro_radius,
				  
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = rocket_micro_damage_explosive, type = "explosion"}
					  },
					  {
						type = "create-entity",
						entity_name = "explosion"
					  }
					}
				  },
			  },
			  {
				  type = "area",
				  radius = rocket_micro_radius,
				  show_in_tooltip = false,
				  force = "same",
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = rocket_micro_damage_explosive * friendly_fire_modifier, type = "explosion"}
					  },
					  {
						type = "create-entity",
						entity_name = "explosion"
					  }
					}
				  },
			  },
            },
		  }
        }
		}
	  },
	  {
		  type = "area",
		  radius = rocket_micro_radius*2,
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
				{
				type = "damage",
				damage = {amount = rocket_micro_damage_explosive/4, type = "explosion"}
				},
				{
				type = "create-trivial-smoke",
				smoke_name = "artillery-smoke",
				initial_height = 0,
				speed_from_center = 0.2,
				speed_from_center_deviation = 0.005,
				offset_deviation = {{-4, -4}, {4, 4}},
				max_radius = 2.5,
				repeat_count = 1 * 2 * 4
				},
			}
		  }
       },
    },
    light = {intensity = 0.2, size = 2},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({0.1, 0.3, 0.9}),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
  },
  
  {
    type = "recipe",
    name = "rocket-micro",
    enabled = false,
    energy_required = 14,
    ingredients =
    {
      {type="item", name="rocket", amount=4},
      {type="item", name="low-density-structure", amount=4}
    },
    results = {{type="item", name="rocket-micro", amount=25}},
  },
  
   ----------------------------- EXPLOSIVE ROCKET ----------------------------
   {
    type = "ammo",
    name = "explosive-rocket",
    icon = "__base__/graphics/icons/explosive-rocket.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "rocket",
    ammo_type =
    {
      category = "rocket",
	  cooldown_modifier = rocket_explosive_cooldown_modifier,
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "explosive-rocket",
          starting_speed = rocket_explosive_speed_initial,
          source_effects =
          {
            type = "create-entity",
            entity_name = "explosion-hit"
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-b[explosive]",
    stack_size = rocket_explosive_stacksize,
    weight = 40*kg
  },
  
  {
    type = "projectile",
    name = "explosive-rocket",
    flags = {"not-on-map"},
    acceleration = rocket_explosive_speed_acceleration,
    turn_speed = 0.003,
    turning_speed_increases_exponentially_with_projectile_speed = true,
	
    final_action =
    {
		{
		  type = "direct",
		  action_delivery =
		  {
			type = "instant",
			show_in_tooltip = false,
			target_effects =
			make_explosion_wave_target_effects("rocket-explosive",rocket_explosive_damage_explosive,rocket_explosive_radius),
		  },
	  },
    },
	
    light = {intensity = 0.5, size = 4},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({1, 0.2, 0.2}),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
  },
  
  {
    type = "recipe",
    name = "explosive-rocket",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {type="item", name="rocket", amount=1},
      {type="item", name="explosives", amount=14}
    },
    results = {{type="item", name="explosive-rocket", amount=1}},
  },
  
  
 ----------------------------- POISON ROCKET ----------------------------
 
 {
    type = "ammo",
    name = "rocket-poison",
    icon = "__factorioplus__/graphics/icons/poison-rocket.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "rocket",
    ammo_type =
    {
      category = "rocket",
	  range_modifier = rocket_utility_range_modifier,
	  cooldown_modifier = rocket_utility_cooldown_modifier,
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "rocket-poison",
          starting_speed = rocket_speed_initial,
          source_effects =
          {
            type = "create-entity",
            entity_name = "explosion-hit",
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-a[basic]",
    stack_size = rocket_utility_stacksize,
    weight = 40*kg
  },
  
 {
    type = "projectile",
    name = "rocket-poison",
    flags = {"not-on-map"},
    acceleration = rocket_speed_acceleration,
    turn_speed = 0.003,
    turning_speed_increases_exponentially_with_projectile_speed = true,
    action =
    {
	  {
      type = "direct",
      action_delivery =
		  {
			type = "instant",
			target_effects =
			{
			  {
				type = "create-entity",
				entity_name = "grenade-explosion"
			  },
			  {
				type = "damage",
				force = "same",
				show_in_tooltip = false,
				damage = {amount = rocket_damage_physical * friendly_fire_modifier, type = "physical"}
			  },
			 {
				type = "damage",
				force = "not-same",
				damage = {amount = rocket_damage_physical, type = "physical"}
			  },
			  {
				type = "create-entity",
				entity_name = "small-scorchmark-tintable",
				check_buildability = true
			  },
			  {
				type = "invoke-tile-trigger",
				repeat_count = 1,
			  },
			  {
				type = "destroy-decoratives",
				from_render_layer = "decorative",
				to_render_layer = "object",
				include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
				include_decals = false,
				invoke_decorative_trigger = true,
				decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
				radius = 1.5 -- large radius for demostrative purposes
			  },
			   {
                  type = "create-smoke",
                  show_in_tooltip = true,
                  entity_name = "poison-cloud-large",
                  initial_height = 0
				},
				{
				  type = "create-particle",
				  particle_name = "poison-capsule-metal-particle",
				  repeat_count = 8,
				  initial_height = 1,
				  initial_vertical_speed = 0.1,
				  initial_vertical_speed_deviation = 0.05,
				  offset_deviation = {{-0.1, -0.1}, {0.1, 0.1}},
				  speed_from_center = 0.05,
				  speed_from_center_deviation = 0.01
				}
			}
		  }
	  },
    },
    light = {intensity = 0.5, size = 4},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({1, 0.8, 0.3}),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
  },
  
  {
    type = "recipe",
    name = "rocket-poison",
    enabled = false,
    energy_required = 16,
    ingredients =
    {
      --{type="item", name="electronic-circuit", amount=1},
      {type="item", name="rocket", amount=1},
      {type="item", name="poison-capsule", amount=2}
    },
    results = {{type="item", name="rocket-poison", amount=1}},
  },
  
   ----------------------------- POISON ROCKET ----------------------------
 
 {
    type = "ammo",
    name = "rocket-slowdown",
    icon =  "__factorioplus__/graphics/icons/slowdown-rocket.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "rocket",
	
    ammo_type =
    {
	  range_modifier = rocket_utility_range_modifier,
	  cooldown_modifier = rocket_utility_cooldown_modifier,
      category = "rocket",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "rocket-slowdown",
          starting_speed = rocket_speed_initial,
          source_effects =
          {
            type = "create-entity",
            entity_name = "explosion-hit",
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-a[basic]",
    stack_size = rocket_utility_stacksize,
    weight = 30*kg
  },
  
 {
    type = "projectile",
    name = "rocket-slowdown",
    flags = {"not-on-map"},
    acceleration = rocket_speed_acceleration,
    turn_speed = 0.003,
    turning_speed_increases_exponentially_with_projectile_speed = true,
    action =
    {
	   {
				type = "area",
				radius = 15,
				force = "enemy",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
						type = "create-sticker",
						sticker = "slowdown-sticker"
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
				type = "create-entity",
				entity_name = "grenade-explosion"
			  },
			  {
				type = "damage",
				force = "same",
				show_in_tooltip = false,
				damage = {amount = rocket_damage_physical * friendly_fire_modifier, type = "physical"}
			  },
			 {
				type = "damage",
				force = "not-same",
				damage = {amount = rocket_damage_physical, type = "physical"}
			  },
			  {
				type = "create-entity",
				entity_name = "small-scorchmark-tintable",
				check_buildability = true
			  },
			  {
				type = "invoke-tile-trigger",
				repeat_count = 1,
			  },
			  {
				type = "destroy-decoratives",
				from_render_layer = "decorative",
				to_render_layer = "object",
				include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
				include_decals = false,
				invoke_decorative_trigger = true,
				decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
				radius = 1.5 -- large radius for demostrative purposes
			  },
			   {
              type = "create-entity",
              entity_name = "slowdown-capsule-explosion"
              },
			
			}
		  }
	  },
    },
    light = {intensity = 0.5, size = 4},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({1, 0.8, 0.3}),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
  },
  
  {
    type = "recipe",
    name = "rocket-slowdown",
    enabled = false,
    energy_required = 16,
    ingredients =
    {
      --{type="item", name="electronic-circuit", amount=1},
      {type="item", name="rocket", amount=1},
      {type="item", name="slowdown-capsule", amount=2}
    },
    results = {{type="item", name="rocket-slowdown", amount=1}},
  },
  ----------------------------- NUKE ROCKET ----------------------------
  
  {
    type = "ammo",
    name = "atomic-bomb",
    icon = "__base__/graphics/icons/atomic-bomb.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "rocket",
    ammo_type =
    {
      range_modifier = rocket_nuke_range_modifier,
	  cooldown_modifier = rocket_nuke_cooldown_modifier,
      target_type = "position",
      category = "rocket",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "atomic-rocket",
          starting_speed = 0.05,
          source_effects =
          {
            type = "create-entity",
            entity_name = "explosion-hit"
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-c[atomic-bomb]",
    stack_size = rocket_nuke_stacksize,
    weight = 1.5 * tons
  },
  
  {
    type = "projectile",
    name = "atomic-rocket",
    flags = {"not-on-map"},
    acceleration = 0.005,
    turn_speed = 0.003,
    turning_speed_increases_exponentially_with_projectile_speed = true,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "set-tile",
            tile_name = "nuclear-ground",
            radius = 12,
            apply_projection = true,
            tile_collision_mask = {layers={water_tile=true}},
          },
          {
            type = "destroy-cliffs",
            radius = 9,
            explosion = "explosion"
          },
          {
            type = "create-entity",
            entity_name = "nuke-explosion"
          },
          {
            type = "camera-effect",
            effect = "screen-burn",
            duration = 60,
            ease_in_duration = 5,
            ease_out_duration = 60,
            delay = 0,
            strength = 6,
            full_strength_max_distance = 200,
            max_distance = 800
          },
          {
            type = "play-sound",
            sound = sounds.nuclear_explosion(0.9),
            play_on_target_position = false,
            -- min_distance = 200,
            max_distance = 1000,
            -- volume_modifier = 1,
            audible_distance_modifier = 3
          },
          {
            type = "play-sound",
            sound = sounds.nuclear_explosion_aftershock(0.4),
            play_on_target_position = false,
            -- min_distance = 200,
            max_distance = 1000,
            -- volume_modifier = 1,
            audible_distance_modifier = 3
          },
          {
            type = "damage",
            damage = {amount = rocket_nuke_damage_explosive, type = "explosion"}
          },
          {
            type = "create-entity",
            entity_name = "huge-scorchmark",
            check_buildability = true,
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 1,
          },
          {
            type = "destroy-decoratives",
            include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
            include_decals = true,
            invoke_decorative_trigger = true,
            decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
            radius = 14 -- large radius for demostrative purposes
          },
          {
            type = "create-decorative",
            decorative = "nuclear-ground-patch",
            spawn_min_radius = 11.5,
            spawn_max_radius = 12.5,
            spawn_min = 30,
            spawn_max = 40,
            apply_projection = true,
            spread_evenly = true
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 1000,
              radius = 7,
              action_delivery =
              {
                type = "projectile",
                projectile = "atomic-bomb-ground-zero-projectile",
                starting_speed = 0.6 * 0.8,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 1000,
              radius = 35,
              action_delivery =
              {
                type = "projectile",
                projectile = "atomic-bomb-wave",
                starting_speed = 0.5 * 0.7,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 1000,
              radius = 26,
              action_delivery =
              {
                type = "projectile",
                projectile = "atomic-bomb-wave-spawns-cluster-nuke-explosion",
                starting_speed = 0.5 * 0.7,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 700,
              radius = 4,
              action_delivery =
              {
                type = "projectile",
                projectile = "atomic-bomb-wave-spawns-fire-smoke-explosion",
                starting_speed = 0.5 * 0.65,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 1000,
              radius = 8,
              action_delivery =
              {
                type = "projectile",
                projectile = "atomic-bomb-wave-spawns-nuke-shockwave-explosion",
                starting_speed = 0.5 * 0.65,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 300,
              radius = 26,
              action_delivery =
              {
                type = "projectile",
                projectile = "atomic-bomb-wave-spawns-nuclear-smoke",
                starting_speed = 0.5 * 0.65,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 10,
              radius = 8,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "create-entity",
                    entity_name = "nuclear-smouldering-smoke-source",
                    tile_collision_mask = {layers={water_tile=true}},
                  }
                }
              }
            }
          }
        }
      }
    },
    light = {intensity = 0.8, size = 15},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({0.0, 0.9, 0.1}),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
  },
  
  {
    type = "recipe",
    name = "atomic-bomb",
    enabled = false,
    energy_required = 50,
    ingredients =
    {
      {type="item", name="processing-unit", amount=10},
      {type="item", name="explosive-rocket", amount=1},
      {type="item", name="uranium-235", amount=30}
    },
    results = {{type="item", name="atomic-bomb", amount=1}},
  },
  
-------------------------------------------------------------------------
-----------------------------  CANNON SHELLS ----------------------------
-------------------------------------------------------------------------

-----------------------------  CANNON SHELL ----------------------------

-------- AMMO --------
{
    type = "ammo",
    name = "cannon-shell",
    icon = "__factorioplus__/graphics/icons/cannon-shell.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "cannon-shell",
    ammo_type =
    {
      category = "cannon-shell",
	  
	  clamp_position = true,
      target_type = "position",
	  
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "cannon-projectile",
          starting_speed = 1 * cannon_shell_projectile_speed_modifier,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = cannon_shell_range,
          min_range = 5,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[cannon-shell]-a[basic]",
    stack_size = cannon_shell_stacksize,
    weight = 20*kg
  },
  
-------- PROJ --------  

  {
    type = "projectile",
    name = "cannon-projectile",
    flags = {"not-on-map"},
    collision_box = {{-0.6, -1.6}, {0.6, 1.6}},
    acceleration = 0,
    piercing_damage = cannon_shell_damage_penetration,
	-- hit_collision_mask
	force_condition = "not-same",
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
            damage = {amount = cannon_shell_damage_physical, type = "physical"}
          },
          {
            type = "create-entity",
            entity_name = "explosion"
          }
        }
      }
    },
	
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "grenade-explosion"
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = cannon_shell_radius,
			  show_in_tooltip = true,
			  force = "not-same",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = cannon_shell_damage_explosive, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion"
                  }
                }
              }
            }
          },
		  {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = cannon_shell_radius/friendly_fire_radius_reduction_factor,
			  show_in_tooltip = false,
			  force = "same",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = cannon_shell_damage_explosive * friendly_fire_modifier, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion"
                  }
                }
              }
            }
          },
		  
          {
            type = "create-entity",
            entity_name = "medium-scorchmark-tintable",
            check_buildability = true
          },
          {
          type = "invoke-tile-trigger",
          repeat_count = 1,
          },
          {
          type = "destroy-decoratives",
          from_render_layer = "decorative",
          to_render_layer = "object",
          include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
          include_decals = false,
          invoke_decorative_trigger = true,
          decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
          radius = 2 -- large radius for demostrative purposes
          },
		  {
            type = "create-trivial-smoke",
            smoke_name = "artillery-smoke",
            initial_height = 0,
            speed_from_center = 0.1,
            speed_from_center_deviation = 0.005,
            offset_deviation = {{-2, -2}, {2, 2}},
            max_radius =4.5,
            repeat_count = 2 * 2 * 20
          },
        }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
	  scale = 2.5,
      priority = "high"
    }
  },
-------- RECIPE --------    
  {
    type = "recipe",
    name = "cannon-shell",
  enabled = false,
  energy_required = 8,
  ingredients =
  {
	{type="item", name="steel-plate", amount=6},
	{type="item", name="plastic-bar", amount=4},
	{type="item", name="explosives", amount=2}
  },
  results = {{type="item", name="cannon-shell", amount=1}},
  },
  
----------------------------- EXPLOSIVE CANNON SHELL ----------------------------  
  {
    type = "ammo",
    name = "explosive-cannon-shell",
    icon = "__factorioplus__/graphics/icons/cannon-shell-explosive.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "cannon-shell",
    ammo_type =
    {
      category = "cannon-shell",
	  
      clamp_position = true,
      target_type = "position",
	  
	  cooldown_modifier = cannon_shell_explosive_cooldown_modifier,
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "explosive-cannon-projectile",
          starting_speed = 1 * cannon_shell_explosive_projectile_speed_modifier,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = cannon_shell_range,
          min_range = 5,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[cannon-shell]-d[explosive]",
    stack_size = cannon_shell_explosive_stacksize,
    weight = 20*kg
  },
  
})



  data.extend({ 
  -------- PROJ -------- 
   
  {
    type = "projectile",
    name = "explosive-cannon-projectile",
    flags = {"not-on-map"},
    collision_box = {{-0.6, -1.6}, {0.6, 1.6}},
    acceleration = 0,
    piercing_damage = cannon_shell_explosive_damage_penetration,
    -- hit_collision_mask
	force_condition = "not-same",
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
            damage = {amount = cannon_shell_explosive_damage_physical, type = "physical"}
          },
          {
            type = "create-entity",
            entity_name = "explosion"
          },
        }
      }
    },
	
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
		make_explosion_wave_target_effects("cannon-explosive",cannon_shell_explosive_damage_explosive,cannon_shell_explosive_radius),
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
	  scale = 4.0,
      priority = "high"
    }
  },
  
  -------- RECIPE -------- 
  
  {
    type = "recipe",
    name = "explosive-cannon-shell",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
	  {type="item", name="cannon-shell", amount=1},
	  {type="item", name="explosives", amount=18}
    },
    results = {{type="item", name="explosive-cannon-shell", amount=1}},
  },
 
----------------------------- PIERCING CANNON SHELL ----------------------------  
  {
    type = "ammo",
    name = "piercing-cannon-shell",
    icon = "__factorioplus__/graphics/icons/cannon-shell-piercing.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "cannon-shell",
    ammo_type =
    {
      category = "cannon-shell",
	  
      clamp_position = true,
      target_type = "position",
	  
	  cooldown_modifier = cannon_shell_piercing_cooldown_modifier,
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "piercing-cannon-projectile",
          starting_speed = 1 * cannon_shell_piercing_projectile_speed_modifier,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = cannon_shell_range,
          min_range = 5,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[cannon-shell]-b[explosive]",
    stack_size = cannon_shell_stacksize,
    weight = 20*kg
  },
  
  {
    type = "projectile",
    name = "piercing-cannon-projectile",
    flags = {"not-on-map"},
    collision_box = {{-0.6, -1.6}, {0.6, 1.6}},
    acceleration = 0,
    piercing_damage = cannon_shell_piercing_damage_penetration,
	-- hit_collision_mask
	force_condition = "not-same",
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
            damage = {amount = cannon_shell_piercing_damage_physical, type = "physical"}
          },
		  {
            type = "damage",
            damage = {amount = cannon_shell_piercing_damage_piercing, type = "piercing"}
          },
          {
            type = "create-entity",
            entity_name = "explosion"
          }
        }
      }
    },
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "explosion"
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = cannon_shell_piercing_radius,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = cannon_shell_piercing_damage_explosive, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion"
                  }
                }
              }
            }
          },
          {
            type = "create-entity",
            entity_name = "medium-scorchmark-tintable",
            check_buildability = true
          },
          {
          type = "invoke-tile-trigger",
          repeat_count = 1,
          },
          {
          type = "destroy-decoratives",
          from_render_layer = "decorative",
          to_render_layer = "object",
          include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
          include_decals = false,
          invoke_decorative_trigger = true,
          decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
          radius = 2 -- large radius for demostrative purposes
          },
		   {
            type = "create-trivial-smoke",
            smoke_name = "artillery-smoke",
            initial_height = 0,
            speed_from_center = 0.12,
            speed_from_center_deviation = 0.005,
            offset_deviation = {{-2, -2}, {2, 2}},
            max_radius = 4.5,
            repeat_count = 2 * 2 * 10
          },
        }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
	  scale = 3.0,
      priority = "high"
    }
  },
  
  {
    type = "recipe",
    name = "piercing-cannon-shell",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
	  {type="item", name="cannon-shell", amount=1},
	  {type="item", name="steel-plate", amount=6},
	  {type="item", name="copper-plate", amount=14}
    },
    results = {{type="item", name="piercing-cannon-shell", amount=1}},
  },
  
----------------------------- DEPLETED UR CANNON SHELL ----------------------------  
  
  {
    type = "ammo",
    name = "uranium-cannon-shell",
    icon = "__factorioplus__/graphics/icons/cannon-shell-depleted.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "cannon-shell",
    ammo_type =
    {
      category = "cannon-shell",
	  
      clamp_position = true,
      target_type = "position",
	  
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "uranium-cannon-projectile",
          starting_speed = 1 * cannon_shell_depleted_projectile_speed_modifier,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = cannon_shell_range,
          min_range = 5,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[cannon-shell]-c[uranium]",
    stack_size = cannon_shell_stacksize,
    weight = 20*kg
  },
  
  {
    type = "projectile",
    name = "uranium-cannon-projectile",
    flags = {"not-on-map"},
    collision_box = {{-0.6, -1.6}, {0.6, 1.6}},
    acceleration = 0,
    piercing_damage = cannon_shell_depleted_damage_penetration,
	force_condition = "not-same",
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
            damage = {amount = cannon_shell_depleted_damage_physical , type = "physical"}
          },
          {
            type = "damage",
            damage = {amount = cannon_shell_depleted_damage_piercing , type = "piercing"}
          },
          {
            type = "create-entity",
            entity_name = "uranium-cannon-explosion"
          }
        }
      }
    },
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "small-scorchmark-tintable",
            check_buildability = true
          }
        }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
	  tint = {r = 0.4, g = 1, b = 0.4},
      frame_count = 1,
      width = 3,
      height = 50,
	  scale = 4.0,
      priority = "high"
    }
  },
  
   {
    type = "recipe",
    name = "uranium-cannon-shell",
    enabled = false,
    energy_required = 16,
    ingredients =
    {
      {type="item", name="piercing-cannon-shell", amount=1},
      {type="item", name="uranium-238", amount=2}
    },
    results = {{type="item", name="uranium-cannon-shell", amount=1}},
  },
 
----------------------------- NUKE CANNON SHELL ----------------------------    
 
  {
    type = "ammo",
    name = "explosive-uranium-cannon-shell",
    icon = "__factorioplus__/graphics/icons/cannon-shell-nuke.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "cannon-shell",
    ammo_type =
    {
      category = "cannon-shell",
	  
      clamp_position = true,
      target_type = "position",
	  
	  cooldown_modifier = cannon_shell_nuke_explosive_cooldown_modifier,
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "nuke-uranium-cannon-projectile",
          starting_speed = 1 * cannon_shell_nuke_projectile_speed_modifier ,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = cannon_shell_range,
          min_range = 10,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[explosive-cannon-shell]-e[uranium]",
    stack_size = cannon_shell_explosive_stacksize,
    weight = 100*kg
  },
  
  {
    type = "projectile",
    name = "nuke-uranium-cannon-projectile",
    flags = {"not-on-map"},
    collision_box = {{-0.6, -1.6}, {0.6, 1.6}},
    acceleration = 0,
    piercing_damage = cannon_shell_nuke_explosive_damage_penetration,
	-- hit_collision_mask
	force_condition = "not-same",
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
            damage = {amount = cannon_shell_nuke_explosive_damage_penetration , type = "piercing"}
          },
        }
      }
    },
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "set-tile",
            tile_name = "nuclear-ground",
            radius = 3,
            apply_projection = true,
            tile_collision_mask = {layers={water_tile=true}},
          },
          {
            type = "destroy-cliffs",
            radius = 3,
            explosion = "explosion"
          },
          {
            type = "create-entity",
            entity_name = "cannon-nuke-explosion"
          },
          {
            type = "camera-effect",
            effect = "screen-burn",
            duration = 60,
            ease_in_duration = 5,
            ease_out_duration = 30,
            delay = 0,
            strength = 4,
            full_strength_max_distance = 100,
            max_distance = 600
          },
          {
            type = "play-sound",
            sound = sounds.nuclear_explosion(0.9),
            play_on_target_position = false,
            -- min_distance = 200,
            max_distance = 500,
            -- volume_modifier = 1,
            audible_distance_modifier = 3
          },
          {
            type = "play-sound",
            sound = sounds.nuclear_explosion_aftershock(0.4),
            play_on_target_position = false,
            -- min_distance = 200,
            max_distance = 400,
            -- volume_modifier = 1,
            audible_distance_modifier = 3
          },
          {
            type = "damage",
            damage = {amount = cannon_shell_nuke_explosive_damage_explosive, type = "explosion"}
          },
          {
            type = "create-entity",
            entity_name = "huge-scorchmark",
            check_buildability = true,
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 8,
          },
          {
            type = "destroy-decoratives",
            include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
            include_decals = true,
            invoke_decorative_trigger = true,
            decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
            radius = 14/2 -- large radius for demostrative purposes
          },
          {
            type = "create-decorative",
            decorative = "nuclear-ground-patch",
            spawn_min_radius = 11.5/2,
            spawn_max_radius = 12.5/2,
            spawn_min = 30/2,
            spawn_max = 40/2,
            apply_projection = true,
            spread_evenly = true
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 1000/2,
              radius = cannon_shell_nuke_explosive_radius,
              action_delivery =
              {
                type = "projectile",
                projectile = "atomic-bomb-ground-zero-projectile",
                starting_speed = 0.6 * 0.8/2,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 1000/2,
              radius = 35/2,
              action_delivery =
              {
                type = "projectile",
                projectile = "cannon-nuke-wave",
                starting_speed = 0.5 * 0.7/2,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 1000/2,
              radius = 26/2,
              action_delivery =
              {
                type = "projectile",
                projectile = "cannon-nuke-wave-spawns-cluster-nuke-explosion",
                starting_speed = 0.5 * 0.7/2,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 700/2,
              radius = 4/2,
              action_delivery =
              {
                type = "projectile",
                projectile = "cannon-nuke-wave-spawns-fire-smoke-explosion",
                starting_speed = 0.5 * 0.65/2,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 1000/2,
              radius = 8/2,
              action_delivery =
              {
                type = "projectile",
                projectile = "cannon-nuke-wave-spawns-nuke-shockwave-explosion",
                starting_speed = 0.5 * 0.65/2,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 300/2,
              radius = 26/2,
              action_delivery =
              {
                type = "projectile",
                projectile = "cannon-nuke-wave-spawns-nuclear-smoke",
                starting_speed = 0.5 * 0.65/2,
                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
              }
            }
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 10/2,
              radius = 8/2,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "create-entity",
                    entity_name = "cannon-nuke-smouldering-smoke-source",
                    tile_collision_mask = {layers={water_tile=true}},
                  }
                }
              }
            }
          }
        }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
	  tint = {r = 0.2, g = 1, b = 0.2},
      frame_count = 1,
      width = 3,
      height = 50,
	  scale = 5.0,
      priority = "high"
    }
  },
  
  
   {
    type = "recipe",
    name = "explosive-uranium-cannon-shell",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {type="item", name="explosive-cannon-shell", amount=1},
      {type="item", name="uranium-235", amount=12}
    },
    results = {{type="item", name="explosive-uranium-cannon-shell", amount=1}},
  },
  
  
  ----------------------------- AUTO CANNON SHELL ---------------------------- 
  
  {
    type = "ammo",
    name = "cannon-shell-auto",
    icon = "__factorioplus__/graphics/icons/cannon-shell-auto.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "cannon-shell",
    ammo_type =
    {
      category = "cannon-shell",
	  
	  clamp_position = true,
      target_type = "position",
	  
	  cooldown_modifier = cannon_shell_auto_cooldown_modifier,
	  
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "cannon-auto-projectile",
          starting_speed = 1 * cannon_shell_auto_projectile_speed_modifier,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = cannon_shell_range,
          min_range = 5,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          }
        }
      }
    },
    subgroup = "ammo",
    order = "d[cannon-shell]-a[basic]",
    stack_size = cannon_shell_stacksize * cannon_shell_auto_stacksize_multiplier,
    weight = 10*kg
  },
  
-------- PROJ --------  

  {
    type = "projectile",
    name = "cannon-auto-projectile",
    flags = {"not-on-map"},
    collision_box = {{-0.4, -1.2}, {0.4, 1.2}},
    acceleration = 0,
    piercing_damage = cannon_shell_auto_damage_penetration,
	force_condition = "not-same",
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
            damage = {amount = cannon_shell_auto_damage_physical, type = "physical"}
          },
          {
            type = "create-entity",
            entity_name = "explosion"
          }
        }
      }
    },
	
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "explosion"
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = cannon_shell_auto_radius,
			  show_in_tooltip = true,
			  force = "not-same",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = cannon_shell_auto_damage_explosive, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion"
                  }
                }
              }
            }
          },
		  {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = cannon_shell_auto_radius/friendly_fire_radius_reduction_factor,
			  show_in_tooltip = false,
			  force = "same",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = cannon_shell_auto_damage_explosive * friendly_fire_modifier, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion"
                  }
                }
              }
            }
          },
		  
          {
            type = "create-entity",
            entity_name = "small-scorchmark-tintable",
            check_buildability = true
          },
          {
			  type = "invoke-tile-trigger",
			  repeat_count = 1,
          },
          {
			  type = "destroy-decoratives",
			  from_render_layer = "decorative",
			  to_render_layer = "object",
			  include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
			  include_decals = false,
			  invoke_decorative_trigger = true,
			  decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
			  radius = 1 -- large radius for demostrative purposes
          },
		  {
            type = "create-trivial-smoke",
            smoke_name = "artillery-smoke",
            initial_height = 0,
            speed_from_center = 0.1,
            speed_from_center_deviation = 0.005,
            offset_deviation = {{-2, -2}, {2, 2}},
            max_radius = 1.5,
            repeat_count = 2 * 2 * 5
          },
        }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
	  scale = 1.5,
      priority = "high"
    }
  },
-------- RECIPE --------    
  
  {
    type = "recipe",
    name = "cannon-shell-auto",
    enabled = false,
    energy_required = 6,
    ingredients =
  {
	{type="item", name="cannon-shell", amount=2},
	{type="item", name="low-density-structure", amount=4},
  },
  results = {{type="item", name="cannon-shell-auto", amount=5}},
  },
  
  
  -----------------------------  PLASMA AMMO -----------------------------
  
   {
    type = "ammo",
    name = "plasma-cell",
    icon = "__factorioplus__/graphics/icons/railgun-ammo.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "plasma-cell",
    ammo_type =
    {
      category = "plasma-cell",
	  target_type = "direction",
	  clamp_position = true,
      action =
      {
	  
		{
          type = "direct",
          repeat_count = plasmagun_innercone_projectile_count/2,
          action_delivery =
          {
            type = "projectile",
            projectile = "plasma-ball-huge",
            starting_speed = speed_plasmagun * 1.4,
            starting_speed_deviation = 0.1,
            direction_deviation = spread_plasmagun/6,
            range_deviation = 0.15,
            max_range = range_plasmagun
          },
		},
		{
          type = "direct",
          repeat_count = plasmagun_innercone_projectile_count,
          action_delivery =
          {
            type = "projectile",
            projectile = "plasma-ball-large",
            starting_speed = speed_plasmagun * 1.2,
            starting_speed_deviation = 0.2,
            direction_deviation = spread_plasmagun/3,
			range_deviation = 0.25,
            max_range = range_plasmagun
          }
        },
		{
          type = "direct",
          repeat_count = plasmagun_outercone_projectile_count,
          action_delivery =
          {
            type = "projectile",
            projectile = "plasma-ball-small",
            starting_speed = speed_plasmagun * 1,
            starting_speed_deviation = 0.4,
            direction_deviation = spread_plasmagun,
            range_deviation = 0.45,
            max_range = range_plasmagun
          }
        }
		

      },
	  
    },
	reload_time = plasmagun_reloadtime,
    magazine_size = plasmagun_magazinesize,
    subgroup = "ammo",
    order = "c[railgun]",
    stack_size = plasmagun_stacksize,
    weight = 20*kg
  },
  
    {
    type = "projectile",
    name = "plasma-ball-huge",
    flags = {"not-on-map"},
    collision_box = {{-2, -2}, {2, 2}},
	hit_at_collision_position = true,
    acceleration = acc_plasmagun/1.5,
    direction_only = true,
    action =
    {
		{
		type = "direct",
		force = "not-same",
		action_delivery =
			{
				{
				type = "instant",
				target_effects =
					{
						{
						type = "damage",
						
						damage = {amount = plasma_damage_electric * 2, type = "electric"}
						},
						{
						type = "create-sticker",
						sticker =  "plasma-slow-sticker"
						},
						{
						type = "push-back",
						distance = plasmagun_pushback * 2
						},			
					},
				},
			},
		},
    },
	
	final_action = 
	{
		{
		type = "direct",
		action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
					},
					{
					type = "create-entity",
					entity_name = "small-scorchmark-tintable",
					check_buildability = true
					},
					{
					type = "play-sound",
					sound =  
						{
						filename = "__base__/sound/fight/pulse.ogg",
						volume = 0.95,
						speed = 0.5,
						play_on_target_position = true,
						max_distance = 400,
						audible_distance_modifier = 3
						},
					},
					{
						type = "create-trivial-smoke",
						smoke_name = "artillery-smoke",
						initial_height = 0,
						speed_from_center = 0.1,
						speed_from_center_deviation = 0.005,
						offset_deviation = {{-4, -4}, {4, 4}},
						max_radius = 3.5,
						repeat_count = 6 * 2 * 3
					},
				},
			},
		},
		{
            type = "area",
			trigger_from_target = true,
            radius = 12,
            force = "not-same",
            action_delivery =
            {
				{
				type = "instant",
				target_effects =
					{
						{
						type = "create-sticker",
						sticker =  "plasma-slow-sticker"
						},
						{
						type = "push-back",
						distance = 0.1
						},	
					},
				},
				{
				   type = "beam",
				   beam = "plasma-zap-beam",
				   max_length = 12,
				   duration = 55,
				   source_offset = {0, -0.5},
				   add_to_shooter = true
				},
            },
         },
		 {
            type = "area",
			trigger_from_target = true,
            radius = 8,
            force = "not-same",
            action_delivery =
            {
				{
				type = "instant",
				target_effects =
					{
						{
						type = "create-sticker",
						sticker =  "plasma-slow-sticker"
						},
						{
						type = "push-back",
						distance = 0.25
						},	
					},
				},
				{
				   type = "beam",
				   beam = "plasma-zap-beam",
				   max_length = 8,
				   duration =145,
				   source_offset = {0, -0.5},
				   add_to_shooter = true
				},
            },
         },
	},
		
	light = {intensity = 1.0, size = 15, color={r=0.55, g=0.9 , b=0.95}},
	
    animation =
    {
	 filename = "__factorioplus__/graphics/plasma-ball.png",
      frame_count = 4,
      width = 64,
      height = 64,
	  scale = 1.0,
      priority = "high",
	  draw_as_glow = true,
    },
},
  
  {
    type = "projectile",
    name = "plasma-ball-large",
    flags = {"not-on-map"},
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
	hit_at_collision_position = true,
    acceleration = acc_plasmagun/1.25,
    direction_only = true,
    action =
    {
		{
		type = "direct",
		force = "not-same",
		action_delivery =
			{
				{
				type = "instant",
				target_effects =
					{
						{
						type = "damage",
						
						damage = {amount = plasma_damage_electric * 1, type = "electric"}
						},
						{
						type = "create-sticker",
						sticker =  "plasma-slow-sticker"
						},
						{
						type = "push-back",
						distance = plasmagun_pushback * 1
						},			
					},
				},
			},
		},
    },
	
	final_action = 
	{
		{
		type = "direct",
		action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
					},
					{
					type = "create-entity",
					entity_name = "small-scorchmark-tintable",
					check_buildability = true
					},
					{
					type = "play-sound",
					sound =  
						{
						filename = "__base__/sound/fight/pulse.ogg",
						volume = 0.85,
						speed = 1,
						play_on_target_position = true,
						max_distance = 400,
						audible_distance_modifier = 3
						},
					},
					{
						type = "create-trivial-smoke",
						smoke_name = "artillery-smoke",
						initial_height = 0,
						speed_from_center = 0.1,
						speed_from_center_deviation = 0.005,
						offset_deviation = {{-4, -4}, {4, 4}},
						max_radius = 3.5,
						repeat_count = 4 * 2 * 3
					},
				},
			},
		},
		{
            type = "area",
			trigger_from_target = true,
            radius = 8,
            force = "not-same",
            action_delivery =
            {
				{
				type = "instant",
				target_effects =
					{
						{
						type = "create-sticker",
						sticker =  "plasma-slow-sticker"
						},
						{
						type = "push-back",
						distance = 0.1
						},	
					},
				},
				{
				   type = "beam",
				   beam = "plasma-zap-beam",
				   max_length = 8,
				   duration = 55,
				   source_offset = {0, -0.5},
				   add_to_shooter = true
				},
            },
         },
		 {
            type = "area",
			trigger_from_target = true,
            radius = 4,
            force = "not-same",
            action_delivery =
            {
				{
				type = "instant",
				target_effects =
					{
						{
						type = "create-sticker",
						sticker =  "plasma-slow-sticker"
						},
						{
						type = "push-back",
						distance = 0.25
						},	
					},
				},
				{
				   type = "beam",
				   beam = "plasma-zap-beam",
				   max_length = 4,
				   duration =145,
				   source_offset = {0, -0.5},
				   add_to_shooter = true
				},
            },
         },
	},
		
	light = {intensity = 1.0, size = 10, color={r=0.45, g=0.8 , b=0.9}},
	
    animation =
    {
	 filename = "__factorioplus__/graphics/plasma-ball.png",
      frame_count = 4,
      width = 64,
      height = 64,
	  scale = 0.7,
      priority = "high",
	  draw_as_glow = true,
    },
},

{
    type = "projectile",
    name = "plasma-ball-small",
    flags = {"not-on-map"},
    collision_box = {{-0.55, -0.55}, {0.55, 0.55}},
	hit_at_collision_position = true,
    acceleration = acc_plasmagun,
    direction_only = true,
    action =
    {
		{
		type = "direct",
		force = "not-same",
		action_delivery =
			{
				{
				type = "instant",
				target_effects =
					{
						{
						type = "damage",
						
						damage = {amount = plasma_damage_electric/2, type = "electric"}
						},
						{
						type = "create-sticker",
						sticker =  "plasma-slow-sticker"
						},
						{
						type = "push-back",
						distance = plasmagun_pushback/2
						},			
					},
				},
			},
		},
    },
	
	final_action = 
	{
		{
		type = "direct",
		action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
					},
					{
					type = "create-entity",
					entity_name = "small-scorchmark-tintable",
					check_buildability = true
					},
					{
					type = "play-sound",
					sound =  
						{
						filename = "__base__/sound/fight/pulse.ogg",
						volume = 0.25,
						speed = 1.25,
						play_on_target_position = true,
						max_distance = 400,
						audible_distance_modifier = 3
						},
					},
					{
						type = "create-trivial-smoke",
						smoke_name = "artillery-smoke",
						initial_height = 0,
						speed_from_center = 0.1,
						speed_from_center_deviation = 0.005,
						offset_deviation = {{-4, -4}, {4, 4}},
						max_radius = 1.5,
						repeat_count = 2 * 2 * 3
					},
				},
			},
		},
		{
            type = "area",
			trigger_from_target = true,
            radius = 4,
            force = "not-same",
            action_delivery =
            {
				{
				type = "instant",
				target_effects =
					{
						{
						type = "create-sticker",
						sticker =  "plasma-slow-sticker"
						},
						{
						type = "push-back",
						distance = 0.1
						},	
					},
				},
				{
				   type = "beam",
				   beam = "plasma-zap-beam",
				   max_length = 4,
				   duration = 55,
				   source_offset = {0, -0.5},
				   add_to_shooter = true
				},
            },
         },
		 {
            type = "area",
			trigger_from_target = true,
            radius = 2,
            force = "not-same",
            action_delivery =
            {
				{
				type = "instant",
				target_effects =
					{
						{
						type = "create-sticker",
						sticker =  "plasma-slow-sticker"
						},
						{
						type = "push-back",
						distance = 0.25
						},	
					},
				},
				{
				   type = "beam",
				   beam = "plasma-zap-beam",
				   max_length = 2,
				   duration =145,
				   source_offset = {0, -0.5},
				   add_to_shooter = true
				},
            },
         },
	},
		
	light = {intensity = 0.5, size = 4, color={r=0.25, g=0.7 , b=0.9}},
	
    animation =
    {
	 filename = "__factorioplus__/graphics/plasma-ball.png",
      frame_count = 4,
      width = 64,
      height = 64,
	  scale = 0.40,
      priority = "high",
	  draw_as_glow = true,
    },
},

})
  
local plasmazapbeam = make_electric_beam("electric-beam", false, 0)
plasmazapbeam.name = "plasma-zap-beam"
plasmazapbeam.action.action_delivery.target_effects[1].damage = { amount = plasma_zap_damage_electric, type = "electric"}

data:extend({
 
 plasmazapbeam,

 {
    type = "sticker",
    name = "plasma-slow-sticker",
    flags = {},
    duration_in_ticks = plasma_stun_duration,
    target_movement_modifier = plasma_stun_movement_modifier
  },

  {
    type = "recipe",
    name = "plasma-cell",
    energy_required = 14,
	enabled = false,
    ingredients =
    {
      {type="item", name="battery", amount=6},
	  {type="item", name="electronic-circuit", amount=2},
	  {type="item", name="aluminium-plate", amount=2},
    },
    results = {{type="item", name="plasma-cell", amount=1}},
  },
   -----------------------------  FLAMETHOWER -----------------------------
  {
    type = "ammo",
    name = "flamethrower-ammo",
    icon = "__base__/graphics/icons/flamethrower-ammo.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "flamethrower",
    ammo_type =
    {
      {
        source_type = "default",
        category = "flamethrower",
        target_type = "position",
        clamp_position = true,

        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "handheld-flamethrower-fire-stream"
          }
        }
      },
      {
        source_type = "vehicle",
        consumption_modifier = 1.125,
        category = "flamethrower",
        target_type = "position",
        clamp_position = true,

        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "handheld-flamethrower-fire-stream"
          }
        }
      }
    },
	-- reload_time = 60 * 2,
    magazine_size = 200,
    subgroup = "ammo",
    order = "e[flamethrower]",
    stack_size = 50,
    weight = 20*kg
  },
  
  
 
  
  ----------------------------- CHAINGUN BULLET -----------------------------
{
    type = "ammo",
    name = "chaingun-ammo",
    icon = "__factorioplus__/graphics/icons/mini-gun-ammo.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "beltfed-bullet",
    ammo_type =
    {
      category = "beltfed-bullet",
	  clamp_position = true,
      target_type = "position",
      action =
      {
        {
          type = "direct",
          action_delivery =
          {			
			  type = "instant",
			  source_effects =
			  {
				{
				  type = "create-explosion",
				  entity_name = "explosion-gunshot"
				}
			  }
			
          }
        },
		{
          type = "direct",
          repeat_count = beltfed_regular_pellets,
          action_delivery =
          {
            type = "projectile",
            projectile = "chaingun-bullet",
            starting_speed = 1.2,
            starting_speed_deviation = 0.0,
            direction_deviation = 0.24,
            range_deviation = 0.4,
            max_range = beltfed_projectile_maxrange
          }
        }
      },
	  
    },
	reload_time = beltfed_reloadtime,
    magazine_size = beltfed_magazinesize,
    subgroup = "ammo",
    order = "b[basic-clips]-a[firearm-magazine]",
    stack_size = beltfed_stacksize,
    weight = 40*kg
  },
  
   {
    type = "projectile",
    name = "chaingun-bullet",
    flags = {"not-on-map"},
    collision_box = {{-0.1, -0.25}, {0.1, 0.25}},
	-- hit_collision_mask = {layers={object=true}, not_colliding_with_itself=true},
	-- collision_mask = {layers={object=true}, not_colliding_with_itself=true},
	hit_at_collision_position = true,
	-- force_condition = "all",
    acceleration = -0.0025,
    direction_only = true,
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
			  damage = {amount = beltfed_regular_physical, type = "physical"}
			},
			{
			  type = "damage",
			  damage = {amount = beltfed_regular_piercing, type = "piercing"}
			},
		},
      }
    },
	final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    animation =
    {
	 filename = "__base__/graphics/entity/bullet/bullet.png",
      --filename = "__factorioplus__/graphics/chaingun-bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
	  scale = 1.6,
      priority = "high"
    }
},
   {
    type = "recipe",
    name = "chaingun-ammo",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {type="item", name="firearm-magazine", amount=50},
      {type="item", name="aluminium-plate", amount=10},
      {type="item", name="copper-plate", amount=10}
    },
    results = {{type="item", name="chaingun-ammo", amount=1}},
  },
  
   ----------------------------- CHAINGUN BULLET PIERCING -----------------------------
{
    type = "ammo",
    name = "chaingun-ammo-piercing",
    icon = "__factorioplus__/graphics/icons/mini-gun-ammo-piercing.png",
    icon_size = 64, icon_mipmaps = 4,
	ammo_category = "beltfed-bullet",
    ammo_type =
    {
      category = "beltfed-bullet",
	  clamp_position = true,
      target_type = "position",
      action =
      {
        {
          type = "direct",
          action_delivery =
          {			
			  type = "instant",
			  source_effects =
			  {
				{
				  type = "create-explosion",
				  entity_name = "explosion-gunshot"
				}
			  }
			
          }
        },
		{
          type = "direct",
          repeat_count = beltfed_piercing_pellets,
          action_delivery =
          {
            type = "projectile",
            projectile = "chaingun-bullet-piercing",
            starting_speed = 1.4,
            starting_speed_deviation = 0.0,
            direction_deviation = 0.2,
            range_deviation = 0.4,
            max_range = beltfed_projectile_maxrange
          }
        }
      },
	  
    },
	reload_time = beltfed_reloadtime,
    magazine_size = beltfed_magazinesize,
    subgroup = "ammo",
    order = "b[basic-clips]-a[firearm-magazine]",
    stack_size = beltfed_stacksize,
    weight = 40*kg
  },
  
   {
    type = "projectile",
    name = "chaingun-bullet-piercing",
    flags = {"not-on-map"},
    collision_box = {{-0.1, -0.25}, {0.1, 0.25}},
	hit_at_collision_position = true,
    acceleration = -0.0020,
    direction_only = true,
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
			  damage = {amount = beltfed_piercing_physical, type = "physical"}
			},
			{
			  type = "damage",
			  damage = {amount = beltfed_piercing_piercing, type = "piercing"}
			},
		},
      }
    },
	final_action = 
	  {
		  {
			  type = "direct",
			  action_delivery =
			  {
				type = "instant",
				target_effects =
				{
				  {
					type = "create-entity",
					entity_name = "gunshot-hit-puff-light"
				  },
				},
			  },
		  },
		},
    animation =
    {
	 filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
	  scale = 2.0,
      priority = "high"
    }
},
   {
    type = "recipe",
    name = "chaingun-ammo-piercing",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {type="item", name="chaingun-ammo", amount=1},
      {type="item", name="piercing-rounds-magazine", amount=50},
    },
    results = {{type="item", name="chaingun-ammo-piercing", amount=1}},
  },
----------------------------- ARTILLERY SHELL -----------------------------
{
    type = "artillery-projectile",
    name = "artillery-projectile",
    flags = {"not-on-map"},
    reveal_map = true,
    map_color = {r=1, g=1, b=0},
    picture =
    {
      filename = "__base__/graphics/entity/artillery-projectile/shell.png",
      width = 64,
      height = 64,
      scale = 0.5
    },
    shadow =
    {
      filename = "__base__/graphics/entity/artillery-projectile/shell-shadow.png",
      width = 64,
      height = 64,
      scale = 0.5
    },
    chart_picture =
    {
      filename = "__base__/graphics/entity/artillery-projectile/artillery-shoot-map-visualization.png",
      flags = { "icon" },
      frame_count = 1,
      width = 64,
      height = 64,
      priority = "high",
      scale = 0.25
    },
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = artillery_shell_radius,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = artillery_shell_damage_physical , type = "physical"}
                  },
                  {
                    type = "damage",
                    damage = {amount = artillery_shell_damage_explosion , type = "explosion"}
                  }
                }
              }
            }
          },
          {
            type = "create-trivial-smoke",
            smoke_name = "artillery-smoke",
            initial_height = 0,
            speed_from_center = 0.05,
            speed_from_center_deviation = 0.005,
            offset_deviation = {{-4, -4}, {4, 4}},
            max_radius = artillery_shell_radius,
            repeat_count = 4 * 4 * 15
          },
          {
            type = "create-entity",
            entity_name = "big-artillery-explosion"
          },
          {
            type = "show-explosion-on-chart",
            scale = 8/32
          }
        }
      }
    },
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "medium-scorchmark-tintable",
            check_buildability = true
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 1,
          },
          {
          type = "destroy-decoratives",
          from_render_layer = "decorative",
          to_render_layer = "object",
          include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
          include_decals = false,
          invoke_decorative_trigger = true,
          decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
          radius = artillery_shell_radius -- large radius for demostrative purposes
          }
        }
      }
    },
    height_from_ground = 280 / 64
  },
  
  ----------------------------- GUNSHOT HITS -----------------------------
  
    {
    type = "explosion",
    name = "gunshot-hit-puff-light",
    localised_name = {"entity-name.explosion-hit"},
    flags = {"not-on-map"},
    subgroup = "explosions",
    animations = explosion_animations.hit_explosion(),
    light = {intensity = 0.2, size = 5, color = {r=1.0, g=1.0, b=1.0}},
    smoke = "smoke-fast",
    smoke_count = 2,
    smoke_slow_down_factor = 1
  },
 })
 
 	make_electric_beam("electric-beam", true, laserbeam_electric_damage)