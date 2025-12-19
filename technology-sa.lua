-- Space age overrides

-- Add bioexplosives to bioflux processing
table.insert(data.raw["technology"]["bioflux-processing"].effects, 
	{
		type = "unlock-recipe",
		recipe = "bioexplosives"
	})

-- Add biter to chunks processing when captivity is researches
table.insert(data.raw["technology"]["captivity"].effects, 
	{
		type = "unlock-recipe",
		recipe = "process-biter-egg-to-chunks"
	})

data.raw["technology"]["turbo-transport-belt"].hidden = true
data.raw["technology"]["turbo-transport-belt"].hidden_in_factoriopedia = true
	

data.extend({
	{
    type = "technology",
    name = "aluminium-productivity",
    icons = util.technology_icon_constant_recipe_productivity("__factorioplus__/graphics/technology/aluminium-productivity.png"),
    icon_size = 256,
    effects =
    {
      {
        type = "change-recipe-productivity",
        recipe = "aluminium-plate",
        change = 0.1
      },
    },
    prerequisites = {"production-science-pack", "metallurgic-science-pack"},
    unit =
    {
      count_formula = "1.5^L*1000",
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"metallurgic-science-pack", 1},
      },
      time = 60
    },
    max_level = "infinite",
    upgrade = true
	 },

	{
    type = "technology",
    name = "rocket-battery",
    icon = "__space-age__/graphics/technology/rocket-turret.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rocket-battery"
      },
      {
        type = "unlock-recipe",
        recipe = "coal-synthesis"
      }
    },
    prerequisites = {"rocket-turret", "carbon-fiber", "stronger-explosives-2"},
    unit =
    {
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"agricultural-science-pack", 1}
      },
      time = 30,
      count = 1000
    }
  },

 
  })