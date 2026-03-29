//-------------------
// Security Hardsuit
//-------------------
/obj/item/clothing/suit/space/hardsuit/sec
	name = "security hardsuit"
	desc = "A special suit designed for work in a hazardous, low pressure environment. Has an additional layer of armor."
	icon_state = "hardsuit-sec"
	armor_type = /datum/armor/hardsuit/sec
	hardsuit_helmet = /obj/item/clothing/head/helmet/space/hardsuit/sec
	allowed = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/tank/jetpack,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/storage/belt/holster/detective,
		/obj/item/storage/belt/holster/nukie,
		/obj/item/storage/belt/holster/energy,
		/obj/item/clothing/mask/breath/,
	)

/obj/item/clothing/head/helmet/space/hardsuit/sec
	name = "security hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low-pressure environment. Has an additional layer of armor."
	icon_state = "hardsuit0-sec"
	armor_type = /datum/armor/hardsuit/sec
	hardsuit_type = "sec"

/obj/item/clothing/head/helmet/space/hardsuit/sec/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == ITEM_SLOT_HEAD)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
		DHUD.show_to(user)

/obj/item/clothing/head/helmet/space/hardsuit/sec/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
		DHUD.hide_from(user)

/obj/item/clothing/head/helmet/space/hardsuit/security/hos
	name = "head of security's hardsuit helmet"
	desc = "A special bulky helmet designed for work in a hazardous, low pressure environment. Has an additional layer of armor."
	icon_state = "hardsuit0-hos"
	hardsuit_type = "hos"
	armor_type = /datum/armor/hardsuit/sec/hos


/obj/item/clothing/suit/space/hardsuit/security/hos
	icon_state = "hardsuit-hos"
	name = "head of security's hardsuit"
	desc = "A special bulky suit that protects against hazardous, low pressure environments. Has an additional layer of armor."
	armor_type = /datum/armor/hardsuit/sec/hos
	hardsuit_helmet = /obj/item/clothing/head/helmet/space/hardsuit/security/hos
//	/obj/item/tank/jetpack/attached_jetpack = /obj/item/tank/jetpack/suit
	cell = /obj/item/stock_parts/power_store/cell/super

