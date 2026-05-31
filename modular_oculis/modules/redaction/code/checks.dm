/mob/living/say(
	message,
	bubble_type,
	list/spans = list(),
	sanitize = TRUE,
	datum/language/language,
	ignore_spam = FALSE,
	forced,
	filterproof = FALSE,
	message_range = 7,
	datum/saymode/saymode,
	list/message_mods = list(),
)
	if(!REDACTION_FILTER_CHECK(message))
		return ..()
	message = SSredaction.redact_sentence(message, src)
	..()

/obj/item/paper/add_raw_text(text, font, color, bold, advanced_html, mob/user)
	if(!REDACTION_FILTER_CHECK(text))
		return ..()
	text = SSredaction.redact_sentence(text, user)
	return ..()

/mob/living/treat_message(message, tts_message, tts_filter, capitalize_message = TRUE)
	if(!REDACTION_FILTER_CHECK(message))
		return ..()
	message = SSredaction.redact_sentence(message, src)
	return ..()

/datum/action/cooldown/spell/pointed/telepathy/send_thought(mob/living/caster, mob/living/target, message)
	if(!REDACTION_FILTER_CHECK(message))
		return ..()
	message = SSredaction.redact_sentence(message, src)
	return ..()

/datum/signal/subspace/messaging/tablet_message/format_message()
	if(!REDACTION_FILTER_CHECK(data["message"]))
		return ..()
	data["message"] = SSredaction.redact_sentence(data["message"], src)
	return ..()

/datum/pda_chat/add_message(datum/pda_message/message, show_in_recents = TRUE)
	if(!REDACTION_FILTER_CHECK(message.message))
		return ..()
	message.message = SSredaction.redact_sentence(message.message, src)
	return ..()

/datum/computer_file/program/messenger/sanitize_pda_message(message, mob/sender)
	if(!REDACTION_FILTER_CHECK(message))
		return ..()
	message = SSredaction.redact_sentence(message, sender)
	return ..()

/datum/ntnet_conversation/add_message(message, username)
	if(!REDACTION_FILTER_CHECK(message))
		return ..()
	message = SSredaction.redact_sentence(message, src)
	return ..()

/datum/nifsoft/soul_poem/add_message(sender_identifier, received_name, received_message)
	if(!REDACTION_FILTER_CHECK(received_message))
		return ..()
	received_message = SSredaction.redact_sentence(received_message, src)
	return ..()

/datum/computer_file/program/notepad/ui_data(mob/user)
	if(!REDACTION_FILTER_CHECK(written_note))
		return ..()
	written_note = SSredaction.redact_sentence(written_note, user)
	return ..()
