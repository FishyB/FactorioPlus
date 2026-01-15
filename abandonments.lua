local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local abandonments_autoplace = require ("__factorioplus__.abandonments-autoplace-util")
require ("stats")







if (settings.startup["settings-warehouse-abandonments"].value) then

	local _warehouse_spacing_scale = 16 -- Normal value
	
	if (settings.startup["settings-warehouse-spacing"].value == "dense" ) then
		_warehouse_spacing_scale = 12
	elseif (settings.startup["settings-warehouse-spacing"].value == "common" ) then
		_warehouse_spacing_scale = 14
	elseif (settings.startup["settings-warehouse-spacing"].value == "uncommon" ) then
		_warehouse_spacing_scale = 18
	elseif (settings.startup["settings-warehouse-spacing"].value == "sparse" ) then
		_warehouse_spacing_scale = 20
	elseif (settings.startup["settings-warehouse-spacing"].value == "rare" ) then
		_warehouse_spacing_scale = 22
	end

	local abandonment_loc = {"entity-name.abandonment"}

	local newpath = util.copy(data.raw["tile"]["nuclear-ground"])
	--newpath.collision_mask = {"water-tile"}
	newpath.localised_name = {"tile-name.abandonment-ground"}
	newpath.name = "abandonment".."-"..newpath.name  
	newpath.hidden = true
	--newpath.autoplace = abandonments_autoplace.abandonment_ground_autoplace(0.5)
	newpath.autoplace = abandonments_autoplace.abandonments_ground_autoplace("abandonments_autoplace_base(1, 0.6)")
	data:extend{newpath}

	local newpath2 = util.copy(data.raw["tile"]["landfill"])
	--newpath.collision_mask = {"water-tile"}
	newpath2.localised_name = {"tile-name.abandonment-ground-2"}
	newpath2.name = "abandonment".."-"..newpath.name.."-2" 
	newpath2.autoplace = abandonments_autoplace.abandonments_ground_autoplace("abandonments_autoplace_base(0, 0.5)")
	data:extend{newpath2}
	
-- Health Setting

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

-- i think this is supposed to be an empty building space, which is just a crater decal.
-- local newcrater = {}

local function package_pictures (_tint, _tint_item)
return
{
	{
		layers = 
		{	
		   {
			  filename = "__factorioplus__/graphics/abandonment-package.png",
			  width = 660/4,
			  height = 130,
			  scale = 0.5,
			  shift = {0, 0}				  
		  },
		   {
			  filename = "__factorioplus__/graphics/abandonment-package-mask.png",
			  width = 660/4,
			  height = 130,
			  tint = _tint,
			  scale = 0.5,
			  shift = {0, 0}		
		  },
			 {
			  filename = "__factorioplus__/graphics/abandonment-package-mask-2.png",
			  width = 660/4,
			  height = 130,
			  tint = _tint_item,
			  tint_as_overlay = true,
			  scale = 0.5,
			  shift = {0, 0}		
		  },
		   {
			  filename = "__factorioplus__/graphics/abandonment-package-shadow.png",
			  width = 660/4,
			  height = 130,
			  scale = 0.5,
			  draw_as_shadow = true,
			  shift = {0, 0}		
		  },
		},
	},
	{
		layers = 
		{	
		   {
			  filename = "__factorioplus__/graphics/abandonment-package.png",
			  width = 660/4,
			  height = 130,
			  scale = 0.5,
			  x = (660/4),
			  shift = {0, 0}				  
		  },
		   {
			  filename = "__factorioplus__/graphics/abandonment-package-mask.png",
			  width = 660/4,
			  height = 130,
			   tint = _tint,
			  x = 660/4,
			  scale = 0.5,
			  shift = {0, 0}		
		  },
		 {
			  filename = "__factorioplus__/graphics/abandonment-package-mask-2.png",
			  width = 660/4,
			  height = 130,
			  x = 660/4,
			  tint = _tint_item,
			  tint_as_overlay = true,
			  scale = 0.5,
			  shift = {0, 0}		
		  },
		   {
			  filename = "__factorioplus__/graphics/abandonment-package-shadow.png",
			  width = 660/4,
			  height = 130,
			  scale = 0.5,
				x = 660/4,
			  draw_as_shadow = true,
			  shift = {0, 0}		
		  },
		},
	},
	{
		layers = 
		{	
		   {
			  filename = "__factorioplus__/graphics/abandonment-package.png",
			  width = 660/4,
			  height = 130,
			  scale = 0.5,
			  x = (660/4) * 2,
			  shift = {0, 0}				  
		  },
		   {
			  filename = "__factorioplus__/graphics/abandonment-package-mask.png",
			  width = 660/4,
			  height = 130,
			   tint = _tint,
			  x = (660/4) * 2,
			  scale = 0.5,
			  shift = {0, 0}		
		  },
			{
			  filename = "__factorioplus__/graphics/abandonment-package-mask-2.png",
			  width = 660/4,
			  height = 130,
			  x =  (660/4) * 2,
			  tint = _tint_item,
			  tint_as_overlay = true,
			  scale = 0.5,
			  shift = {0, 0}		
		  },
		   {
			  filename = "__factorioplus__/graphics/abandonment-package-shadow.png",
			  width = 660/4,
			  height = 130,
			  scale = 0.5,
				x = (660/4) * 2,
			  draw_as_shadow = true,
			  shift = {0, 0}		
		  },
		},
	},
	{
		layers = 
		{	
		   {
			  filename = "__factorioplus__/graphics/abandonment-package.png",
			  width = 660/4,
			  height = 130,
			  scale = 0.5,
			  x = (660/4) * 3,
			  shift = {0, 0}				  
		  },
		   {
			  filename = "__factorioplus__/graphics/abandonment-package-mask.png",
			  width = 660/4,
			  height = 130,
			   tint = _tint,
			  x = (660/4) * 3,
			  scale = 0.5,
			  shift = {0, 0}		
		  },
		  {
			  filename = "__factorioplus__/graphics/abandonment-package-mask-2.png",
			  width = 660/4,
			  height = 130,
			  x =  (660/4) * 3,
			  tint_as_overlay = true,
			  tint = _tint_item,
			  scale = 0.5,
			  shift = {0, 0}		
		  },
		   {
			  filename = "__factorioplus__/graphics/abandonment-package-shadow.png",
			  width = 660/4,
			  height = 130,
			  scale = 0.5,
			  x = (660/4) * 3,
			  draw_as_shadow = true,
			  shift = {0, 0}		
		  },
		},
	},
}
end

data:extend
{
	{
		name = "abandonment-debris-medium-decal-1",
		type = "optimized-decorative",
		order = "b[decorative]-z[abandonment]",
		collision_box = {{-0.25, -0.25}, {0.25, 0.25}},
		collision_mask = {layers={water_tile=true}},
		render_layer = "object",
		tile_layer = 70,
		map_generator_bounding_box = {{ -0.1, -0.1}, {0.1,0.1}},
		autoplace = abandonments_autoplace.abandonments_decoratives_autoplace("abandonments_autoplace_base(0, 0.95)"),
		pictures =
		{
			{
			filename = "__factorioplus__/graphics/abandonment-rubble-medium-1.png",
			  width = 256,
			  height = 181,
			  variation_count = 1,
			  scale = 0.5
			},
			{
			filename = "__factorioplus__/graphics/abandonment-rubble-medium-2.png",
			  width = 256,
			  height = 181,
			  variation_count = 1,
			  scale = 0.5
			},
			{
			filename = "__factorioplus__/graphics/abandonment-rubble-medium-3.png",
			  width = 256,
			  height = 181,
			  variation_count = 1,
			  scale = 0.5
			},
			{
			filename = "__factorioplus__/graphics/abandonment-rubble-medium-4.png",
			  width = 256,
			  height = 181,
			  variation_count = 1,
			  scale = 0.5
			},
		}
	},
	{
		name = "abandonment-debris-large-decal-1",
		type = "optimized-decorative",
		order = "b[decorative]-z[abandonment]",
		collision_box = {{-2, -2}, {2, 2}},
		collision_mask = {layers={water_tile=true}},
		render_layer = "decals",
		tile_layer = 50,
		map_generator_bounding_box = {{ -0.75, -0.75}, {0.75,0.75}},
		autoplace = abandonments_autoplace.abandonments_decoratives_autoplace("abandonments_autoplace_base(0, 0.95)"),
		pictures =
		{
			{
			filename = "__factorioplus__/graphics/abandonment-rubble-large-1.png",
			  width = 512,
			  height = 363,
			  variation_count = 1,
			  scale = 0.5
			},
			{
			filename = "__factorioplus__/graphics/abandonment-rubble-large-2.png",
			  width = 512,
			  height = 363,
			  variation_count = 1,
			  scale = 0.5
			},
			{
			filename = "__factorioplus__/graphics/abandonment-rubble-large-3.png",
			  width = 512,
			  height = 363,
			  variation_count = 1,
			  scale = 0.5
			},
			{
			filename = "__factorioplus__/graphics/abandonment-rubble-large-4.png",
			  width = 512,
			  height = 363,
			  variation_count = 1,
			  scale = 0.5
			},
		}
	},
}

building_ammocache_picture =     
{
  layers =
  {
	{
	  filename = "__factorioplus__/graphics/ammo-cache-large.png",
	  priority = "extra-high",
	  width = 512,
	  height = 346,
	  shift = util.by_pixel(0, 0),
	  scale = 0.5,
	},
	{
		filename = "__factorioplus__/graphics/ammo-cache-large-shadow.png",
		priority = "extra-high",
		width = 512,
		height = 326,
		shift = util.by_pixel(10, -1),
		scale = 0.55,
		draw_as_shadow = true,
	}
  }
}

building_explosivecache_picture =     
{
  layers =
  {
	{
	  filename = "__factorioplus__/graphics/ammo-cache.png",
	  priority = "extra-high",
	  width = 256,
	  height = 281,
	  shift = util.by_pixel(0, 0),
	  scale = 0.5,
	},
	{
		filename = "__factorioplus__/graphics/ammo-cache-shadow.png",
		priority = "extra-high",
		width = 256,
		height = 194,
		shift = util.by_pixel(8, 16),
		scale = 0.55,
		draw_as_shadow = true,
	}
  }
}

building_lab_picture =     
{
  layers =
  {
	{
	  filename = "__factorioplus__/graphics/research-cache.png",
	  priority = "extra-high",
	  width = 512,
	  height = 368,
	  shift = util.by_pixel(0, -6),
	  scale = 0.46,
	},
	{
		filename = "__factorioplus__/graphics/research-cache-shadow.png",
		priority = "extra-high",
		width = 512,
		height = 263,
		shift = util.by_pixel(8, 16),
		scale = 0.50,
		draw_as_shadow = true,
	}
  }
}


building_barren =     
{
  layers =
  {
	{
	  filename = "__factorioplus__/graphics/abandonment-building-medium.png",
	  priority = "extra-high",
	  width = 490,
	  height = 393,
	  shift = util.by_pixel(0, -16),
	  scale = 0.6,
	},
	{
		filename = "__factorioplus__/graphics/abandonment-building-medium-shadow.png",
		priority = "extra-high",
		width = 490,
		height = 393,
		shift = util.by_pixel(0, -16),
		scale = 0.6,
		draw_as_shadow = true,
	}
  }
}

local sp1_scalar = 1
local spap_scalar = 1.3

local solarpanel1_scale = {{-3.8*sp1_scalar, -2.5*sp1_scalar}, {3.8*sp1_scalar, 2.5*sp1_scalar}}
local solarpanel2_scale = {{-2.35*sp1_scalar, -2.2*sp1_scalar}, {2.35*sp1_scalar, 2.2*sp1_scalar}}
local solarpanel3_scale = {{-1.7*sp1_scalar, -1.9*sp1_scalar}, {1.7*sp1_scalar, 1.9*sp1_scalar}}

local solarpanel1_autoplace = {{-3.8*spap_scalar, -2.5*spap_scalar}, {3.8*spap_scalar, 2.5*spap_scalar}}
local solarpanel2_autoplace = {{-2.35*spap_scalar, -2.2*spap_scalar}, {2.35*spap_scalar, 2.2*spap_scalar}}
local solarpanel3_autoplace = {{-1.7*spap_scalar, -1.9*spap_scalar}, {1.7*spap_scalar, 1.9*spap_scalar}}

local building_solararray_abandoned_1 =     
{
  layers =
  {
	{
	  filename = "__factorioplus__/graphics/solar-array-abandoned-1.png",
	  priority = "extra-high",
	  width = 1288/2,
	  height = 428,
	  shift = util.by_pixel(0, 0),
	  scale = 0.4 * sp1_scalar,
	  variation_count = 2,
	},
	{
		filename = "__factorioplus__/graphics/solar-array-abandoned-1-shadow.png",
		priority = "extra-high",
		width = 1288/2,
		height = 428,
		shift = util.by_pixel(0, 0),
		scale = 0.4 * sp1_scalar,
		draw_as_shadow = true,
		variation_count = 2,
	}
  }
}

local building_solararray_abandoned_2 =     
{
  layers =
  {
	{
	  filename = "__factorioplus__/graphics/solar-array-abandoned-2.png",
	  priority = "extra-high",
	  width = 1288/2,
	  height = 428,
	  shift = util.by_pixel(0, 0),
	  scale = 0.4 * sp1_scalar,
	  variation_count = 2,
	},
	{
		filename = "__factorioplus__/graphics/solar-array-abandoned-2-shadow.png",
		priority = "extra-high",
		width = 1288/2,
		height = 428,
		shift = util.by_pixel(0, 0),
		scale = 0.4 * sp1_scalar,
		draw_as_shadow = true,
		variation_count = 2,
	}
  }
}

local building_solararray_abandoned_3 =     
{
  layers =
  {
	{
	  filename = "__factorioplus__/graphics/solar-array-abandoned-3.png",
	  priority = "extra-high",
	  width = 1288/2,
	  height = 428,
	  shift = util.by_pixel(0, 0),
	  scale = 0.4 * sp1_scalar,
	  variation_count = 2,
	},
	{
		filename = "__factorioplus__/graphics/solar-array-abandoned-3-shadow.png",
		priority = "extra-high",
		width = 1288/2,
		height = 428,
		shift = util.by_pixel(0, 0),
		scale = 0.4 * sp1_scalar,
		draw_as_shadow = true,
		variation_count = 2,
	}
  }
}

local building_accumulator_abandoned =     
{
  layers =
  {
	{
	  filename = "__factorioplus__/graphics/abandonment-accumulator.png",
	  priority = "extra-high",
	  width = 256,
	  height = 298,
	  shift = util.by_pixel(0, -16),
	  scale = 0.45,
	  variation_count = 1,
	},
	{
		filename = "__factorioplus__/graphics/abandonment-accumulator-shadow.png",
		priority = "extra-high",
		width = 246,
		height = 128,
		shift = util.by_pixel(32, 6),
		scale = 0.75,
		draw_as_shadow = true,
		variation_count = 1,
	}
  }
}


local building_pole_abandoned =     
{
  layers =
  {
	{
	  filename = "__factorioplus__/graphics/abandonment-electric-pole.png",
	  priority = "extra-high",
	  width = 512/4,
	  height = 328,
	  direction_count = 4,
	  shift = util.by_pixel(0, -50),
	  scale = 0.45,
	},
	{
		filename = "__factorioplus__/graphics/abandonment-electric-pole-shadow.png",
		priority = "extra-high",
		width = 572/4,
		height = 50,
		shift = util.by_pixel(34, 0),
		scale = 0.9,
		direction_count = 4,
		draw_as_shadow = true,
	}
  }
}

local building_pole_abandoned_connections =
{
  {
	shadow =
	{
	  copper = util.by_pixel_hr(229, -13)
	},
	wire =
	{
	  copper = util.by_pixel_hr(13-29, -204-15)
	}
  },
  {
	shadow =
	{
	  copper = util.by_pixel_hr(229, -13)
	},
	wire =
	{
	  copper = util.by_pixel_hr(19-18, -206-26)
	}
  },
  {
	shadow =
	{
	  copper = util.by_pixel_hr(229, -13)
	},
	wire =
	{
	  copper = util.by_pixel_hr(20, -218)
	}
  },
  {
	shadow =
	{
	  copper = util.by_pixel_hr(229, -13)
	},
	wire =
	{
	  copper = util.by_pixel_hr(6, -206)
	}
  }
}

-- ABANDONMENT BUILDING VARIABLES

local autoplace_loot_scale_modifier = 0.65 -- How much to scale the loot buildings autoplace value after calculation (after powerscaling)
local autoplace_turret_scale_modifier = 0.7 -- Same as above for turrets

local autoplace_turret_laser_s = 1.4
local autoplace_turret_laser_m = 3.0
local autoplace_turret_laser_l = 6.0
local autoplace_turret_laser_b = 10.0

-- These should line up with other turrets, so that one doesn't override the other.
local autoplace_turret_mortar_s = autoplace_turret_laser_l
local autoplace_turret_mortar_m = autoplace_turret_laser_b

local autoplace_solar_s = 1.0
local autoplace_solar_m = 5.0
local autoplace_solar_l = 8.0


-- LOOT FUNCTIONS
local loothutboundingbox = _warehouse_spacing_scale 

local powerscalingvalue = (settings.startup["settings-enemy-power-scaling"].value/100)

local trvinc = 0.25
local trvincval = 0
local trv = 0

-- This is the autoplace function shared by all warehouse objects.

local function loot_autoplace(autoplace_dist)
	return ("abandonments_autoplace_base(0,".. (( (((autoplace_dist + trv) * (1+(powerscalingvalue-1))) ) -trv ) * autoplace_loot_scale_modifier ) ..")")
end

local function newtrv()
	local _newtrv 
	trvincval = trvincval + trvinc
	local _radianVal = math.rad((math.pi / (math.random()) + trvincval) )
	trv = math.sin(_radianVal) / 2
	return trv
end

-- MAKE LOOT WAREHOUSE --

local function generate_storage_hut (newname, boundingspace, distance, loottable) 

	-- Add a random value between -0.25 and 0.25
	newtrv()
	
	local _autoplace_distance = distance

	local s = util.copy(data.raw["container"]["warehouse"])
	s.localised_name = {"",abandonment_loc, " ", {"entity-name." .. s.name} }
	s.localised_description = {"entity-description.abandonment-warehouse"} 
	s.max_health = s.max_health * enemy_health_scale
	s.name = "abandonment".."-"..newname  
	s.flags = {"placeable-off-grid", "player-creation"}
	s.build_base_evolution_requirement = 10
	s.enemy_map_color = abandonments_bonus_color_map
	s.hidden = true
	if string.find(s.name,"weapon") or string.find(s.name,"equipment") or string.find(s.name,"turret")  then
		s.picture = building_ammocache_picture
		s.collision_box = {{-3.75, -2.25}, {3.75, 2.25}}
		s.selection_box = {{-3.85, -2.5}, {3.85, 2.5}}
	elseif string.find(s.name,"grenade") or string.find(s.name,"explosive") then
		s.picture = building_explosivecache_picture
		s.collision_box = {{-1.75, -2.25}, {1.75, 2.25}}
		s.selection_box = {{-1.85, -2.5}, {1.85, 2.5}}
	elseif string.find(s.name,"tech") or string.find(s.name,"lab") then
		s.picture = building_lab_picture
		s.collision_box = {{-3.75, -2.25}, {3.75, 2.25}}
		s.selection_box = {{-3.85, -2.5}, {3.85, 2.5}}
	elseif string.find(s.name,"barren") then
		s.picture = building_barren
		s.localised_description = {"entity-description.abandonment-warehouse-barren"} 
		s.enemy_map_color = abandonments_barren_color_map
	end
	
	s.created_effect = 
	{
		create_tiles("nuclear-ground", 6, 1.0), 
		create_tiles("stone-path-abandonment", 3, 1.0), 
		create_tiles("stone-path-abandonment", 4.5, 0.25),
		create_clustertiles("stone-path-abandonment", 4, 0.25, 10)	
	}
	s.map_generator_bounding_box = {{ -boundingspace, -boundingspace}, {boundingspace, boundingspace}}	
	
	s.autoplace = abandonments_autoplace.abandonments_loot_autoplace(loot_autoplace(_autoplace_distance))
	s.loot = loottable 

	-- s.corpse = { s.corpse , "scout" }
	return s
end

-- Shuffle Table
-- Todo, shuffle all entries at startup.

local function ShuffleInPlace(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

-- MAKE COPIES OF STUFF


local newpole = util.copy(data.raw["electric-pole"]["medium-electric-pole"])
newpole.localised_name = {"",abandonment_loc, " ", {"entity-name." .. newpole.name} }
newpole.collision_box = {{-0.25, -0.25}, {0.25, 0.25}}
newpole.selection_box = {{-0.6, -0.6}, {0.6, 0.6}}
newpole.pictures = building_pole_abandoned
newpole.connection_points = building_pole_abandoned_connections
newpole.name = "abandonment".."-"..newpole.name  
newpole.maximum_wire_distance = 12
newpole.supply_area_distance = 10
newpole.flags = {"placeable-off-grid"}
-- newpole.light = 
-- {
	-- intensity = 0.5, 
	-- --minimum_darkness = 0.5,
	-- size = 8, 
	-- color={r=1, g=1, b =1}
-- }
newpole.resistances =
{
  {
	type = "fire",
	percent = 90
  },
   {
	type = "impact",
	percent = 25
  },
  {
	type = "physical",
	percent = 35
  }
}
newpole.max_health = 200 * enemy_health_scale
newpole.autoplace = abandonments_autoplace.abandonments_poles_autoplace("abandonments_autoplace_base(100, 1.00)")
newpole.build_base_evolution_requirement = 10
newpole.map_generator_bounding_box = {{ -5.5, -5.5}, {5.5, 5.5}}
newpole.remove_decoratives = "false"
newpole.hidden = true
newpole.enemy_map_color = abandonments_force_color_map
newpole.loot =
    {
      {item = "steel-plate", probability = 1, count_min = 0, count_max = 2},
	  {item = "copper-cable", probability = 1, count_min = 0, count_max = 4},
    },
data:extend{newpole}

---------------------------
-- ABANDONED LASER TURRETS
---------------------------

abandonmentTurretLayer = 11

local function makeNewAbandonmentTurret(data)

	local _suffix = data.suffix or error("no suffix defined")
	-- local _type = data.type or "electric-turret"
	-- local _turret = data.turret or "laser-turret"
	local _scale = data.scale or 1.0 -- scale of turret art, collision, etc.
	local _mny = data.masknudge_y or 0
	local _energy_consumption_modifier = data.energy_consumption_modifier or 1.0
	local _autoplacedistance = data.autoplace_start_distance or error("no autoplace distance defined")
	local _addhp = data.additionalhp or 0
	
	local newturret = util.copy(data.baseturret)
	local _oldname = data.baseturret.name
	
	-- Construct a localization string from the existing one, and appending a suffix of turret size and prefix "Abandoned" from those localizations.
	newturret.localised_name =  {"",abandonment_loc, " ", {"entity-name." .._oldname}, " (", {"factorioplus-adjectives.".._suffix}, ")" }
	newturret.name = "abandonment".."-".._oldname.."-".._suffix  
	newturretflags = {"placeable-off-grid"}
	
	-- Add some bounding box generator space when things get bigger/smaller
	local _extrabv = 0.3
	local _nbv = _extrabv * _scale
	-- add a number, which is scaled, don't scale the entire base value...
	newturret.map_generator_bounding_box = {{ -1.1 - _nbv, -1.1 - _nbv}, {1.1 + _nbv, 1.1 + _nbv}}
	newturret.build_base_evolution_requirement = 10 -- Make a number so big it can't ever be placed by evo factor (which is 0 - 1.0 range)
	newturret.autoplace = abandonments_autoplace.abandonments_turrets_autoplace("abandonments_autoplace_base("..abandonmentTurretLayer..","..((_autoplacedistance * powerscalingvalue) * autoplace_turret_scale_modifier).." )")
	
	newturret.enemy_map_color = abandonments_force_color_map
	
	newturret.remove_decoratives = "false"

	newturret.max_health = (newturret.max_health * _scale ) * enemy_health_scale + _addhp
	newturret.loot = data.loot or {}
	newturret.hidden = true
	
	scaleTurretArt(newturret.graphics_set.base_visualisation.animation.layers, _scale, _mny)
	scaleTurretArt(newturret.folding_animation.layers, _scale, _mny)
	scaleTurretArt(newturret.prepared_animation.layers, _scale, _mny)
	scaleTurretArt(newturret.preparing_animation.layers, _scale, _mny)
	scaleTurretArt(newturret.folded_animation.layers, _scale, _mny)
	scaleTurretArtSimple(newturret.energy_glow_animation, _scale, _mny)
	
	newturret.collision_box = {{ -0.8 * _scale, -0.8 * _scale}, {0.8 * _scale, 0.8 * _scale}}
    newturret.selection_box = {{ -1 * _scale, -1 * _scale}, {1 * _scale, 1 * _scale}}
	
	-- When a turret is placed in the world, add these lovely details.
	newturret.created_effect = 
	{ 
		-- tiles should be listed from largest to smallest as they will overwrite each other.
		create_tiles("nuclear-ground", 2.5 * _scale, 1.0), 
		create_tiles("stone-path-abandonment", 1.5 * _scale, 0.5), 
		create_entity("small-scorchmark-tintable", 8 * _scale, 1, 4 * _scale),
		create_decoratives("abandonment-debris-medium-decal-1", 7 * _scale, 1),
		create_clustertiles("stone-path-abandonment", 2 * _scale, 0.25, 4 * _scale)	
	}
	
	newturret.attack_parameters.range = math.ceil(newturret.attack_parameters.range * data.range_modifier) or newturret.attack_parameters.range
	newturret.attack_parameters.damage_modifier = data.damage_modifier or newturret.attack_parameters.damage_modifier
	
	-- put in a check for non standard turret variables.
	if (data.energy_consumption_modifier) then
		newturret.attack_parameters.ammo_type.energy_consumption = ((string.match(newturret.attack_parameters.ammo_type.energy_consumption, '%d[%d.,]*'))  * _energy_consumption_modifier ) .."kJ"
	end
	
	abandonmentTurretLayer = abandonmentTurretLayer + abandonmentTurretLayer -- Just add the number to itself any tmie we make a new abandonment turret
	
	return newturret
end

-- This helper is used when there is multiple layers of graphics.
function scaleTurretArt(image_data, scale, mny)
	for i, v in pairs (image_data) do
		v.scale = v.scale * scale
		if v.flags then
			if v.flags[1] == "mask" then
				-- We're gonna do something to the mask to shift it into the correct position.
				v.shift = {v.shift[1],v.shift[2]+ mny}
			end
		end
	end
end

-- this helper is used when there's only 1 entry in a layer.
function scaleTurretArtSimple(image_data, scale, mny)
	image_data.scale = image_data.scale * scale
	if image_data.flags then
		if image_data.flags[1] == "mask" then
			-- We're gonna do something to the mask to shift it into the correct position.
			image_data.shift = {image_data.shift[1],image_data.shift[2]+ mny}
		end
	end

end


data:extend{
	makeNewAbandonmentTurret({
		baseturret = data.raw["electric-turret"]["laser-turret"],
		suffix = "small",
		scale = 0.75,
		masknudge_y = 0.06,
		range_modifier = 0.75,
		damage_modifier = 0.5,
		energy_consumption_modifier = 0.5,
		autoplace_start_distance = autoplace_turret_laser_s,
		loot =	
		{
		  {item = "electronic-circuit", probability = 1, count_min = 0, count_max = 3},
		  {item = "battery", probability = 1, count_min = 0, count_max = 1},
		  {item = "iron-gear-wheel", probability = 1, count_min = 0, count_max = 1},
		  {item = "iron-plate", probability = 1, count_min = 0, count_max = 2},
		  {item = "electronic-circuit", probability = 1, count_min = 0, count_max = 1},
		},	
	})
}

data:extend{
	makeNewAbandonmentTurret({
		baseturret = data.raw["electric-turret"]["laser-turret"],
		suffix = "medium",
		scale = 1,
		range_modifier = 1,
		damage_modifier = 1,
		energy_consumption_modifier = 0.75,
		autoplace_start_distance = autoplace_turret_laser_m,
		loot =	
		{
		  {item = "electronic-circuit", probability = 1, count_min = 0, count_max = 4},
		  {item = "battery", probability = 1, count_min = 0, count_max = 2},
		  {item = "iron-gear-wheel", probability = 0.9, count_min = 0, count_max = 2},
		  {item = "iron-plate", probability = 1, count_min = 0, count_max = 3},
		  {item = "electronic-circuit", probability = 1, count_min = 0, count_max = 2},
		},	
	})
}


data:extend{
	makeNewAbandonmentTurret({
		baseturret = data.raw["electric-turret"]["laser-turret"],
		suffix = "big",
		additionalhp = 250,
		scale = 1.5,
		masknudge_y = -0.15,
		range_modifier = 1.4,
		damage_modifier = 2.5,
		energy_consumption_modifier = 1,
		autoplace_start_distance = autoplace_turret_laser_l,
		loot =	
		{
		  {item = "electronic-circuit", probability = 1, count_min = 0, count_max = 6},
		  {item = "battery", probability = 1, count_min = 0, count_max = 3},
		  {item = "iron-gear-wheel", probability =1, count_min = 0, count_max = 4},
		  {item = "steel-plate", probability = 1, count_min = 0, count_max = 4},
		  {item = "advanced-circuit", probability = 1, count_min = 0, count_max = 4},
		},	
	})
}

data:extend{
	makeNewAbandonmentTurret({
		baseturret = data.raw["electric-turret"]["laser-turret"],
		suffix = "behemoth",
		scale = 2,
		additionalhp = 1500,
		masknudge_y = -0.31,
		range_modifier = 1.8,
		damage_modifier = 6,
		energy_consumption_modifier = 1.5,
		autoplace_start_distance = autoplace_turret_laser_b,
		loot =	
		{
		  {item = "processing-unit", probability = 1, count_min = 0, count_max = 3},
		  {item = "battery", probability = 1, count_min = 0, count_max = 5},
		  {item = "iron-gear-wheel", probability = 1, count_min = 0, count_max = 5},
		  {item = "steel-plate", probability = 1, count_min = 0, count_max = 5},
		  {item = "advanced-circuit", probability = 1, count_min = 0, count_max = 6},
		},	
	})
}

---------------------------
-- ABANDONED MORTAR TURRETS
---------------------------


local newturret2 = util.copy(data.raw["turret"]["abandonment-mortar-turret"]) 
newturret2.name = newturret2.name .. "1"
newturret2.localised_name = {"",abandonment_loc, " ", {"entity-name.mortar-turret"}}
newturret2.attack_parameters.range = newturret2.attack_parameters.range * 0.5
newturret2.attack_parameters.min_range = newturret2.attack_parameters.min_range * 0.65
newturret2.damage_modifier = 1.0
newturret2.flags = {"placeable-off-grid",  "player-creation"}
newturret2.max_health = newturret2.max_health * enemy_health_scale
newturret2.autoplace = abandonments_autoplace.abandonments_turrets_autoplace("abandonments_autoplace_base(33,"..((autoplace_turret_mortar_s * powerscalingvalue) * autoplace_turret_scale_modifier)..")")
newturret2.map_generator_bounding_box = {{ -1.70, -1.70}, {1.70, 1.70}}
newturret2.build_base_evolution_requirement = 10
newturret2.remove_decoratives = "false"
newturret2.hidden = true
newturret2.enemy_map_color = abandonments_force_color_map
newturret2.created_effect = { create_tiles("nuclear-ground", 3.5, 1.0), create_tiles("stone-path-abandonment", 3, 0.5), 	create_clustertiles("stone-path-abandonment", 3, 0.25, 3 * 2)	}
newturret2.loot =
    {
      {item = "electronic-circuit", probability =1, count_min = 0, count_max = 4},
	  {item = "iron-gear-wheel", probability = 1, count_min = 0, count_max = 6},
	  {item = "iron-plate", probability = 1, count_min = 0, count_max = 8},
	  {item = "electronic-circuit", probability = 1, count_min = 0, count_max = 4},
    },
data:extend{newturret2}



local newturret3 = util.copy(data.raw["turret"]["abandonment-mortar-turret"]) 
newturret3.name = newturret3.name .. "2"
newturret3.localised_name = {"",abandonment_loc, " ", {"entity-name.mortar-turret"}}
newturret3.attack_parameters.range = newturret3.attack_parameters.range * 0.75
newturret3.attack_parameters.min_range = newturret3.attack_parameters.min_range * 0.65
newturret3.damage_modifier = 2
newturret3.flags = {"placeable-off-grid",  "player-creation"}
newturret3.max_health = (newturret3.max_health * 1.5) * enemy_health_scale
newturret3.autoplace = abandonments_autoplace.abandonments_turrets_autoplace("abandonments_autoplace_base(33, "..((autoplace_turret_mortar_m * powerscalingvalue) * autoplace_turret_scale_modifier)..")")
newturret3.map_generator_bounding_box = {{ -1.70, -1.70}, {1.70, 1.70}}
newturret3.build_base_evolution_requirement = 10
newturret3.remove_decoratives = "false"
newturret3.hidden = true
newturret3.enemy_map_color = abandonments_force_color_map
newturret3.created_effect = { create_tiles("nuclear-ground", 4, 1.0), create_tiles("stone-path-abandonment", 3.5, 0.5), 	create_clustertiles("stone-path-abandonment", 3, 0.25, 3 * 2)	}
newturret3.loot =
    {
      {item = "electronic-circuit", probability =1, count_min = 0, count_max = 4},
	  {item = "iron-gear-wheel", probability = 1, count_min = 0, count_max = 6},
	  {item = "iron-plate", probability = 1, count_min = 0, count_max = 8},
	  {item = "electronic-circuit", probability = 1, count_min = 0, count_max = 4},
    },
data:extend{newturret3}

---------------------------
-- ABANDONED SOLAR PANELS
---------------------------

local solarpanel = data.raw["solar-panel"]["solar-panel"]
local newsolarpanel = util.copy(solarpanel)
newsolarpanel.icon = "__factorioplus__/graphics/icons/abandonment-solar-1.png"
newsolarpanel.localised_name = {"",abandonment_loc, " ", {"entity-name." .. newsolarpanel.name}}
newsolarpanel.name = "abandonment".."-"..newsolarpanel.name.."2"  
newsolarpanel.max_health = 300 * enemy_health_scale
newsolarpanel.build_base_evolution_requirement = 10
newsolarpanel.production = "397kW"
newsolarpanel.hidden = true
newsolarpanel.energy_source =
	{  
		type = "electric",
		usage_priority = "solar",
		render_no_network_icon = false 
	}
newsolarpanel.flags = {"placeable-off-grid",  "player-creation"}
newsolarpanel.picture = building_solararray_abandoned_1
newsolarpanel.overlay = nil
newsolarpanel.collision_box = solarpanel1_scale
newsolarpanel.selection_box = solarpanel1_scale
newsolarpanel.autoplace = abandonments_autoplace.abandonments_buildings_autoplace("abandonments_autoplace_base(44, "..(autoplace_solar_l * powerscalingvalue)..")")
newsolarpanel.map_generator_bounding_box = solarpanel1_autoplace
newsolarpanel.enemy_map_color = abandonments_force_color_map
newsolarpanel.remove_decoratives = "false"
newsolarpanel.created_effect = { create_tiles("nuclear-ground", 4.5, 1.0), create_tiles("stone-path-abandonment", 3.5, 0.5), 	create_clustertiles("stone-path-abandonment", 4.5, 0.25, 3 * 2)	}
newsolarpanel.loot =
    {
      {item = "steel-plate", probability = 1, count_min = 0, count_max = 8},
	  {item = "electronic-circuit", probability = 1, count_min = 0, count_max = 8},
	  {item = "advanced-circuit", probability = 1, count_min = 0, count_max = 4},
	  {item = "glass-plate", probability = 1, count_min = 0, count_max =14},
    },
data:extend{newsolarpanel}


local newsolarpanel2 = util.copy(data.raw["solar-panel"]["solar-panel"])
newsolarpanel2.icon = "__factorioplus__/graphics/icons/abandonment-solar-2.png"
newsolarpanel2.localised_name = {"",abandonment_loc, " ", {"entity-name." .. newsolarpanel2.name}}
newsolarpanel2.name = "abandonment".."-"..newsolarpanel2.name.."3"
newsolarpanel2.max_health = 200 * enemy_health_scale
newsolarpanel2.build_base_evolution_requirement = 10
newsolarpanel2.production = "219kW"
newsolarpanel2.hidden = true
newsolarpanel2.energy_source = 
	{  
		type = "electric",
		usage_priority = "solar",
		render_no_network_icon = false 
	}
newsolarpanel2.flags = {"placeable-off-grid",  "player-creation"}
newsolarpanel2.picture = building_solararray_abandoned_2
newsolarpanel2.overlay = nil
newsolarpanel2.collision_box = solarpanel2_scale
newsolarpanel2.selection_box = solarpanel2_scale
newsolarpanel2.autoplace = abandonments_autoplace.abandonments_buildings2_autoplace("abandonments_autoplace_base(45,"..(autoplace_solar_m * powerscalingvalue)..")")
newsolarpanel2.map_generator_bounding_box = solarpanel2_autoplace
newsolarpanel2.enemy_map_color = abandonments_force_color_map
newsolarpanel2.remove_decoratives = "false"
newsolarpanel2.created_effect = { create_tiles("nuclear-ground", 4, 1.0), create_tiles("stone-path-abandonment", 3, 0.5), create_clustertiles("stone-path-abandonment", 4, 0.25, 3 * 2)	}
newsolarpanel2.loot =
    {
      {item = "steel-plate", probability = 1, count_min = 0, count_max = 6},
	  {item = "electronic-circuit", probability = 1, count_min = 0, count_max = 6},
	  {item = "glass-plate", probability = 1, count_min = 0, count_max = 6},
    },
data:extend{newsolarpanel2}

local solarpanel3 = data.raw["solar-panel"]["solar-panel"]
local newsolarpanel3 = util.copy(solarpanel3)
newsolarpanel3.icon = "__factorioplus__/graphics/icons/abandonment-solar-3.png"
newsolarpanel3.localised_name = {"",abandonment_loc, " ", {"entity-name." .. newsolarpanel3.name}}
newsolarpanel3.name = "abandonment".."-"..newsolarpanel3.name 
newsolarpanel3.max_health = 125 * enemy_health_scale
newsolarpanel3.build_base_evolution_requirement = 10
newsolarpanel3.production = "91kW"
newsolarpanel3.hidden = true
newsolarpanel3.energy_source = 
	{  
		type = "electric",
		usage_priority = "solar",
		render_no_network_icon = false 
	}
newsolarpanel3.flags = {"placeable-off-grid",  "player-creation"}
newsolarpanel3.picture = building_solararray_abandoned_3
newsolarpanel3.overlay = nil
newsolarpanel3.collision_box = solarpanel3_scale
newsolarpanel3.selection_box = solarpanel3_scale
newsolarpanel3.autoplace = abandonments_autoplace.abandonments_buildings2_autoplace("abandonments_autoplace_base(46,"..(autoplace_solar_s * powerscalingvalue)..")")
newsolarpanel3.map_generator_bounding_box = solarpanel3_autoplace
newsolarpanel3.enemy_map_color = abandonments_force_color_map
newsolarpanel3.remove_decoratives = "false"
newsolarpanel3.created_effect ={ create_tiles("nuclear-ground", 3, 1.0), create_tiles("stone-path-abandonment", 2.5, 0.5),	create_clustertiles("stone-path-abandonment", 3, 0.25, 3 * 2)	} 
newsolarpanel3.loot =
    {
      {item = "steel-plate", probability = 1, count_min = 0, count_max = 2},
	  {item = "electronic-circuit", probability = 1, count_min = 0, count_max = 4},
	  {item = "glass-plate", probability = 1, count_min = 0, count_max = 4},
    },
data:extend{newsolarpanel3}

---------------------------
-- ABANDONED ACCUMULATORS
---------------------------

local newsaccumulator = util.copy(data.raw["accumulator"]["accumulator"])
newsaccumulator.icon = "__factorioplus__/graphics/icons/abandonment-accumulator.png"
newsaccumulator.localised_name = {"",abandonment_loc, " ", {"entity-name." .. newsaccumulator.name}}
newsaccumulator.name = "abandonment".."-"..newsaccumulator.name  
newsaccumulator.flags = {"placeable-off-grid", "player-creation"}
newsaccumulator.collision_box = {{-1.45, -1.45}, {1.45, 1.45}}
newsaccumulator.selection_box = {{-1.5, -1.5}, {1.5, 1.5}}
newsaccumulator.chargable_graphics.picture = building_accumulator_abandoned
newsaccumulator.chargable_graphics.charge_animation = nil
newsaccumulator.chargable_graphics.discharge_animation = nil
newsaccumulator.hidden = true
newsaccumulator.max_health = newsaccumulator.max_health * enemy_health_scale
newsaccumulator.autoplace = abandonments_autoplace.abandonments_auxbuildings_autoplace("abandonments_autoplace_base(80, "..(3 * powerscalingvalue)..")")
newsaccumulator.build_base_evolution_requirement = 10
newsaccumulator.energy_source.buffer_capacity = "20MJ"
newsaccumulator.remove_decoratives = "false"
newsaccumulator.map_generator_bounding_box = {{ -2.65, -1.55},{ 2.65, 1.55}}
newsaccumulator.enemy_map_color = abandonments_force_color_map
newsaccumulator.loot =
    {
      {item = "iron-plate", probability = 1, count_min = 0, count_max = 4},
	  {item = "copper-plate", probability = 1, count_min = 2, count_max = 6},
	  {item = "battery", probability = 0.25, count_min = 0, count_max = 4},
    },
data:extend{newsaccumulator}

---------------------------
-- ABANDONED LOOT WAREHOUSE
---------------------------

-- Barren warehouses

if settings.startup["settings-warehouse-barren"].value == true then
	data:extend{
		generate_storage_hut ("buildings-barren", loothutboundingbox, 18,{})
	}
end

-- Loot Warehouses

data:extend{
generate_storage_hut ("buildings-poles-0", loothutboundingbox, 1.15,
{
	{item = "medium-wooden-electric-pole", probability = 1, count_min = 20, count_max = 40},
	{item = "medium-wooden-electric-pole", probability = 0.5, count_min = 10, count_max = 20},
	{item = "medium-electric-pole", probability = 0.25, count_min = 10, count_max = 20},
}),
generate_storage_hut ("buildings-poles-1", loothutboundingbox, 1.25,
{
	{item = "medium-electric-pole", probability = 1, count_min = 20, count_max = 50},
	{item = "medium-electric-pole", probability = 0.5, count_min = 20, count_max = 40},
	{item = "medium-electric-pole", probability = 0.25, count_min = 20, count_max = 40},
}),
generate_storage_hut ("buildings-poles-2", loothutboundingbox, 3.35,
{
	{item = "medium-electric-pole", probability = 1, count_min = 20, count_max = 70},
	{item = "big-electric-pole", probability = 0.5, count_min = 10, count_max = 30},
	{item = "big-electric-pole", probability = 0.25, count_min = 10, count_max = 20},
}),
generate_storage_hut ("buildings-poles-3", loothutboundingbox, 5.35,
{
	{item = "big-electric-pole", probability = 1, count_min = 20, count_max = 40},
	{item = "big-electric-pole", probability = 0.5, count_min = 20, count_max = 40},
	{item = "substation", probability = 0.25, count_min = 10, count_max = 20},
}),
generate_storage_hut ("buildings-poles-4", loothutboundingbox, 8.35,
{
	{item = "huge-electric-pole", probability = 1, count_min = 10, count_max = 30},
	{item = "substation", probability = 1, count_min = 10, count_max = 30},
	{item = "substation", probability = 0.5, count_min = 10, count_max = 20},
	{item = "substation", probability = 0.25, count_min = 10, count_max = 20},
}),
generate_storage_hut ("buildings-poles-4", loothutboundingbox, 10.35,
{
	{item = "electrical-distributor", probability = 1, count_min = 10, count_max = 30},
	{item = "substation", probability = 0.5, count_min = 10, count_max = 20},
	{item = "substation", probability = 0.25, count_min = 10, count_max = 20},
}),
}

data:extend{
generate_storage_hut ("energy-production-0", loothutboundingbox, 1.31,
{
	{item = "steam-engine", probability = 1, count_min = 5, count_max = 30},
	{item = "boiler", probability = 1, count_min = 5, count_max = 15},
}),
generate_storage_hut ("energy-production-1", loothutboundingbox, 2.31,
{
	{item = "solar-panel", probability = 1, count_min = 10, count_max = 60},
}),
generate_storage_hut ("energy-production-2", loothutboundingbox, 3.51,
{
	{item = "accumulator", probability = 1, count_min = 10, count_max = 50},
}),
generate_storage_hut ("energy-production-3", loothutboundingbox, 5.51,
{
	{item = "solar-array", probability = 1, count_min = 10, count_max = 50},
}),
generate_storage_hut ("energy-production-4", loothutboundingbox, 7.51,
{
	{item = "accumulator-battery", probability = 1, count_min = 10, count_max = 50},
}),
generate_storage_hut ("energy-production-5", loothutboundingbox, 10.51,
{
	{item = "solar-array-2", probability = 1, count_min = 10, count_max = 50},
}),
generate_storage_hut ("energy-production-6", loothutboundingbox, 13.11,
{
	{item = "adv-accumulator-battery", probability = 1, count_min = 10, count_max = 50},
}),
generate_storage_hut ("energy-production-7", loothutboundingbox, 6.11,
{
	{item = "steam-turbine", probability = 1, count_min = 5, count_max = 20},
}),
}

data:extend{
generate_storage_hut ("resource-extraction-1", loothutboundingbox, 2.21,
{
	{item = "gas-extractor", probability = 1, count_min = 2, count_max = 20},
}),
generate_storage_hut ("resource-extraction-2", loothutboundingbox, 1.31,
{
	{item = "electric-mining-drill", probability = 1, count_min = 6, count_max = 25},
}),
generate_storage_hut ("resource-extraction-3", loothutboundingbox, 3.31,
{
	{item = "pumpjack", probability = 1, count_min = 2, count_max = 20},
}),
generate_storage_hut ("resource-extraction-4", loothutboundingbox, 5.21,
{
	{item = "electric-grinder", probability = 1, count_min = 5, count_max = 25},
}),
generate_storage_hut ("resource-extraction-5", loothutboundingbox, 2.11,
{
	{item = "large-burner-mining-drill", probability = 1, count_min = 5, count_max = 25},
}),
generate_storage_hut ("resource-extraction-6", loothutboundingbox, 7.21,
{
	{item = "steam-turbine-miner", probability = 1, count_min = 5, count_max = 25},
}),
}


data:extend{
	generate_storage_hut ("repair-packs-1", loothutboundingbox, 3.081,
	{
		{item = "repair-pack", probability = 1, count_min = 40, count_max = 150},
	}),

	generate_storage_hut ("repair-packs-2", loothutboundingbox, 7.081,
	{
		{item = "repair-pack-advanced", probability = 1, count_min = 30, count_max = 120},
	}),
}

data:extend{
	generate_storage_hut ("buildings-smelters-1", loothutboundingbox, 1.48,
	{
		{item = "stone-furnace", probability = 1, count_min = 10, count_max = 32},
	}),
	generate_storage_hut ("buildings-smelters-2", loothutboundingbox, 2.48,
	{
		{item = "steel-furnace", probability = 1, count_min = 10, count_max = 32},
	}),
	generate_storage_hut ("buildings-smelters-3", loothutboundingbox, 3.18,
	{
		{item = "big-furnace", probability = 1, count_min = 10, count_max = 32},
	}),
	generate_storage_hut ("buildings-smelters-4", loothutboundingbox, 3.58,
	{
		{item = "basic-electric-furnace", probability = 1, count_min = 10, count_max = 32},
	}),
	generate_storage_hut ("buildings-smelters-5", loothutboundingbox, 4.48,
	{
		{item = "mini-electric-furnace", probability = 1, count_min = 10, count_max = 32},
	}),
	generate_storage_hut ("buildings-smelters-6", loothutboundingbox, 6.18,
	{
		{item = "electric-furnace", probability = 1, count_min = 10, count_max = 32},
	}),
	generate_storage_hut ("buildings-smelters-7", loothutboundingbox, 8.48,
	{
		{item = "steel-forge", probability = 1, count_min = 10, count_max = 32},
	}),
	generate_storage_hut ("buildings-smelters-8", loothutboundingbox, 11.48,
	{
		{item = "electric-foundry", probability = 1, count_min = 10, count_max = 32},
	}),
	generate_storage_hut ("buildings-smelters-9", loothutboundingbox, 13.48,
	{
		{item = "heatpipe-furnace", probability = 1, count_min = 10, count_max = 32},
	}),
}


data:extend{
	generate_storage_hut ("buildings-machines-1", loothutboundingbox, 1.89,
	{
		{item = "assembling-machine-1", probability = 1, count_min = 10, count_max = 30},
	}),
	generate_storage_hut ("buildings-machines-3", loothutboundingbox, 3.89,
	{
		{item = "mini-assembling-machine-1", probability = 1, count_min = 10, count_max = 40},
	}),
	generate_storage_hut ("buildings-machines-4", loothutboundingbox, 3.89,
	{
		{item = "assembling-machine-2", probability = 1, count_min = 10, count_max = 30},
	}),
	generate_storage_hut ("buildings-machines-5", loothutboundingbox, 7.89,
	{
		{item = "assembling-machine-3", probability = 1, count_min = 10, count_max = 30},
	}),
	generate_storage_hut ("buildings-machines-6", loothutboundingbox, 13.89,
	{
		{item = "factory-large", probability = 1, count_min = 5, count_max = 15},
	}),
	generate_storage_hut ("buildings-machines-7", loothutboundingbox, 10.89,
	{
		{item = "metal-press-machine", probability = 1, count_min = 4, count_max = 10},
	}),
	generate_storage_hut ("buildings-machines-8", loothutboundingbox, 8.89,
	{
		{item = "centrifuge", probability = 1, count_min = 4, count_max = 10},
	}),
}

data:extend{
	generate_storage_hut ("buildings-machines-lab-1", loothutboundingbox, 2.89,
	{
		{item = "basic-lab", probability = 1, count_min = 8, count_max = 30},
	}),
	generate_storage_hut ("buildings-machines-lab-2", loothutboundingbox, 4.89,
	{
		{item = "lab", probability = 1, count_min = 6, count_max = 20},
	}),
	generate_storage_hut ("buildings-machines-lab-3", loothutboundingbox, 9.89,
	{
		{item = "lab-large", probability = 1, count_min = 4, count_max = 15},
	}),
}

data:extend{
	generate_storage_hut ("buildings-speed-modules-1", loothutboundingbox, 5.31,
	{
		{item = "speed-module", probability = 1, count_min = 5, count_max = 40},
	}),
	generate_storage_hut ("buildings-speed-modules-2", loothutboundingbox, 8.31,
	{
		{item = "speed-module-2", probability = 1, count_min = 5, count_max = 30},
	}),
	generate_storage_hut ("buildings-speed-modules-3", loothutboundingbox, 10.31,
	{
		{item = "speed-module-3", probability = 1, count_min = 10, count_max = 20},
	}),
	generate_storage_hut ("buildings-speed-modules-4", loothutboundingbox, 14.31,
	{
		{item = "speed-module-4", probability = 1, count_min = 5, count_max = 10},
	}),
	generate_storage_hut ("buildings-eff-modules-1", loothutboundingbox, 5.32,
	{
		{item = "efficiency-module", probability = 1, count_min = 5, count_max = 40},
	}),
	generate_storage_hut ("buildings-eff-modules-2", loothutboundingbox, 8.32,
	{
		{item = "efficiency-module-2", probability = 1, count_min = 5, count_max = 30},
	}),
	generate_storage_hut ("buildings-eff-modules-3", loothutboundingbox, 10.32,
	{
		{item = "efficiency-module-3", probability = 1, count_min = 5, count_max = 20},
	}),
	generate_storage_hut ("buildings-eff-modules-4", loothutboundingbox, 14.32,
	{
		{item = "efficiency-module-4", probability = 1, count_min = 5, count_max = 10},
	}),
	generate_storage_hut ("buildings-productivity-modules-1", loothutboundingbox, 5.33,
	{
		{item = "productivity-module", probability = 1, count_min = 5, count_max = 40},
	}),
	generate_storage_hut ("buildings-productivity-modules-2", loothutboundingbox, 8.33,
	{
		{item = "productivity-module-2", probability = 1, count_min = 5, count_max = 30},
	}),
	generate_storage_hut ("buildings-productivity-modules-3", loothutboundingbox, 10.33,
	{
		{item = "productivity-module-3", probability = 1, count_min = 5, count_max = 20},
	}),
	generate_storage_hut ("buildings-productivity-modules-4", loothutboundingbox, 14.33,
	{
		{item = "productivity-module-4", probability = 1, count_min = 5, count_max = 10},
	}),
	generate_storage_hut ("buildings-beacon-1", loothutboundingbox, 6.34,
	{
		{item = "beacon", probability = 1, count_min = 3, count_max = 9},
	}),
	generate_storage_hut ("buildings-beacon-2", loothutboundingbox, 10.34,
	{
		{item = "beacon", probability = 1, count_min = 6, count_max = 22},
	}),
}



data:extend{
generate_storage_hut ("buildings-robologistics-0", loothutboundingbox, 3.43,
{
	{item = "mini-roboport", probability = 1, count_min = 4, count_max = 15},
	{item = "construction-robot", probability =  1, count_min = 6, count_max = 25},
	{item = "construction-robot", probability =  0.5, count_min = 6, count_max = 25},
	{item = "logistic-robot", probability =  0.25, count_min = 6, count_max = 15},
	{item = "logistic-robot", probability =  0.1, count_min = 6, count_max = 15},
	{item = "storage-chest", probability =  0.5, count_min = 1, count_max = 4},
	{item = "active-provider-chest", probability =  0.1, count_min = 1, count_max = 10},
	{item = "requester-chest", probability =  0.1, count_min = 1, count_max = 10},
}),
generate_storage_hut ("buildings-robologistics-1", loothutboundingbox, 5.43,
{
	{item = "mini-roboport", probability = 1, count_min = 6, count_max = 25},
	{item = "construction-robot", probability =  1, count_min = 6, count_max = 40},
	{item = "construction-robot", probability =  0.5, count_min = 6, count_max = 40},
	{item = "logistic-robot", probability =  0.25, count_min = 6, count_max = 20},
	{item = "logistic-robot", probability =  0.1, count_min = 6, count_max = 20},
	{item = "storage-chest", probability =  0.5, count_min = 2, count_max = 10},
	{item = "active-provider-chest", probability =  0.1, count_min = 1, count_max = 10},
	{item = "requester-chest", probability =  0.1, count_min = 1, count_max = 10},
}),
generate_storage_hut ("buildings-robologistics-2", loothutboundingbox, 7.43,
{
	{item = "roboport", probability = 1, count_min = 5, count_max = 15},
	{item = "construction-robot", probability =  1, count_min = 5, count_max = 60},
	{item = "construction-robot", probability =  0.5, count_min = 5, count_max = 60},
	{item = "logistic-robot", probability =  0.55, count_min = 4, count_max = 40},
	{item = "logistic-robot", probability =  0.1, count_min = 4, count_max = 40},
	{item = "logistic-storage-hut", probability =  0.5, count_min = 2, count_max = 10},
	{item = "logistic-active-provider-hut", probability =  0.5, count_min = 2, count_max = 10},
	{item = "logistic-requester-hut", probability =  0.5, count_min = 2, count_max = 10},
}),
generate_storage_hut ("buildings-robologistics-3", loothutboundingbox, 9.43,
{
	{item = "roboport", probability = 1, count_min = 10, count_max = 30},
	{item = "construction-robot", probability =  1, count_min = 10, count_max = 80},
	{item = "construction-robot", probability =  0.5, count_min = 10, count_max = 80},
	{item = "logistic-robot", probability =  0.55, count_min = 4, count_max = 40},
	{item = "logistic-robot", probability =  0.1, count_min = 4, count_max = 40},
	{item = "logistic-storage-hut", probability =  0.5, count_min = 2, count_max = 10},
	{item = "logistic-active-provider-hut", probability =  0.5, count_min = 2, count_max = 10},
	{item = "logistic-requester-hut", probability =  0.5, count_min = 2, count_max = 10},
}),
generate_storage_hut ("buildings-robologistics-4", loothutboundingbox, 11.43,
{
	{item = "roboport-major", probability = 1, count_min = 2, count_max = 10},
	{item = "construction-robot", probability =  1, count_min = 4, count_max = 100},
	{item = "construction-robot", probability =  0.5, count_min = 4, count_max = 100},
	{item = "logistic-robot", probability =  0.55, count_min = 4, count_max = 80},
	{item = "logistic-robot", probability =  0.1, count_min = 4, count_max = 80},
	{item = "logistic-warehouse", probability =  0.5, count_min = 2, count_max = 10},
	{item = "logistic-warehouse-active-provider", probability =  0.5, count_min = 2, count_max = 10},
	{item = "logistic-warehouse-requester", probability =  0.5, count_min = 2, count_max = 10},
}),
generate_storage_hut ("buildings-robologistics-5", loothutboundingbox, 13.43,
{
	{item = "roboport-major", probability = 1, count_min = 5, count_max = 20},
	{item = "construction-robot", probability =  1, count_min = 10, count_max = 100},
	{item = "construction-robot", probability =  0.6, count_min = 10, count_max = 100},
	{item = "logistic-robot", probability =  1, count_min = 10, count_max = 80},
	{item = "logistic-robot", probability =  0.6, count_min = 10, count_max = 80},
	{item = "logistic-warehouse", probability =  0.5, count_min = 2, count_max = 10},
	{item = "logistic-warehouse-active-provider", probability =  0.5, count_min = 2, count_max = 10},
	{item = "logistic-warehouse-requester", probability =  0.5, count_min = 2, count_max = 10},
}),
}

data:extend{
generate_storage_hut ("logistics-inserters-0", loothutboundingbox, 1.26,
{
	{item = "burner-inserter", probability = 1, count_min = 20, count_max = 50},
	{item = "long-handed-burner-inserter", probability = 1, count_min = 20, count_max = 50},
}),
generate_storage_hut ("logistics-inserters-1", loothutboundingbox, 1.56,
{
	{item = "inserter", probability = 1, count_min = 20, count_max = 100},
}),
generate_storage_hut ("logistics-inserters-2", loothutboundingbox, 2.16,
{
	{item = "long-handed-inserter", probability = 1, count_min = 20, count_max = 100},
}),
generate_storage_hut ("logistics-inserters-2b", loothutboundingbox, 4.16,
{
	{item = "very-long-handed-inserter", probability = 1, count_min = 20, count_max = 50},
}),
generate_storage_hut ("logistics-inserters-3", loothutboundingbox, 3.16,
{
	{item = "fast-inserter", probability = 1, count_min = 20, count_max = 100},
}),
generate_storage_hut ("logistics-inserters-4", loothutboundingbox, 6.16,
{
	{item = "bulk-inserter", probability = 1, count_min = 20, count_max = 100},
}),
}


if settings.startup["settings-loaders-active"].value then
data:extend({
generate_storage_hut ("buildings-logistics-0", loothutboundingbox, 1,
{
	{item = "basic-transport-belt", probability = 1, count_min = 100, count_max = 200},
	{item = "basic-underground-belt", probability =  0.5, count_min = 20, count_max = 40},
	{item = "basic-splitter", probability = 0.5, count_min = 20, count_max = 40},
	{item = "basic-loader", probability = 0.25, count_min = 10, count_max = 40},
}),
generate_storage_hut ("buildings-logistics-1", loothutboundingbox, 2,
{
	{item = "transport-belt", probability = 1, count_min = 50, count_max = 200},
	{item = "underground-belt", probability =  0.5, count_min = 10, count_max = 20},
	{item = "splitter", probability = 0.5, count_min = 10, count_max = 20},
	{item = "loader", probability = 0.25, count_min = 5, count_max = 20},
}),
generate_storage_hut ("buildings-logistics-2", loothutboundingbox, 5,
{
	{item = "fast-transport-belt", probability = 1, count_min = 50, count_max = 200},
	{item = "fast-underground-belt", probability =  0.5, count_min = 10, count_max = 20},
	{item = "fast-splitter", probability = 0.5, count_min = 10, count_max = 20},
	{item = "fast-loader", probability = 0.25, count_min = 5, count_max = 20},
}),
generate_storage_hut ("buildings-logistics-3", loothutboundingbox, 7,
{
	{item = "express-transport-belt", probability = 1, count_min = 50, count_max = 200},
	{item = "express-underground-belt", probability =  0.5, count_min = 10, count_max = 20},
	{item = "express-splitter", probability = 0.5, count_min = 10, count_max = 20},
	{item = "express-loader", probability = 0.25, count_min = 5, count_max = 20},
}),
generate_storage_hut ("buildings-logistics-4", loothutboundingbox, 10,
{
	{item = "turbo-transport-belt", probability = 1, count_min = 50, count_max = 200},
	{item = "turbo-underground-belt", probability =  0.5, count_min = 10, count_max = 20},
	{item = "turbo-splitter", probability = 0.5, count_min = 10, count_max = 20},
	{item = "turbo-loader", probability = 0.25, count_min = 5, count_max = 20},
}),
generate_storage_hut ("buildings-logistics-5", loothutboundingbox, 14,
{
	{item = "supersonic-transport-belt", probability = 1, count_min = 50, count_max = 200},
	{item = "supersonic-underground-belt", probability =  0.5, count_min = 10, count_max = 20},
	{item = "supersonic-splitter", probability = 0.5, count_min = 10, count_max = 20},
	{item = "supersonic-loader", probability = 0.25, count_min = 5, count_max = 20},
}),
})
else
data:extend({
generate_storage_hut ("buildings-logistics-0", loothutboundingbox, 1,
{
	{item = "basic-transport-belt", probability = 1, count_min = 50, count_max = 200},
	{item = "basic-underground-belt", probability =  0.5, count_min = 10, count_max = 20},
	{item = "basic-splitter", probability = 0.5, count_min = 10, count_max = 20},
}),
generate_storage_hut ("buildings-logistics-1", loothutboundingbox, 2,
{
	{item = "transport-belt", probability = 1, count_min = 50, count_max = 200},
	{item = "underground-belt", probability =  0.5, count_min = 10, count_max = 20},
	{item = "splitter", probability = 0.5, count_min = 10, count_max = 20},
}),
generate_storage_hut ("buildings-logistics-2", loothutboundingbox, 5,
{
	{item = "fast-transport-belt", probability = 1, count_min = 50, count_max = 200},
	{item = "fast-underground-belt", probability =  0.5, count_min = 10, count_max = 20},
	{item = "fast-splitter", probability = 0.5, count_min = 10, count_max = 20},
}),
generate_storage_hut ("buildings-logistics-3", loothutboundingbox, 7,
{
	{item = "express-transport-belt", probability = 1, count_min = 50, count_max = 200},
	{item = "express-underground-belt", probability =  0.5, count_min = 10, count_max = 20},
	{item = "express-splitter", probability = 0.5, count_min = 10, count_max = 20},
}),
generate_storage_hut ("buildings-logistics-4", loothutboundingbox, 10,
{
	{item = "turbo-transport-belt", probability = 1, count_min = 50, count_max = 200},
	{item = "turbo-underground-belt", probability =  0.5, count_min = 10, count_max = 20},
	{item = "turbo-splitter", probability = 0.5, count_min = 10, count_max = 20},
}),
generate_storage_hut ("buildings-logistics-5", loothutboundingbox, 14,
{
	{item = "supersonic-transport-belt", probability = 1, count_min = 50, count_max = 200},
	{item = "supersonic-underground-belt", probability =  0.5, count_min = 10, count_max = 20},
	{item = "supersonic-splitter", probability = 0.5, count_min = 10, count_max = 20},
}),
})
end

data:extend{
generate_storage_hut ("player-equipment", loothutboundingbox, 4.44,
{
	{item = "modular-armor", probability = 1, count_min = 1, count_max = 1},
	{item = "solar-panel-equipment", probability =1, count_min = 1, count_max = 4},
	{item = "battery-equipment", probability = 1, count_min = 1, count_max = 4},
	{item = "solar-panel-equipment", probability = 0.2, count_min = 0, count_max = 4},
	{item = "battery-equipment", probability = 0.2, count_min = 0, count_max = 4},
	{item = "energy-shield-equipment", probability = 1, count_min = 0, count_max = 2},
	{item = "energy-shield-equipment", probability = 0.2, count_min = 0, count_max = 2},
}),
generate_storage_hut ("player-equipment-1", loothutboundingbox, 5.44,
{
	{item = "modular-armor", probability = 1, count_min = 1, count_max = 1},
	{item = "personal-roboport-equipment", probability = 1, count_min = 1, count_max = 2},
	{item = "personal-roboport-equipment", probability = 0.2, count_min = 0, count_max = 2},
	{item = "battery-equipment", probability = 1, count_min = 1, count_max = 4},
	{item = "battery-equipment", probability = 0.2, count_min = 0, count_max = 4},
	{item = "fuel-generator-equipment", probability = 1, count_min = 1, count_max = 2},
	{item = "fuel-generator-equipment", probability = 0.2, count_min = 0, count_max = 2},
}),
generate_storage_hut ("player-equipment-2", loothutboundingbox, 7.44,
{
	{item = "power-armor", probability = 1, count_min = 1, count_max = 1},
	{item = "solar-panel-equipment", probability = 1, count_min = 1, count_max = 5},
	{item = "solar-panel-equipment-mk2", probability = 0.2, count_min = 0, count_max = 10},
	{item = "personal-long-range-roboport-equipment", probability = 0.2, count_min = 0, count_max = 2},
	{item = "exoskeleton-equipment", probability = 0.2, count_min = 0, count_max = 2},
	{item = "battery-mk2-equipment", probability = 0.2, count_min = 0, count_max = 6},
	{item = "personal-long-range-roboport-equipment", probability = 0.2, count_min = 0, count_max = 2},
	{item = "battery-equipment", probability = 1, count_min = 1, count_max = 5},
	{item = "battery-mk2-equipment", probability = 0.2, count_min = 0, count_max = 2},
}),
generate_storage_hut ("player-equipment-3", loothutboundingbox, 10.44,
{
	{item = "power-armor", probability = 1, count_min = 1, count_max = 1},
	{item = "solar-panel-equipment", probability = 1, count_min = 1, count_max = 5},
	{item = "solar-panel-equipment-mk2", probability = 0.2, count_min = 0, count_max = 10},
	{item = "personal-laser-defense-equipment", probability = 1, count_min = 1, count_max = 5},
	{item = "personal-laser-defense-equipment", probability = 0.2, count_min = 0, count_max = 5},
	{item = "battery-equipment", probability = 1, count_min = 1, count_max = 6},
	{item = "battery-mk2-equipment", probability = 0.2, count_min = 0, count_max = 6},
	{item = "exoskeleton-equipment", probability = 0.2, count_min = 0, count_max = 2},
	{item = "energy-shield-equipment", probability = 1, count_min = 0, count_max = 2},
	{item = "energy-shield-equipment", probability = 0.2, count_min = 0, count_max = 2},
}),
generate_storage_hut ("player-equipment-4", loothutboundingbox, 9.44,
{
	{item = "power-armor-mk2", probability = 1, count_min = 1, count_max = 1},
	{item = "solar-panel-equipment", probability = 1, count_min = 2, count_max = 10},
	{item = "fission-reactor-equipment", probability = 0.2, count_min = 1, count_max = 1},
	{item = "battery-mk2-equipment", probability = 1, count_min = 1, count_max = 4},
	{item = "battery-mk2-equipment", probability = 0.2, count_min = 0, count_max = 4},
	{item = "energy-shield-equipment", probability = 1, count_min = 0, count_max = 2},
	{item = "energy-shield-mk2-equipment", probability = 0.2, count_min = 0, count_max = 2},
	{item = "exoskeleton-equipment", probability = 0.2, count_min = 0, count_max = 2},
}),
generate_storage_hut ("player-equipment-5", loothutboundingbox, 12.44,
{
	{item = "power-armor-mk2", probability = 1, count_min = 1, count_max = 1},
	{item = "solar-panel-equipment-mk2", probability = 1, count_min = 2, count_max = 5},
	{item = "fission-reactor-equipment", probability = 0.25, count_min = 1, count_max = 2},
	{item = "battery-mk2-equipment", probability = 1, count_min = 1, count_max = 5},
	{item = "battery-mk2-equipment", probability = 0.25, count_min = 0, count_max = 4},
	{item = "personal-laser-defense-equipment", probability = 1, count_min = 0, count_max = 8},
	{item = "energy-shield-mk2-equipment", probability = 0.6, count_min = 0, count_max = 2},
	{item = "exoskeleton-equipment", probability = 0.6, count_min = 0, count_max = 2},
}),
}

data:extend{
generate_storage_hut ("buildings-turrets-0a", loothutboundingbox, 1.08,
{
	{item = "pistol-turret", probability = 1, count_min = 10, count_max = 25},
	{item = "firearm-magazine", probability = 1, count_min = 50, count_max = 100},
}),
generate_storage_hut ("buildings-turrets-1a", loothutboundingbox, 3.08,
{
	{item = "gun-turret", probability = 1, count_min = 10, count_max = 25},
	{item = "piercing-rounds-magazine", probability = 1, count_min = 50, count_max = 100},
}),
generate_storage_hut ("buildings-turrets-1b", loothutboundingbox, 3.08,
{
	{item = "shotgun-turret", probability = 1, count_min = 6, count_max = 15},
	{item = "shotgun-shell", probability = 1, count_min = 50, count_max = 100},
}),
generate_storage_hut ("buildings-turrets-2a", loothutboundingbox, 4.08,
{
	{item = "rocket-turret", probability = 1, count_min = 3, count_max = 10},
	{item = "rocket", probability = 1, count_min = 50, count_max = 100},
}),
generate_storage_hut ("buildings-turrets-3a", loothutboundingbox, 5,
{
	{item = "laser-turret", probability = 1, count_min = 10, count_max = 25},
}),
generate_storage_hut ("buildings-turrets-3b", loothutboundingbox, 4.08,
{
	{item = "flamethrower-turret", probability = 1, count_min = 8, count_max = 20},
}),
generate_storage_hut ("buildings-turrets-4a", loothutboundingbox, 6.08,
{
	{item = "heavygun-turret", probability = 1, count_min = 6, count_max = 20},
	{item = "piercing-rounds-magazine", probability = 1, count_min = 50, count_max = 100},
}),
generate_storage_hut ("buildings-turrets-4b", loothutboundingbox, 6.08,
{
	{item = "mortar-turret", probability = 1, count_min = 4, count_max = 8},
	{item = "grenade-rounds", probability = 1, count_min = 25, count_max = 50},
}),
generate_storage_hut ("buildings-turrets-5a", loothutboundingbox, 7.08,
{
	{item = "sniper-turret", probability = 1, count_min = 3, count_max = 8},
	{item = "sniper-shell", probability = 1, count_min = 25, count_max = 50},
}),
generate_storage_hut ("buildings-turrets-6a", loothutboundingbox, 10.08,
{
	{item = "cannon-turret", probability = 1, count_min = 4, count_max = 8},
	{item = "cannon-shell", probability = 1, count_min = 50, count_max = 100},
}),
}

-- RAIL STUFF

data:extend{
generate_storage_hut ("trains-0", loothutboundingbox, 2.39,
{
	{item = "locomotive", probability = 1, count_min = 0, count_max = 1},
	{item = "rail", probability = 1, count_min = 100, count_max = 300},
	{item = "rail", probability = 0.3, count_min = 50, count_max = 200},
	{item ="train-stop", probability = 1, count_min = 0, count_max = 5},
}),
generate_storage_hut ("trains-1", loothutboundingbox, 4.39,
{
	{item = "locomotive", probability = 1, count_min = 0, count_max = 2},
	{item = "cargo-wagon", probability = 1, count_min = 0, count_max = 4},
	{item = "fluid-wagon", probability = 1, count_min = 0, count_max = 4},
	{item = "rail", probability = 1, count_min = 150, count_max = 300},
	{item = "rail", probability = 0.4, count_min = 50, count_max = 200},
	{item ="train-stop", probability = 1, count_min = 2, count_max = 8},
	{item ="rail-signal", probability = 0.5, count_min = 10, count_max = 40},
}),
generate_storage_hut ("trains-2", loothutboundingbox, 6.39,
{
	{item = "solar-train", probability = 1, count_min = 0, count_max = 3},
	{item = "cargo-wagon", probability = 1, count_min = 0, count_max = 4},
	{item = "fluid-wagon", probability = 1, count_min = 0, count_max = 4},
	{item = "cargo-wagon", probability = 1, count_min = 2, count_max = 8},
	{item = "rail", probability = 1, count_min = 200, count_max = 300},
	{item = "rail", probability = 0.6, count_min = 100, count_max = 200},
	{item ="train-stop", probability = 1, count_min = 2, count_max = 8},
	{item ="rail-signal", probability = 1, count_min = 20, count_max = 60},
	{item ="rail-chain-signal", probability = 0.5, count_min = 20, count_max = 60},
}),
}

-- VEHICLE STUFF

data:extend{
generate_storage_hut ("transport-0", loothutboundingbox, 1.42,
{
	{item = "atv", probability = 1, count_min = 1, count_max = 1},

}),
generate_storage_hut ("transport-1", loothutboundingbox, 2.82,
{
	{item = "car-base", probability = 1, count_min = 1, count_max = 1},

}),
generate_storage_hut ("transport-1b", loothutboundingbox, 3.22,
{
	{item = "car", probability = 1, count_min = 1, count_max = 1},

}),
generate_storage_hut ("transport-1c", loothutboundingbox, 3.24,
{
	{item = "car-shotgun", probability = 1, count_min = 1, count_max = 1},

}),
generate_storage_hut ("transport-2", loothutboundingbox, 3.42,
{
	{item = "dozer", probability = 1, count_min = 1, count_max = 1},

}),
generate_storage_hut ("transport-2", loothutboundingbox, 4.62,
{
	{item = "apc-base", probability = 1, count_min = 1, count_max = 1},

}),
generate_storage_hut ("transport-2", loothutboundingbox, 5.62,
{
	{item = "apc-twinsmg", probability = 1, count_min = 1, count_max = 1},

}),
generate_storage_hut ("transport-2", loothutboundingbox, 5.72,
{
	{item = "apc-autoshotgun", probability = 1, count_min = 1, count_max = 1},

}),
generate_storage_hut ("transport-3", loothutboundingbox, 6.22,
{
	{item = "scout", probability = 1, count_min = 1, count_max = 1},

}),
generate_storage_hut ("transport-5", loothutboundingbox, 9.22,
{
	{item = "tank", probability = 1, count_min = 1, count_max = 1},

}),
}

-- FUEL STUFF

data:extend{
generate_storage_hut ("fuel-0", loothutboundingbox, 2.09,
{
	{item = "solid-fuel", probability = 1, count_min = 50, count_max = 100},
	{item = "solid-fuel", probability = 0.5, count_min = 25, count_max = 80},
	{item = "solid-fuel", probability = 0.25, count_min = 25, count_max = 80},
}),
generate_storage_hut ("fuel-1", loothutboundingbox, 3.09,
{
	{item = "nat-gas-fuel", probability = 1, count_min = 50, count_max = 100},
	{item = "nat-gas-fuel", probability = 0.5, count_min = 25, count_max = 50},
	{item = "nat-gas-fuel", probability = 0.25, count_min = 25, count_max = 50},
}),
generate_storage_hut ("fuel-2", loothutboundingbox, 5.09,
{
	{item = "petroleum-fuel", probability = 1, count_min = 25, count_max = 100},
	{item = "petroleum-fuel", probability = 0.5, count_min = 25, count_max = 50},
	{item = "petroleum-fuel", probability = 0.25, count_min = 25, count_max = 50},
}),
generate_storage_hut ("fuel-3", loothutboundingbox, 8.09,
{
	{item = "rocket-fuel", probability = 1, count_min = 25, count_max = 100},
	{item = "rocket-fuel", probability = 0.5, count_min = 25, count_max = 50},
	{item = "rocket-fuel", probability = 0.25, count_min = 25, count_max = 50},
}),
generate_storage_hut ("fuel-4", loothutboundingbox, 10.09,
{
	{item = "true-rocket-fuel", probability = 1, count_min = 25, count_max = 80},
	{item = "true-rocket-fuel", probability = 0.5, count_min = 25, count_max = 50},
	{item = "true-rocket-fuel", probability = 0.25, count_min = 25, count_max = 50},
}),
generate_storage_hut ("fuel-5", loothutboundingbox, 14.09,
{
	{item = "nuclear-fuel", probability = 1, count_min = 25, count_max = 50},
	{item = "nuclear-fuel", probability = 0.5, count_min = 25, count_max = 50},
	{item = "nuclear-fuel", probability = 0.25, count_min = 25, count_max = 50},
}),



}


data:extend{
generate_storage_hut ("weapons-robots-1", loothutboundingbox, 3,
{
	{item = "defender-capsule", probability = 1, count_min = 2, count_max = 10},
	{item = "defender-capsule", probability = 0.5, count_min = 2, count_max = 10},
}),
generate_storage_hut ("weapons-robots-2", loothutboundingbox, 5,
{
	{item = "destroyer-capsule", probability = 1, count_min = 2, count_max = 10},
	{item = "destroyer-capsule", probability = 0.5, count_min = 2, count_max = 10},
}),
generate_storage_hut ("weapons-robots-2b", loothutboundingbox, 5,
{
	{item = "disruptor-capsule", probability = 1, count_min = 2, count_max = 10},
	{item = "disruptor-capsule", probability = 0.5, count_min = 2, count_max = 10},
}),
generate_storage_hut ("weapons-robots-3", loothutboundingbox, 10,
{
	{item = "destroyer-capsule", probability = 1, count_min = 2, count_max = 10},
	{item = "destroyer-capsule", probability = 0.5, count_min = 2, count_max = 10},
}),
}

local weaponforge_chance = 5 / 100

data:extend{
generate_storage_hut ("weapons1-pistol", loothutboundingbox, 0.91,
{
	{item = "pistol-uncommon", probability = 0.8, count_min = 1, count_max = 1},
	{item = "firearm-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "firearm-magazine", probability = 0.5, count_min = 10, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-pistol", loothutboundingbox, 1.21,
{
	{item = "pistol-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "piercing-rounds-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "piercing-rounds-magazine", probability = 0.5, count_min = 10, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-pistol", loothutboundingbox, 1.51,
{
	{item = "pistol-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "explosive-rounds-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "explosive-rounds-magazine", probability = 0.5, count_min = 10, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-pistol", loothutboundingbox, 2.31,
{
	{item = "pistol-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "uranium-rounds-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "uranium-rounds-magazine", probability = 0.5, count_min = 10, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons0-magnum", loothutboundingbox, 1.12,
{
	{item = "magnum", probability = 1, count_min = 1, count_max = 1},
	{item = "firearm-magazine", probability = 1, count_min = 25, count_max = 40},
	{item = "firearm-magazine", probability = 0.5, count_min = 25, count_max = 45},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons1-magnum", loothutboundingbox, 1.62,
{
	{item = "magnum-uncommon", probability =  0.8, count_min = 1, count_max = 1},
	{item = "firearm-magazine", probability = 1, count_min = 25, count_max = 40},
	{item = "firearm-magazine", probability = 0.5, count_min = 25, count_max = 45},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-magnum", loothutboundingbox, 2.62,
{
	{item = "magnum-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "piercing-rounds-magazine", probability = 1, count_min = 25, count_max = 40},
	{item = "piercing-rounds-magazine", probability = 0.5, count_min = 25, count_max = 45},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-magnum", loothutboundingbox, 3.42,
{
	{item = "magnum-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "piercing-rounds-magazine", probability = 1, count_min = 25, count_max = 40},
	{item = "piercing-rounds-magazine", probability = 0.5, count_min = 25, count_max = 45},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-magnum", loothutboundingbox, 5.22,
{
	{item = "magnum-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "piercing-rounds-magazine", probability = 1, count_min = 25, count_max = 40},
	{item = "uranium-rounds-magazine", probability = 0.5, count_min = 25, count_max = 45},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons0-smg", loothutboundingbox, 1.73,
{
	{item = "submachine-gun", probability = 1, count_min = 1, count_max = 1},
	{item = "firearm-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "firearm-magazine", probability = 0.5, count_min = 10, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons1-smg", loothutboundingbox, 2.73,
{
	{item = "submachine-gun-uncommon", probability = 0.8, count_min = 1, count_max = 1},
	{item = "firearm-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "firearm-magazine", probability = 0.5, count_min = 10, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-smg", loothutboundingbox, 3.83,
{
	{item = "submachine-gun-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "piercing-rounds-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "piercing-rounds-magazine", probability = 0.5, count_min = 10, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-smg", loothutboundingbox, 4.93,
{
	{item = "submachine-gun-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "explosive-rounds-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "uranium-rounds-magazine", probability = 0.5, count_min = 10, count_max = 15},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-smg", loothutboundingbox, 6.03,
{
	{item = "submachine-gun-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "uranium-rounds-magazine", probability = 1, count_min = 10, count_max = 30},
	{item = "uranium-rounds-magazine", probability = 0.5, count_min = 10, count_max = 15},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons0-uzi", loothutboundingbox, 1.63,
{
	{item = "uzi-gun", probability = 1, count_min = 1, count_max = 1},
	{item = "firearm-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "firearm-magazine", probability = 0.5, count_min = 10, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons1-uzi", loothutboundingbox, 2.23,
{
	{item = "uzi-gun-uncommon", probability = 0.8, count_min = 1, count_max = 1},
	{item = "firearm-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "firearm-magazine", probability = 0.5, count_min = 10, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-uzi", loothutboundingbox, 3.23,
{
	{item = "uzi-gun-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "piercing-rounds-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "piercing-rounds-magazine", probability = 0.5, count_min = 10, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-uzi", loothutboundingbox, 4.03,
{
	{item = "uzi-gun-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "explosive-rounds-magazine", probability = 1, count_min = 20, count_max = 40},
	{item = "uranium-rounds-magazine", probability = 0.5, count_min = 10, count_max = 15},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-uzi", loothutboundingbox, 5.53,
{
	{item = "uzi-gun-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "uranium-rounds-magazine", probability = 1, count_min = 10, count_max = 30},
	{item = "uranium-rounds-magazine", probability = 0.5, count_min = 10, count_max = 15},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons0-shotgun", loothutboundingbox, 2.04,
{
	{item = "shotgun", probability = 1, count_min = 1, count_max = 1},
	{item = "shotgun-shell", probability = 1, count_min = 15, count_max = 30},
	{item = "shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons1-shotgun", loothutboundingbox, 2.64,
{
	{item = "shotgun-uncommon", probability = 0.8, count_min = 1, count_max = 1},
	{item = "shotgun-shell", probability = 1, count_min = 15, count_max = 30},
	{item = "shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-shotgun", loothutboundingbox, 3.04,
{
	{item = "shotgun-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "piercing-shotgun-shell", probability = 1,  count_min = 15, count_max = 30},
	{item = "piercing-shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-shotgun", loothutboundingbox, 4.64,
{
	{item = "shotgun-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "explosive-shotgun-shell", probability = 1,  count_min = 15, count_max = 30},
	{item = "explosive-shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-shotgun", loothutboundingbox, 6.04,
{
	{item = "shotgun-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "explosive-shotgun-shell", probability = 1,  count_min = 15, count_max = 30},
	{item = "explosive-shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),

generate_storage_hut ("weapons0-blunderbuss", loothutboundingbox, 2.55,
{
	{item = "blunderbuss", probability = 0.8, count_min = 1, count_max = 1},
	{item = "shotgun-shell", probability = 1, count_min = 15, count_max = 30},
	{item = "shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons1-blunderbuss", loothutboundingbox, 3.55,
{
	{item = "blunderbuss-uncommon", probability = 0.8, count_min = 1, count_max = 1},
	{item = "shotgun-shell", probability = 1, count_min = 15, count_max = 30},
	{item = "shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-blunderbuss", loothutboundingbox, 5.55,
{
	{item = "blunderbuss-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "piercing-shotgun-shell", probability = 1,  count_min = 15, count_max = 30},
	{item = "piercing-shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-blunderbuss", loothutboundingbox, 6.75,
{
	{item = "blunderbuss-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "explosive-shotgun-shell", probability = 1,  count_min = 15, count_max = 30},
	{item = "depleted-shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-blunderbuss", loothutboundingbox, 8.55,
{
	{item = "blunderbuss-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "depleted-shotgun-shell", probability = 1,  count_min = 15, count_max = 30},
	{item = "depleted-shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),


generate_storage_hut ("weapons0-autoshotgun", loothutboundingbox, 5.06,
{
	{item = "combat-shotgun", probability = 1, count_min = 1, count_max = 1},
	{item = "piercing-shotgun-shell", probability = 1,  count_min = 15, count_max = 30},
	{item = "piercing-shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons1-autoshotgun", loothutboundingbox, 6.06,
{
	{item = "combat-shotgun-uncommon", probability = 0.8, count_min = 1, count_max = 1},
	{item = "piercing-shotgun-shell", probability = 1,  count_min = 15, count_max = 30},
	{item = "piercing-shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-autoshotgun", loothutboundingbox, 7.06,
{
	{item = "combat-shotgun-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "piercing-shotgun-shell", probability = 1,  count_min = 15, count_max = 30},
	{item = "piercing-shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-autoshotgun", loothutboundingbox, 8.06,
{
	{item = "combat-shotgun-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "explosive-shotgun-shell", probability = 1,  count_min = 15, count_max = 30},
	{item = "depleted-shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-autoshotgun", loothutboundingbox, 9.06,
{
	{item = "combat-shotgun-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "depleted-shotgun-shell", probability = 1,  count_min = 15, count_max = 30},
	{item = "depleted-shotgun-shell", probability = 0.5, count_min = 5, count_max = 25},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),


generate_storage_hut ("weapons0-flamethrower", loothutboundingbox, 5.07,
{
	{item = "flamethrower", probability = 1, count_min = 1, count_max = 1},
	{item = "flamethrower-ammo", probability = 1, count_min = 15, count_max = 30},
	{item = "flamethrower-ammo", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons1-flamethrower", loothutboundingbox, 6.07,
{
	{item = "flamethrower-uncommon", probability = 0.8, count_min = 1, count_max = 1},
	{item = "flamethrower-ammo", probability = 1, count_min = 15, count_max = 30},
	{item = "flamethrower-ammo", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-flamethrower", loothutboundingbox, 7.07,
{
	{item = "flamethrower-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "flamethrower-ammo", probability = 1, count_min = 15, count_max = 30},
	{item = "flamethrower-ammo-napalm", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-flamethrower", loothutboundingbox, 8.07,
{
	{item = "flamethrower-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "flamethrower-ammo-napalm", probability = 1, count_min = 15, count_max = 30},
	{item = "flamethrower-ammo-napalm", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-flamethrower", loothutboundingbox, 9.07,
{
	{item = "flamethrower-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "flamethrower-ammo-napalm", probability = 1, count_min = 15, count_max = 30},
	{item = "flamethrower-ammo-napalm", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons0-rocket-launcher", loothutboundingbox, 8.08,
{
	{item = "rocket-launcher", probability = 1, count_min = 1, count_max = 1},
	{item = "rocket", probability = 1, count_min = 15, count_max = 30},
	{item = "rocket", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons1-rocket-launcher", loothutboundingbox, 9.08,
{
	{item = "rocket-launcher-uncommon", probability = 0.8, count_min = 1, count_max = 1},
	{item = "rocket", probability = 1, count_min = 15, count_max = 30},
	{item = "rocket", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-rocket-launcher", loothutboundingbox, 10.08,
{
	{item = "rocket-launcher-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "explosive-rocket", probability = 1, count_min = 15, count_max = 30},
	{item = "explosive-rocket", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-rocket-launcher", loothutboundingbox, 11.08,
{
	{item = "rocket-launcher-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "rocket-micro", probability = 1, count_min = 50, count_max = 200},
	{item = "explosive-rocket", probability = 0.5, count_min = 25, count_max = 55},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-rocket-launcher", loothutboundingbox, 12.08,
{
	{item = "rocket-launcher-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "rocket-micro", probability = 1, count_min = 50, count_max = 200},
	{item = "explosive-rocket", probability = 0.5, count_min = 45, count_max = 105},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons0-sniper-rifle", loothutboundingbox, 6.59,
{
	{item = "sniper-rifle", probability = 1, count_min = 1, count_max = 1},
	{item = "sniper-shell", probability = 1, count_min = 15, count_max = 30},
	{item = "sniper-shell", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons1-sniper-rifle", loothutboundingbox, 7.29,
{
	{item = "sniper-rifle-uncommon", probability = 0.8, count_min = 1, count_max = 1},
	{item = "sniper-shell", probability = 1, count_min = 15, count_max = 30},
	{item = "sniper-shell-piercing", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-sniper-rifle", loothutboundingbox, 8.39,
{
	{item = "sniper-rifle-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "sniper-shell-piercing", probability = 1, count_min = 15, count_max = 30},
	{item = "sniper-shell-piercing", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-sniper-rifle", loothutboundingbox, 9.09,
{
	{item = "sniper-rifle-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "sniper-shell-piercing", probability = 1, count_min = 15, count_max = 30},
	{item = "sniper-shell-uranium", probability = 0.25, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-sniper-rifle", loothutboundingbox, 10.19,
{
	{item = "sniper-rifle-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "sniper-shell-piercing", probability = 1, count_min = 15, count_max = 30},
	{item = "sniper-shell-uranium", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons0-multi-rocket-launcher", loothutboundingbox, 10.01,
{
	{item = "multirocket-launcher", probability = 1, count_min = 1, count_max = 1},
	{item = "rocket", probability = 1, count_min = 15, count_max = 30},
	{item = "rocket", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons1-multi-rocket-launcher", loothutboundingbox, 11.01,
{
	{item = "multirocket-launcher-uncommon", probability = 0.8, count_min = 1, count_max = 1},
	{item = "rocket", probability = 1, count_min = 15, count_max = 30},
	{item = "explosive-rocket", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-multi-rocket-launcher", loothutboundingbox, 12.01,
{
	{item = "multirocket-launcher-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "explosive-rocket", probability = 1, count_min = 15, count_max = 30},
	{item = "explosive-rocket", probability = 0.5, count_min = 15, count_max = 35},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-multi-rocket-launcher", loothutboundingbox, 13.01,
{
	{item = "multirocket-launcher-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "explosive-rocket", probability = 1, count_min = 50, count_max = 200},
	{item = "rocket-micro", probability = 0.5, count_min = 50, count_max = 200},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-multi-rocket-launcher", loothutboundingbox, 14.01,
{
	{item = "multirocket-launcher-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "rocket-micro", probability = 1, count_min = 50, count_max = 200},
	{item = "explosive-rocket", probability = 0.5, count_min = 45, count_max = 105},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons5-nuke", loothutboundingbox, 14.02,
{
	{item = "atomic-bomb", probability = 1, count_min = 1, count_max = 1},
	{item = "atomic-bomb", probability = 0.5, count_min = 1, count_max = 1},
	{item = "atomic-bomb", probability = 0.25, count_min = 1, count_max = 1},
	{item = "atomic-bomb", probability = 0.125, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons0-mini-gun", loothutboundingbox, 10.03,
{
	{item = "mini-gun", probability = 1, count_min = 1, count_max = 1},
	{item = "chaingun-ammo", probability = 1, count_min = 5, count_max = 10},
	{item = "chaingun-ammo", probability = 0.5, count_min = 5, count_max = 15},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons1-mini-gun", loothutboundingbox, 11.43,
{
	{item = "mini-gun-uncommon", probability = 0.8, count_min = 1, count_max = 1},
	{item = "chaingun-ammo", probability = 1, count_min = 5, count_max = 10},
	{item = "chaingun-ammo", probability = 0.5, count_min = 5, count_max = 15},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons2-mini-gun", loothutboundingbox, 11.83,
{
	{item = "mini-gun-rare", probability = 0.4, count_min = 1, count_max = 1},
	{item = "chaingun-ammo", probability = 1, count_min = 5, count_max = 10},
	{item = "chaingun-ammo-piercing", probability = 0.5, count_min = 5, count_max = 15},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons3-mini-gun", loothutboundingbox, 12.23,
{
	{item = "mini-gun-epic", probability = 0.2, count_min = 1, count_max = 1},
	{item = "chaingun-ammo-piercing", probability = 1, count_min = 5, count_max = 15},
	{item = "chaingun-ammo-piercing", probability = 0.5, count_min = 5, count_max = 15},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
generate_storage_hut ("weapons4-mini-gun", loothutboundingbox, 13.13,
{
	{item = "mini-gun-legendary", probability = 0.1, count_min = 1, count_max = 1},
	{item = "chaingun-ammo-piercing", probability = 1, count_min = 5, count_max = 15},
	{item = "chaingun-ammo-piercing", probability = 0.5, count_min = 5, count_max = 15},
	{item = "weapon-forge", probability = weaponforge_chance, count_min = 1, count_max = 1},
}),
}
    
data:extend{
generate_storage_hut ("grenades1", loothutboundingbox, 1.04,
{
	{item = "grenade", probability = 1, count_min = 5, count_max = 30},
	{item = "grenade", probability = 0.5, count_min = 5, count_max = 30},
}),
generate_storage_hut ("grenades2", loothutboundingbox, 3.04,
{
	{item = "flak-grenade", probability =  1, count_min = 5, count_max = 30},
	{item = "flak-grenade", probability =  0.5, count_min = 5, count_max = 30},
}),
generate_storage_hut ("grenades3", loothutboundingbox, 5.04,
{
	{item = "flak-grenade", probability =  1, count_min = 15, count_max = 30},
	{item = "cluster-grenade", probability = 0.75, count_min = 5, count_max = 30},
	{item = "cluster-grenade", probability =  0.5, count_min = 5, count_max = 30},
}),
generate_storage_hut ("grenades3a", loothutboundingbox, 6.04,
{
	{item = "cluster-grenade", probability =  1, count_min = 15, count_max = 30},
	{item = "cluster-grenade", probability = 0.75, count_min = 5, count_max = 30},
	{item = "he-grenade", probability =  0.5, count_min = 5, count_max = 30},
}),
generate_storage_hut ("grenades3b", loothutboundingbox, 9.04,
{
	{item = "cluster-grenade", probability = 1, count_min = 5, count_max = 60},
	{item = "he-grenade", probability =  0.5, count_min = 5, count_max = 30},
}),
generate_storage_hut ("grenades4", loothutboundingbox, 11.04,
{
	{item = "flak-grenade", probability =  0.75, count_min = 15, count_max = 30},
	{item = "he-grenade", probability = 1, count_min = 5, count_max = 10},
	{item = "mirv-grenade", probability =  0.5, count_min = 5, count_max = 10},
}),
generate_storage_hut ("grenades5", loothutboundingbox, 14.04,
{
	{item = "mirv-grenade", probability = 1, count_min = 15, count_max = 30},
	{item = "flak-grenade", probability =  1, count_min = 15, count_max = 60},
	{item = "he-grenade", probability =  0.5, count_min = 15, count_max = 60},
}),
}



--
--
--
--
--



local function generate_storage_hut_with_packages(data) 
	local _warehousename = data.warehouse_name
	local _created_entity = data.created_entity
	local _autoplace_distance = data.autoplace_distance

	local _picture
	local _collision_box
	local _selection_box

	

		if string.find(_warehousename,"weapon") or string.find(_warehousename,"equipment") or string.find(_warehousename,"turret")  or string.find(_warehousename,"magazine") or string.find(_warehousename,"rounds") or string.find(_warehousename,"shell") then
			_picture = building_ammocache_picture
			_collision_box = {{-3.75, -2.25}, {3.75, 2.25}}
			_selection_box = {{-3.85, -2.5}, {3.85, 2.5}}
			
		elseif string.find(_warehousename,"grenade") or string.find(_warehousename,"explosive") then
			_picture = building_explosivecache_picture
			_collision_box = {{-1.75, -2.25}, {1.75, 2.25}}
			_selection_box = {{-1.85, -2.5}, {1.85, 2.5}}
			
		elseif string.find(_warehousename,"tech") or string.find(_warehousename,"lab") or string.find(_warehousename,"sci")  then
			_picture = building_lab_picture
			_collision_box = {{-3.75, -2.25}, {3.75, 2.25}}
			_selection_box = {{-3.85, -2.5}, {3.85, 2.5}}
			
		else
			_picture =  
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
			}
			_collision_box = {{-2.25, -2.25}, {2.25, 2.25}}
			_selection_box = {{-2.5, -2.5}, {2.5, 2.5}}
	end
	
	newtrv()

	return
	{
		type = "container",
		name = "abandonment".."-".._warehousename,
		localised_description = {"entity-description.abandonment-warehouse"}, 
		localised_name = {"",abandonment_loc, " ", {"entity-name.warehouse"} },
		icon = "__factorioplus__/graphics/icons/warehouse.png",
		icon_size = 64, icon_mipmaps = 4,
		flags = {"placeable-off-grid"},
		max_health = 1250 * enemy_health_scale,
		corpse = "warehouse-remnants",
		dying_explosion = "electric-furnace-explosion",
		open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.53 },
		close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.53 },
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
		collision_box = _collision_box,
		selection_box = _selection_box,
		damaged_trigger_effect = hit_effects.entity(),
		
		inventory_size = 10,
		vehicle_impact_sound = sounds.generic_impact,
		picture = _picture,
		build_base_evolution_requirement = 10,
		map_generator_bounding_box = {{ -loothutboundingbox, -loothutboundingbox}, {loothutboundingbox, loothutboundingbox}},
		autoplace = abandonments_autoplace.abandonments_loot_autoplace(loot_autoplace(_autoplace_distance)),
		enemy_map_color = abandonments_bonus_color_map,
		
		dying_trigger_effect =
		{
		  {
			type = "create-entity",
			entity_name = "loot-proxy-" .. _created_entity,
			-- offsets =
			-- {
				-- {-1.25,0}, {1.25,0}, 
				-- {-1.25,2}, {1.25,2}, 				
			-- }
		  },
		   -- {
			-- type = "create-entity",
			-- entity_name = "warehouse-remnants",
			-- offsets =
			-- {
				-- {0,0}		
			-- }
		  -- }
		}
	   -- circuit_connector = circuit_connector_definitions["warehouse"],
	   -- circuit_wire_max_distance = default_circuit_wire_max_distance,
	}
end


function create_abandonment_package(data)
	local _item = data.item
	local _tier = data.tier or 1
	local _count = data.count or 100
	local _countdeviation = data.count_deviation or 1.5
	local _count_max = _count
	local _count_min = _count / _countdeviation
	local _tint = data.tint or {0.25, 0.25, 0.25}
	local _tint_item = data.tint_item or {1, 1, 1}
	return
	{
		name = "abandonment-package-".._item.. "-".._tier,
		type = "simple-entity",
		
		localised_name = {"",abandonment_loc, " ", {"item-name.".. _item}, " ", {"entity-name.package"} },
		
		flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
		icon = "__factorioplus__/graphics/icons/abandonment-package.png",
		icon_size = 64, icon_mipmaps = 4,
		
		collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
		selection_box = {{-1, -1}, {1, 1}},
		
		hidden = true,
		damaged_trigger_effect = hit_effects.entity(),
		impact_category = "metal",
		dying_explosion = "steel-chest-explosion",
		mined_sound = sounds.deconstruct_small(1.0),
		corpse = "small-remnants",
		enemy_map_color = abandonments_bonus_color_map,
		minable =
		{
		  mining_time = 2,
		   results = 
		  {
		  {type = "item", name = _item, amount_min = _count_min, amount_max = _count_max}, 
		  },
		},
		render_layer = "object",
		max_health = 800,
		resistances =
	   {
			{
			type = "acid",
			percent = 50
		  },
		  {
			type = "fire",
			percent = 50
		  },
		  {
			type = "physical",
			percent = 50
		  },
		  {
			type = "impact",
			percent = 50
		  },
		  {
			type = "piercing",
			percent = 50
		  },
		  {
			type = "explosion",
			percent = 25
		  },
			  {
			type = "electric",
			percent = 90
		  },
		  {
			type = "laser",
			percent = 90
		  },
		},
		pictures = package_pictures(_tint,_tint_item),
		
	}
end

function make_loot_proxy(data)

	local _name = data.name
	local _packagecount = data.package_count
	local _packagecountdeviation = data.packagecount_deviation
	local _packagename = data.loot_entity

	return
	{
		name = "loot-proxy-".._name,
		type = "turret",
		flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
		icon = "__factorioplus__/graphics/icons/abandonment-package.png",
		icon_size = 64, icon_mipmaps = 4,
	--    subgroup = "enemies",
	--    collision_box = {{-2 * scale, -2 * scale}, {2 * scale, 2 * scale}},
	--    selection_box = {{-2 * scale, -2 * scale}, {2 * scale, 2 * scale}},

		render_layer = "object",
		max_health = 1,
		healing_per_tick = -(1000),
		call_for_help_radius = 0,
		
		folded_animation = 
		{
			north =
			{
				  filename = "__factorioplus__/graphics/enemies/hatcher_egg.png",
				  width = 1,
				  height = 1,
				  scale = 0.1,
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
					  type = "damage",
					  show_in_tooltip = false,
					  damage = { amount = 0 , type = "physical"}
					}
				  }
				}
			},	
		},
			
		
		dying_trigger_effect = 
		{
		  {
			type = "create-entity",
			repeat_count = _packagecount,
			repeat_count_deviation = _packagecountdeviation,
			entity_name = _packagename,
			find_non_colliding_position = true,
		  },

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
							  width = 1,
							  height = 1,
							  scale = 1,
							  shift = {0,0},
							}
						},
					},
				},
			},
		}
	}
end



function create_warehouse_package_set(package_name, placement_distance, amount_of_packages, amount_of_packages_deviation)

	local _distancetruncated = math.floor(placement_distance)
	local _sharedname = "resources-" .. package_name .. amount_of_packages .. "-packages-" .. _distancetruncated

	return
	table.unpack({
		make_loot_proxy({
			name = _sharedname,
			loot_entity = package_name,
			package_count = amount_of_packages,
			packagecount_deviation = amount_of_packages_deviation,
		}),
		generate_storage_hut_with_packages({
			warehouse_name = package_name .. "-".. _distancetruncated,
			created_entity = _sharedname,
			autoplace_distance = placement_distance
		})

	})
end

-- IRON PLATES

local iron_tint = {152 , 194 , 212 }

data:extend({
	create_abandonment_package({
	item = "iron-plate",
	tier = 1,
	count = 400,
	tint = iron_tint ,
	tint_item = {110 , 110 , 110} ,
	}),
})

data:extend({ create_warehouse_package_set("abandonment-package-iron-plate-1", 2.101, 5, 1) })

data:extend({ create_warehouse_package_set("abandonment-package-iron-plate-1", 1.101, 3, 1) })

-- STEEL PLATES

local steel_tint = {200 , 200 , 208 }

data:extend({
	create_abandonment_package({
	item = "steel-plate",
	tier = 1,
	count = 400,
	tint = steel_tint ,
	tint_item = {150 , 150 , 150} ,
	}),
})

data:extend({ create_warehouse_package_set("abandonment-package-steel-plate-1", 2.102, 3, 1) })

data:extend({ create_warehouse_package_set("abandonment-package-steel-plate-1", 3.102, 5, 1) })

-- COPPER PLATES

local copper_tint = {181 , 98 , 76 }

data:extend({
	create_abandonment_package({
	item = "copper-plate",
	tier = 1,
	count = 400,
	tint = copper_tint,
	tint_item = copper_tint ,
	}),
})

data:extend({ create_warehouse_package_set("abandonment-package-copper-plate-1", 1.103, 3, 1) })

data:extend({ create_warehouse_package_set("abandonment-package-copper-plate-1", 2.103, 5, 1) })



-- ALUMINIUM PLATES

local aluminum_tint = {220 , 220 , 220 }

data:extend({
	create_abandonment_package({
	item = "aluminium-plate",
	tier = 1,
	count = 400,
	tint = aluminum_tint,
	tint_item = {190 , 190 , 190},
	}),
})

data:extend({ create_warehouse_package_set("abandonment-package-aluminium-plate-1", 3.104, 4, 1) })

data:extend({ create_warehouse_package_set("abandonment-package-aluminium-plate-1", 5.104, 6, 1) })



-- PLASTIC BARS

local plastic_tint = {255 , 255 , 255 }


data:extend({
	create_abandonment_package({
	item = "plastic-bar",
	tier = 1,
	count = 400,
	tint = plastic_tint,
	tint_item = plastic_tint,
	}),
})

data:extend({ create_warehouse_package_set("abandonment-package-plastic-bar-1", 3.105, 4, 1) })

data:extend({ create_warehouse_package_set("abandonment-package-plastic-bar-1", 4.105, 6, 1) })

-- CHIPS

data:extend({
	create_abandonment_package({
	item = "electronic-circuit",
	tier = 1,
	count = 200,
	tint = {255 , 255 , 0 },
	tint_item = {0 , 240 , 50 },
	}), 
})

data:extend({ create_warehouse_package_set("abandonment-package-electronic-circuit-1", 1.106, 3, 1) })

data:extend({ create_warehouse_package_set("abandonment-package-electronic-circuit-1", 3.106, 6, 1) })

data:extend({
	create_abandonment_package({
	item = "advanced-circuit",
	tier = 1,
	count = 200,
	tint = {255 , 255 , 0 },
	tint_item = {240 , 0 , 0 },
	}), 
})

data:extend({ create_warehouse_package_set("abandonment-package-advanced-circuit-1", 2.107, 3, 1) })

data:extend({ create_warehouse_package_set("abandonment-package-advanced-circuit-1", 5.107, 6, 1) })

data:extend({
	create_abandonment_package({
	item = "processing-unit",
	tier = 1,
	count = 200,
	tint = {255 , 255 , 0 },
	tint_item = {60 , 0 , 240 },
	}), 
})

data:extend({ create_warehouse_package_set("abandonment-package-processing-unit-1", 3.108, 3, 1) })

data:extend({ create_warehouse_package_set("abandonment-package-processing-unit-1", 8.108, 6, 1) })

data:extend({
	create_abandonment_package({
	item = "cpu-item",
	tier = 1,
	count = 200,
	tint = {255 , 255 , 0 },
	tint_item = {240 , 60 , 140 },
	}), 
})

data:extend({ create_warehouse_package_set("abandonment-package-cpu-item-1", 5.109, 3, 1) })

data:extend({ create_warehouse_package_set("abandonment-package-cpu-item-1", 10.109, 6, 1) })

-- SCI

data:extend({
	create_abandonment_package({
	item = "automation-science-pack",
	tier = 1,
	count = 300,
	tint = {255 , 255 , 255 },
	tint_item = {240 , 80 , 81 },
	}), 
})

data:extend({ create_warehouse_package_set("abandonment-package-automation-science-pack-1", 1.111, 3, 1) })

data:extend({ create_warehouse_package_set("abandonment-package-automation-science-pack-1", 3.111, 6, 1) })


data:extend({
	create_abandonment_package({
	item = "logistic-science-pack",
	tier = 1,
	count = 300,
	tint = {255 , 255 , 255 },
	tint_item = {84 , 242 , 96 },
	}),
})

data:extend({ create_warehouse_package_set("abandonment-package-logistic-science-pack-1", 2.112, 3, 1) })

data:extend({ create_warehouse_package_set("abandonment-package-logistic-science-pack-1", 4.112, 6, 1) })

data:extend({
	create_abandonment_package({
	item = "chemical-science-pack",
	tier = 1,
	count = 300,
	tint = {255 , 255 , 255 },
	tint_item = {83 , 238 , 244 },
	})
})

data:extend({create_warehouse_package_set("abandonment-package-chemical-science-pack-1", 3.113, 3, 1) })

data:extend({create_warehouse_package_set("abandonment-package-chemical-science-pack-1", 6.113, 6, 1) })

data:extend({
	create_abandonment_package({
	item = "bio-science-pack",
	tier = 1,
	count = 300,
	tint = {255 , 255 , 255 },
	tint_item = {255 , 174 , 255 },
	})
})

data:extend({create_warehouse_package_set("abandonment-package-bio-science-pack-1", 3.114, 3, 1)})

data:extend({create_warehouse_package_set("abandonment-package-bio-science-pack-1", 6.114, 6, 2)})

data:extend({create_warehouse_package_set("abandonment-package-bio-science-pack-1", 8.114, 10, 3)})


data:extend({
	create_abandonment_package({
	item = "military-science-pack",
	tier = 1,
	count = 300,
	tint = {255 , 255 , 255 },
	tint_item = {149/2 , 155/2 , 177/2 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-military-science-pack-1", 2.115, 3, 1)})

data:extend({create_warehouse_package_set("abandonment-package-military-science-pack-1", 4.115, 6, 2)})

data:extend({create_warehouse_package_set("abandonment-package-military-science-pack-1", 6.115, 8, 3)})

data:extend({
	create_abandonment_package({
	item = "utility-science-pack",
	tier = 1,
	count = 300,
	tint = {255 , 255 , 255 },
	tint_item = {255, 244 , 93 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-utility-science-pack-1", 5.116, 3, 1)})

data:extend({create_warehouse_package_set("abandonment-package-utility-science-pack-1", 9.116, 6, 1)})

data:extend({
	create_abandonment_package({
	item = "production-science-pack",
	tier = 1,
	count = 300,
	tint = {255 , 255 , 255 },
	tint_item = {219 , 61 , 239 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-production-science-pack-1", 5.117, 3, 1)})

data:extend({create_warehouse_package_set("abandonment-package-production-science-pack-1", 9.117, 6, 1)})

data:extend({
	create_abandonment_package({
	item = "firearm-magazine",
	tier = 1,
	count = 200,
	tint = {50 , 50 , 50 },
	tint_item = {255 , 255 , 0 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-firearm-magazine-1", 1.121, 4, 1)})

data:extend({
	create_abandonment_package({
	item = "piercing-rounds-magazine",
	tier = 1,
	count = 200,
	tint = {50 , 50 , 50 },
	tint_item = {0 , 255 , 255 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-piercing-rounds-magazine-1", 2.122, 4, 1)})

data:extend({
	create_abandonment_package({
	item = "longrange-rounds-magazine",
	tier = 1,
	count = 200,
	tint = {50 , 50 , 50 },
	tint_item = {200 , 0 , 255 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-longrange-rounds-magazine-1", 2.123, 4, 1)})

data:extend({
	create_abandonment_package({
	item = "explosive-rounds-magazine",
	tier = 1,
	count = 100,
	tint = {50 , 50 , 50 },
	tint_item = {255 , 0 , 0 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-explosive-rounds-magazine-1", 3.124, 4, 1)})

data:extend({
	create_abandonment_package({
	item = "uranium-rounds-magazine",
	tier = 1,
	count = 100,
	tint = {50 , 50 , 50 },
	tint_item = {0 , 100 , 0 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-uranium-rounds-magazine-1", 5.125, 3, 1)})

data:extend({
	create_abandonment_package({
	item = "nuke-rounds-magazine",
	tier = 1,
	count = 25,
	tint = {50 , 50 , 50 },
	tint_item = {0 , 255 , 0 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-nuke-rounds-magazine-1", 8.126, 3, 1)})

data:extend({
	create_abandonment_package({
	item = "shotgun-shell",
	tier = 1,
	count = 100,
	tint = {50 , 50 , 50 },
	tint_item = {255 , 255 , 0 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-shotgun-shell-1", 1.127, 4, 1)})


data:extend({
	create_abandonment_package({
	item = "piercing-shotgun-shell",
	tier = 1,
	count = 100,
	tint = {50 , 50 , 50 },
	tint_item = {0 , 255 , 255 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-piercing-shotgun-shell-1", 2.128, 4, 1)})

data:extend({
	create_abandonment_package({
	item = "explosive-shotgun-shell",
	tier = 1,
	count = 100,
	tint = {50 , 50 , 50 },
	tint_item = {255 , 0 , 0 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-explosive-shotgun-shell-1", 3.129, 4, 1)})

data:extend({
	create_abandonment_package({
	item = "shotgun-shell-birdshot",
	tier = 1,
	count = 100,
	tint = {50 , 50 , 50 },
	tint_item = {200 , 0 , 255 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-shotgun-shell-birdshot-1", 5.128, 4, 1)})


data:extend({
	create_abandonment_package({
	item = "depleted-shotgun-shell",
	tier = 1,
	count = 100,
	tint = {50 , 50 , 50 },
	tint_item = {0 , 100 , 0 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-depleted-shotgun-shell-1", 7.129, 4, 2)})

data:extend({
	create_abandonment_package({
	item = "nuke-shotgun-shell",
	tier = 1,
	count = 100,
	tint = {50 , 50 , 50 },
	tint_item = {0 , 255 , 0 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-nuke-shotgun-shell-1", 9.129, 3, 2)})

data:extend({
	create_abandonment_package({
	item = "rocket",
	tier = 1,
	count = 200,
	tint = {50 , 50 , 50 },
	tint_item = {255 , 255 , 0 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-rocket-1", 4, 4, 2)})

data:extend({
	create_abandonment_package({
	item = "explosive-rocket",
	tier = 1,
	count = 50,
	tint = {50 , 50 , 50 },
	tint_item = {255 , 0 , 0 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-explosive-rocket-1", 7, 4, 1)})

data:extend({
	create_abandonment_package({
	item = "rocket-micro",
	tier = 1,
	count = 200,
	tint = {50 , 50 , 50 },
	tint_item = {0 , 0 , 200 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-rocket-micro-1", 6, 4, 2)})

data:extend({
	create_abandonment_package({
	item = "landfill",
	tier = 1,
	count = 600,
	tint = {60 , 40 , 30 },
	tint_item = {60 , 40 , 30 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-landfill-1", 2.122, 3, 1)})
data:extend({create_warehouse_package_set("abandonment-package-landfill-1", 5.122, 6, 2)})

data:extend({
	create_abandonment_package({
	item = "cliff-explosives",
	tier = 1,
	count = 50,
	tint = {60 , 40 , 30 },
	tint_item = {30 , 180 , 255 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-cliff-explosives-1", 3.123, 3, 1)})
data:extend({create_warehouse_package_set("abandonment-package-cliff-explosives-1", 6.123, 5, 2)})

data:extend({
	create_abandonment_package({
	item = "landfill-deep",
	tier = 1,
	count = 400,
	tint = {60 , 70 , 190 },
	tint_item = {60 , 40 , 30} ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-landfill-deep-1", 5.134, 3, 1)})
data:extend({create_warehouse_package_set("abandonment-package-landfill-deep-1", 10.134, 5, 2)})


data:extend({
	create_abandonment_package({
	item = "waterfill-barrel",
	tier = 1,
	count = 500,
	tint = {60 , 70 , 190 },
	tint_item = {100 , 100 , 100 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-waterfill-barrel-1", 5.145, 5, 1)})
data:extend({create_warehouse_package_set("abandonment-package-waterfill-barrel-1", 10.145, 7, 2)})

data:extend({
	create_abandonment_package({
	item = "stone-brick",
	tier = 1,
	count = 400,
	tint = {120 , 120 , 120 },
	tint_item = {100 , 100 , 100 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-stone-brick-1", 1.156, 3, 1)})
data:extend({create_warehouse_package_set("abandonment-package-stone-brick-1", 3.156, 5, 2)})
data:extend({create_warehouse_package_set("abandonment-package-stone-brick-1", 6.156, 7, 3)})

data:extend({
	create_abandonment_package({
	item = "concrete",
	tier = 1,
	count = 400,
	tint = {120 , 120 , 120 },
	tint_item = {120 , 120 , 120 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-concrete-1", 3.167, 4, 1)})
data:extend({create_warehouse_package_set("abandonment-package-concrete-1", 7.167, 8, 2)})

data:extend({
	create_abandonment_package({
	item = "refined-concrete",
	tier = 1,
	count = 400,
	tint = {120 , 120 , 120 },
	tint_item = {150 , 150 , 150 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-refined-concrete-1", 4.178, 4, 1)})
data:extend({create_warehouse_package_set("abandonment-package-refined-concrete-1", 9.178, 8, 2)})


data:extend({
	create_abandonment_package({
	item = "rail",
	tier = 1,
	count = 400,
	tint = {120 , 120 , 120 },
	tint_item = {100 , 80 , 40 } ,
	})
})

data:extend({create_warehouse_package_set("abandonment-package-rail-1", 2.187, 3, 1)})
data:extend({create_warehouse_package_set("abandonment-package-rail-1", 4.487, 5, 2)})
data:extend({create_warehouse_package_set("abandonment-package-rail-1", 6.887, 7, 3)})

end
