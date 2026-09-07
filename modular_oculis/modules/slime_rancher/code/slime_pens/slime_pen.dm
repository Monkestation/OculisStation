/// handles a single slime pen and tracks the slimes in it
/datum/slime_pen
	/// List of all slimes in the pen.
	var/list/slimes
	/// List of all turfs in the pen.
	var/list/turf/turfs = list()

/datum/slime_pen/Destroy(force)
	for(var/turf/turf as anything in turfs)
		remove_turf(turf)
	// cleaning up all turfs SHOULD remove all slimes, but this is BYOND, "should" doesn't mean jack shit, so better safe than sorry
	for(var/mob/living/basic/slime/slime as anything in slimes)
		stop_tracking_slime(slime)
	turfs = null
	return ..()

/datum/slime_pen/proc/track_slime(mob/living/basic/slime/slime)
	SIGNAL_HANDLER
	if(!isslime(slime))
		CRASH("somehow tried to add something that isn't a slime as a slime in a pen")
	if(QDELING(slime) || (slime in slimes) || !(slime.loc in turfs) || QDELETED(src))
		return
	LAZYADD(slimes, slime)
	RegisterSignal(slime, COMSIG_QDELETING, PROC_REF(stop_tracking_slime))
	RegisterSignal(slime, COMSIG_MOVABLE_MOVED, PROC_REF(slime_moved))

/datum/slime_pen/proc/stop_tracking_slime(mob/living/basic/slime/slime)
	SIGNAL_HANDLER
	if(isnull(slime) || !(slime in slimes))
		return
	UnregisterSignal(slime, list(COMSIG_QDELETING, COMSIG_MOVABLE_MOVED))
	LAZYREMOVE(slimes, slime)

/datum/slime_pen/proc/slime_moved(mob/living/basic/slime/slime, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER
	if(!(slime.loc in turfs))
		stop_tracking_slime(slime)

/datum/slime_pen/proc/add_turf(turf/new_turf)
	if(!isturf(new_turf))
		CRASH("somehow tried to add a non-turf as a slime pen turf")
	if(new_turf in turfs)
		return
	RegisterSignals(new_turf, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON), PROC_REF(check_entered))
	turfs += new_turf
	for(var/mob/living/basic/slime/slime in new_turf)
		track_slime(slime)

/datum/slime_pen/proc/remove_turf(turf/old_turf)
	if(!isturf(old_turf))
		CRASH("somehow tried to remove a non-turf from the slime pen turfs?")
	if(!(old_turf in turfs))
		return
	UnregisterSignal(old_turf, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON))
	turfs -= old_turf
	for(var/mob/living/basic/slime/slime in old_turf)
		stop_tracking_slime(slime)

/datum/slime_pen/proc/check_entered(datum/source, atom/movable/arrived)
	SIGNAL_HANDLER
	if(isslime(arrived))
		track_slime(arrived)

/datum/slime_pen/ui_data(mob/user)
	var/list/slime_data = list()
	for(var/mob/living/basic/slime/slime as anything in slimes)
		var/list/possible_mutations = list()
		for(var/datum/slime_mutation/mutation_type as anything in slime.slime_type.possible_mutations)
			possible_mutations += "[mutation_type]"
		slime_data += list(list(
			"name" = slime.name,
			"health" = round(slime.health / slime.maxHealth, 1),
			"life_stage" = slime.life_stage,
			"amount_grown" = slime.amount_grown,
			"color" = slime.slime_type.rgb_code,
			"possible_mutations" = possible_mutations,
		))
	return list("slimes" = slime_data)

// keep all these in static data
/datum/slime_pen/ui_static_data(mob/user)
	var/list/mutation_types = list()
	for(var/datum/slime_mutation/mutation_type as anything in valid_subtypesof(/datum/slime_mutation))
		var/datum/slime_type/mutates_into = mutation_type::mutates_into
		mutation_types["[mutation_type]"] = "[mutates_into::colour]"
	return list("mutation_types" = mutation_types)
