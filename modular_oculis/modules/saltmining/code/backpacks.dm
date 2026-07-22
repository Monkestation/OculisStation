//This file contains the three backpacks made specifically for shaft miners!
//also includes a new holster, cry about it

/obj/item/storage/belt/holster/wasteland
	name = "wasteland gun holster"
	desc = "A special holster that can carry any wasteland gun, and fits in your suit storage slot or belt!"
	icon = 'modular_oculis/modules/saltmining/icons/backpack_item.dmi'
	worn_icon = 'modular_oculis/modules/saltmining/icons/backpack_worn.dmi'
	icon_state = "holsterwastes"
	inhand_icon_state = "holster"
	worn_icon_state = "notreal"
	alternate_worn_layer = UNDER_SUIT_LAYER
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/belt/holster/wasteland

/datum/storage/belt/holster/wasteland
	max_slots = 1
	max_total_storage = 10
	open_sound = 'sound/items/handling/holster_open.ogg'
	open_sound_vary = TRUE
	max_specific_storage = WEIGHT_CLASS_HUGE //big guns go in here
	quickdraw = TRUE

/datum/storage/belt/holster/wasteland/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
	. = ..()
	if(length(holdables))
		set_holdable(holdables)
		return

	set_holdable(list(
		/obj/item/gun/ballistic/automatic/proto/pksmg,
		/obj/item/gun/ballistic/shotgun/doublebarrel/kinetic,
		/obj/item/gun/ballistic/shotgun/automatic/combat/compact/goliathhunter,
		/obj/item/gun/ballistic/revolver/govmining,
		/obj/item/gun/ballistic/revolver/govmining/venator,
		/obj/item/gun/ballistic/automatic/proto/pksmg/autoshotgun,
		/obj/item/gun/ballistic/automatic/proto/pksmg/kineticlmg,
		/obj/item/gun/ballistic/rifle/minerjdj,
		//wasteland guns ONLY no pkas
	))


/obj/item/storage/backpack/rockspider //three slots, can only hold mining guns and PKAs, nothing else
	name = "Rockspider Pack"
	desc = "A surprisingly flexible and durable bag, capable of carrying up to three mining guns at once, for those who prowl the wastes with a passion for marksmanship. Due to its flexibility, it doesn't interfere with movement like most bags when paired with a satchel."
	icon = 'modular_oculis/modules/saltmining/icons/backpack_item.dmi'
	worn_icon = 'modular_oculis/modules/saltmining/icons/backpack_worn.dmi'
	icon_state = "rockspider"
	inhand_icon_state = "backpack"
	satchel_movespeed_modifier = PAIRED_STORAGE_NO_SLOWDOWN


/obj/item/storage/backpack/rockspider/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 3
	atom_storage.max_specific_storage = WEIGHT_CLASS_HUGE
	atom_storage.set_holdable(list(
		/obj/item/gun/ballistic/automatic/proto/pksmg/autoshotgun,
		/obj/item/gun/ballistic/automatic/proto/pksmg/kineticlmg,
		/obj/item/gun/ballistic/shotgun/doublebarrel/kinetic,
		/obj/item/gun/ballistic/automatic/proto/pksmg,
		/obj/item/gun/ballistic/rifle/minerjdj,
		/obj/item/gun/ballistic/revolver/govmining,
		/obj/item/gun/energy/recharge/kinetic_accelerator,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/glock,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/railgun,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/repeater,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/shockwave,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/shotgun,
		/obj/item/gun/ballistic/revolver/govmining/venator,
		/obj/item/gun/ballistic/shotgun/automatic/combat/compact/goliathhunter,

	))
	atom_storage.max_total_storage = 100

/obj/item/storage/backpack/ashduelist //two slots, can hold any crusher or mining guns
	name = "Ashen Duelist Pack"
	desc = "A bag with a mount and holster, capable of carrying any crusher type weapon and a gun, for the aspiring duelist who needs a bit more than just a blade. Due to its flexibility, it doesn't interfere with movement like most bags when paired with a satchel."
	icon = 'modular_oculis/modules/saltmining/icons/backpack_item.dmi'
	worn_icon = 'modular_oculis/modules/saltmining/icons/backpack_worn.dmi'
	icon_state = "ashenduelist"
	inhand_icon_state = "backpack"
	satchel_movespeed_modifier = PAIRED_STORAGE_NO_SLOWDOWN

/obj/item/storage/backpack/ashduelist/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 2
	atom_storage.max_specific_storage = WEIGHT_CLASS_HUGE
	atom_storage.set_holdable(list(
		/obj/item/gun/ballistic/automatic/proto/pksmg/autoshotgun,
		/obj/item/gun/ballistic/automatic/proto/pksmg/kineticlmg,
		/obj/item/gun/ballistic/shotgun/doublebarrel/kinetic,
		/obj/item/gun/ballistic/automatic/proto/pksmg,
		/obj/item/gun/ballistic/rifle/minerjdj,
		/obj/item/gun/ballistic/revolver/govmining,
		/obj/item/gun/energy/recharge/kinetic_accelerator,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/glock,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/railgun,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/repeater,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/shockwave,
		/obj/item/gun/energy/recharge/kinetic_accelerator/variant/shotgun,
		/obj/item/gun/ballistic/revolver/govmining/venator,
		/obj/item/gun/ballistic/shotgun/automatic/combat/compact/goliathhunter,
		/obj/item/kinetic_crusher,
		/obj/item/kinetic_crusher/machete,
		/obj/item/kinetic_crusher/spear,
		/obj/item/kinetic_crusher/hammer,
		/obj/item/kinetic_crusher/claw,
		/obj/item/kinetic_crusher/pilebunker,
		/obj/item/kinetic_crusher/sickle,
	))
	atom_storage.max_total_storage = 100

/obj/item/storage/backpack/trenchjockey //has 14 slots but can only hold wasteland gun ammo
	name = "Trench Jockey Pack"
	desc = "A exceptionally spacious bag full of slots and pouches for different kinds of ammunition, for those who really need more than just one extra round. Despite its weight, it fits incredibly well with a satchel, and does not hinder your movement as a regular backpack would."
	icon = 'modular_oculis/modules/saltmining/icons/backpack_item.dmi'
	worn_icon = 'modular_oculis/modules/saltmining/icons/backpack_worn.dmi'
	icon_state = "trenchjockey"
	inhand_icon_state = "backpack"
	satchel_movespeed_modifier = PAIRED_STORAGE_NO_SLOWDOWN

/obj/item/storage/backpack/trenchjockey/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 14 //TWO whole rows to fill with ammo, this should be PLENTY, if you run out you either spent way to long on lavaland and should go touch grass, or you have a TREMENDOUS skill issue
	atom_storage.max_specific_storage = WEIGHT_CLASS_HUGE
	atom_storage.set_holdable(list(
		/obj/item/ammo_box/magazine/pksmgmag,
		/obj/item/storage/box/kinetic,
		/obj/item/ammo_box/magazine/autoshotgun,
		/obj/item/ammo_casing/shotgun/hydrakinetic,
		/obj/item/storage/box/kinetic/autoshotgun,
		/obj/item/ammo_casing/a762kinetic,
		/obj/item/ammo_box/a762kinetic,
		/obj/item/storage/box/kinetic/kineticlmg,
		/obj/item/ammo_casing/govmining,
		/obj/item/ammo_box/govmining,
		/obj/item/storage/box/kinetic/govmining,
		/obj/item/ammo_casing/minerjdj,
		/obj/item/ammo_casing/shotgun/kinetic,
		/obj/item/ammo_casing/shotgun/kinetic/sniperslug,
		/obj/item/ammo_casing/shotgun/kinetic/rockbreaker,
		/obj/item/storage/box/kinetic/shotgun,
		/obj/item/storage/box/kinetic/shotgun/sniperslug,
		/obj/item/storage/box/kinetic/shotgun/rockbreaker,
		/obj/item/ammo_box/magazine/ammo_stack/govmining,
		/obj/item/ammo_box/magazine/ammo_stack/kineticmagnum,
		/obj/item/ammo_box/magazine/ammo_stack/autoshotgun,

	),
	list( //cant hold these
		/obj/item/storage/box/kinetic/govmining/bigcase,
		/obj/item/storage/box/kinetic/autoshotgun/bigcase,
		/obj/item/storage/box/kinetic/kineticlmg/bigcase,
		/obj/item/storage/box/kinetic/minerjdj/bigcase, //just incase...
		/obj/item/storage/box/kinetic/shotgun/bigcase,
		/obj/item/storage/box/pksmg, //also just incase...
	))

	atom_storage.max_total_storage = 100

