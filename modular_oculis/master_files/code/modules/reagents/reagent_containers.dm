/obj/item/reagent_containers/onZImpact(turf/impacted_turf, levels, impact_flags)
	. = ..()
	var/list/mob_targets = list()
	for(var/mob/living/mob_target in impacted_turf)
		mob_targets += mob_target
	var/target
	if(length(mob_targets))
		target = pick(mob_targets)
		var/splash_multiplier = 1 * (rand(5,10) * 0.1) //Not all of it makes contact with the target
		reagents.expose(target, TOUCH, splash_multiplier)
		reagents.expose(impacted_turf, TOUCH, 1 - splash_multiplier) // 1 - splash_multiplier because it's what didn't hit the target
		impacted_turf.add_liquid_from_reagents(reagents, reagent_multiplier = (1 - splash_multiplier))
	else
		target = impacted_turf
		var/turf/turf_target = target
		reagents.expose(target, TOUCH)
		turf_target.add_liquid_from_reagents(reagents)
	log_combat(null, target, "splashed (falling) [english_list(reagents.reagent_list)]", src, "in [AREACOORD(target)]. Last fingerprints: [fingerprintslast]")
	message_admins("[target] was splashed (falling) [english_list(reagents.reagent_list)] in [ADMIN_VERBOSEJMP(target)] Last fingerprints: [ADMIN_LOOKUPFLW(fingerprintslast)].")
