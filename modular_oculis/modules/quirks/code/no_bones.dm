/datum/quirk/no_bones
	name = "Boneless"
	desc = "You lack any bones."
	value = 1
	gain_text = span_notice("You feel like gelatin.")
	lose_text = span_notice("You feel more sturdy.")
	medical_record_text = "Patient lacks any bones."
	icon = FA_ICON_BONE

/datum/quirk/no_bones/post_add()
	for(var/obj/item/bodypart/possible_limb in quirk_holder.get_bodyparts())
		if(LIMB_HAS_BONES(possible_limb))
			possible_limb.biological_state &= ~BIO_BONE

/datum/quirk/no_bones/remove()
	for(var/obj/item/bodypart/possible_limb in quirk_holder.get_bodyparts())
		if(initial(possible_limb.biological_state) & BIOSTATE_HAS_BONES)
			possible_limb.biological_state |= BIO_BONE
