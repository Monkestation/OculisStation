/obj/item/ear_trumpet
	name = "ear trumpet"
	desc = "A trumpet you hold up to your ear to hear better."
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "megaphone"
	inhand_icon_state = "megaphone"
	lefthand_file = 'icons/mob/inhands/items/megaphone_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/megaphone_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	color = COLOR_THEME_CLOCKWORK

/obj/item/ear_trumpet/attack_self(mob/user, modifiers)
	. = ..()
	user.visible_message(span_notice("[user] holds [src] up to their ears."), span_notice("You hold [src] up to your ears."))
