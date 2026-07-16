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

/obj/item/ear_trumpet/Initialize(mapload)
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_POST_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))

/obj/item/ear_trumpet/attack_self(mob/user, modifiers)
	. = ..()
	user.visible_message(span_notice("[user] holds [src] up to their ears."), span_notice("You hold [src] up to your ears."))
	ADD_TRAIT(user, TRAIT_GOOD_HEARING, "eartrumpet")
	while(do_after(user, 1 SECOND, target = src, timed_action_flags = IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE, hidden = TRUE))
	REMOVE_TRAIT(user, TRAIT_GOOD_HEARING, "eartrumpet")

/datum/design/ear_trumpet
	name = "Ear Trumpet"
	id = "eartrumpet"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/ear_trumpet
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/techweb_node/office_equip/New()
	design_ids += list(
		"eartrumpet",
	)
	return ..()
