
/*Contains all the guns added by the module. They are in this order for the sake of helping to find them a little easier
PK SHOCKWAVE
RAPIER SMG
SLAYER SHOTGUN
LEGENDARY GOLIATH HUNTER
DUSTER REVOLER
LEGENDARY VENATOR
FENRIR AUTOSHOTGUN
HELLHOUND LMG
THOR RIFLE
*/

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/gun/energy/recharge/kinetic_accelerator/variant/shockwave
	name = "proto-kinetic shockwave"
	desc = "A specialized PKA frame designed to accept an overclocked version of the AOE modkit."
	icon = 'modular_oculis/modules/saltmining/icons/gun_item.dmi'
	icon_state = "kineticshockwave"
	base_icon_state = "kineticshockwave"
	recharge_time = 3 SECONDS //same as railgun but can be cooldown modded
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/shockwave)
	max_mod_capacity = 90 //bumped up to 90 to compensate for the 30 you need to spend on the AOE mod that gives it its functionality

/obj/item/borg/upgrade/modkit/cooldown/aoe/mobs/andturfs/shockwave
	name = "Shockwave modkit"
	desc = "A special version of the AOE modkit that gives the PK-Shockwave all of its unique properties. It does not fit into any other PK weapon."
	maximum_of_type = 1
	modifier = 0.25 //shockwave AOE only does 10 damage now, used to be 20 damage but had to nerf due to AOE not being affected by pressure

/obj/item/storage/box/shockwave
	name = "PK-Shockwave Box"
	desc = "A box containing a PK-Shockwave and the Shockwave modkit. Dispose of after emptying."
	icon_state = "cyber_implants"

/obj/item/storage/box/shockwave/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 2
	atom_storage.max_specific_storage = WEIGHT_CLASS_BULKY
	atom_storage.max_total_storage = 2

/obj/item/storage/box/shockwave/PopulateContents()
	new /obj/item/gun/energy/recharge/kinetic_accelerator/variant/shockwave(src)
	new /obj/item/borg/upgrade/modkit/cooldown/aoe/mobs/andturfs/shockwave(src)
//Holy crap code, I think this has to be here just to increase the range by ONE TILE :sob:
/obj/item/borg/upgrade/modkit/cooldown/aoe/mobs/andturfs/shockwave/projectile_strike(obj/projectile/kinetic/K, turf/target_turf, atom/target, obj/item/gun/energy/recharge/kinetic_accelerator/KA)
	if(stats_stolen)
		return
	new /obj/effect/temp_visual/explosion/fast(target_turf)
	if(turf_aoe)
		for(var/T in RANGE_TURFS(2, target_turf) - target_turf)
			if(ismineralturf(T))
				var/turf/closed/mineral/M = T
				M.gets_drilled(K.firer, TRUE)
	if(modifier)
		for(var/mob/living/L in range(2, target_turf) - K.firer - target)
			var/armor = L.run_armor_check(K.def_zone, K.armor_flag, "", "", K.armour_penetration)
			L.apply_damage(K.damage*modifier, K.damage_type, K.def_zone, armor)
			to_chat(L, span_userdanger("You're struck by a [K.name]!"))

/obj/item/borg/upgrade/modkit/cooldown/aoe/mobs/andturfs/shockwave/install(obj/item/gun/energy/recharge/kinetic_accelerator/KA, mob/user)
	if(istype(KA, /obj/item/gun/energy/recharge/kinetic_accelerator/variant/shockwave))
		. = ..()
	else
		to_chat(user, span_warning("[src] does not fit in [KA]. It will only fit in a Shockwave!"))
		return FALSE

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/gun/ballistic/automatic/proto/pksmg
	name = "'Rapier' Mining Smg'"
	desc = "The 'Rapier' Mining Smg is a fully automatic Smg made specifically for shaft miners, in a compact package, for the lowest price."
	icon = 'modular_oculis/modules/saltmining/icons/gun_item.dmi'
	icon_state = "pksmg"
	burst_size = 1
	actions_types = list()
	mag_display = TRUE
	empty_indicator = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/pksmgmag
	pin = /obj/item/firing_pin/wastes
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	fire_sound = 'sound/items/weapons/gun/rifle/smg_heavy.ogg'

/obj/item/gun/ballistic/automatic/proto/pksmg/Initialize(mapload)
	. = ..()
	var/datum/component/automatic_fire/autofire = GetComponent(/datum/component/automatic_fire)
	autofire.autofire_shot_delay = 0.1 SECONDS

//FLASHLIGHTTTTTT
/obj/item/gun/ballistic/automatic/proto/pksmg/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 16)

/obj/item/storage/box/pksmg //A case that the SMG comes in on purchase, containing three magazines
	name = "'Rapier' Mining SMG Case"
	desc = "A case containing a 'Rapier' Mining SMG and three magazines. Designed for full auto but has limited ammo.\
	This box was not designed (somehow) to properly store its contents, and should instead be emptied and dissassembled immedietly."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "miner_case"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/iron

/obj/item/storage/box/pksmg/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 4
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 4

/obj/item/storage/box/pksmg/PopulateContents()
		new /obj/item/gun/ballistic/automatic/proto/pksmg(src)
		new /obj/item/ammo_box/magazine/pksmgmag(src)
		new /obj/item/ammo_box/magazine/pksmgmag(src)
		new /obj/item/ammo_box/magazine/pksmgmag(src)

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/gun/ballistic/shotgun/doublebarrel/kinetic
	name = "'Slayer' Mining Boomstick"
	desc = "An advanced re-design of the old Proto-Kinetic Shotgun, upgraded to a proper boomstick. Rumor has it the original designer designed this to execute a dissident researcher at a pizza party. <b> Does NOT fit standard 12 gauge shells! Shells tend to get jammed when fired, so you must eject both shells before reloading.</b>"
	icon = 'modular_oculis/modules/saltmining/icons/gun_item.dmi'
	icon_state = "protokshotgun"
	base_icon_state = "protokshotgun"
	inhand_icon_state = "protokshotgun"
	worn_icon = 'modular_oculis/modules/saltmining/icons/gun_worn.dmi'
	worn_icon_state = "protokshotgun"
	lefthand_file = 'modular_oculis/modules/saltmining/icons/gun_left_hand.dmi'
	righthand_file = 'modular_oculis/modules/saltmining/icons/gun_right_hand.dmi'
	recoil = 2
	force = 20
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	armour_penetration = 0
	pin = /obj/item/firing_pin/wastes //yes this is required, do NOT remove it
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/shotgun_heavy.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/dual/kinetic
	can_be_sawn_off = FALSE
	sharpness = SHARP_EDGED
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("slashes", "cuts", "cleaves", "chops", "swipes")
	attack_verb_simple = list("cleave", "chop", "cut", "swipe", "slash")
	pb_knockback = 1 //you may have your point blank

/obj/item/gun/ballistic/shotgun/doublebarrel/kinetic/setup_reskins()
	return //killing the double barrels reskin capabilities

/obj/item/storage/box/kinetic/shotgun/bigcase //box
	name = "'Slayer' Shotgun Case"
	desc = "A special and totally original gun case that contains a 'Slayer' Boomstick, eight shells of Rockbreaker, and four shells of 'Slayer' Magnum Buckshot. The box is not designed to properly store its contents, and should be emptied and recycled immedietly."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "miner_case"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/iron

/obj/item/storage/box/kinetic/shotgun/bigcase/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 13
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 13
	atom_storage.set_holdable(list())

/obj/item/storage/box/kinetic/shotgun/bigcase/PopulateContents() //populate

		new /obj/item/gun/ballistic/shotgun/doublebarrel/kinetic(src) //the shotgun
		new /obj/item/ammo_casing/shotgun/kinetic/rockbreaker(src) //fuck it we do a little bit of bad code :)
		new /obj/item/ammo_casing/shotgun/kinetic/rockbreaker(src)
		new /obj/item/ammo_casing/shotgun/kinetic/rockbreaker(src)
		new /obj/item/ammo_casing/shotgun/kinetic/rockbreaker(src)
		new /obj/item/ammo_casing/shotgun/kinetic/rockbreaker(src)
		new /obj/item/ammo_casing/shotgun/kinetic/rockbreaker(src)
		new /obj/item/ammo_casing/shotgun/kinetic/rockbreaker(src)
		new /obj/item/ammo_casing/shotgun/kinetic/rockbreaker(src)  //8 shells of rockbreaker
		new /obj/item/ammo_casing/shotgun/kinetic(src) //4 shells of kinetic buckshot
		new /obj/item/ammo_casing/shotgun/kinetic(src)
		new /obj/item/ammo_casing/shotgun/kinetic(src)
		new /obj/item/ammo_casing/shotgun/kinetic(src)

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/goliathhunter //legendary slayer varient, upgraded by not being a double barrel :)
	name = "'Goliath Hunter' Shotgun"
	desc = "A strange shotgun that has been customized and outfitted with non-standard parts. Only accepts 'Slayer' shotgun shells, and has a 4 round tube, totalling 5 shells in the gun at a time."
	special_desc = "Inside the grip you find a note... \ 'To my dearest sister - It's lonely out here in space, so many stars sit between us and a re-union... I can't stand the cold out here alone, but knowing you are out there waiting for \
	me is enough to keep me warm enough to keep going. I wish we could be back together in the swamps of Terra, hunting the muddy fiends that lurk beneath. Alas with this many stars between us, there is no telling when we may re-unite, \
	but just knowing that we will one day fuels me with the strength to keep marching forward. I hope you receive this, it's a custom design I have been working on just for you, so you may always have me at your side. - Your dearest brother' \
	It seems the message and the shotgun never made it to his sister..."
	icon = 'modular_oculis/modules/saltmining/icons/gun_item.dmi'
	righthand_file = 'modular_oculis/modules/saltmining/icons/gun_right_hand.dmi'
	lefthand_file = 'modular_oculis/modules/saltmining/icons/gun_left_hand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/shotgun_heavy.ogg'
	fire_sound_volume = 100
	rack_sound = 'sound/items/weapons/gun/general/chunkyrack.ogg'
	icon_state = "goliathhunter"
	inhand_icon_state = "goliathhunter"
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "gun"
	inside_belt_icon_state = "gun"
	bolt_wording = "charging handle"
	slot_flags = NONE //Keep it in your bag
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/com/compact/goliathhunter
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	pin = /obj/item/firing_pin/wastes //has to be manually added as its not a subtype of a pre-existing wasteland gun

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/goliathhunter/give_manufacturer_examine()
	return //NO MANUFACTURER STAMP

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/gun/ballistic/revolver/govmining
	name = "45-70 GOV 'Duster' Revolver"
	desc = "A .45-70 cartridge mining revolver. Comes with a spin nanochip in the grip that grants the wielder the dexterity to spin the revolver to eject the casings."
	icon = 'modular_oculis/modules/saltmining/icons/gun_item.dmi'
	icon_state = "miningbigiron"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/govmining
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/revolver_heavy.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 100
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	pin = /obj/item/firing_pin/wastes

/obj/item/gun/ballistic/revolver/govmining/attack_self(mob/living/user) //you do a sick flip when you empty the rounds
	. = ..()
	SpinAnimation(4,2)
	if(flip_cooldown <= world.time)
		flip_cooldown = (world.time + 30)
		user.visible_message(span_notice("[user] spins [src] around [user.p_their()] finger by the trigger, ejecting any loaded cartridges!"))
		playsound(src, 'sound/items/handling/ammobox_pickup.ogg', 20, FALSE)


/obj/item/gun/ballistic/revolver/govmining/give_manufacturer_examine()
	return //NO MANUFACTURER STAMP

/obj/item/storage/box/kinetic/govmining/bigcase
	name = "Kinetic 'Duster' Revolver Case"
	desc = "A case containing a 'Duster' Mining revolver and three speedloaders. The box is not designed to store its contents properly, and thus should be emptied and disposed of immedietly."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "miner_case"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/iron

/obj/item/storage/box/kinetic/govmining/bigcase/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 4
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 4
	atom_storage.set_holdable(list())

/obj/item/storage/box/kinetic/govmining/bigcase/PopulateContents() //populate

		new /obj/item/gun/ballistic/revolver/govmining (src)
		new /obj/item/ammo_box/govmining (src)
		new /obj/item/ammo_box/govmining (src)
		new /obj/item/ammo_box/govmining (src)

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/gun/ballistic/revolver/govmining/venator //legendary varient with big ammo cap and full auto
	name = "'Venator' Chain Pistol"
	desc = "A strange modification of the 'Duster' revolver, apparently the cylinder has been replaced with a 21 round chain, the grip has also been upgraded with a fanning nanochip, granting you the innate ability to fan the hammer."
	special_desc = "Inside the grip you find a note... \ 'To my dearest brother - I hope this note finds you in good health, I know its been a long time since we have last seen one another, and I pray that one day we may be able to find \
	each other again in the swamps of Terra, to go on one last hunt together as brother and sister. Space is cold and lonely, and without you its so much worse, I miss the long nights we spent under the stars talking to each other. \
	I miss you, may this pistol help you to never forget about me, I made it just for you. - Your dearest sister' \
	It seems the message and pistol never made it to her brother..."
	icon = 'modular_oculis/modules/saltmining/icons/gun_item.dmi'
	righthand_file = 'modular_oculis/modules/saltmining/icons/gun_right_hand.dmi'
	lefthand_file = 'modular_oculis/modules/saltmining/icons/gun_left_hand.dmi'
	icon_state = "venator"
	inhand_icon_state = "venator"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/govmining/venator
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/revolver_heavy.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 100
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	pin = /obj/item/firing_pin/wastes

/obj/item/gun/ballistic/revolver/govmining/venator/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)


//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/gun/ballistic/automatic/proto/pksmg/autoshotgun
	name = "20. Gauge Mining 'Fenrir' Auto Shotgun"
	desc = "A fully automatic mining shotgun created using some spare polymer parts, procured from a undisclosed source. Loaded with 20. Gauge shells, for sweeping up any unwanted fauna from a hostile environment."
	icon = 'modular_oculis/modules/saltmining/icons/gun_item_wide.dmi'
	inhand_icon_state = "protokshotgunauto"
	worn_icon = 'modular_oculis/modules/saltmining/icons/gun_worn.dmi'
	worn_icon_state = "protokshotgunauto"
	icon_state = "protokshotgunauto"
	lefthand_file = 'modular_oculis/modules/saltmining/icons/gun_left_hand.dmi'
	righthand_file = 'modular_oculis/modules/saltmining/icons/gun_right_hand.dmi'
	slot_flags = ITEM_SLOT_BACK
	burst_size = 1
	fire_delay = 0
	base_pixel_x = -2
	pixel_x = -2
	actions_types = list()
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	mag_display = TRUE
	empty_indicator = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/autoshotgun
	pin = /obj/item/firing_pin/wastes
	bolt_type = BOLT_TYPE_STANDARD
	show_bolt_icon = FALSE
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/battle_rifle.ogg'

/obj/item/gun/ballistic/automatic/proto/pksmg/autoshotgun/Initialize(mapload)
	. = ..()
	var/datum/component/automatic_fire/autofire = GetComponent(/datum/component/automatic_fire)
	autofire.autofire_shot_delay = 0.25 SECONDS

/obj/item/storage/box/kinetic/autoshotgun/bigcase //box containing the actual gun and a few spare mags for sale
	name = "'Fenrir' Shotgun case"
	desc = "A mining gun case containing a 20. gauge Fenrir automatic shotgun and three spare magazines. It is not designed to store its contents properly, and should be emptied and disposed of immedietly."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	icon_state = "miner_case"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/iron

/obj/item/storage/box/kinetic/autoshotgun/bigcase/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 4
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 4
	atom_storage.set_holdable(list())

/obj/item/storage/box/kinetic/autoshotgun/bigcase/PopulateContents() //populate

		new /obj/item/gun/ballistic/automatic/proto/pksmg/autoshotgun (src)
		new /obj/item/ammo_box/magazine/autoshotgun (src)
		new /obj/item/ammo_box/magazine/autoshotgun (src)
		new /obj/item/ammo_box/magazine/autoshotgun (src)

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/gun/ballistic/automatic/proto/pksmg/kineticlmg
	name = "'Hellhound' Mining LMG"
	desc = "The 'Hellhound' is an LMG chambered in kinetic 7.62mm Mining, also known as Triple M, with an incredibly high fire rate. Has a fixed unremovable 150 round magazine with a special loading port on the outside, allowing you to \
	top off and reload using stripper clips. Some have called its designer a 'Sadistic Asshole' for designing it without a swappable magazine."
	icon = 'modular_oculis/modules/saltmining/icons/gun_item_wide.dmi'
	worn_icon = 'modular_oculis/modules/saltmining/icons/gun_worn.dmi'
	lefthand_file = 'modular_oculis/modules/saltmining/icons/gun_left_hand.dmi'
	righthand_file = 'modular_oculis/modules/saltmining/icons/gun_right_hand.dmi'
	icon_state = "kineticlmg"
	inhand_icon_state = "kineticlmg"
	base_icon_state = "kineticlmg"
	worn_icon_state = "kineticlmg"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	burst_size = 1
	mag_display = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/kineticlmg
	weapon_weight = WEAPON_HEAVY
	internal_magazine = TRUE
	spread = 3
	pin = /obj/item/firing_pin/wastes
	fire_sound = 'modular_oculis/modules/saltmining/sound/hmg-short.ogg'

/obj/item/gun/ballistic/automatic/proto/pksmg/kineticlmg/Initialize(mapload)
	. = ..()
	var/datum/component/automatic_fire/autofire = GetComponent(/datum/component/automatic_fire)
	autofire.autofire_shot_delay = 0.08 SECONDS

/obj/item/storage/box/kinetic/kineticlmg/bigcase //box containing the LMG and a box of extra bullets to get one reload
	name = "'Hellhound' Mining LMG case"
	desc = "A special and totally original gun case that contains a 'Hellhound' Mining LMG, and a box of spare rounds to refill it. It is not designed to store its contents properly, and should be emptied and disposed of immedietly."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "miner_case"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/iron

/obj/item/storage/box/kinetic/kineticlmg/bigcase/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 2
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 2
	atom_storage.set_holdable(list())

/obj/item/storage/box/kinetic/kineticlmg/bigcase/PopulateContents() //populate

		new /obj/item/gun/ballistic/automatic/proto/pksmg/kineticlmg (src)
		new /obj/item/storage/box/kinetic/kineticlmg (src)

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/gun/ballistic/rifle/minerjdj // singlehandedly most expensive weapon a miner can buy, and for good reason. Its only purpose is to essentially delete the target of this rifles fury, and your wallet when you buy it.
	name = ".950 JDJ 'Thor' Mining Rifle"
	desc = "Completely absurd, in both size and firepower. Fires an absolutely massive round that is sure to stop pretty much anything in its tracks that would even warrent it. Was developed about 17 beers deep into the night, and with no intent of actually being used for mining."
	icon_state = "fatmac"
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK
	icon = 'modular_oculis/modules/saltmining/icons/gun_item_wide.dmi'
	worn_icon = 'modular_oculis/modules/saltmining/icons/gun_worn.dmi'
	lefthand_file = 'modular_oculis/modules/saltmining/icons/gun_left_hand.dmi'
	righthand_file = 'modular_oculis/modules/saltmining/icons/gun_right_hand.dmi'
	inhand_icon_state = "fatmac"
	worn_icon_state = "fatmac"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/minerjdj
	bolt_wording = "bolt"
	bolt_type = BOLT_TYPE_LOCKING
	semi_auto = FALSE
	recoil = 8 //ow my back
	fire_sound = 'modular_oculis/modules/saltmining/sound/quadfire.ogg'
	rack_sound = 'modular_oculis/modules/saltmining/sound/quadrack.ogg'
	bolt_drop_sound = 'modular_oculis/modules/saltmining/sound/quadinsert.ogg'
	fire_sound_volume = 200 // L O U D
	need_bolt_lock_to_interact = TRUE
	pin = /obj/item/firing_pin/wastes //hey so yeah did you see how much damage the bullet this thing fires does ok cool so you know why this is NEVER EVER coming off

/obj/item/storage/box/kinetic/minerjdj/bigcase //box containing the actual gun for sale
	name = ".950 JDJ 'Thor' Rifle case"
	desc = "A pretty redundant gun case that only contains the .950 JDJ Kinetic 'Thor' Rifle... contains no spare ammo, so make your one shot count or buy some more bullets. It is not designed to store its contents properly, and should be emptied and disposed of immedietly."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "miner_case"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/iron

/obj/item/storage/box/kinetic/minerjdj/bigcase/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 1
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 1
	atom_storage.set_holdable(list())

/obj/item/storage/box/kinetic/minerjdj/bigcase/PopulateContents() //populate

		new /obj/item/gun/ballistic/rifle/minerjdj (src)
