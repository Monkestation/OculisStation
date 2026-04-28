/datum/reagent/manganese
	name = "Manganese"
	description = "A silvery-gray metal that resembles iron. It is hard and very brittle, difficult to fuse, but easy to oxidize."
	color = "#3D3C47"
	taste_description = "metal"
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

// New blood packs
/obj/item/reagent_containers/blood/haemocyanin
	blood_type = "Haemocyanin"

/obj/item/reagent_containers/blood/chlorocruorin
	blood_type = "Chlorocruorin"

/obj/item/reagent_containers/blood/hemerythrin
	blood_type = "Hemerythrin"

/obj/item/reagent_containers/blood/pinnaglobin
	blood_type = "Pinnaglobin"

/obj/item/reagent_containers/blood/exotic
	blood_type = "Exotic"

// OCULIS ADDITION START

/obj/item/reagent_containers/blood/haemoglobin
	blood_type = "Haemoglobin"

/obj/item/reagent_containers/blood/haemotoxin
	blood_type = "Haemotoxin"

/obj/item/reagent_containers/blood/nanoblood
	blood_type = "Nanomachine Infused Blood"

// OCULIS ADDITION END

/datum/supply_pack/medical/bloodpacks/uncommon
	name = "Uncommon Blood Pack Variety Crate"
	desc = "Contains sixteen different uncommmon blood packs for reintroducing blood to patients." // OCULIS EDIT
	cost = CARGO_CRATE_VALUE * 11 // about 1.6x the price of regular blood crate, since there's that much more blood in this one // OCULIS EDIT
	contains = list(
		/obj/item/reagent_containers/blood/haemocyanin = 2,
		/obj/item/reagent_containers/blood/chlorocruorin = 2,
		/obj/item/reagent_containers/blood/hemerythrin = 2,
		/obj/item/reagent_containers/blood/pinnaglobin = 2,
		/obj/item/reagent_containers/blood/exotic = 2,
		/obj/item/reagent_containers/blood/haemoglobin = 2, // OCULIS ADDITION
		/obj/item/reagent_containers/blood/haemotoxin = 2, // OCULIS ADDITION
		/obj/item/reagent_containers/blood/nanoblood = 2, // OCULIS ADDITION
	)
	crate_name = "blood freezer"
	crate_type = /obj/structure/closet/crate/freezer
