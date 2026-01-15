
--data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["forest"] = {}


-- Health Setting

local time_scale = 1.0

if settings.startup["settings-world-daynightcycle"].value == "short" then
time_scale = 0.5
elseif settings.startup["settings-world-daynightcycle"].value == "long" then
time_scale = 2.0 
end

-- data.raw["planet"]["nauvis"].surface_properties =
-- {
  -- ["day-night-cycle"] = (12 * time_scale) * 60 * 60
-- }

data.raw["planet"]["nauvis"].surface_properties["day-night-cycle"] = (12 * time_scale) * 60 * 60

data.raw["map-gen-presets"]["default"]["snakey-continents-old"] = 
{
	order = "b",
      basic_settings =
      {
        starting_area = 2,
        property_expression_names = { elevation = "elevation_lakes" },
        autoplace_controls =
        {
          ["iron-ore"] = {  frequency = 0.2, size = 0.5, richness = 5},
          ["copper-ore"] = {  frequency = 0.2, size =  0.5,richness = 5},
          ["stone"] = { frequency = 0.2, size =  0.5, richness = 5},
          ["coal"] = {  frequency = 0.2, size =  0.5, richness = 5},
          ["uranium-ore"] = {  frequency = 0.1, size = 0.25, richness = 5},
          ["crude-oil"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["sand-ore"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["aquifer"] = {  frequency = 0, size =  0, richness = 0},
		  ["geothermal-vent"] = {  frequency = 0.2, size = 1, richness = 5},
		  ["forest"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["natural-gas"] = {  frequency = 0.2, size =  1, richness = 5},
		  ["bauxite-ore"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["goblin-ore"] = { frequency = 0.2, size =  0.5, richness = 5},
          ["enemy-base"] = { frequency = 1, size = 2},
		  ["water"] =  {frequency = 3.0, size = 6},
		  ["starting_area_moisture"] =  {frequency = 4.0, size = 6},
        },
      },
}

data.raw["map-gen-presets"]["default"]["snakey-continents-new"] = 
{
	order = "b",
      basic_settings =
      {
        starting_area = 2,
        property_expression_names = { },
        autoplace_controls =
        {
          ["iron-ore"] = {  frequency = 0.2, size = 0.5, richness = 5},
          ["copper-ore"] = {  frequency = 0.2, size =  0.5,richness = 5},
          ["stone"] = { frequency = 0.2, size =  0.5, richness = 5},
          ["coal"] = {  frequency = 0.2, size =  0.5, richness = 5},
          ["uranium-ore"] = {  frequency = 0.1, size = 0.25, richness = 5},
          ["crude-oil"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["sand-ore"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["aquifer"] = {  frequency = 0, size =  0, richness = 0},
		  ["geothermal-vent"] = {  frequency = 0.2, size = 1, richness = 5},
		  ["forest"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["natural-gas"] = {  frequency = 0.2, size =  1, richness = 5},
		  ["bauxite-ore"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["goblin-ore"] = { frequency = 0.2, size =  0.5, richness = 5},
          ["enemy-base"] = { frequency = 1, size = 2},
		  ["water"] =  {frequency = 3.0, size = 1.5},
		  ["starting_area_moisture"] =  {frequency = 4.0, size = 6},
        },
      },
}


data.raw["map-gen-presets"]["default"]["snakey-continents-z-authors-pick"] = 
{
	order = "b",
      basic_settings =
      {
        starting_area = 1.5,
        property_expression_names = { 
		 },
        autoplace_controls =
        {
          ["iron-ore"] = {  frequency = 0.2, size = 0.5, richness = 5},
          ["copper-ore"] = {  frequency = 0.2, size =  0.5,richness = 5},
          ["stone"] = { frequency = 0.2, size =  0.5, richness = 5},
          ["coal"] = {  frequency = 0.2, size =  0.5, richness = 5},
          ["uranium-ore"] = {  frequency = 0.1, size = 0.25, richness = 5},
          ["crude-oil"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["sand-ore"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["aquifer"] = {  frequency = 0, size =  0, richness = 0},
		  ["geothermal-vent"] = {  frequency = 0.2, size = 1, richness = 5},
		  ["forest"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["natural-gas"] = {  frequency = 0.2, size =  1, richness = 5},
		  ["bauxite-ore"] = {  frequency = 0.2, size =  0.5, richness = 5},
		  ["goblin-ore"] = { frequency = 0.2, size =  0.5, richness = 5},
          ["enemy-base"] = { frequency = 1, size = 3},
		  ["water"] =  {frequency = 3.0, size = 1.5},
		  ["starting_area_moisture"] =  {frequency = 4.0, size = 6},
        },
      },
	   advanced_settings =
      {
        enemy_evolution =
        {
          time_factor = 0.000004,
          pollution_factor = 0.0000004
        },
        pollution =
        {
          ageing = 0.5,
          enemy_attack_pollution_consumption_modifier = 0.8
        },
		enemy_expansion =
		{
			max_expansion_distance = 9,
			settler_group_min_size = 10,
			settler_group_max_size = 30,
			min_expansion_cooldown = 60 * 60 * 20,
			max_expansion_cooldown = 60 * 60 * 60,
		},
        difficulty_settings =
        {
          technology_price_multiplier = 10
        }
      }
}

data.raw["map-gen-presets"]["default"]["oasis"] = 
{
	order = "b",
      basic_settings =
      {
        starting_area = 3,
         property_expression_names = 
		{
			--temperature = 30,
			moisture = 0.1,
			--moisture = "moisture_basic",
			aux = "aux_basic",
		},
        autoplace_controls =
        {
			["iron-ore"] = {  frequency = 0.2, size = 0.6, richness = 5},
			["copper-ore"] = {  frequency = 0.2, size = 0.4,richness = 6},
			["stone"] = { frequency = 0.2, size = 0.5, richness = 5},
			["coal"] = {  frequency = 0.2, size = 0.6, richness = 5},
			["uranium-ore"] = {  frequency = 0.1, size = 0.25, richness = 4},
			["crude-oil"] = {  frequency = 0.2, size = 0.5, richness = 5},
			["sand-ore"] = {  frequency = 2, size = 10, richness = 0.25},
			["aquifer"] = {  frequency = 0.1, size = 0.4, richness = 6},
			["geothermal-vent"] = {  frequency = 0.2, size = 0.5, richness = 5},
			["forest"] = {  frequency = 0.1, size = 6, richness = 0.1},
			["natural-gas"] = {  frequency = 0.2, size = 1, richness = 5},
			["bauxite-ore"] = {  frequency = 0.2, size = 0.6, richness = 4},
			["goblin-ore"] = { frequency = 0.2, size =  0.5, richness = 5},
			
			["enemy-base"] = { frequency = 0.2, size = 6},
			["water"] =  {frequency = 0, size = 0},
			["trees"] =  {frequency = 1, size = 0.1},
			["rocks"] =  {frequency = 1, size = 1},
			["nauvis_cliff"] =  {frequency = 0.0001, size =0.0001, richness = 0.0001},
			["starting_area_moisture"] =  {frequency = 3.0, size = 6},
		    --["moisture_basic"] = {frequency = 0, size = 0},
			--["aux"] =  {frequency = 0, size = 0},
        },
      },
}

data.raw["map-gen-presets"]["default"]["goblin-mode"] = 
{
	order = "c",
      basic_settings =
      {
        starting_area = 2,
       
        autoplace_controls =
        {
          ["iron-ore"] = {  frequency = 0.0, size = 0.0, richness = 0},
          ["copper-ore"] = {  frequency = 0, size =  0,richness = 0},
          ["stone"] = { frequency = 0, size =  0, richness = 0},
          ["coal"] = {  frequency = 0, size =  0, richness = 0},
		  ["goblin-ore"] = { frequency = 8, size =  6, richness = 0.1},
          ["enemy-base"] = { frequency = 0.5, size = 3},
        },
      },
}


   