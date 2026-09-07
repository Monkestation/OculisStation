/obj/item/slime_rancher_scanner
	name = "slime scanner"
	desc = "A device that analyzes a slime's internal composition and measures its stats. \
		Keeps a lock on the last slime you pointed it at."
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "slime_scanner"
	inhand_icon_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NOBLUDGEON
	obj_flags = CONDUCTS_ELECTRICITY
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	/// The slime we're currently locked onto, so the panel keeps updating as it eats
	var/datum/weakref/scanned_slime_ref

/obj/item/slime_rancher_scanner/Initialize(mapload)
	. = ..()
	register_item_context()

/obj/item/slime_rancher_scanner/Destroy(force)
	scanned_slime_ref = null
	return ..()

/obj/item/slime_rancher_scanner/add_item_context(obj/item/source, list/context, atom/target, mob/living/user)
	if(!isslime(target))
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = "Scan slime"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/slime_rancher_scanner/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	if(!user.can_read(src))
		return ITEM_INTERACT_BLOCKING
	if(!isslime(interacting_with))
		to_chat(user, span_warning("This device can only scan slimes!"))
		return ITEM_INTERACT_BLOCKING

	scanned_slime_ref = WEAKREF(interacting_with)
	playsound(src, SFX_INDUSTRIAL_SCAN, 20, TRUE, -2, TRUE, FALSE)
	ui_interact(user)
	return ITEM_INTERACT_SUCCESS

/// the whole point of a ranching scanner is watching the pen from outside it, so let it reach
/obj/item/slime_rancher_scanner/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return interact_with_atom(interacting_with, user, modifiers)

/obj/item/slime_rancher_scanner/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SlimeRancherScanner", name)
		ui.open()

/obj/item/slime_rancher_scanner/ui_data(mob/user)
	var/mob/living/basic/slime/slime = scanned_slime_ref?.resolve()
	if(isnull(slime))
		scanned_slime_ref = null
		return list("scanned" = FALSE)

	var/sprite_icon = get_icon_dmi_path(slime)
	var/list/data = list(
		"scanned" = TRUE,
		"name" = slime.name,
		"color" = slime.slime_type.colour,
		"color_hex" = slime.slime_type.rgb_code,
		"sprite_icon" = sprite_icon,
		"sprite_state" = slime.icon_state,
		// the face is a separate overlay, so the panel stacks it on top of the body itself
		"mood_state" = (!slime.stat && slime.current_mood && slime.current_mood != SLIME_MOOD_NONE) ? "aslime-[slime.current_mood]" : null,
		"transparent" = slime.slime_type.transparent,
		"life_stage" = slime.life_stage,
		"health" = round(slime.health, 1),
		"max_health" = slime.maxHealth,
		"nutrition" = floor(slime.nutrition),
		"powerlevel" = slime.powerlevel,
		"cores" = slime.cores,
		"growth" = slime.amount_grown,
		"mutation_chance" = slime.mutation_chance,
		"crossbreed_modification" = slime.crossbreed_modification,
		"crossbreed_progress" = slime.applied_crossbreed_amount,
		"mutations" = list(),
	)

	for(var/datum/slime_mutation/mutation as anything in slime.mutation_progress)
		data["mutations"] += list(mutation_data(mutation))

	return data

// ui static data so we don't have to hardcode these on the tgui side of things
/obj/item/slime_rancher_scanner/ui_static_data(mob/user)
	return list(
		"max_growth" = SLIME_EVOLUTION_THRESHOLD,
		"max_crossbreed_progress" = SLIME_EXTRACT_CROSSING_REQUIRED,
		"max_powerlevel" = SLIME_MAX_POWER,
		"max_nutrition" = SLIME_MAX_NUTRITION,
		"nutrition_starving" = SLIME_STARVE_NUTRITION,
		"nutrition_hungry" = SLIME_HUNGER_NUTRITION,
	)

/obj/item/slime_rancher_scanner/proc/mutation_data(datum/slime_mutation/mutation) as /list
	var/datum/slime_type/target = mutation.mutates_into
	var/list/entry = list(
		"color" = target::colour,
		"color_hex" = target::rgb_code,
		"ready" = mutation.is_satisfied(),
		"items" = list(),
		"drains" = list(),
	)

	for(var/obj/item/wanted as anything in mutation.total_items)
		entry["items"] += list(list(
			"name" = wanted::name,
			"icon" = wanted::icon,
			"icon_state" = wanted::icon_state,
			"done" = !(wanted in mutation.needed_items),
		))

	for(var/prey_type, drain_total in mutation.latch_totals)
		var/mob/living/prey = prey_type
		entry["drains"] += list(list(
			"name" = prey::name,
			"icon" = prey::icon,
			"icon_state" = prey::icon_state,
			"total" = drain_total,
			"drained" = drain_total - (mutation.latch_needed[prey_type] || 0),
		))

	return entry

// any old slime scanner that's mapped in gets replaced with the new one
/obj/item/slime_scanner/Initialize(mapload)
	. = ..()
	if(mapload)
		var/obj/item/slime_rancher_scanner/new_scanner = new(loc)
		// also ensure it's positioned the same
		new_scanner.pixel_x = pixel_x
		new_scanner.pixel_y = pixel_y
		new_scanner.pixel_w = pixel_w
		new_scanner.pixel_z = pixel_z
		return INITIALIZE_HINT_QDEL
