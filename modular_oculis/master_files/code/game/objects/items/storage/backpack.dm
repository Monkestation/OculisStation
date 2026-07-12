/obj/item/storage/backpack/equipped(mob/user, slot, initial)
	. = ..()
	check_belt_satchel(user)

/obj/item/storage/backpack/dropped(mob/user, silent)
	. = ..()
	check_belt_satchel(user)

/obj/item/storage/backpack/satchel
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT

/obj/item/storage/backpack/satchel/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = 18
