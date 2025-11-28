------ INCINERATION STUFF ------  
  
local incinerator_graphics = 
{
  animation =
  {
	layers =
	{
	  {
		filename = "__factorioplus__/graphics/incinerator-off.png",
		priority = "high",
		width = 228,
		height = 512,
		shift = util.by_pixel(-1.0, -62.0),
		scale = 0.45
	  },
	  {
		filename = "__factorioplus__/graphics/incinerator-shadow.png",
		priority = "high",
		width = 512,
		height = 228,
		draw_as_shadow = true,
		shift = util.by_pixel(60, 4),
		scale = 0.45
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
		filename = "__base__/graphics/entity/steel-furnace/steel-furnace-fire.png",
		priority = "high",
		line_length = 8,
		width = 57,
		height = 81,
		frame_count = 48,
		draw_as_glow = true,
		shift = util.by_pixel(-9, -3),
		scale = 0.75
	  },
	},
	{
	  fadeout = true,
	  effect = "flicker",
	  animation =
	  {
		filename = "__base__/graphics/entity/steel-furnace/steel-furnace-glow.png",
		priority = "high",
		width = 60,
		height = 43,
		draw_as_glow = true,
		shift = {0.03125, 0.640625},
		blend_mode = "additive"
	  }
	},
	{
	  fadeout = true,
	  effect = "flicker",
	  animation =
	  {
		filename = "__base__/graphics/entity/steel-furnace/steel-furnace-working.png",
		priority = "high",
		line_length = 1,
		width = 128,
		height = 150,
		draw_as_glow = true,
		shift = util.by_pixel(0, -5),
		blend_mode = "additive",
		scale = 0.5,
	  }
	},
	{
	  fadeout = true,
	  effect = "flicker",
	  animation =
	  {
		filename = "__base__/graphics/entity/steel-furnace/steel-furnace-ground-light.png",
		priority = "high",
		line_length = 1,
		width = 152,
		height = 126,
		draw_as_light = true,
		shift = util.by_pixel(1, 48),
		blend_mode = "additive",
		scale = 0.5,
	  },
	},
  },
  water_reflection =
  {
	pictures =
	{
	  filename = "__base__/graphics/entity/steel-furnace/steel-furnace-reflection.png",
	  priority = "extra-high",
	  width = 20,
	  height = 24,
	  shift = util.by_pixel(0, 45),
	  variation_count = 1,
	  scale = 5
	},
	rotate = false,
	orientation_to_variation = false
  }
}
	
local incinerator_smoke =
{
	{
	  name = "smoke",
	  frequency = 30,
	  position = {-0.25, -5},
	  starting_vertical_speed = 0.04,
	  starting_frame_deviation = 60
	}
}
  
local incinerator = util.copy(data.raw["furnace"]["steel-furnace"])
incinerator.name = "incinerator"
incinerator.minable = {mining_time = 1, result = "incinerator"}
incinerator.collision_box = {{-1.3, -1.3}, {1.3, 1.3}}
incinerator.selection_box = {{-1.5, -1.5}, {1.5, 1.5}}
incinerator.fast_replaceable_group = "incinerator"
incinerator.crafting_categories = {"incineration"}
incinerator.crafting_speed = 1
incinerator.graphics_set = incinerator_graphics
incinerator.energy_source.smoke = incinerator_smoke
if (mods["space-age"]) then
	incinerator.energy_source.emissions_per_minute = { pollution = 6, spores = 4 }
	else
	incinerator.energy_source.emissions_per_minute = { pollution = 6 }
end

incinerator.icon_draw_specification = { scale = 1.5},
data.extend({ incinerator })


data.extend({ 
  {
    type = "item",
    name = "incinerator",
    icon = "__factorioplus__/graphics/icons/incinerator.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "ca[stone-furnace]",
    place_result = "incinerator",
    stack_size = 25
  },
  
  {
    type = "recipe",
    name = "incinerator",
	energy_required = 10,
	enabled = false,
    ingredients = {
	{type="item", name="stone-furnace", amount=1}, 
	{type="item", name="stone-brick", amount=12}, 
	{type="item", name="steel-plate", amount=6}, 
	},
    results = {{type="item", name="incinerator", amount=1}},
},

{
     type = "technology",
    name = "incineration",
    icon_size = 256,
    icon = "__factorioplus__/graphics/technology/incineration.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "incinerator"
      }
    },
    prerequisites = {"steel-processing"},
    unit =
    {
      count = 20,
      ingredients =
      {
        {"automation-science-pack", 1},
      },
      time = 30
    },
    order = "c-c-b"
  },

 })

local incineration_icon = "__base__/graphics/icons/explosion.png"
local incineration_icon_size = 0.6


function generate_incinerator_recipe_icons_from_item(item)
	local _icons = {}
	
	if  item.icons == nil then
		_icons = 
		{
			{
				icon = incineration_icon,
			},
			{
				icon = item.icon,
				icon_size = item.icon_size,
				scale = (0.5 * defines.default_icon_size / (item.icon_size or defines.default_icon_size)) * incineration_icon_size,
			}	
		}
	else
		_icons =
		{
		  {
			icon = incineration_icon
		  }
		}
		for i = 1, #item.icons do
		  local icon = table.deepcopy(item.icons[i]) 
		  icon.scale = ((icon.scale == nil) and (0.5 * defines.default_icon_size / (icon.icon_size or defines.default_icon_size)) or icon.scale) * incineration_icon_size
		  icon.shift = util.mul_shift(icon.shift, 0.8)
		  _icons[#_icons + 1] = icon
		end		
	end
	return _icons	
end

-- local itemtypes = {"item","capsule","item-with-entity-data","tool","ammo","armor","gun"}

 function getitemrecipeenergytime(itemname)
	if (data.raw["recipe"][itemname] ~= nil ) then
		if (data.raw["recipe"][itemname].energy_required ~= nil ) then
			return data.raw["recipe"][itemname].energy_required
		end		
	end
	return 0	
 end
 
 
-- Go through all items in the game (and mods) and make incinerator versions of them.
-- All it does it put the firey background behind the icon/icons
 
for k,v in pairs(data.raw["item"]) do
	
	local _newrecipe = 
	{ 
		type = "recipe",
		icon = nil,
		icons = generate_incinerator_recipe_icons_from_item(v) ,
		icon_size = 64,
		name = v.name .. "-incinerate",
		enabled = true,
		hidden = true,
		auto_recycle = false,
		category = "incineration",
		energy_required = math.max( (getitemrecipeenergytime(v.name)), 2 ),
		ingredients = {{type="item", name=v.name, amount=1}},
	}
	data.extend({ _newrecipe })	
	
end
