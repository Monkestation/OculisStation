/obj/item/bodypart/head/arachnid
	icon_greyscale = 'modular_oculis/modules/arachnids/icons/bodyparts.dmi'
	limb_id = SPECIES_ARACHNID
	is_dimorphic = FALSE
	head_flags = HEAD_EYESPRITES | HEAD_EYEHOLES | HEAD_DEBRAIN | HEAD_EYECOLOR | HEAD_HAIR

/obj/item/bodypart/chest/arachnid
	icon_greyscale = 'modular_oculis/modules/arachnids/icons/bodyparts.dmi'
	limb_id = SPECIES_ARACHNID
	is_dimorphic = FALSE

/obj/item/bodypart/arm/left/arachnid
	icon_greyscale = 'modular_oculis/modules/arachnids/icons/bodyparts.dmi'
	limb_id = SPECIES_ARACHNID
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	unarmed_attack_verbs = list("slashed", "scratched", "clawed")
	grappled_attack_verb = "lacerate"
	grappled_attack_verb_continuous = "lacerates"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/arm/right/arachnid
	icon_greyscale = 'modular_oculis/modules/arachnids/icons/bodyparts.dmi'
	limb_id = SPECIES_ARACHNID
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	unarmed_attack_verbs = list("slashed", "scratched", "clawed")
	grappled_attack_verb = "lacerate"
	grappled_attack_verb_continuous = "lacerates"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/leg/left/arachnid
	icon_greyscale = 'modular_oculis/modules/arachnids/icons/bodyparts.dmi'
	limb_id = SPECIES_ARACHNID
	speed_modifier = -0.05

/obj/item/bodypart/leg/right/arachnid
	icon_greyscale = 'modular_oculis/modules/arachnids/icons/bodyparts.dmi'
	limb_id = SPECIES_ARACHNID
	speed_modifier = -0.05
