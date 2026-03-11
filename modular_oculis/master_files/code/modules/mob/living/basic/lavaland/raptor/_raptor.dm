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

// Tamed raptors also have a much quicker cooldown for attacking mining fauna.
/mob/living/basic/raptor/melee_attack(mob/living/target, list/modifiers, ignore_cooldown)
	var/atom/target_loc = target.loc // we need to store this before we attack, due to legion del_on_death stuff
	. = ..()
	if(!. || ignore_cooldown || !(target.mob_biotypes & (MOB_BEAST | MOB_MINING)) || ismegafauna(target))
		return
	if(LAZYLEN(ai_controller?.blackboard[BB_FRIENDS_LIST]))
		changeNext_move(melee_attack_cooldown * 0.25)
	// DIE YOU LITTLE SHITS
	if(istype(target, /mob/living/basic/mining/legion_brood))
		var/iter = 1
		// when spacing out our attacks, we should avoid overlapping with the next melee cooldown
		var/delay_limit = next_move - world.time - world.tick_lag
		for(var/mob/living/basic/mining/legion_brood/stupid_skull in target_loc)
			if(stupid_skull == target || !prob(75))
				continue
			// slightly space out our additional attacks
			var/delay = melee_attack_cooldown * (iter * 0.05)
			if(delay >= delay_limit)
				break
			addtimer(CALLBACK(src, PROC_REF(attack_additional_legion), stupid_skull), delay)
			iter++

// Completely block attacks from legion broods, and 50% block chance if we're currently stuck with a goliath tentacle up our a-
/mob/living/basic/raptor/check_block(atom/hit_by, damage, attack_text, attack_type, armour_penetration, damage_type)
	. = ..()
	if(. == SUCCESSFUL_BLOCK)
		return
	// I HATE LEGIONS I HATE LEGIONS I HATE LEGIONS
	if(istype(hit_by, /mob/living/basic/mining/legion_brood))
		return SUCCESSFUL_BLOCK
	// Not easy to make them actually try to dodge tentacles, so like, next best thing I guess?
	if(has_status_effect(/datum/status_effect/incapacitating/stun/goliath_tentacled) && prob(50))
		return SUCCESSFUL_BLOCK
	var/mob/living/living_attacker = hit_by
	if(isprojectile(hit_by))
		var/obj/projectile/hit_by_projectile = hit_by
		living_attacker = hit_by_projectile.firer
	if(isliving(living_attacker))
		// 20% block chance against mining mobs (except megafauna)
		if(prob(20) && (living_attacker.mob_biotypes & (MOB_BEAST | MOB_MINING)) && !ismegafauna(living_attacker))
			return SUCCESSFUL_BLOCK

/// Wrapper proc that just checks for qdeleted in case someone punched the legion during our short delay, to prevent weird runtimes.
/mob/living/basic/raptor/proc/attack_additional_legion(mob/living/basic/mining/legion_brood/stupid_skull)
	if(!QDELETED(stupid_skull) && Adjacent(stupid_skull))
		// dw, this can't recurse due the ignore_cooldown var
		melee_attack(stupid_skull, ignore_cooldown = TRUE)
