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
