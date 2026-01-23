-- Any particular planet specific updates for Space Age goes in here.

function length_setting(settingname, values)
	local v 
	if settings.startup[settingname].value == "short" then
		v = values[1]
	elseif settings.startup[settingname].value == "normal" then
		v = values[2]
	elseif settings.startup[settingname].value == "long" then
		v = values[3]
	end
	return v
end

function difficult_setting(settingname, values)
	local v 
	if settings.startup[settingname].value == "easy" then
		v = values[1]
	elseif settings.startup[settingname].value == "normal" then
		v = values[2]
	elseif settings.startup[settingname].value == "hard" then
		v = values[3]
	elseif settings.startup[settingname].value == "extreme" then
		v = values[4]
	elseif settings.startup[settingname].value == "insane" then
		v = values[5]
	end
	return v
end

function daynightcycle_setting(settingname)
	local v 
	if settings.startup[settingname].value == "short" then
		v = 0.5
	elseif settings.startup[settingname].value == "normal" then
		v = 1
	elseif settings.startup[settingname].value == "long" then
		v = 2
	end
	return v
end

-- Make it so the player has a little more priority to getting struck by lightning...
table.insert(data.raw["planet"]["fulgora"].lightning_properties.priority_rules,
	{
	  type = "prototype",
	  string = "character",
	  priority_bonus = 80
	}
)

data.raw["planet"]["fulgora"].lightning_properties.lightnings_per_chunk_per_tick = data.raw["planet"]["fulgora"].lightning_properties.lightnings_per_chunk_per_tick * length_setting("settings-spaceage-fulgora-lightning-hitfrequency", {2, 1, 0.5})
data.raw["lightning"]["lightning"].energy = 1000 * difficult_setting("settings-spaceage-fulgora-lightning-power", {2, 1, 0.75, 0.5, 0.25}) .. "MJ"
data.raw["lightning"]["lightning"].damage = data.raw["lightning"]["lightning"].damage * difficult_setting("settings-spaceage-fulgora-lightning-damage", {0.75, 1, 2, 3, 4})

data.raw["planet"]["vulcanus"].surface_properties["day-night-cycle"] = data.raw["planet"]["vulcanus"].surface_properties["day-night-cycle"] * daynightcycle_setting("settings-spaceage-vulcanus-daynightcycle")
data.raw["planet"]["gleba"].surface_properties["day-night-cycle"] = data.raw["planet"]["gleba"].surface_properties["day-night-cycle"] * daynightcycle_setting("settings-spaceage-gleba-daynightcycle")
data.raw["planet"]["fulgora"].surface_properties["day-night-cycle"] = data.raw["planet"]["fulgora"].surface_properties["day-night-cycle"] * daynightcycle_setting("settings-spaceage-fulgora-daynightcycle")
data.raw["planet"]["aquilo"].surface_properties["day-night-cycle"] = data.raw["planet"]["aquilo"].surface_properties["day-night-cycle"] * daynightcycle_setting("settings-spaceage-aquilo-daynightcycle")







