-- Space age overrides
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

local containers =
{
	["container"] = { "singlestack-chest", "storage-hut", "warehouse" },
	["logistic-container"] = 
	{ 
	"logistic-passive-provider-hut", "logistic-active-provider-hut", "logistic-storage-hut", "logistic-buffer-hut", "logistic-requester-hut",
	"logistic-warehouse", "logistic-warehouse-passive-provider", "logistic-warehouse-active-provider", "logistic-warehouse-buffer", "logistic-warehouse-requester"  
	},
}

for t,l in pairs(containers) do
  for _,n in pairs(l) do
    data.raw[t][n].surface_conditions =
    {
      {
        property = "gravity",
        min = 0.1
      }
    }
  end
end

-- HEATING
-- Heat pipe radius override for space age.
data.raw["heat-pipe"]["heat-pipe"].heating_radius = settings.startup["settings-spaceage-aquilo-heatpipe-radius"].value

-- Heating values

data.raw["transport-belt"]["basic-transport-belt"].heating_energy = "10kW"
data.raw["underground-belt"]["basic-underground-belt"].heating_energy = "50kW"
data.raw["splitter"]["basic-splitter"].heating_energy = "40kW"
data.raw["loader"]["basic-loader"].heating_energy = "40kW"

data.raw["loader"]["loader"].heating_energy = "40kW"
data.raw["loader"]["fast-loader"].heating_energy = "40kW"
data.raw["loader"]["express-loader"].heating_energy = "40kW"

data.raw["transport-belt"]["turbo-transport-belt"].heating_energy = "10kW"
data.raw["underground-belt"]["turbo-underground-belt"].heating_energy = "50kW"
data.raw["splitter"]["turbo-splitter"].heating_energy = "40kW"
data.raw["loader"]["turbo-loader"].heating_energy = "40kW"

data.raw["transport-belt"]["supersonic-transport-belt"].heating_energy = "10kW"
data.raw["underground-belt"]["supersonic-underground-belt"].heating_energy = "50kW"
data.raw["splitter"]["supersonic-splitter"].heating_energy = "40kW"
data.raw["loader"]["supersonic-loader"].heating_energy = "40kW"

data.raw["assembling-machine"]["mini-assembling-machine-1"].heating_energy = "50kW"
data.raw["storage-tank"]["storage-tank-large"].heating_energy = "50kW"
data.raw["assembling-machine"]["factory-large"].heating_energy = "200kW"
data.raw["assembling-machine"]["metal-press-machine"].heating_energy = "80kW"
data.raw["assembling-machine"]["compressor"].heating_energy = "50kW"
data.raw["furnace"]["electric-foundry"].heating_energy = "50kW"
data.raw["furnace"]["heatpipe-furnace"].heating_energy = "90kW"
data.raw["furnace"]["mini-electric-furnace"].heating_energy = "30kW"
data.raw["furnace"]["basic-electric-furnace"].heating_energy = "50kW"

data.raw["inserter"]["very-long-handed-inserter"].heating_energy = "50kW"

data.raw["roboport"]["mini-roboport"].heating_energy = "100kW"
data.raw["roboport"]["roboport-major"].heating_energy = "600kW"

data.raw["lab"]["basic-lab"].heating_energy = "40kW"
data.raw["lab"]["lab-large"].heating_energy = "200kW"

--

data.raw["assembling-machine"]["mini-assembling-machine-1"].crafting_categories = {"crafting", "basic-crafting", "advanced-crafting", "electronics", "pressing"}
data.raw["assembling-machine"]["factory-large"].crafting_categories = {"crafting", "basic-crafting", "advanced-crafting", "electronics", "pressing"}

data.raw.recipe["basic-transport-belt"].category = "pressing"
data.raw.recipe["basic-underground-belt"].category = "pressing"
data.raw.recipe["basic-splitter"].category = "pressing"

data.raw.recipe["transport-belt"].category = "pressing"
data.raw.recipe["underground-belt"].category = "pressing"
data.raw.recipe["splitter"].category = "pressing"

data.raw.recipe["fast-transport-belt"].category = "pressing"
data.raw.recipe["fast-underground-belt"].category = "pressing"
data.raw.recipe["fast-splitter"].category = "pressing"

data.raw.recipe["express-transport-belt"].category = "crafting-with-fluid-or-metallurgy"
data.raw.recipe["express-underground-belt"].category = "crafting-with-fluid-or-metallurgy"
data.raw.recipe["express-splitter"].category = "crafting-with-fluid-or-metallurgy"

data.raw.recipe["turbo-transport-belt"].category = "crafting-with-fluid-or-metallurgy"
data.raw.recipe["turbo-underground-belt"].category = "crafting-with-fluid-or-metallurgy"
data.raw.recipe["turbo-splitter"].category = "crafting-with-fluid-or-metallurgy"

data.raw.recipe["supersonic-transport-belt"].category = "crafting-with-fluid-or-metallurgy"
data.raw.recipe["supersonic-underground-belt"].category = "crafting-with-fluid-or-metallurgy"
data.raw.recipe["supersonic-splitter"].category = "crafting-with-fluid-or-metallurgy"

data.extend({
{
    type = "assembling-machine",
    name = "captive-biter-spawner-1",
    icon = "__space-age__/graphics/icons/captive-biter-spawner.png",
    subgroup = "agriculture",
    flags = {"placeable-neutral", "placeable-player", "player-creation", "not-repairable", "not-deconstructable"},
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    create_ghost_on_death = false,
    max_health = 350,
    show_recipe_icon = false,
    impact_category = "organic",
    production_health_effect =
    {
      not_producing = -1 / 60, -- 5 hp per second
      producing = 1 / 60 -- 5 hp per second
    },
    ignore_output_full = true,
    alert_icon_shift = util.by_pixel(0, -12),
    icon_draw_specification = {shift = {0, -0.3}},
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        source_effects =
        {
          type = "create-explosion",
          entity_name = "captive-spawner-explosion-1"
        }
      }
    },
    dying_explosion = "captive-spawner-explosion-2",
    dying_trigger_effect =
    {
      type = "create-entity",
      entity_name = "biter-spawner",
      as_enemy = true,
      ignore_no_enemies_mode = true,
      protected = true
    },
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    surface_conditions =
    {
      {
        property = "pressure",
        min = 1000,
        max = 1000
      }
    },
    fast_replaceable_group = "captive-biter-spawner",
    graphics_set =
    {
      animation = {
        layers = {
          util.sprite_load("__space-age__/graphics/entity/captive-spawner/captive-anim",{
            frame_count = 32,
            scale = 0.5,
            animation_speed = 0.4,
          }),
          util.sprite_load("__space-age__/graphics/entity/captive-spawner/captive-shadow",{
            frame_count = 32,
            scale = 0.5,
            animation_speed = 0.4,
            draw_as_shadow = true,
          })
        }
      },
      working_visualisations = {
        {
          fadeout = true,
          animation = util.sprite_load("__space-age__/graphics/entity/captive-spawner/captive-fluids",{
            frame_count = 32,
            scale = 0.5,
            tint = {0.25,0.44,0,1},
            animation_speed = 0.4,
          })
        },
      }
    },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    working_sound =
    {
      sound = { filename = "__base__/sound/creatures/spawner.ogg", volume = 0.6 },
      sound_accents =
      {
        {sound = {variations = sound_variations("__space-age__/sound/entity/spawner/spawner-respirator-push", 3, 0.3)}, frame = 1, audible_distance_modifier = 0.6},
        {sound = {variations = sound_variations("__space-age__/sound/entity/spawner/spawner-respirator-pull", 3, 0.3)}, frame = 17, audible_distance_modifier = 0.6},
      },
    },
    crafting_categories = {"captive-spawner-process"},
    fixed_recipe = "biter-egg",
    crafting_speed = 1,
    energy_source =
    {
      type = "burner",
      fuel_categories = {"food"},
      effectivity = 1,
      fuel_inventory_size = 1,
      emissions_per_minute = { pollution = -1 },
      burner_usage = "food",
      light_flicker =
      {
        minimum_intensity = 0,
        maximum_intensity = 0,
        derivation_change_frequency = 0,
        derivation_change_deviation = 0,
        border_fix_speed = 0,
        minimum_light_size = 0,
        light_intensity_to_size_coefficient = 0,
        color = {0, 0, 0, 1}
      }
    },
    energy_usage = "100kW",
    module_slots = 0,
    allowed_effects = {},
    enable_logistic_control_behavior = false
  },
 })