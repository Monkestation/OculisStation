
/*Contains all the ammo, projectiles, and relevant magazines and boxes added by the module. They are in this order for the sake of helping to find them a little easier
PK SHOCKWAVE
RAPIER SMG
SLAYER SHOTGUN / GOLIATH HUNTER
DUSTER REVOLER / VENATOR
FENRIR AUTOSHOTGUN
HELLHOUND LMG
THOR RIFLE
*/

//DEFINES
#define MINER_SHOTGUN "Kinetic Shotgun"
#define CALIBER_GOV_MINING ".45-70 Gov Mining"
#define KINETIC_20G "20 Gauge Mining Shell"
#define CALIBER_A762_KINETIC "7.65 Mining"
#define CALIBER_MINER_950 ".950 JDJ Lightning"

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/projectile/kinetic/shockwave
	name = "concussive kinetic force"
	damage = 40
	range = 0

/obj/item/ammo_casing/energy/kinetic/shockwave
	projectile_type = /obj/projectile/kinetic/shockwave
	fire_sound = 'sound/items/weapons/gun/general/cannon.ogg'

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

//Magazine for SMG and the box the mags come in
/obj/item/ammo_box/magazine/pksmgmag
	name = "'Rapier' magazine"
	desc = "A single magazine for the 'Rapier'."
	icon = 'modular_oculis/modules/saltmining/icons/ammo_item.dmi'
	icon_state = "pksmgmag"
	base_icon_state = "pksmgmag"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/energy/kinetic/smg
	caliber = ENERGY
	max_ammo = 30

/obj/item/storage/box/kinetic
	name = "box of 'Rapier' mining magazines"
	desc = "A box full of 'Rapier' magazines, specifically for the 'Rapier' Mining SMG. \
	It can only hold the magazines for the 'Rapier', but as a result, fits inside of explorer webbing."
	icon = 'icons/obj/storage/toolbox.dmi'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	icon_state = "ammobox"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/iron

/obj/item/storage/box/kinetic/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 7
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 20
	atom_storage.set_holdable(list(
		/obj/item/ammo_box/magazine/pksmgmag,
	))

/obj/item/storage/box/kinetic/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_box/magazine/pksmgmag(src)

/obj/item/storage/box/kinetic/small
	name = "small case of 'Rapier' ammo"
	desc = "A small case with two 'Rapier' magazines. Does NOT fit in explorer webbing and was not designed to properly store its contents, and should be emptied and recycled immedietly."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	icon_state = "miner_case_small"
	illustration = ""

/obj/item/storage/box/kinetic/small/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 2
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 2

/obj/item/storage/box/kinetic/small/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/ammo_box/magazine/pksmgmag(src)

/obj/item/ammo_casing/energy/kinetic/smg
	name = "'Rapier' Mining SMG Casing"
	desc = "A singular round for the 'Rapier' Mining SMG, the first ammunition ever designed for a Mining Wasteland Gun."
	projectile_type = /obj/projectile/kinetic/smg
	select_name = "kinetic"
	e_cost = 0
	fire_sound = 'sound/items/weapons/kinetic_accel.ogg'

/obj/projectile/kinetic/smg
	name = "rapier round"
	damage = 5
	range = 6
	icon_state = "gauss_silenced"
	skillbasedweapon = FALSE
	lavafauna_mod = 5

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/ammo_box/magazine/internal/shot/dual/kinetic
	name = "kinetic double barrel shotgun internal magazine"
	desc = "how did you break my gun like this, please report whatever you did then feel bad!!!"
	ammo_type = /obj/item/ammo_casing/shotgun/kinetic
	caliber = MINER_SHOTGUN
	max_ammo = 2

//You cant just pry these shells out with your fingers, youll have to eject them by breaking open the shotgun
/obj/item/ammo_box/magazine/internal/shot/dual/kinetic/give_round(obj/item/ammo_casing/R)
	if(!R || !(caliber ? (caliber == R.caliber) : (ammo_type == R.type)))
		return FALSE

	else if (stored_ammo.len < max_ammo)
		stored_ammo += R
		R.forceMove(src)
		return TRUE
	return FALSE

/obj/item/storage/box/kinetic/shotgun //box
	name = "box of 'slayer' magnum buckshot"
	desc = "A box that can hold up to ten shells of Magnum Mining Buckshot for the 'Slayer'. Fits inside of explorer webbings."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	icon_state = "protoshell_box"
	illustration = "protoshell_box"

/obj/item/storage/box/kinetic/shotgun/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 10
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 20
	atom_storage.set_holdable(list(
		/obj/item/ammo_casing/shotgun/kinetic,
	))

/obj/item/storage/box/kinetic/shotgun/PopulateContents() //populate
	for(var/i in 1 to 10)
		new /obj/item/ammo_casing/shotgun/kinetic(src)

/obj/item/storage/box/kinetic/shotgun/sniperslug //box
	name = "box of .50 BMG 'slayer' shells"
	desc = "A box designed to hold up to ten shells of 50 BMG Slugs for the 'Slayer'. Fits inside of explorer webbings."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	icon_state = "bmgshell_box"
	illustration = "bmgshell_box"

/obj/item/storage/box/kinetic/shotgun/sniperslug/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 10
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 20
	atom_storage.set_holdable(list(
		/obj/item/ammo_casing/shotgun/kinetic/sniperslug,
	))

/obj/item/storage/box/kinetic/shotgun/sniperslug/PopulateContents() //populate
	for(var/i in 1 to 10)
		new /obj/item/ammo_casing/shotgun/kinetic/sniperslug(src)

/obj/item/storage/box/kinetic/shotgun/rockbreaker //box
	name = "box of 'slayer' rock breaker shells"
	desc = "A box for holding up to twenty shells of Rockbreaker for the 'Slayer'. Surprisingly fits inside of explorer webbings."
	icon = 'icons/obj/storage/toolbox.dmi'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	icon_state = "ammobox"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/iron

/obj/item/storage/box/kinetic/shotgun/rockbreaker/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 20
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 20
	atom_storage.set_holdable(list(
		/obj/item/ammo_casing/shotgun/kinetic/rockbreaker,
	))

/obj/item/storage/box/kinetic/shotgun/rockbreaker/PopulateContents() //populate
	for(var/i in 1 to 20)
		new /obj/item/ammo_casing/shotgun/kinetic/rockbreaker(src)

/obj/item/ammo_casing/shotgun/kinetic //for slaying, works on crowds
	name = "'Slayer' Magnum Buckshot Shell"
	desc = "A 12 gauge Shell loaded with magnum kinetic projectiles. Penetrates rocky walls and creatures! <b> Does NOT fit in any standard 12 gauge shotgun! </b>"
	icon_state = "shellproto"
	icon = 'modular_oculis/modules/saltmining/icons/ammo_item.dmi'
	caliber = MINER_SHOTGUN
	pellets = 5
	variance = 30
	projectile_type = /obj/projectile/plasma/kineticshotgun
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/kineticmagnum

/obj/item/ammo_box/magazine/ammo_stack/kineticmagnum
	name = "'Slayer' shells"
	desc = "A stack of shells for the 'Slayer' Boomstick."
	caliber = MINER_SHOTGUN
	ammo_type = /obj/item/ammo_casing/shotgun/kinetic

/obj/item/ammo_casing/shotgun/kinetic/sniperslug //slugs essentially
	name = "'Slayer' .50 BMG"
	desc = "If god did not want us to put 50 BMG in a 12 gauge, he would not have given them similar diameter! A incredibly large 50 BMG round adapted into a slug. Does not penetrate targets like 'Slayer' Magnum Buckshot, but still penetrates rock walls. <b> Does NOT fit in any standard 12 gauge shotgun! </b>"
	icon = 'modular_oculis/modules/saltmining/icons/ammo_item.dmi'
	icon_state = "slugbmg"
	pellets = 1
	variance = 5
	projectile_type = /obj/projectile/plasma/kineticshotgun/sniperslug

/obj/item/ammo_casing/shotgun/kinetic/rockbreaker //for digging!
	name = "'Slayer' Rockbreaker Shell"
	desc = "A 12 gauge Shell loaded with dozens of special tiny 'Slayer' rockbreaker pellets, perfect for clearing masses of rocks but no good for killing fauna. <b> Does NOT fit in any standard 12 gauge shotgun! </b>"
	icon = 'icons/obj/weapons/guns/ammo.dmi'
	icon_state = "bountyshell"
	caliber = MINER_SHOTGUN
	pellets = 15
	variance = 75
	projectile_type = /obj/projectile/plasma/kineticshotgun/rockbreaker

/obj/projectile/plasma/kineticshotgun //subtype of plasma instead of kinetic so it can punch through mineable turf. Cant be used off of lavaland or off the wastes of icemoon anyways so...
	name = "'Slayer' magnum pellet"
	icon_state = "cryoshot"
	damage_type = BRUTE
	armor_flag = BOMB
	damage = 5
	lavafauna_mod = 7 //totals 175 damage letting them reach the breakpoint for watcher HP so it one shots them
	range = 7
	speed = 2
	dismemberment = 0
	projectile_piercing = PASSMOB
	impact_effect_type = /obj/effect/temp_visual/kinetic_blast
	mine_range = 1
	tracer_type = ""
	muzzle_type = ""
	impact_type = ""

/obj/projectile/plasma/kineticshotgun/sniperslug // long range but cant hit the oneshot breakpoint of a watcher and does not penetrate targets
	name = "'Slayer' .50 BMG"
	speed = 3
	damage = 15
	lavafauna_mod = 10 //150 damage, still one taps light mobs like legions and worms, while two tapping goliaths, but needs an extra bit to kill a watcher
	range = 10
	icon_state = "gaussstrong"
	projectile_piercing = NONE

/obj/projectile/plasma/kineticshotgun/rockbreaker // for breaking rocks
	name = "rockbreaker"
	speed = 5
	damage = 1
	range = 7
	icon_state = "guardian"
	projectile_piercing = NONE

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/ammo_box/magazine/internal/shot/com/compact/goliathhunter
	name = "goliath hunter mag tube"
	ammo_type = /obj/item/ammo_casing/shotgun/kinetic
	caliber = MINER_SHOTGUN
	max_ammo = 4 //this is four in the tube + 1 in the chamber

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/ammo_box/magazine/internal/cylinder/govmining
	name = "Really Big Revolver Cylinder"
	desc = "Hey BUB howdja do that, dont BREAK the expensive equipment. (REPORT ME)"
	ammo_type = /obj/item/ammo_casing/govmining
	caliber = CALIBER_GOV_MINING
	max_ammo = 6

/obj/item/ammo_casing/govmining
	name = ".45-70 Gov Mining Magnum Casing"
	desc = "An absolute beast of a round that will probably only fit in the 'Duster' Revolver."
	icon = 'modular_oculis/modules/saltmining/icons/ammo_item.dmi'
	icon_state = ".45-70"
	caliber = CALIBER_GOV_MINING
	projectile_type = /obj/projectile/bullet/govmining
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/govmining

/obj/item/ammo_box/magazine/ammo_stack/govmining
	name = "45-70. Mining Casings"
	desc = "A stack of bullets for the 'Duster' Revolver."
	caliber = CALIBER_GOV_MINING
	ammo_type = /obj/item/ammo_casing/govmining

/obj/item/ammo_box/govmining
	name = "speed loader (.45-70 Kinetic)"
	desc = "A six round speedloader carrying an absolute beast of a round for the 'Duster' Revolver."
	icon = 'modular_oculis/modules/saltmining/icons/ammo_item.dmi'
	icon_state = "4570loader"
	w_class = WEIGHT_CLASS_TINY
	ammo_type = /obj/item/ammo_casing/govmining
	max_ammo = 6
	caliber = CALIBER_GOV_MINING
	ammo_box_multiload = AMMO_BOX_MULTILOAD_ALL
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/projectile/bullet/govmining
	name = ".45-70 Gov Kinetic Bullet"
	icon_state = "gaussphase"
	speed = 3
	damage = 15
	lavafauna_mod = 5 //4 taps for a goliath

/obj/projectile/bullet/govmining/on_hit(atom/target, Firer, blocked = 0, pierce_hit) //its not meant to tear through walls like a plasma cutter, but will still at least bust down a wall if it hits one.
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer, FALSE)
	. = ..()

/obj/item/storage/box/kinetic/govmining
	name = "box of .45-70 Gov Mining rounds"
	desc = "A box containing 36 individual .45-70 Gov Mining rounds. Good for loading your 'Duster' revolver or refilling your speedloaders. Fits in explorer webbing."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	icon_state = "gov_box"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/cardboard

/obj/item/storage/box/kinetic/govmining/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 36
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 36
	atom_storage.set_holdable(list(
		/obj/item/ammo_casing/govmining,
	))

/obj/item/storage/box/kinetic/govmining/PopulateContents() //populate
	for(var/i in 1 to 36)
		new /obj/item/ammo_casing/govmining(src)

/obj/item/storage/box/kinetic/govmining/smallcase
	name = "Case of 'Duster' Speedloaders"
	desc = "A case containing three spare speedloaders for the 'Duster' revolver. It is not designed to store its contents properly, and should be emptied and disposed of immedietly."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	icon_state = "miner_case_small"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/iron

/obj/item/storage/box/kinetic/govmining/smallcase/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 3
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 3
	atom_storage.set_holdable(list())

/obj/item/storage/box/kinetic/govmining/smallcase/PopulateContents() //populate

		new /obj/item/ammo_box/govmining (src)
		new /obj/item/ammo_box/govmining (src)
		new /obj/item/ammo_box/govmining (src)

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/ammo_box/magazine/internal/cylinder/govmining/venator
	name = "Venator chain magazine"
	desc = "Hey BUB howdja do that, dont BREAK the expensive equipment. (REPORT ME)"
	ammo_type = /obj/item/ammo_casing/govmining
	caliber = CALIBER_GOV_MINING
	max_ammo = 21
//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/ammo_box/magazine/autoshotgun
	name = "20 Gauge Shotgun Magazine"
	desc = "A single magazine capable of holding 15 rounds of 20 gauge mining hydra shells."
	icon = 'modular_oculis/modules/saltmining/icons/ammo_item.dmi'
	icon_state = "proto20gmag"
	base_icon_state = "proto20gmag"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/shotgun/hydrakinetic
	caliber = KINETIC_20G
	max_ammo = 15

/obj/item/storage/box/kinetic/autoshotgun //box containing 45 spare shells for the fenrir, used to reload spare mags. cheaper to buy than new spare mags.
	name = "20. Gauge Hydra Shell Box"
	desc = "A surprisingly hefty box containing 45 spare 10. gauge Hydra shells, for reloading spare Fenrir magazines. Despite its heft, it fits in explorer webbing."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	icon_state = "smallshell_box"
	illustration = ""

/obj/item/storage/box/kinetic/autoshotgun/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 45
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 45
	atom_storage.set_holdable(list(/obj/item/ammo_casing/shotgun/hydrakinetic))

/obj/item/storage/box/kinetic/autoshotgun/PopulateContents() //populate
	for(var/i in 1 to 45)
		new /obj/item/ammo_casing/shotgun/hydrakinetic (src)

/obj/item/storage/box/kinetic/autoshotgun/smallcase //box containing 3 spare mags for the fenrir auto shotgun
	name = "Spare Fenrir Shotgun Magazine Case"
	desc = "A small gun case that contains three spare magazines for the Fenrir auto shotgun. It is not designed to store its contents properly, and should be emptied and disposed of immedietly."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	icon_state = "miner_case_small"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/iron

/obj/item/storage/box/kinetic/autoshotgun/smallcase/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 3
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 3
	atom_storage.set_holdable(list())

/obj/item/storage/box/kinetic/autoshotgun/smallcase/PopulateContents() //populate
		new /obj/item/ammo_box/magazine/autoshotgun (src)
		new /obj/item/ammo_box/magazine/autoshotgun (src)
		new /obj/item/ammo_box/magazine/autoshotgun (src)


/obj/item/ammo_casing/shotgun/hydrakinetic
	name = "Mining Hydra Shell"
	desc = "A 20 gauge shell loaded with five pellets, dubbed the Mining Hydra Shell! <b> Does NOT fit in any standard shotgun! </b>"
	icon_state = "20gshell"
	icon = 'modular_oculis/modules/saltmining/icons/ammo_item.dmi'
	caliber = KINETIC_20G
	pellets = 5
	variance = 10 //very tight spread
	projectile_type = /obj/projectile/bullet/hydrakinetic
	ammo_stack_type = /obj/item/ammo_box/magazine/ammo_stack/autoshotgun

/obj/item/ammo_box/magazine/ammo_stack/autoshotgun
	name = "20. Gauge hydra shells"
	desc = "A stack of hydra shells for the 'Fenrir' Auto shotgun."
	caliber = KINETIC_20G
	ammo_type = /obj/item/ammo_casing/shotgun/hydrakinetic

/obj/projectile/bullet/hydrakinetic
	name = "Mining Hydra Sabot"
	icon_state = "flechette"
	damage = 3
	lavafauna_mod = 5

/obj/projectile/bullet/hydrakinetic/on_hit(atom/target, Firer, blocked = 0, pierce_hit) //its not meant to tear through walls like a plasma cutter, but will still at least bust down a wall if it hits one.
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer, FALSE)
	. = ..()

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/ammo_box/magazine/internal/kineticlmg
	name = "Internal LMG magazine"
	desc = "uhm... uhg... erm... the magazine fell off... (REPORT ME)"
	ammo_type = /obj/item/ammo_casing/a762kinetic
	caliber = CALIBER_A762_KINETIC
	max_ammo = 150

/obj/item/ammo_casing/a762kinetic
	name = "7.62mm mining bullet casing"
	desc = "A 7.62mmm bullet casing, or Triple M, for use in the 'Hellhound' LMG."
	icon = 'modular_oculis/modules/saltmining/icons/ammo_item.dmi'
	icon_state = "762kinetic-casing"
	caliber = CALIBER_A762_KINETIC
	projectile_type = /obj/projectile/bullet/a762kinetic

/obj/projectile/bullet/a762kinetic
	name = "7.62mmm projectile"
	damage = 3
	icon_state = "gaussweak"
	lavafauna_mod = 5

/obj/projectile/bullet/a762kinetic/on_hit(atom/target, Firer, blocked = 0, pierce_hit) //its not meant to tear through walls like a plasma cutter, but will still at least bust down a wall if it hits one.
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer, FALSE)
	. = ..()

/obj/item/ammo_box/a762kinetic
	name = "stripper clip (7.62mm mining)"
	desc = "A stripper clip with 7.62 Triple M rounds."
	icon = 'modular_oculis/modules/saltmining/icons/ammo_item.dmi'
	icon_state = "762kinetic"
	max_ammo = 5
	ammo_type = /obj/item/ammo_casing/a762kinetic
	ammo_box_multiload = AMMO_BOX_MULTILOAD_ALL
	multiple_sprites = AMMO_BOX_PER_BULLET
	caliber = CALIBER_A762_KINETIC

/obj/item/storage/box/kinetic/kineticlmg //box of stripper clips (30, totalling 150 rounds, or one full reload)
	name = "box of kinetic 7.62mm mining stripper clips"
	desc = "A box that contains up to 30 stripper clips of 7.62 Triple M, for refilling the 'Hellhound' LMG. Surprisingly fits inside of explorer webbings."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	icon_state = "kinetic762_box"
	illustration = ""

/obj/item/storage/box/kinetic/kineticlmg/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 30
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 100
	atom_storage.set_holdable(list(
		/obj/item/ammo_box/a762kinetic,
	))

/obj/item/storage/box/kinetic/kineticlmg/PopulateContents() //populate
	for(var/i in 1 to 30)
		new /obj/item/ammo_box/a762kinetic(src)

//--------------------------------------------------------------------------//
//--------------------------------------------------------------------------//

/obj/item/ammo_box/magazine/internal/boltaction/minerjdj
	name = "GIGANTIC RIFLE BREECH THAT SHOULD NOT EXIST"
	desc = "DO NOT BREAK THE EXPENSIVE MINING EQUIPMENT (REPORT ME)"
	ammo_type = /obj/item/ammo_casing/minerjdj
	caliber = CALIBER_MINER_950
	max_ammo = 1

/obj/item/ammo_casing/minerjdj
	name = ".950 JDJ Lightning casing"
	desc = "A monster of a round for the 'Thor' Rifle, weighing over half a pound and capable of generating over 50,000 Joules of force. You might assume almost nothing could survive a round like this... but..."
	icon = 'modular_oculis/modules/saltmining/icons/ammo_item.dmi'
	icon_state = ".950"
	caliber = CALIBER_MINER_950
	projectile_type = /obj/projectile/plasma/minerjdj

/obj/projectile/plasma/minerjdj //is plasma because wall cutting
	name = ".950 JDJ solid brass mining projectile"
	desc = "you have somehow observed pure death, and it strikes fear that weaves deep within your psyche."
	speed = 5
	damage = 2500
	dismemberment = 1 //lmao
	damage_type = BRUTE
	armor_flag = BULLET //not that it will save you...
	range = 50
	icon_state = "gaussstrong"
	tracer_type = ""
	muzzle_type = ""
	impact_type = ""
	mine_range = 1
	projectile_piercing = PASSMOB
	lavafauna_mod = 10 //doom and despair

/obj/item/storage/box/kinetic/minerjdj //box containing a single bullet, as to not anger the mining vendor with the bullets dynamic description
	name = ".950 JDJ Kinetic bullet case"
	desc = "A pretty redundant small gun case that only contains a single .950 JDJ Kinetic round for the 'Thor' rifle... its more than enough honestly. It is not designed to store its contents properly, and should be emptied and disposed of immedietly."
	icon = 'modular_oculis/modules/saltmining/icons/boxes.dmi'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "miner_case_small"
	illustration = ""
	foldable_result = /obj/item/stack/sheet/iron

/obj/item/storage/box/kinetic/minerjdj/Initialize(mapload) //initialize
	. = ..()
	atom_storage.max_slots = 1
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 1
	atom_storage.set_holdable(list())

/obj/item/storage/box/kinetic/minerjdj/PopulateContents() //populate

		new /obj/item/ammo_casing/minerjdj (src)

//UNDEFINES
#undef MINER_SHOTGUN
#undef CALIBER_GOV_MINING
#undef KINETIC_20G
#undef CALIBER_A762_KINETIC
#undef CALIBER_MINER_950
