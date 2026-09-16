/mob/living/basic/slime
	/// health actually drained while adult, banked toward the next extract/split/mutation
	var/ranch_progress = 0
	/// 0 = not primed, otherwise how much ranch_progress a split needs before it fires
	var/primed_split_cost = 0

/mob/living/basic/slime/proc/on_ranch_drain(datum/source, mob/living/meal, drained)
	SIGNAL_HANDLER
	set_temporary_mood(SLIME_MOOD_SMILE) // a mouthful of someone is still a mouthful, even for babies
	if(life_stage != SLIME_LIFE_STAGE_ADULT)
		return
	ranch_progress += drained
	try_ranch_outcome()

/// checks whether we've banked enough to split, mutate, or pop out an extract
/mob/living/basic/slime/proc/try_ranch_outcome()
	if(has_status_effect(/datum/status_effect/slime_reproducing))
		return

	if(primed_split_cost)
		if(ranch_progress < primed_split_cost)
			return
		reproduce()
		return

	if(ranch_progress < SLIME_RANCH_EXTRACT_COST)
		return

	var/mutation_target = (transformative_effect != SLIME_TYPE_CERULEAN) ? get_unlocked_mutation_type(weight_new_types = TRUE) : null
	if(mutation_target && prob(mutation_chance))
		queued_mutation = mutation_target
		apply_status_effect(/datum/status_effect/slime_reproducing, SLIME_MUTATE_WINDUP)
		return

	ranch_progress -= SLIME_RANCH_EXTRACT_COST
	squish_out_extract()
	for(var/i in 1 to cores)
		var/obj/item/slime_extract/extract = new slime_type.core_type(drop_location())
		extract.fresh_from_slime = TRUE
		extract.pixel_x = extract.base_pixel_x + rand(-6, 6)
		extract.pixel_y = extract.base_pixel_y + rand(-6, 6)
	balloon_alert_to_viewers("produces an extract!")
	playsound(src, 'sound/effects/splat.ogg', 50, TRUE)
	EVLOG_TEXT(src, EVLOG_CATEGORY_SLIMES, "produced an extract via ranching ([ranch_progress] progress left over)")

/mob/living/basic/slime/proc/set_primed_split_cost(new_cost)
	primed_split_cost = new_cost
	balloon_alert_to_viewers(new_cost ? "ready to split!" : "back to extracts")
	do_jitter_animation()
	refresh_wanted_targets() // so the AI starts (or stops) hunting down breeding pellets
	try_ranch_outcome() // if we already banked enough, split right away instead of waiting on the next drain

/mob/living/basic/slime/finish_reproduce()
	if(primed_split_cost)
		primed_split_cost = 0
		balloon_alert_to_viewers("back to extracts")
		refresh_wanted_targets()
	else if(queued_mutation != slime_type.type) // a ranch mutation, not a wild-slime split
		ranch_progress = max(ranch_progress - SLIME_RANCH_EXTRACT_COST, 0)
	// deliberately not calling set_primed_split_cost/try_ranch_outcome here - this runs inside
	// slime_reproducing/on_remove, before ..() reads queued_mutation, so starting a second windup
	// here would stomp it out from under the split/mutation that's about to actually happen
	return ..()

/mob/living/basic/slime/proc/on_check_wanted_pellet(mob/living/basic/slime/source, obj/item/meal)
	SIGNAL_HANDLER
	if(!primed_split_cost && istype(meal, /obj/item/slime_breeding_pellet))
		return COMPONENT_SLIME_WANTS_ITEM

/datum/pet_command/slime_split
	command_name = "Split"
	command_desc = "Prime (or unprime) your slime to split the next time it's fed enough."
	radial_icon_state = "breed"
	speech_commands = list("split", "breed", "multiply")

/datum/pet_command/slime_split/try_activate_command(mob/living/commander, radial_command)
	if(!pet_able_to_respond())
		return FALSE
	var/mob/living/basic/slime/parent = weak_parent.resolve()
	if(!istype(parent))
		return FALSE
	parent.set_primed_split_cost(parent.primed_split_cost ? 0 : SLIME_RANCH_COMMAND_SPLIT_COST)
	if(radial_command)
		var/manual_emote_text = generate_emote_command()
		commander.manual_emote(manual_emote_text)
	// deliberately skips set_command_active - toggling the split prime shouldn't cancel an active Follow/Stay
	return TRUE

/obj/item/slime_breeding_pellet
	name = "slime breeding pellet"
	desc = "A biomass pellet slimes go nuts for. Feed it to a slime, and it'll split the next time it's fed enough!"
	icon = 'modular_oculis/modules/slime_rancher/icons/biomass.dmi'
	icon_state = "pellet"
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
