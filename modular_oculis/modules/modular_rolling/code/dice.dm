/datum/emote/roll
	key = "roll"
	affected_by_pitch = FALSE

/datum/emote/roll/run_emote(mob/user, params, type_override, intentional)
	. = ..()

	var/given_text = params
	user.client?.looc_message("[user] rolls [given_text] and gets [given_text].")
