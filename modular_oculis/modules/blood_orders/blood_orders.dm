/datum/supply_pack/medical/bloodpack
	group = "★ Medical Supplies"
	crate_name = "blood freezer"
	crate_type = /obj/structure/closet/crate/freezer
	order_flags = ORDER_COMPANY
	discountable = SUPPLY_PACK_UNCOMMON_DISCOUNTABLE
	cost = CARGO_CRATE_VALUE

/datum/supply_pack/medical/bloodpack/nabber
	contains = list(/obj/item/reagent_containers/blood/nabber)
	name = "blood pack - H"
	desc = "Contains blood used for transfusion. Must be attached to an IV drip. This deep blue blood is meant for Giant Armoured Serpentids."

/datum/supply_pack/medical/bloodpack/vox
	contains = list(/obj/item/reagent_containers/blood/vox)
	name = "blood pack - VO"
	desc = "Contains blood used for transfusion. Must be attached to an IV drip. This light blue blood is meant for Vox, both types."

/datum/supply_pack/medical/bloodpack/skrell
	contains = list(/obj/item/reagent_containers/blood/skrell)
	name = "blood pack - SK"
	desc = "Contains blood used for transfusion. Must be attached to an IV drip. This copper colored blood is meant for Skrell."

/datum/supply_pack/medical/bloodpack/snail
	contains = list(/obj/item/reagent_containers/blood/snail)
	name = "blood pack - S"
	desc = "Contains blood used for transfusion. Must be attached to an IV drip. It's a bit slimy... The label indicates that this is meant for snails."

/datum/supply_pack/medical/bloodpack/arachnid
	contains = list(/obj/item/reagent_containers/blood/arachnid)
	name = "blood pack - CU"
	desc = "Contains blood used for transfusion. Must be attached to an IV drip. Copper based blood, very blue. The label indicates that this is meant for arachnids."
