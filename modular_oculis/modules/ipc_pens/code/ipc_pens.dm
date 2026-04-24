// ITEMS

/obj/item/reagent_containers/hypospray/medipen/synthcare
	name = "Small Synthetic Care Pen"
	desc = "A single use applicator made to care for synthetic parts on the go anywhere, be it a single prosthetic or an IPC. Contains chemicals that are safe but otherwise worthless for organics. <b> WARNING : DO NOT APPLY A SECOND APPLICATOR UNTIL FIRST HAS FULLY PROCESSED. FAILURE TO FOLLOW INSTRUCTIONS CAN PROVE HAZARDOUS TO SYNTHETICS. DOES NOT WORK ON CYBORGS. UNDER NO CIRCUMSTANCES IS THIS TO BE MIXED WITH ADVANCED NANITE SLURRY (FOUND IN THE ADVANCED SYNTHETIC CARE PEN)</b>"
	icon = 'modular_oculis/modules/ipc_pens/icons/syringe.dmi'
	icon_state = "synthpen"
	base_icon_state = "synthpen"
	amount_per_transfer_from_this = 9
	volume = 9
	list_reagents = list(/datum/reagent/medicine/nanite_slurry = 9)

/obj/item/reagent_containers/hypospray/medipen/synthcare/luxury
	name = "Advanced Synthetic Care Pen"
	desc = "A single use applicator made to rapidly fix urgent damage to synthetic parts on the go in low pressure enviorments and provide a small speed boost. Contains chemicals that are safe but otherwise worthless for organics. <b> WARNING : DO NOT APPLY A SECOND APPLICATOR UNTIL FIRST HAS FULLY PROCESSED. FAILURE TO FOLLOW INSTRUCTIONS IS GURANTEED TO BE LETHAL TO SYNTHETICS. DOES NOT WORK ON CYBORGS. UNDER NO CIRCUMSTANCES IS THIS TO BE MIXED WITH BASIC NANITE SLURRY (FOUND IN THE SMALL SYNTHETIC CARE PEN)</b>"
	icon_state = "synthpen_lux"
	base_icon_state = "synthpen_lux"
	amount_per_transfer_from_this = 10
	volume = 10
	list_reagents = list(/datum/reagent/medicine/nanite_slurry/strong = 9, /datum/reagent/medicine/stimulants = 1)

/obj/item/reagent_containers/hypospray/medipen/synthcare/meth
	name = "Servo Overclocker Pen"
	desc = "A single use applicator made to temporarily overclock an IPC's servos. Contains chemicals that are safe but otherwise worthless for organics, somehow. <b> WARNING : DEFOREST IS NOT RESPONSIBLE FOR ANY DAMAGE CAUSED TO SYNTHETIC PROPERTY FROM USE OF THIS MEDIPEN</b>"
	icon_state = "synthpen_meth"
	base_icon_state = "synthpen_meth"
	amount_per_transfer_from_this = 10
	volume = 10
	list_reagents = list(/datum/reagent/drug/methamphetamine/robo = 10)

// IPC CHEMS

/datum/reagent/medicine/nanite_slurry/strong
	name = "Super Nanite Slurry"
	description = "A localized swarm of advanced nanomachines specialized in repairing mechanical parts rapidly. While concentrated amounts will safely purge from an organic host, in a synthetic host the friction will cause them to overheat and melt violently."
	overdose_threshold = 10
	/// How much brute and burn individually is healed per tick
	healing = 5
	/// How much body temperature is increased by per overdose cycle on robotic bodyparts.
	temperature_change = 100

/datum/reagent/medicine/nanite_slurry/strong/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick)
	var/heal_amount = healing * REM * seconds_per_tick
	affected_mob.heal_bodypart_damage(heal_amount, heal_amount, required_bodytype = BODYTYPE_ROBOTIC)
	return ..()

/datum/reagent/medicine/nanite_slurry/strong/overdose_start(mob/living/affected_mob)
	if(affected_mob.mob_biotypes & MOB_ROBOTIC)
		to_chat(affected_mob, span_danger("The nanomachines inside you are overheating due to the high concentration, you have mere moments to live!"))
	else
		to_chat(affected_mob, span_danger("Your stomach lurches as concentrations of nanites begin disposing of themselves."))

/datum/reagent/medicine/nanite_slurry/strong/overdose_process(mob/living/carbon/affected_mob, seconds_per_tick, times_fired) // Mostly to treat a synthetic being EMP'd
	if(affected_mob.mob_biotypes & MOB_ROBOTIC)
		affected_mob.adjust_bodytemperature(temperature_change * REM * seconds_per_tick) // Overheats
		affected_mob.take_bodypart_damage(burn = (healing * REM * seconds_per_tick) * 1.5) // Burns up
		return ..()
	affected_mob.reagents.remove_reagent(type, 4) //gets removed from organics very fast
	if(prob(25))
		affected_mob.vomit(vomit_type = /obj/effect/decal/cleanable/chem_pile)
	return TRUE

/datum/chemical_reaction/reagent_explosion/nanite_mismatch //these nanite types are not compatible with each other! do not mix!!!
	required_reagents = list(/datum/reagent/medicine/nanite_slurry/strong = 1, /datum/reagent/medicine/nanite_slurry = 1)
	strengthdiv = 3
	modifier = 3

/datum/reagent/drug/methamphetamine/robo
	name = "Positronic Excitement Salts"
	description = "An experimental excitement chemical for synthetic life, this produces a similar effect to methamphetamine, but on robots."
	metabolized_traits = list(TRAIT_ANALGESIA)
	process_flags = REAGENT_SYNTHETIC
	color = "#FAFAFA"
	overdose_threshold = 11

/datum/chemical_reaction/positronic_excitation_salts
	results = list(/datum/reagent/drug/methamphetamine/robo = 1)
	required_reagents = list(/datum/reagent/drug/methamphetamine = 1, /datum/reagent/dinitrogen_plasmide = 1)
	reaction_tags = REACTION_TAG_DRUG | REACTION_TAG_EASY

// CARGO LISTINGS

/datum/supply_pack/companies/medical/synthpen
	contains = list(/obj/item/reagent_containers/hypospray/medipen/synthcare)
	cost = CARGO_CRATE_VALUE * 0.5

/datum/supply_pack/companies/medical/synthpen/luxury
	contains = list(/obj/item/reagent_containers/hypospray/medipen/synthcare/luxury)
	cost = CARGO_CRATE_VALUE * 1.5

/datum/supply_pack/companies/medical/synthpen/meth
	contains = list(/obj/item/reagent_containers/hypospray/medipen/synthcare/meth)
	cost = CARGO_CRATE_VALUE * 1.75
