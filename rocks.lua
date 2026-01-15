local sounds = require ("__base__.prototypes.entity.sounds")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local decorative_trigger_effects = require("__base__.prototypes.decorative.decorative-trigger-effects")
local util = require("util") 

--- BAOBAO TREES BEEFYNESS

data.raw["tree"]["tree-09"].minable.mining_time = 1.0
data.raw["tree"]["tree-09"].minable.count = 8
data.raw["tree"]["tree-09"].max_health = 125
data.raw["tree"]["tree-09-brown"].minable.mining_time = 1.0
data.raw["tree"]["tree-09-brown"].minable.count = 8
data.raw["tree"]["tree-09-brown"].max_health = 125
data.raw["tree"]["tree-09-red"].minable.mining_time = 1.0
data.raw["tree"]["tree-09-red"].minable.count = 8
data.raw["tree"]["tree-09-red"].max_health = 125

 for i, v in ipairs(data.raw["tree"]) do
	v.resistances =  
	{
		{
        type = "acid",
        percent = -80
		},
	}
 end
 
-- WATER DETAILS

local water_grass = util.copy(data.raw["optimized-decorative"]["green-hairy-grass"])
water_grass.name = "water-grass"
water_grass.autoplace =
  {
	placement_density = 2,
      order = "a[doodad]-f[grass]-a",
      probability_expression = "-1.2 + rpi(0.6) + 0.8 * grass_noise - min(0, decorative_knockout) + region_box",
      local_expressions =
      {
        region_box = "range_select{input = moisture, from = 0.5, to = 1, slope = 0.05, min = -10, max = 1}"
      }
    }
water_grass.autoplace.tile_restriction = {"water-shallow"}
water_grass.collision_mask = {layers={ground_tile=true}, colliding_with_tiles_only=true}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["decorative"].settings["water-grass"] = {}

local water_bush = util.copy(data.raw["optimized-decorative"]["green-bush-mini"])
water_bush.name = "water-bush"
water_bush.autoplace =
 {
  order = "a[doodad]-c[croton]-a",
  placement_density = 2,
  probability_expression = "-2 + rpi(0.9) + 1.5 * croton_noise + max(0, decorative_knockout) + region_box",
  local_expressions =
  {
	region_box = "min(range_select{input = moisture, from = 0.5, to = 1, slope = 0.05, min = -10, max = 1},\z
					  range_select{input = temperature, from = 10, to = 14.5, slope = 0.5, min = -10, max = 1})"
  }
}
water_bush.autoplace.tile_restriction = {"water-shallow"}
water_bush.collision_mask = {layers={ground_tile=true}, colliding_with_tiles_only=true}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["decorative"].settings["water-bush"] = {}


if data.raw["optimized-decorative"]["tiny-rock"] and
   data.raw["optimized-decorative"]["tiny-rock"].autoplace and
   data.raw["optimized-decorative"]["small-sand-rock"] and
   data.raw["optimized-decorative"]["small-sand-rock"].autoplace then

    -- Copy and modify tiny-rock
    local water_rock = util.copy(data.raw["optimized-decorative"]["tiny-rock"])
    water_rock.name = "water-rock"

    -- Deepcopy autoplace including the noise expression, then safely add tile restriction
    water_rock.autoplace = table.deepcopy(data.raw["optimized-decorative"]["tiny-rock"].autoplace)

    -- Modify tile_restriction safely, preserving noise expressions
    if water_rock.autoplace.tile_restriction then
        table.insert(water_rock.autoplace.tile_restriction, "water-shallow")
    else
        water_rock.autoplace.tile_restriction = {"water-shallow"}
    end

    water_rock.collision_mask = {
        layers = {ground_tile = true},
        colliding_with_tiles_only = true
    }

    -- Copy and modify small-sand-rock similarly
    local water_sand_rock = util.copy(data.raw["optimized-decorative"]["small-sand-rock"])
    water_sand_rock.name = "water_sand_rock"

    water_sand_rock.autoplace = table.deepcopy(data.raw["optimized-decorative"]["small-sand-rock"].autoplace)

    if water_sand_rock.autoplace.tile_restriction then
        table.insert(water_sand_rock.autoplace.tile_restriction, "water-shallow")
    else
        water_sand_rock.autoplace.tile_restriction = {"water-shallow"}
    end

    water_sand_rock.collision_mask = {
        layers = {ground_tile = true},
        colliding_with_tiles_only = true
    }

    -- Register the new decorative prototypes
    data:extend({water_rock, water_sand_rock})

    -- Add them to the planet autoplace settings as empty tables to avoid errors
    data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["decorative"].settings["water-rock"] = {}
    data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["decorative"].settings["water_sand_rock"] = {}
else
    -- Base decorations or autoplace missing: log a warning or skip creating water-rocks
    log("Warning: Base optimized-decorative 'tiny-rock' or 'small-sand-rock' or their autoplace data missing. Skipping water-rock creation.")
end
   
 data:extend
({
water_grass,
water_bush,
water_rock,
water_sand_rock
 })

--- ROCKS PASS

--[[
local base_miningtime_rock = 5
local base_miningtime_rocksandy = 3
local rock_scale_increase = 1.5
local rock_results = 
{
	{type = "item", name = "stone", amount_min = 40, amount_max = 80}, 
	{type = "item", name = "coal", amount_min = 4, amount_max = 12}
}

 for i, v in pairs(data.raw["simple-entity"]) do
	if string.find(v.name,"rock")
		local col_box =
		{ 
			{v.collision_box[1][1] * rock_scale_increase, v.collision_box[1][2] * rock_scale_increase},
			{v.collision_box[2][1] * rock_scale_increase, v.collision_box[2][2] * rock_scale_increase} 
		}   	
		v.collision_box = col_box 
		v.selection_box = col_box
		 
		v.minable.mining_time = v.minable.mining_time * rock_scale_increase
	end
 end
	
	]]--
	
-- END ROCKS PASS

local rock_region_box = "range_select_base(moisture, 0.15, 1, 0.2, -10, 0)"
local autoplace_rock_massive =  
{
  control = "rocks",
  order = "a[doodad]-a[rock]-9[massive]",
  probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
  local_expressions =
  {
	multiplier = 0.09,
	penalty = 1.7,
	region_box = "range_select_base(moisture, 0.35, 1, 0.2, -10, 0)",
	control = "control:rocks:size"
  }
}

local autoplace_rock_huge =
{
  control = "rocks",
  order = "a[doodad]-a[rock]-a[huge]",
  probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
  local_expressions =
  {
	multiplier = 0.16,
	penalty = 1.7,
	region_box = "range_select_base(moisture, 0.35, 1, 0.2, -10, 0)",
	control = "control:rocks:size"
  }
}



local autoplace_rock_big =
{
  control = "rocks",
  order = "a[doodad]-a[rock]-b[big]",
  probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
  local_expressions =
  {
	multiplier = 0.26,
	penalty = 1.6,
	region_box = "range_select_base(moisture, 0.35, 1, 0.2, -10, 0)",
	control = "control:rocks:size"
  }
}

 local autoplace_rock_bigmedium =
{
  control = "rocks",
  order = "a[doodad]-a[rock]-c[medium]",
  probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
  local_expressions =
  {
	multiplier = 0.32,
	penalty = 1.5,
	region_box = "range_select_base(moisture, 0.35, 1, 0.2, -10, 0)",
	control = "control:rocks:size"
  }
}

 local autoplace_rock_medium =
{
  control = "rocks",
  order = "a[doodad]-a[rock]-c[medium]",
  probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
  local_expressions =
  {
	multiplier = 0.5,
	penalty = 1.2,
	region_box = "range_select_base(moisture, 0.35, 1, 0.2, -10, 0)",
	control = "control:rocks:size"
  }
}
	
 local autoplace_rock_small =
{
  control = "rocks",
  order = "a[doodad]-a[rock]-d[small]",
  probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
  local_expressions =
  {
	multiplier = 0.7,
	penalty = 1.1,
	region_box = "range_select_base(moisture, 0.35, 1, 0.2, -10, 0)",
	control = "control:rocks:size"
  }
}
	
local autoplace_rock_tiny =
    {
      control = "rocks",
      order = "a[doodad]-a[rock]-e[tiny]",
      placement_density = 2,
      probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
      local_expressions =
      {
        multiplier = 0.9,
        penalty = 0.5,
        region_box = rock_region_box,
        control = "control:rocks:size"
      }
    }
	
	
	
local autoplace_rock_big_red =
    {
      control = "rocks",
      order = "a[doodad]-a[rock]-b[big]",
      probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
      local_expressions =
      {
        multiplier = 0.4,
        penalty = 1.6,
        region_box = "min(aux_range, moisture_range)",
        aux_range = "range_select_base(aux, 0.3, 1, 0.3, -10, 0)",
        moisture_range = "range_select_base(moisture, 0, 0.3, 0.2, -10, 0)",
        control = "control:rocks:size"
      }
    }
	
local autoplace_rock_medium_red =
    {
      control = "rocks",
      order = "a[doodad]-a[rock]-c[medium]",
      probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
      local_expressions =
      {
        multiplier = 0.8,
        penalty = 1.3,
         region_box = "min(aux_range, moisture_range)",
        aux_range = "range_select_base(aux, 0.3, 1, 0.3, -10, 0)",
        moisture_range = "range_select_base(moisture, 0, 0.3, 0.2, -10, 0)",
        control = "control:rocks:size"
      }
    }

local autoplace_rock_small_red =
    {
      control = "rocks",
      order = "a[doodad]-a[rock]-d[small]",
      placement_density = 2,
      probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
      local_expressions =
      {
        multiplier = 1.2,
        penalty = 1.0,
        region_box = "min(aux_range, moisture_range)",
        aux_range = "range_select_base(aux, 0.3, 1, 0.3, -10, 0)",
        moisture_range = "range_select_base(moisture, 0, 0.3, 0.2, -10, 0)",
        control = "control:rocks:size"
      }
    }
	
	-- range_select_base => {"input", "from", "to", "slope", "min", "max"},
--expression_in_range_base => "aux_from", "moisture_from", "aux_to", "moisture_to"},
	
local autoplace_rocksandy_big =
    {
      control = "rocks",
      order = "a[doodad]-a[rock]-b[big]",
      probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
      local_expressions =
      {
        multiplier = 0.4,
        penalty = 1.6,
        region_box = "min(aux_range, moisture_range)",
        aux_range = "range_select_base(aux, 0.0 , 0.3, 0.3, -10, 0)",
        moisture_range = "range_select_base(moisture, 0, 0.3, 0.2, -10, 0)",
        control = "control:rocks:size"
      }
    }
local autoplace_rocksandy_bigmedium =
    {
      control = "rocks",
      order = "a[doodad]-a[rock]-b[bigmedium]",
      probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
      local_expressions =
      {
        multiplier = 0.5,
        penalty = 1.5,
        region_box = "min(aux_range, moisture_range)",
        aux_range = "range_select_base(aux, 0.0 , 0.3, 0.3, -10, 0)",
        moisture_range = "range_select_base(moisture, 0, 0.3, 0.2, -10, 0)",
        control = "control:rocks:size"
      }
    }

local autoplace_rocksandy_medium =
    {
      control = "rocks",
      order = "a[doodad]-a[rock]-c[medium]",
      probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
      local_expressions =
      {
        multiplier = 0.7,
        penalty = 1.5,
        region_box = "min(aux_range, moisture_range)",
        aux_range = "range_select_base(aux, 0.0 , 0.3, 0.3, -10, 0)",
        moisture_range = "range_select_base(moisture, 0, 0.3, 0.2, -10, 0)",
        control = "control:rocks:size"
      }
    }
	
local autoplace_rocksandy_small =
    {
      control = "rocks",
      order = "a[doodad]-a[rock]-d[small]",
      placement_density = 2,
      probability_expression = "multiplier * control * (region_box + rock_density - penalty)",
      local_expressions =
      {
        multiplier = 0.8,
        penalty = 1.4,
        region_box = "min(aux_range, moisture_range)",
        aux_range = "range_select_base(aux, 0.0 , 0.3, 0.3, -10, 0)",
        moisture_range = "range_select_base(moisture, 0, 0.3, 0.2, -10, 0)",
        control = "control:rocks:size"
      }
    }

data:extend
({
{
    name = "rock-massive",
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/huge-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "grass",
    order = "b[decorative]-l[rock]-9[massive]",
    collision_box = {{-5.5, -4.0}, {5.5, 4.0}},
    selection_box = {{-5.7, -4.2}, {5.7, 4.2}},
    damaged_trigger_effect = hit_effects.rock(),
    dying_trigger_effect = decorative_trigger_effects.huge_rock(),
	-- corpse = "huge-rock",
	--remains_when_mined = "huge-rock",
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 18,
      results = 
	  {
	  {type="item", name = "stone", amount_min = 198/3, amount_max = 340/2}, 
	  {type="item", name = "coal", amount_min = 74/3, amount_max = 150/2}
	  },
    },
    loot =
    {
      {type="item", item = "stone", probability = 1, count_min = 65/2, count_max = 90/2},
	  {type="item", item = "coal",  probability = 1, amount_min = 34/2, amount_max = 50/2}
    },
    count_as_rock_for_filtered_deconstruction = true,
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    vehicle_impact_sound = sounds.car_stone_impact,
    render_layer = "object",
    max_health = 1500,
    resistances =
    {
	  {
        type = "acid",
        percent = -80
      },
      {
        type = "fire",
        percent = 100
      },
	  {
        type = "physical",
        percent = 95
      },
	  {
        type = "impact",
        percent = 95
      },
	  {
        type = "piercing",
        percent = 75
      },
	  {
        type = "explosion",
        percent = 25
      },
	  {
        type = "electric",
        percent = 100
      },
	  {
        type = "laser",
        percent = 90
      },
    },
    autoplace = autoplace_rock_massive,
    pictures =
    {
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-17.png",
          width = 332,
          height = 228,
          scale = 1.5,
          shift = {0.226562, 0.046875}

      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-18.png",
          width = 290,
          height = 243,
          scale = 1.5,
          shift = {0.195312, 0.0390625}

      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-19.png",
          width = 349,
          height = 225,
          scale = 1.5,
          shift = {1.509375, 0.0234375}

      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-20.png",
          width = 287,
          height = 250,
          scale = 1.5,
          shift = {0.160625, 0.03125}

      }
    }
  },
  {
    name = "huge-rock",
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/huge-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "grass",
    order = "b[decorative]-l[rock]-a[huge]",
    collision_box = {{-3.8/1.1, -2.9/1.1}, {3.8/1.1, 2.9/1.1}},
    selection_box = {{-4.0/1.1, -3.1/1.1}, {4.0/1.1, 3.1/1.1}},
    damaged_trigger_effect = hit_effects.rock(),
    dying_trigger_effect = decorative_trigger_effects.huge_rock(),
	-- corpse = "big-rock",
	--remains_when_mined = "big-rock",
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 12,
      results = 
	  {
	  {type = "item", name = "stone", amount_min = 156/2, amount_max = 240/2}, 
	  {type = "item",name = "coal", amount_min = 54/2, amount_max = 100/2}
	  },
    },
    loot =
    {
      {type = "item", item = "stone", probability = 1, count_min = 55/2, count_max = 80/2},
	  {type = "item", item = "coal",  probability = 1, amount_min = 24/2, amount_max = 40/2}
    },
    count_as_rock_for_filtered_deconstruction = true,
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    vehicle_impact_sound = sounds.car_stone_impact,
    render_layer = "object",
    max_health = 1200,
    resistances =
    {
	 {
        type = "acid",
        percent = -80
      },
      {
        type = "fire",
        percent = 100
      },
	  {
        type = "physical",
        percent = 95
      },
	  {
        type = "impact",
        percent = 95
      },
	  {
        type = "piercing",
        percent = 75
      },
	  {
        type = "explosion",
        percent = 25
      },
	  	  {
        type = "electric",
        percent = 100
      },
	  {
        type = "laser",
        percent = 90
      },
    },
    autoplace = autoplace_rock_huge,
    pictures =
    {
      {
 
          filename = "__base__/graphics/decorative/huge-rock/huge-rock-05.png",
          width = 201,
          height = 179,
          scale = 1.3,
          shift = {0.25, 0.0625}

      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-06.png",
          width = 233,
          height = 171,
          scale =  1.3,
          shift = {0.429688, 0.046875}
        
      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-07.png",
          width = 240,
          height = 192,
          scale =  1.3,
          shift = {0.398438, 0.03125}
        
      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-08.png",
          width = 219,
          height = 175,
          scale = 1.3,
          shift = {0.148438, 0.132812}
        
      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-09.png",
          width = 240,
          height = 208,
          scale = 1.3,
          shift = {0.3125, 0.0625}
        
      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-10.png",
          width = 243,
          height = 190,
          scale = 1.3,
          shift = {0.1875, 0.046875}
        
      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-11.png",
          width = 249,
          height = 185,
          scale = 1.3,
          shift = {0.398438, 0.0546875}
        
      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-12.png",
          width = 273,
          height = 163,
          scale = 1.3,
          shift = {0.34375, 0.0390625}
        
      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-13.png",
          width = 275,
          height = 175,
          scale = 1.3,
          shift = {0.273438, 0.0234375}
        
      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-14.png",
          width = 241,
          height = 215,
          scale = 1.3,
          shift = {0.195312, 0.0390625}
        
      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-15.png",
          width = 318,
          height = 181,
          scale = 1.3,
          shift = {0.523438, 0.03125}
        
      },
      {

          filename = "__base__/graphics/decorative/huge-rock/huge-rock-16.png",
          width = 217,
          height = 224,
          scale = 1.3,
          shift = {0.0546875, 0.0234375}
        
      },
    }
  },
  {
    name = "big-rock",
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/big-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "grass",
    order = "b[decorative]-l[rock]-b[big]",
    collision_box = {{-2.0, -1.9}, {2.0, 2.0}},
    selection_box = {{-2.2, -2.2}, {2.2, 2.2}},
    damaged_trigger_effect = hit_effects.rock(),
    dying_trigger_effect = decorative_trigger_effects.big_rock(),
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 6,
       results = 
	  {
	  {type = "item", name = "stone", amount_min = 40, amount_max = 80}, 
	  {type = "item", name = "coal", amount_min = 4, amount_max = 12}
	  },
    },
    loot =
    {
      {type = "item", item = "stone", probability = 1, count_min = 19, count_max = 30}
    },
    count_as_rock_for_filtered_deconstruction = true,
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    vehicle_impact_sound = sounds.car_stone_impact,
    render_layer = "object",
    max_health = 800,
    resistances =
   {
	    {
        type = "acid",
        percent = -80
      },
      {
        type = "fire",
        percent = 100
      },
	  {
        type = "physical",
        percent = 95
      },
	  {
        type = "impact",
        percent = 95
      },
	  {
        type = "piercing",
        percent = 75
      },
	  {
        type = "explosion",
        percent = 25
      },
	  	  {
        type = "electric",
        percent = 100
      },
	  {
        type = "laser",
        percent = 90
      },
    },
    autoplace = autoplace_rock_big,
    pictures =
    {
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-01.png",
          width = 188,
          height = 127,
          scale = 1.0,
          shift = {-0.046875, 0.171875}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-02.png",
          width = 195,
          height = 135,
          scale = 1.0,
          shift = {0.445312, 0.125}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-03.png",
          width = 205,
          height = 132,
          scale = 1.0,
          shift = {0.484375, 0.0546875}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-04.png",
          width = 144,
          height = 142,
          scale = 1.0,
          shift = {0.210938, 0.0390625}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-05.png",
          width = 130,
          height = 107,
          scale = 1.0,
          shift = {0.0234375, 0.226562}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-06.png",
          width = 165,
          height = 109,
          scale = 1.0,
          shift = {0.15625, 0.226562}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-07.png",
          width = 150,
          height = 133,
          scale = 1.0,
          shift = {0.257812, 0.148438}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-08.png",
          width = 156,
          height = 111,
          scale = 1.0,
          shift = {0.0859375, 0.179688}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-09.png",
          width = 187,
          height = 120,
          scale = 1.0,
          shift = {0.078125, 0.0859375}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-10.png",
          width = 225,
          height = 128,
          scale = 1.0,
          shift = {-0.15625, 0.0703125}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-11.png",
          width = 183,
          height = 144,
          scale = 1.0,
          shift = {0.195312, 0.257812}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-12.png",
          width = 158,
          height = 138,
          scale = 1.0,
          shift = {0.0390625, 0.15625}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-13.png",
          width = 188,
          height = 150,
          scale = 1.0,
          shift = {0.226562, 0.21875}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-14.png",
          width = 186,
          height = 160,
          scale = 1.0,
          shift = {0.132812, 0.0625}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-15.png",
          width = 181,
          height = 174,
          scale = 1.0,
          shift = {0.304688, -0.09375}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-16.png",
          width = 212,
          height = 150,
          scale = 1.0,
          shift = {0.335938, 0.117188}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-17.png",
          width = 155,
          height = 117,
          scale = 1.0,
          shift = {0.25, 0.0390625}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-18.png",
          width = 141,
          height = 128,
          scale = 1.0,
          shift = {0.304688, 0.0390625}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-19.png",
          width = 176,
          height = 114,
          scale = 1.0,
          shift = {0.390625, 0.0234375}
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-20.png",
          width = 120,
          height = 125,
          scale = 1.0,
          shift = {0.148438, 0.03125}
        
      }
    }
  },
  {
    name = "medium-rock",
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/big-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "grass",
    order = "b[decorative]-l[rock]-b[medium]",
    collision_box = {{-1.2, -1.1}, {1.2, 1.1}},
    selection_box = {{-1.3, -1.3}, {1.3, 1.3}},
	autoplace = autoplace_rock_bigmedium,
    damaged_trigger_effect = hit_effects.rock(),
    dying_trigger_effect = decorative_trigger_effects.big_rock(),
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 3,
       results = 
	  {
	  {type = "item", name = "stone", amount_min = 10, amount_max = 20}, 
	  {type = "item", name = "coal", amount_min = 2, amount_max = 6}
	  },
    },
    loot =
    {
      {type = "item", item = "stone", probability = 1, count_min = 4, count_max = 10}
    },
    count_as_rock_for_filtered_deconstruction = true,
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    vehicle_impact_sound = sounds.car_stone_impact,
    render_layer = "object",
    max_health = 400,
    resistances =
   {
	    {
        type = "acid",
        percent = -80
      },
      {
        type = "fire",
        percent = 100
      },
	  {
        type = "physical",
        percent = 95
      },
	  {
        type = "impact",
        percent = 95
      },
	  {
        type = "piercing",
        percent = 75
      },
	  {
        type = "explosion",
        percent = 25
      },
	  	  {
        type = "electric",
        percent = 100
      },
	  {
        type = "laser",
        percent = 90
      },
    },
    pictures =
    {
      {

          filename = "__base__/graphics/decorative/medium-rock/medium-rock-01.png",
          priority = base_decorative_sprite_priority,
          width = 89,
          height = 63,
          scale = 1.1,
          shift = {0.078125, 0.109375}

      },
      {

          filename = "__base__/graphics/decorative/medium-rock/medium-rock-02.png",
          priority = base_decorative_sprite_priority,
          width = 77,
          height = 66,
          scale = 1.1,
          shift = {0.015625, 0.132812}
 
      },
      {

          filename = "__base__/graphics/decorative/medium-rock/medium-rock-03.png",
          priority = base_decorative_sprite_priority,
          width = 92,
          height = 63,
          scale = 1.1,
          shift = {0.148438, 0.179688}
   
      },
      {

          filename = "__base__/graphics/decorative/medium-rock/medium-rock-04.png",
          priority = base_decorative_sprite_priority,
          width = 91,
          height = 59,
          scale = 1.1,
          shift = {-0.0078125, 0.1875}
       
      },
      {
     
       
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-05.png",
          priority = base_decorative_sprite_priority,
          width = 104,
          height = 72,
          scale = 1.1,
          shift = {0.203125, 0.179688}
     
      },
      {
       
        
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-06.png",
          priority = base_decorative_sprite_priority,
          width = 83,
          height = 82,
          scale = 1.1,
          shift = {0.015625, 0.21875}
       
      },
      {
        
        
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-07.png",
          priority = base_decorative_sprite_priority,
          width = 111,
          height = 65,
          scale = 1.1,
          shift = {0.0625, 0.3125}
        
      },
      {
      
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-08.png",
          priority = base_decorative_sprite_priority,
          width = 79,
          height = 81,
          scale = 1.1,
          shift = {0.109375, 0.148438}
        
      },
      {
       
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-09.png",
          priority = base_decorative_sprite_priority,
          width = 98,
          height = 56,
          scale = 1.1,
          shift = {0.015625, 0.140625}
       
      },
      {
       
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-10.png",
          priority = base_decorative_sprite_priority,
          width = 91,
          height = 68,
          scale = 1.1,
          shift = {0, 0.132812}
       
      },
      {
       
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-11.png",
          priority = base_decorative_sprite_priority,
          width = 105,
          height = 71,
          scale = 1.1,
          shift = {-0.0234375, 0.125}
      
      },
      {
      
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-12.png",
          priority = base_decorative_sprite_priority,
          width = 78,
          height = 80,
          scale = 1.1,
          shift = {0.078125, -0.015625}
      
      }
    }
  },
  {
    name = "medium-rock",
    type = "optimized-decorative",
    order = "b[decorative]-l[rock]-c[medium]",
    collision_box = {{-1.1, -1.1}, {1.1, 1.1}},
    render_layer = "decorative",
    autoplace = autoplace_rock_medium,
    trigger_effect = decorative_trigger_effects.medium_rock(),
    pictures =
    {
      {

          filename = "__base__/graphics/decorative/medium-rock/medium-rock-01.png",
          priority = base_decorative_sprite_priority,
          width = 89,
          height = 63,
          scale = 0.3,
          shift = {0.078125, 0.109375}

      },
      {

          filename = "__base__/graphics/decorative/medium-rock/medium-rock-02.png",
          priority = base_decorative_sprite_priority,
          width = 77,
          height = 66,
          scale = 0.3,
          shift = {0.015625, 0.132812}
 
      },
      {

          filename = "__base__/graphics/decorative/medium-rock/medium-rock-03.png",
          priority = base_decorative_sprite_priority,
          width = 92,
          height = 63,
          scale = 0.3,
          shift = {0.148438, 0.179688}
   
      },
      {

          filename = "__base__/graphics/decorative/medium-rock/medium-rock-04.png",
          priority = base_decorative_sprite_priority,
          width = 91,
          height = 59,
          scale = 0.3,
          shift = {-0.0078125, 0.1875}
       
      },
      {
     
       
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-05.png",
          priority = base_decorative_sprite_priority,
          width = 104,
          height = 72,
          scale = 0.3,
          shift = {0.203125, 0.179688}
     
      },
      {
       
        
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-06.png",
          priority = base_decorative_sprite_priority,
          width = 83,
          height = 82,
          scale = 0.3,
          shift = {0.015625, 0.21875}
       
      },
      {
        
        
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-07.png",
          priority = base_decorative_sprite_priority,
          width = 111,
          height = 65,
          scale = 0.3,
          shift = {0.0625, 0.3125}
        
      },
      {
      
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-08.png",
          priority = base_decorative_sprite_priority,
          width = 79,
          height = 81,
          scale = 0.3,
          shift = {0.109375, 0.148438}
        
      },
      {
       
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-09.png",
          priority = base_decorative_sprite_priority,
          width = 98,
          height = 56,
          scale = 0.3,
          shift = {0.015625, 0.140625}
       
      },
      {
       
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-10.png",
          priority = base_decorative_sprite_priority,
          width = 91,
          height = 68,
          scale = 0.3,
          shift = {0, 0.132812}
       
      },
      {
       
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-11.png",
          priority = base_decorative_sprite_priority,
          width = 105,
          height = 71,
          scale = 0.3,
          shift = {-0.0234375, 0.125}
      
      },
      {
      
          filename = "__base__/graphics/decorative/medium-rock/medium-rock-12.png",
          priority = base_decorative_sprite_priority,
          width = 78,
          height = 80,
          scale = 0.3,
          shift = {0.078125, -0.015625}
      
      }
    }
  },
  
  {
    name = "small-rock",
    type = "optimized-decorative",
    order = "b[decorative]-l[rock]-d[small]",
    collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
    render_layer = "decorative",
    walking_sound = sounds.pebble,
    autoplace = autoplace_rock_small,
    trigger_effect = decorative_trigger_effects.small_rock(),
    pictures =
    {
      {
      
          filename = "__base__/graphics/decorative/small-rock/small-rock-01.png",
          priority = base_decorative_sprite_priority,
          width = 51,
          height = 37,
          scale = 0.25,
          shift = {0.0546875, 0.117188}
       
      },
      {
       
          filename = "__base__/graphics/decorative/small-rock/small-rock-02.png",
          priority = base_decorative_sprite_priority,
          width = 52,
          height = 35,
          scale = 0.25,
          shift = {0.0390625, 0.078125}
        
      },
      {
      
          filename = "__base__/graphics/decorative/small-rock/small-rock-03.png",
          priority = base_decorative_sprite_priority,
          width = 46,
          height = 42,
          scale = 0.25,
          shift = {-0.0078125, 0.148438}
       
      },
      {
       
          filename = "__base__/graphics/decorative/small-rock/small-rock-04.png",
          priority = base_decorative_sprite_priority,
          width = 53,
          height = 33,
          scale = 0.25,
          shift = {0.0234375, 0.15625}
        
      },
      {
       
          filename = "__base__/graphics/decorative/small-rock/small-rock-05.png",
          priority = base_decorative_sprite_priority,
          width = 47,
          height = 46,
         scale = 0.25,
          shift = {0.0390625, 0.140625}
       
      },
      {
       
          filename = "__base__/graphics/decorative/small-rock/small-rock-06.png",
          priority = base_decorative_sprite_priority,
          width = 62,
          height = 41,
          scale = 0.25,
          shift = {-0.03125, 0.09375}
       
      },
      {
     
          filename = "__base__/graphics/decorative/small-rock/small-rock-07.png",
          priority = base_decorative_sprite_priority,
          width = 64,
          height = 36,
          scale = 0.25,
          shift = {-0.015625, 0.0703125}
        
      },
      {
       
          filename = "__base__/graphics/decorative/small-rock/small-rock-08.png",
          priority = base_decorative_sprite_priority,
          width = 65,
          height = 31,
          scale = 0.25,
          shift = {-0.71875, -0.164062}
        
      },
      {
        
          filename = "__base__/graphics/decorative/small-rock/small-rock-09.png",
          priority = base_decorative_sprite_priority,
          width = 46,
          height = 34,
          scale = 0.25,
          shift = {-0.0859375, 0.101562}
       
      },
      {
        
          filename = "__base__/graphics/decorative/small-rock/small-rock-10.png",
          priority = base_decorative_sprite_priority,
          width = 48,
          height = 34,
          scale = 0.25,
          shift = {0.0078125, 0.125}
        
      },
      {
        
          filename = "__base__/graphics/decorative/small-rock/small-rock-11.png",
          priority = base_decorative_sprite_priority,
          width = 51,
          height = 33,
          scale = 0.25,
          shift = {-0.0859375, 0.078125}
        
      },
      {
        
          filename = "__base__/graphics/decorative/small-rock/small-rock-12.png",
          priority = base_decorative_sprite_priority,
          width = 47,
          height = 39,
         scale = 0.25,
          shift = {0.078125, 0.117188}
       
      },
      {
       
          filename = "__base__/graphics/decorative/small-rock/small-rock-13.png",
          priority = base_decorative_sprite_priority,
          width = 43,
          height = 33,
          scale = 0.25,
          shift = {0, 0.09375}
        
      },
      {
       
          filename = "__base__/graphics/decorative/small-rock/small-rock-14.png",
          priority = base_decorative_sprite_priority,
          width = 43,
          height = 30,
          scale = 0.25,
          shift = {0.046875, 0.140625}
        
      },
      {
       
          filename = "__base__/graphics/decorative/small-rock/small-rock-15.png",
          priority = base_decorative_sprite_priority,
          width = 41,
          height = 37,
          scale = 0.25,
          shift = {0, 0.140625}
        
      },
      {
   
          filename = "__base__/graphics/decorative/small-rock/small-rock-16.png",
          priority = base_decorative_sprite_priority,
          width = 46,
          height = 33,
          scale = 0.25,
          shift = {0.0234375, 0.125}
        
      }
    }
  },
  
  {
    name = "tiny-rock",
    type = "optimized-decorative",
    order = "b[decorative]-l[rock]-e[tiny]",
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    render_layer = "decorative",
    walking_sound = sounds.pebble,
    autoplace = autoplace_rock_tiny,
    trigger_effect = decorative_trigger_effects.tiny_rock(),
    pictures =
    {
      {
     
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-01.png",
          priority = base_decorative_sprite_priority,
          width = 29,
          height = 21,
          scale = 0.25,
          shift = {0.0390625, 0.0234375}
        
      },
      {
      
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-02.png",
          priority = base_decorative_sprite_priority,
          width = 30,
          height = 19,
          scale = 0.25,
          shift = {0.0078125, 0.0234375}
       
      },
      {
      
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-03.png",
          priority = base_decorative_sprite_priority,
          width = 29,
          height = 24,
          scale = 0.25,
          shift = {0.0234375, 0.0234375}
        
      },
      {
       
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-04.png",
          priority = base_decorative_sprite_priority,
          width = 32,
          height = 20,

          scale = 0.25,
          shift = {0.03125, 0.015625}
       
      },
      {
        
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-05.png",
          priority = base_decorative_sprite_priority,
          width = 29,
          height = 25,
          scale = 0.25,
          shift = {0, -0.0078125}
        
      },
      {
       
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-06.png",
          priority = base_decorative_sprite_priority,
          width = 36,
          height = 24,
          scale = 0.25,
          shift = {0, -0.0234375}
       
      },
      {
       
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-07.png",
          priority = base_decorative_sprite_priority,
          width = 78,
          height = 34,
          scale = 0.25,
          shift = {-0.34375, -0.132812}
       
      },
      {
       
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-08.png",
          priority = base_decorative_sprite_priority,
          width = 35,
          height = 19,
          scale = 0.25,
          shift = {-0.03125, 0}
        
      },
      {
        
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-09.png",
          priority = base_decorative_sprite_priority,
          width = 28,
          height = 20,
          scale = 0.25,
          shift = {0.0234375, 0.015625}
        
      },
      {
      
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-10.png",
          priority = base_decorative_sprite_priority,
          width = 29,
          height = 20,
          scale = 0.25,
          shift = {0.0078125, -0.0234375}
       
      },
      {
       
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-11.png",
          priority = base_decorative_sprite_priority,
          width = 29,
          height = 20,
          scale = 0.25,
          shift = {0.046875, 0.0078125}
        
      },
      {
       
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-12.png",
          priority = base_decorative_sprite_priority,
          width = 29,
          height = 22,
          scale = 0.25,
          shift = {0.015625, 0}
       
      },
      {
       
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-13.png",
          priority = base_decorative_sprite_priority,
          width = 27,
          height = 19,
         scale = 0.25,
          shift = {0.03125, 0.015625}
        
      },
      {
       
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-14.png",
          priority = base_decorative_sprite_priority,
          width = 27,
          height = 19,
          scale = 0.25,
          shift = {0.0078125, 0.0078125}
        
      },
      {
        
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-15.png",
          priority = base_decorative_sprite_priority,
          width = 26,
          height = 22,
          scale = 0.25,
          shift = {0.0078125, 0.015625}
        
      },
      {
      
          filename = "__base__/graphics/decorative/tiny-rock/tiny-rock-16.png",
          priority = base_decorative_sprite_priority,
          width = 27,
          height = 20,
          scale = 0.25,
          shift = {0.03125, 0.0078125}
       
      }
    }
  },


--- SAND ROCKS

  {
    name = "big-sand-rock",
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/big-sand-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "grass",
    order = "b[decorative]-l[rock]-a[big]",
    collision_box = {{-1.75, -1.75}, {1.75, 1.75}},
    selection_box = {{-2.0, -2.0}, {2.0, 2.25}},
    damaged_trigger_effect = hit_effects.rock(),
    render_layer = "object",
    max_health = 400,
    autoplace = autoplace_rocksandy_big,
    dying_trigger_effect = decorative_trigger_effects.big_rock(),
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 3,
       results = 
	  {
	  {type = "item", name = "stone", amount_min = 10, amount_max = 30}, 
	  {type = "item", name = "sand-ore", amount_min = 55, amount_max = 95}
	  },
    },
    loot =
    {
      {type = "item", item = "stone", probability = 1, count_min = 5, count_max = 20},
	  {type = "item", item = "sand-ore", probability = 1, count_min = 15, count_max = 35}
    },
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
        type = "impact",
        percent = 70
      },
	  {
        type = "piercing",
        percent = 60
      },
	  {
        type = "explosion",
        percent = 10
      },
    },
    count_as_rock_for_filtered_deconstruction = true,
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    vehicle_impact_sound = sounds.car_stone_impact,
    pictures =
    {
      {

          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-01.png",
          width = 209,
          height = 138,
          shift = {0.304688, -0.4},
          scale = 1.0
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-02.png",
          width = 165,
          height = 129,
          shift = {0.0, 0.0390625},
          scale = 1.0
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-03.png",
          width = 151,
          height = 139,
          shift = {0.151562, 0.0},
          scale = 1.0
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-04.png",
          width = 216,
          height = 110,
          shift = {0.390625, 0.0},
          scale = 1.0
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-05.png",
          width = 154,
          height = 147,
          shift = {0.328125, 0.0703125},
          scale = 1.0
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-06.png",
          width = 154,
          height = 132,
          shift = {0.16875, -0.1},
          scale = 1.0
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-07.png",
          width = 193,
          height = 130,
          shift = {0.3, -0.2},
          scale = 1.0
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-08.png",
          width = 136,
          height = 117,
          shift = {0.0, 0.0},
          scale = 1.0
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-09.png",
          width = 157,
          height = 115,
          shift = {0.1, 0.0},
          scale = 1.0
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-10.png",
          width = 198,
          height = 153,
          shift = {0.325, -0.1},
          scale = 1.0
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-11.png",
          width = 190,
          height = 115,
          shift = {0.453125, 0.0},
          scale = 1.0
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-12.png",
          width = 229,
          height = 126,
          shift = {0.539062, -0.015625},
          scale = 1.0
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-13.png",
          width = 151,
          height = 125,
          shift = {0.0703125, 0.179688},
          scale = 1.0
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-14.png",
          width = 137,
          height = 117,
          shift = {0.160938, 0.0},
          scale = 1.0
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-15.png",
          width = 201,
          height = 141,
          shift = {0.242188, -0.195312},
          scale = 1.0
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/big-sand-rock-16.png",
          width = 209,
          height = 154,
          shift = {0.351562, -0.1},
          scale = 1.0
        
      }
    }
  },
  {
    name = "medium-sand-rock",
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/big-sand-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "grass",
    order = "b[decorative]-l[rock]-a[big]",
    collision_box = {{-1.15, -1.15}, {1.15, 1.15}},
    selection_box = {{-1.25, -1.25}, {1.25, 1.25}},
    damaged_trigger_effect = hit_effects.rock(),
    render_layer = "object",
    max_health = 200,
    autoplace = autoplace_rocksandy_bigmedium,
    dying_trigger_effect = decorative_trigger_effects.big_rock(),
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 1.5,
       results = 
	  {
	  {type = "item", name = "stone", amount_min = 5, amount_max = 10}, 
	  {type = "item", name = "sand-ore", amount_min = 15, amount_max = 35}
	  },
    },
    loot =
    {
      {type = "item", item = "stone", probability = 1, count_min = 2, count_max = 8},
	  {type = "item", item = "sand-ore", probability = 1, count_min = 5, count_max = 15}
    },
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
        type = "impact",
        percent = 70
      },
	  {
        type = "piercing",
        percent = 60
      },
	  {
        type = "explosion",
        percent = 10
      },
    },
    count_as_rock_for_filtered_deconstruction = true,
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    vehicle_impact_sound = sounds.car_stone_impact,
    pictures =
    {
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-01.png",
          priority = base_decorative_sprite_priority,
          width = 134,
          height = 82,
          shift = {0.328125, 0.515625},
          scale = 1.0,
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-02.png",
          priority = base_decorative_sprite_priority,
          width = 110,
          height = 79,
          shift = {0.15625, 0.570312},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-03.png",
          priority = base_decorative_sprite_priority,
          width = 90,
          height = 60,
		  scale = 0.5,
          shift = {0.34375, 0.484375},
          scale = 1.0,
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-04.png",
          priority = base_decorative_sprite_priority,
          width = 110,
          height = 89,
          shift = {0.296875, 0.476562},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-05.png",
          priority = base_decorative_sprite_priority,
          width = 106,
          height = 76,
          shift = {0.359375, 0.25},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-06.png",
          priority = base_decorative_sprite_priority,
          width = 100,
          height = 92,
          shift = {0.4375, 0.296875},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-07.png",
          priority = base_decorative_sprite_priority,
          width = 82,
          height = 83,
          shift = {0.59375, 0.398438},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-08.png",
          priority = base_decorative_sprite_priority,
          width = 123,
          height = 92,
          shift = {0.601562, 0.328125},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-09.png",
          priority = base_decorative_sprite_priority,
          width = 146,
          height = 76,
          shift = {0.5625, 0.3125},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-10.png",
          priority = base_decorative_sprite_priority,
          width = 112,
          height = 77,
          shift = {0.46875, 0.460938},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-11.png",
          priority = base_decorative_sprite_priority,
          width = 91,
          height = 61,
          shift = {0.445312, 0.507812},
          scale = 1.0,
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-12.png",
          priority = base_decorative_sprite_priority,
          width = 105,
          height = 84,
          shift = {0.398438, 0.453125},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-13.png",
          priority = base_decorative_sprite_priority,
          width = 94,
          height = 73,
          shift = {0.375, 0.632812},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-14.png",
          priority = base_decorative_sprite_priority,
          width = 122,
          height = 89,
          shift = {0.359375, 0.570312},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-15.png",
          priority = base_decorative_sprite_priority,
          width = 98,
          height = 65,
          shift = {0.1875, 0.773438},
          scale = 1.0,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-16.png",
          priority = base_decorative_sprite_priority,
          width = 144,
          height = 76,
          shift = {0.109375, 0.71875},
          scale = 1.0,
        
      }
    }
  },
  {
    name = "medium-sand-rock",
    type = "optimized-decorative",
    order = "d[remnants]-d[ship-wreck-grass]-b[small]",
    collision_box = {{-1.5, -0.5}, {1.5, 0.5}},
    render_layer = "floor",
    autoplace = autoplace_rocksandy_medium,
    trigger_effect = decorative_trigger_effects.medium_rock(),
    pictures =
    {
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-01.png",
          priority = base_decorative_sprite_priority,
          width = 134,
          height = 82,
          shift = {0.328125, 0.515625},
          scale = 0.25,
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-02.png",
          priority = base_decorative_sprite_priority,
          width = 110,
          height = 79,
          shift = {0.15625, 0.570312},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-03.png",
          priority = base_decorative_sprite_priority,
          width = 90,
          height = 60,
		  scale = 0.5,
          shift = {0.34375, 0.484375},
          scale = 0.25,
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-04.png",
          priority = base_decorative_sprite_priority,
          width = 110,
          height = 89,
          shift = {0.296875, 0.476562},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-05.png",
          priority = base_decorative_sprite_priority,
          width = 106,
          height = 76,
          shift = {0.359375, 0.25},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-06.png",
          priority = base_decorative_sprite_priority,
          width = 100,
          height = 92,
          shift = {0.4375, 0.296875},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-07.png",
          priority = base_decorative_sprite_priority,
          width = 82,
          height = 83,
          shift = {0.59375, 0.398438},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-08.png",
          priority = base_decorative_sprite_priority,
          width = 123,
          height = 92,
          shift = {0.601562, 0.328125},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-09.png",
          priority = base_decorative_sprite_priority,
          width = 146,
          height = 76,
          shift = {0.5625, 0.3125},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-10.png",
          priority = base_decorative_sprite_priority,
          width = 112,
          height = 77,
          shift = {0.46875, 0.460938},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-11.png",
          priority = base_decorative_sprite_priority,
          width = 91,
          height = 61,
          shift = {0.445312, 0.507812},
          scale = 0.25,
        
      },
      {
 
          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-12.png",
          priority = base_decorative_sprite_priority,
          width = 105,
          height = 84,
          shift = {0.398438, 0.453125},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-13.png",
          priority = base_decorative_sprite_priority,
          width = 94,
          height = 73,
          shift = {0.375, 0.632812},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-14.png",
          priority = base_decorative_sprite_priority,
          width = 122,
          height = 89,
          shift = {0.359375, 0.570312},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-15.png",
          priority = base_decorative_sprite_priority,
          width = 98,
          height = 65,
          shift = {0.1875, 0.773438},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/medium-sand-rock-16.png",
          priority = base_decorative_sprite_priority,
          width = 144,
          height = 76,
          shift = {0.109375, 0.71875},
          scale = 0.25,
        
      }
    }
  },

  {
    name = "small-sand-rock",
    type = "optimized-decorative",
    order = "d[remnants]-d[ship-wreck-grass]-b[small]",
    collision_box = {{-1.5, -0.5}, {1.5, 0.5}},
    render_layer = "floor",
    autoplace = autoplace_rocksandy_small,
    walking_sound = sounds.pebble,
    trigger_effect = decorative_trigger_effects.small_rock(),
    pictures =
    {
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-01.png",
          priority = base_decorative_sprite_priority,
          width = 56,
          height = 45,
          shift = {0.40625, 0.476562},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-02.png",
          priority = base_decorative_sprite_priority,
          width = 54,
          height = 45,
          shift = {0.296875, 0.476562},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-03.png",
          priority = base_decorative_sprite_priority,
          width = 44,
          height = 40,
          shift = {0.328125, 0.53125},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-04.png",
          priority = base_decorative_sprite_priority,
          width = 60,
          height = 43,
          shift = {0.265625, 0.601562},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-05.png",
          priority = base_decorative_sprite_priority,
          width = 52,
          height = 48,
          shift = {0.296875, 0.46875},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-06.png",
          priority = base_decorative_sprite_priority,
          width = 57,
          height = 39,
          shift = {0.554688, 0.523438},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-07.png",
          priority = base_decorative_sprite_priority,
          width = 73,
          height = 41,
          shift = {0.570312, 0.539062},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-08.png",
          priority = base_decorative_sprite_priority,
          width = 50,
          height = 46,
          shift = {0.640625, 0.390625},
          scale = 0.25,
        
       },
       {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-09.png",
          priority = base_decorative_sprite_priority,
          width = 52,
          height = 43,
          shift = {0.671875, 0.335938},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-10.png",
          priority = base_decorative_sprite_priority,
          width = 63,
          height = 39,
          shift = {0.632812, 0.398438},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-11.png",
          priority = base_decorative_sprite_priority,
          width = 57,
          height = 41,
          shift = {0.460938, 0.617188},
          scale = 0.25,
        
      },
      {
  
          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-12.png",
          priority = base_decorative_sprite_priority,
          width = 67,
          height = 51,
          shift = {0.460938, 0.570312},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-13.png",
          priority = base_decorative_sprite_priority,
          width = 70,
          height = 37,
          shift = {0.484375, 0.789062},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-14.png",
          priority = base_decorative_sprite_priority,
          width = 63,
          height = 48,
          shift = {0.179688, 0.90625},
          scale = 0.25,
        
      },
      {

          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-15.png",
          priority = base_decorative_sprite_priority,
          width = 56,
          height = 48,
          shift = {0.140625, 0.78125},
          scale = 0.25,
      
      },
      {
      
          filename = "__base__/graphics/decorative/sand-rock/small-sand-rock-16.png",
          priority = base_decorative_sprite_priority,
          width = 74,
          height = 46,
          shift = {-0.03125, 0.78125},
          scale = 0.25,
        
      }
    }
  },
})

data.raw["simple-entity"]["big-sand-rock"].autoplace["tile_restriction"] = {"sand-1","sand-2","sand-3","dirt-3","dirt-2","dirt-1"} 
data.raw["optimized-decorative"]["medium-sand-rock"].autoplace["tile_restriction"] = {"sand-1","sand-2","sand-3","dirt-3","dirt-2","dirt-1"} 
data.raw["optimized-decorative"]["small-sand-rock"].autoplace["tile_restriction"] = {"sand-1","sand-2","sand-3","dirt-3","dirt-2","dirt-1"} 

-- data.raw["simple-entity"]["big-sand-rock"].autoplace 
-- data.raw["optimized-decorative"]["medium-sand-rock"].autoplace["tile_restriction"] = {"sand-1","sand-2","sand-3","dirt-3","dirt-2","dirt-1"} 
-- data.raw["optimized-decorative"]["small-sand-rock"].autoplace["tile_restriction"] = {"sand-1","sand-2","sand-3","dirt-3","dirt-2","dirt-1"} 

data.raw["optimized-decorative"]["tiny-rock"].autoplace["tile_restriction"] = {"grass-1","grass-2","grass-3","grass-4","dirt-5","dirt-6","dirt-7","dry-dirt"} 
data.raw["optimized-decorative"]["small-rock"].autoplace["tile_restriction"] = {"grass-1","grass-2","grass-3","grass-4","dirt-5","dirt-6","dirt-7","dry-dirt"} 
data.raw["optimized-decorative"]["medium-rock"].autoplace["tile_restriction"] = {"grass-1","grass-2","grass-3","grass-4","dirt-5","dirt-6","dirt-7","dry-dirt"} 
data.raw["simple-entity"]["big-rock"].autoplace["tile_restriction"] = {"grass-1","grass-2","grass-3","grass-4","dirt-5","dirt-6","dirt-7","dry-dirt"} 
data.raw["simple-entity"]["huge-rock"].autoplace["tile_restriction"] = {"grass-1","grass-2","grass-3","grass-4","dirt-5","dirt-6","dirt-7"} 
data.raw["simple-entity"]["rock-massive"].autoplace["tile_restriction"] = {"grass-1","grass-2","grass-3","grass-4","dirt-5","dirt-6","dirt-7"} 

local red_rock_tint = {1, 0.75 , 0.6}

data.extend({
{
    name = "big-rock-red",
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/big-rock.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "grass",
    order = "b[decorative]-l[rock]-b[big]",
    collision_box = {{-2.0, -1.9}, {2.0, 2.0}},
    selection_box = {{-2.2, -2.2}, {2.2, 2.2}},
    damaged_trigger_effect = hit_effects.rock(),
    dying_trigger_effect = decorative_trigger_effects.big_rock(),
--	remains_when_mined = "medium-rock",
--	corpse = "medium-rock",


    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 6,
       results = 
	  {
	  {type = "item", name = "stone", amount_min = 10, amount_max = 20}, 
	  {type = "item", name = "bauxite-ore", amount_min = 20, amount_max = 40}
	  },
    },
    loot =
    {
	  {type = "item", item = "stone", probability = 1, count_min = 5, count_max = 10}, 
	  {type = "item", item = "bauxite-ore", probability = 1, count_min = 5, count_max = 15}
	},
    count_as_rock_for_filtered_deconstruction = true,
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    vehicle_impact_sound = sounds.car_stone_impact,
    render_layer = "object",
    max_health = 800,
    resistances =
   {
	    {
        type = "acid",
        percent = -80
      },
      {
        type = "fire",
        percent = 100
      },
	  {
        type = "physical",
        percent = 95
      },
	  {
        type = "impact",
        percent = 95
      },
	  {
        type = "piercing",
        percent = 75
      },
	  {
        type = "explosion",
        percent = 25
      },
	  	  {
        type = "electric",
        percent = 100
      },
	  {
        type = "laser",
        percent = 90
      },
    },
    autoplace = autoplace_rock_big_red,
    pictures =
    {
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-01.png",
          width = 188,
          height = 127,
          scale = 1.0,
          shift = {-0.046875, 0.171875},
         tint = red_rock_tint,
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-02.png",
          width = 195,
          height = 135,
          scale = 1.0,
          shift = {0.445312, 0.125},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-03.png",
          width = 205,
          height = 132,
          scale = 1.0,
          shift = {0.484375, 0.0546875},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-04.png",
          width = 144,
          height = 142,
          scale = 1.0,
          shift = {0.210938, 0.0390625},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-05.png",
          width = 130,
          height = 107,
          scale = 1.0,
          shift = {0.0234375, 0.226562},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-06.png",
          width = 165,
          height = 109,
          scale = 1.0,
          shift = {0.15625, 0.226562},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-07.png",
          width = 150,
          height = 133,
          scale = 1.0,
          shift = {0.257812, 0.148438},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-08.png",
          width = 156,
          height = 111,
          scale = 1.0,
          shift = {0.0859375, 0.179688},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-09.png",
          width = 187,
          height = 120,
          scale = 1.0,
          shift = {0.078125, 0.0859375},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-10.png",
          width = 225,
          height = 128,
          scale = 1.0,
          shift = {-0.15625, 0.0703125},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-11.png",
          width = 183,
          height = 144,
          scale = 1.0,
          shift = {0.195312, 0.257812},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-12.png",
          width = 158,
          height = 138,
          scale = 1.0,
          shift = {0.0390625, 0.15625},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-13.png",
          width = 188,
          height = 150,
          scale = 1.0,
          shift = {0.226562, 0.21875},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-14.png",
          width = 186,
          height = 160,
          scale = 1.0,
          shift = {0.132812, 0.0625},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-15.png",
          width = 181,
          height = 174,
          scale = 1.0,
          shift = {0.304688, -0.09375},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-16.png",
          width = 212,
          height = 150,
          scale = 1.0,
          shift = {0.335938, 0.117188},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-17.png",
          width = 155,
          height = 117,
          scale = 1.0,
          shift = {0.25, 0.0390625},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-18.png",
          width = 141,
          height = 128,
          scale = 1.0,
          shift = {0.304688, 0.0390625},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-19.png",
          width = 176,
          height = 114,
          scale = 1.0,
          shift = {0.390625, 0.0234375},
		  tint = red_rock_tint,
        
      },
      {

          filename = "__base__/graphics/decorative/big-rock/big-rock-20.png",
          width = 120,
          height = 125,
          scale = 1.0,
          shift = {0.148438, 0.03125},
		  tint = red_rock_tint,
        
      }
    }
  },
 })
 
 data.raw["simple-entity"]["big-rock-red"].autoplace["tile_restriction"] = {"red-desert-3","red-desert-2","red-desert-1"} 

local mediumredrock = util.copy(data.raw["optimized-decorative"]["medium-rock"])
mediumredrock.name = "medium-red-rock"
for i, v in ipairs(mediumredrock.pictures) do
	v.tint = red_rock_tint
end
mediumredrock.autoplace = autoplace_rock_medium_red
mediumredrock.autoplace["tile_restriction"] = {"red-desert-3","red-desert-2","red-desert-1"} 
data:extend{mediumredrock}

local smallredrock = util.copy(data.raw["optimized-decorative"]["small-rock"])
smallredrock.name = "small-red-rock"
for i, v in ipairs(smallredrock.pictures) do
	v.tint = red_rock_tint
end
smallredrock.autoplace = autoplace_rock_small_red
smallredrock.autoplace["tile_restriction"] = {"red-desert-3","red-desert-2","red-desert-1"} 
data:extend{smallredrock}

--we want to get to
-- data.raw["simple-entity"]["lithium-iceberg-huge"].collision_box
-- {{-1.0, -0.75}, {1.0, 0.75}}




function scalecollision(type, t, scale, boxname) 
	for _,u in pairs(t) do
		scalebox( data.raw[type][u][boxname],scale)
	end
end

function scalebox(t, scale) 
	for k ,v in pairs(t) do
		for l ,w in pairs(v) do		
			t[k][l] = w * scale
		end
	end
end

function scaleimages(type, t, s) 
   	for _,u in pairs(t) do
		if data.raw[type][u].pictures.layers ~= nil then
			for _,v in pairs( data.raw[type][u].pictures.layers ) do			
				v.scale = v.scale * s
				if v.shift ~= nil then
					v.shift[2] = v.shift[2] * s
					v.shift[1] = v.shift[1] * s
				end
			end
		else 
			for _,v in pairs( data.raw[type][u].pictures ) do			
				v.scale = v.scale * s
				if v.shift ~= nil then
					v.shift[2] = v.shift[2] * s
					v.shift[1] = v.shift[1] * (s/2)
				end
			end
		end	
	end
end


function scalemining(type, t, scale) 
	for k,u in pairs(t) do
		local dir =  data.raw[type][u].minable	
		dir.mining_time = math.ceil(dir.mining_time * (scale ^ 2 ))
		scaleminingresults(dir.results, scale) 
	end
end

function scaleminingresults(t, scale) 
	for k,v in pairs(t) do	
		if v.amount ~= nil then
			t[k].amount = math.ceil( (v.amount * (scale ^ 2 )) + scale )
		else
			t[k].amount_min = math.ceil( (v.amount_min * (scale ^ 2 )) + scale )
			t[k].amount_max = math.ceil( (v.amount_max * (scale ^ 2 )) + scale )
		end	
	end
end

function scalerocks(type, t, scale)

	if type == "simple-entity" then
		scalecollision(type, t, scale, "selection_box")
		scalemining(type, t, scale) 
	end
		scalecollision(type, t, scale, "collision_box")
		scaleimages(type, t, scale)
end

-- local icebergs_to_update = {"floating-iceberg-large", "floating-iceberg-small"}
local gleba_rocks_to_update = { "iron-stromatolite", "copper-stromatolite" }
local huge_rocks_to_update = { "lithium-iceberg-huge", "huge-volcanic-rock"}
local big_rocks_to_update = { "lithium-iceberg-big", "big-volcanic-rock"}
local fulgorite_rocks_to_update = { "fulgurite-small", "fulgurite", "big-fulgora-rock" }
local fulgorite_ruins_to_update = { "fulgoran-ruin-small", "fulgoran-ruin-medium", "fulgoran-ruin-stonehenge", "fulgoran-ruin-big", "fulgoran-ruin-huge", "fulgoran-ruin-colossal", "fulgoran-ruin-vault" }
local vulcanus_chimneys_to_update = {"vulcanus-chimney", "vulcanus-chimney-faded", "vulcanus-chimney-cold" , "vulcanus-chimney-short", "vulcanus-chimney-truncated"}
local decoratives_to_update = { "lithium-iceberg-medium", "lithium-iceberg-small", "lithium-iceberg-tiny", "medium-volcanic-rock", "small-volcanic-rock", "tiny-volcanic-rock", "tiny-rock-cluster", "small-sulfur-rock", "tiny-sulfur-rock", "sulfur-rock-cluster", "small-fulgora-rock", "medium-fulgora-rock", "tiny-fulgora-rock" }

if (mods["space-age"]) then
	scalerocks("simple-entity", fulgorite_rocks_to_update, 1.8)
	scalerocks("simple-entity", fulgorite_ruins_to_update, 1.5)
	scalerocks("simple-entity", huge_rocks_to_update, 2)
	scalerocks("simple-entity", big_rocks_to_update, 1.75)
	scalerocks("simple-entity", vulcanus_chimneys_to_update, 1.5)
	scalerocks("simple-entity", gleba_rocks_to_update, 1.5)
	scalerocks("optimized-decorative", decoratives_to_update, 0.75)
	-- scalerocks("optimized-decorative", icebergs_to_update, 1.75)
end


