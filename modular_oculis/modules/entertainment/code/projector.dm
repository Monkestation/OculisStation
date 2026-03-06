/obj/machinery/projector
	name = "projector"
	desc = "A projector for showing movies and such."
	icon = 'modular_oculis/modules/entertainment/icons/projector.dmi'
	base_icon_state = "projector"
	icon_state = "projector-off"
	var/enabled = FALSE

/obj/machinery/projector/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/redirect_attack_hand_from_turf)
	register_context()

/obj/machinery/projector/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_LMB] = enabled ? "Turn off" : "Turn on"
		context[SCREENTIP_CONTEXT_RMB] = "Next Slide"
		return CONTEXTUAL_SCREENTIP_SET
	return .

/obj/machinery/projector/update_icon_state()
	icon_state = "[base_icon_state][enabled ? "-active" : "-off"]"
	return ..()

/obj/machinery/projector/examine(mob/user)
	. = ..()
	. += "It is [(machine_stat & NOPOWER) ? "unpowered" : (enabled ? "on" : "off")]."

/obj/machinery/projector/proc/update_projector_screen()
	update_icon_state()

/obj/machinery/projector/interact(mob/user)
	. = ..()
	enabled = !enabled
	playsound(src, 'modular_iris/modules/emotes/sound/synth_voice/synth_click.ogg', 100, TRUE)
	balloon_alert_to_viewers("click!")
	addtimer(CALLBACK(src, PROC_REF(update_projector_screen)), 1 SECONDS)
	return TRUE

/obj/machinery/projector/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	balloon_alert_to_viewers("click!")
	icon_state = "[base_icon_state]-on"
	addtimer(CALLBACK(src, PROC_REF(update_projector_screen)), 1 SECONDS)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
