SUBSYSTEM_DEF(redaction)
	name = "1984" //Because we are redacting text. Literally 1984.
	ss_flags = SS_NO_FIRE

	var/static/regex/redacted_words_regex
	var/list/redacted_words

/datum/controller/subsystem/redaction/Initialize()
	redacted_words = new()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/redaction/proc/add_word(mob/user)
	var/word = tgui_input_text(user, "Enter a word to redact from everyone.", "Word Redaction", null)
	if(!word)
		return
	redacted_words |= lowertext(word)
	reinitialize_regex()
	return word

/datum/controller/subsystem/redaction/proc/remove_word(mob/user)
	var/word = tgui_input_list(user, "Select a word to approve.", "Word Approval", redacted_words, null)
	if(!word)
		return
	redacted_words -= lowertext(word)
	reinitialize_regex()
	return word

/datum/controller/subsystem/redaction/proc/reinitialize_regex()
	var/list/filter = list()
	for(var/line as anything in redacted_words)
		filter += REGEX_QUOTE(line)
	redacted_words_regex = filter.len ? regex("\\b([jointext(filter, "|")])\\b", "i") : null

#define REDACTION "█"

/datum/controller/subsystem/redaction/proc/redact_sentence(sentence, mob/user)
	var/character_count = length(SSredaction.redacted_words_regex.match)

	var/generated_redaction = ""
	for(var/i in 1 to character_count)
		generated_redaction += REDACTION

	var/redacted_sentence = replacetext(sentence, SSredaction.redacted_words_regex.match, generated_redaction)
	message_admins("[ADMIN_LOOKUPFLW(user)]] attempted to say the word: [SSredaction.redacted_words_regex.match]")
	return redacted_sentence

#undef REDACTION
