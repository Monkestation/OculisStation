/obj/item/encryptionkey/castor
	name = "\improper Castor radio encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/headset_cent"
	post_init_icon_state = "cypherkey_centcom"
	special_channels = RADIO_SPECIAL_CENTCOM
	channels = list(
		RADIO_CHANNEL_CENTCOM = 1,
		)
	greyscale_config = /datum/greyscale_config/encryptionkey_centcom
	greyscale_colors = "#24a157#dca01b"

///////////////////////////////////////////////////////////////////////////////////

/obj/item/radio/headset/headset_cent/sectorial_commander
	name = "\improper sectorial commander's headset"
	desc = "A headset used by the upper echelons of Castor."
	icon_state = "cent_headset"
	worn_icon_state = "cent_headset"
	keyslot = /obj/item/encryptionkey/castor/sectorial_commander
	keyslot2 = null
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/encryptionkey/castor/sectorial_commander
	name = "\proper sectorial commander's encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/binary"
	post_init_icon_state = "cypherkey_cube"
	channels = list(
		RADIO_CHANNEL_CENTCOM = 1,
		RADIO_CHANNEL_COMMAND = 1,
		RADIO_CHANNEL_SECURITY = 1,
		RADIO_CHANNEL_ENGINEERING = 1,
		RADIO_CHANNEL_SCIENCE = 1,
		RADIO_CHANNEL_MEDICAL = 1,
		RADIO_CHANNEL_SUPPLY = 1,
		RADIO_CHANNEL_SERVICE = 1,
		)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2c9327#331bdc"

///////////////////////////////////////////////////////////////////////////////////

/obj/item/radio/headset/headset_cent/sectorial_personnel_administrator
	name = "\improper sectorial personnel administrator's headset"
	desc = "A headset used by the upper echelons of Castor."
	icon_state = "cent_headset"
	worn_icon_state = "cent_headset"
	keyslot = /obj/item/encryptionkey/castor/sectorial_personnel_administrator
	keyslot2 = null
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/encryptionkey/castor/sectorial_personnel_administrator
	name = "\proper sectorial personnel administrator's encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/binary"
	post_init_icon_state = "cypherkey_cube"
	channels = list(
		RADIO_CHANNEL_CENTCOM = 1,
		RADIO_CHANNEL_COMMAND = 1,
		RADIO_CHANNEL_SERVICE = 1,
		)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2c9327#331bdc"

///////////////////////////////////////////////////////////////////////////////////

/obj/item/radio/headset/headset_cent/sectorial_security_administrator
	name = "\improper sectorial security administrator's headset"
	desc = "A headset used by the upper echelons of Castor. Protects ears from flashbangs."
	icon_state = "cent_headset_alt"
	worn_icon_state = "cent_headset_alt"
	keyslot = /obj/item/encryptionkey/castor/sectorial_security_administrator
	keyslot2 = null
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/radio/headset/headset_cent/sectorial_security_administrator/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)

/obj/item/encryptionkey/castor/sectorial_security_administrator
	name = "\proper sectorial security administrator's encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/binary"
	post_init_icon_state = "cypherkey_cube"
	channels = list(
		RADIO_CHANNEL_CENTCOM = 1,
		RADIO_CHANNEL_COMMAND = 1,
		RADIO_CHANNEL_SECURITY = 1,
		)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2c9327#331bdc"

///////////////////////////////////////////////////////////////////////////////////

/obj/item/radio/headset/headset_cent/sectorial_research_administrator
	name = "\improper sectorial research administrator's headset"
	desc = "A headset used by the upper echelons of Castor."
	icon_state = "cent_headset"
	worn_icon_state = "cent_headset"
	keyslot = /obj/item/encryptionkey/castor/sectorial_research_administrator
	keyslot2 = null
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/encryptionkey/castor/sectorial_research_administrator
	name = "\proper sectorial research administrator's encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/binary"
	post_init_icon_state = "cypherkey_cube"
	channels = list(
		RADIO_CHANNEL_CENTCOM = 1,
		RADIO_CHANNEL_COMMAND = 1,
		RADIO_CHANNEL_SCIENCE = 1,
		)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2c9327#331bdc"

///////////////////////////////////////////////////////////////////////////////////

/obj/item/radio/headset/headset_cent/sectorial_medical_administrator
	name = "\improper sectorial medical administrator's headset"
	desc = "A headset used by the upper echelons of Castor."
	icon_state = "cent_headset"
	worn_icon_state = "cent_headset"
	keyslot = /obj/item/encryptionkey/castor/sectorial_medical_administrator
	keyslot2 = null
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/encryptionkey/castor/sectorial_medical_administrator
	name = "\proper sectorial medical administrator's encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/binary"
	post_init_icon_state = "cypherkey_cube"
	channels = list(
		RADIO_CHANNEL_CENTCOM = 1,
		RADIO_CHANNEL_COMMAND = 1,
		RADIO_CHANNEL_MEDICAL = 1,
		)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2c9327#331bdc"

///////////////////////////////////////////////////////////////////////////////////

/obj/item/radio/headset/headset_cent/sectorial_logistics_administrator
	name = "\improper sectorial logistics administrator's headset"
	desc = "A headset used by the upper echelons of Castor."
	icon_state = "cent_headset"
	worn_icon_state = "cent_headset"
	keyslot = /obj/item/encryptionkey/castor/sectorial_logistics_administrator
	keyslot2 = null
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/encryptionkey/castor/sectorial_logistics_administrator
	name = "\proper sectorial logistics administrator's encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/binary"
	post_init_icon_state = "cypherkey_cube"
	channels = list(
		RADIO_CHANNEL_CENTCOM = 1,
		RADIO_CHANNEL_COMMAND = 1,
		RADIO_CHANNEL_SUPPLY = 1,
		)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2c9327#331bdc"

///////////////////////////////////////////////////////////////////////////////////

/obj/item/radio/headset/headset_cent/sectorial_engineering_administrator
	name = "\improper sectorial engineering administrator's headset"
	desc = "A headset used by the upper echelons of Castor."
	icon_state = "cent_headset"
	worn_icon_state = "cent_headset"
	keyslot = /obj/item/encryptionkey/castor/sectorial_engineering_administrator
	keyslot2 = null
	special_channels = RADIO_SPECIAL_CENTCOM

// ;)
/obj/item/radio/headset/headset_cent/sectorial_engineering_administrator/Initialize(mapload)
	. = ..()
	keyslot2 = new /obj/item/encryptionkey/syndicate()
	special_channels |= RADIO_SPECIAL_SYNDIE
	recalculateChannels()

/obj/item/encryptionkey/castor/sectorial_engineering_administrator
	name = "\proper sectorial engineering administrator's encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/binary"
	post_init_icon_state = "cypherkey_cube"
	channels = list(
		RADIO_CHANNEL_CENTCOM = 1,
		RADIO_CHANNEL_COMMAND = 1,
		RADIO_CHANNEL_ENGINEERING = 1,
		)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2c9327#331bdc"

///////////////////////////////////////////////////////////////////////////////////

/obj/item/radio/headset/headset_cent/sectorial_internal_affairs_administrator
	name = "\improper sectorial internal affairs administrator's headset"
	desc = "A headset used by the upper echelons of Castor."
	icon_state = "cent_headset"
	worn_icon_state = "cent_headset"
	keyslot = /obj/item/encryptionkey/castor/sectorial_internal_affairs_administrator
	keyslot2 = null
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/encryptionkey/castor/sectorial_internal_affairs_administrator
	name = "\proper sectorial internal affairs administrator's encryption key"
	icon = 'icons/map_icons/items/encryptionkey.dmi'
	icon_state = "/obj/item/encryptionkey/binary"
	post_init_icon_state = "cypherkey_cube"
	channels = list(
		RADIO_CHANNEL_CENTCOM = 1,
		RADIO_CHANNEL_COMMAND = 1,
		)
	greyscale_config = /datum/greyscale_config/encryptionkey_cube
	greyscale_colors = "#2c9327#331bdc"
