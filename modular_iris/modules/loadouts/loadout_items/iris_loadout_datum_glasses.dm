/datum/loadout_item/glasses/prescription_glasses/transparent
	name = "Transparent Glasses"
	item_path = /obj/item/clothing/glasses/regular/transparent
	group = "Prescription"

/datum/loadout_item/glasses/prescription_glasses/circle_glasses/transparent
	name = "Transparent Circle Glasses"
	item_path = /obj/item/clothing/glasses/regular/circle/transparent
	group = "Prescription"

/datum/loadout_item/glasses/prescription_glasses/thin/transparent
	name = "Transparent Thin Glasses"
	item_path = /obj/item/clothing/glasses/regular/thin/transparent
	group = "Prescription"

/datum/loadout_item/glasses/hud/stealing/get_item_information()
	. = ..()
	.[FA_ICON_LINK] = "Takes in properties of other glasses!"

/datum/loadout_item/glasses/hud/stealing/techno_visor
	name = "Techno-Visor"
	item_path = /obj/item/clothing/glasses/techno_visor
