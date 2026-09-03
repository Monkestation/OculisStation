/obj/item/weaponcrafting/kielbasa_kit
	name = "\"Kielbasa\" weapon conversion kit"
	desc = "Convert your Kibokos into much more practical Kielbasas. Also contains magazine conversion materials."
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "kitsuitcase"

/obj/item/gun/ballistic/automatic/sol_grenade_launcher/kielbasa
	name = "Kielbasa Grenade Launcher"
	desc = /obj/item/gun/ballistic/automatic/sol_grenade_launcher::name + " This one seems to have been modified to accept magazines full of sausages instead of grenades."
	accepted_magazine_type = /obj/item/ammo_box/magazine/c980_sausage

/obj/item/ammo_box/magazine/c980_sausage
	name = "\improper Kielbasa grenade box"
	desc = "A standard size box for .980 sausages, holds four of them."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/ammo.dmi'
	icon_state = "granata_standard"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_SMALL

	ammo_type = /obj/item/ammo_casing/c980sausage
	caliber = CALIBER_980TYDHOUER
	max_ammo = 4

obj/item/ammo_box/magazine/c980_sausage/drum
	name = "\improper Kielbasa grenade drum"
	desc = "A drum for .980 sausages, holds six of them."

	icon_state = "granata_drum"

	w_class = WEIGHT_CLASS_NORMAL

	max_ammo = 6

/obj/item/ammo_box/magazine/ammo_stack/c980sausage
	name = ".980 Sausages"
	desc = "A stack of .980 sausages."
	caliber = CALIBER_980TYDHOUER
	ammo_type = /obj/item/ammo_casing/c980sausage
	casing_phrasing = "sausage"
	max_ammo = 6
	casing_w_spacing = 3
	casing_z_padding = 9

/obj/item/ammo_casing/c980sausage
	name = ".980 Sausage"
	desc = "A large sausage that deals stamina damage and is a sausage."

	icon = 'icons/obj/food/meat.dmi'
	icon_state = "sausage"

	caliber = CALIBER_980TYDHOUER
	projectile_type = /obj/projectile/bullet/sausage

	custom_materials = AMMO_MATS_GRENADE

	harmful = FALSE //Erm, technically
	ammo_categories = AMMO_CLASS_NONE
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/c980sausage

/obj/projectile/bullet/sausage
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "sausage"
	name = ".980 Sausage"
	damage = 0
	stamina = 30
	range = 14
	speed = 1
	sharpness = NONE
