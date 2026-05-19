/datum/quirk/featherquirk
	name = "Feathered"
	desc = "You got feathers, wherever they are. One way or another, you drop them when hit."
	mob_trait = TRAIT_FEATHERED
	icon = FA_ICON_FEATHER
	value = 0
//feathered quirk, oculis addition n shit
/datum/quirk/featherquirk/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder

	human_holder.AddComponent(/datum/component/pinata, candy = list(/obj/item/feather))

/datum/quirk/featherquirk/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder

	var/datum/component/pinata/feathered_removal = human_holder.GetExactComponent(/datum/component/pinata)
	feathered_removal.Destroy()
