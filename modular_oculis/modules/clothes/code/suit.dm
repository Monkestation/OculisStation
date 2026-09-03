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
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/jacket/pilot_hi_vis/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/toggle/jacket/pilot_hi_vis/Initialize(mapload)
	. = ..()
	allowed += GLOB.colonist_suit_allowed

//Port of the dusters from Shiptest https://github.com/shiptest-ss13/Shiptest/

/obj/item/clothing/suit/leather_duster
	name = "leather duster"
	desc = "A long, utilitarian leather coat. Ideal for protecting its wearer from rain, sun, and dust. Especially popular among the ship crews of the frontier."
	icon = 'modular_oculis/modules/clothes/icons/obj/suit.dmi'
	icon_state = "duster"
	worn_icon = 'modular_oculis/modules/clothes/icons/mob/suit.dmi'
	heat_protection = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|ARMS|LEGS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/watermelon_fr

/obj/item/clothing/suit/leather_duster/black
	name = "black leather duster"
	icon_state = "duster_black"

/obj/item/clothing/suit/leather_duster/command
	name = "officer's duster"
	desc = "A long, supple leather coat. Ideal for protecting its wearer from rain, sun, dust, and paperwork. Especially popular among the ship crews of the frontier."
	icon_state = "duster_command"
	armor_type = /datum/armor/barrelmelon_fr
