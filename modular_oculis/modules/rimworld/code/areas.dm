/area/rimworld
	name = "Rimworld"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "explored"
	default_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags_mapping = UNIQUE_AREA | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | CAVES_ALLOWED
	ambience_index = AMBIENCE_FOREST
	sound_environment = SOUND_AREA_FOREST
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	static_lighting = FALSE
	base_lighting_alpha = 255
	map_generator = /datum/map_generator/jungle_generator
	outdoors = TRUE
