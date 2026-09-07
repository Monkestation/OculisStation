/mob/living/basic/slime
	var/list/datum/slime_mutation/mutation_progress

/mob/living/basic/slime/Initialize(mapload, new_type, new_life_stage)
	. = ..()
	ADD_TRAIT(src, TRAIT_DOESNT_SQUASH, INNATE_TRAIT) // so we don't squash iceroaches and such. slimes are soft and squishy it makes sense.

/mob/living/basic/slime/Destroy()
	QDEL_LIST(mutation_progress)
	return ..()
