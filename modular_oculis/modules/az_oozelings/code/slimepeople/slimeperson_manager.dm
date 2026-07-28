GLOBAL_ALIST_EMPTY(slimeperson_managers)

/// Datum to manage multiple slimeperson bodies.
/datum/slimeperson_manager
	/// The mind that owns all the bodies.
	var/datum/mind/owner
	/// List of bodies in the slimeperson's "network".
	var/list/bodies = list()

/datum/slimeperson_manager/New(datum/mind/owner)
	if(!isnull(GLOB.slimeperson_managers[owner]))
		CRASH("Attempted to create a [type] for a mind that already has one!")
	src.owner = owner
	GLOB.slimeperson_managers[owner] = src

/datum/slimeperson_manager/Destroy(force)
	if(!force && !QDELETED(owner))
		. = QDEL_HINT_LETMELIVE
		CRASH("/datum/slimeperson_manager should not be deleted under most circumstances!")
	if(!isnull(owner))
		GLOB.slimeperson_managers -= owner
		owner = null
	bodies.Cut()
	return ..()

/datum/slimeperson_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SlimeBodySwapper", "Split Body")
		ui.open()

/datum/slimeperson_manager/ui_state(mob/user)
	return GLOB.always_state

/datum/slimeperson_manager/ui_host(mob/user)
	return owner?.current || ..()

/datum/slimeperson_manager/ui_data(mob/user)
	. = list("bodies" = list())
	for(var/mob/living/carbon/human/body as anything in bodies)
		if(QDELETED(body) || !isslimeperson(body))
			continue

		var/stat = "error"
		switch(body.stat)
			if(CONSCIOUS)
				stat = "Conscious"
			if(SOFT_CRIT to HARD_CRIT) // Also includes UNCONSCIOUS
				stat = "Unconscious"
			if(DEAD)
				stat = "Dead"

		var/occupied
		if(body == user)
			occupied = "owner"
		else if(body.mind?.active)
			occupied = "stranger"
		else
			occupied = "available"

		var/button
		if(occupied == "owner")
			button = "selected"
		else if(occupied == "stranger")
			button = "danger"
		else if(can_swap(body))
			button = null
		else
			button = "disabled"

		.["bodies"] += list(list(
			"htmlcolor" = body.dna.features[FEATURE_MUTANT_COLOR],
			"area" = get_area_name(body, TRUE),
			"status" = stat,
			"exoticblood" = body.get_blood_volume(),
			"name" = body.real_name || body.name,
			"ref" = REF(body),
			"occupied" = occupied,
			"swap_button_state" = button,
			"swappable" = (occupied == "available") && can_swap(body),
		))

/datum/slimeperson_manager/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("swap")
			var/mob/living/carbon/human/selected = locate(params["ref"]) in bodies
			if(can_swap(selected)) // these two procs have all the required sanity checks
				swap_to_dupe(selected)
			return TRUE

/datum/slimeperson_manager/proc/can_swap(mob/living/carbon/human/dupe)
	var/mob/living/carbon/human/owner = src.owner?.current

	if(QDELETED(dupe)) //Is there a body?
		remove_body(dupe)
		return FALSE

	if(!isslimeperson(owner))
		return FALSE

	if(!isslimeperson(dupe)) //Is it a slimeperson?
		remove_body(dupe)
		return FALSE

	if(dupe.stat != CONSCIOUS) //Is it awake?
		return FALSE

	if(dupe.mind?.active) //Is it unoccupied?
		return FALSE

	if(!(dupe in bodies)) //Do we actually own it?
		return FALSE

	return TRUE

/datum/slimeperson_manager/proc/swap_to_dupe(mob/living/carbon/human/dupe)
	if(!can_swap(dupe)) //sanity check
		return
	var/mob/living/current = owner.current
	if(current.stat == CONSCIOUS)
		current.visible_message(span_notice("[current] stops moving and starts staring vacantly into space."), span_notice("You stop moving this body..."))
	else
		to_chat(current, span_notice("You abandon this body..."))
	current.transfer_quirk_datums(dupe)
	owner.transfer_to(dupe)
	dupe.visible_message(span_notice("[dupe] blinks and looks around."), span_notice("...and move this one instead."))

/datum/slimeperson_manager/proc/add_body(mob/living/carbon/human/new_body)
	if(!isslimeperson(new_body) || QDELING(new_body))
		return FALSE
	if(new_body in bodies)
		return TRUE
	var/datum/species/jelly/slime/slime = new_body.dna.species
	if(slime.manager && slime.manager != src)
		slime.manager.remove_body(new_body)
	RegisterSignals(new_body, list(COMSIG_QDELETING, COMSIG_SPECIES_LOSS), PROC_REF(remove_body))
	bodies += new_body
	slime.needs_manager_update = FALSE
	slime.manager = src
	SStgui.update_uis(src)
	return TRUE

/datum/slimeperson_manager/proc/remove_body(mob/living/carbon/human/body)
	SIGNAL_HANDLER
	if(isnull(body) || !(body in bodies))
		return
	bodies -= body
	UnregisterSignal(body, list(COMSIG_QDELETING, COMSIG_SPECIES_LOSS))
	SStgui.update_uis(src)
	var/datum/species/jelly/slime/slime = astype(body.dna?.species)
	if(!slime)
		return
	if(slime.manager == src)
		slime.manager = null
	slime.needs_manager_update = FALSE

/datum/slimeperson_manager/proc/get_available_bodies()
	. = list()
	for(var/body in bodies)
		if(can_swap(body))
			. += body
