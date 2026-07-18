/datum/blood_type/arachnid
	name = BLOOD_TYPE_ARACHNID

	desc = "Copper based blood, very blue."
	dna_string = "Arachnid DNA"

	color = BLOOD_COLOR_ARACHNID
	reagent_type = /datum/reagent/blood

	restoration_chem = /datum/reagent/copper
	compatible_types = list(
		/datum/blood_type/arachnid
	)

/obj/item/reagent_containers/blood/arachnid
	blood_type = BLOOD_TYPE_ARACHNID
