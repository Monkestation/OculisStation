/obj/item/mod/control/pre_equipped/abel
	worn_icon = 'modular_oculis/modules/abel/icons/mod_clothing_worn.dmi'
	icon = 'modular_oculis/modules/abel/icons/mod_clothing.dmi'
	icon_state = "abel-control"
	theme = /datum/mod_theme/abel
	applied_modules = list(
		/obj/item/mod/module/storage/bluespace,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/megaphone,
	)

/datum/mod_theme/abel
	name = "abel"
	desc = "It feels warm to the touch."
	extended_desc = "<span class='danger>It faintly twitches in your hand.</span>"

	default_skin = "abel"
	armor_type = /datum/armor/mod_theme_security
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	charge_drain = NONE
	slowdown_deployed = 0.5
	allowed_suit_storage = list(
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	variants = list(
		"abel" = list(
			MOD_ICON_OVERRIDE = 'modular_oculis/modules/abel/icons/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_oculis/modules/abel/icons/mod_clothing_worn.dmi',
			MOD_DIGITIGRADE_ICON_OVERRIDE = 'modular_oculis/modules/abel/icons/mod_clothing_worn_mutant.dmi',
			MOD_SNOUT_ICON_OVERRIDE = 'modular_oculis/modules/abel/icons/mod_clothing_worn_mutant.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|HEADINTERNALS,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)
