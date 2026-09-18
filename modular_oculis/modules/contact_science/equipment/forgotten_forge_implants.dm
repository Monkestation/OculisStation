/obj/item/brass_spear/implant
	name = "implanted brass spear"
	desc = "An ancient spear of brass emerging from your arm."

/obj/item/organ/cyberimp/arm/toolkit/clockwork_spear
	name = "brass spear implant"
	desc = "A tiny, trapped pocket dimension containing a brass spear, able to emerge and retract at will."
	items_to_create = list(/obj/item/brass_spear/implant)
	extend_sound = 'sound/items/unsheath.ogg'
	retract_sound = 'sound/items/sheath.ogg'

/obj/item/organ/cyberimp/arm/toolkit/clockwork_spear/left_arm
	zone = BODY_ZONE_L_ARM
	slot = ORGAN_SLOT_LEFT_ARM_AUG

/obj/item/organ/cyberimp/arm/toolkit/clockwork_spear/right_arm
	zone = BODY_ZONE_R_ARM
	slot = ORGAN_SLOT_RIGHT_ARM_AUG

/obj/item/organ/cyberimp/arm/toolkit/shell_launcher/clockwork
	name = "clockwork launch system implant"
	desc = "An odd, single-shot housing for a projectile cannon capable of firing either arrows or harpoons."
	items_to_create = list(/obj/item/gun/ballistic/shotgun/shell_launcher/clockwork)
	icon = 'modular_oculis/modules/contact_science/icons/implants.dmi'
	icon_state = "clock_cannon"
	zone = BODY_ZONE_R_ARM
	slot = ORGAN_SLOT_RIGHT_ARM_AUG

/obj/item/organ/cyberimp/arm/toolkit/shell_launcher/clockwork/l
	zone = BODY_ZONE_L_ARM
	slot = ORGAN_SLOT_LEFT_ARM_AUG

/obj/item/gun/ballistic/shotgun/shell_launcher/clockwork
	name = "clockwork launch system"
	desc = "A clockwork projectile cannon, for firing arrows or harpoons."
	initial_caliber = CALIBER_ARROW
	alternative_caliber = CALIBER_HARPOON
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/shell_cannon/clockwork
	icon = 'modular_oculis/modules/contact_science/icons/implants.dmi'
	icon_state = "clock_cannon_weapon"

/obj/item/ammo_box/magazine/internal/shot/shell_cannon/clockwork
	ammo_type = /obj/item/ammo_casing/harpoon
	caliber = CALIBER_HARPOON

/obj/item/organ/cyberimp/chest/clockwork_regen
	name = "clockwork regenerator"
	desc = "A strange spinal implant which continuously restores brute damage at the cost of stamina."
	slot = ORGAN_SLOT_SPINE
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'modular_oculis/modules/contact_science/icons/implants.dmi'
	icon_state = "clock_regen"

	var/regen_threshold = 20

/obj/item/organ/cyberimp/chest/clockwork_regen/on_life(seconds_per_tick)
	. = ..()

	if(owner.bruteloss > regen_threshold)
		owner.bruteloss -= 1
		owner.staminaloss += 1
