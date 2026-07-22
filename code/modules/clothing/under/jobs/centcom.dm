/obj/item/clothing/under/rank/centcom
	icon = 'icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'icons/mob/clothing/under/centcom.dmi'
	abstract_type = /obj/item/clothing/under/rank/centcom

/obj/item/clothing/under/rank/centcom/commander
	name = "\improper SectCom commander's suit" // OCULIS EDIT, SectCommening 2, ORIGINAL: name = "\improper CentCom commander's suit"
	desc = "It's a suit worn by SectCom's highest-tier Commanders." // OCULIS EDIT, SectCommening 2, ORIGINAL: desc = "It's a suit worn by CentCom's highest-tier Commanders."
	icon_state = "centcom"
	inhand_icon_state = "dg_suit"

/obj/item/clothing/under/rank/centcom/official
	name = "\improper SectCom official's suit" // OCULIS EDIT, SectCommening 2, ORIGINAL: name = "\improper CentCom official's suit"
	desc = "A suit worn by SectCom Officials, with a silver belt buckle to indicate their rank from a glance." // OCULIS EDIT, SectCommening 2, ORIGINAL: desc = "A suit worn by CentCom Officials, with a silver belt buckle to indicate their rank from a glance."
	icon_state = "official"
	inhand_icon_state = "dg_suit"

/obj/item/clothing/under/rank/centcom/intern
	name = "\improper SectCom intern's jumpsuit" // OCULIS EDIT, SectCommening 2, ORIGINAL: name = "\improper CentCom intern's jumpsuit"
	desc = "It's a jumpsuit worn by those interning for SectCom. The top is styled after a polo shirt for easy identification." // OCULIS EDIT, SectCommening 2, ORIGINAL: desc = "It's a jumpsuit worn by those interning for CentCom. The top is styled after a polo shirt for easy identification."
	icon_state = "intern"
	inhand_icon_state = "dg_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/centcom/officer
	name = "\improper SectCom turtleneck suit" // OCULIS EDIT, SectCommening 2, ORIGINAL: name = "\improper CentCom turtleneck suit"
	desc = "A casual, yet refined green turtleneck, used by SectCom Officers. It has a fragrance of aloe." // OCULIS EDIT, SectCommening 2, ORIGINAL: desc = "A casual, yet refined green turtleneck, used by CentCom Officers. It has a fragrance of aloe."
	icon_state = "officer"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/centcom/officer/replica
	name = "\improper SectCom turtleneck replica" // OCULIS EDIT, SectCommening 2, ORIGINAL: name = "\improper CentCom turtleneck replica"
	desc = "A cheap copy of the SectCom turtleneck! A Donk Co. logo can be seen on the collar." // OCULIS EDIT, SectCommening 2, ORIGINAL: desc = "A cheap copy of the CentCom turtleneck! A Donk Co. logo can be seen on the collar."

/obj/item/clothing/under/rank/centcom/officer_skirt
	name = "\improper SectCom turtleneck skirt" // OCULIS EDIT, SectCommening 2, ORIGINAL: name = "\improper CentCom turtleneck skirt"
	desc = "A skirt version of the SectCom turtleneck, rarer and more sought after than the original." // OCULIS EDIT, SectCommening 2, ORIGINAL: desc = "A skirt version of the CentCom turtleneck, rarer and more sought after than the original."
	icon_state = "officer_skirt"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/centcom/officer_skirt/replica
	name = "\improper SectCom turtleneck skirt replica" // OCULIS EDIT, SectCommening 2, ORIGINAL: name = "\improper CentCom turtleneck skirt replica"
	desc = "A cheap copy of the SectCom turtleneck skirt! A Donk Co. logo can be seen on the collar." // OCULIS EDIT, SectCommening 2, ORIGINAL: desc = "A cheap copy of the CentCom turtleneck skirt! A Donk Co. logo can be seen on the collar."

/obj/item/clothing/under/rank/centcom/centcom_skirt
	name = "\improper SectCom commander's suitskirt" // OCULIS EDIT, SectCommening 2, ORIGINAL: name = "\improper CentCom commander's suitskirt"
	desc = "It's a suitskirt worn by SectCom's highest-tier Commanders." // OCULIS EDIT, SectCommening 2, ORIGINAL: desc = "It's a suitskirt worn by CentCom's highest-tier Commanders."
	icon_state = "centcom_skirt"
	inhand_icon_state = "dg_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/centcom/military
	name = "tactical combat uniform"
	desc = "A dark colored uniform worn by SectCom's conscripted military forces." // OCULIS EDIT, SectCommening 2, ORIGINAL: desc = "A dark colored uniform worn by CentCom's conscripted military forces."
	icon_state = "military"
	inhand_icon_state = "bl_suit"
	can_adjust = FALSE
	armor_type = /datum/armor/clothing_under/centcom_military

/datum/armor/clothing_under/centcom_military
	melee = 10
	fire = 50
	acid = 40
	wound = 10

/obj/item/clothing/under/rank/centcom/military/eng
	name = "tactical engineering uniform"
	desc = "A dark colored uniform worn by SectCom's regular military engineers." // OCULIS EDIT, SectCommening 2, ORIGINAL: desc = "A dark colored uniform worn by CentCom's regular military engineers."
	icon_state = "military_eng"
