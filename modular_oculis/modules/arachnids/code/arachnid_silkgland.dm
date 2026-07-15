/obj/item/organ/silkgland
	name = "silk gland"
	desc = "The silk actually comes out of your wrists, this is just the thing that produces it."
	icon = 'modular_oculis/modules/arachnids/icons/organs.dmi'
	icon_state = "arachnid_silkgland"
	visual = FALSE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_GLAND
	w_class = WEIGHT_CLASS_SMALL
	var/datum/action/innate/arachnid_silk/arachnid_silk

/datum/action/innate/arachnid_silk
	name = "Sericulture"
	desc = "Create a piece of silk for arts and crafts. Consumes nutrition and cannot be done if starving."
	check_flags = AB_CHECK_INCAPACITATED | AB_CHECK_CONSCIOUS | AB_CHECK_HANDS_BLOCKED // Can't do it if you're missing your arms!
	button_icon_state = "web"
	button_icon = 'modular_oculis/modules/arachnids/icons/actions_arachnid.dmi'
	overlay_icon_state = "bg_alien_border"

/obj/item/organ/silkgland/on_mob_insert(mob/living/carbon/organ_owner)
	. = ..()
	if(QDELETED(arachnid_silk))
		arachnid_silk = new
	arachnid_silk.Grant(organ_owner)

/obj/item/organ/silkgland/on_mob_remove(mob/living/carbon/organ_owner)
	. = ..()
	QDEL_NULL(arachnid_silk)

/obj/item/organ/silkgland/Destroy()
	QDEL_NULL(arachnid_silk)
	return ..()

/datum/action/innate/arachnid_silk/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE

/datum/action/innate/arachnid_silk/Activate()
	var/mob/living/carbon/human/spider = owner
	if(DOING_INTERACTION(owner, "making_silk"))
		to_chat(spider, span_warning("Already weaving!"))
		return
	while(owner.nutrition > NUTRITION_LEVEL_VERY_HUNGRY && do_after(owner, 3 SECONDS, interaction_key = "making_silk"))
		to_chat(spider, span_notice("You produce a piece of silk from your wrists."))
		owner.adjust_nutrition(-10)
		var/obj/item/stack/sheet/silk/produced_silk = new /obj/item/stack/sheet/silk
		owner.put_in_hands(produced_silk)

	to_chat(spider, span_warning("You fail to produce any silk.")) //The owner moved or is too hungry.
