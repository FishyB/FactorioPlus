-- Data updates for other mods


------------------ ALL MODS (Including Factorioplus) ------------------

-- Remove 'object' layer from walls so that shotguns can shoot over them. 
local wall_collision_mask_new = {layers={item=true, meltable=true,  wall=true, player=true, water_tile=true, is_lower_object=true}}

for k, v in pairs(data.raw["wall"]) do
  v.collision_mask = wall_collision_mask_new
end

------------------ INDIVIDUAL MODS ------------------
  
-- aai-industry
if mods["aai-industry"] then
	-- Do glass stuff
	switchrecipeingredient("glass","glass-plate")
	data.raw["recipe"]["glass"].hidden = true
	data.raw["item"]["glass"].hidden = true
	table.removetablewithmatchingentry(data.raw["technology"]["glass-processing"].effects,"recipe", "glass") 
	 
	 -- Do sand stuff
	switchrecipeingredient("sand","sand-ore")
	data.raw["recipe"]["sand"].hidden = true
	data.raw["item"]["sand"].hidden = true
end

-- Dectorio
if mods["Dectorio"] then
	-- do this
end

-- Flow Control
if mods["Flow Control"] then
	-- Place all new pipes into the F+ fluid handling subgroups
	if data.raw.item["pipe-junction"] then
	data.raw.item["pipe-junction"].subgroup = "pipes"
	end
	if data.raw.item["pipe-elbow"] then
	data.raw.item["pipe-elbow"].subgroup = "pipes"
	end
	if data.raw.item["pipe-straight"] then
	data.raw.item["pipe-straight"].subgroup = "pipes"
	end
end

-- FluidMustFlow
if mods["FluidMustFlow"] then
	-- Make a subgroup for Fluidmustflow objects in the F+ fluid handling category
	data:extend({
		{
		type = "item-subgroup",
		name = "FluidMustFlow",
		group = "fluid-handling",
		order = "z"
		}
	})

	-- List of FMF items
	local fluidMustFlowItems = {
	"duct", 
	"duct-cross", 
	"duct-curve", 
	"duct-exhaust",
	"duct-intake", 
	"duct-long", 
	"duct-small", 
	"duct-t-junction",
	"duct-underground", 
	"non-return-duct"
	}

	for _, itemName in pairs(fluidMustFlowItems) do
		if data.raw.item[itemName] then
		data.raw.item[itemName].subgroup = "FluidMustFlow"
		end
	end
end

-- Maraxsis

if mods["maraxsis"] then
	-- Place the trench-duct pipe into the F+ fluid handling subgroups
	if data.raw.item["maraxsis-trench-duct"] then
		data.raw.item["maraxsis-trench-duct"].subgroup = "pipes"
	end

	-- Rename the sand to Quartz Sand
	local item_prototype = data.raw["item"][maraxsis_constants.SAND_ITEM_NAME]
	if recipe then
    	item_prototype.localised_name = {"item-name.quartz-sand"}
    end
end

-- Pangila

if mods["panglia_planet"] then

	-- Swap glass recipes
	local recipe_name = "matter_printer"
    local recipe = data.raw.recipe[recipe_name]

	if recipe then
    	recipe.ingredients =
        {
		{type = "item", name = "neural_computer", amount = 1},
		{type = "item", name = "electromagnetic-plant", amount = 1},
		{type = "item", name = "electronic-circuit", amount = 10},
		{type = "item", name = "panglia_panglite", amount = 10},
		--{type = "item", name = "glass", amount = 50},
		{type = "item", name = "glass-plate", amount = 50}
		}
      end
end

-- Moshine

if mods["Moshine"] then
	-- Swap glass recipes
	local recipe_name = "optical-cable"
    local recipe = data.raw.recipe[recipe_name]

	if recipe then
		recipe.ingredients =
		{
			{type = "item", name = "silicon", amount = 1},
			{type = "item", name = "silicon-carbide", amount = 1},
			--{type = "item", name = "glass", amount = 1},
			{type = "item", name = "glass-plate", amount = 1}
		}
	end

	local recipe_name = "3d-data-storage"
    local recipe = data.raw.recipe[recipe_name]

	if recipe then
		recipe.ingredients =
		{
			{type = "item", name = "magnet", amount = 3},
			{type = "item", name = "silicon-cell", amount = 3},
			{type = "item", name = "datacell-empty", amount = 4},
			--{type = "item", name = "glass", amount = 5},
			{type = "item", name = "glass-plate", amount = 5},
		}
	end

	local recipe_name = "ai-trainer"
    local recipe = data.raw.recipe[recipe_name]

	if recipe then
		recipe.ingredients =
		{
			{type = "item", name = "model-unstable", amount = 1},
			{type = "item", name = "model-stable", amount = 10},
			{type = "item", name = "data-processor", amount = 1},
			{type = "item", name = "processing-unit", amount = 50},
			{type = "item", name = "concrete", amount = 100},
			--{type = "item", name = "glass", amount = 100},
			{type = "item", name = "glass-plate", amount = 100}

		}
	end

	-- Rename the sand to Quartz Sand
	local recipe_name = "maraxsis-sand-extraction"
    local recipe = data.raw.recipe[recipe_name]
	local item_prototype = data.raw["item"]["sand"]

	if recipe then
        recipe.localised_name = {"item-name.quartz-sand"}
    end

	if item_prototype then
        -- Overwrites the name defined in the locale 
        item_prototype.localised_name = {"item-name.quartz-sand"}
    end

	-- Add a new smelting recipe

	data:extend({
        {
          type = "recipe",
          name = "glas-plate-Quartz",
          localised_name = {"item-name.glass-plate"},
          localised_description = {"item-description.glass-plate"},
          category = "smelting",
          energy_required = 4,
          ingredients = {
            {type = "item", name = "sand", amount = 4}
          },
          results = {{type = "item", name = "glass-plate", amount = 1}},
          allow_productivity = true,
          enabled = false,
        },
        
    -- Change research to FactorioPlus

        {
        type = "technology",
        name = "moshine-tech-glass",
        icon = "__Moshine__/graphics/technology/moshine-tech-glass.png",
        icon_size = 256,
        effects =
        {
          {
            type = "unlock-recipe",
            recipe = "glas-plate-Quartz"
          },
        },
        prerequisites = {"planet-discovery-moshine"},
        unit =
        {
          count = 70,
          ingredients =
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
          },
          time = 60
        }
      },
      })
	
	-- Hide the now unsed Item

	local item_name = "glass"
    local item = data.raw.item[item_name]
	local recipe = data.raw.recipe[item_name]
	
	if item then
       item.hidden = true
    end

	if recipe then
       recipe.hidden = true
    end

end

-- IridescentIndustry

if mods["IridescentIndustry"] then

	-- Swap glass recipes

	local recipe_name = "iridescent-science-pack"
    local recipe = data.raw.recipe[recipe_name]

	if recipe then      
		recipe.ingredients =
		{
			{type = "item", name = "prismite-refined", amount = 1},
			{type = "item", name = "mythril-plate", amount = 1},
			-- {type = "item", name = IRIDESCENT.glass, amount = 1}, -- Auskommentiert gelassen
			{type = "item", name = "glass-plate", amount = 1},
		}
	end

	local recipe_name = "polychromatic-science-pack"
    local recipe = data.raw.recipe[recipe_name]

	if recipe then            
		recipe.ingredients =
		{
			-- Format: {type = "item", name = "Name des Gegenstands", amount = Menge}
			{type = "item", name = "prismite-crystal", amount = 1},
			--{type = "item", name = IRIDESCENT.glass, amount = 10},
			{type = "item", name = "glass-plate", amount = 10},
			{type = "item", name = "prismite-gem-r", amount = 1},
			{type = "item", name = "prismite-gem-g", amount = 1},
			{type = "item", name = "prismite-gem-b", amount = 1},
		}
    end


	local recipe_name = "s6x-prismite-crystal-glass"
    local recipe = data.raw.recipe[recipe_name]

        if recipe then
            -- Removing obsolete entry fields
            recipe.result = nil
            recipe.result_count = nil

            recipe.main_product = "glass-plate"
            
            -- Defining the new result
            recipe.results =
            {
                {
                    type = "item",         
                    name = "glass-plate",
                    amount = 20
                }
            }
        end


	local item_name = "glass"
    local item = data.raw.item[item_name]
	local recipe = data.raw.recipe[item_name]
	
	if item then
       item.hidden = true
    end

	if recipe then
       recipe.hidden = true
    end

end