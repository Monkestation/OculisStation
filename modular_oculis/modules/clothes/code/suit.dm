// Port of the high-visibility hazard jacket from Pentest/Shiptest https://github.com/PentestSS13/Pentest/ with added emissives
/obj/item/clothing/suit/toggle/jacket/pilot_hi_vis
	name = "high-visibility pilot jacket"
	desc = "A highlighter-yellow jacket with reflective stripes. These ones are usually worn by cargo ship pilots of the frontier and the settled sectors."
	icon = 'modular_oculis/modules/clothes/icons/obj/suit.dmi'
	icon_state = "jacket_hazard"
	worn_icon = 'modular_oculis/modules/clothes/icons/mob/suit.dmi'
	post_init_icon_state = "jacket_hazard"
	armor_type = /datum/armor/colonist_clothing
	resistance_flags = FIRE_PROOF
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|ARMS
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	slot_flags = ITEM_SLOT_OCLOTHING
	toggle_noun = "zipper"


/obj/item/clothing/suit/toggle/jacket/pilot_hi_vis/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/toggle/jacket/pilot_hi_vis/Initialize(mapload)
	. = ..()
	allowed += GLOB.colonist_suit_allowed
