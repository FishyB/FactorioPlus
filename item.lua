--item.lua

local sounds = require ("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

local healing_cooldown = 60 * 5

local tarmac_icon = {
  {
    icon = "__base__/graphics/icons/concrete.png",
    icon_size = 64,
    tint = { a = 1, r=0.25, g=0.25, b=0.25}
  },
}

---------------------------------------
-- SPACE AGE OVERRIDES AND THINGS HERE --
---------------------------------------

-- {
    -- type = "capsule",
    -- name = "cliff-explosives-light",
    -- icon = "__factorioplus__/graphics/icons/cliff-explosives-light.png",
    -- flags = {"hide-from-bonus-gui"},
    -- capsule_action =
    -- {
      -- type = "destroy-cliffs",
      -- radius = 1.5,
      -- attack_parameters =
      -- {
        -- type = "projectile",
        -- activation_type = "throw",
        -- ammo_category = "grenade",
        -- cooldown = 30,
        -- projectile_creation_distance = 0.6,
        -- range = 10,
        -- ammo_type =
        -- {
          -- target_type = "position",
          -- action =
          -- {
            -- type = "direct",
            -- action_delivery =
            -- {
              -- type = "projectile",
              -- projectile = "cliff-explosives",
              -- starting_speed = 0.3
            -- }
          -- }
        -- }
      -- }
    -- },
    -- subgroup = "terrain",
    -- order = "cz[cliff-explosives-light]",
    -- inventory_move_sound = item_sounds.explosive_inventory_move,
    -- pick_sound = item_sounds.explosive_inventory_pickup,
    -- drop_sound = item_sounds.explosive_inventory_move,
    -- stack_size = 20
  -- },
  

---------------------------------------------------  FACTORIOPLUS ITEM GROUP OVERRIDE  ------------------------------------------------------------

  data.raw["item"]["train-stop"].subgroup = "train-infrastructure"
  data.raw["rail-planner"]["rail"].subgroup = "train-infrastructure"  
  data.raw["item"]["rail-signal"].subgroup = "train-infrastructure"  
  data.raw["item"]["rail-chain-signal"].subgroup = "train-infrastructure"
  
  data.raw["item"]["steam-turbine"].subgroup = "fluidpower"
  data.raw["item"]["steam-engine"].subgroup = "fluidpower"
  data.raw["item"]["boiler"].subgroup = "fluidpower"
  
   data.raw["item-with-entity-data"]["locomotive"].subgroup = "trains"  
   data.raw["item-with-entity-data"]["cargo-wagon"].subgroup = "trains"  
   data.raw["item-with-entity-data"]["fluid-wagon"].subgroup = "trains"  
   data.raw["item-with-entity-data"]["artillery-wagon"].subgroup = "trains"
   
   data.raw["item"]["pumpjack"].subgroup = "fluidextraction"
   data.raw["item"]["chemical-plant"].subgroup = "fluidprocessing"
   data.raw["item"]["oil-refinery"].subgroup = "fluidprocessing"
   
   data.raw["item"]["pump"].subgroup = "pumps"
   data.raw["item"]["offshore-pump"].subgroup = "pumps"
   
   data.raw["item"]["storage-tank"].subgroup = "pipes"	
   data.raw["item"]["pipe"].subgroup = "pipes"
   data.raw["item"]["pipe-to-ground"].subgroup = "pipes"
  
-- If elevated rails is in the game, then push them into the rail subgroup tab
if (mods["elevated-rails"]) then  
	data.raw["rail-planner"]["rail-ramp"].subgroup = "train-infrastructure"  
	data.raw["item"]["rail-support"].subgroup = "train-infrastructure"  
end

 ---------------------------------------------------  FACTORIOPLUS STUFF  ------------------------------------------------------------
data:extend
({ 
   {
    type = "item",
    name = "storage-tank-large",
    icon = "__factorioplus__/graphics/icons/storage-tank-large.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "pipes",
    order = "b[fluid]-a[storage-tank]",
    place_result = "storage-tank-large",
	 pick_sound = item_sounds.metal_large_inventory_pickup,
    drop_sound = item_sounds.metal_large_inventory_move,
    stack_size = 25
  },
  {
    type = "item",
    name = "listening-post",
    icon = "__factorioplus__/graphics/icons/listening-post.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "defensive-structure",
    order = "d[radar]-a[radar]",
    place_result = "listening-post",
    stack_size = 50
  },
  {
    type = "item",
    name = "radar-large",
    icon = "__factorioplus__/graphics/icons/large-radar.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "defensive-structure",
    order = "d[radar]-a[radar]",
    place_result = "radar-large",
    stack_size = 10
  },
  {
    type = "item",
    name = "tarmac",
    icons = tarmac_icon,
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "path-infrastructure",
    order = "b[concrete]-a[plain]",
    stack_size = 100,
    place_as_tile =
    {
      result = "tarmac",
      condition_size = 1,
	  condition = {layers={water_tile=true}}
    }
  },
  {
    type = "item",
    name = "long-handed-burner-inserter",
    icon = "__factorioplus__/graphics/icons/long-handed-burner-inserter.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "inserter",
    order = "ab[burner-inserter]",
    place_result = "long-handed-burner-inserter",
    stack_size = 50
  },
   {
    type = "item",
    name = "very-long-handed-inserter",
    icon = "__factorioplus__/graphics/icons/very-long-handed-inserter.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "inserter",
    order = "da[very-long-handed-inserter]",
    place_result = "very-long-handed-inserter",
    stack_size = 50
  },
  
   {
    type = "item",
    name = "large-burner-mining-drill",
    icon = "__factorioplus__/graphics/icons/large-burner-miner.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "extraction-machine",
    order = "a[items]-a[burner-mining-drill]",
    place_result = "large-burner-mining-drill",
    stack_size = 50
  },
  
 -- {
    -- type = "item",
    -- name = "crane-inserter",
    -- icon = "__base__/graphics/icons/inserter.png",
    -- icon_size = 64, icon_mipmaps = 4,
    -- subgroup = "inserter",
    -- order = "b[inserter]",
    -- place_result = "crane-inserter",
    -- stack_size = 25
  -- },
{
    type = "item",
    name = "air-scrubber",
    icon = "__factorioplus__/graphics/icons/air_scrubber.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "anti-pollution",
    order = "[assembling-machine-1]a",
    place_result = "air-scrubber",
    stack_size = 25
  },
  {
    type = "item",
    name = "crash-site-electric-pole",
    icon = "__factorioplus__/graphics/icons/crash-site-electric-pole.png",
    icon_size = 64, icon_mipmaps = 4,
    place_result = "crash-site-electric-pole",
    stack_size = 50
  },
  {
    type = "item",
    name = "air-scrubber-large",
    icon = "__factorioplus__/graphics/icons/air_scrubber_large.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "anti-pollution",
    order = "[assembling-machine-1]a",
    place_result = "air-scrubber-large",
    stack_size = 10
  },
{
    type = "item",
    name = "factory-large",
    icon = "__factorioplus__/graphics/icons/factory.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "a[assembling-machine-1]",
    place_result = "factory-large",
    stack_size = 10
  },
  {
    type = "item",
    name = "mini-assembling-machine-1",
    icon = "__factorioplus__/graphics/icons/mini-assembling-machine.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "a[assembling-machine-1]",
    place_result = "mini-assembling-machine-1",
    stack_size = 50
  },
  {
    type = "item",
    name = "metal-press-machine",
    icon = "__factorioplus__/graphics/icons/metal-press-machine.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "a[assembling-machine-1]",
    place_result = "metal-press-machine",
    stack_size = 50
  },
    {
    type = "item",
    name = "compressor",
    icon = "__factorioplus__/graphics/icons/compressor.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "a[assembling-machine-1]",
    place_result = "compressor",
    stack_size = 25
  },
  {
    type = "item",
    name = "big-furnace",
    icon = "__factorioplus__/graphics/icons/big-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "ba[stone-furnace]",
    place_result = "big-furnace",
    stack_size = 25
  },
    {
    type = "item",
    name = "mini-electric-furnace",
    icon = "__factorioplus__/graphics/icons/mini-electric-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "bz[electric-furnace]",
    place_result = "mini-electric-furnace",
    stack_size = 50
  },
      {
    type = "item",
    name = "basic-electric-furnace",
    icon = "__factorioplus__/graphics/icons/basic-electric-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "bz[electric-furnace]",
    place_result = "basic-electric-furnace",
    stack_size = 25
  },
    {
    type = "item",
    name = "basic-lab",
    icon = "__factorioplus__/graphics/icons/basic-lab.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "y[lab]",
    place_result = "basic-lab",
    stack_size = 20,
  },
   {
    type = "item",
    name = "lab-large",
    icon = "__factorioplus__/graphics/icons/lab-large.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "za[lab]",
    place_result = "lab-large",
    stack_size = 5,
  },
    {
    type = "item",
    name = "singlestack-chest",
    icon = "__factorioplus__/graphics/icons/singlestack-chest.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "storage",
    order = "a[items]-c[steel-chest]",
    place_result = "singlestack-chest",
    stack_size = 50
  },
  {
    type = "item",
    name = "storage-hut",
    icon = "__factorioplus__/graphics/icons/storage-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "storage",
    order = "a[items]-c[steel-chest]",
    place_result = "storage-hut",
    stack_size = 25
  },
    {
    type = "item",
    name = "logistic-passive-provider-hut",
    icon = "__factorioplus__/graphics/icons/logistics-passive-provider-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "b[storage]-c[logistic-chest-passive-provider]",
    place_result = "logistic-passive-provider-hut",
    stack_size = 25
  },
   {
    type = "item",
    name = "logistic-active-provider-hut",
    icon = "__factorioplus__/graphics/icons/logistics-active-provider-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "b[storage]-c[logistic-chest-active-provider]",
    place_result = "logistic-active-provider-hut",
    stack_size = 25
  },
   {
    type = "item",
    name = "logistic-buffer-hut",
    icon = "__factorioplus__/graphics/icons/logistics-buffer-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "b[storage]-d[logistic-chest-buffer]",
    place_result = "logistic-buffer-hut",
    stack_size = 25
  },
   {
    type = "item",
    name = "logistic-storage-hut",
    icon = "__factorioplus__/graphics/icons/logistics-storage-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "b[storage]-c[logistic-chest-storage]",
    place_result = "logistic-storage-hut",
    stack_size = 25
  },
   {
    type = "item",
    name = "logistic-requester-hut",
    icon = "__factorioplus__/graphics/icons/logistics-requester-hut.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "b[storage]-e[logistic-chest-requester]]",
    place_result = "logistic-requester-hut",
    stack_size = 25
  },
{
    type = "item",
    name = "warehouse",
    icon = "__factorioplus__/graphics/icons/warehouse.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "storage",
    order = "a[items]-c[steel-chest]",
    place_result = "warehouse",
    stack_size = 10
  },
  {
    type = "item",
    name = "logistic-warehouse",
    icon = "__factorioplus__/graphics/icons/logistics-warehouse-storage.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "b[storage]-c[logistic-chest-storage]",
    place_result = "logistic-warehouse",
    stack_size = 10
  },
   {
    type = "item",
    name = "logistic-warehouse-passive-provider",
    icon = "__factorioplus__/graphics/icons/logistics-warehouse-passive-provider.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "b[storage]-c[logistic-chest-passive-provider]",
    place_result = "logistic-warehouse-passive-provider",
    stack_size = 10
  },
   {
    type = "item",
    name = "logistic-warehouse-active-provider",
    icon = "__factorioplus__/graphics/icons/logistics-warehouse-active-provider.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "b[storage]-c[logistic-chest-active-provider]",
    place_result = "logistic-warehouse-active-provider",
    stack_size = 10
  },
   {
    type = "item",
    name = "logistic-warehouse-buffer",
    icon = "__factorioplus__/graphics/icons/logistics-warehouse-buffer.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "b[storage]-d[logistic-chest-buffer]",
    place_result = "logistic-warehouse-buffer",
    stack_size = 10
  },
   {
    type = "item",
    name = "logistic-warehouse-requester",
    icon = "__factorioplus__/graphics/icons/logistics-warehouse-requester.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "b[storage]-e[logistic-chest-requester]",
    place_result = "logistic-warehouse-requester",
    stack_size = 10
  },
    {
    type = "item",
    name = "solar-array",
    icon = "__factorioplus__/graphics/icons/solar-array.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "energy",
    order = "d[solar-panel]-b[solar-array]",
    place_result = "solar-array",
    stack_size = 25
  },
  {
    type = "item",
    name = "solar-array-2",
    icon = "__factorioplus__/graphics/icons/solar-array-2.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "energy",
    order = "d[solar-panel]-c[solar-array-2]",
    place_result = "solar-array-2",
    stack_size = 10
  },
  
 })
   
------------------------------------------ LOADERS 0 & 1 & 2 & 3 & 4 & 5 ------------------------------------------

if settings.startup["settings-loaders-active"].value then
data.extend({
  {
    type = "item",
    name = "basic-loader",
    icon = "__factorioplus__/graphics/icons/basic-loader.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "d[loader]-a[basic-loader]",
    place_result = "basic-loader",
    stack_size = 50
  },
  {
    type = "item",
    name = "loader",
    icon = "__factorioplus__/graphics/icons/loader.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "d[loader]-a[basic-loader]",
    place_result = "loader",
    stack_size = 50
  },
  {
    type = "item",
    name = "fast-loader",
    icon = "__factorioplus__/graphics/icons/fast-loader.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "d[loader]-b[fast-loader]",
    place_result = "fast-loader",
    stack_size = 50
  },
  {
    type = "item",
    name = "express-loader",
    icon = "__factorioplus__/graphics/icons/express-loader.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "d[loader]-c[express-loader]",
    place_result = "express-loader",
    stack_size = 50,
  },
    {
    type = "item",
    name = "turbo-loader",
    icon = "__factorioplus__/graphics/icons/turbo-loader.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "d[loader]-d[turbo-loader]",
    place_result = "turbo-loader",
    stack_size = 50,
  },
  {
    type = "item",
    name = "supersonic-loader",
    icon = "__factorioplus__/graphics/icons/supersonic-loader.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "d[loader]-e[supersonic-loader]",
    place_result = "supersonic-loader",
    stack_size = 50
  }, 
 })
end

data.extend({
     {
    type = "item",
    name = "floor-lamp",
    icon = "__factorioplus__/graphics/icons/floor-lamp.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "circuit-network",
    order = "a[light]-abc[floor-lamp]",
    place_result = "floor-lamp",
    stack_size = 50
  },
    {
    type = "item",
    name = "floodlight-lamp",
    icon = "__factorioplus__/graphics/icons/floodlight.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "circuit-network",
    order = "a[light]-ab[floodlight-lamp]",
    place_result = "floodlight-lamp",
    stack_size = 25
  },
   {
    type = "item",
    name = "basic-explosive",
    icon = "__factorioplus__/graphics/icons/basic-explosive.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "b[chemistry]-e[explosives]",
    stack_size = 100,
	weight = 0.5*kg
  },
    {
    type = "item",
    name = "aluminium-plate",
    icon = "__factorioplus__/graphics/icons/aluminium-plate.png",
    icon_size = 64, icon_mipmaps = 3,
    subgroup = "raw-material",
    order = "b[iron-plate]",
	inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    stack_size = 100,
	eight = 0.25 * kg,
  },
  {
    type = "item",
    name = "glass-plate",
    icon = "__factorioplus__/graphics/icons/glass-plate.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "b[iron-plate]",
	inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    stack_size = 100,
	 weight = 2*kg
  },
  {
    type = "item",
    name = "silicon-wafer",
    icon = "__factorioplus__/graphics/icons/silicon-wafer.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "b[iron-plate]",
	inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    stack_size = 100,
	weight = 1*kg
  },
  {
    type = "item",
    name = "landfill",
    icon = "__base__/graphics/icons/landfill.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]",
	 inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    stack_size = 100,
    place_as_tile =
    {
      result = "landfill",
      condition_size = 1,
	  condition = {layers={ground_tile=true}},
	  tile_condition = {"water", "water-green", "water-shallow", "water-mud"},
    },
	random_tint_color = item_tints.organic_green,
  },
  {
    type = "item",
    name = "landfill-deep",
    icon = "__factorioplus__/graphics/icons/landfill-deep.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]",
	 inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    stack_size = 50,
    place_as_tile =
    {
      result = "water",
      condition_size = 1,
	  condition = {layers={ground_tile=true}},
	  tile_condition = {"deepwater", "deepwater-green"},
    },
	random_tint_color = item_tints.organic_green,
  },
    {
    type = "item",
    name = "waterfill-barrel",
    icon = "__factorioplus__/graphics/icons/waterfill-barrel.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]",
    stack_size = 50,
    place_as_tile =
    {
      result = "water",
      condition_size = 1,
	  condition = {layers={water_tile=true, flooring_tile=true}},
    },
  },

   {
    type = "item",
    name = "accumulator-battery",
    icon = "__factorioplus__/graphics/icons/accumulator-battery.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "energy",
    order = "e[accumulator]-a[accumulator]",
    place_result = "accumulator-battery",
    stack_size = 25,
	 weight = 50*kg
  },
  
    {
    type = "item",
    name = "adv-accumulator-battery",
    icon = "__factorioplus__/graphics/icons/adv-accumulator-battery.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "energy",
    order = "e[accumulator]-a[accumulator]",
    place_result = "adv-accumulator-battery",
    stack_size = 10,
	 weight = 100*kg
  },
   
   	----------------------------------------
	
   -- VEHICLES HERE --
  
  {
    type = "item-with-entity-data",
    name = "car-base",
    icon = "__base__/graphics/icons/car.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "simple-vehicles",
    order = "ba[cars]",
    place_result = "car-base",
    stack_size = 1
  },
  
  -- Car is overriden here:
   {
    type = "item-with-entity-data",
    name = "car",
    icon = "__base__/graphics/icons/car.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "military-vehicles",
    order = "aa[milveh]",
    place_result = "car",
    stack_size = 1
  },
  
  {
    type = "item-with-entity-data",
    name = "car-shotgun",
    icon = "__base__/graphics/icons/car.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "military-vehicles",
    order = "ab[milveh]",
    place_result = "car-shotgun",
    stack_size = 1
  },
  
    {
    type = "item-with-entity-data",
    name = "scout",
    icon = "__factorioplus__/graphics/icons/speeder.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "simple-vehicles",
    order = "e[cars]",
    place_result = "scout",
    stack_size = 1
  },
  
  {
    type = "item-with-entity-data",
    name = "transporter",
    icon = "__factorioplus__/graphics/icons/transporter.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "utility-vehicles",
    order = "b[utilveh]",
    place_result = "transporter",
    stack_size = 1
  },
  
  {
    type = "item-with-entity-data",
    name = "atv",
    icon = "__factorioplus__/graphics/icons/atv.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "simple-vehicles",
    order = "9[cars]",
    place_result = "atv",
    stack_size = 1
  },
  
    {
    type = "item-with-entity-data",
    name = "atv-drone",
    icon = "__factorioplus__/graphics/icons/atv.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "military-vehicles",
    order = "ab[milveh]",
    place_result = "atv-drone",
    stack_size = 1
  },
  
    {
    type = "item-with-entity-data",
    name = "atv-exploding",
    icon = "__factorioplus__/graphics/icons/atv.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "military-vehicles",
    order = "aa[milveh]",
    place_result = "atv-exploding",
    stack_size = 1
  },
  
  
   {
    type = "item-with-entity-data",
    name = "apc-base",
    icon = "__factorioplus__/graphics/icons/apc.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "simple-vehicles",
    order = "ca[cars]",
    place_result = "apc-base",
    stack_size = 1
  },
  
  {
    type = "item-with-entity-data",
    name = "apc-twinsmg",
    icon = "__factorioplus__/graphics/icons/apc-smg.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "military-vehicles",
    order = "cb[milveh]",
    place_result = "apc-twinsmg",
    stack_size = 1
  },
  
   {
    type = "item-with-entity-data",
    name = "apc-autoshotgun",
    icon = "__factorioplus__/graphics/icons/apc-autoshotgun.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "military-vehicles",
    order = "cb[milveh]",
    place_result = "apc-autoshotgun",
    stack_size = 1
  },
  
   {
    type = "item-with-entity-data",
    name = "apc-rocket",
    icon = "__factorioplus__/graphics/icons/apc-rocket.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "military-vehicles",
    order = "cb[milveh]",
    place_result = "apc-rocket",
    stack_size = 1
  },
  
  {
    type = "item-with-entity-data",
    name = "dozer",
    icon = "__factorioplus__/graphics/icons/dozer.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "utility-vehicles",
    order = "da[utilveh]",
    place_result = "dozer",
    stack_size = 1
  },
   {
    type = "item-with-entity-data",
    name = "flame-tank",
    icon = "__factorioplus__/graphics/icons/flame-tank.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "military-vehicles",
    order = "ta[milveh]",
    place_result = "flame-tank",
    stack_size = 1
  },
  -- TANK OVERRIDE --
   {
    type = "item-with-entity-data",
    name = "tank",
    icon = "__base__/graphics/icons/tank.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "military-vehicles",
    order = "tb[milveh]",
    place_result = "tank",
    stack_size = 1
  },
  
   {
    type = "item-with-entity-data",
    name = "hovercraft",
    icon = "__factorioplus__/graphics/icons/hovercraft.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "utility-vehicles",
    order = "c[utilveh]",
    place_result = "hovercraft",
    stack_size = 1
  },
 
	----------------------------------------

  {
    type = "item",
    name = "pistol-turret",
    icon = "__factorioplus__/graphics/icons/pistol-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "turret",
    order = "b[turret]-9[pistol-turret]",
    place_result = "pistol-turret",
    stack_size = 50,
	weight = 25*kg
  },
   {
    type = "item",
    name = "heavygun-turret",
    icon = "__factorioplus__/graphics/icons/heavy-gun-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "turret",
    order = "b[turret]-a[gun-turret]",
    place_result = "heavygun-turret",
    stack_size = 25,
	 weight = 100*kg
  },
  {
    type = "item",
    name = "cannon-turret",
    icon = "__factorioplus__/graphics/icons/cannon-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "turret",
    order = "b[turret]-cb[cannon-turret]",
    place_result = "cannon-turret",
    stack_size = 10,
	 weight = 1000*kg
  },
    {
    type = "item",
    name = "chaingun-turret",
    icon = "__base__/graphics/icons/gun-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "turret",
    order = "b[turret]-ab[chaingun-turret]",
    place_result = "chaingun-turret",
    stack_size = 10,
	 weight = 500*kg
  },
    {
    type = "item",
    name = "large-laser-turret",
    icon = "__factorioplus__/graphics/icons/mega-laser.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "turret",
    order = "b[turret]-ba[large-laser-turret]",
    place_result = "large-laser-turret",
    stack_size = 5,
	 weight = 1000*kg
  },

})

  data.extend
({
  {
    type = "item",
    name = "rocket-turret",
    icon = "__factorioplus__/graphics/icons/rocket-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "turret",
    order = "b[turret]-ca[rocket-turret]",
    place_result = "rocket-turret",
    stack_size = 15
  },
}) 

  
   data.extend({  
  
  
   {
    type = "item",
    name = "mortar-turret",
    icon = "__factorioplus__/graphics/icons/mortar-turret.png",
    icon_size = 64, icon_mipmaps = 4,
   subgroup = "turret",
    order = "b[turret]-d[artillery-turret]-9[turret]",
    place_result = "mortar-turret",
    stack_size = 10
  },
   {
    type = "item",
    name = "shotgun-turret",
    icon = "__factorioplus__/graphics/icons/shotgun-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "turret",
    order = "b[turret]-a[shotgun-turret]",
    place_result = "shotgun-turret",
    stack_size = 25
  },
   {
    type = "item",
    name = "sniper-turret",
    icon = "__factorioplus__/graphics/icons/sniper-tower.png",
    icon_size = 64, icon_mipmaps = 4,
	subgroup = "turret",
    order = "b[turret]-ac[sniper-turret]",
    place_result = "sniper-turret",
    stack_size = 10
  },
  
	----------------------------------------
  
   {
    type = "item",
    name = "steel-forge",
    icon = "__factorioplus__/graphics/icons/steel-forge.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "bb[stone-furnace]",
    place_result = "steel-forge",
    stack_size = 25
  },
   {
    type = "item",
    name = "electric-foundry",
    icon = "__factorioplus__/graphics/icons/electric-foundry.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "eb[electric-furnace]",
    place_result = "electric-foundry",
    stack_size = 25
  },
   {
    type = "item",
    name = "heatpipe-furnace",
    icon = "__factorioplus__/graphics/icons/heatpipe-furnace.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "smelting-machine",
    order = "f[heatpipe-furnace]",
    place_result = "heatpipe-furnace",
    stack_size = 10
  },
  {
    type = "item",
    name = "electric-grinder",
    icon = "__factorioplus__/graphics/icons/electric-grinder.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "extraction-machine",
    order = "a[items]-bb[electric-mining-drill]",
    place_result = "electric-grinder",
    stack_size = 25
  },
   {
    type = "item",
    name = "steam-turbine-miner",
    icon = "__factorioplus__/graphics/icons/turbine-miner.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "extraction-machine",
    order = "a[items]-c[steam-mining-drill]",
    place_result = "steam-turbine-miner",
    stack_size = 25
  },
  {
    type = "item",
    name = "electric-sawmill",
    icon = "__factorioplus__/graphics/icons/sawmill.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "sawmills",
    order = "a[items]-9[sawmill]",
    place_result = "electric-sawmill",
    stack_size = 25
  },
  {
    type = "item",
    name = "gas-extractor",
    icon = "__factorioplus__/graphics/icons/gas-extractor.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "fluidextraction",
    order = "a[items]",
    place_result = "gas-extractor",
    stack_size = 25
  },
   {
    type = "repair-tool",
    name = "repair-pack-advanced",
    icon = "__factorioplus__/graphics/icons/adv-repair-tool.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "tool",
    order = "b[repair]-a[repair-pack]",
    speed = 5,
    durability = 750,
    stack_size = 50,
	random_tint_color = item_tints.iron_rust
  },
   {
    type = "item",
    name = "basic-transport-belt",
    icon = "__factorioplus__/graphics/icons/basic-transport-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "a[transport-belt]",
    place_result = "basic-transport-belt",
    stack_size = 100
  },
  {
    type = "item",
    name = "turbo-transport-belt",
    icon = "__factorioplus__/graphics/icons/turbo-transport-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "a[transport-belt]-d[turbo-transport-belt]",
    place_result = "turbo-transport-belt",
    stack_size = 100
  },
  {
    type = "item",
    name = "supersonic-transport-belt",
    icon = "__factorioplus__/graphics/icons/supersonic-transport-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "a[transport-belt]-e[supersonic-transport-belt]",
    place_result = "supersonic-transport-belt",
    stack_size = 100
  },
  {
    type = "item",
    name = "basic-splitter",
    icon = "__factorioplus__/graphics/icons/basic-splitter.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "c[splitter]-a[basic-splitter]",
    place_result = "basic-splitter",
    stack_size = 50
  },
    {
    type = "item",
    name = "turbo-splitter",
    icon = "__factorioplus__/graphics/icons/turbo-splitter.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "c[splitter]-d[turbo-splitter]",
    place_result = "turbo-splitter",
    stack_size = 50
  },
   {
    type = "item",
    name = "supersonic-splitter",
    icon = "__factorioplus__/graphics/icons/supersonic-splitter.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "c[splitter]-e[supersonic-splitter]",
    place_result = "supersonic-splitter",
    stack_size = 50
  },
    {
    type = "item",
    name = "basic-underground-belt",
    icon = "__factorioplus__/graphics/icons/basic-underground-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "b[underground-belt]-a[basic-underground-belt]",
    place_result = "basic-underground-belt",
    stack_size = 50
  },
  {
    type = "item",
    name = "turbo-underground-belt",
    icon = "__factorioplus__/graphics/icons/turbo-underground-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "b[underground-belt]-d[turbo-underground-belt]",
    place_result = "turbo-underground-belt",
    stack_size = 50
  },
  {
    type = "item",
    name = "supersonic-underground-belt",
    icon = "__factorioplus__/graphics/icons/supersonic-underground-belt.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "belt",
    order = "b[underground-belt]-e[supersonic-underground-belt]",
    place_result = "supersonic-underground-belt",
    stack_size = 50
  },
    {
    type = "item",
    name = "medium-wooden-electric-pole",
    icon = "__factorioplus__/graphics/icons/medium-wooden-electric-pole.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-ab[small-electric-pole]",
    place_result = "medium-wooden-electric-pole",
    stack_size = 50
  },
  {
    type = "item",
    name = "electrical-distributor",
    icon = "__factorioplus__/graphics/icons/electric-distributor.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-e[substation]",
    place_result = "electrical-distributor",
    stack_size = 25
  },
{
    type = "item",
    name = "huge-electric-pole",
    icon = "__factorioplus__/graphics/icons/huge-electric-pole.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-f[electrical-distributor]",
    place_result = "huge-electric-pole",
    stack_size = 25
  },
    {
    type = "item",
    name = "roboport-major",
    icon = "__factorioplus__/graphics/icons/robo-superport.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "c[signal]-a[roboport]",
    place_result = "roboport-major",
    stack_size = 5
  },
      {
    type = "item",
    name = "mini-roboport",
    icon = "__factorioplus__/graphics/icons/mini-roboport.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "logistic-network",
    order = "c[signal]-a[roboport]",
    place_result = "mini-roboport",
    stack_size = 25
  },
  {
    type = "item",
    name = "vehicle-chassis",
    icon = "__factorioplus__/graphics/icons/chassis.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-military-product",
    order = "c",
    stack_size = 25
  },
  {
    type = "item",
    name = "cannon",
    icon = "__base__/graphics/icons/tank-cannon.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-military-product",
    order = "e",
    stack_size = 25
  },
    {
    type = "item",
    name = "laser",
    icon = "__factorioplus__/graphics/icons/laser.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-military-product",
    order = "d",
    stack_size = 25
  },
  
  {
    type = "item",
    name = "turret-base",
    icon = "__factorioplus__/graphics/icons/turret-base.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-military-product",
    order = "a",
    stack_size = 25
  },
  
{
    type = "item",
    name = "basic-wall",
	icon = "__factorioplus__/graphics/icons/basic-wall.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "defensive-structure",
    order = "9[basic-wall]",
	place_result = "basic-wall",
    stack_size = 100
  },
  
  -- {
    -- type = "item",
    -- name = "reinforced-wall",
	-- icons = {
  -- {
    -- icon = "__base__/graphics/icons/wall.png",
	-- tint = {r=0.6, g=0.6, b=0.6, a=1},
  -- },
  -- {
    -- icon = "__base__/graphics/icons/concrete.png",
	-- scale = 0.4,
    -- shift = {8, 9 }
  -- },
-- },
    -- icon_size = 64, icon_mipmaps = 4, 
    -- subgroup = "defensive-structure",
    -- order = "a[stone-wall]",
	-- place_result = "reinforced-wall",
    -- stack_size = 100
  -- },
  
   {
    type = "item",
    name = "offshore-pump-large",
    icon = "__factorioplus__/graphics/icons/offshore-pump-large.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "pumps",
    order = "b[fluids]-a[offshore-pump]",
    place_result = "offshore-pump-large",
    stack_size = 10
  },

   {
    type = "tool",
    name = "bio-science-pack",
    localised_description = {"item-description.science-pack"},
    icon = "__factorioplus__/graphics/icons/bio-science.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "science-pack",
    order = "b[military-science-pack]",
    stack_size = 200,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value",
	 weight = 1*kg
  },

    {
    type = "virtual-signal",
    name = "signal-cross",
    icon = "__core__/graphics/cancel.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "virtual-signal",
    order = "e[signal]-[1checked]"
  },

})

data.extend({ 

	{
    type = "capsule",
    name = "meaty-chunks",
    icon = "__factorioplus__/graphics/icons/meaty-chunks.png",
	flags = {"always-show"},
    icon_size = 64, icon_mipmaps = 3,
    subgroup = "raw-material",
    order = "gz[raw-fish]",
	fuel_category = "chemical",
    fuel_value = "0.25MJ",
	fuel_emissions_multiplier = 20,
	capsule_action =
    {
      type = "use-on-self",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = healing_cooldown,
        range = 0,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
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
                  damage = {type = "physical", amount = 10}
                },
                {
                  type = "play-sound",
                  sound = sounds.eat_fish,
                },
              }
            }
          }
        }
      }
    },
	inventory_move_sound = item_sounds.raw_fish_inventory_move,
    pick_sound = item_sounds.raw_fish_inventory_pickup,
    drop_sound = item_sounds.raw_fish_inventory_move,
	weight = 0.25 * kg,
    stack_size = 200,
	fuel_acceleration_multiplier = 0.1,
    fuel_top_speed_multiplier = 0.1,
	},
  
	{
    type = "capsule",
    name = "chunky-meat",
    icon = "__factorioplus__/graphics/icons/chunky-meat.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "gz[raw-fish]",
	fuel_category = "chemical",
    fuel_value = "1.0MJ",
	fuel_emissions_multiplier = 50,
	capsule_action =
    {
      type = "use-on-self",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = healing_cooldown,
        range = 0,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
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
                  damage = {type = "physical", amount = 40}
                },
                {
                  type = "play-sound",
                  sound = sounds.eat_fish,
                },
              }
            }
          }
        }
      }
    },
	inventory_move_sound = item_sounds.raw_fish_inventory_move,
    pick_sound = item_sounds.raw_fish_inventory_pickup,
    drop_sound = item_sounds.raw_fish_inventory_move,
	weight = 1 * kg,
    stack_size = 100,
	fuel_acceleration_multiplier = 0.2,
    fuel_top_speed_multiplier = 0.2,
	},
  
})

if (mods["space-age"]) then
data.raw.capsule["meaty-chunks"].spoil_ticks = 2 * 60 * 60 * 60
data.raw.capsule["meaty-chunks"].spoil_result = null
data.raw.capsule["chunky-meat"].spoil_ticks = 4 * 60 * 60 * 60
data.raw.capsule["chunky-meat"].spoil_result = null
end

data.raw.capsule["raw-fish"].capsule_action.attack_parameters.cooldown = healing_cooldown
  
data.extend({ 
 {
    type = "capsule",
    name = "cooked-fish",
    icon = "__factorioplus__/graphics/icons/cooked-fish.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "capsule",
    capsule_action =
    {
      type = "use-on-self",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = healing_cooldown,
        range = 0,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
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
                  damage = {type = "physical", amount = -150}
                },
                {
                  type = "play-sound",
                  sound = sounds.eat_fish,
                },
              }
            }
          }
        }
      }
    },
    order = "9b[health]",
	inventory_move_sound = item_sounds.raw_fish_inventory_move,
    pick_sound = item_sounds.raw_fish_inventory_pickup,
    drop_sound = item_sounds.raw_fish_inventory_move,
    stack_size = 50,
  },
}) 

if (mods["space-age"]) then
data.raw.capsule["cooked-fish"].spoil_ticks = 4 * 60 * 60 * 60
data.raw.capsule["cooked-fish"].spoil_result = "spoilage"
end

data.extend({ 
  {
    type = "capsule",
    name = "med-pack",
    icon = "__factorioplus__/graphics/icons/med-pack.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "capsule",
    capsule_action =
    {
      type = "use-on-self",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = healing_cooldown,
        range = 0,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
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
                  damage = {type = "physical", amount = -300}
                },
                {
                  type = "play-sound",
                  sound = sounds.eat_fish,
                },
              }
            }
          }
        }
      }
    },
    order = "9c[health]",
    stack_size = 25
  },
  
  
  {
    type = "module",
    name = "productivity-module-4",
    localised_description = {"item-description.productivity-module"},
    icon = "__factorioplus__/graphics/icons/module-productivity-4.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "module",
    category = "productivity",
    tier = 4,
    order = "c[productivity]-c[productivity-module-4]",
    stack_size = 50,
    effect =
    {
      productivity = 0.15,
      consumption = 1.0,
      pollution = 0.14,
      speed = -0.2
    },
  --  limitation = productivity_module_limitation(),
  --   limitation_message_key = "production-module-usable-only-on-intermediates"
  },
   {
    type = "module",
    name = "speed-module-4",
    localised_description = {"item-description.speed-module"},
    icon = "__factorioplus__/graphics/icons/module-speed-4.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "module",
    category = "speed",
    tier = 4,
    order = "a[speed]-c[speed-module-4]",
    stack_size = 50,
    effect = { speed = 0.8, consumption = 0.8, quality = -0.40},
    beacon_tint =
    {
      primary = {r = 0.441, g = 0.714, b = 1.000, a = 1.000}, -- #70b6ffff
      secondary = {r = 0.388, g = 0.976, b = 1.000, a = 1.000}, -- #63f8ffff
    },
    art_style = "vanilla",
    requires_beacon_alt_mode = false
  },
   {
    type = "module",
    name = "efficiency-module-4",
    localised_description = {"item-description.efficiency-module"},
    icon = "__factorioplus__/graphics/icons/module-efficiency-4.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "module",
    category = "efficiency",
    tier = 4,
    order = "c[efficiency]-c[efficiency-module-4]",
    stack_size = 50,
    effect = { consumption = -0.6},
    beacon_tint =
    {
      primary = { 0, 1, 0 },
      secondary = {r = 0.370, g = 1.000, b = 0.370, a = 1.000}, -- #5eff5eff
    },
    art_style = "vanilla",
    requires_beacon_alt_mode = false
  },
})

data.extend({
    {
    type = "item",
    name = "cpu-item",
    icon = "__factorioplus__/graphics/icons/computing-unit.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-product",
     order = "b[circuits]-d[computing-unit]",
    stack_size = 100,
	 weight = 2*kg
	}
	
})
 
if (mods["space-age"]) then  
data.raw["item"]["cpu-item"].icon = "__factorioplus__/graphics/icons/computing-unit-2.png"
data.raw["item"]["processing-unit"].icon = "__factorioplus__/graphics/icons/proccesing-unit-2.png"
end


data.extend({  
  {
    type = "item-with-entity-data",
    name = "solar-train",
    icon = "__factorioplus__/graphics/icons/solar-train.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "trains",
    order = "a[train-system]-f[locomotive]",
    place_result = "solar-train",
    stack_size = 5
  },
  {
    type = "item",
    name = "cargo-wagon-equipment",
    icon = "__factorioplus__/graphics/icons/equipment-wagon.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "trains",
    order = "a[train-system]-g[equipment-wagon]",
    place_result = "cargo-wagon-equipment",
    stack_size = 5
  },
})  

-- BASIC PIPE ITEMS --	

data.extend({  
  {
  	hidden = true, -- REMOVE ONCE IMPLEMENTED
    type = "item",
    name = "pipe-basic",
    icon = "__base__/graphics/icons/pipe.png",
    subgroup = "pipes",
    order = "a[pipe]-a[pipe]",
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    place_result = "pipe-basic",
    stack_size = 100,
    weight = 5 * kg,
    random_tint_color = item_tints.iron_rust
  },
  
  {
	hidden = true, -- REMOVE ONCE IMPLEMENTED
    type = "item",
    name = "pipe-to-ground-basic",
    icon = "__base__/graphics/icons/pipe-to-ground.png",
    subgroup = "pipes",
    order = "a[pipe]-b[pipe-to-ground]",
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    place_result = "pipe-to-ground-basic",
    stack_size = 50,
    random_tint_color = item_tints.iron_rust
  },
})

-- REINFORCED PIPE ITEMS --	

data.extend({  
  {
	hidden = true, -- REMOVE ONCE IMPLEMENTED
    type = "item",
    name = "pipe-reinforced",
    icon = "__base__/graphics/icons/pipe.png",
    subgroup = "pipes",
    order = "a[pipe]-a[pipe]",
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    place_result = "pipe-reinforced",
    stack_size = 100,
    weight = 5 * kg,
    random_tint_color = item_tints.iron_rust
  },
  
  {
	hidden = true, -- REMOVE ONCE IMPLEMENTED
    type = "item",
    name = "pipe-to-ground-reinforced",
    icon = "__base__/graphics/icons/pipe-to-ground.png",
    subgroup = "pipes",
    order = "a[pipe]-b[pipe-to-ground]",
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    place_result = "pipe-to-ground-reinforced",
    stack_size = 50,
    random_tint_color = item_tints.iron_rust
  },
})

  ----------------------------------------------------- OVERRIDES -----------------------------------------------------
 
data.extend({   
  {
    type = "item",
    name = "gun-turret",
    icon = "__factorioplus__/graphics/icons/gun-turret.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "turret",
    order = "b[turret]-a[gun-turret]",
    place_result = "gun-turret",
    stack_size = 50
  },
})

  ----------------------------------------------------- MODULE OVERRIDE -----------------------------------------------------

local modules = {"productivity-module", "productivity-module-2", "productivity-module-3" }
local recipesToAdd = {"bio-science-pack","glass-plate","silicon-wafer","aluminium-plate","true-rocket-fuel","charcoal","solid-fuel-from-nat-gas","resin-extraction","bio-fuel","basic-natural-gas-processing","turret-base","laser","cpu-item"}

for k, v in pairs(data.raw.module) do
  if v.name:find("productivity%-module") and v.limitation then
    for _, recipe in ipairs(recipesToAdd) do
      table.insert(v.limitation, recipe)
    end
  end
end

