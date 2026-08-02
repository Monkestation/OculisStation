/datum/emote/living/squeal
	key = "squeal"
	key_third_person = "squeals"
	message = "squeals!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_oculis/modules/emotes/sound/squeal.ogg' // Taken from Monkestation

/datum/emote/living/tailthump
	key = "tailthump"
	key_third_person = "thumps their tail"
	message = "thumps their tail!"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_oculis/modules/emotes/sound/tailthump.ogg' // Taken from Monkestation

/datum/emote/living/tailthump/can_run_emote(mob/user, status_check, intentional, params)
	var/obj/item/organ/tail/tail = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(tail)
		return ..()
	return FALSE

/mob/proc/emote_roll2d6()
	set name = "| Roll 2d6 |"
	set category = "Emotes"
	usr.emote("roll2d6", intentional = TRUE)

/datum/emote/roll2d6
	key = "roll2d6"
	affected_by_pitch = FALSE

/datum/emote/roll2d6/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/roll1 = roll(6)
	var/roll2 = roll(6)
	var/result = roll1 + roll2
	user.client?.looc_message("[user] rolls 2d6 and gets [roll1]+[roll2]=[result].")
