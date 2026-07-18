/datum/element/climbable/proc/after_climb_effects(atom/climbed_thing, mob/living/user)
	if(HAS_TRAIT(user, TRAIT_OVERSIZED) || HAS_TRAIT(user, TRAIT_HEAVYSET))
		climbed_thing.take_damage(100, BRUTE)
