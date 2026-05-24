/datum/quirk/no_mail
	name = "Unsubscribed"
	desc = "You don't receive any mail."
	value = 0
	gain_text = span_notice("You feel less popular.")
	lose_text = span_notice("You feel more popular.")
	icon = FA_ICON_MAIL_REPLY
	mob_trait = TRAIT_NO_MAIL
	hidden = TRUE
	medical_record_text = "You shouldn't be seeing this."
