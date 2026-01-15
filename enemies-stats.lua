
-- COLOUR

swarmer_spawner_tint = {r=0.99, g=0.79, b=0.09, a=0.5} -- small, numerous, fast, annoying
biter_spawner_tint = {r=0.8, g=0.4, b=0.4, a=0.3} -- basic melee
spitter_spawner_tint = {r=0.19, g=0.9, b=0.09, a=0.4} -- ranged, slow
blaster_spawner_tint = {r=0.9, g=0.0, b=0.0, a=0.4} -- suicide, explodes
blaster_spawner_tint_light = {r=0.9/2, g=0.0, b=0.0, a=0.4/2}
tanker_tint = {r=0.02, g=0.09, b=0.59, a=0.4} -- high armour, slow, high hp
webber_spawner_tint = {r=0.06, g=0.03, b=0.06, a=0.7} -- spider black, sticky white web stickers, pure slowdown, nothing else.
flamer_spawner_tint = {r=0.99, g=0.45, b=0.06, a=0.4} --  ranged flamethrower
flamer_spawner_tint_light = {r=0.99/2, g=0.45/2, b=0.06/2, a=0.4/2}

-- breeder, hatcher, bearer

stinger_spawner_tint = {r=0.10, g=0.4, b=0.02, a=0.3} -- poisoning, slowing biter
--tbd


--laser_spawner_tint = {r=0.19, g=0.99, b=0.09, a=0.5} -- shoots lasers, reflective
--bio_spawner_tint = {r=0.99, g=0.99, b=0.09, a=0.5} -- poison gas ?
--launcher_spawner_tint = {r=0.99, g=0.99, b=0.09, a=0.5} -- long ranged, long range, v few of them

-- WORMS

scale_worm_small     = 0.7
scale_worm_medium    = 1.1
scale_worm_big       = 1.5
scale_worm_behemoth  = 1.9
--scale_worm_boss  	= 1.9

autoplace_worm_small     = 0.0
autoplace_worm_medium    = 1.5
autoplace_worm_big       = 3.5
autoplace_worm_behemoth  = 8.0

tint_worm_small      = spitter_spawner_tint
tint_worm_medium     = spitter_spawner_tint
tint_worm_big        = spitter_spawner_tint
tint_worm_behemoth   = spitter_spawner_tint
tint_worm_boss   = spitter_spawner_tint

damage_modifier_worm_small    = 20
damage_modifier_worm_medium   = 40
damage_modifier_worm_big      = 60
damage_modifier_worm_behemoth = 100
-- damage_modifier_worm_boss 	= 160

range_worm_small_min	= 4
range_worm_small    	= 24
range_worm_medium_min  	= 6
range_worm_medium   	= 36
range_worm_big_min     	= 8
range_worm_big      	= 52
range_worm_behemoth_min	= 10
range_worm_behemoth 	= 74

prepare_range_worm_small    = 8
prepare_range_worm_medium   = 12
prepare_range_worm_big      = 16
prepare_range_worm_behemoth = 20
-- prepare_range_worm_boss 	= 24

health_small_worm    	= 400
health_medium_worm   	= 1000
health_big_worm  		= 2200
health_behemoth_worm 	= 4800
-- health_boss_worm  		= 8800

damage_splash_worm_small    	= damage_modifier_worm_small / 60 / 2
damage_splash_worm_medium   	= damage_modifier_worm_medium / 60 / 3
damage_splash_worm_big      	= damage_modifier_worm_big / 60 / 4
damage_splash_worm_behemoth 	= damage_modifier_worm_behemoth / 60 / 8
--damage_splash_worm_boss 		= damage_modifier_worm_boss / 60 / 12

worm_attack_speed_base = 100

worm_collision_map_scale_base = 3.0 -- autoplace bounding box multiplier for worm scale
worm_collision_map_scale_addition = 3.0 -- autoplace total + this amount



-- SPACING

-- [1] is the distance from starting area ~ in chunks
-- [2] Is the bounding box space between others
autoplace_spacing_biter    = {0.25, 6.0}
autoplace_spacing_spitter  	= {0.4, 5.0}
autoplace_spacing_swarmer	= {0.40, 4.75}
autoplace_spacing_blaster = {0.9, 10}
autoplace_spacing_tanker  ={0.85, 9.0}
autoplace_spacing_webber = {0.65, 9.5}
autoplace_spacing_flamer = {0.8, 6.2}
autoplace_spacing_stinger = {0.5, 5}

-- BASE SPAWN AMOUNTS

spawning_amount_biter = 4
spawning_amount_spitter = 4
spawning_amount_swarmer = 8
spawning_amount_blaster = 4
spawning_amount_tanker = 3
spawning_amount_flamer = 3
spawning_amount_stinger = 6

-- SPAWN TIME

spawning_time_slowest = 200
spawning_time_fastest = 100

spawning_base_pollution_cost = 4

spawning_time_small = 4
spawning_time_medium = 10
spawning_time_big = 20
spawning_time_behemoth = 50
spawning_time_boss = 120

spawning_time_scalar_spitter = 1.3
spawning_time_scalar_swarmer = 0.75
spawning_time_scalar_biter = 1.3
spawning_time_scalar_blaster = 2.1
spawning_time_scalar_tanker = 1.8
spawning_time_scalar_webber = 1.4
spawning_time_scalar_flamer = 1.8
spawning_time_scalar_stinger = 1.0

-- TILE RESTRICTIONS
-- Restrictions state what tiles can spawners be placed on.



-- HEALTH

health_spawner_flamer   = 250

health_small_flamer    = 70
health_medium_flamer  = 250
health_big_flamer      = 400
health_behemoth_flamer = 700
health_boss_flamer     = 1800

health_spawner_blaster   = 300

health_small_blaster    = 200 * 1.25
health_medium_blaster  	= 600 * 1.25
health_big_blaster		= 1400 * 1.25
health_behemoth_blaster = 3200 * 1.25
health_boss_blaster     = 6500 * 1.25

health_spawner_swarmer   = 150

health_small_swarmer    = 6
health_medium_swarmer  	= 15
health_big_swarmer		= 32
health_behemoth_swarmer = 90
health_boss_swarmer     = 220

health_spawner_biter   = 400

health_small_biter    = 50
health_medium_biter   = 150
health_big_biter      = 500
health_behemoth_biter = 1500
health_boss_biter     = 6000

health_spawner_spitter   = 250

health_small_spitter    = 25
health_medium_spitter   = 60
health_big_spitter      = 250
health_behemoth_spitter = 450
health_boss_spitter     = 1900

health_spawner_tanker   = 500

health_small_tanker    	= 450
health_medium_tanker  	= 800
health_big_tanker		= 1400
health_behemoth_tanker 	= 1900
health_boss_tanker     	= 3200

health_spawner_stinger   = 350

-- MOVEMENT

movement_blaster_movement_scalar   = 0.5

movement_speed_swarmer_base		=  0.16
movement_speed_swarmer 			=  0.035
movement_speed_biter_base 		=  0.12
movement_speed_biter 			=  0.025
movement_speed_spitter_base 	=  0.10
movement_speed_spitter 			=  0.015
movement_speed_blaster_base 	=  0.06
movement_speed_blaster 			=  0.018
movement_speed_tanker_base 		=  0.06
movement_speed_tanker 			=  0.011
movement_speed_webber_base 		=  0.10 -- base speed
movement_speed_webber 			=  0.013 -- additional speed per size increase
movement_speed_flamer_base 		=  0.11
movement_speed_flamer			=  0.014 

-- SCALE

flamer_spawner_scale = 1.25

small_flamer_scale   	= 0.7
medium_flamer_scale    = 0.95
big_flamer_scale    	= 1.25
behemoth_flamer_scale  = 1.6
boss_flamer_scale  	= 2.25

blaster_spawner_scale = 1.1

small_blaster_scale   	= 0.6
medium_blaster_scale    = 0.9
big_blaster_scale    	= 1.2
behemoth_blaster_scale  = 1.5
boss_blaster_scale  	= 2.0

swarmer_spawner_scale = 0.6

small_swarmer_scale    = 0.2
medium_swarmer_scale    = 0.25
big_swarmer_scale    = 0.3
behemoth_swarmer_scale    = 0.35
boss_swarmer_scale    = 0.55

biter_spawner_scale = 1.1

small_biter_scale    = 0.5
medium_biter_scale   = 0.8
big_biter_scale      = 1.2
behemoth_biter_scale = 1.75
boss_biter_scale     = 3.0

spitter_spawner_scale = 0.8

small_spitter_scale    = 0.4
medium_spitter_scale   = 0.65
big_spitter_scale      = 1
behemoth_spitter_scale  = 1.45
boss_spitter_scale      = 2.0

tanker_spawner_scale = 1.2

small_tanker_scale    = 0.9
medium_tanker_scale   = 1.2
big_tanker_scale      = 1.5
behemoth_tanker_scale = 1.9
boss_tanker_scale     = 2.3

stinger_spawner_scale = 1.1

-- ATTACKS & DAMAGE

damage_modifier_blaster_spawn    	= 400
damage_radius_blaster_spawn			= 15  
damage_falloff_blaster_spawn		= 1  

blaster_base_attack_range			= 1.5 -- trigger range

damage_modifier_blaster_small    	= 200
damage_radius_blaster_small			= 8  
damage_modifier_blaster_medium 		= 400
damage_radius_blaster_medium   		= 9
damage_modifier_blaster_big    		= 800
damage_radius_blaster_big    		= 10 
damage_modifier_blaster_behemoth    = 1200
damage_radius_blaster_behemoth		= 11
damage_modifier_blaster_boss    	= 1600
damage_radius_blaster_boss			= 12

attack_speed_swarmer_base = 15
attack_speed_tanker_base = 40
attack_speed_biter_base = 30
attack_speed_spitter_base = 50
attack_speed_webber_base = 60
attack_speed_blaster_base = 10

damage_modifier_swarmer_small    = 4
damage_modifier_swarmer_medium   = 8
damage_modifier_swarmer_big      = 14
damage_modifier_swarmer_behemoth = 22
damage_modifier_swarmer_boss     = 32

damage_modifier_tanker_small    = 8  
damage_modifier_tanker_medium   = 16
damage_modifier_tanker_big      = 30
damage_modifier_tanker_behemoth = 60
damage_modifier_tanker_boss     = 120

damage_modifier_biter_small    = 10
damage_modifier_biter_medium   = 25
damage_modifier_biter_big      = 50
damage_modifier_biter_behemoth = 100
damage_modifier_biter_boss     = 250

damage_modifier_spitter_small    = 10
damage_modifier_spitter_medium   = 20
damage_modifier_spitter_big      = 35
damage_modifier_spitter_behemoth = 50
damage_modifier_spitter_boss     = 100

damage_splash_spitter_small    	= damage_modifier_spitter_small / 60
damage_splash_spitter_medium   	= damage_modifier_spitter_medium / 60 / 1.5
damage_splash_spitter_big      	= damage_modifier_spitter_big / 60 / 2
damage_splash_spitter_behemoth 	= damage_modifier_spitter_behemoth / 60 / 3
damage_splash_spitter_boss 		= damage_modifier_spitter_boss / 60 / 4

stream_radius_spitter_small    = 0.7
stream_radius_spitter_medium   = 1.0
stream_radius_spitter_big      = 1.3
stream_radius_spitter_behemoth = 1.6
stream_radius_spitter_boss 	= 2.0

spitter_hit_splash_radius_modifier = 2.0

slow_movement_multiplier_spitter = 1.0
slow_movement_time_spitter = 1

spitter_ground_patch_duration = 30
patch_opacity = 0.5
ground_patch_scale_modifier = 1.5

range_spitter_small    = 14
range_spitter_medium   = 20
range_spitter_big      = 26
range_spitter_behemoth = 32
range_spitter_boss 	   = 38

-- FLAMER

attack_speed_flamer_base = 200

damage_modifier_flamer_small    = 16
damage_modifier_flamer_medium   = 20
damage_modifier_flamer_big      = 24
damage_modifier_flamer_behemoth = 28
damage_modifier_flamer_boss     = 34

cluster_amount_flamer_small    = 6
cluster_amount_flamer_medium   = 10
cluster_amount_flamer_big      = 14
cluster_amount_flamer_behemoth = 24
cluster_amount_flamer_boss     = 38

damage_dps_flamer_small    	= damage_modifier_flamer_small / 60
damage_dps_flamer_medium   	= damage_modifier_flamer_medium / 60 
damage_dps_flamer_big      	= damage_modifier_flamer_big / 60 
damage_dps_flamer_behemoth 	= damage_modifier_flamer_behemoth / 60 
damage_dps_flamer_boss 		= damage_modifier_flamer_boss / 60 
damage_dps_maxstackamount_flamer = 6

stream_radius_flamer_small    = 1.0
stream_radius_flamer_medium   = 1.2
stream_radius_flamer_big      = 1.5
stream_radius_flamer_behemoth = 1.8
stream_radius_flamer_boss 	= 2.4

stream_blastradius_flamer_small    = 2
stream_blastradius_flamer_medium   = 2.5
stream_blastradius_flamer_big      = 3
stream_blastradius_flamer_behemoth = 3.5
stream_blastradius_flamer_boss 	= 4.5

flamer_hit_splash_radius_modifier = 3.0
flamer_sticker_duration = 10
flamer_ground_patch_duration = 10
flamer_ground_patch_scale_modifier = 1.5

range_flamer_small    = 18 -4
range_flamer_medium   = 24 -4
range_flamer_big      = 32 -4
range_flamer_behemoth = 42 -4
range_flamer_boss 	  = 54 -4

-- WEBBERS

	-- WEBBBER SPAWNER
health_spawner_webber = 200
spawning_amount_webber = 4
webber_spawner_scale = 0.95
spawning_time_scalar_webber = 1.0
webber_spawner_scale = 0.8

	-- WEBBER UNIT

--movement_speed_webber = 0.15

small_webber_scale    = 0.6
medium_webber_scale   = 0.8
big_webber_scale      = 1.1
behemoth_webber_scale  = 1.4
boss_webber_scale      = 2.0

health_small_webber   	= 30
health_medium_webber  	= 80
health_big_webber   	= 200
health_behemoth_webber 	= 400
health_boss_webber    	= 1100

range_webber_small    = 18
range_webber_medium   = 22
range_webber_big      = 26
range_webber_behemoth = 30
range_webber_boss 	   = 36

	-- WEBBER STREAM
	
stream_radius_webber_small    = 1.4
stream_radius_webber_medium   = 1.7
stream_radius_webber_big      = 2.0
stream_radius_webber_behemoth = 2.3
stream_radius_webber_boss 	= 2.8

damage_webber_small    = 4
damage_webber_medium   = 8
damage_webber_big      = 12
damage_webber_behemoth = 20
damage_webber_boss 	   = 32

	-- WEBBER STATS
	
webber_web_tint = {r=1, g=1, b=1, a=0.8} -- spider black, sticky white web stickers, pure slowdown, nothing else.

ground_webber_scale_modifier = 1.35
webber_ground_patch_duration = 15
slow_movement_multiplier_webber = 0.5 -- per level ^ level
slow_movement_time_webber = 4

	-- STINGER STATS

small_stinger_scale    = 0.4
medium_stinger_scale   = 0.6
big_stinger_scale      = 0.9
behemoth_stinger_scale  = 1.3
boss_stinger_scale      = 1.8

health_small_stinger   	= 45
health_medium_stinger  	= 280
health_big_stinger   	= 500
health_behemoth_stinger = 1200
health_boss_stinger    	= 2200

movement_speed_stinger_base 		=  0.14
movement_speed_stinger 				=  0.015 

attack_speed_stinger_base = 80

damage_stinger_small    = 5
damage_stinger_medium   = 10
damage_stinger_big      = 20
damage_stinger_behemoth = 30
damage_stinger_boss     = 50
	
slow_movement_multiplier_stinger = 0.7
slow_movement_time_stinger = 10 -- Includes damage over time poison

-- HATCHER STATS

	function hatcherresistances(v)
	local ntv = v
	local dinc = {2,10}
	local pinc = {0,5}
	return 
	{
		{
		type = "physical",
		decrease = 2 + ( ntv * dinc[1] ) ,
		percent = 20 + ( ntv * dinc[2] ) ,
		},
		{
		type = "piercing",
		decrease = 0 + ( ntv * pinc[1] ),
		percent = 10 + ( ntv * pinc[2] ),
		},
	}
	end
	
	--  HATCHER SPAWNER
	
	hatcher_spawner_tint = swarmer_spawner_tint -- A spitter version of swarmers, spits them out as 'eggs' and when killed leave a 'nest' of swarmers eggs
	autoplace_spacing_hatcher = {0.9, 7}
	spawning_amount_hatcher = 3
	spawning_time_scalar_hatcher = 2.0
	spawner_tilerestrictions_hatcher = {"dry-dirt","dirt-5", "dirt-6" }
	health_spawner_hatcher   = 350	
	hatcher_spawner_scale = 1.4

	-- HATCHER UNIT
	
	small_hatcher_scale    = 1.0
	medium_hatcher_scale   = 1.2
	big_hatcher_scale      = 1.4
	behemoth_hatcher_scale  = 1.6
	boss_hatcher_scale      = 2.2

	hatcher_egg_health_base = 250

	health_small_hatcher   	= 100
	health_medium_hatcher  	= 100 * 2
	health_big_hatcher   	= 100 * 5
	health_behemoth_hatcher = 100 * 10
	health_boss_hatcher    	= 100 * 30

	movement_speed_hatcher_base 		=  0.10
	movement_speed_hatcher 				=  0.015 

	attack_speed_hatcher_base = 60 * 1.5

	range_hatcher_small    = 26
	range_hatcher_medium   = 28
	range_hatcher_big      = 32
	range_hatcher_behemoth = 36
	range_hatcher_boss 	   = 42
	
	-- multiplied by 10, because spitter logic...
	damage_hatcher_small    = 1
	damage_hatcher_medium   = 2
	damage_hatcher_big      = 3
	damage_hatcher_behemoth = 4
	damage_hatcher_boss     = 5	

-- BITER COLOURS

blaster_tint1 = blaster_spawner_tint
blaster_tint2 = blaster_spawner_tint

swarmer_tint1 = swarmer_spawner_tint 
swarmer_tint2 = swarmer_spawner_tint 

small_biter_tint1 = biter_spawner_tint
small_biter_tint2 = biter_spawner_tint
medium_biter_tint1 = biter_spawner_tint
medium_biter_tint2 = biter_spawner_tint
big_biter_tint1 = biter_spawner_tint
big_biter_tint2 = biter_spawner_tint
behemoth_biter_tint1 = biter_spawner_tint
behemoth_biter_tint2 = biter_spawner_tint
boss_biter_tint1 = biter_spawner_tint
boss_biter_tint2 = biter_spawner_tint

tint_1_spitter_small    = spitter_spawner_tint
tint_2_spitter_small    = spitter_spawner_tint
tint_1_spitter_medium   = spitter_spawner_tint
tint_2_spitter_medium   = spitter_spawner_tint
tint_1_spitter_big      = spitter_spawner_tint
tint_2_spitter_big      = spitter_spawner_tint
tint_1_spitter_behemoth = spitter_spawner_tint
tint_2_spitter_behemoth = spitter_spawner_tint
tint_1_spitter_boss = spitter_spawner_tint
tint_2_spitter_boss = spitter_spawner_tint

-- RESISTANCES

function tankerresistances(v)
local ntv = v
local dinc = {3,8}
local pinc = {2,8}
local einc = {0,6}
return 
{
	{
	type = "physical",
	decrease = 2 + ( ntv * dinc[1] ) ,
	percent = 50 + ( ntv * dinc[2] ) ,
	},
	{
	type = "piercing",
	decrease = 1 + ( ntv * pinc[1] ),
	percent = 40 + ( ntv * pinc[2] ),
	},
	{
	type = "explosion",
	decrease = 0 + ( ntv * einc[1] ), 
	percent = 15 + ( ntv * einc[2] ),
	},
}
end

function biterresistances(v)
local ntv = v - 1
local dinc = {2,15}
local einc = {1,10}
local linc = {1,10}
local pinc = {1,5}
return 
{
	{
	type = "physical",
	decrease = 1 + ( ntv * dinc[1] ),
	percent = 10 + ( ntv * dinc[2] ),
	},
	{
	type = "explosion",
	decrease = 0 + ( ntv * einc[1] ), 
	percent = 0 + ( ntv * einc[2] ),
	},
	{
	type = "laser",
	decrease = 0 + ( ntv * linc[1] ),
	percent = 0 + ( ntv * linc[2] ),
	},
	{
	type = "piercing",
	decrease = 0 + ( ntv * pinc[1] ),
	percent = 0 + ( ntv * pinc[2] ),
	},
}
end

function spitterresistances(v)
local ntv = v - 1
local dinc = {1,8}
local ainc = {5,5}
local linc = {0,5}
return 
{
	{
	type = "physical",
	decrease = 0 + ( ntv * dinc[1] ) ,
	percent = 0 + ( ntv * dinc[2] ) ,
	},
	{
	type = "acid",
	percent = 100 ,
	},
	{
	type = "laser",
	decrease = 0 + ( ntv * linc[1] ),
	percent = 0 + ( ntv * linc[2] ),
	},
}
end

function webberresistances(v)
local ntv = v - 1
local dinc = {1,10}
return 
{
	{
	type = "physical",
	decrease = 1 + ( ntv * dinc[1] ) ,
	percent = 10 + ( ntv * dinc[2] ) ,
	},
}
end

function blasterresistances(v)
local ntv = v - 1
local dinc = {1,15}
local einc = {15,5}
return 
{
{
	type = "physical",
	decrease = 1 + ( ntv * dinc[1] ) ,
	percent = 10 + ( ntv * dinc[2] ) ,
	},
	{
	type = "explosion",
	decrease = 20 + ( ntv * einc[1] ),
	percent = 70 + ( ntv * einc[2] ),
	},
}
end

function swarmerresistances(v)
local ntv = v - 1
local dinc = {0,8}
return 
{
	{
	type = "physical",
	decrease = 0 + ( ntv * dinc[1] ) ,
	percent = 0 + ( ntv * dinc[2] ) ,
	},
}
end

function flamerresistances(v)
local ntv = v - 1
local dinc = {1,8}
return 
{
	{
	type = "physical",
	decrease = 0 + ( ntv * dinc[1] ) ,
	percent = 0 + ( ntv * dinc[2] ) ,
	},
	{
	type = "fire",
	percent = 100 ,
	},
}
end

function stingerresistances(v)
local ntv = v - 1
local dinc = {1,10}
local einc = {2,6}
return 
{
	{
	type = "physical",
	decrease = 1 + ( ntv * dinc[1] ) ,
	percent = 5 + ( ntv * dinc[2] ) ,
	},
	{
	type = "explosion",
	decrease = 0 + ( ntv * einc[1] ), 
	percent = 0 + ( ntv * einc[2] ),
	},
	{
	type = "poison",
	percent = 100 ,
	},
}
end

-- LOOT

function createmeatyloot(scale, tier)
	local nttier = tier - 1
	local minval = 0.5
	local calc =  ((scale * (nttier*1.0)) + 0.5)
	local big_chunks = math.floor( calc / 5 )
	-- Boss swarmer with 0.5 scale => calc =  (0.5 * (5*1.0) + 0.5)  = 3
		if  (scale + (nttier) == 0) or (calc <= minval)
			then 
			return nil
		else
			if (big_chunks > 0)
			then
			return
			{ 
				{item = "chunky-meat", probability = 1 * (settings.startup["settings-chunks-probability"].value/100), count_min =  math.floor(nttier/2) , count_max = math.ceil( big_chunks + (nttier/1.5) ) },
				{item = "meaty-chunks", probability = 1 * (settings.startup["settings-chunks-probability"].value/100), count_min =  1, count_max = math.ceil(calc/2) }, 
			}			
			else
			return 
			{ 
				{item = "meaty-chunks", probability = 1 * (settings.startup["settings-chunks-probability"].value/100), count_min = math.floor( scale + (nttier) ), count_max = math.ceil( calc ) },
				{item = "meaty-chunks", probability = 0.5 * (settings.startup["settings-chunks-probability"].value/100), count_min =  math.floor( (scale + (nttier)) /2 ) , count_max = math.ceil(calc/2) }, 
			}
			end
		end
end



-- Preset loot



-- small_loot = { {item = "meaty-chunks", probability =  (settings.startup["settings-chunks-probability"].value/100) , count_min = 0 , count_max = 1 * settings.startup["settings-chunks-multiplier"].value} }
-- medium_loot = { {item = "meaty-chunks", probability =  (settings.startup["settings-chunks-probability"].value/100) , count_min = 0 , count_max = 2 * settings.startup["settings-chunks-multiplier"].value} }
-- big_loot = { {item = "meaty-chunks", probability =  (settings.startup["settings-chunks-probability"].value/100), count_min = 1, count_max = 3 * settings.startup["settings-chunks-multiplier"].value} }
-- behemoth_loot = { {item = "meaty-chunks", probability =  (settings.startup["settings-chunks-probability"].value/100), count_min = 2, count_max = 5 * settings.startup["settings-chunks-multiplier"].value} }
-- boss_loot = { {item = "meaty-chunks", probability =  (settings.startup["settings-chunks-probability"].value/100), count_min = 3, count_max = 8 * settings.startup["settings-chunks-multiplier"].value} }

-- medium_loot = { {item = "meaty-chunks", probability = 0.2, count_min = 1, count_max = 2} }
-- big_loot = { {item = "meaty-chunks", probability = 0.4, count_min = 2, count_max = 4} }
-- behemoth_loot = { {item = "meaty-chunks", probability = 0.5, count_min = 3, count_max = 6} }
-- boss_loot = { {item = "meaty-chunks", probability = 1, count_min = 4, count_max = 8} }

if (settings.startup["settings-chunks-probability"].value ~= 0) then
	small_loot = createmeatyloot(1, 1)
	medium_loot = createmeatyloot(1.25, 2) 
	big_loot = createmeatyloot(1.5, 3)
	behemoth_loot = createmeatyloot(1.75, 4)
	boss_loot = createmeatyloot(2.0, 5) 
	spawner_small_loot = { {item = "meaty-chunks", probability = (settings.startup["settings-chunks-probability"].value/100), count_min = 2, count_max = 6 * settings.startup["settings-chunks-multiplier"].value} }
	spawner_medium_loot = { {item = "meaty-chunks", probability =  (settings.startup["settings-chunks-probability"].value/100), count_min = 4, count_max = 10 * settings.startup["settings-chunks-multiplier"].value} }
	spawner_big_loot = { {item = "meaty-chunks", probability = (settings.startup["settings-chunks-probability"].value/100), count_min = 6, count_max = 14 * settings.startup["settings-chunks-multiplier"].value} }
	spawner_behemoth_loot = { {item = "meaty-chunks", probability =  (settings.startup["settings-chunks-probability"].value/100), count_min = 8, count_max = 18 * settings.startup["settings-chunks-multiplier"].value} }
else
	small_loot = nil
	medium_loot = nil
	big_loot = nil
	behemoth_loot = nil
	boss_loot = nil
	spawner_small_loot = nil
	spawner_medium_loot = nil
	spawner_big_loot = nil
	spawner_behemoth_loot = nil
end
