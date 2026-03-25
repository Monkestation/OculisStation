// Tamed raptors are faster on lavaland when being ridden.
/mob/living/basic/raptor/on_changed_z_level(turf/old_turf, turf/new_turf, same_z_layer, notify_contents)
	. = ..()
	if(same_z_layer)
		return
	if(length(buckled_mobs) && SSmapping.level_trait(new_turf.z, ZTRAIT_ASHSTORM))
		add_movespeed_modifier(/datum/movespeed_modifier/lavaland_raptor)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/lavaland_raptor)

/mob/living/basic/raptor/post_buckle_mob(mob/living/buckled_mob)
	. = ..()
	var/turf/our_turf = get_turf(src)
	if(SSmapping.level_trait(our_turf.z, ZTRAIT_ASHSTORM))
		add_movespeed_modifier(/datum/movespeed_modifier/lavaland_raptor)

/mob/living/basic/raptor/post_unbuckle_mob(mob/living/unbuckled_mob)
	. = ..()
	if(!length(buckled_mobs))
		remove_movespeed_modifier(/datum/movespeed_modifier/lavaland_raptor)

/datum/movespeed_modifier/lavaland_raptor
	multiplicative_slowdown = -0.5
	blacklisted_movetypes = MOVETYPES_NOT_TOUCHING_GROUND

// Not easy to make them actually try to dodge goliath tentacles, so like,
// next best thing is giving them 50% block chance if they are currently caught by one?
/mob/living/basic/raptor/check_block(atom/hit_by, damage, attack_text, attack_type, armour_penetration, damage_type)
	. = ..()
	if(. == SUCCESSFUL_BLOCK)
		return
	if(has_status_effect(/datum/status_effect/incapacitating/stun/goliath_tentacled) && prob(50))
		return SUCCESSFUL_BLOCK
