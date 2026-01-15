--data.lua

-- put any helper functions first that you always want available for any lua files below.
require("util-generic")

-- Main data group of STUFF AND THINGS
require("signal")
require("item-groups")
require("buildings")
require("item")
require("recipes")
require("technology")
require("resources")
require("tiles")
require("weapons")
require("ammo")
require("enemies")
require("vehicles")
require("turrets")
require("drills")
require("categories")
require("player")
require("movement_triggers")
require("equipment")
require("robots")
require("walls")
require("crashsite")
require("stats")
require("veteran-turrets")
require("rocks")
require("explosions")
require("map-gen-presets")
require("abandonments")
require("abandonments-noise-expressions")
require("collision-masks")
require("tips-and-tricks") -- probably not needed

-- If you can isolate space age things, then put them here.
if (mods["space-age"]) then
require("recipes-sa")
require("item-sa")
require("technology-sa")
require("entities-sa")
require("buildings-sa")
require("planets-sa")
end

-- Anything to blanket update the data in this mod specifically.
require("blanket-data-updates")