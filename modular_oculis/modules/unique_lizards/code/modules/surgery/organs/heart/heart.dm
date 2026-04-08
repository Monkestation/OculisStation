/obj/item/organ/heart/second_heart
	name = "second heart"
	desc = "Wow, those lizards sure are full of heart."
	icon = 'modular_oculis/modules/unique_lizards/icons/surgery.dmi'
	icon_state = "second_heart"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_HEART_AID
	healing_factor = 1.5 * STANDARD_ORGAN_HEALING
	decay_factor = 1.5 * STANDARD_ORGAN_DECAY
	attack_verb_continuous = list("beats", "thumps")
	attack_verb_simple = list("beat", "thump")
	/// How much blood we regenerate
	var/regen_modifier = 0.5

/obj/item/organ/heart/second_heart/on_life(seconds_per_tick)
	..()
	if(!owner.needs_heart() || owner.blood_volume >= BLOOD_VOLUME_NORMAL)
		return
	if(organ_flags & ORGAN_FAILING)
		var/bleed_amount = 0
		for(var/obj/item/bodypart/part as anything in owner.bodyparts)
			bleed_amount += part.cached_bleed_rate * seconds_per_tick
		if(bleed_amount)
			owner.bleed(bleed_amount)
			owner.bleed_warn(bleed_amount)
		else
			owner.blood_volume = min(owner.blood_volume + (BLOOD_REGEN_FACTOR * regen_modifier * seconds_per_tick), BLOOD_VOLUME_NORMAL)
