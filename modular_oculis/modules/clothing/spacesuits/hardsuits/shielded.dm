/obj/item/clothing/suit/space/hardsuit/shielded
	name = "shielded hardsuit"
	desc = "A hardsuit with built in energy shielding. Will rapidly recharge when not under fire."
	icon_state = "hardsuit-hos"
	hardsuit_helmet = /obj/item/clothing/head/helmet/space/hardsuit/security/hos
	allowed = null
	armor = list(MELEE = 30, BULLET = 15, LASER = 30, ENERGY = 40, BOMB = 10, BIO = 100, FIRE = 100, ACID = 100, WOUND = 15)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/space/hardsuit/shielded/Initialize(mapload)
	AddComponent(/datum/component/shielded, max_charges = 3, recharge_start_delay = 20 SECONDS, charge_increment_delay = 1 SECONDS, charge_recovery = 1, lose_multiple_charges = FALSE, shield_icon = "shield-old")

/obj/item/clothing/head/helmet/space/hardsuit/shielded
	resistance_flags = FIRE_PROOF | ACID_PROOF

//////Syndicate Version
/obj/item/clothing/suit/space/hardsuit/shielded/syndi
	name = "blood-red hardsuit"
	desc = "An advanced hardsuit with built in energy shielding."
	icon_state = "hardsuit1-syndi"
	inhand_icon_state = "syndie_hardsuit"
	hardsuit_type = "syndi"
	armor = list(MELEE = 40, BULLET = 50, LASER = 30, ENERGY = 40, BOMB = 35, BIO = 100, FIRE = 100, ACID = 100, WOUND = 30)
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	hardsuit_helmet = /obj/item/clothing/head/helmet/space/hardsuit/shielded/syndi
	slowdown = 0
	jetpack = /obj/item/tank/jetpack/suit

/obj/item/clothing/suit/space/hardsuit/shielded/syndi/Initialize(mapload)
	AddComponent(/datum/component/shielded, max_charges = 3, recharge_start_delay = 20 SECONDS, charge_increment_delay = 1 SECONDS, charge_recovery = 1, lose_multiple_charges = FALSE, shield_icon = "shield-red")

/obj/item/clothing/head/helmet/space/hardsuit/shielded/syndi
	name = "blood-red hardsuit helmet"
	desc = "An advanced hardsuit helmet with built in energy shielding."
	icon_state = "hardsuit1-syndi"
	inhand_icon_state = "syndie_helm"
	hardsuit_type = "syndi"
	armor = list(MELEE = 40, BULLET = 50, LASER = 30, ENERGY = 40, BOMB = 35, BIO = 100, FIRE = 100, ACID = 100, WOUND = 30)
