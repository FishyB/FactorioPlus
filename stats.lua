-- GENERAL STATS

friendly_fire_modifier = settings.startup["settings-combat-friendlyfire-percent"].value / 100 -- This modifies the player splash damage by this amount of weapons that have been affected (arbitary)
friendly_fire_radius_reduction_factor = 2 -- divide the radius that affects allies by this amount (flat value across board)

-- Abandonments force

abandonments_force_color_tint = {0.25,0.25,0.25,1}
abandonments_force_color_map = {0.9,0.25,0.25,1}
abandonments_bonus_color_map = {0.9,0.7,0.1,1}
abandonments_barren_color_map = {0.1,0.1,0.1,1}

-- Vehicles

-- Vehicles aren't turrets than can be spammed, so give them a little more benifits compared to them.
damage_modifier_vehicle_bonus = 1.4
range_modifier_vehicle_bonus = 1.4
attack_speed_vehicle_bonus = 1.4

atv_health = 150
atv_ephp = 2 
atv_resistances = 
{
  {
	type = "impact",
	percent = 20,
	decrease = 4
  },
  {
	type = "acid",
	percent = -25
  },
}
atv_effectivity = 0.6
atv_braking = "100kW"
atv_consumption = "60kW"
atv_friction = 0.004
atv_turnrate = 0.022
atv_weight = 225
atv_inventory_size = 0


car_health = 400
car_ephp = 1 
car_resistances = 
{
  {
	type = "fire",
	percent = 40
  },
  {
	type = "impact",
	percent = 30,
	decrease = 50
  },
  {
	type = "acid",
	percent = -25
  },
}
car_effectivity = 0.8
car_braking = "250kW"
car_consumption = "180kW"
car_friction = 0.004
car_turnrate =0.015
car_weight = 500
car_inventory_size = 5


truck_health = 900
truck_ephp = 1 
truck_resistances = 
{
  {
	type = "fire",
	percent = 10
  },
  {
	type = "impact",
	percent = 30,
	decrease = 50
  },
  {
	type = "acid",
	percent = -25
  },
}
truck_effectivity = 0.7
truck_braking = "920kW"
truck_consumption = "250kW"
truck_friction = 0.003
truck_turnrate = 0.01
truck_weight = 1200
truck_inventory_size = 100


apc_health = 1600
apc_ephp = 0.7 
apc_resistances = 
{
  {
	type = "fire",
	percent = 50
  },
  {
	type = "impact",
	percent = 50,
	decrease = 50
  },
  {
	type = "physical",
	decrease = 10,
	percent = 30
  },
  {
	type = "explosion",
	percent = 30,
	decrease = 25
  },
  {
	type = "acid",
	percent = -25
  },
}
apc_effectivity = 0.7
apc_braking = "1520kW"
apc_consumption = "475kW"
apc_friction = 0.003
apc_turnrate = 0.01
apc_weight = 2700
apc_inventory_size = 20
apc_friction_terrain_modifier =  0.4

-- FLAME TANK --

flametank_health = 2000
flametank_ephp = 0.4 
flametank_resistances = 
 {
  {
	type = "fire",
	decrease = 15,
	percent = 100
  },
  {
	type = "physical",
	decrease = 15,
	percent = 40
  },
  {
	type = "impact",
	decrease = 50,
	percent = 60
  },
  {
	type = "explosion",
	decrease = 15,
	percent = 50
  },
  {
	type = "acid",
	percent = -25
  }
}
flametank_effectivity = 0.8
flametank_braking = "1400kW"
flametank_consumption = "600kW"
flametank_friction_terrain_modifier =  0.3
flametank_friction = 0.002
flametank_turnrate = 0.0035
flametank_weight = 12000
flametank_inventory_size = 5

-- TANK --

tank_health = 3000
tank_ephp = 0.4 
tank_resistances = 
{
  {
	type = "fire",
	decrease = 15,
	percent = 60
  },
  {
	type = "physical",
	decrease = 15,
	percent = 60
  },
  {
	type = "impact",
	decrease = 50,
	percent = 80
  },
  {
	type = "explosion",
	decrease = 25,
	percent = 70
  },
  {
	type = "acid",
	decrease = 4,
	percent = -25
  }
}
tank_effectivity = 0.7
tank_braking = "2650kW"
tank_consumption = "1600kW"
tank_friction_terrain_modifier =  0.2
tank_friction = 0.002
tank_turnrate = 0.0030
tank_weight = 22000
tank_inventory_size = 5

-- SPEEDER --

speeder_health = 400
speeder_ephp = 1
speeder_resistances = 
{
  {
	type = "fire",
	percent = 10
  },
  {
	type = "impact",
	percent = 30,
	decrease = 40
  },
  {
	type = "acid",
	percent = -25
  },
}
speeder_effectivity = 0.8
speeder_braking = "350kW"
speeder_consumption = "200kW"
speeder_friction = 0.0025
speeder_turnrate = 0.0135
speeder_weight = 400
speeder_inventory_size = 0

-- Small Arms

firerate_pistol = 60 / 3
range_pistol = 25
ammo_consumption_modifier_pistol = 2.0
damage_modifier_pistol = 2.0
movement_slow_down_factor_pistol =  0.1

firerate_magnum = 60 / 0.6
range_magnum = 20
damage_modifier_magnum = 10.0
ammo_consumption_modifier_magnum = 5.0
movement_slow_down_factor_magnum = 0.3

firerate_smg = 60 / 9
movement_slow_down_factor_smg = 0.4
range_smg = 22

firerate_uzi = firerate_smg / 1.75
ammo_consumption_modifier_uzi = 0.5
damage_modifier_uzi = 0.8
movement_slow_down_factor_uzi = 0.2
range_uzi = math.floor(range_smg / 1.5)

bullet_magazinesize = 30
bullet_stacksize = 50
bullet_reloadtime = 1 * 60

bullet_regular_physical = 8

bullet_piercing_physical = 5
bullet_piercing_piercing = 5

bullet_longrange_magazine_size = 20
bullet_longrange_physical = 4
bullet_longrange_piercing = 2
bullet_longrange_range_modifier = 1.5
bullet_longrange_cooldown_modifier = 2.0

bullet_explosive_magazinesize = 15
bullet_explosive_physical = 4
bullet_explosive_explosive = 12
bullet_explosive_radius = 3
bullet_explosive_stacksize = 25
bullet_explosive_cooldown_modifier = 1.5

bullet_uranium_magazinesize = bullet_magazinesize
bullet_uranium_physical = 8
bullet_uranium_piercing = 12
bullet_uranium_stacksize = 50

bullet_nuke_magazinesize = 15
bullet_nuke_physical = 12
bullet_nuke_explosive = 55
bullet_nuke_radius = 4
bullet_nuke_stacksize = 25
bullet_nuke_cooldown_modifier = 2

-- Sniper

firerate_sniper = 60 / 0.25

sniper_damage_modifier = 2.0 -- player sniper weapon modifier
sniper_fired_movement_slow_down_factor = 0.9 -- player sniper weapon modifier
sniper_movement_slow_down_cooldown_factor = 2 -- How long movement is slowed down between each shot -> firerate / X

sniperbullet_range = 200

sniperbullet_piercing_damage = 500 -- more adnvanced ammo is *2 the previous
sniperbullet_regular_piercing = 250 -- more adnvanced ammo is *2 the previous

sniperbullet_magazinesize = 5
sniperbullet_stacksize = 10
sniperbullet_reloadtime = 0 --60 * 3

-- Shotguns

firerate_shotgun = 60 / 0.75
shotgun_damage_modifier = 1.5
movement_slow_down_factor_shotgun = 0.5
range_shotgun = 24

firerate_blunderbuss = 60 / 40
ammo_consumption_rate_blunderbuss = 4
damage_modifier_blunderbuss = 2.5
movement_slow_down_cooldown_blunderbuss = firerate_shotgun/1.5
movement_slow_down_factor_blunderbuss = 0.8

firerate_combatshotgun = 60 / 1.85
range_combatshotgun = 28
movement_slow_down_factor_combatshotgun = 0.8
movement_slow_down_cooldown_combatshotgun = firerate_shotgun/2
damage_modifier_combatshotgun = 1.0
ammo_consumption_rate_combatshotgun = 0.5

shell_arc_wide = 0.6
shell_arc_tight = 0.3

shell_range = 24

shell_regular_physical = 5
shell_regular_pellets = 30
shell_regular_arc = shell_arc_wide

shell_piercing_physical = 4
shell_piercing_piercing = 4
shell_piercing_pellets = 20
shell_piercing_arc = shell_arc_tight

shell_explosive_physical = 6
shell_explosive_explosive = 14
shell_explosive_radius = 3
shell_explosive_pellets = 16
shell_explosive_magazinesize = 6
shell_explosive_stacksize = 25
shell_explosive_cooldown_modifier = 1.5
shell_explosive_arc = shell_arc_wide

shell_depleted_physical = 8
shell_depleted_piercing = 16
shell_depleted_pellets = 12
shell_depleted_arc = shell_arc_tight

shell_nuke_range_modifier = 1.5
shell_nuke_physical = 40
shell_nuke_explosive = 100
shell_nuke_radius = 5
shell_nuke_pellets = 12
shell_nuke_magazinesize = 4
shell_nuke_stacksize = 25
shell_nuke_cooldown_modifier = 2
shell_nuke_arc = shell_arc_wide

shell_magazinesize = 8
shell_stacksize = 50
shell_reloadtime = 2.5 * 60

-- Chainguns
 
firerate_minigun = 60 / 30
range_minigun = 50
damage_modifier_minigun = 1.25
 
beltfed_regular_physical = 16
beltfed_regular_piercing = 4
beltfed_regular_pellets = 3

beltfed_piercing_physical = 8
beltfed_piercing_piercing = 16
beltfed_piercing_pellets = 3

beltfed_magazinesize = 1000
beltfed_stacksize = 10
beltfed_reloadtime = 60 * 6
beltfed_projectile_maxrange = 60

-- Mortar

firerate_grenadelauncher = 60 * 3

mortar_reloadtime = 60 * 1.5
mortar_magazinesize = 6
mortar_stacksize = 25

range_mortar = 6 * 32

mortar_hit_physicaldamage = 160
mortar_regular_explosivedamage = 100

mortar_regular_damageradius = 8.0

mortar_napalm_explosivedamage = 40
mortar_napalm_explosivedamageradius = 4
mortar_napalm_firedps = 30
mortar_napalm_fireground_time = 40

mortar_napalm_bomblet_count = 8
mortar_napalm_bomblet_scatter_radius = 3
mortar_napalm_bomblet_scatter_deviation = 6

mortar_napalm_fireburnsticker_time = 30
mortar_napalm_firestickerapplyradius = 8

-------------
-- GRENADES --
-------------

firerate_grenade = 60 / 0.5
firerate_grenade_large = 60 / 0.3333

firerate_brick = firerate_grenade

range_grenade_min = 3
range_brick = 26
range_grenade = 26
range_flakgrenade = 26
range_clustergrenade = 26
range_mirvgrenade = 26

brick_damage = 60
brick_radius = 1

grenade_damage = 80
grenade_radius = 10.0
grenade_falloff = 1

he_grenade_damage = 350
he_grenade_radius = 16
he_grenade_falloff = 1.5

flak_explosion_damage = 60
flak_explosion_radius = 4
flak_pellet_range = 12
flak_pellet_count = 40 * 1.5
flak_piercing_damage = 35 /1.5

clustergrenade_count = 8

mirvgrenade_count = 6

grenade_stack = 50
grenade_stack_low = 25
mirv_stack = 15


-------------
-- FLAMETHROWER --
-------------

firerate_flamethrower = 60 / 20
range_flamethrower = 26

-------------
-- ROCKETS --
-------------

firerate_rocketlauncher = 60 / 1
firerate_rocketlauncher_spidertron = firerate_rocketlauncher
firerate_rocketlauncher_multi = firerate_rocketlauncher / 3

movement_slow_down_factor_rocketlauncher =  0.75

range_rocketlauncher = 42
range_rocketlauncher_spidertron = range_rocketlauncher + 4 -- Because it's higher up.
range_rocketlauncher_multi = math.ceil(range_rocketlauncher * 0.8)

min_range_rocketlauncher = 6

-- regular
 
rocket_speed_initial = 0.15
rocket_speed_acceleration = 0.006

rocket_damage_physical = 120
rocket_damage_explosive = 120
rocket_radius = 6
rocket_stacksize = 100

-- micro
	
rocket_micro_speed_initial = 0.275
rocket_micro_speed_acceleration = 0.03

rocket_micro_damage_physical = 35
rocket_micro_damage_explosive = 40
rocket_micro_radius = 4
rocket_micro_cooldown_modifier = 0.25
rocket_micro_explosive_cooldown_modifier = 0.25
rocket_micro_stacksize = 300

-- explosive

rocket_explosive_speed_initial = 0.075
rocket_explosive_speed_acceleration = 0.005

rocket_explosive_damage_physical = 100
rocket_explosive_damage_explosive = 400
rocket_explosive_radius = 8.0
rocket_explosive_cooldown_modifier = 2.0
rocket_explosive_stacksize = 50

-- util

rocket_utility_stacksize = 50
rocket_utility_range_modifier =  1.5
rocket_utility_cooldown_modifier = 3

-- nuke

rocket_nuke_damage_explosive = 1000
rocket_nuke_range_modifier = 1.5
rocket_nuke_cooldown_modifier = 10.0
rocket_nuke_stacksize = 10

-------------
-- RAILGUN --
-------------

firerate_railgun = 60 / 0.5

-------------
-- PLASMA BLASTER --
-------------

firerate_plasmagun = 60 * 3
range_plasmagun = 52

spread_plasmagun = 0.8
speed_plasmagun = 0.5
acc_plasmagun = -0.0015

plasmagun_ammo_consumption_modifier = 10
plasmagun_slow_down_factor = 0.75

plasmagun_pushback = 2.0

plasmagun_innercone_projectile_count = 9
plasmagun_outercone_projectile_count = 28
 
plasma_damage_electric = 125
plasma_zap_damage_electric = 45

plasma_stun_duration = 60 * 3
plasma_stun_movement_modifier = 0.2

--- plasma cell

plasmagun_magazinesize = 80
plasmagun_stacksize = 25
plasmagun_reloadtime = 60 * 5

-- Cannons

firerate_cannon = 60 / 0.70

cannon_shell_projectile_speed_modifier = 1.25
cannon_shell_damage_physical = 600
cannon_shell_damage_penetration = 300
cannon_shell_damage_explosive = 300
cannon_shell_radius = 4

cannon_shell_explosive_projectile_speed_modifier = 1
cannon_shell_explosive_damage_physical = 200
cannon_shell_explosive_damage_penetration = 250
cannon_shell_explosive_damage_explosive = 600
cannon_shell_explosive_radius = 10
cannon_shell_explosive_cooldown_modifier = 2.0
cannon_shell_explosive_stacksize = 25

cannon_shell_piercing_projectile_speed_modifier = 1.75
cannon_shell_piercing_damage_physical = 300
cannon_shell_piercing_damage_piercing = 1400
cannon_shell_piercing_damage_penetration = 1000
cannon_shell_piercing_damage_explosive = 100
cannon_shell_piercing_radius = 2

cannon_shell_depleted_projectile_speed_modifier = 2
cannon_shell_depleted_damage_physical = cannon_shell_piercing_damage_physical * 2
cannon_shell_depleted_damage_piercing = cannon_shell_piercing_damage_piercing * 2
cannon_shell_depleted_damage_penetration = cannon_shell_piercing_damage_penetration * 2
cannon_shell_depleted_damage_explosive = cannon_shell_piercing_damage_explosive * 2
cannon_shell_depleted_radius = cannon_shell_piercing_radius + 1

cannon_shell_nuke_projectile_speed_modifier = 1
cannon_shell_nuke_explosive_damage_penetration = cannon_shell_explosive_damage_physical * 2
cannon_shell_nuke_explosive_damage_explosive = cannon_shell_explosive_damage_explosive * 2
cannon_shell_nuke_explosive_damage_explosive_shockwave = 25
cannon_shell_nuke_explosive_radius = 8
cannon_shell_nuke_explosive_cooldown_modifier = 3.0

cannon_shell_auto_projectile_speed_modifier = 1.5
cannon_shell_auto_damage_physical = 200
cannon_shell_auto_damage_penetration = 50
cannon_shell_auto_damage_explosive = 100
cannon_shell_auto_radius = 2
cannon_shell_auto_cooldown_modifier = 0.2
cannon_shell_auto_stacksize_multiplier = 4


cannon_shell_range = 80
cannon_shell_stacksize = 50

-- Red Lasers

laserbeam_red_damage = 10
laserbeam_red_firerate = 60 / 2 
laserbeam_red_damage_interval =  60 / 2
laserbeam_red_duration =  60 / 2

-- Big Red Laser

laserbeam_red_large_damage = 800
laserbeam_red_large_radius_damage = 200
laserbeam_red_large_radius = 6
laserbeam_red_large_firerate = 60 * 8 
laserbeam_red_large_damage_interval =  60 * 8 
laserbeam_red_large_duration =  60 * 0.1

-- Electricity (AKA Blue laser)

laserbeam_electric_damage = 12
laserbeam_electric_firerate = 60 / 6 
laserbeam_electric_damage_interval = 60 / 3 
laserbeam_electric_duration = 60 / 3 

-- Turrets
health_turret_medium_additional = 300 -- add this health to any turrets with a medium base.
health_turret_heavy_additional = 600 -- add this heath to any turrets with a heavy base.

firerate_turret_pistol = firerate_pistol
range_turret_pistol = range_pistol + 2
health_turret_pistol = 150

firerate_turret_smg = 60 / 5
range_turret_smg = range_smg + 2
health_turret_smg = 300

turret_heavysmg_modifier = 1.5
firerate_turret_heavysmg = firerate_turret_smg / turret_heavysmg_modifier
range_turret_heavysmg =  math.ceil(range_turret_smg * (turret_heavysmg_modifier - ((turret_heavysmg_modifier-1)/2)))
health_turret_heavysmg = math.ceil(health_turret_smg * turret_heavysmg_modifier) + health_turret_medium_additional
damagemodifier_turret_heavysmg = turret_heavysmg_modifier

firerate_turret_shotgun = 60 / 0.75
range_turret_shotgun = 20
health_turret_shotgun = 500

firerate_turret_flamethrower = 60 / 15
range_turret_flamethrower = 28
health_turret_flamethrower = 600

firerate_turret_laser = 80 / 4 
range_turret_laser = 28
health_turret_laser = 400

firerate_turret_laser_large = 60 * 8 
range_turret_laser_large = 50
health_turret_laser_large = 2000 + health_turret_heavy_additional

firerate_turret_rocket = firerate_rocketlauncher / 0.3
rangemin_turret_rocket = 22
range_turret_rocket = range_rocketlauncher + 2 -- because it's higher up
health_turret_rocket = 300 + health_turret_medium_additional

-- Space age rocket turret

firerate_rocket_battery = firerate_rocketlauncher / 2
rangemin_rocket_battery = rangemin_turret_rocket
range_rocket_battery = range_rocketlauncher_multi + 2 -- because it's higher up
health_rocket_battery = 600 + health_turret_medium_additional

--

firerate_turret_cannon =  60 / 0.2
rangemin_turret_cannon = 20
range_turret_cannon = 70
health_turret_cannon = 1500 + health_turret_heavy_additional

firerate_turret_minigun = 60 / 15
range_turret_minigun = 42
rangemin_turret_minigun = 4
health_turret_minigun = 1200 + health_turret_heavy_additional

turnrange_mortar = 1/4
firerate_mortar_factor = 2 -- How much to multilpy the base attack speed (in frame count, higher is slower)
range_turret_mortar = 8 * 32
rangemin_turret_mortar = 2 * 32 
health_turret_mortar = 200 + health_turret_medium_additional
projectile_mortar_turret_speed_modifier = 1.5 -- for player turrets, not abandoments, which are using the base horz speed.

firerate_turret_sniper = 60 * 6
range_turret_sniper = 4 * 32
rangemin_turret_sniper = 1 * 32
health_turret_sniper = 300

firerate_artillery = 60 / 0.1
artillery_manual_range_modifier = 2.0
artillery_turret_rotation_speed = 0.001
artillery_turret_range = 8 * 32
artillery_turret_min_range = 2 * 32
health_turret_artillery = 1500 + health_turret_heavy_additional

artillery_shell_radius = 10.0
artillery_shell_damage_physical = 500
artillery_shell_damage_explosion = 500

-- Roborts

robot_costruction_speed_base = 0.14
robot_logistic_speed_base = 0.14
robot_speed_per_tech_level = 0.2

robot_lifetime = 10 * 60 * 60 * 60
robot_deploy_cooldown = 60
robot_deploy_range = 15
robot_stacksize = 25

robot_defender_hp = 150
robot_defender_damage_modifier = 1 -- uses pistol/piercing mag stats
robot_defender_range = 18
robot_defender_speed = 0.016

robot_distractor_hp = 250
robot_distractor_damage_modifier = 1.75 -- uses laser stats
robot_distractor_range = 26
robot_distractor_speed = 0.014

robot_disruptor_damage_modifier = 0.6 
robot_disruptor_range = 36

robot_denier_damage_modifier = 1 
robot_denier_range = 20


robot_destroyer_hp = 600
robot_destroyer_damage_modifier = 2.5  -- uses electric beam stats
robot_destroyer_range = 22
robot_destroyer_speed = 0.012

-- Capsules 

capsule_throw_extra_range = 8

slowdown_grenade_duration =  30 * 60
slowdown_grenade_movement = 0.2

healing_grenade_duration = 60 * 20
healing_grenade_health = 10 
healing_grenade_tick_duration = 15

poison_grenade_damage = 20
poison_grenade_duration = 60 * 40
poison_grenade_tick_duration = 15
