/obj/item/radio/headset/headset_cent/sectorial_commander
	name = "\improper CentCom headset"
	desc = "A headset used by the upper echelons of Nanotrasen."
	icon_state = "cent_headset"
	worn_icon_state = "cent_headset"
	keyslot = /obj/item/encryptionkey/headset_cent
	keyslot2 = /obj/item/encryptionkey/headset_com
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/encryptionkey/castor
	name = "\improper CentCom radio encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/headset_cent"
	post_init_icon_state = "cypherkey_centcom"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(RADIO_CHANNEL_CENTCOM = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_centcom
	greyscale_colors = "#24a157#dca01b"

/obj/item/encryptionkey/castor
	name = "\proper castor's encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/binary"
	post_init_icon_state = "cypherkey_cube"
	channels = list(
		RADIO_CHANNEL_COMMAND = 1,
		RADIO_CHANNEL_CENTCOM = 1,
		)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2c9327#331bdc"

/**
	channels = list(
		RADIO_CHANNEL_COMMAND = 1,
		RADIO_CHANNEL_SECURITY = 1,
		RADIO_CHANNEL_ENGINEERING = 1,
		RADIO_CHANNEL_SCIENCE = 1,
		RADIO_CHANNEL_MEDICAL = 1,
		RADIO_CHANNEL_SUPPLY = 1,
		RADIO_CHANNEL_SERVICE = 1,
		)
 */
