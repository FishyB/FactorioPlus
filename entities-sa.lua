local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require ("__base__.prototypes.entity.sounds")
local decorative_trigger_effects = require("__base__.prototypes.decorative.decorative-trigger-effects")

-- Space age specific ents

-- data.raw["planet"]["gleba"].map_gen_settings.autoplace_settings.entity.settings =  	
-- {
  -- ["stone"] = {},
  -- ["iron-stromatolite"] = {},
  -- ["copper-stromatolite"] = {},
  -- ["bauxite-stromatolite"] = {}
-- }


data.raw["planet"]["gleba"].map_gen_settings.autoplace_settings.entity.settings["bauxite-stromatolite"] = {} 
-- Bauxite STROMATOLITE
local stroma_bauxite_scale = 0.65
local stroma_bauxite_scale_col = 1 + (stroma_bauxite_scale - 0.5)

data:extend{
 {
    type = "noise-expression",
    name = "gleba_bauxite_stromatolite",
    expression = "region_box - gleba_scrub_noise",
    local_expressions =
-- IRON region_box = "gleba_select(gleba_aux, 0.6, 2, 0.1, -10, 1) - 1"
-- COPPER region_box = "gleba_select(gleba_aux, -1, 0.4, 0.1, -10, 1) - 1"
    { -- plateau potential: -10 to 0
      region_box = "gleba_select(gleba_aux, 0.425, 0.575, 0.1, -10, 1) - 1"
    }
  },
  
  {
    name = "bauxite-stromatolite",
    type = "simple-entity",
    flags = {"placeable-neutral", "placeable-off-grid"},
    icon = "__space-age__/graphics/icons/iron-stromatolite.png",
    subgroup = "grass",
    order = "b[decorative]-l[rock]-a[big]",
    collision_box = {{-0.8 * stroma_bauxite_scale_col, -0.8 * stroma_bauxite_scale_col }, {0.8 * stroma_bauxite_scale_col, 0.8 * stroma_bauxite_scale_col}},
    selection_box = {{-0.95 * stroma_bauxite_scale_col, -0.95 * stroma_bauxite_scale_col}, {0.95 * stroma_bauxite_scale_col, 0.95 * stroma_bauxite_scale_col}},
    collision_mask = {layers={player=true, ground_tile=true, train=true, is_object=true, is_lower_object=true}},
    damaged_trigger_effect = hit_effects.rock(),
    render_layer = "object",
    max_health = 750,
--probability_expression = "gleba_select(gleba_copper_stromatolite - clamp(gleba_decorative_knockout, 0, 1), 1.3, 2, 0.2, 0, 1)"
--probability_expression = "gleba_select(gleba_iron_stromatolite - clamp(gleba_decorative_knockout, 0, 1), 1.3, 2, 0.2, 0, 1)"
    autoplace = {
	  probability_expression = "gleba_select(gleba_bauxite_stromatolite - clamp(gleba_decorative_knockout, 0, 1), 1.3, 2, 0.2, 0, 1)"
    },
	 
    dying_trigger_effect = decorative_trigger_effects.big_rock(),
    minable =
    {
      mining_particle = "stone-particle",
      mining_time = 1,
      results = {
        {type = "item", name = "stone", amount_min = 4, amount_max = 8},
        {type = "item", name = "bauxite-ore", amount_min = 23, amount_max = 27},
        {type = "item", name = "alumina-bacteria", amount_min = 33, amount_max = 47}
      }
    },
    resistances =
    {
      {
        type = "fire",
        percent = 100
      }
    },
    map_color = {179, 125, 98},
    count_as_rock_for_filtered_deconstruction = true,
    mined_sound = sounds.deconstruct_bricks(1.0),
    impact_category = "stone",
    pictures =
    {
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-01.png",
        width = 209,
        height = 138,
        shift = {0.304688, -0.4},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-02.png",
        width = 165,
        height = 129,
        shift = {0.0, 0.0390625},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-03.png",
        width = 151,
        height = 139,
        shift = {0.151562, 0.0},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-04.png",
        width = 216,
        height = 110,
        shift = {0.390625, 0.0},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-05.png",
        width = 154,
        height = 147,
        shift = {0.328125, 0.0703125},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-06.png",
        width = 154,
        height = 132,
        shift = {0.16875, -0.1},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-07.png",
        width = 193,
        height = 130,
        shift = {0.3, -0.2},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-08.png",
        width = 136,
        height = 117,
        shift = {0.0, 0.0},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-09.png",
        width = 157,
        height = 115,
        shift = {0.1, 0.0},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-10.png",
        width = 198,
        height = 153,
        shift = {0.325, -0.1},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-11.png",
        width = 190,
        height = 115,
        shift = {0.453125, 0.0},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-12.png",
        width = 229,
        height = 126,
        shift = {0.539062, -0.015625},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-13.png",
        width = 151,
        height = 125,
        shift = {0.0703125, 0.179688},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-14.png",
        width = 137,
        height = 117,
        shift = {0.160938, 0.0},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-15.png",
        width = 201,
        height = 141,
        shift = {0.242188, -0.195312},
        scale = stroma_bauxite_scale
      },
      {
        filename = "__factorioplus__/graphics/entity/stroma-bauxite/stromatolite-16.png",
        width = 209,
        height = 154,
        shift = {0.351562, -0.1},
        scale = stroma_bauxite_scale
      }
    }
  },
 }
 
 -- Allow bullet projectile collision with Asteroids
 -- Add piercing damage type resistances.
 
for i, v in pairs(data.raw["asteroid"]) do
	v.collision_mask = {layers={object=true, player=true}, not_colliding_with_itself=true}
	if (string.find(v.name, "medium")) then
		table.insert(v.resistances , {type = "piercing" , decrease = 0, percent = 30} )
	elseif (string.find(v.name, "big")) then
		table.insert(v.resistances , {type = "piercing" , decrease = 10, percent = 60} )
	elseif (string.find(v.name, "huge")) then
		table.insert(v.resistances , {type = "piercing" , decrease = 100, percent = 90} )
	end
end
