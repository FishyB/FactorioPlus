local sounds = require("__base__.prototypes.entity.sounds")
local soundsnew = require("sounds")
require ("__factorioplus__.util-attack-helpers")
require ("__factorioplus__.util-fire-stickers")
require("stats")

function sound_variations_speed_modifier(filename_string, variations, volume_parameter, speed_modifiers, modifiers_parameter)
  local result = {}
  for i = 1,variations do
    result[i] = { filename = filename_string .. "-" .. i .. ".ogg", volume = volume_parameter or 0.5, speed = speed_modifiers}
     if modifiers_parameter then
      result[i].modifiers = modifiers_parameter
    end
 end
  return result
end


function string.capitalize(str)
    if str=="" then return end
    local first = str:sub(1,1)
    local last = str:sub(2)
    return first:upper()..last:lower()
end

function util.item_icon_rarity_border(i, t)
local lt = t or {r=1, g=1, b=1, a=1}
  local icons =
  {
    {
      icon = i,
      icon_size = 64, icon_mipmaps = 4,
    },
    {
      icon = "__factorioplus__/graphics/icons/rarity-overlay.png",
      icon_size = 64,
      icon_mipmaps = 3,
	  tint = lt,
    },
  }
  return icons
end

-- Rarity includes _name_ of rarity, the _color_ used and the _scale_ of the stats increase (range, firerate, damage)
local rarities = 
{
	uncommon = {name = "uncommon", color = {12,255,70,0.7}, scale = 1.2 }, -- green
	rare = {name = "rare", color = {50,100,255,0.7}, scale = 1.4 }, -- blue
	epic = {name = "epic", color = {255,14,158,0.7}, scale = 1.7 }, -- purple
	legendary = {name = "legendary", color = {255,170,8,0.7}, scale = 2.1 }, -- orange/yellow
}

function createnewrareweapon(weapon, rarity)
	local r = rarities[rarity]
	local nw = table.deepcopy(data.raw["gun"][weapon]) 
	local dm = nw.attack_parameters.damage_modifier or 1.0
	local acm = nw.attack_parameters.ammo_consumption_modifier or 1.0
	local range_reduction = 1/4
	nw.localised_name = { "" , string.capitalize(r.name) , " " , {"item-name." .. nw.name} }
	nw.name = nw.name .. "-" .. r.name
	nw.icons = util.item_icon_rarity_border(nw.icon , r.color)
	nw.icon = nil
	nw.hidden = true
	nw.attack_parameters.cooldown = nw.attack_parameters.cooldown / r.scale 
	nw.attack_parameters.range = math.ceil( nw.attack_parameters.range * (1+((r.scale-1)*range_reduction)) )
	nw.attack_parameters.damage_modifier = dm * r.scale
	nw.attack_parameters.ammo_consumption_modifier = acm / r.scale
	return nw
end

	----- WEAPON CATEGORY -----

local rocketlauncher_ammo_categories = {"rocket"}
 
data:extend({
  -----------------------------  PISTOL  -----------------------------
 {
    type = "gun",
    name = "pistol",
    icon = "__base__/graphics/icons/pistol.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "a[basic-clips]-a[pistol]",
    attack_parameters =
	{
      type = "projectile",
      ammo_category = "bullet",
      cooldown = firerate_pistol,
      movement_slow_down_factor = movement_slow_down_factor_pistol,
	  ammo_consumption_modifier = ammo_consumption_modifier_pistol,
      shell_particle =
	  
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0.1},
        creation_distance = -0.5,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.125,
      range = range_pistol,
      sound = sounds.light_gunshot,
	  damage_modifier = damage_modifier_pistol,
    },
    stack_size = 15
  },
  

})



data:extend({

createnewrareweapon("pistol", "uncommon"),
createnewrareweapon("pistol", "rare"),
createnewrareweapon("pistol", "epic"),
createnewrareweapon("pistol", "legendary"),

})

data:extend({  
  -----------------------------  MAGNUM  -----------------------------
 {
    type = "gun",
    name = "magnum",
    icon = "__factorioplus__/graphics/icons/magnum.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "a[basic-clips]-b[pistol]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = firerate_magnum,
      movement_slow_down_factor = movement_slow_down_factor_magnum,
      shell_particle =
	  
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0.1},
        creation_distance = -0.5,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.125,
      range = range_magnum,
      sound = 
	  {
		  {
			filename = "__base__/sound/fight/tank-cannon-1.ogg",
			volume = 0.7,
			speed = 1.7
		  },
		  {
			filename = "__base__/sound/fight/tank-cannon-2.ogg",
			volume = 0.7,
			speed = 1.7
		  },
		  {
			filename = "__base__/sound/fight/tank-cannon-3.ogg",
			volume = 0.7,
			speed = 1.7
		  },
		  {
			filename = "__base__/sound/fight/tank-cannon-4.ogg",
			volume = 0.7,
			speed = 1.7
		  },
		  {
			filename = "__base__/sound/fight/tank-cannon-5.ogg",
			volume = 0.7,
			speed = 1.7
		  }
	  },
	  damage_modifier = damage_modifier_magnum,
	  ammo_consumption_modifier = ammo_consumption_modifier_magnum,
    },
    stack_size = 10
  },
  
})
  
    -----------------------------  MACHINE GUN  -----------------------------
data:extend({
createnewrareweapon("magnum", "uncommon"),
createnewrareweapon("magnum", "rare"),
createnewrareweapon("magnum", "epic"),
createnewrareweapon("magnum", "legendary"),
})

  -----------------------------  MACHINE GUN  -----------------------------
data:extend({
   {
    type = "gun",
    name = "submachine-gun",
    icon = "__base__/graphics/icons/submachine-gun.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "a[basic-clips]-b[submachine-gun]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = firerate_smg,
      movement_slow_down_factor = movement_slow_down_factor_smg,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0.1},
        creation_distance = -0.5,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.125,
      range = range_smg,
      sound = sounds.submachine_gunshot
	  
    },
    stack_size = 5
  },
})

-- OVERRIDE SMG RECIPE
-- Cheaper

data.raw["recipe"]["submachine-gun"].ingredients =
{
  {type = "item", name = "iron-gear-wheel", amount = 4},
  {type = "item", name = "copper-plate", amount = 4},
  {type = "item", name = "iron-plate", amount = 8}
}
 
data:extend({
createnewrareweapon("submachine-gun", "uncommon"),
createnewrareweapon("submachine-gun", "rare"),
createnewrareweapon("submachine-gun", "epic"),
createnewrareweapon("submachine-gun", "legendary"),
})

  -----------------------------  MACHINE PISTOL GUN -----------------------------
data:extend({
   {
    type = "gun",
    name = "uzi-gun",
    icon = "__factorioplus__/graphics/icons/uzi.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "a[basic-clips]-ba[uzi-gun]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = firerate_uzi,
	  ammo_consumption_modifier = ammo_consumption_modifier_uzi,
	  damage_modifier = damage_modifier_uzi,
      movement_slow_down_factor = movement_slow_down_factor_uzi,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0.1},
        creation_distance = -0.5,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.125,
      range = range_uzi,
      sound = soundsnew.gun_uzi
	  
    },
    stack_size = 5
  },
})
 
data:extend({
createnewrareweapon("uzi-gun", "uncommon"),
createnewrareweapon("uzi-gun", "rare"),
createnewrareweapon("uzi-gun", "epic"),
createnewrareweapon("uzi-gun", "legendary"),
})

data:extend({
-----------------------------  CAR HORN GUN  -----------------------------
 
  {
    type = "ammo-category",
    name = "car-horn",
	hidden = true
  },

 {
    type = "gun",
    name = "vehicle-horn-small",
    icon = "__base__/graphics/icons/signal/signal-alarm.png",
    icon_size = 64, icon_mipmaps = 4,
    hidden = true,
    -- subgroup = "utility",
    order = "a[basic-clips]-b[vehicle-machine-gun]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "car-horn",
      cooldown = 60 ,
      range = 1,
      sound = soundsnew.car_horn,
	  use_shooter_direction = true,
	  
	  ammo_type =
      {
        source_type = "default",
        category = "car-horn",
        target_type = "position",
        clamp_position = true,
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
    stack_size = 1
  },
-----------------------------  CAR MACHINE GUN  -----------------------------
   {
    type = "gun",
    name = "vehicle-machine-gun",
    icon = "__base__/graphics/icons/submachine-gun.png",
    icon_size = 64, icon_mipmaps = 4,
    hidden = true,
    subgroup = "gun",
    order = "a[basic-clips]-b[vehicle-machine-gun]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = firerate_smg / attack_speed_vehicle_bonus ,
	  damage_modifier = damage_modifier_vehicle_bonus,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0},
        creation_distance = -0.6875,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 0.65,
      range = math.ceil(range_smg * range_modifier_vehicle_bonus) ,
      sound = soundsnew.gun_turret_gunshot_light
    },
    stack_size = 1
  },
  
   {
    type = "gun",
    name = "twin-smg",
    icon = "__base__/graphics/icons/submachine-gun.png",
    icon_size = 64, icon_mipmaps = 4,
    hidden = true,
    subgroup = "gun",
    order = "a[basic-clips]-b[vehicle-machine-gun]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = firerate_turret_heavysmg / attack_speed_vehicle_bonus,
	  damage_modifier = damagemodifier_turret_heavysmg * damage_modifier_vehicle_bonus,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0},
        creation_distance = -0.6875,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
	  projectile_creation_distance = 1.2,
      projectile_center = {0, -0.1275}, -- same as gun_turret_attack shift
	  projectile_creation_offsets = {{-0.25,0 },{0.25,0 }}, 
      range = math.ceil(range_turret_heavysmg * range_modifier_vehicle_bonus) ,
      sound = soundsnew.gun_turret_gunshot_heavy,
    },
    stack_size = 1
  },
   -----------------------------  TANK MACHINE GUN  -----------------------------
  -- {
    -- type = "gun",
    -- name = "tank-machine-gun",
    -- icon = "__base__/graphics/icons/submachine-gun.png",
    -- icon_size = 64, icon_mipmaps = 4,
    -- hidden = true,
    -- subgroup = "gun",
    -- order = "a[basic-clips]-b[tank-machine-gun]",
    -- attack_parameters =
    -- {
      -- type = "projectile",
      -- ammo_category = "bullet",
      -- cooldown = firerate_smg,
      -- shell_particle =
      -- {
        -- name = "shell-particle",
        -- direction_deviation = 0.1,
        -- speed = 0.1,
        -- speed_deviation = 0.03,
        -- center = {0, 0},
        -- creation_distance = -0.6875,
        -- starting_frame_speed = 0.4,
        -- starting_frame_speed_deviation = 0.1
      -- },
      -- projectile_center = {-0.15625, -0.07812},
      -- projectile_creation_distance = 1,
      -- range = range_turret_smg,
      -- sound = sounds.heavy_gunshot
    -- },
    -- stack_size = 1
  -- },
  -----------------------------  SHOTGUN  -----------------------------
  {
    type = "gun",
    name = "shotgun",
    icon = "__base__/graphics/icons/shotgun.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "b[shotgun]-a[basic]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "shotgun-shell",
      cooldown = firerate_shotgun,
	  damage_modifier = shotgun_damage_modifier,
	  movement_slow_down_cooldown = firerate_shotgun/4,
      movement_slow_down_factor = movement_slow_down_factor_shotgun,
      projectile_creation_distance = 1.125,
      range = range_shotgun,
      min_range = 1,
      sound = sounds.shotgun
    },
    stack_size = 5
  },
  
    ----------------------------- VEHICLE SHOTGUN -----------------------------
  {
    type = "gun",
    name = "shotgun-veh",
    icon = "__base__/graphics/icons/shotgun.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "b[shotgun]-a[basic]",
	hidden = true,
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "shotgun-shell",
      cooldown = firerate_shotgun / attack_speed_vehicle_bonus,
	  damage_modifier = shotgun_damage_modifier * damage_modifier_vehicle_bonus,
      projectile_creation_distance = 1.125,
      range = range_shotgun * range_modifier_vehicle_bonus,
      min_range = 1,
      sound = sounds.shotgun
    },
    stack_size = 5
  },
    -----------------------------  BLUNDERBUSS  -----------------------------
  {
    type = "gun",
    name = "blunderbuss",
    icon = "__factorioplus__/graphics/icons/blunderbuss.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "b[shotgun]-a[basic]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "shotgun-shell",
      cooldown = firerate_blunderbuss,
	  ammo_consumption_modifier = ammo_consumption_rate_blunderbuss,
	  damage_modifier = damage_modifier_blunderbuss,
	  movement_slow_down_cooldown = movement_slow_down_cooldown_blunderbuss ,
      movement_slow_down_factor = movement_slow_down_factor_blunderbuss,
      projectile_creation_distance = 1.125,
      range = range_shotgun,
      min_range = 1,
      sound = soundsnew.gun_blunderbuss
    },
    stack_size = 5
  },
   -----------------------------  COMBAT SHOTGUN  -----------------------------
  {
    type = "gun",
    name = "combat-shotgun",
    icon = "__base__/graphics/icons/combat-shotgun.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "b[shotgun]-a[combat]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "shotgun-shell",
      cooldown = firerate_combatshotgun,
	  ammo_consumption_modifier = ammo_consumption_rate_combatshotgun,
      movement_slow_down_factor = movement_slow_down_factor_combatshotgun,
	  movement_slow_down_cooldown = movement_slow_down_cooldown_combatshotgun,
      damage_modifier = damage_modifier_combatshotgun,
      projectile_creation_distance = 1.125,
      range = range_combatshotgun,
      sound = soundsnew.gun_autoshotgun
    },
    stack_size = 5
  },
})  
 
data:extend({
createnewrareweapon("shotgun", "uncommon"),
createnewrareweapon("shotgun", "rare"),
createnewrareweapon("shotgun", "epic"),
createnewrareweapon("shotgun", "legendary"),
})  

data:extend({
createnewrareweapon("blunderbuss", "uncommon"),
createnewrareweapon("blunderbuss", "rare"),
createnewrareweapon("blunderbuss", "epic"),
createnewrareweapon("blunderbuss", "legendary"),
})  

data:extend({
createnewrareweapon("combat-shotgun", "uncommon"),
createnewrareweapon("combat-shotgun", "rare"),
createnewrareweapon("combat-shotgun", "epic"),
createnewrareweapon("combat-shotgun", "legendary"),
})  

data:extend({
    ----------------------------- VEHICLE COMBAT SHOTGUN  -----------------------------
  {
    type = "gun",
    name = "combat-shotgun-veh",
    icon = "__base__/graphics/icons/combat-shotgun.png",
    icon_size = 64, icon_mipmaps = 4,
	hidden = true,
    subgroup = "gun",
    order = "b[shotgun]-a[combat]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "shotgun-shell",
      cooldown = firerate_combatshotgun / attack_speed_vehicle_bonus,
      ammo_consumption_modifier = ammo_consumption_rate_combatshotgun,
      damage_modifier = damage_modifier_vehicle_bonus,
      projectile_creation_distance = 1.125,
      range = range_combatshotgun * range_modifier_vehicle_bonus,
      sound = soundsnew.gun_autoshotgun
    },
    stack_size = 1
  },
  
    -----------------------------  SNIPER RIFLE  -----------------------------
  {
    type = "gun",
    name = "sniper-rifle",
    icon = "__factorioplus__/graphics/icons/sniper.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "b[shotgun]-a[basic]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "sniper-shell",
      cooldown = firerate_sniper,
	  damage_modifier = sniper_damage_modifier,
	  movement_slow_down_cooldown = firerate_sniper/sniper_movement_slow_down_cooldown_factor,
      movement_slow_down_factor = sniper_fired_movement_slow_down_factor,
      projectile_creation_distance = 1.125,
      range = sniperbullet_range,
      min_range = 1,
      sound = {
  {
    filename = "__base__/sound/fight/heavy-gunshot-1.ogg",
    volume = 0.7,
	speed = 1.0
  },
  {
    filename = "__base__/sound/fight/heavy-gunshot-2.ogg",
    volume = 0.7,
	speed = 1.0
  },
  {
    filename = "__base__/sound/fight/heavy-gunshot-3.ogg",
    volume = 0.7,
	speed = 1.0
  },
  {
    filename = "__base__/sound/fight/heavy-gunshot-4.ogg",
    volume = 0.7,
	speed = 1.0
  },
},
    },
    stack_size = 5
  },

   -----------------------------  FLAMETHROWER  -----------------------------
  {
    type = "gun",
    name = "flamethrower",
    icon = "__base__/graphics/icons/flamethrower.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "e[flamethrower]",
    attack_parameters =
    {
      type = "stream",
      ammo_category = "flamethrower",
      cooldown = firerate_flamethrower,
      movement_slow_down_factor = 0.4,
      gun_barrel_length = 0.8,
      gun_center_shift = { 0, -1 },
      range = range_flamethrower,
      min_range = 3,
      cyclic_sound =
      {
        begin_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-start.ogg",
            volume = 0.7
          }
        },
        middle_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-mid.ogg",
            volume = 0.7
          }
        },
        end_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-end.ogg",
            volume = 0.7
          }
        }
      }
    },
    stack_size = 5
  }, 
  
})  
 
data:extend({
createnewrareweapon("sniper-rifle", "uncommon"),
createnewrareweapon("sniper-rifle", "rare"),
createnewrareweapon("sniper-rifle", "epic"),
createnewrareweapon("sniper-rifle", "legendary"),
})  

data:extend({
createnewrareweapon("flamethrower", "uncommon"),
createnewrareweapon("flamethrower", "rare"),
createnewrareweapon("flamethrower", "epic"),
createnewrareweapon("flamethrower", "legendary"),
})  

data:extend({
  -----------------------------  TANK FLAMETHROWER  -----------------------------
  {
    type = "gun",
    name = "tank-flamethrower",
    icon = "__base__/graphics/icons/flamethrower.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {},
	hidden = true,
    subgroup = "gun",
    order = "b[flamethrower]-b[tank-flamethrower]",
    attack_parameters =
    {
      type = "stream",
      ammo_category = "flamethrower",
      cooldown = firerate_flamethrower / attack_speed_vehicle_bonus,
	  damage_modifier = damage_modifier_vehicle_bonus,
      gun_barrel_length = 1.4,
      gun_center_shift = { -0.17, -1.15 },
      range = range_flamethrower * range_modifier_vehicle_bonus + 4,
      min_range = 5,
      cyclic_sound =
      {
        begin_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-start.ogg",
            volume = 1
          }
        },
        middle_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-mid.ogg",
            volume = 1
          }
        },
        end_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-end.ogg",
            volume = 1
          }
        }
      }
    },
    stack_size = 1
  },
  
 
   
   -----------------------------  LANDMINE  -----------------------------
  {
    type = "item",
    name = "land-mine",
    icon = "__base__/graphics/icons/land-mine.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "f[land-mine]",
    place_result = "land-mine",
    stack_size = 100,
  },
  
  
    -----------------------------  BRICK  -----------------------------
  
   {
    type = "recipe",
    name = "throwing-brick",
    energy_required = 4,
    ingredients =
    {
      {type="item", name="iron-plate", amount=1},
      {type="item", name="stone-brick", amount=2},
    },
	results = {{type="item", name="throwing-brick", amount=2}},
  },
  
  {
    type = "capsule",
    name = "throwing-brick",
    icon = "__factorioplus__/graphics/icons/throwable-brick.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "brick",
        cooldown = firerate_brick,
        projectile_creation_distance = 0.5,
		min_range = range_grenade_min,
        range = range_brick,
        ammo_type =
        {
          category = "bullet",
          target_type = "entity",
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "throwing-brick-projectile",
                starting_speed = 0.75
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
                    type = "play-sound",
                    sound = sounds.throw_projectile,
                  },
                }
              }
            } 
          }
        }
      }
    },
    -- radius_color = { r = 0.25, g = 0.05, b = 0.25, a = 0.25 },
    subgroup = "capsule",
    order = "a[grenade]-9[normal]",
    stack_size = grenade_stack
  },
  
  {
    type = "projectile",
    name = "throwing-brick-projectile",
    flags = {"not-on-map"},
	acceleration = 0;
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
						type = "create-particle",
						repeat_count = 16,
						particle_name = "explosion-stone-particle-small",
						offset_deviation = { { -0.25, -0.25 }, { 0.25, 0.25 } },
						initial_height = 0,
						initial_height_deviation = 0.25,
						initial_vertical_speed = 0.05,
						initial_vertical_speed_deviation = 0.05,
						speed_from_center = 0.05,
						speed_from_center_deviation = 0.05
					},
					{
						type = "create-entity",
						entity_name = "small-scorchmark-tintable",
						check_buildability = true
					},
				},
			},
		},
		{
        type = "area",
        radius = brick_radius,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
				{
				  type = "damage",
				  damage = {amount = brick_damage/2, type = "physical"}
				},
				{
				  type = "damage",
				  damage = {amount = brick_damage/3, type = "piercing"}
				},
				{
					type = "create-particle",
					repeat_count = 8,
					particle_name = "explosion-stone-particle-small",
					offset_deviation = { { -0.25, -0.25 }, { 0.2, 0.5 } },
					initial_height = 0.25,
					initial_height_deviation = 0.6,
					initial_vertical_speed = 0.1,
					initial_vertical_speed_deviation = 0.05,
					speed_from_center = 0.05,
					speed_from_center_deviation = 0.07
				},
			},
		},
		},

    },
    light = {intensity = 0.2, size = 1},
    animation =
    {
      filename = "__factorioplus__/graphics/stone-brick-projectile.png",
      frame_count = 1,
      line_length = 1,
      animation_speed = 0.250,
      width = 64,
      height = 64,
      shift = util.by_pixel(1, 1),
      priority = "high",
	  scale = 0.35,

    },
    shadow =
    {
      filename = "__factorioplus__/graphics/stone-brick-projectile-shadow.png",
      frame_count = 1,
      line_length = 1,
      animation_speed = 0.250,
      width = 64,
      height = 64,
      shift = util.by_pixel(2, 6),
      priority = "high",
      draw_as_shadow = true,
	  scale = 0.35,
    },
  },hidden = true,
  
    -----------------------------  GRENADE  -----------------------------
  
  {
    type = "capsule",
    name = "grenade",
    icon = "__base__/graphics/icons/grenade.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      --uses_stack = false,
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "grenade",
        cooldown = firerate_grenade,
        projectile_creation_distance = 0.6,
        range = range_grenade,
		min_range = range_grenade_min,
        ammo_type =
        {
          category = "grenade",
          target_type = "position",
		  clamp_position = true,
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "grenade",
                starting_speed = 0.5
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
                    type = "play-sound",
                    sound = sounds.throw_projectile,
                  },
                }
              }
            } 
          }
        }
      }
    },
    -- radius_color = { r = 0.25, g = 0.05, b = 0.25, a = 0.25 },
    subgroup = "capsule",
    order = "a[grenade]-a[normal]",
    stack_size = grenade_stack
  },

  {
    type = "projectile",
    name = "grenade",
    flags = {"not-on-map"},
    acceleration = -0.00,
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
		  table.unpack(make_explosion_trigger(grenade_damage, grenade_radius, grenade_falloff))
          },
		  
        }
      },
    },

    light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__base__/graphics/entity/grenade/grenade.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
       width = 48,
        height = 54,
		scale = 0.5,
      shift = util.by_pixel(1, 1),
      priority = "high",
	  scale = 0.6,

    },
    shadow =
    {
      filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 50,
        height = 40,
		scale = 0.5,
      shift = util.by_pixel(2, 6),
      priority = "high",
      draw_as_shadow = true,
    },
  },
  
   {
    type = "recipe",
    name = "grenade",
    enabled = false,
    energy_required = 4,
    ingredients =
    {
      {type = "item", name = "iron-plate", amount = 1},
      {type = "item", name = "basic-explosive", amount = 2}
    },
    results = {{type="item", name="grenade", amount=1}}
  },
  
    -----------------------------  CLUSTER GRENADE  -----------------------------
  
   {
    type = "capsule",
    name = "cluster-grenade",
    icon = "__base__/graphics/icons/cluster-grenade.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "grenade",
        cooldown = firerate_grenade,
        projectile_creation_distance = 0.6,
        range = range_clustergrenade,
		min_range = range_grenade_min,
        ammo_type =
        {
          category = "grenade",
          target_type = "position",
		  clamp_position = true,
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "cluster-grenade",
                starting_speed = 0.3
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
                    type = "play-sound",
                    sound = sounds.throw_projectile,
                  },
                }
              }
            }
          } 
        }
      }
    },
    subgroup = "capsule",
    order = "a[grenade]-b[cluster]",
    stack_size = grenade_stack_low
  },
  
  {
    type = "projectile",
    name = "cluster-grenade",
    flags = {"not-on-map"},
    acceleration = 0.005,
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
              type = "create-entity",
              entity_name = "small-scorchmark-tintable",
              check_buildability = true
            },
			table.unpack(make_explosion_trigger(grenade_damage, grenade_radius, grenade_falloff))
          }
        }
      },
      {
        type = "cluster",
        cluster_count = clustergrenade_count,
        distance = 6,
        distance_deviation = 4,
        action_delivery =
        {
          type = "projectile",
          projectile = "grenade",
          direction_deviation = 0.6,
          starting_speed = 0.35,
          starting_speed_deviation = 0.25
        }
      }
    },
    light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__base__/graphics/entity/cluster-grenade/cluster-grenade.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
       width = 48,
        height = 54,
		scale = 0.5,
      shift = util.by_pixel(1, 1),
      priority = "high",

    },
    shadow =
    {
      filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 50,
        height = 40,
		scale = 0.5,
      shift = util.by_pixel(2, 6),
      priority = "high",
      draw_as_shadow = true,
    },
  },
  
   {
    type = "recipe",
    name = "cluster-grenade",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
      {type="item", name="grenade", amount=4},
      {type="item", name="explosives", amount=4},
      {type="item", name="steel-plate", amount=2}
    },
	results = {{type="item", name="cluster-grenade", amount=1}},
  },
  
  
      -----------------------------  HE GRENADE  -----------------------------
  
       {
    type = "recipe",
    name = "he-grenade",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
      {type="item", name="grenade", amount=2},
      {type="item", name="explosives", amount=10}
    },
	results = {{type="item", name="he-grenade", amount=1}},
  },
  
  {
    type = "capsule",
    name = "he-grenade",
    icon = "__factorioplus__/graphics/icons/grenade-he.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      --uses_stack = false,
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "grenade",
        cooldown = firerate_grenade_large,
        projectile_creation_distance = 0.6,
        range = range_grenade,
		min_range = range_grenade_min,
        ammo_type =
        {
          category = "grenade",
          target_type = "position",
		  clamp_position = true,
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "he-grenade",
                starting_speed = 0.5
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
                    type = "play-sound",
                    sound = sounds.throw_projectile,
                  },
                }
              }
            } 
          }
        }
      }
    },
    -- radius_color = { r = 0.25, g = 0.05, b = 0.25, a = 0.25 },
    subgroup = "capsule",
    order = "a[grenade]-a[normal]",
    stack_size = grenade_stack_low
  },

  {
    type = "projectile",
    name =  "he-grenade",
    flags = {"not-on-map"},
    acceleration = -0.00,
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
		  table.unpack(make_explosion_trigger(he_grenade_damage, he_grenade_radius, he_grenade_falloff))
          },
		  
        }
      },
    },
    light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__factorioplus__/graphics/he-grenade.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 48,
      height = 54,
	  scale = 0.75,
      shift = util.by_pixel(1, 1),
      priority = "high",
	  scale = 0.6,
    },
    shadow =
    {
      filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 50,
      height = 40,
	  scale = 0.75,
      shift = util.by_pixel(2, 6),
      priority = "high",
      draw_as_shadow = true,
    },
  },
  
  -----------------------------  FLAK GRENADE  -----------------------------
  
     {
    type = "recipe",
    name = "flak-grenade",
    enabled = false,
    energy_required = 12,
    ingredients =
    {
      {type="item", name="grenade", amount=2},
      {type="item", name="piercing-shotgun-shell", amount=3}
    },
	results = {{type="item", name="flak-grenade", amount=1}},
  },
  
   {
    type = "capsule",
    name = "flak-grenade",
    icon = "__factorioplus__/graphics/icons/grenade-flak.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "grenade",
        cooldown = firerate_grenade,
        projectile_creation_distance = 0.6,
        range = range_flakgrenade,
		min_range = range_grenade_min,
        ammo_type =
        {
          category = "bullet",
          target_type = "position",
		  clamp_position = true,
          action =
          {
			  
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "flak-grenade",
                starting_speed = 0.4
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
                    type = "play-sound",
                    sound = sounds.throw_projectile,
                  },
                }
              }
            }
          } 
        }
      }
    },
    subgroup = "capsule",
    order = "a[grenade]-b[cluster]",
    stack_size = grenade_stack_low
  },
  
 
  
  {
    type = "projectile",
    name = "flak-grenade",
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
		{
			type = "area",
			radius = flak_explosion_radius,
			action_delivery =
			{
			  type = "instant",
			  target_effects =
			  {
				{
				  type = "damage",
				  damage = {amount = flak_explosion_damage, type = "explosion"}
				},
				{
				  type = "create-entity",
				  entity_name = "explosion"
				},
				{
				type = "create-trivial-smoke",
				smoke_name = "artillery-smoke",
				initial_height = 0,
				speed_from_center = 0.2,
				speed_from_center_deviation = 0.005,
				offset_deviation = {{-4, -4}, {4, 4}},
				max_radius = 4.0,
				repeat_count = 1 * 2 * 8
				},
			  },
			  
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
              type = "create-entity",
              entity_name = "small-scorchmark-tintable",
              check_buildability = true
            },
          }
        }
      },
      {
        type = "cluster",
        cluster_count = flak_pellet_count,
        distance = 15,
        distance_deviation = 5,
        action_delivery =
        {
          type = "projectile",
          projectile = "flak-grenade-pellet",
		  max_range = flak_pellet_range,
		  range_deviation = 2.0,
          direction_deviation = 0.6,
          starting_speed = 1,
          starting_speed_deviation = 0.1
        }
      }
    },
    light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__factorioplus__/graphics/flak-grenade.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
       width = 48,
        height = 54,
		scale = 0.5,
      shift = util.by_pixel(1, 1),
      priority = "high",
    },
    shadow =
    {
      filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
       width = 50,
      height = 40,
	  scale = 0.5,
      shift = util.by_pixel(2, 6),
      priority = "high",
      draw_as_shadow = true,
    },
  },
    	
  {
    type = "projectile",
    name = "flak-grenade-pellet",
    flags = {"not-on-map"},
    collision_box = {{-0.05, -0.25}, {0.05, 0.25}},
    acceleration = 0,
    direction_only = true,
	piercing_damage = 100, 
	max_range = shell_range,
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
			  damage = {amount = flak_piercing_damage, type = "piercing"}
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

 -----------------------------  MIRV GRENADE  -----------------------------
  
   {
    type = "capsule",
    name = "mirv-grenade",
    icon = "__factorioplus__/graphics/icons/grenade-mirv.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "grenade",
        cooldown = firerate_grenade_large,
        projectile_creation_distance = 0.6,
        range = range_mirvgrenade,
        ammo_type =
        {
          category = "grenade",
          target_type = "position",
		  clamp_position = true,
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "mirv-grenade",
                starting_speed = 0.4
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
                    type = "play-sound",
                    sound = sounds.throw_projectile,
                  },
                }
              }
            }
          } 
        }
      }
    },
    subgroup = "capsule",
    order = "a[grenade]-b[cluster]",
    stack_size = mirv_stack
  },
  
  {
    type = "projectile",
    name = "mirv-grenade",
    flags = {"not-on-map"},
    acceleration = 0.003,
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
              type = "create-entity",
              entity_name = "small-scorchmark-tintable",
              check_buildability = true
            },
          }
        }
      },
      {
        type = "cluster",
        cluster_count = mirvgrenade_count,
        distance = 12,
        distance_deviation = 5,
        action_delivery =
        {
          type = "projectile",
          projectile = "cluster-grenade",
          direction_deviation = 0.6,
          starting_speed = 0.35,
          starting_speed_deviation = 0.5
        }
      }
    },
    light = {intensity = 0.5, size = 5},
    animation =
    {
      filename = "__base__/graphics/entity/cluster-grenade/cluster-grenade.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
       width = 48,
        height = 54,
		scale = 1,
      shift = util.by_pixel(1, 1),
      priority = "high",

    },
    shadow =
    {
      filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 50,
        height = 40,
		scale = 1,
      shift = util.by_pixel(2, 6),
      priority = "high",
      draw_as_shadow = true,
    },
  },
  
   {
    type = "recipe",
    name = "mirv-grenade",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
      {type="item", name="cluster-grenade", amount=6},
      {type="item", name="explosives", amount=12},
      {type="item", name="low-density-structure", amount=1}
    },
	results = {{type="item", name="mirv-grenade", amount=1}},
  },
  
      -----------------------------  MOLOTOV  -----------------------------
  
   {
    type = "recipe",
    name = "molotov",
	enabled = false,
    energy_required = 18,
    ingredients =
    {
      {type="item", name="glass-plate", amount=8},
      {type="item", name="petroleum-fuel", amount=2},
	  {type="item", name="grenade", amount=1},
    },
	results = {{type="item", name="molotov", amount=4}},
  },
  
  
  	make_fire_bomblet_projectile({
		name = "molotov-fire-bomblet",
		bomblet_radius = 2 , -- Range to apply sticker & damage
		bomblet_sticker = "fire-sticker" , -- fire sticker
		bomblet_damage = 0,
		bomblet_damage_type = "fire",
		bomblet_groundfire = "fire-flame" , -- ground fire
	}),
	
  {
    type = "capsule",
    name = "molotov",
    icon = "__factorioplus__/graphics/icons/molotov.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "flamethrower",
        cooldown = firerate_grenade,
        projectile_creation_distance = 0.6,
        range = range_grenade,
		min_range = range_grenade_min,
        ammo_type =
        {
          category = "flamethrower",
          target_type = "position",
		  clamp_position = true,
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "molotov",
                starting_speed = 0.5
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
                    type = "play-sound",
                    sound = sounds.throw_projectile,
                  },
                }
              }
            } 
          }
        }
      }
    },
    -- radius_color = { r = 0.25, g = 0.05, b = 0.25, a = 0.25 },
    subgroup = "capsule",
    order = "a[grenade]-a[normal]",
    stack_size = grenade_stack_low
  },

  {
    type = "projectile",
    name = "molotov",
    flags = {"not-on-map"},
    acceleration = -0.00,
    action =
    {
		{
			type = "cluster",
			cluster_count = 30,
			distance = 4,
			distance_deviation = 6,
			action_delivery =
			{
			  type = "projectile",
			  projectile = "molotov-fire-bomblet",
			  direction_deviation = 0.6,
			  starting_speed = 0.35,
			  starting_speed_deviation = 0.5
			}
		},
		{
			type = "cluster",
			cluster_count = 10,
			distance = 1,
			distance_deviation = 2,
			action_delivery =
			{
			  type = "projectile",
			  projectile = "molotov-fire-bomblet",
			  direction_deviation = 0.6,
			  starting_speed = 0.95,
			  starting_speed_deviation = 0.5
			}
		},
    },

    light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__factorioplus__/graphics/molotov-projectile.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
       width = 696/8,
        height = 154/2,
		scale = 0.5,
      shift = util.by_pixel(1, 1),
      priority = "high",
	  scale = 0.6,

    },
    shadow =
    {
      filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 50,
        height = 40,
		scale = 0.4,
      shift = util.by_pixel(2, 6),
      priority = "high",
      draw_as_shadow = true,
    },
  },
 })
 
  
  -----------------------------  SLOWDOWN GRENADE  -----------------------------
  data.raw["sticker"]["slowdown-sticker"].duration = slowdown_grenade_duration
   data.raw["sticker"]["slowdown-sticker"].target_movement_modifier = slowdown_grenade_movement
  
  
  data.extend({
  
    {
    type = "recipe",
    name = "slowdown-capsule",
	category = "crafting-with-fluid",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {type="item", name="barrel", amount=1},
	  {type="item", name="grenade", amount=1},
      {type="item", name="electronic-circuit", amount=3},
      {type="fluid", name="heavy-oil", amount=60}
    },
    results = {{type="item", name="slowdown-capsule", amount=2}},
  },
  
  {
    type = "capsule",
    name = "slowdown-capsule",
    icon = "__base__/graphics/icons/slowdown-capsule.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        activation_type = "throw",
        ammo_category = "capsule",
        cooldown = firerate_grenade,
        projectile_creation_distance = 0.6,
        range = range_grenade + capsule_throw_extra_range,
        ammo_type =
        {
		  
          category = "capsule",
          target_type = "position",
		  clamp_position = true,
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "slowdown-capsule",
                starting_speed = 0.3
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
                    type = "play-sound",
                    sound = sounds.throw_projectile
                  }
                }
              }
            }
          }
        }
      }
    },
    subgroup = "capsule",
    order = "c[slowdown-capsule]",
    stack_size = grenade_stack
  },
  
  
  {
    type = "projectile",
    name = "slowdown-capsule",
    flags = {"not-on-map"},
    acceleration = 0.005,
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
              entity_name = "slowdown-capsule-explosion"
            }
          }
        }
      },
      {
        type = "area",
        radius = 10,
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
      }
    },
    --light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__base__/graphics/entity/slowdown-capsule/slowdown-capsule.png",
      draw_as_glow = true,
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 32,
      height = 30,
      shift = util.by_pixel(1, 0),
      priority = "high",
      hr_version =
      {
        filename = "__base__/graphics/entity/slowdown-capsule/hr-slowdown-capsule.png",
        draw_as_glow = true,
        frame_count = 16,
        line_length = 8,
        animation_speed = 0.250,
        width = 60,
        height = 60,
        shift = util.by_pixel(0.5, 0.5),
        priority = "high",
        scale = 0.5
      }

    },
    shadow =
    {
      filename = "__base__/graphics/entity/slowdown-capsule/slowdown-capsule-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 32,
      height = 24,
      shift = util.by_pixel(2, 13),
      priority = "high",
      draw_as_shadow = true,
      hr_version =
      {
        filename = "__base__/graphics/entity/slowdown-capsule/hr-slowdown-capsule-shadow.png",
        frame_count = 16,
        line_length = 8,
        animation_speed = 0.250,
        width = 64,
        height = 48,
        shift = util.by_pixel(2, 13.5),
        priority = "high",
        draw_as_shadow = true,
        scale = 0.5
      }
    },
    smoke = capsule_smoke
  },
  
  {
    type = "explosion",
    name = "slowdown-capsule-explosion",
    icon = "__base__/graphics/icons/slowdown-capsule.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"not-on-map"}, 
	hidden = true,
    subgroup = "storage-explosions",
    height = 0,
    render_layer = "lower-object-above-shadow",
    animations = util.empty_sprite(),
    --light = default_light(20),
    smoke = "smoke-fast",
    smoke_count = 6,
    smoke_slow_down_factor = 1,
    sound = sounds.slowdown_capsule_explosion,
    subgroup = "gun-explosions",
    order = "a-a-a",
    render_layer = "lower-object-above-shadow",
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-particle",
            repeat_count = 15,
            repeat_count_deviation = 0,
            probability = 1,
            affects_target = false,
            show_in_tooltip = false,
            particle_name = "slowdown-capsule-particle",
            offsets = {
              { 0, 0 }
            },
            offset_deviation = {
              left_top = { -0.09766, -0.09766 },
              right_bottom = { 0.09766, 0.09766 }
            },
            tile_collision_mask = nil,
            initial_height = 1,
            initial_height_deviation = 0.2,
            initial_vertical_speed = 0.1,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.25,
            speed_from_center_deviation = 0.05,
            frame_speed = 0.5,
            frame_speed_deviation = 0,
            tail_length = 15,
            tail_length_deviation = 1,
            tail_width = 3,
            rotate_offsets = false
          },
          {
            type = "create-particle",
            repeat_count = 18,
            repeat_count_deviation = 0,
            probability = 1,
            affects_target = false,
            show_in_tooltip = false,
            particle_name = "slowdown-capsule-particle-big",
            offsets = {
              { 0, 0 }
            },
            offset_deviation = {
              left_top = { -0.4961, -0.3945 },
              right_bottom = { 0.4961, 0.3945 }
            },
            tile_collision_mask = nil,
            initial_height = 0.7,
            initial_height_deviation = 0.14,
            initial_vertical_speed = 0.1,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.15,
            speed_from_center_deviation = 0.01,
            frame_speed = 0.3,
            frame_speed_deviation = 0,
            tail_length = 15,
            tail_length_deviation = 1,
            tail_width = 5,
            rotate_offsets = false
          },
          {
            type = "create-particle",
            repeat_count = 18,
            repeat_count_deviation = 0,
            probability = 1,
            affects_target = false,
            show_in_tooltip = false,
            particle_name = "slowdown-capsule-particle",
            offsets = {
              { 0, 0 }
            },
            offset_deviation = {
              left_top = { -0.1914, -0.2969 },
              right_bottom = { 0.1914, 0.2969 }
            },
            tile_collision_mask = nil,
            initial_height = 0.3,
            initial_height_deviation = 0.03,
            initial_vertical_speed = 0.012,
            initial_vertical_speed_deviation = 0,
            speed_from_center = 0.15,
            speed_from_center_deviation = 0,
            frame_speed = 0.5,
            frame_speed_deviation = 0,
            tail_length = 10,
            tail_length_deviation = 0,
            tail_width = 5,
            rotate_offsets = false
          },
          {
            type = "create-particle",
            repeat_count = 18,
            repeat_count_deviation = 0,
            probability = 1,
            affects_target = false,
            show_in_tooltip = false,
            particle_name = "slowdown-capsule-particle-big",
            offsets = {
              { 0, 0 }
            },
            offset_deviation = {
              left_top = { -0.09766, -0.2969 },
              right_bottom = { 0.09766, 0.2969 }
            },
            tile_collision_mask = nil,
            initial_height = 0.3,
            initial_height_deviation = 0.03,
            initial_vertical_speed = 0.021,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.15,
            speed_from_center_deviation = 0.05,
            frame_speed = 0.5,
            frame_speed_deviation = 0,
            tail_length = 10,
            tail_length_deviation = 0,
            tail_width = 5,
            rotate_offsets = false
          },
          {
            type = "create-particle",
            repeat_count = 20,
            repeat_count_deviation = 0,
            probability = 1,
            affects_target = false,
            show_in_tooltip = false,
            particle_name = "slowdown-capsule-particle-big",
            offsets = {
              { 0, 0 }
            },
            offset_deviation = {
              left_top = { -0.5, 0 },
              right_bottom = { 0.5, 0 }
            },
            tile_collision_mask = nil,
            initial_height = 0.2,
            initial_height_deviation = 0.5,
            initial_vertical_speed = 0.050,
            initial_vertical_speed_deviation = 0.15,
            speed_from_center = 0.25,
            speed_from_center_deviation = 0.05,
            frame_speed = 0.25,
            frame_speed_deviation = 0,
            tail_length = 7,
            tail_length_deviation = 0,
            tail_width = 3,
            rotate_offsets = false
          }
        }
      }
    }
  },
})
  
  -----------------------------  POISON GRENADE  -----------------------------
 
data.raw["smoke-with-trigger"]["poison-cloud"].duration = poison_grenade_duration
data.raw["smoke-with-trigger"]["poison-cloud"].action_cooldown = poison_grenade_tick_duration
data.raw["smoke-with-trigger"]["poison-cloud-visual-dummy"].duration = poison_grenade_duration
data.raw["smoke-with-trigger"]["poison-cloud"].action.action_delivery.target_effects.action.action_delivery.target_effects.damage.amount = poison_grenade_damage

data.extend({ 

  {
    type = "recipe",
    name = "poison-capsule",
    enabled = false,
    energy_required = 20,
	category = "crafting-with-fluid",
    ingredients =
    {
	  {type="item", name="grenade", amount=1},
      {type="item", name="barrel", amount=1},
      {type="item", name="electronic-circuit", amount=3},
      {type="fluid", name="sulfuric-acid", amount=100},
    },
    results = {{type="item", name="poison-capsule", amount=2}},
  },


  {
    type = "capsule",
    name = "poison-capsule",
    icon = "__base__/graphics/icons/poison-capsule.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        activation_type = "throw",
        ammo_category = "capsule",
        cooldown = firerate_grenade,
        projectile_creation_distance = 0.6,
        range = range_grenade + capsule_throw_extra_range,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
		  clamp_position = true,
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "poison-capsule",
                starting_speed = 0.3
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
                    type = "play-sound",
                    sound = sounds.throw_projectile
                  }
                }
              }
            }
          }
        }
      }
    },
    subgroup = "capsule",
    order = "b[poison-capsule]",
    stack_size = grenade_stack
   },
   
   {
    type = "projectile",
    name = "poison-capsule",
    flags = {"not-on-map"},
    acceleration = 0.005,
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
              type = "create-smoke",
              show_in_tooltip = true,
              entity_name = "poison-cloud",
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
      }
    },
    --light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__base__/graphics/entity/poison-capsule/poison-capsule.png",
      draw_as_glow = true,
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 29,
      height = 29,
      shift = util.by_pixel(1, 0.5),
      priority = "high",
      hr_version =
      {
        filename = "__base__/graphics/entity/poison-capsule/hr-poison-capsule.png",
        draw_as_glow = true,
        frame_count = 16,
        line_length = 8,
        animation_speed = 0.250,
        width = 58,
        height = 59,
        shift = util.by_pixel(1, 0.5),
        priority = "high",
        scale = 0.5
      }

    },
    shadow =
    {
      filename = "__base__/graphics/entity/poison-capsule/poison-capsule-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 27,
      height = 21,
      shift = util.by_pixel(1, 2),
      priority = "high",
      draw_as_shadow = true,
      hr_version =
      {
        filename = "__base__/graphics/entity/poison-capsule/hr-poison-capsule-shadow.png",
        frame_count = 16,
        line_length = 8,
        animation_speed = 0.250,
        width = 54,
        height = 42,
        shift = util.by_pixel(1, 2),
        priority = "high",
        draw_as_shadow = true,
        scale = 0.5
      }
    },
    smoke =
    {
      {
        name = "poison-capsule-smoke",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, 0},
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed_deviation = 5
      }
    }
  },
  
  --- CLOUDS
  
  {
    name = "poison-cloud-large",
    type = "smoke-with-trigger",
    flags = {"not-on-map"},
    hidden = true,
    show_when_smoke_off = true,
    particle_count = 24,
    particle_spread = { 3.6 * 1.05, 3.6 * 0.6 * 1.05 },
    particle_distance_scale_factor = 0.5,
    particle_scale_factor = { 1, 0.707 },
    wave_speed = { 1/80, 1/60 },
    wave_distance = { 0.3, 0.2 },
    spread_duration_variation = 20,
    particle_duration_variation = 60 * 3,
    render_layer = "object",

    affected_by_wind = false,
    cyclic = true,
    duration = poison_grenade_duration,
    fade_away_durastion = 2 * 60,
    spread_duration = 20,
    color = {0.239, 0.875, 0.992, 0.690}, -- #3ddffdb0,

    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {-0.53125, -0.4375},
      priority = "high",
      animation_speed = 0.25,
      filename = "__base__/graphics/entity/smoke/smoke.png",
      flags = { "smoke" }
    },

    created_effect =
    {
      {
        type = "cluster",
        cluster_count = 10*1.5,
        distance = 4 *1.5,
        distance_deviation = 5 *1.5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-smoke",
              show_in_tooltip = false,
              entity_name = "poison-cloud-large-visual-dummy",
              initial_height = 0
            },
            {
              type = "play-sound",
              sound = sounds.poison_capsule_explosion
            }
          }
        }
      },
      {
        type = "cluster",
        cluster_count = 11 *1.5 ,
        distance = 8 * 1.5,
        distance_deviation = 2,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-smoke",
              show_in_tooltip = false,
              entity_name = "poison-cloud-visual-dummy",
              initial_height = 0
            }
          }
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
          type = "nested-result",
          action =
          {
            type = "area",
            radius = 11 * 1.5,
            entity_flags = {"breaths-air"},
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = { amount = poison_grenade_damage, type = "poison"}
              }
            }
          }
        }
      }
    },
    action_cooldown = poison_grenade_tick_duration
  },
  
  {
    type = "smoke-with-trigger",
    name = "poison-cloud-large-visual-dummy",
    flags = {"not-on-map"},
    hidden = true,
    show_when_smoke_off = true,
    particle_count = 16 * 2,
    particle_spread = { 3.6 * 1.05, 3.6 * 0.6 * 1.05 },
    particle_distance_scale_factor = 0.5 *1.5,
    particle_scale_factor = { 1, 0.707 },
    particle_duration_variation = 60 * 3,
    wave_speed = { 0.5 / 80, 0.5 / 60 },
    wave_distance = { 1, 0.5 },
    spread_duration_variation = 300 - 20,

    render_layer = "object",

    affected_by_wind = false,
    cyclic = true,
    duration = poison_grenade_duration,
    fade_away_duration = 3 * 60,
    spread_duration = (300 - 20) / 2 ,
    color = {0.014, 0.358, 0.395, 0.322}, -- #035b6452

    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {-0.53125, -0.4375},
      priority = "high",
      animation_speed = 0.25,
      filename = "__base__/graphics/entity/smoke/smoke.png",
      flags = { "smoke" }
    },
    working_sound =
    {
      sound = {filename = "__base__/sound/fight/poison-cloud.ogg", volume = 0.5, audible_distance_modifier = 0.8},
      max_sounds_per_prototype = 1,
      match_volume_to_activity = true
    }
  },
   
-----------------------------  HEALING GRENADE  -----------------------------
  
     {
    type = "recipe",
    name = "healing-capsule",
	category = "crafting-with-fluid",
    enabled = false,
    energy_required = 20,
    ingredients =
    {
      {type="item", name="med-pack", amount=1},
      {type="item", name="barrel", amount=1},
      {type="fluid", name="steam", amount=200},
    },
    results = {{type="item", name="healing-capsule", amount=2}},
  },
  
  {
    type = "capsule",
    name = "healing-capsule",
    icon = "__factorioplus__/graphics/icons/healing-capsule.png",
    icon_size = 64, icon_mipmaps = 4,
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        activation_type = "throw",
        ammo_category = "capsule",
        cooldown = firerate_grenade,
        projectile_creation_distance = 0.6,
        range = range_grenade + capsule_throw_extra_range,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
		  clamp_position = true,
          action =
          {
            {
              type = "direct",
              action_delivery =
              {
                type = "projectile",
                projectile = "healing-capsule",
                starting_speed = 0.3
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
                    type = "play-sound",
                    sound = sounds.throw_projectile
                  }
                }
              }
            }
          }
        }
      }
    },
    subgroup = "capsule",
    order = "b[poison-capsule]",
    stack_size = grenade_stack
   },
   
   {
    type = "projectile",
    name = "healing-capsule",
    flags = {"not-on-map"},
    acceleration = 0.005,
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
              type = "create-smoke",
              show_in_tooltip = true,
              entity_name = "healing-cloud",
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
      }
    },
    --light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__base__/graphics/entity/poison-capsule/poison-capsule.png",
      draw_as_glow = true,
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 29,
      height = 29,
      shift = util.by_pixel(1, 0.5),
      priority = "high",
      hr_version =
      {
        filename = "__base__/graphics/entity/poison-capsule/hr-poison-capsule.png",
        draw_as_glow = true,
        frame_count = 16,
        line_length = 8,
        animation_speed = 0.250,
        width = 58,
        height = 59,
        shift = util.by_pixel(1, 0.5),
        priority = "high",
        scale = 0.5
      }

    },
    shadow =
    {
      filename = "__base__/graphics/entity/poison-capsule/poison-capsule-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 27,
      height = 21,
      shift = util.by_pixel(1, 2),
      priority = "high",
      draw_as_shadow = true,
      hr_version =
      {
        filename = "__base__/graphics/entity/poison-capsule/hr-poison-capsule-shadow.png",
        frame_count = 16,
        line_length = 8,
        animation_speed = 0.250,
        width = 54,
        height = 42,
        shift = util.by_pixel(1, 2),
        priority = "high",
        draw_as_shadow = true,
        scale = 0.5
      }
    },
    smoke =
    {
      {
        name = "poison-capsule-smoke",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, 0},
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed_deviation = 5
      }
    }
  },
  
  {
    name = "healing-cloud",
    type = "smoke-with-trigger",
    flags = {"not-on-map"},
    show_when_smoke_off = true,
    particle_count = 16,
    particle_spread = { 3.6 * 1.05, 3.6 * 0.6 * 1.05 },
    particle_distance_scale_factor = 0.5,
    particle_scale_factor = { 1, 0.707 },
    wave_speed = { 1/80, 1/60 },
    wave_distance = { 0.3, 0.2 },
    spread_duration_variation = 20,
    particle_duration_variation = 60 * 3,
    render_layer = "object",

    affected_by_wind = false,
    cyclic = true,
    duration = healing_grenade_duration,
    fade_away_duration = 2 * 60,
    spread_duration = 20,
    color = {r = 0.239, g = 0.875, b = 0.192, a = 0.690}, -- #3ddffdb0,

    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {-0.53125, -0.4375},
      priority = "high",
      animation_speed = 0.25,
      filename = "__base__/graphics/entity/smoke/smoke.png",
      flags = { "smoke" }
    },

    created_effect =
    {
      {
        type = "cluster",
        cluster_count = 10,
        distance = 4,
        distance_deviation = 5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-smoke",
              show_in_tooltip = false,
              entity_name = "healing-cloud-visual-dummy",
              initial_height = 0
            },
            {
              type = "play-sound",
              sound = sounds.poison_capsule_explosion
            }
          }
        }
      },
      {
        type = "cluster",
        cluster_count = 11,
        distance = 8 * 1.1,
        distance_deviation = 2,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-smoke",
              show_in_tooltip = false,
              entity_name = "healing-cloud-visual-dummy",
              initial_height = 0
            }
          }
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
          type = "nested-result",
          action =
          {
            type = "area",
            radius = 11,
            entity_flags = {"breaths-air"},
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = { amount = -healing_grenade_health, type = "physical"}
              }
            }
          }
        }
      }
    },
    action_cooldown = healing_grenade_tick_duration
  },
  
  {
    type = "smoke-with-trigger",
    name = "healing-cloud-visual-dummy",
    flags = {"not-on-map"},
    show_when_smoke_off = true,
    particle_count = 24,
    particle_spread = { 3.6 * 1.05, 3.6 * 0.6 * 1.05 },
    particle_distance_scale_factor = 0.5,
    particle_scale_factor = { 1, 0.707 },
    particle_duration_variation = 60 * 3,
    wave_speed = { 0.5 / 80, 0.5 / 60 },
    wave_distance = { 1, 0.5 },
    spread_duration_variation = 300 - 20,

    render_layer = "object",

    affected_by_wind = false,
    cyclic = true,
    duration = healing_grenade_duration,
    fade_away_duration = 3 * 60,
    spread_duration = (300 - 20) / 2 ,
    color = {r = 0.239, g = 0.875, b = 0.192, a = 0.390}, -- #035b6452

    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {-0.53125, -0.4375},
      priority = "high",
      animation_speed = 0.25,
      filename = "__base__/graphics/entity/smoke/smoke.png",
      flags = { "smoke" }
    },
    working_sound =
    {
      sound = { filename = "__base__/sound/fight/poison-cloud.ogg", volume = 0.5 },
      max_sounds_per_type = 1,
      audible_distance_modifier = 0.8,
      match_volume_to_activity = true
    }
  },
  
   -----------------------------  MORTAR  -----------------------------
 
   {
    type = "gun",
    name = "grenade-launcher",
    icon = "__factorioplus__/graphics/icons/grenade-launcher.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "c[grenadelauncher]",
    attack_parameters =
    {
      type = "stream",
      ammo_category = "grenade-shell",
      cooldown = firerate_grenadelauncher,
	  --warmup = firerate_grenadelauncher,
      movement_slow_down_factor = 0.95,
	  movement_slow_down_cooldown = firerate_grenadelauncher,
      gun_barrel_length = 0.8,
      gun_center_shift = { 0, -1 },
      range = range_mortar,
      min_range = 10,
	  sound =
      {
        {
          filename = "__base__/sound/fight/artillery-shoots-1.ogg",
          volume = 0.5,
		  speed = 2.0,
        }
      },
	  cyclic_sound =
      {
        begin_sound =
        {
          {
          filename = "__base__/sound/fight/artillery-shoots-1.ogg",
          volume = 0.6,
		  speed = 1.75,
          }
        },
		-- middle_sound =
        -- {
          -- {
            -- filename = "__base__/sound/fight/artillery-shoots-1.ogg",
          -- volume = 0.6,
		  -- speed = 1.75,
          -- }
        -- },
	 }
    },
    stack_size = 5
  }, 
  
})  

data:extend({
createnewrareweapon("grenade-launcher", "uncommon"),
createnewrareweapon("grenade-launcher", "rare"),
createnewrareweapon("grenade-launcher", "epic"),
createnewrareweapon("grenade-launcher", "legendary"),
})  

data:extend({
 -----------------------------  TANK CANNON  -----------------------------
  {
    type = "gun",
    name = "tank-cannon",
    icon = "__base__/graphics/icons/tank-cannon.png",
    icon_size = 64, icon_mipmaps = 4,
    hidden = true,
    subgroup = "gun",
    order = "z[tank]-a[cannon]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "cannon-shell",
      cooldown = firerate_cannon / attack_speed_vehicle_bonus,
	  damage_modifier = damage_modifier_vehicle_bonus ,
      movement_slow_down_factor = 0,
      projectile_creation_distance = 1.6,
      projectile_center = {-0.15625, -0.07812},
      range = cannon_shell_range * range_modifier_vehicle_bonus,
      sound = sounds.tank_gunshot,
    },
    stack_size = 5
  },
   -----------------------------  ARTILLERY CANNON  -----------------------------
  {
    type = "gun",
    name = "artillery-wagon-cannon",
    icon = "__base__/graphics/icons/tank-cannon.png",
    icon_size = 64, icon_mipmaps = 4,
    hidden = true,
    subgroup = "gun",
    order = "z[artillery]-a[cannon]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "artillery-shell",
      cooldown = firerate_artillery,
      movement_slow_down_factor = 0,
      projectile_creation_distance = 1.6,
      projectile_center = {-0.15625, -0.07812},
      range = artillery_turret_range,
      min_range = artillery_turret_min_range,
      projectile_creation_parameters = require("__base__.prototypes.entity.artillery-cannon-muzzle-flash-shifting"),
      sound =
      {
        {
          filename = "__base__/sound/fight/artillery-shoots-1.ogg",
          volume = 0.7
        }
      },
      shell_particle =
      {
        name = "artillery-shell-particle",
        direction_deviation = 0.05,
        direction = 0.4,
        speed = 0.10,
        speed_deviation = 0.1,
        vertical_speed = 0.05,
        vertical_speed_deviation = 0.01,
        center = {0, -0.5},
        creation_distance = 0.5,
        creation_distance_orientation = 0.4,
        starting_frame_speed = 0.5,
        starting_frame_speed_deviation = 0.5,
        use_source_position = true,
        height = 1
      },
    },
    stack_size = 1
  },
   -----------------------------  ROCKET LAUNCHER  -----------------------------
  {
    type = "gun",
    name = "rocket-launcher",
    icon = "__base__/graphics/icons/rocket-launcher.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "d[rocket-launcher]",
    attack_parameters =
    {
      type = "projectile",
      ammo_categories = rocketlauncher_ammo_categories,
      movement_slow_down_factor = movement_slow_down_factor_rocketlauncher,
      cooldown =  firerate_rocketlauncher,
      projectile_creation_distance = 0.6,
      range = range_rocketlauncher,
	  min_range = min_range_rocketlauncher,
      projectile_center = {-0.17, 0},
      sound =
      {
        {
          filename = "__base__/sound/fight/rocket-launcher.ogg",
          volume = 0.7
        }
      }
    },
    stack_size = 5
  },
  
  })  
 
data:extend({
createnewrareweapon("rocket-launcher", "uncommon"),
createnewrareweapon("rocket-launcher", "rare"),
createnewrareweapon("rocket-launcher", "epic"),
createnewrareweapon("rocket-launcher", "legendary"),
})   

data:extend({ 
   ----------------------------- VEHICLE ROCKET LAUNCHER  -----------------------------
  {
    type = "gun",
    name = "rocket-launcher-veh",
    icon = "__base__/graphics/icons/rocket-launcher.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "d[rocket-launcher]",
	hidden = true,
    attack_parameters =
    {
      type = "projectile",
      ammo_categories = rocketlauncher_ammo_categories,
      movement_slow_down_factor = 0.75,
      cooldown =  firerate_rocketlauncher / attack_speed_vehicle_bonus,
      projectile_creation_distance = 0.6,
	  damage_modifier = damage_modifier_vehicle_bonus,
      range = range_rocketlauncher * range_modifier_vehicle_bonus,
	  min_range =  math.ceil( min_range_rocketlauncher * range_modifier_vehicle_bonus),
      projectile_center = {-0.17, 0},
      sound =
      {
        {
          filename = "__base__/sound/fight/rocket-launcher.ogg",
          volume = 0.7
        }
      }
    },
    stack_size = 5
  },
  
  })  
  
 ----------------------------- MULTI ROCKET LAUNCHER  -----------------------------
data:extend({ 
 {
    type = "gun",
    name = "multirocket-launcher",
    icon = "__factorioplus__/graphics/icons/multirocket-launcher.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "d[rocket-launcher]",
    attack_parameters =
    {
      type = "projectile",
      ammo_categories = rocketlauncher_ammo_categories,
      movement_slow_down_factor = 0.8,
      cooldown = firerate_rocketlauncher_multi,
      projectile_creation_distance = 0.6,
      range = range_rocketlauncher_multi,
	  min_range = min_range_rocketlauncher,
      projectile_center = {-0.17, 0},
      sound =
      {
        {
          filename = "__base__/sound/fight/rocket-launcher.ogg",
          volume = 0.8
        }
      }
    },
    stack_size = 5
  },
 })  
 
data:extend({
createnewrareweapon("multirocket-launcher", "uncommon"),
createnewrareweapon("multirocket-launcher", "rare"),
createnewrareweapon("multirocket-launcher", "epic"),
createnewrareweapon("multirocket-launcher", "legendary"),
})   

data:extend({
   -----------------------------  SPIDERTRON ROCKET LAUNCHER  -----------------------------
  {
    type = "gun",
    name = "spidertron-rocket-launcher-1",
    localised_name = {"item-name.spidertron-rocket-launcher"},
    icon = "__base__/graphics/icons/rocket-launcher.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    hidden = true,
    order = "z[spider]-a[rocket-launcher]",
    attack_parameters =
    {
      type = "projectile",
      ammo_categories = rocketlauncher_ammo_categories,
      cooldown =  firerate_rocketlauncher_spidertron,
      range = range_rocketlauncher_spidertron,
      projectile_creation_distance = -0.5,
      projectile_center = {0, 0.3},
      projectile_orientation_offset = -0.0625,
      sound =
      {
        {
          filename = "__base__/sound/fight/rocket-launcher.ogg",
          volume = 0.7
        }
      }
    },
    stack_size = 1
  },
  {
    type = "gun",
    name = "spidertron-rocket-launcher-2",
    localised_name = {"item-name.spidertron-rocket-launcher"},
    icon = "__base__/graphics/icons/rocket-launcher.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    hidden = true,
    order = "z[spider]-a[rocket-launcher]",
    attack_parameters =
    {
      type = "projectile",
       ammo_categories = rocketlauncher_ammo_categories,
      cooldown =  firerate_rocketlauncher_spidertron,
      range = range_rocketlauncher_spidertron,
      projectile_creation_distance = -0.5,
      projectile_orientation_offset = -0.03125,
      projectile_center = {0, 0.3},
      sound =
      {
        {
          filename = "__base__/sound/fight/rocket-launcher.ogg",
          volume = 0.7
        }
      }
    },
    stack_size = 1
  },
  {
    type = "gun",
    name = "spidertron-rocket-launcher-3",
    localised_name = {"item-name.spidertron-rocket-launcher"},
    icon = "__base__/graphics/icons/rocket-launcher.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    hidden = true,
    order = "z[spider]-a[rocket-launcher]",
    attack_parameters =
    {
      type = "projectile",
       ammo_categories = rocketlauncher_ammo_categories,
      cooldown =  firerate_rocketlauncher_spidertron,
      range = range_rocketlauncher_spidertron,
      projectile_creation_distance = -0.5,
      projectile_center = {0, 0.3},
      projectile_orientation_offset = 0.03125,
      sound =
      {
        {
          filename = "__base__/sound/fight/rocket-launcher.ogg",
          volume = 0.7
        }
      }
    },
    stack_size = 1
  },
  
  {
    type = "gun",
    name = "spidertron-rocket-launcher-4",
    localised_name = {"item-name.spidertron-rocket-launcher"},
    icon = "__base__/graphics/icons/rocket-launcher.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    hidden = true,
    order = "z[spider]-a[rocket-launcher]",
    attack_parameters =
    {
      type = "projectile",
       ammo_categories = rocketlauncher_ammo_categories,
      cooldown =  firerate_rocketlauncher_spidertron,
      range = range_rocketlauncher_spidertron,
      projectile_creation_distance = -0.5,
      projectile_center = {0, 0.3},
      projectile_orientation_offset = 0.0625,
      sound =
      {
        {
          filename = "__base__/sound/fight/rocket-launcher.ogg",
          volume = 0.7
        }
      }
    },
    stack_size = 1
  },
   -----------------------------  MINIGUN  -----------------------------
   {
    type = "gun",
    name = "mini-gun",
    icon = "__factorioplus__/graphics/icons/mini-gun.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "a[basic-clips]-c[submachine-gun]",
	
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "beltfed-bullet",
      cooldown =  firerate_minigun,
	  damage_modifier = damage_modifier_minigun,
      movement_slow_down_factor = 0.9,
	  --warmup = 60.0 * 1.0,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.03,
        speed = 0.2,
        speed_deviation = 0.02,
        center = {0, 0.1},
        creation_distance = -0.5,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.125,
      range = range_minigun,
      sound = 
	  {
		  {
			filename = "__base__/sound/fight/submachine-gunshot-1.ogg",
			volume = 0.6,
			speed = 1.9,
		  },
		  {
			filename = "__base__/sound/fight/submachine-gunshot-2.ogg",
			volume = 0.6,
			speed = 1.9,
		  },
		  {
			filename = "__base__/sound/fight/submachine-gunshot-3.ogg",
			volume = 0.6,
			speed = 1.9,
		  }
	  },
	  cyclic_sound =
	  {
	      begin_sound=
		  {
			filename = "__base__/sound/fight/gun-turret-activate-1.ogg",
			volume = 0.4
		  },
		  end_sound=
		   {
			filename = "__base__/sound/fight/gun-turret-deactivate-1.ogg",
			volume = 0.6
		  },
	  },
	 },
    stack_size = 1
  },
  
  })  

data:extend({
createnewrareweapon("mini-gun", "uncommon"),
createnewrareweapon("mini-gun", "rare"),
createnewrareweapon("mini-gun", "epic"),
createnewrareweapon("mini-gun", "legendary"),
})  

data:extend({

     -----------------------------  PLASMA GUN  -----------------------------
	 
  {
    type = "gun",
    name = "plasma-gun",
    icon = "__factorioplus__/graphics/icons/laser-gun.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "gun",
    order = "a[basic-clips]-c[submachine-gun]",
	
    attack_parameters =
    {
	  ammo_consumption_modifier = plasmagun_ammo_consumption_modifier,
      type = "projectile",
      ammo_category = "plasma-cell",
      cooldown =  firerate_plasmagun ,
	  damage_modifier = 1,
      movement_slow_down_factor = plasmagun_slow_down_factor,
	  movement_slow_down_cooldown = firerate_plasmagun / 2,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.05,
        speed = 0.2,
        speed_deviation = 0.02,
        center = {0, 0.1},
        creation_distance = -0.5,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.425,
      range = range_plasmagun,
      sound =
       {
         {
           filename = "__factorioplus__/sounds/plasma-blaster.ogg",
           volume = 0.85,
		   speed = 0.95
        },
		{
           filename = "__factorioplus__/sounds/plasma-blaster.ogg",
           volume = 0.82,
		   speed = 0.85
        },
		{
           filename = "__factorioplus__/sounds/plasma-blaster.ogg",
           volume = 0.89,
		   speed = 0.89
        }
      }
	 },
    stack_size = 5
  },

})