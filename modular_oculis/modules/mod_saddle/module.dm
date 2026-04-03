/obj/item/mod/module/saddle
	name = "MOD riding saddle module"
	desc = "A module specifically designed for the taurs of the galaxy. \
	When installed, this module will project a hardlight saddle to allow the wearer to carry a passenger on their back."
	icon_state = "storage"
	module_type = MODULE_TOGGLE //! should this just be passive? i personally like the ability to toggle it on and off.
	complexity = 5
	required_slots = ITEM_SLOT_BACK
	overlay_icon_file = 'modular_nova/modules/customization/modules/taur_mechanics/icons/saddles.dmi'
	overlay_state_active = "saddle_blue"

/obj/item/mod/module/saddle/proc/determine_elligible(mob/living/carbon/human/target)
	if(!istype(target))
		return FALSE

	var/obj/item/organ/taur_body/taur_body = target.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAUR)
	if (istype(taur_body) && taur_body.can_use_saddle)
		return TRUE

	return FALSE

/obj/item/mod/module/saddle/on_activation(mob/living/carbon/human/activator)
	. = ..()
	if (active && determine_elligible(activator))
		mod.AddComponent(/datum/component/carbon_saddle, RIDING_TAUR)
		mod.AddComponent(/datum/component/taur_clothing_offset)
		var/datum/component/carbon_saddle/saddle = mod.GetExactComponent(/datum/component/carbon_saddle)
		saddle.parent_equipped(activator, activator, ITEM_SLOT_BACK)
	else
		to_chat(activator, "[src]: Unable to deploy saddle, requisite anatomy not detected.")

/obj/item/mod/module/saddle/on_deactivation(mob/living/carbon/human/activator, display_message = TRUE, deleting = FALSE)
	. = ..()
	do_deactivate()

/obj/item/mod/module/saddle/on_equip()
	. = ..()
	if (active)
		if(determine_elligible(mod.wearer))
			mod.AddComponent(/datum/component/carbon_saddle, RIDING_TAUR)
			mod.AddComponent(/datum/component/taur_clothing_offset)
			var/datum/component/carbon_saddle/saddle = mod.GetExactComponent(/datum/component/carbon_saddle)
			saddle.parent_equipped(mod.wearer, mod.wearer, ITEM_SLOT_BACK)
		else
			to_chat(mod.wearer, "[src]: Unable to deploy saddle, requisite anatomy not detected.")

/obj/item/mod/module/saddle/on_unequip()
	. = ..()
	do_deactivate()

/obj/item/mod/module/saddle/proc/do_deactivate()
	var/datum/component/carbon_saddle/saddle = mod.GetExactComponent(/datum/component/carbon_saddle)
	var/datum/component/taur_clothing_offset/offset = mod.GetExactComponent(/datum/component/taur_clothing_offset)
	saddle.mob_unequipped_parent(mod.wearer)
	mod.wearer.unbuckle_all_mobs()
	if(saddle)
		qdel(saddle)
	if(offset)
		qdel(offset)

/datum/component/carbon_saddle/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_ITEM_POST_EQUIPPED) //! this seems like an oversight in the saddle_component.dm. should i just apply this there?
	UnregisterSignal(parent, COMSIG_ITEM_MOB_CAN_EQUIP)
