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
		/obj/item/gun/microfusion,
		/obj/item/knife/combat,
		/obj/item/melee/baton,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/storage/belt/holster/detective,
		/obj/item/storage/belt/holster/nukie,
		/obj/item/storage/belt/holster/energy,
		/obj/item/clothing/mask/breath/sec_bandana,
	)

/obj/item/clothing/head/helmet/space/hardsuit/sec
	name = "security hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low-pressure environment. Has an additional layer of armor."
	icon_state = "hardsuit0-sec"
	armor_type = /datum/armor/hardsuit/sec
	hardsuit_type = "sec"

/obj/item/clothing/head/helmet/space/hardsuit/sec/New(loc, ...)
	. = ..()
	hud_glasses = new /obj/item/clothing/glasses/hud/security(src)

	/obj/item/clothing/head/helmet/space/hardsuit/security/hos
	name = "head of security's hardsuit helmet"
	desc = "A special bulky helmet designed for work in a hazardous, low pressure environment. Has an additional layer of armor."
	icon_state = "hardsuit0-hos"
	hardsuit_type = "hos"
	armor = list(MELEE = 45, BULLET = 25, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 100, FIRE = 95, ACID = 95, WOUND = 25)


/obj/item/clothing/suit/space/hardsuit/security/hos
	icon_state = "hardsuit-hos"
	name = "head of security's hardsuit"
	desc = "A special bulky suit that protects against hazardous, low pressure environments. Has an additional layer of armor."
	armor = list(MELEE = 45, BULLET = 25, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 100, FIRE = 95, ACID = 95, WOUND = 25)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/hos
	jetpack = /obj/item/tank/jetpack/suit
	cell = /obj/item/stock_parts/cell/super

