/// A character quirk that removes the mechanical effects of mood, including movespeed and actionspeed buffs and debuffs.
/datum/quirk/no_mood_effects
	name = "No Mood Effects"
	desc = "(OOC) Your character will not be affected by positive or negative mechanical mood effects."
	value = 0
	gain_text = span_notice("You feel physically unaffected by your mood.")
	lose_text = span_notice("You feel physically affected by your mood.")
	icon = FA_ICON_FACE_MEH_BLANK
	mob_trait = TRAIT_NO_MOOD_EFFECTS
	hidden = TRUE
	medical_record_text = "(OOC) You shouldn't be seeing this. Quirk: No Mood Effects"

/datum/quirk/no_mood_effects/add(client/client_source) // remove sanity effects
	quirk_holder.remove_movespeed_modifier(MOVESPEED_ID_SANITY)
	quirk_holder.remove_actionspeed_modifier(ACTIONSPEED_ID_SANITY)
