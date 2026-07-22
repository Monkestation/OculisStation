/datum/orderable_item/accelerator/gun/shockwave
	purchase_path = /obj/item/storage/box/shockwave
	cost_per_order = 1250

/datum/orderable_item/mining/gardener
	purchase_path = /obj/item/shovel/gardener
	desc = "A special shovel meant for beating lavaland fauna to death... its not very good at it... "
	cost_per_order = 500

/datum/orderable_item/mining/holsterwastes
	purchase_path = /obj/item/storage/belt/holster/wasteland
	desc = "A special holster that only has space for any wasteland gun, but fits in your suit storage or belt."
	cost_per_order = 1000

/datum/orderable_item/mining/rockspider
	purchase_path = /obj/item/storage/backpack/rockspider
	desc = "A specialized backpack for carrying up to three ranged mining weapons. Will not slow you down with a satchel."
	cost_per_order = 1000

/datum/orderable_item/mining/ashduelist
	purchase_path = /obj/item/storage/backpack/ashduelist
	desc = "A specialized backpack for carrying a crusher and a ranged mining weapon. Will not slow you down with a satchel"
	cost_per_order = 1000

/datum/orderable_item/mining/trenchjockey
	purchase_path = /obj/item/storage/backpack/trenchjockey
	desc = "A specialized backpack for carrying lots of wasteland gun ammo. Will not slow you down with a satchel."
	cost_per_order = 1000

/datum/orderable_item/mining/surpluscrate
	purchase_path = /obj/structure/closet/crate/necropolis/surplus
	desc = "An old busted open necropolis crate from an old science warehouse. Does not require a key, however it has a sticker on it that reads <b> Quality Not Guranteed <b/>."
	cost_per_order = 3500 //EXPERIMENTAL, ORIGINAL PRICE IS 5000. THIS MIGHT BE TOO LOW BUT WE ARE ALL HERE TO HAVE FUN.

/datum/orderable_item/wasteland //This is for any weapon that uses ammo (and the ammo) for shaft miners, and by extension SHOULD have a wasteland pin
	category_index = CATEGORY_WASTELAND_GUNS

/datum/orderable_item/wasteland/pksmg
	purchase_path = /obj/item/storage/box/pksmg
	desc = "A recyclable case containing a 'Rapier' Mining SMG and three magazines to get you started."
	cost_per_order = 1750

/datum/orderable_item/wasteland/smallsmgammo
	purchase_path = /obj/item/storage/box/kinetic/small
	desc = "A case containing two seperate magazines for the PKSMG."
	cost_per_order = 150

/datum/orderable_item/wasteland/smgammo
	purchase_path = /obj/item/storage/box/kinetic
	desc = "A box containing seven magazines for the PKSMG that also fits in explorer webbing."
	cost_per_order = 500

/datum/orderable_item/wasteland/pkshotgun
	purchase_path = /obj/item/storage/box/kinetic/shotgun/bigcase
	desc = "A case containing a PKShotgun along with four lethal shells and eight mining shells."
	cost_per_order = 2500

/datum/orderable_item/wasteland/magnumbuck
	purchase_path = /obj/item/storage/box/kinetic/shotgun
	desc = "A box containing ten Magnum Kinetic Buckshot shells for the PKShotgun. Fits in explorer webbing."
	cost_per_order = 500

/datum/orderable_item/wasteland/sniperslug
	purchase_path = /obj/item/storage/box/kinetic/shotgun/sniperslug
	desc = "A box containing ten 50 BMG Slug shells for the PKShotgun. Still penetrates rock walls but not fauna. Trades potential damage for range and reliability. Fits in explorer webbing."
	cost_per_order = 650

/datum/orderable_item/wasteland/rockbreaker
	purchase_path = /obj/item/storage/box/kinetic/shotgun/rockbreaker
	desc = "A box containing twenty Rockbreaker shells for the PKShotgun, designed to destroy masses of rock but do very little damage to fauna. Fits in explorer webbing."
	cost_per_order = 300

/datum/orderable_item/wasteland/miningrevolver
	purchase_path = /obj/item/storage/box/kinetic/govmining/bigcase
	cost_per_order = 1750

/datum/orderable_item/wasteland/miningrevolver/spareshells
	purchase_path = /obj/item/storage/box/kinetic/govmining
	cost_per_order = 650

/datum/orderable_item/wasteland/miningrevolver/sparemags
	purchase_path = /obj/item/storage/box/kinetic/govmining/smallcase
	cost_per_order = 1500

/datum/orderable_item/wasteland/fenrir
	purchase_path = /obj/item/storage/box/kinetic/autoshotgun/bigcase
	cost_per_order = 2000

/datum/orderable_item/wasteland/fenrir/spareshells
	purchase_path = /obj/item/storage/box/kinetic/autoshotgun
	cost_per_order = 650

/datum/orderable_item/wasteland/fenrir/sparemags
	purchase_path = /obj/item/storage/box/kinetic/autoshotgun/smallcase
	cost_per_order = 1500

/datum/orderable_item/wasteland/hellhound
	purchase_path = /obj/item/storage/box/kinetic/kineticlmg/bigcase
	cost_per_order = 2000

/datum/orderable_item/wasteland/hellhound/spareshells
	purchase_path = /obj/item/storage/box/kinetic/kineticlmg
	cost_per_order = 1000

/datum/orderable_item/wasteland/jdj
	purchase_path = /obj/item/storage/box/kinetic/minerjdj/bigcase
	cost_per_order = 115385 //really weird number however its specifically set to this to make shuttle buy a clean 75k points. This thing should demolish your wallet as violently as your enemies
//also as a side note if this is too low im willing to increase it to 100k for a shuttle buy, im yet to see how the 75k points holds up to rounds that cap at 5 hours.
/datum/orderable_item/wasteland/jdj/spareshells
	purchase_path = /obj/item/storage/box/kinetic/minerjdj
	cost_per_order = 76923 //same reason as above, this puts it at 50k for a shuttle buy
