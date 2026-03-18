/obj/item/organ/lungs/slime
	safe_oxygen_min = 4 //We don't need much oxygen to subsist.

/obj/item/organ/lungs/slime/Initialize(mapload)
	. = ..()
	add_gas_reaction(/datum/gas/water_vapor, while_present = PROC_REF(melt_lungs))

/obj/item/organ/lungs/slime/proc/melt_lungs(mob/living/carbon/breather, datum/gas_mixture/breath, h2o_pp, old_h2o_pp)
	if(h2o_pp > 1)
		var/ratio = CLAMP01((h2o_pp - 1) / 7)
		var/lung_damage  = 5  * ratio
		var/blood_damage = 15 * ratio
		apply_organ_damage(lung_damage)
		breather.adjust_blood_volume(-blood_damage)

		if(prob(20) && h2o_pp < 3)
			breather.emote("cough")
		if(prob(20) && h2o_pp >= 3)
			breather.emote("wheeze")
			breather.adjust_oxy_loss(rand(4, 8))
			to_chat(owner, span_userdanger("Your lungs feel like they are liquefying!"))

/obj/item/organ/lungs/slime/slime_smoker
	name = "smoker slime vacuole"
	desc = "A large organelle designed to store oxygen and other important gasses, now discolored from heavy smoking."
	maxHealth = /obj/item/organ/lungs/smoker_lungs::maxHealth
	healing_factor = /obj/item/organ/lungs/smoker_lungs::healing_factor
