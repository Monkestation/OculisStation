
/obj/item/circuitboard/machine/infuser
	name = "Plant Chemical Infuser (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/infuser
	req_components = list(
		/datum/stock_part/servo = 1,
	)


/obj/machinery/infuser
	name = "Plant Chemical Infuser"
	desc = "Infuses seeds with chemicals."
	icon = 'modular_oculis/modules/hydroponics/icons/infuser.dmi'
	base_icon_state = "infuser"
	icon_state = "infuser"
	circuit = /obj/item/circuitboard/machine/infuser
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 0.5
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.5

	var/obj/item/seeds/seed
	var/obj/item/reagent_containers/cup/beaker/held_beaker
	var/working = FALSE
	var/work_timer = null
	var/potential_damage = 0
	var/list/stats = list()

/obj/machinery/infuser/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/seeds))
		if(seed)
			balloon_alert(user, "seed slot occupied!")
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		seed = tool
		balloon_alert(user, "seed inserted")
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/reagent_containers/cup/beaker))
		if(held_beaker)
			balloon_alert(user, "beaker slot occupied!")
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		held_beaker = tool
		balloon_alert(user, "beaker inserted")
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/machinery/infuser/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/infuser/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!.)
		return default_deconstruction_screwdriver(user, base_icon_state, base_icon_state, tool)

/obj/machinery/infuser/crowbar_act(mob/living/user, obj/item/tool)
	if(default_deconstruction_crowbar(tool))
		return TRUE

/obj/machinery/infuser/update_icon_state()
	. = ..()
	if(machine_stat & BROKEN)
		icon_state = "[base_icon_state]_broken"
	else if((machine_stat & NOPOWER) || !anchored)
		icon_state = "[base_icon_state]_off"
	else if(working)
		icon_state = "[base_icon_state]_working"
	else
		icon_state = "[base_icon_state]"

/obj/machinery/infuser/update_overlays()
	. = ..()
	if(panel_open)
		. += "[base_icon_state]_open"

/obj/machinery/infuser/set_anchored(anchorvalue)
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/machinery/infuser/on_set_panel_open(old_value)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/infuser/ui_data(mob/user)
	. = ..()

	var/has_seed = FALSE
	var/has_beaker = FALSE
	var/list/data = list()

	if(seed)
		data["seed"] = list(seed.return_all_data())
		has_seed = TRUE
		data["damage_taken"] = seed.infusion_damage
		data["potential_damage"] = potential_damage
		data["combined_damage"] = (potential_damage + seed.infusion_damage)
	if(held_beaker)
		data["held_beaker"] = held_beaker.reagents
		has_beaker = TRUE


	data["has_seed"] = has_seed
	data["held_beaker"] = has_beaker

	data["working"] = working

	data["timeleft"] = work_timer ? timeleft(work_timer) : null

	return data

/obj/machinery/infuser/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BotanyInfuser", name)
		ui.set_autoupdate(TRUE)
		ui.open()

/obj/machinery/infuser/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("eject_seed")
			eject_seed(seed)
			seed = null
			return TRUE
		if("eject_beaker")
			eject_beaker(held_beaker)
			return TRUE
		if("infuse")
			infuse()
			return TRUE

/obj/machinery/infuser/proc/eject_seed(obj/item/seeds/ejected_seed)
	if (ejected_seed)
		if(Adjacent(usr) && !HAS_SILICON_ACCESS(usr))
			if (!usr.put_in_hands(ejected_seed))
				ejected_seed.forceMove(drop_location())
		else
			ejected_seed.forceMove(drop_location())
		. = TRUE

/obj/machinery/infuser/proc/eject_beaker()
	if (held_beaker)
		if(Adjacent(usr) && !HAS_SILICON_ACCESS(usr))
			if (!usr.put_in_hands(held_beaker))
				held_beaker.forceMove(drop_location())
		else
			held_beaker.forceMove(drop_location())
		held_beaker = null
		potential_damage = 0
		. = TRUE



/obj/machinery/infuser/proc/calculate_stats_for_infusion()
	if(!held_beaker)
		return

	var/list/total_stats = list(
		"potency_change" = 0,
		"yield_change" = 0,
		"endurance_change" = 0,
		"lifespan_change" = 0,
		"weed_chance_change" = 0,
		"weed_rate_change" = 0,
		"production_change" = 0,
		"maturation_change" = 0,
		"damage" = 0,
	)
	for(var/reagent in held_beaker.reagents.reagent_list)
		var/datum/reagent/listed_reagent = reagent
		total_stats += listed_reagent.generate_infusion_values(held_beaker.reagents)
	stats = total_stats
	potential_damage = stats["damage"]


/obj/machinery/infuser/proc/infuse()
	if(isnull(held_beaker) || isnull(seed)) /// Checks if we have a beaker and a seed to infuse
		return

	if(apply_infusion_damage())
		held_beaker.reagents.remove_all(held_beaker.reagents.total_volume)
		return

	if(isnull(held_beaker.reagents) || !length(held_beaker.reagents.reagent_list))
		to_chat(usr, span_warning("The beaker is empty! Nothing to infuse."))
		return

	for(var/datum/reagent/reagent_instance in held_beaker.reagents.reagent_list.Copy())
		try_infuse_reagent(reagent_instance)

	seed.reagents_from_genes()
	held_beaker.reagents.remove_all(held_beaker.reagents.total_volume)
	potential_damage = 0
	to_chat(usr, span_notice("[seed] infusion process complete."))

/obj/machinery/infuser/proc/apply_infusion_damage()
	potential_damage = held_beaker.reagents.total_volume / 10 /// Every 10 units of reagents in the beaker will cause 1 damage to the seed.
	seed.infusion_damage += min(potential_damage, 100 - seed.infusion_damage)

	/// If the seed has taken too much damage, it gets deleted and passes TRUE for early return. Otherwise return FALSE.
	if(seed.infusion_damage < 100)
		return FALSE

	to_chat(usr, span_warning("[seed] has become too damaged from infusion and disintegrated!"))
	qdel(seed)
	seed = null
	stats = list()
	potential_damage = 0
	return TRUE

/obj/machinery/infuser/proc/try_infuse_reagent(datum/reagent/reagent_instance)
	if(!(reagent_instance.chemical_flags & REAGENT_CAN_BE_SYNTHESIZED))
		to_chat(usr, span_warning("[reagent_instance.name] cannot be infused into plants!"))
		return

	if(reagent_instance.volume <= 0)
		return

	if(reagent_instance.volume < 100)
		to_chat(usr, span_notice("Attempted to infuse [reagent_instance.name] into [seed], but it failed. Infusion requires a volume of 100 units."))
		return

	var/random_rate = rand(3, 25) / 100

	var/datum/plant_gene/reagent/existing_gene
	for(var/datum/plant_gene/reagent/reagent_gene in seed.genes)
		if(reagent_gene.reagent_id != reagent_instance.type)
			continue
		existing_gene = reagent_gene
		break

	if(existing_gene)
		/// Add to existing gene's rate
		var/old_rate = round(existing_gene.rate * 100)
		existing_gene.rate += random_rate
		to_chat(usr, span_notice("Increased [reagent_instance.name] rate in [seed] from [old_rate]% to [old_rate + round(random_rate * 100)]%."))
		return

	/// Create a new gene with the random rate
	var/datum/plant_gene/reagent/new_gene = new(reagent_instance.type, random_rate)
	/// Skips adding the gene mutation if it failed to add
	if(!new_gene.can_add(seed))
		to_chat(usr, span_warning("Could not add new gene for [reagent_instance.name] to [seed]."))
		qdel(new_gene)
		return

	seed.genes += new_gene
	to_chat(usr, span_notice("Successfully infused [reagent_instance.name] into [seed] with a rate of [round(new_gene.rate * 100)]%."))
