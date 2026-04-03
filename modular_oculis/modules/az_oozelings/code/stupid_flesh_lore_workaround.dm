/datum/heretic_knowledge/limited_amount/starting/base_flesh/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY, PROC_REF(on_mansus_grasp_secondary))

/datum/heretic_knowledge/limited_amount/starting/base_flesh/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY)

// snowflake handler for ooze cores
/datum/heretic_knowledge/limited_amount/starting/base_flesh/proc/on_mansus_grasp_secondary(mob/living/source, obj/item/organ/brain/slime/core)
	//SIGNAL_HANDLER
	if(!is_slime_core(core))
		return NONE

	if(LAZYLEN(created_items) >= limit)
		core.balloon_alert(source, "at ghoul limit!")
		return COMPONENT_BLOCK_HAND_USE

	core.brainmob?.grab_ghost()
	if(!core.mind || !core.brainmob?.client)
		core.balloon_alert(source, "no soul!")
		return COMPONENT_BLOCK_HAND_USE

	var/mob/living/carbon/human/ghouled_slime = core.rebuild_body(nugget = FALSE)
	if(QDELETED(ghouled_slime))
		core.balloon_alert(source, "failed to ghoul!")
		return COMPONENT_BLOCK_HAND_USE

	make_ghoul(source, ghouled_slime)

	return COMPONENT_USE_HAND
