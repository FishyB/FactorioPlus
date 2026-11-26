--control.lua

require ("util")
require ("veteran-turrets")
require ("stats")

script.on_init(function() InitMod() end)
script.on_load(function() OnLocalLoad()  end)

local csaAmount = 1
if settings.startup["settings-crashsite-bonus-buildingstats"].value == "more" then
	csaAmount = 2
elseif settings.startup["settings-crashsite-bonus-buildingstats"].value == "extra" then
	csaAmount = 3
end

local siAmountPct = ( settings.startup["settings-tech-progressive-increment-amount"].value / 100 )

-- Storage
local turretPairs = {}

-- Events
if settings.startup["settings-turrets-vet-active"].value then
	script.on_event(defines.events.on_entity_died, function(event)  DidTurretDie(event.entity)  if event.cause ~= nil then DidTurretKill(event.cause) end end)
end
script.on_event(defines.events.on_player_mined_entity, function(event) OnRemoved(event.entity) end,  {{filter="turret"}} )
script.on_event(defines.events.on_robot_mined_entity, function(event) RemoveTurretListEntry(event.entity) end, {{filter="turret"}} )
script.on_event(defines.events.on_post_entity_died, function(eventinfo)  ReplaceTurretGhost(eventinfo)  end )
script.on_event(defines.events.on_built_entity, function(event)  ChangePastedTurret(event)  end,  {{filter="ghost", force="player"}} )
script.on_event(defines.events.on_player_created, function(event) OnPlayerCreated(event) end)
script.on_event(defines.events.on_space_platform_mined_entity, function(event) OnRemoved(event.entity) end,  {{filter="turret"}} )
script.on_event(defines.events.on_entity_spawned, function(event) EnemyBiterBuff(event.entity) end)
script.on_event(defines.events.on_research_finished, function(event) IncreaseScienceDifficulty(event.research) end)
script.on_event(defines.events.on_research_reversed, function(event) ReduceScienceDifficulty(event.research) end)

-- Randomly give enemies a small speed buff.
function EnemyBiterBuff(entity)
	if ( entity.has_flag("breaths-air") and entity.speed ~=nil ) then
		if (math.random()>0.9) then
			entity.speed = entity.speed * 1.35
		end
	end
end



function TestSciencePrice()
	if (storage.scienceIncAmount == nil) then
		storage.scienceBaseMulti = game.difficulty_settings.technology_price_multiplier
		storage.scienceIncAmount = (storage.scienceBaseMulti * siAmountPct)
	end
end

function ReduceScienceDifficulty(research)
	TestSciencePrice()
	if (research.prototype.research_unit_ingredients ~= nil) then
		game.difficulty_settings.technology_price_multiplier = game.difficulty_settings.technology_price_multiplier - storage.scienceIncAmount 
	end
end

function IncreaseScienceDifficulty(research)
	TestSciencePrice()
	if (research.prototype.research_unit_ingredients ~= nil) then
		game.difficulty_settings.technology_price_multiplier = game.difficulty_settings.technology_price_multiplier + storage.scienceIncAmount 
	end
end

-- Initmod is called once when mod is loaded for first time on a save file (or a game is started with this mod active)
function InitMod() 
	storage.generator = game.create_random_generator()
	
	TestSciencePrice()

	if game.forces["abandonments"] ~= nil then 
		game.forces["abandonments"].ai_controllable = false
		game.forces["abandonments"].custom_color = abandonments_force_color_tint
		else
		CreateForce("abandonments")
	end
	
	OnLocalLoad()
end

function CreateForce(force)
	f = game.create_force(force)
	f.custom_color = abandonments_force_color_tint
	f.ai_controllable = false
end

-- function OnForceCreated(event) 
-- event.force.ai_controllable = false
-- event.force.custom_color = {0.6,0.6,0.6,1}
-- end

function GetTargets(entity)
	local targets = {}
	local index = 0
	while true do
	  index = index + 1
	  local success, target = pcall(entity.get_priority_target, index)
	  if not success then break end
	  table.insert(targets, target)
	end
	return targets
end

function SetTargets(targets, entity)
	 for i, v in pairs (targets) do
		entity.set_priority_target(i,v)
	 end
end

-- If a veteran turret is copy and pasted. It is reverted to the base turret level.
-- on_built_entity
function ChangePastedTurret(event) 
--game.print("ChangePastedTurret")
--game.print( "Entity:" .. serpent.block(event.entity.ghost_prototype))

	if (IsTurret(event.entity.ghost_prototype)) then
		local targets = GetTargets(event.entity)
		local ignoretargets = event.entity.ignore_unprioritised_targets
		local playerindex = event.player_index 
		local wireconnections = GetWireConnections(event.entity)
		local conditions = GetConditions(event.entity)
		local turretpasted = event.entity.surface.create_entity
		{							
		  name = "entity-ghost",
		  inner_name = event.entity.ghost_prototype.mineable_properties.products[1].name,
		  quality = event.entity.quality,
		  position = event.entity.position,
		  direction = event.entity.direction,
		  expires = false,
		  force = "player",
		  player = playerindex
		}
		event.entity.destroy()
		
		SetTargets(targets,turretpasted)
		turretpasted.ignore_unprioritised_targets = ignoretargets
		RecreateWireConnections(turretpasted,wireconnections)
		RecreateConditions(turretpasted,conditions)
	end
end

-- If a veteran turret dies. It is reverted to the base turret level.
-- on_post_entity_died
function ReplaceTurretGhost(eventinfo) 
if (IsTurret(eventinfo.prototype)) then
	if eventinfo.ghost ~= nil then -- Check to see if ghosts are being created first!
		local targets = GetTargets(eventinfo.ghost)
		local ignoretargets = eventinfo.ghost.ignore_unprioritised_targets
		local wireconnections = GetWireConnections(eventinfo.ghost)
		local conditions = GetConditions(eventinfo.ghost)
		local turretghost = eventinfo.ghost.surface.create_entity
		{							
		  name = "entity-ghost",
		  inner_name = eventinfo.prototype.mineable_properties.products[1].name,
		  quality = eventinfo.quality,
		  position = eventinfo.position,
		  direction = eventinfo.ghost.direction,
		  expires = true,
		  force = "player"
		}
		eventinfo.ghost.destroy()
		
		SetTargets(targets,turretghost)
		turretghost.ignore_unprioritised_targets = ignoretargets
		RecreateWireConnections(turretghost,wireconnections)
		RecreateConditions(turretghost,conditions)
	end
end

end

function IsTurret(entity)
	if entity ~= nil then
	-- game.print("isEntity!")
	    for turretgroup, v in pairs (turretVetGroupings) do
			-- game.print("isTurret!")
			if string.find(entity.name, turretgroup, 1, true  ) ~= nil then 
				return true
			end
		end	    
	end
	return false
end

function table.merge(t1, t2)
	for _,v in ipairs(t2) do
	   table.insert(t1, v)
   end
end

local shipStartLab = "crash-site-lab-repaired"
local shipStartGenerator = "crash-site-generator"
local shipAssemblers = {"crash-site-assembling-machine-1-repaired","crash-site-assembling-machine-2-repaired" }
local shipElectricPole = "crash-site-electric-pole"
local shipStartPieces = {}

function FinalShipPieces(count) 
	table.insert(shipStartPieces, shipStartLab)
	table.insert(shipStartPieces, shipStartGenerator)
	for i = (count -1), 0, -1 do
		table.merge(shipStartPieces,shipAssemblers)
	end
end

function PlaceShipParts() 
	ship = FindStartShip()
	thisPosition = {math.random(-4,4),math.random(-4,4)}
	if ship then
		FinalShipPieces(csaAmount)
		for k, name in pairs (shipStartPieces) do
			thisPosition = game.surfaces[1].find_non_colliding_position( name, thisPosition, 7, 3, true )
			game.surfaces[1].create_entity{ position = thisPosition, name = name, force = "player" } 
			if (k ~= #shipStartPieces) then
				thisPosition = game.surfaces[1].find_non_colliding_position( name, thisPosition, 5, 2, true )
				game.surfaces[1].create_entity{ position = thisPosition, name = shipElectricPole, force = "player" } 
			end
		end
	end
end

function FindStartShip() 
local ship = game.surfaces[1].find_entities_filtered{name="crash-site-spaceship"}
	if ship then
	return ship
	else 
	return nil
	end
end

local robotitems =
{
	{name="modular-harness", count=1},
	{name="harness-generator-equipment", count=1},
	{name="harness-battery-equipment", count=1},
	{name="harness-roboport-equipment", count=1},	
	{name="construction-robot", count=20},
}

function PlaceShipContainer(items, position) 

	local csc = "crash-site-chest-1" 
	if math.random() > 0.5 then
		csc = "crash-site-chest-2" 
	end
	thisPosition = position 
	_pos = game.surfaces[1].find_non_colliding_position( csc , thisPosition, 15, 2, true )
	_obj = game.surfaces[1].create_entity{ position = _pos, name = csc , force = "player" } 
			
	if items then
		InsertItemsStack(items, _obj)
	end
end

local extra_loot_ship = nil
local extra_loot_large_wreck = nil
local extra_loot_medium_wreck = nil
if settings.startup["settings-crashsite-bonus-equipment"].value == "more" then
	extra_loot_ship = {
		{name="med-pack", count=5},
		{name="repair-pack", count=20},
		{name="submachine-gun", count=1},
		{name="light-armor", count=1},
		{name="firearm-magazine", count=40},
	}
elseif settings.startup["settings-crashsite-bonus-equipment"].value == "extra" then
extra_loot_ship = {
		{name="med-pack", count=20},
		{name="repair-pack", count=80},
		{name="submachine-gun", count=1},
		{name="firearm-magazine", count=40},
		{name="piercing-rounds-magazine", count=20},
		{name="heavy-armor", count=1},
		{name="defender-capsule", count=5},
		
	}
end

if settings.startup["settings-crashsite-bonus-scrap"].value == "more" then
	extra_loot_large_wreck = {
		{name="iron-plate", count=30},
		{name="iron-gear-wheel", count=15},
	}
	extra_loot_medium_wreck = {
		{name="iron-plate", count=10},
	}
elseif settings.startup["settings-crashsite-bonus-scrap"].value == "extra" then
	extra_loot_large_wreck = {
		{name="iron-plate", count=100},
		{name="copper-plate", count=40},
		{name="steel-plate", count=20},
	}
	extra_loot_medium_wreck = {
		{name="iron-plate", count=25},
		{name="iron-gear-wheel", count=30},
	}
end


function InsertGoodies(objects, items) 
--local ship = game.surfaces[1].find_entities_filtered{name="crash-site-spaceship"}
	if objects and items then
		for i,v in ipairs(objects) do
			InsertItemsStack(items, v)
		end
	end
--local ship = game.surfaces[1].find_entities_filtered{name="crash-site-spaceship-wreck-big-1"}	
end

function InsertItemsStack(items, object) 
	for i,v in ipairs(items) do
		object.insert(v)
	end
end

-- Scripted scenarios (e.g. the base game tutorial) call force.disable_all_prototypes() and then
-- enable a hardcoded list of vanilla recipes, bypassing research. Our "transport-belt" recipe needs
-- "basic-transport-belt" as an ingredient, which such scripts don't know about, so the vanilla belt
-- ends up craftable while its ingredient is not. In normal play the basic belt recipe is enabled from
-- the start, so "transport-belt enabled but basic belt disabled" only happens in that situation.
function EnsureBasicBeltUnlocked()
	for _, force in pairs(game.forces) do
		local recipes = force.recipes
		local basic = recipes["basic-transport-belt"]
		local vanilla = recipes["transport-belt"]
		if basic and vanilla and vanilla.enabled and not basic.enabled then
			basic.enabled = true
		end
	end
end

-- The scenario's own on_player_created handler may run after ours, so also re-check shortly afterwards.
script.on_nth_tick(10, function()
	if storage.beltUnlockCheckPending then
		storage.beltUnlockCheckPending = nil
		EnsureBasicBeltUnlocked()
	end
end)

function OnPlayerCreated()
	EnsureBasicBeltUnlocked()
	storage.beltUnlockCheckPending = true

	if ( remote.interfaces["freeplay"] and  settings.startup["settings-crashsite"].value == true and storage.crashsiteplaced == nil) then
		PlaceShipParts() 
		if settings.startup["settings-crashsite-bonus-scrap"].value ~= "normal" then
			InsertGoodies(game.surfaces[1].find_entities_filtered{name="crash-site-spaceship-wreck-big-1"},extra_loot_large_wreck)
			InsertGoodies(game.surfaces[1].find_entities_filtered{name="crash-site-spaceship-wreck-big-2"},extra_loot_large_wreck)
			InsertGoodies(game.surfaces[1].find_entities_filtered{name="crash-site-spaceship-wreck-medium-1"},extra_loot_medium_wreck)
			InsertGoodies(game.surfaces[1].find_entities_filtered{name="crash-site-spaceship-wreck-medium-2"},extra_loot_medium_wreck)
			InsertGoodies(game.surfaces[1].find_entities_filtered{name="crash-site-spaceship-wreck-medium-3"},extra_loot_medium_wreck)
		end
		if settings.startup["settings-crashsite-bonus-equipment"].value ~= "normal" then
			i = settings.startup["settings-crashsite-x-players"].value
			while ( i > 0 ) do
				PlaceShipContainer(extra_loot_ship, {math.random(-12,6),math.random(-16, -10)} ) 
				i = i - 1
			end
			--InsertGoodies(game.surfaces[1].find_entities_filtered{name="crash-site-spaceship"},extra_loot_ship)
		end
		if settings.startup["settings-crashsite-robots"].value then
			i = settings.startup["settings-crashsite-x-players"].value
			while ( i > 0 ) do
				PlaceShipContainer(robotitems, {math.random(-12,6),math.random(6, 10)} ) 
				i = i - 1
			end
		end
		storage.crashsiteplaced = true
	end	
end

function OnLocalLoad()
	if storage.turrets == nil then
	-- maybe init turrets pairs is a method for all places to call? 
	else
	turretPairs = storage.turrets
	end
end


function DidTurretDie(entity)
	if entity ~= nil then
	    for turretgroup, v in pairs (turretVetGroupings) do
			if string.find(entity.name, turretgroup, 1, true  ) ~= nil then 
				entity.kills = 0
				entity.damage_dealt = 0
				local num = entity.unit_number
				if storage.turrets ~= nil then
				
					if storage.turrets[num] ~= nil then
						storage.turrets[num][2].destroy()
						table.remove(storage.turrets,num)	
					end	
				end
		
			end
		end	    
	end
end


function OnRemoved(entity)
	if entity ~= nil then
		RemoveOldTurret(entity)
	end
end

function RemoveIcon(turretEntity)
	for _, entity in pairs(glob.entities) do
		local newEntity = ReplaceSingleEntity(entity, newName)
		if newEntity then
			table.insert(newEntities, newEntity)
		end
	end
end

local function escapeHyphens(str) 
  return str:gsub("%-", "%%-") 
end


local delegate = 
{
  greet = function(self, name)
   return "Hello, " .. name .. "!"
  end
}


local VetFunction = nil

local function CheckKills(entity, i)
	return (entity.kills >= turretKillLevels[i])
end

local function CheckDamage(entity, i)
	return (entity.damage_dealt  >= turretDamageLevels[i])
end

local function CheckBoth(entity, i)
	return (CheckKills(entity, i) and CheckDamage(entity, i))
end

local function CheckEither(entity, i)
	return (CheckKills(entity, i) or CheckDamage(entity, i))
end


if (settings.startup["settings-turrets-vet-kill-damage-check-type"].value == "kill" ) then
	VetFunction = CheckKills
elseif (settings.startup["settings-turrets-vet-kill-damage-check-type"].value == "damage" ) then
	VetFunction = CheckDamage
elseif (settings.startup["settings-turrets-vet-kill-damage-check-type"].value == "either" ) then
	VetFunction = CheckEither
else 
	-- value == "both"
	VetFunction	= CheckBoth
end

	
function DidTurretKill(entity)

    for turretgroup, v in pairs (turretVetGroupings) do

		if string.find(entity.name, turretgroup, 1, true  ) ~= nil then 

			for index, turretvet in pairs (v) do

			-- if this is the original turret (not upgraded)
				if (string.find(turretgroup, entity.name, 1, true )) ~= nil and VetFunction(entity,1) then

					UpgradeTurret(entity, v[1] ,turretVetIcons[1])
					return
 
				end
			-- if it's already upgraded then
				if v[index+1] ~= nil and string.find(v[index], entity.name, 1, true  ) ~= nil and turretKillLevels[index+1] ~= nil and VetFunction(entity,index+1) then
					UpgradeTurret(entity, v[index+1] ,turretVetIcons[index+1])
					return
				end
			end
		end
	end

end

function GetConditions(entity, conditions)
	local control_behavior = entity.get_control_behavior()
    local controlBehaviorData = nil
	if control_behavior ~=  nil then	
			controlBehaviorData = 
			{			
				circuit_enable_disable = control_behavior.circuit_enable_disable,
				circuit_condition = control_behavior.circuit_condition,
				connect_to_logistic_network = control_behavior.connect_to_logistic_network,
				logistic_condition = control_behavior.logistic_condition,

				set_priority_list = control_behavior.set_priority_list,
				set_ignore_unlisted_targets = control_behavior.set_ignore_unlisted_targets,
				ignore_unlisted_targets_condition = control_behavior.ignore_unlisted_targets_condition,
				read_ammo = control_behavior.read_ammo
			}
	end
	return controlBehaviorData
end

function RecreateConditions(entity, conditions)
	if (conditions ~= nil) then
		local new_conditions = entity.get_or_create_control_behavior()

		new_conditions.circuit_enable_disable = conditions.circuit_enable_disable
		new_conditions.circuit_condition = conditions.circuit_condition
		new_conditions.connect_to_logistic_network = conditions.connect_to_logistic_network
		new_conditions.logistic_condition = conditions.logistic_condition

		new_conditions.set_priority_list = conditions.set_priority_list
		new_conditions.set_ignore_unlisted_targets = conditions.set_ignore_unlisted_targets
		new_conditions.ignore_unlisted_targets_condition = conditions.ignore_unlisted_targets_condition
	end

end

function GetWireConnections(entity)
	if not entity.valid then return {} end

	local current_wire_connections = entity.get_wire_connectors()
	local source_connections = {}

	for k,v in pairs(current_wire_connections) do
		if not v.valid then break end
		
		if v.connection_count > 0 and v.connections ~= nil then
			if v.wire_connector_id == defines.wire_connector_id.circuit_red then 
				source_connections.red = {}
				for _, connection in ipairs(v.connections) do
					table.insert(source_connections.red,connection)
				end
			elseif v.wire_connector_id == defines.wire_connector_id.circuit_green then
				source_connections.green = {}
				for _, connection in ipairs(v.connections) do
					table.insert(source_connections.green,connection)
				end
			end

		end
	  end
	return source_connections
end

function RecreateWireConnections(entity,source_connections)
	if (source_connections ~= nil) then
		if next(source_connections) ~= nil  then
			local dest_connections = entity.get_wire_connectors(true) 
			for k,v in pairs(dest_connections) do
				if not v.valid then break end

				if v.wire_connector_id == defines.wire_connector_id.circuit_red then 
					if source_connections.red ~= nil then
						for _, connection in ipairs(source_connections.red) do
							if connection ~= nil then
								v.connect_to(connection.target)
							end
						end
					end
				elseif v.wire_connector_id == defines.wire_connector_id.circuit_green then
					if source_connections.green ~= nil then
						for _, connection in ipairs(source_connections.green) do
							if connection ~= nil then
								v.connect_to(connection.target)
							end
						end
					end
				end
			end
		end
	end
end
	
function UpgradeTurret(turret, newName, icon)
	
	-- Don't replace a dead or removed turret.	
	if not turret.valid then
		return false
	end

	-- init storage turrets tracking table
	if storage.turrets == nil then
		storage.turrets = {}
		-- created new storage turrets if none exists
	end
	
	-- Get relevant stats of the turret.
	local ammo = GetAmmo(turret)
	local healthPercent = turret.health / prototypes.entity[turret.name].get_max_health()
	local kills = turret.kills
	local damage_dealt = turret.damage_dealt 
	local turretSurface = turret.surface
	local turretPosition = turret.position
	local turretForce = turret.force
	local turretDirection = turret.direction
	local turretQuality = turret.quality
	local targets = GetTargets(turret)
	local ignoretargets = turret.ignore_unprioritised_targets
	local wireconnections = GetWireConnections(turret)
	local conditions = GetConditions(turret)
	
	RemoveOldTurret(turret) -- This fixed the issue of flame turrets not working correctly by removing the old turret before making the new one.
	
	-- Create a new turret and copy in the stats of the old one.
	local newTurret = turretSurface.create_entity{position=turretPosition, quality =turretQuality, name=newName, force = turretForce, direction=turretDirection, target=turretPosition, fast_replace=true}
	newTurret.kills = kills
	newTurret.damage_dealt = damage_dealt	
	SetTargets(targets,newTurret)
	newTurret.ignore_unprioritised_targets = ignoretargets
	
	-- Apply circuit conditions and wires if there is.
	
	RecreateWireConnections(newTurret, wireconnections)
	RecreateConditions(newTurret, conditions)

	-- Create the veterancy icon at the Bottom Right of the turrets bounding box
	local newIcon = newTurret.surface.create_entity{position = BoundingBoxBottomRightPosition(newTurret), name = icon}
	
	-- Set relevant stats on the new turret.
	newTurret.health = healthPercent * prototypes.entity[newTurret.name].get_max_health()
	if ammo then
		--newTurret.insert(ammo)
		InsertAmmo(newTurret, ammo)
	end
	
	-- Create flying text to mark veterancy
	
	for i,v in pairs(game.players) do
    v.create_local_flying_text{text={"factorioplus-text.veterancy-bonus"},position = newTurret.position, create_at_cursor = false, color = { 1, 0.85 ,0, 1} }
	end
	
	-- newTurret.surface.create_entity{position = newTurret.position, name = "flying-text-veterancy", text = "+debugtext", color = { 1, 0.85 ,0, 1}  }
	-- flyText.text = {"factorioplus-text.veterancy-bonus"}
	
	--local flyText = newTurret.surface.create_entity{position = newTurret.position, name = "flying-text-veterancy", text = "+debugtext", color = { 1, 0.85 ,0, 1}  }
	--flyText.text = {"factorioplus-text.veterancy-bonus"}
	
	-- Create a k,v pair of the turret entity and its associated icon entity
	local num = newTurret.unit_number
	local turretPair = {newTurret, newIcon}
	
	-- add the pair of turrets and their icons to the turret tracking table
	if storage.turrets[num] == nil then
		table.insert (storage.turrets, num, turretPair)
		-- inserted new turret into the storage tracking list
	end
	
	-- RemoveOldTurret(turret)

end

-- If a veteran turret is mined, it needs to be removed from the list,
function RemoveTurretListEntry(turretEntity)
local num = turretEntity.unit_number
	if storage.turrets ~= nil then
		if storage.turrets[num] ~= nil then
			-- destroy the turrets vet icon
			storage.turrets[num][2].destroy()
			-- and remove it from the tracking table
			table.remove(storage.turrets,num)
			return
		end
	end	
end

function RemoveOldTurret(turretEntity)
local num = turretEntity.unit_number
	if storage.turrets ~= nil then
		if storage.turrets[num] ~= nil then
			-- destroy old veteran turret[1] and icon[2]
			storage.turrets[num][1].destroy()
			storage.turrets[num][2].destroy()
			-- remove from storage table tracking
			table.remove(storage.turrets,num)
			return
		end
		-- destroy old turret if it's basic ass.
		turretEntity.destroy()	
	end
		
end
 
function BoundingBoxBottomRightPosition(entity)
  return entity.bounding_box.right_bottom
end


function GetAmmo(turret)
	--local inv = turret.get_inventory(1)
	local inv = turret.get_inventory(1)
	
	if inv == nil then
	return false
	else 
	return inv.get_contents()
	end
	
	-- for name, count in pairs(inv.get_contents()) do
		-- return {name=name, count=count}
	-- end
	return false
end

function InsertAmmo(turret, ammo)
--game.print( "Insert Ammo")
--game.print( "ammo:" .. serpent.block(ammo))

for i,v in pairs(ammo) do
	--game.print( "ammo:" .. i .. serpent.block(v))

	turret.insert({name=v.name, count=v.count, quality=v.quality})
 end

end