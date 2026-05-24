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

/obj/item/organ/liver/lizard
	name = "lizard liver"
	icon = 'modular_oculis/modules/unique_lizards/icons/surgery.dmi'
	icon_state = "liver-l"
	desc = "Due to a low number of natural poisons on Tizira, lizard livers have a lower tolerance for poisons when compared to human ones."
	toxTolerance = 2

/obj/item/organ/stomach/lizard
	name = "lizard stomach"
	icon = 'modular_oculis/modules/unique_lizards/icons/surgery.dmi'
	icon_state = "stomach-l"
	desc = "Lizards have evolved highly efficient stomachs, made to get nutrients out of what they eat as fast as possible."
	metabolism_efficiency = 0.07

/obj/item/organ/stomach/lizard/handle_hunger(mob/living/carbon/human/human, seconds_per_tick)
	. = ..()
	if(human.nutrition > NUTRITION_LEVEL_WELL_FED && human.nutrition < NUTRITION_LEVEL_FULL)
		human.adjust_brute_loss(-0.5 * seconds_per_tick)
