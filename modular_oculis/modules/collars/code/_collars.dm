// Basetype is actually a choker, but functionally it makes the most sense
/obj/item/clothing/neck/collar
	name = "choker"
	desc = "A little ring of cloth with a locking buckle sequestered on the back. Stylish - just \
		only under very specific conditions."
	worn_icon = 'modular_oculis/modules/collars/icons/mob/neck_collars.dmi'
	greyscale_colors = "#2d2d33"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/collar"
	post_init_icon_state = "thin_choker_real"
	greyscale_config = /datum/greyscale_config/thin_collar
	greyscale_config_worn = /datum/greyscale_config/thin_collar/worn
	obj_flags = parent_type::obj_flags | UNIQUE_RENAME
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	alternate_worn_layer = NONE
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = IS_PLAYER_COLORABLE_1
	interaction_flags_click = NEED_DEXTERITY

/obj/item/clothing/neck/collar/examine(mob/user)
	. = ..()
	. += span_notice("The collar can be worn above or below your suit. Alt-Right-click to toggle.")

/datum/storage/collar
	max_slots = 1
	max_specific_storage = WEIGHT_CLASS_SMALL
	do_rustle = FALSE
	attack_hand_interact = FALSE

/datum/storage/collar/New(atom/parent, max_slots, max_specific_storage, max_total_storage, list/holdables)
	. = ..()
	if(length(holdables))
		set_holdable(holdables)
		return

	set_holdable(list(
		/obj/item/food/cookie,
	))

/obj/item/clothing/neck/collar/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/collar)

/obj/item/clothing/neck/collar/click_alt_secondary(mob/user) //Adds a toggle to wear above or below suit slot items, for hiding it under a big coat or something :3
	alternate_worn_layer = (alternate_worn_layer == initial(alternate_worn_layer) ? LOW_NECK_LAYER : initial(alternate_worn_layer))
	user.update_clothing(ITEM_SLOT_NECK)
	balloon_alert(user, "wearing [alternate_worn_layer == initial(alternate_worn_layer) ? "above" : "below"] suits")
