/mob/living/basic/voidwalker/sunwalker/cosmic_entity
	name = "Tangible splinter"
	desc = "A cosmic entity covered in stellar corona. You DEFINITELY shouldn't stare."
	icon_state = "voidwalker_stealthed"
	melee_damage_type = BURN
	melee_damage_lower = 50
	melee_damage_upper = 50

	health = 10000
	maxHealth = 10000

	obj_damage = 50
	speed = 0.2
	regenerate_colour = COLOR_VIOLET
	light_range = 7
	faction = list(FACTION_VIOLET)
	movement_type = FLOATING | PHASING

/mob/living/basic/voidwalker/sunwalker/cosmic_entity/Initialize(mapload, mob/tamer)
	. = ..()

	clear_filters()
	var/static/list/ray_filter = list(type = "rays", size = 32, color = COLOR_VOID_PURPLE)
	add_filter("sunwalker_rays", 3, ray_filter)
	animate(get_filter("sunwalker_rays"), offset = 1, time = 3 SECONDS, loop = -1, flags = ANIMATION_PARALLEL)
