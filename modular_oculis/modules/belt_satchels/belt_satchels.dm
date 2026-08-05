/obj/item/storage/backpack
	var/satchel_movespeed_modifier = PAIRED_STORAGE_DEFAULT_SLOWDOWN

/obj/item/storage/backpack/proc/check_belt_satchel(mob/user)
	if(QDELETED(user))
		return
	user.remove_movespeed_modifier(/datum/movespeed_modifier/belt_satchel, update = FALSE)
	var/obj/item/storage/backpack/back_item = user.get_item_by_slot(ITEM_SLOT_BACK)
	var/obj/item/storage/backpack/belt_item = user.get_item_by_slot(ITEM_SLOT_BELT)
	if(istype(back_item) && istype(belt_item))
		// Min is used here instead of max because Monke had standout lighter bags but no extra-heavy ones
		user.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/belt_satchel, TRUE, min(back_item.satchel_movespeed_modifier, belt_item.satchel_movespeed_modifier))
	else
		user.update_movespeed()

/datum/movespeed_modifier/belt_satchel
	variable = TRUE

/obj/item/storage/backpack/duffelbag/deforest_medkit
	satchel_movespeed_modifier = PAIRED_STORAGE_NO_SLOWDOWN

/obj/item/storage/backpack/duffelbag/deforest_surgical
	satchel_movespeed_modifier = PAIRED_STORAGE_NO_SLOWDOWN

/obj/item/storage/backpack/duffelbag/deforest_paramedic
	satchel_movespeed_modifier = PAIRED_STORAGE_NO_SLOWDOWN
