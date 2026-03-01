/obj/machinery/projector
	name = "projector"
	desc = "A projector for showing movies and such."
	icon = 'icons/obj/machines/stationary_camera.dmi'
	icon_state = "camera"
	var/enabled = FALSE

/obj/machinery/projector/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/redirect_attack_hand_from_turf)

/obj/machinery/projector/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_LMB] = enabled ? "Turn off" : "Turn on"
		return CONTEXTUAL_SCREENTIP_SET
	return .

/obj/machinery/projector/update_icon_state()
	//icon_state = enabled ? "projector-on" : "projector-off"
	return ..()

/obj/machinery/projector/examine(mob/user)
	. = ..()
	. += "It is [(machine_stat & NOPOWER) ? "unpowered" : (enabled ? "on" : "off")]."

/obj/machinery/projector/interact(mob/user)
	. = ..()
	enabled = !enabled
	playsound(src, 'modular_iris/modules/emotes/sound/synth_voice/synth_click.ogg', 100, TRUE)
	update_icon_state()

