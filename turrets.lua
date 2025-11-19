local enemy_autoplace = require ("__base__.prototypes.entity.enemy-autoplace-utils")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local soundsnew = require("sounds")
local item_sounds = require("__base__.prototypes.item_sounds")

-- turret stats
require("stats")

local tank_shift_y = 6

local fireutil = require("__base__.prototypes.fire-util")	
local math3d = require "math3d" 

local mediumturretbase =
{
	{
		filename = "__factorioplus__/graphics/medium-turret-base.png",
		priority = "high",
		width = 282,
		height = 256,
		direction_count = 1,
		frame_count = 1,
		shift = util.by_pixel(-0.5, 2),
		scale = 0.35
	},
	{
		filename = "__factorioplus__/graphics/medium-turret-base-tint.png",
		line_length = 1,
		width = 282,
		height = 256,
		apply_runtime_tint = true,
		direction_count = 1,
		frame_count = 1,
		shift = util.by_pixel(-0.5, 2),
		scale = 0.35
	},
	{
		filename = "__factorioplus__/graphics/medium-turret-base-shadow.png",
		line_length = 1,
		width = 282,
		height = 256,
		draw_as_shadow = true,
		direction_count = 1,
		frame_count = 1,
		shift = util.by_pixel(0, 3),
		scale = 0.35
	}
}

---------------------------------------------------  VETERANCY ICONS  ------------------------------------------------------------

data:extend({ 
{
type = "simple-entity",
name = "icon-veterancy-1",
render_layer = "entity-info-icon",
collision_mask = {layers={}},
resistances = 
	{
	  {
		type = "fire",
		percent = 100
	  },
	  {
		type = "explosion",
		percent = 100
	  },
	  {
		type = "acid",
		percent = 100
	  },
	},
picture =
	{
	  filename = "__factorioplus__/graphics/icons/vet-1.png",
	  priority = "high",
	  blend_mode = "normal",
	  width = 64,
	  height = 64,
	  direction_count = 1,
	  frame_count = 1,
	  scale = 0.5,
	  shift = util.by_pixel(-16, -16),
    },
},
{
type = "simple-entity",
name = "icon-veterancy-2",
render_layer = "entity-info-icon",
collision_mask = {layers={}},
resistances = 
	{
	  {
		type = "fire",
		percent = 100
	  },
	  {
		type = "explosion",
		percent = 100
	  },
	  {
		type = "acid",
		percent = 100
	  },
	},
picture =
	{
	  filename = "__factorioplus__/graphics/icons/vet-2.png",
	  priority = "high",
	  blend_mode = "normal",
	  width = 64,
	  height = 64,
	  direction_count = 1,
	  frame_count = 1,
	  scale = 0.5,
	  shift = util.by_pixel(-16, -16),
    },
},
{
type = "simple-entity",
name = "icon-veterancy-3",
render_layer = "entity-info-icon",
collision_mask = {layers={}},
resistances = 
	{
	  {
		type = "fire",
		percent = 100
	  },
	  {
		type = "explosion",
		percent = 100
	  },
	  {
		type = "acid",
		percent = 100
	  },
	},
picture =
	{
	  filename = "__factorioplus__/graphics/icons/vet-3.png",
	  priority = "high",
	  blend_mode = "normal",
	  width = 64,
	  height = 64,
	  direction_count = 1,
	  frame_count = 1,
	  scale = 0.5,
	  shift = util.by_pixel(-16, -16),
    },
},
{
type = "simple-entity",
name = "icon-veterancy-4",
render_layer = "entity-info-icon",
collision_mask = {layers={}},
resistances = 
	{
	  {
		type = "fire",
		percent = 100
	  },
	  {
		type = "explosion",
		percent = 100
	  },
	  {
		type = "acid",
		percent = 100
	  },
	},
picture =
	{
	  filename = "__factorioplus__/graphics/icons/vet-4.png",
	  priority = "high",
	  blend_mode = "normal",
	  width = 64,
	  height = 64,
	  direction_count = 1,
	  frame_count = 1,
	  scale = 0.5,
	  shift = util.by_pixel(-16, -16),
    },
},
})

---------------------------------------------------  TURRET OVERRIDES  ------------------------------------------------------------

--------------------------------- ROCKET BATTERY --------------------------------
if (mods["space-age"]) then

	local _rocketbattery = util.copy(data.raw["ammo-turret"]["rocket-turret"])
	_rocketbattery.name = "rocket-battery" 
	_rocketbattery.minable.result = "rocket-battery" 
	_rocketbattery.placeable_by = {item = "rocket-battery" , count = 1}
	_rocketbattery.max_health = health_rocket_battery
	_rocketbattery.inventory_size = 4
	_rocketbattery.attack_parameters.cooldown = firerate_rocket_battery
	_rocketbattery.attack_parameters.range = range_rocket_battery
	_rocketbattery.attack_parameters.min_range = rangemin_rocket_battery
	_rocketbattery.attack_parameters.damage_modifier = 1.0	
	_rocketbattery.hide_resistances = false
	_rocketbattery.resistances =
    {
      {
        type = "fire",
        decrease = 2,
        percent = 20
      },
       {
        type = "physical",
        percent = 20
      },
      {
        type = "impact",
        decrease = 20,
        percent = 10
      },
      {
        type = "explosion",
        decrease = 25,
        percent = 60
      },
      {
        type = "acid",
		decrease = 2,
        percent = 50
      }
    },
	data:extend({_rocketbattery})
	
	data:extend
	({
		{
			type = "recipe",
			name = "rocket-battery" ,
			enabled = false,
			energy_required = 25,
			ingredients =
			{
				{type = "item", name = "rocket-turret", amount = 1},	
				{type = "item", name = "rocket-launcher", amount = 2},
				{type = "item", name = "processing-unit", amount = 4},
				{type = "item", name = "carbon-fiber", amount = 20},		
			},
			results = {{type="item", name="rocket-battery", amount=1}},
		},  	
	})
	
	 data.extend
	({
		{
			type = "item",
			name = "rocket-battery",
			icon = "__space-age__/graphics/icons/rocket-turret.png",
			icon_size = 64, icon_mipmaps = 4,
			subgroup = "turret",
			order = "b[turret]-cb[rocket-battery]",
			inventory_move_sound = item_sounds.turret_inventory_move,
			pick_sound = item_sounds.turret_inventory_pickup,
			drop_sound = item_sounds.turret_inventory_move,
			place_result = "rocket-battery",
			stack_size = 10,
			weight = 100*kg
		},
	}) 
end

--------------------------------- FLAME TURRET --------------------------------

function fireutil.flamethrower_turret_extension_animation(shft, opts)
  local m_line_length = 5
  local m_frame_count = 15
  local ret_layers =
  {
    -- diffuse
    {
        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-gun-extension.png",
        priority = "medium",
        frame_count = opts and opts.frame_count or m_frame_count,
        line_length = opts and opts.line_length or m_line_length,
        run_mode = opts and opts.run_mode or "forward",
        width = 152,
        height = 128,
        direction_count = 1,
        axially_symmetrical = false,
        shift = util.by_pixel(0, -26),
        scale = 0.5
    },
    -- mask
    {
        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-gun-extension-mask.png",
        flags = { "mask" },
        frame_count = opts and opts.frame_count or m_frame_count,
        line_length = opts and opts.line_length or m_line_length,
        run_mode = opts and opts.run_mode or "forward",
        width = 144,
        height = 120,
        direction_count = 1,
        axially_symmetrical = false,
        shift = util.by_pixel(0, -26),
        apply_runtime_tint = true,
        scale = 0.5
    },
    -- shadow
    {
        filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-gun-extension-shadow.png",
        frame_count = opts and opts.frame_count or m_frame_count,
        line_length = opts and opts.line_length or m_line_length,
        run_mode = opts and opts.run_mode or "forward",
        width = 180,
        height = 114,
        direction_count = 1,
        axially_symmetrical = false,
        shift = util.by_pixel(33, -1),
        draw_as_shadow = true,
        scale = 0.5
    }
  }

  local yoffsets = { north = 0, east = 3, south = 2, west = 1 }
  local m_lines = m_frame_count / m_line_length

  return { layers = fireutil.foreach(ret_layers, function(tab)
    if tab.shift then tab.shift = { tab.shift[1] + shft[1], tab.shift[2] + shft[2] } end
    if tab.height then tab.y = tab.height * m_lines * yoffsets[opts.direction] end
  end) }
end

fireutil.turret_gun_shift =
{
  north = util.by_pixel(0.0, -6.0),
  east = util.by_pixel(18.5, 9.5),
  south = util.by_pixel(0.0, 19.0),
  west = util.by_pixel(-12.0, 5.5)
}

fireutil.turret_model_info =
{
  tilt_pivot = { -1.68551, 0, 2.35439 },
  gun_tip_lowered = { 4.27735, 0, 3.97644 },
  gun_tip_raised = { 2.2515, 0, 7.10942 },
  units_per_tile = 4
}

fireutil.gun_center_base = math3d.vector2.sub({0,  -0.725}, fireutil.turret_gun_shift.south)

function fireutil.flamethrower_turret_preparing_muzzle_animation(opts)
  opts.frame_count = opts.frame_count or 15
  opts.run_mode = opts.run_mode or "forward"
  assert(opts.orientation_count)

  local model = fireutil.turret_model_info
  local angle_raised = -math3d.vector3.angle({1, 0, 0}, math3d.vector3.sub(model.gun_tip_raised, model.tilt_pivot))
  local angle_lowered = -math3d.vector3.angle({1, 0, 0}, math3d.vector3.sub(model.gun_tip_lowered, model.tilt_pivot))
  local delta_angle = angle_raised - angle_lowered

  local generated_orientations = {}
  for r = 0, opts.orientation_count-1 do
    local phi = (r / opts.orientation_count - 0.25) * math.pi * 2
    local generated_frames = {}
    for i = 0, opts.frame_count-1 do
      local k = opts.run_mode == "backward" and (opts.frame_count - i - 1) or i
      local progress = opts.progress or (k / (opts.frame_count - 1))

      local matrix = math3d.matrix4x4
      local mat = matrix.compose({
        matrix.translation_vec3(math3d.vector3.mul(model.tilt_pivot, -1)),
        matrix.rotation_y(progress * delta_angle),
        matrix.translation_vec3(model.tilt_pivot),
        matrix.rotation_z(phi),
        matrix.scale(1 / model.units_per_tile, 1 / model.units_per_tile, -1 / model.units_per_tile)
      })

      local vec = math3d.matrix4x4.mul_vec3(mat, model.gun_tip_lowered)
      table.insert(generated_frames, math3d.project_vec3(vec))
    end
    local direction_data = { frames = generated_frames }
    if (opts.layers and opts.layers[r]) then
      direction_data.render_layer = opts.layers[r]
    end
    table.insert(generated_orientations, direction_data)
  end

  return
  {
    rotations = generated_orientations,
    direction_shift = fireutil.turret_gun_shift
  }
end

function fireutil.flamethrower_turret_extension(opts)
  local set_direction = function (opts, dir)
    opts.direction = dir
    return opts
  end

  return
  {
    north = fireutil.flamethrower_turret_extension_animation(fireutil.turret_gun_shift.north, set_direction(opts, "north")),
    east = fireutil.flamethrower_turret_extension_animation(fireutil.turret_gun_shift.east, set_direction(opts, "east")),
    south = fireutil.flamethrower_turret_extension_animation(fireutil.turret_gun_shift.south, set_direction(opts, "south")),
    west = fireutil.flamethrower_turret_extension_animation(fireutil.turret_gun_shift.west, set_direction(opts, "west"))
  }
end

function fireutil.flamethrower_turret_prepared_animation(shft, opts)
  local diffuse_layer =
  {
      filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-gun.png",
      priority = "medium",
      counterclockwise = true,
      line_length = 8,
      width = 158,
      height = 128,
      frame_count = 1,
      axially_symmetrical = false,
      direction_count = 64,
      shift = util.by_pixel(-1, -25),
      scale = 0.5
  }
  local glow_layer =
  {

      filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-gun-active.png",
      counterclockwise = true,
      line_length = 8,
      width = 158,
      height = 126,
      frame_count = 1,
      axially_symmetrical = false,
      direction_count = 64,
      shift = util.by_pixel(-1, -25),
      tint = util.premul_color{1, 1, 1, 0.5},
      blend_mode = "additive",
      scale = 0.5

  }
  local mask_layer =
  {

      filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-gun-mask.png",
      flags = { "mask" },
      counterclockwise = true,
      line_length = 8,
      width = 144,
      height = 112,
      frame_count = 1,
      axially_symmetrical = false,
      direction_count = 64,
      shift = util.by_pixel(-1, -28),
      apply_runtime_tint = true,
      scale = 0.5

  }
  local shadow_layer =
  {

      filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-gun-shadow.png",
      counterclockwise = true,
      line_length = 8,
      width = 182,
      height = 116,
      frame_count = 1,
      axially_symmetrical = false,
      direction_count = 64,
      shift = util.by_pixel(31, -1),
      draw_as_shadow = true,
      scale = 0.5

  }

  local ret_layers = opts and opts.attacking and { diffuse_layer, glow_layer, mask_layer, shadow_layer }
                                             or  { diffuse_layer, mask_layer, shadow_layer }

  return { layers = fireutil.foreach(ret_layers, function(tab)
    if tab.shift then tab.shift = { tab.shift[1] + shft[1], tab.shift[2] + shft[2] } end
  end) }
end

function fireutil.flamethrower_prepared_animation(opts)
  return
  {
    north = fireutil.flamethrower_turret_prepared_animation(fireutil.turret_gun_shift.north, opts),
    east = fireutil.flamethrower_turret_prepared_animation(fireutil.turret_gun_shift.east, opts),
    south = fireutil.flamethrower_turret_prepared_animation(fireutil.turret_gun_shift.south, opts),
    west = fireutil.flamethrower_turret_prepared_animation(fireutil.turret_gun_shift.west, opts)
  }
end

local function set_shift(shift, tab)
  tab.shift = shift
  if tab.hr_version then
    tab.hr_version.shift = shift
  end
  return tab
end

function fireutil.flamethrower_turret_pipepictures()
  local pipe_sprites = pipepictures()

  return
  {
    north = set_shift({0, 1}, util.table.deepcopy(pipe_sprites.straight_vertical)),
    south = set_shift({0, -1}, util.table.deepcopy(pipe_sprites.straight_vertical)),
    east = set_shift({-1, 0}, util.table.deepcopy(pipe_sprites.straight_horizontal)),
    west = set_shift({1, 0}, util.table.deepcopy(pipe_sprites.straight_horizontal))
  }
end

local indicator_pictures =
{
  north =
  {

      filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-led-indicator-north.png",
      line_length = 2,
      width = 10,
      height = 18,
      frame_count = 2,
      axially_symmetrical = false,
      direction_count = 1,
      shift = util.by_pixel(7, 20),
      scale = 0.5

  },
  east =
  {

      filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-led-indicator-east.png",
      line_length = 2,
      width = 18,
      height = 8,
      frame_count = 2,
      axially_symmetrical = false,
      direction_count = 1,
      shift = util.by_pixel(-33, -5),
      scale = 0.5

  },
  south =
  {
  
      filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-led-indicator-south.png",
      line_length = 2,
      width = 8,
      height = 18,
      frame_count = 2,
      axially_symmetrical = false,
      direction_count = 1,
      shift = util.by_pixel(-8, -45),
      scale = 0.5

  },
  west =
  {

      filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-led-indicator-west.png",
      line_length = 2,
      width = 20,
      height = 10,
      frame_count = 2,
      axially_symmetrical = false,
      direction_count = 1,
      shift = util.by_pixel(32, -20),
      scale = 0.5

  }
}

data:extend({
  {
    type = "fluid-turret",
    name = "flamethrower-turret",
	placeable_by = {item = "flamethrower-turret", count = 1},
    icon = "__base__/graphics/icons/flamethrower-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "flamethrower-turret"},
    max_health = health_turret_flamethrower,
    corpse = "flamethrower-turret-remnants",
    collision_box = {{-0.7, -1.2 }, {0.7, 1.2}},
    selection_box = {{-1, -1.5 }, {1, 1.5}},
    rotation_speed = 0.015,
    preparing_speed = 0.08,
    preparing_sound = sounds.flamethrower_turret_activate,
    folding_sound = sounds.flamethrower_turret_deactivate,
    folding_speed = 0.08,
    attacking_speed = 1,
    ending_attack_speed = 0.2,
    dying_explosion = "medium-explosion",
    turret_base_has_direction = true,
    hide_resistances = false,
    resistances =
    {
      {
        type = "fire",
        percent = 100
      }
    },

    fluid_box =
    {
      production_type = "none", -- FluidTurret has its own logic
      secondary_draw_order = 0,
      render_layer = "lower-object",
      --pipe_picture = fireutil.flamethrower_turret_pipepictures(),
      pipe_covers = pipecoverspictures(),
      volume = 100,
      pipe_connections =
      {
        { direction = defines.direction.west, position = {-0.5, 1.0} },
        { direction = defines.direction.east, position = {0.5, 1.0} }
      }
    },
    fluid_buffer_size = 100,
    fluid_buffer_input_flow = 250 / 60 / 5, -- 5s to fill the buffer
    activation_buffer_ratio = 0.25,

    folded_animation = fireutil.flamethrower_turret_extension({frame_count = 1, line_length = 1}),

    preparing_animation = fireutil.flamethrower_turret_extension({}),
    prepared_animation = fireutil.flamethrower_prepared_animation(),
    attacking_animation = fireutil.flamethrower_prepared_animation({attacking = true}),
    ending_attack_animation = fireutil.flamethrower_prepared_animation({attacking = true}),

    folding_animation = fireutil.flamethrower_turret_extension({ run_mode = "backward" }),

    not_enough_fuel_indicator_picture = indicator_pictures,
    enough_fuel_indicator_picture = fireutil.foreach(util.table.deepcopy(indicator_pictures), function (tab) tab.x = tab.width end),
    out_of_ammo_alert_icon =
    {
      filename = "__core__/graphics/icons/alerts/fuel-icon-red.png",
      priority = "extra-high-no-scale",
      width = 64,
      height = 64,
      flags = {"icon"}
    },
    indicator_light = { intensity = 0.8, size = 0.9 },

    gun_animation_render_layer = "object",
    gun_animation_secondary_draw_order = 1,
    base_picture_render_layer = "lower-object-above-shadow",
    base_picture_secondary_draw_order = 1,
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
          -- diffuse
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-north.png",
              line_length = 1,
              width = 158,
              height = 196,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-1, 13),
              scale = 0.5

          },
          -- mask
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-north-mask.png",
              flags = { "mask" },
              line_length = 1,
              width = 74,
              height = 70,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-1, 33),
              apply_runtime_tint = true,
              scale = 0.5

          },
          -- shadow
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-north-shadow.png",
              draw_as_shadow = true,
              line_length = 1,
              width = 134,
              height = 152,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(3, 15),
              scale = 0.5

          }
        }
      },
      east =
      {
        layers =
        {
          -- diffuse
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-east.png",
              line_length = 1,
              width = 216,
              height = 146,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-6, 3),
              scale = 0.5

          },
          -- mask
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-east-mask.png",
              flags = { "mask" },
              apply_runtime_tint = true,
              line_length = 1,
              width = 66,
              height = 82,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(-33, 1),
              scale = 0.5

          },
          -- shadow
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-east-shadow.png",
              draw_as_shadow = true,
              line_length = 1,
              width = 144,
              height = 86,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(14, 9),
              scale = 0.5

          }
        }
      },
      south =
      {
        layers =
        {
          -- diffuse
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-south.png",
              line_length = 1,
              width = 128,
              height = 166,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(0, -8),
              scale = 0.5

          },
          -- mask
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-south-mask.png",
              flags = { "mask" },
              apply_runtime_tint = true,
              line_length = 1,
              width = 72,
              height = 72,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(0, -31),
              scale = 0.5

          },
          -- shadow
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-south-shadow.png",
              draw_as_shadow = true,
              line_length = 1,
              width = 134,
              height = 98,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(3, 9),
              scale = 0.5

          }
        }

      },
      west =
      {
        layers =
        {
          -- diffuse
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-west.png",
              line_length = 1,
              width = 208,
              height = 144,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(7, -1),
              scale = 0.5

          },
          -- mask
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-west-mask.png",
              flags = { "mask" },
              apply_runtime_tint = true,
              line_length = 1,
              width = 64,
              height = 74,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(32, -1),
              scale = 0.5

          },
          -- shadow
          {

              filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-base-west-shadow.png",
              draw_as_shadow = true,
              line_length = 1,
              width = 206,
              height = 88,
              frame_count = 1,
              axially_symmetrical = false,
              direction_count = 1,
              shift = util.by_pixel(15, 4),
              scale = 0.5

          }
        }
      }
    },
	 },
	  },

    muzzle_animation = util.draw_as_glow
    {
      filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-muzzle-fire.png",
      line_length = 8,
      width = 16,
      height = 30,
      frame_count = 32,
      blend_mode = "additive",
      scale = 0.45,
      shift = {0.015625 * 0.5, -0.546875 * 0.5 + 0.05}
    },
    muzzle_light = {intensity = 0.7, size = 3},

    folded_muzzle_animation_shift          = fireutil.flamethrower_turret_preparing_muzzle_animation{ frame_count = 1,  orientation_count = 4, progress = 0, layers = {[0] = "object"} },
    preparing_muzzle_animation_shift       = fireutil.flamethrower_turret_preparing_muzzle_animation{ frame_count = 15, orientation_count = 4, layers = {[0] = "object"} },
    prepared_muzzle_animation_shift        = fireutil.flamethrower_turret_preparing_muzzle_animation{ frame_count = 1, orientation_count =  64, progress = 1},
    --starting_attack_muzzle_animation_shift = fireutil.flamethrower_turret_preparing_muzzle_animation{ frame_count = 1,  orientation_count = 64, progress = 1},
    attacking_muzzle_animation_shift       = fireutil.flamethrower_turret_preparing_muzzle_animation{ frame_count = 1,  orientation_count = 64, progress = 1},
    ending_attack_muzzle_animation_shift   = fireutil.flamethrower_turret_preparing_muzzle_animation{ frame_count = 1,  orientation_count = 64, progress = 1},
    folding_muzzle_animation_shift         = fireutil.flamethrower_turret_preparing_muzzle_animation{ frame_count = 15, orientation_count = 4, run_mode = "backward", layers = {[0] = "object"}},

    vehicle_impact_sound = sounds.generic_impact,

    prepare_range = 35,
    shoot_in_prepare_state = false,
    attack_parameters =
    {
      type = "stream",
      cooldown = firerate_turret_flamethrower,
      range = range_turret_flamethrower,
      min_range = 6,
	  damage_modifier = 1,
		
      turn_range = 1.0 / 3.0,
      fire_penalty = 15,

      -- lead_target_for_projectile_speed = 0.2* 0.75 * 1.5, -- this is same as particle horizontal speed of flamethrower fire stream

      fluids =
      {
        {type = "crude-oil"},
        {type = "heavy-oil", damage_modifier = 1.1},
        {type = "light-oil", damage_modifier = 1.2},
		{type = "natural-gas", damage_modifier = 0.5}
      },
      fluid_consumption = 0.2,

      gun_center_shift =
      {
        north = math3d.vector2.add(fireutil.gun_center_base, fireutil.turret_gun_shift.north),
        east = math3d.vector2.add(fireutil.gun_center_base, fireutil.turret_gun_shift.east),
        south = math3d.vector2.add(fireutil.gun_center_base, fireutil.turret_gun_shift.south),
        west = math3d.vector2.add(fireutil.gun_center_base, fireutil.turret_gun_shift.west)
      },
      gun_barrel_length = 0.4,
	  ammo_category = "flamethrower",

      ammo_type =
      {
        category = "flamethrower",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "stream",
            stream = "flamethrower-fire-stream",
            source_offset = {0.15, -0.5}
          }
        }
      },

      cyclic_sound =
      {
        begin_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-1.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-2.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-3.ogg",
            volume = 0.5
          }
        },
        middle_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-1.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-2.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-3.ogg",
            volume = 0.5
          }
        },
        end_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-1.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-2.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-3.ogg",
            volume = 0.5
          }
        }
      }
    }, -- {0,  0.625}
    call_for_help_radius = 40
  }
})

--------------------------------- CANNON TURRET --------------------------------

function cannon_turret_extension(inputs)
return
{

    filename = "__base__/graphics/entity/tank/tank-turret.png",
    priority = "medium",
	width = 179,
	height = 132,
    direction_count = 8,
    frame_count = 1,
    line_length = 0,
    run_mode = inputs.run_mode or "forward",
    shift = util.by_pixel(2.25-2, -40.5 + tank_shift_y),
    axially_symmetrical = false,
    scale = 0.7

}
end

function cannon_turret_extension_mask(inputs)
return
{

    filename = "__base__/graphics/entity/tank/tank-turret-mask.png",
    flags = { "mask" },
    width = 72,
    height = 66,
    direction_count = 8,
    frame_count = 1,
    line_length = 0,
    run_mode = inputs.run_mode or "forward",
    shift = util.by_pixel(0, -36),
    axially_symmetrical = false,
    apply_runtime_tint = true,
    scale =  0.7

}
end

function cannon_turret_extension_shadow(inputs)
return
{

    filename = "__base__/graphics/entity/tank/tank-turret-shadow.png",
    width = 193,
            height = 134,
    direction_count = 8,
    frame_count = 1,
    line_length = 0,
    run_mode = inputs.run_mode or "forward",
    shift = util.by_pixel(19, 2.5),
    axially_symmetrical = false,
    draw_as_shadow = true,
    scale =  0.7

}
end

function cannon_turret_attack(inputs)
return
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
            shift = util.by_pixel(2.25-2, -40.5 + tank_shift_y),
            animation_speed = 8,
            scale = 0.7

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
            shift = util.by_pixel(2-2, -36),
            scale = 0.7

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
            scale = 0.7
        }
  }
}
end

data:extend({
{
    type = "ammo-turret",
    name = "cannon-turret",
	placeable_by = {item = "cannon-turret", count = 1},
    icon = "__base__/graphics/icons/tank-cannon.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation","building-direction-8-way"},
    minable = {mining_time = 1.5, result = "cannon-turret"},
    max_health = health_turret_cannon,
	hide_resistances = false,
	resistances =
    {
      {
        type = "fire",
        decrease = 15,
        percent = 30
      },
      {
        type = "physical",
        decrease = 5,
        percent = 40
      },
      {
        type = "impact",
        decrease = 50,
        percent = 40
      },
      {
        type = "explosion",
        decrease = 25,
        percent = 60
      },
      {
        type = "acid",
		decrease = 2,
        percent = 50
      }
    },
    corpse = "gun-turret-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = {{-1.9, -1.9 }, {1.9, 1.9}},
    selection_box = {{-1.8, -1.8 }, {1.8, 1.8}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.02,
    preparing_speed = 0.5,
    preparing_sound = sounds.cannon_turret_activate,
    folding_sound = sounds.cannon_turret_deactivate,
    folding_speed = 0.5,
    inventory_size = 2,
    automated_ammo_count = 10,
    attacking_speed = 50,
    alert_when_attacking = true,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
	turret_base_has_direction = true,
	graphics_set = {},
    folded_animation =
    {
      layers =
      {
        cannon_turret_extension{frame_count=1, line_length = 1},
        cannon_turret_extension_mask{frame_count=1, line_length = 1},
        cannon_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        cannon_turret_extension{},
        cannon_turret_extension_mask{},
        cannon_turret_extension_shadow{}
      }
    },
    prepared_animation = cannon_turret_attack{frame_count=1},
    attacking_animation = cannon_turret_attack{},
    folding_animation =
    {
      layers =
      {
        cannon_turret_extension{run_mode = "backward"},
        cannon_turret_extension_mask{run_mode = "backward"},
        cannon_turret_extension_shadow{run_mode = "backward"}
      }
    },
  graphics_set =
    {
      base_visualisation =
      {
        animation =
        {
      layers =
      {
        {
            filename = "__base__/graphics/entity/gun-turret/gun-turret-base.png",
            priority = "high",
            width = 150,
            height = 118,
            axially_symmetrical = false,
            direction_count = 1,
            frame_count = 1,
            shift = util.by_pixel(0.5, -1),
            scale = 1
        },
        {

            filename = "__base__/graphics/entity/gun-turret/gun-turret-base-mask.png",
            flags = { "mask", "low-object" },
            line_length = 1,
            width = 122,
            height = 102,
            axially_symmetrical = false,
            direction_count = 1,
            frame_count = 1,
            shift = util.by_pixel(0, -8),
            apply_runtime_tint = true,
            scale = 1

        }

      }
    },
	},
	},
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "projectile",
      ammo_category = "cannon-shell",
      cooldown = firerate_turret_cannon,
	  rotate_penalty = 2,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = -2, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
      projectile_creation_distance = 1.39375,
      projectile_center = {0, -0.1375}, -- same as cannon_turret_attack shift
	  turn_range = 0.25,
	  damage_modifier = 1,
	  lead_target_for_projectile_speed = 1,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {-0.0625, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      range = range_turret_cannon,
      min_range = rangemin_turret_cannon,
      sound = {
  {
    filename = "__base__/sound/fight/tank-cannon-1.ogg",
    volume = 0.8,
	speed = 0.7
  },
  {
    filename = "__base__/sound/fight/tank-cannon-2.ogg",
    volume = 0.8,
	speed = 0.7
  },
  {
    filename = "__base__/sound/fight/tank-cannon-3.ogg",
    volume = 0.8,
	speed = 0.7
  },
  {
    filename = "__base__/sound/fight/tank-cannon-4.ogg",
    volume = 0.8,
	speed = 0.7
  },
  {
    filename = "__base__/sound/fight/tank-cannon-5.ogg",
    volume = 0.8,
	speed = 0.7
  }

},
    },

    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 2,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
  })


------------------------------------------------
---------------- PISTOL TURRET ---------------------
------------------------------------------------
  
  
  function pistol_turret_extension(inputs)
return
{
  filename = "__factorioplus__/graphics/pistol-turret/pistol-turret.png",
  priority = "medium",
  width = 64,
  height = 44,
  direction_count = 16,
  frame_count = 1,
  line_length = 4,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(0+2, -18),
  axially_symmetrical = false,
  animation_speed = 8,
  scale = 0.5,
}
end

--- TODO needs a proper image
function pistol_turret_extension_shadow(inputs)
return
{
   filename = "__factorioplus__/graphics/pistol-turret/pistol-turret.png",
          priority = "low",
          line_length = 4,
          width = 1,
          height = 1,
          frame_count = 1,
          draw_as_shadow = true,
          direction_count = 64,
          shift = {0.875, 0.359375}
}
end

function pistol_turret_attack(inputs)
return
{
  layers =
  {
	  {
		 filename = "__factorioplus__/graphics/pistol-turret/pistol-turret.png",
		  priority = "medium",
		  width = 64,
		  height = 44,
		  direction_count = 16,
		  frame_count = 1,
		  line_length = 4,
		  run_mode = inputs.run_mode or "forward",
		  shift = util.by_pixel(0+2, -18),
		  axially_symmetrical = false,
		  animation_speed = 8,
		  scale = 0.5,
	},
    {
         filename = "__base__/graphics/entity/car/car-turret-shadow.png",
          priority = "low",
          line_length = 8,
          width = 1,
          height = 1,
          frame_count = 1,
          draw_as_shadow = true,
          direction_count = 64,
          shift = {0.875, 0.359375}
    },
  },
}
end

data:extend({ 
  {
    type = "ammo-turret",
    name = "pistol-turret",
	placeable_by = {item = "pistol-turret", count = 1},
    icon = "__factorioplus__/graphics/icons/pistol-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.25, result = "pistol-turret"},
    max_health = health_turret_pistol,
	hide_resistances = false,
	resistances =
    {
      {
        type = "fire",
        decrease = 2,
        percent = 20
      },
       {
        type = "physical",
        percent = 20
      },
      {
        type = "impact",
        decrease = 20,
        percent = 10
      },
      {
        type = "explosion",
        decrease = 15,
        percent = 10
      },
      {
        type = "acid",
		decrease = 2,
        percent = 50
      }
    },
    corpse = "small-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
    selection_box = {{-1, -1 }, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.03,
    preparing_speed = 0.3,
    preparing_sound = sounds.gun_turret_activate,
    folding_sound = sounds.gun_turret_deactivate,
    folding_speed = 0.3,
    inventory_size = 1,
    automated_ammo_count = 2,
    attacking_speed = 0.3,
    alert_when_attacking = true,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,

    folded_animation =
    {
      layers =
      {
        pistol_turret_extension{frame_count=1, line_length = 1},
        pistol_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        pistol_turret_extension{},
        pistol_turret_extension_shadow{}
      }
    },
    prepared_animation = pistol_turret_attack{frame_count=1},
    attacking_animation = pistol_turret_attack{},
    folding_animation =
    {
      layers =
      {
        pistol_turret_extension{run_mode = "backward"},
        pistol_turret_extension_shadow{run_mode = "backward"}
      }
    },
	
	  graphics_set =
    {
      base_visualisation =
      {
        animation =
		{
      layers =
      {
        {
          filename = "__factorioplus__/graphics/pistol-turret/pistolturret-base.png",
          priority = "high",
          width = 140,
          height = 103,
          direction_count = 1,
          frame_count = 1,
          shift = util.by_pixel(0, 2),
		  scale = 0.5,
        },
        {
          filename = "__factorioplus__/graphics/pistol-turret/pistolturret-base-shadow.png",
          line_length = 1,
          width = 140,
          height = 103,
          draw_as_shadow = true,
          direction_count = 1,
          frame_count = 1,
          shift = util.by_pixel(0, 2),
		  scale = 0.5,
        }
      }
    },
	},
	},
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = firerate_turret_pistol,  
	  rotate_penalty = 0.0,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = 0.5, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
      projectile_creation_distance = 1,
      projectile_center = {0, -0.0875}, -- same as gun_turret_attack shift
	  damage_modifier = 1.0,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {-0.0625, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      range = range_turret_pistol,
      sound = soundsnew.turret_pistol,
    },
	icon_draw_specification = { scale = 0.65},
    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
})
 
---------------- GUN TURRET ---------------------

-- function gun_turret_extension(inputs)
-- return
-- {
	 -- layers =
	-- {
			-- filename = "__factorioplus__/graphics/smg-turret/smg-turret.png",
			-- priority = "low",
			-- width = 912/8,
			-- height = 832/8,
			-- frame_count = 1,
			-- line_length = 8,
			-- axially_symmetrical = false,
			-- direction_count = 8,
			-- shift = util.by_pixel(0+2, -33.5+8.5),
			-- scale = 0.5,
	-- },
	-- {
			-- filename = "__factorioplus__/graphics/smg-turret/smg-turret-mask.png",
			-- priority = "low",
			-- width = 912/8,
			-- height = 832/8,
			-- frame_count = 1,
			-- line_length = 8,
			-- axially_symmetrical = false,
			-- direction_count = 8,
			-- apply_runtime_tint = true,
			-- shift = util.by_pixel(0+2, -33.5+8.5),
			-- scale = 0.5,
	-- },
-- }
-- end

-- function gun_turret_extension_shadow(inputs)
-- return
-- {
   -- filename = "__base__/graphics/entity/car/car-turret-shadow.png",
          -- priority = "low",
          -- line_length = 8,
          -- width = 46,
          -- height = 31,
          -- frame_count = 1,
          -- draw_as_shadow = true,
          -- direction_count = 64,
          -- shift = {0.875, 0.359375}
-- }
-- end

-- function gun_turret_attack(inputs)
-- return
-- {
  -- layers =
  -- {
	  -- {

			-- priority = "low",
			-- width = 71,
			-- height = 57,
			-- frame_count = 1,
			-- axially_symmetrical = false,
			-- direction_count = 64,
			-- shift = util.by_pixel(0+2, -33.5+8.5),
			-- animation_speed = 8,
			-- scale = 0.5,
			-- stripes =
			-- {
				-- {
				-- filename = "__factorioplus__/graphics/smg-turret/smg-turret.png",
				-- width_in_frames = 8,
				-- height_in_frames = 8
			  -- },
			-- }
	-- },
    -- {
         -- filename = "__base__/graphics/entity/car/car-turret-shadow.png",
          -- priority = "low",
          -- line_length = 8,
          -- width = 46,
          -- height = 31,
          -- frame_count = 1,
          -- draw_as_shadow = true,
          -- direction_count = 64,
          -- shift = {0.875, 0.359375}
    -- }
  -- }
-- }
-- end

local gun_turret_scale = 0.5
local gun_turret_xy = {912/8, 832/8}
local gun_turret_shift_xy = {0, -19 }

function gun_turret_extension(inputs)
return
{
  filename = "__factorioplus__/graphics/smg-turret/smg-turret.png",
  priority = "medium",
  width = gun_turret_xy[1],
  height = gun_turret_xy[2],
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(table.unpack(gun_turret_shift_xy) ),
  axially_symmetrical = false,
  scale =  gun_turret_scale,
}
end

function gun_turret_extension_mask(inputs)
return
{
  filename = "__factorioplus__/graphics/smg-turret/smg-turret-mask.png",
  flags = { "mask" },
  width = gun_turret_xy[1],
  height = gun_turret_xy[2],
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(table.unpack(gun_turret_shift_xy) ),
  axially_symmetrical = false,
  apply_runtime_tint = true,
  scale =  gun_turret_scale,
}
end

function gun_turret_extension_shadow(inputs)
return
{
  filename = "__base__/graphics/entity/tank/tank-turret-shadow.png",
  width = 1,
  height = 1,
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(19, 2),
  axially_symmetrical = false,
  draw_as_shadow = true,
  scale =  gun_turret_scale,
}
end

function gun_turret_attack(inputs)
return
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
		  scale =  gun_turret_scale,
		},
		{
		  filename ="__factorioplus__/graphics/smg-turret/smg-turret-mask.png",
		  flags = { "mask" },
			width = gun_turret_xy[1],
			height = gun_turret_xy[2],
		  direction_count = 64,
		  frame_count = 1,
		  line_length = 8,
		  run_mode = inputs.run_mode or "forward",
		  shift = util.by_pixel(table.unpack(gun_turret_shift_xy) ),
		  axially_symmetrical = false,
		  apply_runtime_tint = true,
		  scale =  gun_turret_scale,
		},
  }
}
end

data:extend({ 
  {
    type = "ammo-turret",
    name = "gun-turret",
	placeable_by = {item = "gun-turret", count = 1},
    icon = "__factorioplus__/graphics/icons/gun-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "player-creation"},
    minable = {mining_time = 0.5, result = "gun-turret"},
	-- subgroup="enemies",
    max_health = health_turret_smg,
	hide_resistances = false,
	resistances =
    {
      {
        type = "fire",
        decrease = 2,
        percent = 20
      },
       {
        type = "physical",
        percent = 20
      },
      {
        type = "impact",
        decrease = 20,
        percent = 10
      },
      {
        type = "explosion",
        decrease = 15,
        percent = 10
      },
       {
        type = "acid",
		decrease = 2,
        percent = 50
      },
    },
    corpse = "small-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
    selection_box = {{-1, -1 }, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.04,
    preparing_speed = 0.5,
    preparing_sound = sounds.gun_turret_activate,
    folding_sound = sounds.gun_turret_deactivate,
    folding_speed = 0.5,
    inventory_size = 1,
    automated_ammo_count = 10,
    attacking_speed = 0.5,
    alert_when_attacking = true,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    folded_animation =
    {
      layers =
      {
        gun_turret_extension{frame_count=1, line_length = 1},
		gun_turret_extension_mask{frame_count=1, line_length = 1},
        gun_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        gun_turret_extension{},
		gun_turret_extension_mask{},
        gun_turret_extension_shadow{}
      }
    },
    prepared_animation = gun_turret_attack{frame_count=1},
    attacking_animation = gun_turret_attack{},
    folding_animation =
    {
      layers =
      {
        gun_turret_extension{run_mode = "backward"},
		gun_turret_extension_mask{run_mode = "backward"},
        gun_turret_extension_shadow{run_mode = "backward"}
      }
    },
	graphics_set =
    {
		base_visualisation =
		{
		 animation =
        {
		  layers =
		  {
			{
				filename = "__base__/graphics/entity/laser-turret/laser-turret-base.png",
				priority = "high",
				width = 138,
				height = 104,
				direction_count = 1,
				frame_count = 1,
				shift = util.by_pixel(-0.5, 2),
				scale = 0.5
			},
			{
				filename = "__base__/graphics/entity/laser-turret/laser-turret-base-shadow.png",
				line_length = 1,
				width = 132,
				height = 82,
				draw_as_shadow = true,
				direction_count = 1,
				frame_count = 1,
				shift = util.by_pixel(6, 3),
				scale = 0.5
			}
		  }
		},
		},
	},
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = firerate_turret_smg,  
	  rotate_penalty = 0.0,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = 0.5, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
      projectile_creation_distance = 0.9375,
      projectile_center = {0, -0.0675}, -- same as gun_turret_attack shift
	  projectile_creation_offsets = {{-0.15,0}}, 
	  damage_modifier = 1.0,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {-0.0625, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      range = range_turret_smg,
      sound = soundsnew.gun_turret_gunshot_light,
    },

	icon_draw_specification = { scale = 0.75},
    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },

})

---------------------------------------- HEAVY GUN TURRET ----------------------------------------

  
local twingun_turret_scale = 0.6
local twingun_turret_xy = {1216/8, 1112/8}
local twingun_turret_shift_xy = {0, -32 }

function heavygun_turret_extension(inputs)
return
{
  filename = "__factorioplus__/graphics/smg-turret/smg-turret-heavy.png",
  priority = "medium",
  width = twingun_turret_xy[1],
  height = twingun_turret_xy[2],
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(table.unpack(twingun_turret_shift_xy) ),
  axially_symmetrical = false,
  scale =  twingun_turret_scale,
}
end

function heavygun_turret_extension_mask(inputs)
return
{
  filename = "__factorioplus__/graphics/smg-turret/smg-turret-heavy-mask.png",
  flags = { "mask" },
  width = twingun_turret_xy[1],
  height = twingun_turret_xy[2],
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(table.unpack(twingun_turret_shift_xy) ),
  axially_symmetrical = false,
  apply_runtime_tint = true,
  scale =  twingun_turret_scale,
}
end

function heavygun_turret_extension_shadow(inputs)
return
{
  filename = "__base__/graphics/entity/tank/tank-turret-shadow.png",
  width = 1,
  height = 1,
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(19, 2),
  axially_symmetrical = false,
  draw_as_shadow = true,
  scale =  twingun_turret_scale,
}
end

function heavygun_turret_attack(inputs)
return
{
  layers =
  {
   
		{
          filename = "__factorioplus__/graphics/smg-turret/smg-turret-heavy.png",
          priority = "low",
          line_length = 8,
			width = twingun_turret_xy[1],
			height = twingun_turret_xy[2],
          frame_count = 1,
          direction_count = 64,
          shift = util.by_pixel(table.unpack(twingun_turret_shift_xy) ),
          animation_speed = 8,
		  scale =  twingun_turret_scale,
		},
		{
		  filename ="__factorioplus__/graphics/smg-turret/smg-turret-heavy-mask.png",
		  flags = { "mask" },
			width = twingun_turret_xy[1],
			height = twingun_turret_xy[2],
		  direction_count = 64,
		  frame_count = 1,
		  line_length = 8,
		  run_mode = inputs.run_mode or "forward",
		  shift = util.by_pixel(table.unpack(twingun_turret_shift_xy) ),
		  axially_symmetrical = false,
		  apply_runtime_tint = true,
		  scale =  twingun_turret_scale,
		},
  }
}
end

data:extend({ 
  {
    type = "ammo-turret",
    name = "heavygun-turret",
	placeable_by = {item = "heavygun-turret", count = 1},
    icon = "__factorioplus__/graphics/icons/heavy-gun-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "player-creation"},
    minable = {mining_time = 0.75, result = "heavygun-turret"},
	-- subgroup="enemies",
    max_health = health_turret_heavysmg,
	hide_resistances = false,
	resistances =
    {
      {
        type = "fire",
        decrease = 5,
        percent = 30
      },
       {
        type = "physical",
        percent = 30
      },
      {
        type = "impact",
        decrease = 30,
        percent = 10
      },
      {
        type = "explosion",
        decrease = 15,
        percent = 30
      },
	   {
        type = "acid",
		decrease = 2,
        percent = 50
      },
    },
    corpse = "medium-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = {{-1.2, -1.2 }, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5 }, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.03,
    preparing_speed = 0.5,
    preparing_sound = sounds.gun_turret_activate,
    folding_sound = sounds.gun_turret_deactivate,
    folding_speed = 0.5,
    inventory_size = 2,
    automated_ammo_count = 20,
    attacking_speed = 0.5,
    alert_when_attacking = true,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    folded_animation =
    {
      layers =
      {
        heavygun_turret_extension{frame_count=1, line_length = 1},
		heavygun_turret_extension_mask{frame_count=1, line_length = 1},
        heavygun_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        heavygun_turret_extension{},
		heavygun_turret_extension_mask{},
        heavygun_turret_extension_shadow{}
      }
    },
    prepared_animation = heavygun_turret_attack{frame_count=1},
    attacking_animation = heavygun_turret_attack{},
    folding_animation =
    {
      layers =
      {
        heavygun_turret_extension{run_mode = "backward"},
		heavygun_turret_extension_mask{run_mode = "backward"},
        heavygun_turret_extension_shadow{run_mode = "backward"}
      }
    },
	graphics_set =
    {
		base_visualisation =
		{
		 animation =
        {
		  layers = mediumturretbase,
		},
		},
	},
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = firerate_turret_heavysmg,  
	  rotate_penalty = 0.0,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = 0.5, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
      projectile_creation_distance = 1.2,
      projectile_center = {0, -0.1275}, -- same as gun_turret_attack shift
	  projectile_creation_offsets = {{-0.25,0 },{0.25,0 }}, 
	  damage_modifier = damagemodifier_turret_heavysmg,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.2,
        speed_deviation = 0.05,
        center = {-0.0625, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      range = math.ceil(range_turret_heavysmg),
      sound = soundsnew.gun_turret_gunshot_heavy,
    },

    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 6,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },

})

---------------------------------------- SHOTGUN TURRET ----------------------------------------
shotgun_turret_scale = 0.4

function shotgun_turret_extension(inputs)
return
{
  filename = "__factorioplus__/graphics/shotgun-turret/shotgun-turret.png",
  priority = "medium",
  width = 1328/8,
  height = 1208/8,
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(2-2, -16 ),
  axially_symmetrical = false,
  scale =  shotgun_turret_scale,
}
end

function shotgun_turret_extension_mask(inputs)
return
{
  filename = "__factorioplus__/graphics/shotgun-turret/shotgun-turret-mask.png",
  flags = { "mask" },
  width = 1328/8,
  height = 1208/8,
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(2-2, -16 ),
  axially_symmetrical = false,
  apply_runtime_tint = true,
  scale =  shotgun_turret_scale,
}
end

function shotgun_turret_extension_shadow(inputs)
return
{
  filename = "__factorioplus__/graphics/shotgun-turret/shotgun-turret-shadow.png",
  width = 1328/8,
  height = 1208/8,
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(19, 2),
  axially_symmetrical = false,
  draw_as_shadow = true,
  scale =  shotgun_turret_scale,
}
end

function shotgun_turret_attack(inputs)
return
{
  layers =
  {
   
		{
          filename = "__factorioplus__/graphics/shotgun-turret/shotgun-turret.png",
          priority = "low",
          line_length = 8,
		width = 1328/8,
		height = 1208/8,
          frame_count = 1,
          direction_count = 64,
          shift = util.by_pixel(2-2, -16 ),
          animation_speed = 8,
		  scale =  shotgun_turret_scale,
		},
		{
		  filename = "__factorioplus__/graphics/shotgun-turret/shotgun-turret-mask.png",
			flags = { "mask" },
			width = 1328/8,
			height = 1208/8,
		  direction_count = 64,
		  frame_count = 1,
		  line_length = 8,
		  run_mode = inputs.run_mode or "forward",
		  shift = util.by_pixel(2-2, -16 ),
		  axially_symmetrical = false,
		  apply_runtime_tint = true,
		  scale =  shotgun_turret_scale,
		},
		{
		  filename = "__factorioplus__/graphics/shotgun-turret/shotgun-turret-shadow.png",
		  width = 1328/8,
		  height = 1208/8,
		  direction_count = 64,
		  frame_count = 1,
		  line_length = 8,
		  run_mode = inputs.run_mode or "forward",
		  shift = util.by_pixel(19, 2),
		  axially_symmetrical = false,
		  draw_as_shadow = true,
		  scale =  shotgun_turret_scale,
		}
  }
}
end

data:extend({ 
  {
    type = "ammo-turret",
    name = "shotgun-turret",
	placeable_by = {item = "shotgun-turret", count = 1},
    icon = "__factorioplus__/graphics/icons/shotgun-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation","building-direction-8-way"},
    minable = {mining_time = 0.5, result = "shotgun-turret"},
    max_health = health_turret_shotgun,
	
	turret_base_has_direction = true,
	
	hide_resistances = false,
	resistances =
    {
      {
        type = "fire",
        decrease = 3,
        percent = 30
      },
       {
        type = "physical",
        percent = 30
      },
      {
        type = "impact",
        decrease = 20,
        percent = 30
      },
      {
        type = "explosion",
        decrease = 15,
        percent = 30
      },
   {
        type = "acid",
		decrease = 2,
        percent = 60
      },
    },
    corpse = "small-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
    selection_box = {{-1, -1 }, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.02,
    preparing_speed = 1,
    preparing_sound = sounds.gun_turret_activate,
    folding_sound = sounds.gun_turret_deactivate,
    folding_speed = 1,
    inventory_size = 1,
    automated_ammo_count = 10,
    attacking_speed = 1.0,
    alert_when_attacking = true,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    folded_animation =
    {
      layers =
      {
        shotgun_turret_extension{frame_count=1, line_length = 1},
		shotgun_turret_extension_mask{frame_count=1, line_length = 1},
        shotgun_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        shotgun_turret_extension{},
		shotgun_turret_extension_mask{},
        shotgun_turret_extension_shadow{}
      }
    },
    prepared_animation = shotgun_turret_attack{frame_count=1},
    attacking_animation = shotgun_turret_attack{},
    folding_animation =
    {
      layers =
      {
        shotgun_turret_extension{run_mode = "backward"},
		shotgun_turret_extension_mask{run_mode = "backward"},
        shotgun_turret_extension_shadow{run_mode = "backward"}
      }
    },
  graphics_set =
    {
      base_visualisation =
      {
        animation =
		{
		  layers =
		  {
			{
				filename = "__base__/graphics/entity/laser-turret/laser-turret-base.png",
				priority = "high",
				width = 138,
				height = 104,
				direction_count = 1,
				frame_count = 1,
				shift = util.by_pixel(-0.5, 2),
				scale = 0.5
			},
			{
				filename = "__base__/graphics/entity/laser-turret/laser-turret-base-shadow.png",
				line_length = 1,
				width = 132,
				height = 82,
				draw_as_shadow = true,
				direction_count = 1,
				frame_count = 1,
				shift = util.by_pixel(6, 3),
				scale = 0.5
			}
		  }
	  }
    },
	},
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "projectile",
      ammo_category = "shotgun-shell",
      cooldown = firerate_turret_shotgun,  
	  rotate_penalty = 0.25,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = 0.5, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
      projectile_creation_distance = 1.0,
      projectile_center = {0, -0.0875}, -- same as gun_turret_attack shift
	  damage_modifier = 1.0,
	  turn_range = 0.25,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {-0.0625, 0},
        creation_distance = -0.25,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      range = range_turret_shotgun,
      sound = sounds.shotgun,
    },
	icon_draw_specification = { scale = 0.75},
    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },

})

---------------------------------------- LASER TURRET ----------------------------------------

function laser_turret_extension(inputs)
  return
  {

      filename = "__base__/graphics/entity/laser-turret/laser-turret-raising.png",
      priority = "medium",
      width = 130,
      height = 126,
      frame_count = inputs.frame_count and inputs.frame_count or 15,
      line_length = inputs.line_length and inputs.line_length or 0,
      run_mode = inputs.run_mode and inputs.run_mode or "forward",
      axially_symmetrical = false,
      direction_count = 4,
      shift = util.by_pixel(0, -32.5),
      scale = 0.5

  }
end

function laser_turret_extension_shadow(inputs)
  return
  {
      filename = "__base__/graphics/entity/laser-turret/laser-turret-raising-shadow.png",
      width = 182,
      height = 96,
      frame_count = inputs.frame_count and inputs.frame_count or 15,
      line_length = inputs.line_length and inputs.line_length or 0,
      run_mode = inputs.run_mode and inputs.run_mode or "forward",
      axially_symmetrical = false,
      direction_count = 4,
      draw_as_shadow = true,
      shift = util.by_pixel(47, 2.5),
      scale = 0.5

  }
end

function laser_turret_extension_mask(inputs)
  return
  {

      filename = "__base__/graphics/entity/laser-turret/laser-turret-raising-mask.png",
      flags = { "mask" },
      width = 86,
      height = 80,
      frame_count = inputs.frame_count and inputs.frame_count or 15,
      line_length = inputs.line_length and inputs.line_length or 0,
      run_mode = inputs.run_mode and inputs.run_mode or "forward",
      axially_symmetrical = false,
      apply_runtime_tint = true,
      direction_count = 4,
      shift = util.by_pixel(0, -43),
      scale = 0.5

  }
end

function laser_turret_shooting()
  return
  {

      filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting.png",
      line_length = 8,
      width = 126,
      height = 120,
      frame_count = 1,
      direction_count = 64,
      shift = util.by_pixel(0, -35),
      scale = 0.5

  }
end

function laser_turret_shooting_glow()
  return
  {

      filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-light.png",
      line_length = 8,
      width = 122,
      height = 116,
      frame_count = 1,
      direction_count = 64,
      shift = util.by_pixel(-0.5, -35),
      blend_mode = "additive",
      scale = 0.5

  }
end

function laser_turret_shooting_mask()
  return
  {

      filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-mask.png",
      flags = { "mask" },
      line_length = 8,
      width = 92,
      height = 80,
      frame_count = 1,
      apply_runtime_tint = true,
      direction_count = 64,
      shift = util.by_pixel(0, -43.5),
      scale = 0.5

  }
end

function laser_turret_shooting_shadow()
  return
  {

      filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-shadow.png",
      line_length = 8,
      width = 170,
      height = 92,
      frame_count = 1,
      direction_count = 64,
      draw_as_shadow = true,
      shift = util.by_pixel(50.5, 2.5),
      scale = 0.5

  }
end

data:extend({ 
  {
    type = "electric-turret",
    name = "laser-turret",
	placeable_by = {item = "laser-turret", count = 1},
    icon = "__base__/graphics/icons/laser-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-player", "player-creation"},
    minable = { mining_time = 0.75, result = "laser-turret" },
    max_health = health_turret_laser,
		resistances =
    {
      {
        type = "fire",
        decrease = 2,
        percent = 20
      },
      {
        type = "impact",
        decrease = 50,
        percent = 50
      },
       {
        type = "acid",
		decrease = 2,
        percent = 50
      }
    },
	hide_resistances = false,
    collision_box = {{ -0.7, -0.7}, {0.7, 0.7}},
    selection_box = {{ -1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.01,
    preparing_speed = 0.05,
    preparing_sound = sounds.laser_turret_activate,
    folding_sound = sounds.laser_turret_deactivate,
    corpse = "laser-turret-remnants",
    dying_explosion = "laser-turret-explosion",
    folding_speed = 0.05,
    energy_source =
    {
		 type = "electric",
		 buffer_capacity = "400kJ",
		 input_flow_limit = "4300kW",
		 drain = "30kW",
		 usage_priority = "primary-input"
    },
    folded_animation =
    {
      layers =
      {
        laser_turret_extension{frame_count=1, line_length = 1},
        laser_turret_extension_shadow{frame_count=1, line_length=1},
        laser_turret_extension_mask{frame_count=1, line_length=1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        laser_turret_extension{},
        laser_turret_extension_shadow{},
        laser_turret_extension_mask{}
      }
    },
    prepared_animation =
    {
      layers =
      {
        laser_turret_shooting(),
        laser_turret_shooting_shadow(),
        laser_turret_shooting_mask()
      }
    },
    --attacking_speed = 0.1,
    energy_glow_animation = laser_turret_shooting_glow(),
    glow_light_intensity = 0.5, -- defaults to 0
    folding_animation =
    {
      layers =
      {
        laser_turret_extension{run_mode = "backward"},
        laser_turret_extension_shadow{run_mode = "backward"},
        laser_turret_extension_mask{run_mode = "backward"}
      }
    },
   graphics_set =
    {
      base_visualisation =
      {
        animation =
		{

		layers =
		  {
				{
					filename = "__base__/graphics/entity/laser-turret/laser-turret-base.png",
					priority = "high",
					width = 138,
					height = 104,
					direction_count = 1,
					frame_count = 1,
					shift = util.by_pixel(-0.5, 2),
					scale = 0.5
				},
				{
					filename = "__base__/graphics/entity/laser-turret/laser-turret-base-shadow.png",
					line_length = 1,
					width = 132,
					height = 82,
					draw_as_shadow = true,
					direction_count = 1,
					frame_count = 1,
					shift = util.by_pixel(6, 3),
					scale = 0.5
				}
		  }
		},
	},
	},
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "beam",
      cooldown = firerate_turret_laser,
	  rotate_penalty = 0.2,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = 0.75, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
      range = range_turret_laser,
      source_direction_count = 64,
      source_offset = {0, -3.423489 / 4},
      damage_modifier = 1,
	  ammo_category = "laser",
      ammo_type =
      {
        energy_consumption = "70kJ",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "beam",
            beam = "laser-beam",
            max_length = 60,
            duration = firerate_turret_laser,
            source_offset = {0, -1.31439 }
          }
        }
      }
    },

    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  }
})

---------------------------------------- LARGE LASER TURRET ----------------------------------------
local gauss_shift_y = -56

function large_laser_turret_extension(inputs)
  return
  {
    filename = "__factorioplus__/graphics/mega-laser-turret.png",
    priority = "medium",
    width = 4104/8,
    height = 2904/8,
	  direction_count = 8,
	  frame_count = 1,
	  line_length = 0,
	  scale = 0.5,
    run_mode = inputs.run_mode and inputs.run_mode or "forward",
    axially_symmetrical = false,
    shift = util.by_pixel(0, gauss_shift_y),
  }
end

function large_laser_turret_extension_shadow(inputs)
  return
  {
    filename = "__base__/graphics/entity/laser-turret/laser-turret-raising-shadow.png",
    width = 1,
    height = 1,
frame_count = 1,
  line_length = 0,
    run_mode = inputs.run_mode and inputs.run_mode or "forward",
    axially_symmetrical = false,
    direction_count = 4,
    draw_as_shadow = true,
    shift = util.by_pixel(47, 3),
  }
end

function large_laser_turret_extension_mask(inputs)
  return
  {
    filename = "__factorioplus__/graphics/mega-laser-turret-mask.png",
    flags = { "mask" },
     width = 4104/8,
    height = 2904/8,
	scale = 0.5,
	frame_count = 1,
	line_length = 0,
    run_mode = inputs.run_mode and inputs.run_mode or "forward",
    axially_symmetrical = false,
    apply_runtime_tint = true,
    direction_count = 4,
    shift = util.by_pixel(0, gauss_shift_y),
  }
end

function large_laser_turret_shooting()
  return
  {
    filename = "__factorioplus__/graphics/mega-laser-turret.png",
    line_length = 8,
    width = 4104/8,
    height = 2904/8,
	scale = 0.5,
    frame_count = 1,
    direction_count = 64,
     shift = util.by_pixel(0, gauss_shift_y),
  }
end

function large_laser_turret_shooting_glow()
  return
  {
    filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-light.png",
    line_length = 8,
    width = 1,
    height = 1,
    frame_count = 1,
    direction_count = 64,
    blend_mode = "additive",
    shift = util.by_pixel(0, -35),
  }
end

function large_laser_turret_shooting_mask()
  return
  {
    filename = "__factorioplus__/graphics/mega-laser-turret-mask.png",
    flags = { "mask" },
    line_length = 8,
   width = 4104/8,
    height = 2904/8,
	 scale = 0.5,
    frame_count = 1,
    apply_runtime_tint = true,
    direction_count = 64,
     shift = util.by_pixel(0, gauss_shift_y),
  }
end

function large_laser_turret_shooting_shadow()
  return
  {
    filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-shadow.png",
    line_length = 8,
    width = 1,
    height = 1,
    frame_count = 1,
    direction_count = 64,
    draw_as_shadow = true,
    shift = util.by_pixel(51, 2),
  }
end

data:extend({ 
  {
    type = "electric-turret",
    name = "large-laser-turret",
	placeable_by = {item = "large-laser-turret", count = 1},
    icon = "__base__/graphics/icons/laser-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-player", "placeable-enemy", "player-creation"},
    minable = { mining_time = 1.5, result = "large-laser-turret" },
    max_health = health_turret_laser_large,
	hide_resistances = false,
	resistances =
    {
      {
        type = "fire",
        decrease = 5,
        percent = 20
      },
       {
        type = "physical",
        decrease = 5,
        percent = 20
      },
      {
        type = "impact",
        decrease = 20,
        percent = 10
      },
      {
        type = "explosion",
        decrease = 15,
        percent = 40
      },
       {
        type = "acid",
		decrease = 2,
        percent = 50
      }
    },
	hide_resistances = false,
    collision_box = {{ -2.4, -2.4}, {2.4, 2.4}},
    selection_box = {{ -2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.001,
    preparing_speed = 0.05,
    preparing_sound = sounds.laser_turret_activate,
    folding_sound = sounds.laser_turret_deactivate,
    corpse = "laser-turret-remnants",
    dying_explosion = "laser-turret-explosion",
    folding_speed = 0.05,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "30000kJ",
      input_flow_limit = "7500kW",
      drain = "500kW",
      usage_priority = "primary-input"
    },

    folded_animation =
    {
      layers =
      {
        large_laser_turret_extension{frame_count=1, line_length = 1},
        large_laser_turret_extension_shadow{frame_count=1, line_length=1},
        large_laser_turret_extension_mask{frame_count=1, line_length=1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        large_laser_turret_extension{},
        large_laser_turret_extension_shadow{},
        large_laser_turret_extension_mask{}
      }
    },
    prepared_animation =
    {
      layers =
      {
        large_laser_turret_shooting(),
        large_laser_turret_shooting_shadow(),
        large_laser_turret_shooting_mask()
      }
    },
    energy_glow_animation = large_laser_turret_shooting_glow(),
    glow_light_intensity = 1.5, -- defaults to 0
    folding_animation =
    {
      layers =
      {
        large_laser_turret_extension{run_mode = "backward"},
        large_laser_turret_extension_shadow{run_mode = "backward"},
        large_laser_turret_extension_mask{run_mode = "backward"}
      }
    },
	
  graphics_set =
    {
      base_visualisation =
      {
        animation =
		{
      layers =
      {
        {

            filename = "__base__/graphics/entity/gun-turret/gun-turret-base.png",
            priority = "high",
            width = 150,
            height = 118,
            axially_symmetrical = false,
            direction_count = 1,
            frame_count = 1,
            shift = util.by_pixel(0.5, -1),
            scale = 1.25

        },
        {

            filename = "__base__/graphics/entity/gun-turret/gun-turret-base-mask.png",
            flags = { "mask", "low-object" },
            line_length = 1,
            width = 122,
            height = 102,
            axially_symmetrical = false,
            direction_count = 1,
            frame_count = 1,
            shift = util.by_pixel(0, -4.5),
            apply_runtime_tint = true,
            scale = 1.25

        }

      },
	  },
    },
	},
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "beam",
      cooldown = firerate_turret_laser_large,
	  rotate_penalty = 10,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = -1, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
      range = range_turret_laser_large,
	  min_range = 10,
      source_direction_count = 64,
      source_offset = {0, -3.423489 / 4},
      damage_modifier = 1,
	  ammo_category = "laser",
      ammo_type =
      {
        energy_consumption = "15000kJ",
        action =
        {  
		{
			  type = "direct",
			  action_delivery =
			  {
				type = "beam",
				beam = "large-laser-beam",
				max_length = 100,
				duration = laserbeam_red_large_duration,
				source_offset = {0, -1.31439 },	
				target_effects =
				{
					{
					type = "create-entity",
					entity_name = "grenade-explosion",
					},
					{
					  type = "create-entity",
					  entity_name = "medium-scorchmark-tintable",
					  check_buildability = true
					},
					{
					type = "create-trivial-smoke",
					smoke_name = "artillery-smoke",
					initial_height = 0,
					speed_from_center = 0.1,
					speed_from_center_deviation = 0.005,
					offset_deviation = {{-1, -1}, {1, 1}},
					max_radius = 5.5,
					repeat_count = 2 * 2 * 8
					},
					{
					type = "play-sound",
					sound =  
						{
						
						  filename = "__factorioplus__/sounds/megalaser-1.ogg",
						  volume = 0.4,
						  speed = 0.9,
							
						},				
					},
				},
				source_effects =
				{
					{
					type = "play-sound",
					sound =  
					{
						
						  filename = "__factorioplus__/sounds/megalaser-1.ogg",
						  volume = 1,
						  speed = 0.6,
						
					},				
					},
				},
				
			},
		},
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
				  radius = laserbeam_red_large_radius,
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = laserbeam_red_large_radius_damage, type = "explosion"}
					  },
					  {
						type = "create-entity",
						entity_name = "explosion"
					  }
					}
				  }
				}
		},
		},
		},
		},
    },
	},

    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/laser-turret/laser-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  }
})

---------------------------------------- CHAINGUN TURRET ----------------------------------------

function chaingun_turret_extension(inputs)
return
{

    filename = "__base__/graphics/entity/gun-turret/gun-turret-raising.png",
    priority = "medium",
    width = 130,
    height = 126,
    direction_count = 4,
    frame_count = inputs.frame_count or 5,
    line_length = inputs.line_length or 0,
    run_mode = inputs.run_mode or "forward",
    shift = util.by_pixel(0, -26.5),
    axially_symmetrical = false,
    scale = 0.75,

}
end

function chaingun_turret_extension_mask(inputs)
return
{
 
    filename = "__base__/graphics/entity/gun-turret/gun-turret-raising-mask.png",
    flags = { "mask" },
    width = 48,
    height = 62,
    direction_count = 4,
    frame_count = inputs.frame_count or 5,
    line_length = inputs.line_length or 0,
    run_mode = inputs.run_mode or "forward",
    shift = util.by_pixel(0, -28),
    axially_symmetrical = false,
    apply_runtime_tint = true,
    scale = 0.75

}
end

function chaingun_turret_extension_shadow(inputs)
return
{

    filename = "__base__/graphics/entity/gun-turret/gun-turret-raising-shadow.png",
    width = 250,
    height = 124,
    direction_count = 4,
    frame_count = inputs.frame_count or 5,
    line_length = inputs.line_length or 0,
    run_mode = inputs.run_mode or "forward",
    shift = util.by_pixel(19, 2.5),
    axially_symmetrical = false,
    draw_as_shadow = true,
    scale = 0.75

}
end

function chaingun_turret_attack(inputs)
return
{
  layers =
  {
    {
      width = 132,
      height = 130,
      frame_count = inputs.frame_count or 2,
      direction_count = 64,
      shift = util.by_pixel(0, -27.5),
      stripes =
      {
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-1.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      },
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-2.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      },
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-3.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      },
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-4.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      }
      },
       scale = 0.75
    },
    {
      flags = {"mask"},
      line_length = inputs.frame_count or 2,
      width = 58,
      height = 54,
      frame_count = inputs.frame_count or 2,
      direction_count = 64,
      shift = util.by_pixel(0, -32.5),
      apply_runtime_tint = true,
      stripes =
      {
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-1.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      },
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-2.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      },
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-3.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      },
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-mask-4.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      }
      },
       scale = 0.75
    },
    {
      width = 250,
      height = 124,
      frame_count = inputs.frame_count or 2,
      direction_count = 64,
      shift = util.by_pixel(22, 2.5),
      draw_as_shadow = true,
      stripes =
      {
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-shadow-1.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      },
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-shadow-2.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      },
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-shadow-3.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      },
      {
      filename = "__base__/graphics/entity/gun-turret/gun-turret-shooting-shadow-4.png",
      width_in_frames = inputs.frame_count or 2,
      height_in_frames = 16
      }
      },
      scale = 0.75
    }
  }
}
end

data:extend({ 
{
	
    type = "ammo-turret",
    name = "chaingun-turret",
	placeable_by = {item = "chaingun-turret", count = 1},
    icon = "__base__/graphics/icons/gun-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation" ,"building-direction-8-way"},
    minable = {mining_time = 1.5, result = "chaingun-turret"},
    max_health = health_turret_minigun,
	turret_base_has_direction = true,
	can_retarget_while_starting_attack = true,
	allow_turning_when_starting_attack = true,
	resistances =
    {
      {
        type = "fire",
        decrease = 4,
        percent = 20
      },
      {
        type = "physical",
        decrease = 10,
        percent = 40
      },
      {
        type = "impact",
        decrease = 50,
        percent = 50
      },
      {
        type = "explosion",
        decrease = 15,
        percent = 40
      },
       {
        type = "acid",
		decrease = 2,
        percent = 50
      }
    },
	hide_resistances = false,
    corpse = "gun-turret-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = {{-1.3, -1.3 }, {1.3, 1.3}},
    selection_box = {{-1.5, -1.5 }, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.002,
    preparing_speed = 0.04,
    preparing_sound = sounds.gun_turret_activate,
    folding_sound = sounds.gun_turret_deactivate,
    folding_speed = 0.04,
    inventory_size = 2,
    automated_ammo_count = 10,
    attacking_speed = 0.5,
    alert_when_attacking = true,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,

    folded_animation =
    {
      layers =
      {
        chaingun_turret_extension{frame_count=1, line_length = 1},
        chaingun_turret_extension_mask{frame_count=1, line_length = 1},
        chaingun_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        chaingun_turret_extension{},
        chaingun_turret_extension_mask{},
        chaingun_turret_extension_shadow{}
      }
    },
    prepared_animation = chaingun_turret_attack{frame_count=1},
    attacking_animation = chaingun_turret_attack{},
    folding_animation =
    {
      layers =
      {
        chaingun_turret_extension{run_mode = "backward"},
        chaingun_turret_extension_mask{run_mode = "backward"},
        chaingun_turret_extension_shadow{run_mode = "backward"}
      }
    },
     graphics_set =
    {
      base_visualisation =
      {
        animation =
		{
      layers =
      {
        {

            filename = "__base__/graphics/entity/gun-turret/gun-turret-base.png",
            priority = "high",
            width = 150,
            height = 118,
            axially_symmetrical = false,
            direction_count = 1,
            frame_count = 1,
            shift = util.by_pixel(0.5, -1),
            scale = 0.75

        },
		{

            filename = "__base__/graphics/entity/gun-turret/gun-turret-base-mask.png",
            flags = { "mask", "low-object" },
            line_length = 1,
            width = 122,
            height = 102,
            axially_symmetrical = false,
            direction_count = 1,
            frame_count = 1,
            shift = util.by_pixel(0, -4.5),
            apply_runtime_tint = true,
            scale = 0.75

        }

      }
    },
	},
	},
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "projectile",
      ammo_category = "beltfed-bullet",
      cooldown = firerate_turret_minigun,
	  rotate_penalty = 10,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = 0, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
      projectile_creation_distance = 1.89375,
      projectile_center = {0, -0.0875}, -- same as chaingun_turret_attack shift
	  turn_range = 0.225,
	  damage_modifier = 1,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.3,
        speed_deviation = 0.08,
        center = {-0.0625, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      range = range_turret_minigun,
	  min_range = rangemin_turret_minigun,
       sound = 
	  {
		  {
			filename = "__base__/sound/fight/submachine-gunshot-1.ogg",
			volume = 0.6,
			speed = 0.7 ,
		  },
		  {
			filename = "__base__/sound/fight/submachine-gunshot-2.ogg",
			volume = 0.6,
			speed =  0.7,
		  },
		  {
			filename = "__base__/sound/fight/submachine-gunshot-3.ogg",
			volume = 0.6,
			speed = 0.7,
		  }
	  },
    },

    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
 })
 
  --------------------------------------------------- SMALL ROCKET TURRET ------------------------------------------------------------


local rocket_turret_x = 1824/8
local rocket_turret_y = 1720/8

function rocket_turret_extension(inputs)
return
{
  filename = "__factorioplus__/graphics/rocket-turret/hr-rocket-turret.png",
  priority = "medium",
  width = rocket_turret_x,
  height = rocket_turret_y,
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(2-2, -38 ),
  axially_symmetrical = false,
  scale =  0.4,
}
end

function rocket_turret_extension_mask(inputs)
return
{
  filename = "__factorioplus__/graphics/rocket-turret/hr-rocket-turret-mask.png",
  flags = { "mask" },
  width = rocket_turret_x,
  height = rocket_turret_y,
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(2-2, -38 ),
  axially_symmetrical = false,
  apply_runtime_tint = true,
	scale =  0.4,
}
end

function rocket_turret_extension_shadow(inputs)
return
{

    filename = "__base__/graphics/entity/tank/tank-turret-shadow.png",
    width = 193,
    height = 134,
    direction_count = 4,
    frame_count = 1,
    line_length = 0,
    run_mode = inputs.run_mode or "forward",
    shift = util.by_pixel(19, 2.5),
    axially_symmetrical = false,
    draw_as_shadow = true,
    scale =  0.4

}
end

function rocket_turret_attack(inputs)
return
{
  layers =
  {
   
	{
	  filename = "__factorioplus__/graphics/rocket-turret/hr-rocket-turret.png",
	  priority = "low",
	  line_length = 8,
	  width = rocket_turret_x,
		height = rocket_turret_y,
	  frame_count = 1,
	  direction_count = 64,
	  shift = util.by_pixel(2-2, -38 ),
	  animation_speed = 8,
	  scale =  0.4,
	},
	{
	  filename = "__factorioplus__/graphics/rocket-turret/hr-rocket-turret-mask.png",
	  flags = { "mask" },
	  width = rocket_turret_x,
		height = rocket_turret_y,
	  direction_count = 64,
	  frame_count = 1,
	  line_length = 8,
	  run_mode = inputs.run_mode or "forward",
	  shift = util.by_pixel(2-2, -38 ),
	  axially_symmetrical = false,
	  apply_runtime_tint = true,
	 scale =  0.4,
	},
  }
}
end

data:extend({ 
  {
    type = "ammo-turret",
    name = "rocket-turret",
	placeable_by = {item = "rocket-turret", count = 1},
    icon = "__factorioplus__/graphics/icons/rocket-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "rocket-turret"},
    max_health = health_turret_rocket,
	hide_resistances = false,
	resistances =
    {
      {
        type = "fire",
        decrease = 2,
        percent = 20
      },
       {
        type = "physical",
        percent = 20
      },
      {
        type = "impact",
        decrease = 20,
        percent = 10
      },
      {
        type = "explosion",
        decrease = 25,
        percent = 60
      },
      {
        type = "acid",
		decrease = 2,
        percent = 50
      }
    },
	hide_resistances = false,
    corpse = "gun-turret-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = {{-1.3, -1.3 }, {1.3, 1.3}},
    selection_box = {{-1.5, -1.5 }, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.01,
    preparing_speed = 0.1,
    preparing_sound = sounds.gun_turret_activate,
    folding_sound = sounds.gun_turret_deactivate,
    folding_speed = 0.1,
    inventory_size = 2,
    automated_ammo_count = 25,
    attacking_speed = 0.5,
    alert_when_attacking = true,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,

    folded_animation =
    {
      layers =
      {
        rocket_turret_extension{frame_count=1, line_length = 1},
		rocket_turret_extension_mask{frame_count=1, line_length = 1},
        rocket_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        rocket_turret_extension{},
		rocket_turret_extension_mask{},
        rocket_turret_extension_shadow{},
	  }
    },
    prepared_animation = rocket_turret_attack{frame_count=1},
    attacking_animation = rocket_turret_attack{},
    folding_animation =
    {
      layers =
      {
        rocket_turret_extension{run_mode = "backward"},
		rocket_turret_extension_mask{run_mode = "backward"},
        rocket_turret_extension_shadow{run_mode = "backward"}
      }
    },
    graphics_set =
    {
      base_visualisation =
      {
        animation =
		{
      layers = mediumturretbase,
    },
	},
	},
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "projectile",
      ammo_category = "rocket",
      cooldown =  firerate_turret_rocket,
	  rotate_penalty = 0.75,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = -1, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
	  damage_modifier = 1.0,
      projectile_creation_distance = 0.6,
      range = range_turret_rocket,
	  min_range = rangemin_turret_rocket,
      projectile_center = {-0, 0},
      sound =
      {
        {
          filename = "__base__/sound/fight/rocket-launcher.ogg",
          volume = 0.7,
		  speed = 0.75
        }
      }
    },

    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
})
	
--------------------------------- MORTAR(GRENADE) TURRET --------------------------------

function mortar_turret_extension(inputs)
return
{
  filename = "__factorioplus__/graphics/mortar.png",
  priority = "medium",
  width = 150,
  height = 106,
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(2-2, -26.5 ),
  axially_symmetrical = false,
  scale =  0.6,
}
end

function mortar_turret_extension_mask(inputs)
return
{
  filename = "__factorioplus__/graphics/mortar-mask.png",
  flags = { "mask" },
  width = 150,
  height = 106,
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(2-2, -26.5 ),
  axially_symmetrical = false,
  apply_runtime_tint = true,
  scale = 0.6,
}
end

function mortar_turret_extension_shadow(inputs)
return
{

    filename = "__base__/graphics/entity/tank/tank-turret-shadow.png",
    width = 193,
    height = 134,
    direction_count = 4,
    frame_count = 1,
    line_length = 0,
    run_mode = inputs.run_mode or "forward",
    shift = util.by_pixel(19, 2.5),
    axially_symmetrical = false,
    draw_as_shadow = true,
    scale =  0.7

}
end

function mortar_turret_attack(inputs)
return
{
  layers =
  {
   
		{
          filename = "__factorioplus__/graphics/mortar.png",
          priority = "low",
          line_length = 8,
			width = 150,
			height = 106,
          frame_count = 1,
          direction_count = 64,
          shift = util.by_pixel(2-2, -26.5),
          animation_speed = 8,
		  scale = 0.6,
		},
		{
		  filename = "__factorioplus__/graphics/mortar-mask.png",
		  flags = { "mask" },
		  width = 150,
		  height = 106,
		  direction_count = 64,
		  frame_count = 1,
		  line_length = 8,
		  run_mode = inputs.run_mode or "forward",
		  shift = util.by_pixel(2-2, -26.5),
		  axially_symmetrical = false,
		  apply_runtime_tint = true,
		  scale =  0.6,
		},
  }
}
end

data:extend({ 
  {
    type = "ammo-turret",
    name = "mortar-turret",
	placeable_by = {item = "mortar-turret", count = 1},
    icon = "__factorioplus__/graphics/icons/mortar-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation", "building-direction-8-way"},
    minable = {mining_time = 0.5, result = "mortar-turret"},
    max_health = health_turret_mortar,
	turret_base_has_direction = true,
	  resistances =
    {
      {
        type = "fire",
        decrease = 2,
        percent = 60
      },
      {
        type = "physical",
        percent = 30
      },
      {
        type = "impact",
        decrease = 50,
        percent = 50
      },
      {
        type = "explosion",
        decrease = 15,
        percent = 60
      },
      {
        type = "acid",
		decrease = 2,
        percent = 50
      }
    },
	hide_resistances = false,
    corpse = "gun-turret-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = {{-1.25, -1.25 }, {1.25, 1.25}},
    selection_box = {{-1.5, -1.5 }, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.001,
    preparing_speed = 0.5,
    preparing_sound = sounds.gun_turret_activate,
    folding_sound = sounds.gun_turret_deactivate,
    folding_speed = 0.5,
    inventory_size = 2,
    automated_ammo_count = 5,
    attacking_speed = 0.5,
    alert_when_attacking = true,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,

    folded_animation =
    {
      layers =
      {
        mortar_turret_extension{frame_count=1, line_length = 1},
		mortar_turret_extension_mask{frame_count=1, line_length = 1},
        mortar_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        mortar_turret_extension{},
		mortar_turret_extension_mask{},
        mortar_turret_extension_shadow{}
      }
    },
    prepared_animation = mortar_turret_attack{frame_count=1},
    attacking_animation = mortar_turret_attack{},
    folding_animation =
    {
      layers =
      {
        mortar_turret_extension{run_mode = "backward"},
		mortar_turret_extension_mask{run_mode = "backward"},
        mortar_turret_extension_shadow{run_mode = "backward"}
      }
    },
   graphics_set =
    {
      base_visualisation =
      {
        animation =
        {
          layers = mediumturretbase,
        }
      }
    },
  
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "stream",
      ammo_category = "grenade-shell",
	  damage_modifier = 1.0,
      cooldown = firerate_grenadelauncher * firerate_mortar_factor,
	  rotate_penalty = 2,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = -0.5, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
      gun_barrel_length = 0.8,
      gun_center_shift = { 0, -1 },
	  turn_range = turnrange_mortar,
      range = range_turret_mortar,
      min_range = rangemin_turret_mortar,
	  lead_target_for_projectile_speed = 0.35,
	  
	  sound =
      {
        {
          filename = "__base__/sound/fight/artillery-shoots-1.ogg",
          volume = 0.6,
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
		  speed = 2.0,
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
    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
})
 
 --- ABANDONMENT MORTAR
 
 
 
 data:extend({ 
 {
    type = "stream",
    name = "enemy-grenade-arc",
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

    stream_light = {intensity = 0.2, size = 4 * 1},
    ground_light = {intensity = 1.25, size = mortar_regular_damageradius, color = {0.95,0.2,0.2}, minimum_darkness = -5},

    particle_buffer_size = 30,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 1,
    particle_vertical_acceleration = 0.01 * 0.6,
    particle_horizontal_speed = 0.45,
    particle_horizontal_speed_deviation = 0.0035,
    particle_start_alpha = 1,
    particle_end_alpha = 1,
    particle_start_scale = 0.5,
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
				  radius = mortar_regular_damageradius/2,
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = {amount = mortar_regular_explosivedamage/2 , type = "explosion"}
					  },
					},
				  },
				},
				{
				  type = "area",
				  radius = 1,
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
      scale = 0.5,
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
    type = "turret",
    name = "abandonment-mortar-turret",
	placeable_by = {item = "mortar-turret", count = 1},
    icon = "__factorioplus__/graphics/icons/mortar-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {},
	hidden = true,
    minable = {mining_time = 0.5, result = "mortar-turret"},
    max_health = health_turret_mortar,
	  resistances =
      {
      {
        type = "fire",
        decrease = 2,
        percent = 60
      },
      {
        type = "physical",
        decrease = 4,
        percent = 30
      },
      {
        type = "impact",
        decrease = 50,
        percent = 50
      },
      {
        type = "explosion",
        decrease = 10,
        percent = 60
      },
       {
        type = "acid",
		decrease = 2,
        percent = 50
      }
    },
	hide_resistances = false,
    corpse = "gun-turret-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = {{-1.3, -1.3 }, {1.3, 1.3}},
    selection_box = {{-1.5, -1.5 }, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.001,
    preparing_speed = 0.5,
    preparing_sound = sounds.gun_turret_activate,
    folding_sound = sounds.gun_turret_deactivate,
    folding_speed = 0.5,
    attacking_speed = 0.5,
    alert_when_attacking = true,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    folded_animation =
    {
      layers =
      {
        mortar_turret_extension{frame_count=1, line_length = 1},
		mortar_turret_extension_mask{frame_count=1, line_length = 1},
        mortar_turret_extension_shadow{frame_count=1, line_length = 1}
      }
    },
    preparing_animation =
    {
      layers =
      {
        mortar_turret_extension{},
		mortar_turret_extension_mask{},
        mortar_turret_extension_shadow{}
      }
    },
    prepared_animation = mortar_turret_attack{frame_count=1},
    attacking_animation = mortar_turret_attack{},
    folding_animation =
    {
      layers =
      {
        mortar_turret_extension{run_mode = "backward"},
		mortar_turret_extension_mask{run_mode = "backward"},
        mortar_turret_extension_shadow{run_mode = "backward"}
      }
    },

   graphics_set =
    {
      base_visualisation =
      {
        animation =
		{
      layers =
      {
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-base.png",
            priority = "high",
            width = 138,
            height = 104,
            direction_count = 1,
            frame_count = 1,
            shift = util.by_pixel(-0.5, 2),
            scale = 0.75,
        },
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-base-shadow.png",
            line_length = 1,
            width = 132,
            height = 82,
            draw_as_shadow = true,
            direction_count = 1,
            frame_count = 1,
            shift = util.by_pixel(6, 3),
            scale = 0.75
        }
      }
    },
	},
	},
    
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "stream",
      ammo_category = "grenade-shell",
	  damage_modifier = 1.0,
      cooldown = firerate_grenadelauncher * firerate_mortar_factor,
	  rotate_penalty = 2,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = -0.5, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
      gun_barrel_length = 0.8,
      gun_center_shift = { 0, -1 },
      range = range_turret_mortar,
      min_range = rangemin_turret_mortar,
	  lead_target_for_projectile_speed = 0.35,
	  ammo_type =
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
            stream = "enemy-grenade-arc"
          }
        }
      },

	  sound =
      {
        {
          filename = "__base__/sound/fight/artillery-shoots-1.ogg",
          volume = 0.6,
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
		  speed = 2.0,
          }
        },
	 }
    },
    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false
    }
  },
})
 
--------------------------------- SNIPER TURRET --------------------------------
local sniper_turret_x = 2944/8
local sniper_turret_y = 2568/8
local sniper_turret_scale = 0.4
local sniper_turret_xy = {-2,-44}

function sniper_turret_extension(inputs)
return
{
  filename = "__factorioplus__/graphics/sniper-turret.png",
  priority = "medium",
  width = sniper_turret_x,
  height = sniper_turret_y,
  direction_count = 8,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(sniper_turret_xy[1],sniper_turret_xy[2]),
  axially_symmetrical = false,
  scale =  sniper_turret_scale,
}
end

function sniper_turret_extension_mask(inputs)
return
{
  filename = "__factorioplus__/graphics/sniper-turret-mask.png",
  flags = { "mask" },
  width = sniper_turret_x,
  height = sniper_turret_y,
  direction_count = 4,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(sniper_turret_xy[1],sniper_turret_xy[2]),
  axially_symmetrical = false,
  apply_runtime_tint = true,
  scale =  sniper_turret_scale,
}
end

function sniper_turret_extension_shadow(inputs)
return
{
  filename = "__base__/graphics/entity/tank/tank-turret-shadow.png",
  width = 1,
  height = 1,
  direction_count = 4,
  frame_count = 1,
  line_length = 0,
  run_mode = inputs.run_mode or "forward",
  shift = util.by_pixel(19, -16),
  axially_symmetrical = false,
  draw_as_shadow = true,
  scale =  1,
}
end

function sniper_turret_attack(inputs)
return
{
  layers =
  {
		{
          filename = "__factorioplus__/graphics/sniper-turret.png",
          priority = "low",
          line_length = 8,
          width = sniper_turret_x,
		  height = sniper_turret_y,
          frame_count = 1,
          direction_count = 64,
          shift = util.by_pixel(sniper_turret_xy[1],sniper_turret_xy[2]),
          animation_speed = 8,
		  scale = sniper_turret_scale,
		},
		{
			filename = "__factorioplus__/graphics/sniper-turret-mask.png",
			flags = { "mask" },
			width = sniper_turret_x,
			height = sniper_turret_y,
			direction_count = 64,
			frame_count = 1,
			line_length = 8,
			shift = util.by_pixel(sniper_turret_xy[1],sniper_turret_xy[2]),
			axially_symmetrical = false,
			apply_runtime_tint = true,
			scale =  sniper_turret_scale,
		}
  }
}
end

local get_sniper_shell_particle_pictures = function()
  return
  {
    {
      filename = "__base__/graphics/particle/shell-particle/shell-particle-1.png",
      priority = "extra-high",
	  scale = 3,
      width = 6,
      height = 6,
      frame_count = 5
    },
    {
      filename = "__base__/graphics/particle/shell-particle/shell-particle-2.png",
      priority = "extra-high",
	  scale = 3,
      width = 5,
      height = 7,
      frame_count = 5
    }
  }
end

local get_sniper_shell_particle_shadow_pictures = function()
  return
  {
    {
      filename = "__base__/graphics/particle/shell-particle/shell-particle-shadow-1.png",
      priority = "extra-high",
	  scale = 2,
      width = 9,
      height = 7,
      frame_count = 5
    },
    {
      filename = "__base__/graphics/particle/shell-particle/shell-particle-shadow-2.png",
      priority = "extra-high",
	  scale = 2,
      width = 7,
      height = 8,
      frame_count = 5
    }
  }
end

local particle_ended_in_water_trigger_effect = function()
  return
  {
    type = "create-particle",
    repeat_count = 6,
    repeat_count_deviation = 4,
    probability = 0.25,
    affects_target = false,
    show_in_tooltip = false,
    particle_name = "tintable-water-particle",
    apply_tile_tint = "secondary",
    offsets = { { 0, 0 } },
    offset_deviation = { { -0.2969, -0.2969 }, { 0.2969, 0.2969 } },
    initial_height = 0.1,
    initial_height_deviation = 0.5,
    initial_vertical_speed = 0.06,
    initial_vertical_speed_deviation = 0.069,
    speed_from_center = 0.02,
    speed_from_center_deviation = 0.05,
    frame_speed = 1,
    frame_speed_deviation = 0,
    tail_length = 9,
    tail_length_deviation = 8,
    tail_width = 1
  }
end

local make_particle = function(params)

  if not params then error("No params given to make_particle function") end
  local name = params.name or error("No name given")

  local ended_in_water_trigger_effect = params.ended_in_water_trigger_effect or default_ended_in_water_trigger_effect()
  if params.ended_in_water_trigger_effect == false then
    ended_in_water_trigger_effect = nil
  end

  local particle =
  {

    type = "optimized-particle",
    name = name,

    life_time = params.life_time or (60 * 15),
    fade_away_duration = params.fade_away_duration,

    render_layer = params.render_layer or "projectile",
    render_layer_when_on_ground = params.render_layer_when_on_ground or "corpse",

    regular_trigger_effect_frequency = params.regular_trigger_effect_frequency or 2,
    regular_trigger_effect = params.regular_trigger_effect,
    ended_in_water_trigger_effect = ended_in_water_trigger_effect,

    pictures = params.pictures,
    shadows = params.shadows,
    draw_shadow_when_on_ground = params.draw_shadow_when_on_ground,

    movement_modifier_when_on_ground = params.movement_modifier_when_on_ground,
    movement_modifier = params.movement_modifier,
    vertical_acceleration = params.vertical_acceleration,

    mining_particle_frame_speed = params.mining_particle_frame_speed,

  }

  return particle

end

data:extend({
make_particle
  {
    name = "sniper-shell-particle",
    life_time = 600,
    pictures = get_sniper_shell_particle_pictures(),
    shadows = get_sniper_shell_particle_shadow_pictures(),
    ended_in_water_trigger_effect = particle_ended_in_water_trigger_effect()
  }
})

data:extend({ 
  {
    type = "ammo-turret",
    name = "sniper-turret",
	placeable_by = {item = "sniper-turret", count = 1},
    icon = "__factorioplus__/graphics/icons/sniper-tower.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "player-creation","building-direction-8-way"},
    minable = {mining_time = 0.7, result = "sniper-turret"},
    max_health = health_turret_sniper,
	turret_base_has_direction = true,
	resistances =
    {
      {
        type = "fire",
        decrease = 2,
        percent = 20
      },
      {
        type = "physical",
        percent = 20
      },
      {
        type = "impact",
        decrease = 5,
        percent = 20
      },
      {
        type = "explosion",
        percent = 15
      },
       {
        type = "acid",
		decrease = 2,
        percent = 50
      }
    },
	hide_resistances = false,
    corpse = "gun-turret-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = {{-1.3, -1.3 }, {1.3, 1.3}},
    selection_box = {{-1.5, -1.5 }, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.001,
    preparing_speed = 0.5,
    preparing_sound = sounds.gun_turret_activate,
    folding_sound = sounds.gun_turret_deactivate,
    folding_speed = 0.5,
    inventory_size = 2,
    automated_ammo_count = 5,
    attacking_speed = 50,
    alert_when_attacking = true,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,

    folded_animation =
    {
      layers =
      {
        sniper_turret_extension{frame_count=1, line_length = 1},
		sniper_turret_extension_mask{frame_count=1, line_length = 1},
        sniper_turret_extension_shadow{frame_count=1, line_length = 1},
      }
    },
    preparing_animation =
    {
      layers =
      {
        sniper_turret_extension{},
		sniper_turret_extension_mask{},
        sniper_turret_extension_shadow{},
		
      }
    },
    prepared_animation = sniper_turret_attack{frame_count=1},
    attacking_animation = sniper_turret_attack{},
    folding_animation =
    {
      layers =
      {
        sniper_turret_extension{run_mode = "backward"},
        sniper_turret_extension_shadow{run_mode = "backward"},
		sniper_turret_extension_mask{run_mode = "backward"},
      }
    },
	  graphics_set =
    {
      base_visualisation =
      {
        animation =
		{
		  layers =
		  {
			{
			  filename = "__factorioplus__/graphics/sniper-turret-base.png",
			  priority = "high",
			  width = 298,
			  height = 288,
			  direction_count = 1,
			  frame_count = 1,
			  shift = util.by_pixel(0, -8),
			  scale = 0.35,
			},
			{
			  filename = "__factorioplus__/graphics/sniper-turret-base-shadow.png",
			  priority = "high",
			  width = 396,
			  height = 288,
			  direction_count = 1,
			  frame_count = 1,
			  draw_as_shadow = true,
			  shift = util.by_pixel(16, -8),
			  scale = 0.35,
			},
		  },
    },
	},
	},
    
    vehicle_impact_sound = sounds.generic_impact,

    attack_parameters =
    {
      type = "projectile",
      ammo_category = "sniper-shell",
      cooldown = firerate_turret_sniper,
	  rotate_penalty = 5,  -- >0 will discourage turrets from targeting units that would take longer to turn to face.
	  health_penalty = -3, -- >0 will discourage turrets from targeting units with higher health. <0 will encourage turrets to target units with higher health.  
      projectile_creation_distance = 2.8,
      projectile_center = {0, -1.0875}, -- same as chaingun_turret_attack shift
	  turn_range = 1/8, -- Allows for 8 directions with full coverage without gaps between rotations.
	  damage_modifier = 1,
	  lead_target_for_projectile_speed = 1.75,
      shell_particle =
      {
        name = "artillery-shell-particle",
        direction_deviation = 0.05,
		vertical_speed = 0.2,
        speed = 0.1,
        speed_deviation = 0.08,
        center = {-0.0625, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      range = range_turret_sniper,
	  min_range = rangemin_turret_sniper,
      sound = 
		{
			  {
				filename = "__base__/sound/fight/heavy-gunshot-1.ogg",
				volume = 0.9,
				speed = 0.8,
				max_distance = 2400,
				audible_distance_modifier = 4,
			  },
			  {
				filename = "__base__/sound/fight/heavy-gunshot-2.ogg",
				volume = 0.9,
				speed = 0.8,
				max_distance = 2400,
				audible_distance_modifier = 4,
			  },
			  {
				filename = "__base__/sound/fight/heavy-gunshot-3.ogg",
				volume = 0.9,
				speed = 0.8,
				max_distance = 2400,
				audible_distance_modifier = 4,
			  },
			  {
				filename = "__base__/sound/fight/heavy-gunshot-4.ogg",
				volume = 0.9,
				speed = 0.8,
				max_distance = 2400,
				audible_distance_modifier = 4,
			  },
		  },
	 },
	
    call_for_help_radius = 40,
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
        priority = "extra-high",
        width = 20,
        height = 32,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false,
    }
  }, 
  
})
 ---------------------------------------------------  GENERATE TURRET VETERANCY LEVELS ------------------------------------------------------------
require("veteran-turrets")

 if (mods["space-age"]) then

turretVetGroupings["rocket-battery"] = {
    "rocket-battery-veterancy-1",
    "rocket-battery-veterancy-2",
    "rocket-battery-veterancy-3",
    "rocket-battery-veterancy-4"
  }
turretVetGroupings["railgun-turret"] = {
    "railgun-turret-veterancy-1",
    "railgun-turret-veterancy-2",
    "railgun-turret-veterancy-3",
    "railgun-turret-veterancy-4"
  }
turretVetGroupings["tesla-turret"] = {
    "tesla-turret-veterancy-1",
    "tesla-turret-veterancy-2",
    "tesla-turret-veterancy-3",
    "tesla-turret-veterancy-4"
  }
end

turretVetIcons = {"icon-veterancy-1", "icon-veterancy-2", "icon-veterancy-3", "icon-veterancy-4"}
turretsToVet = { {"ammo-turret","pistol-turret"},{"ammo-turret","shotgun-turret"},{"ammo-turret","gun-turret"},{"ammo-turret","heavygun-turret"},{"ammo-turret","cannon-turret"},{"ammo-turret","rocket-turret"},{"ammo-turret","mortar-turret"},{"ammo-turret","chaingun-turret"},{"electric-turret","laser-turret"},{"fluid-turret","flamethrower-turret"},{"ammo-turret","sniper-turret"},{"electric-turret","large-laser-turret"} }

if (mods["space-age"]) then
	table.insert( turretsToVet , {"ammo-turret","railgun-turret"} )
	data.raw["ammo-turret"]["railgun-turret"].attack_parameters.damage_modifier = 1.0
	
	table.insert( turretsToVet , {"electric-turret","tesla-turret"} )
	data.raw["electric-turret"]["tesla-turret"].attack_parameters.damage_modifier = 1.0	
	
	table.insert( turretsToVet , {"ammo-turret", "rocket-battery"} )
	data.raw["ammo-turret"]["rocket-battery"].attack_parameters.damage_modifier = 1.0	
end


local tempVetGroupings = {}

function createAllTurrets()

local result = {}
	for i, v in pairs (turretsToVet) do
	local tempResult = {}

	   for i2, v2 in ipairs (turretKillLevels) do
			local singleturretresult = createTurretVeterancys(v[1],v[2] , i2 )
			table.insert(tempResult,singleturretresult.name)
			table.insert(result,singleturretresult)
	   end
	   tempVetGroupings[v[2]] = tempResult

	end
	
	turretVetGroupings = tempVetGroupings
	--log(serpent.block(turretVetGroupings))
	return result
end

function createTurretVeterancys(turrettype, turret, level)
  local result = table.deepcopy(data.raw[turrettype][turret])

  result.localised_name = {"entity-name.".. result.name}
  result.name = result.name .. "-veterancy-" .. level
  result.hidden = true 
  result.max_health = result.max_health * (1 + turretValueIncreaseAmount[level]  )
  result.healing_per_tick = (result.max_health / 10000 ) * (turretValueIncreaseAmount[level] * 2 )
  result.attack_parameters.cooldown = result.attack_parameters.cooldown / (1 + turretValueIncreaseAmount[level]  ) 
  result.attack_parameters.range = math.ceil(  result.attack_parameters.range * (1 + turretValueIncreaseAmount[level]  ) )
  result.attack_parameters.damage_modifier = result.attack_parameters.damage_modifier * (1 + turretValueIncreaseAmount[level] ) 

  return result
end

data:extend( createAllTurrets() )

-- function makeAbandonmentTurrets()
	-- local turret = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])

	-- turret.name = "abandonment".."-"..turret.name
	-- turret.subgroup = "enemies"
	-- turret.minable = nil
	-- turret.autoplace = abandonment_turret_autoplace(1.2)	
-- end

-- data:extend{makeAbandonmentTurrets()}