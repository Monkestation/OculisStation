SUBSYSTEM_DEF(redaction)
	name = "1984" //Because we are redacting text. Literally 1984.
	ss_flags = SS_NO_FIRE

	var/static/regex/redacted_words_regex
	var/list/redacted_words

/datum/controller/subsystem/redaction/Initialize()
	redacted_words = new()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/redaction/proc/add_word(mob/user)
	var/word = tgui_input_text(user, "Enter a word to redact from everyone.", "Word Redaction", null, encode = FALSE)
	if(!word)
		return
	redacted_words |= LOWER_TEXT(word)
	reinitialize_regex()
	return word

/datum/controller/subsystem/redaction/proc/remove_word(mob/user)
	var/word = tgui_input_list(user, "Select a word to approve.", "Word Approval", redacted_words, null)
	if(!word)
		return
	redacted_words -= LOWER_TEXT(word)
	reinitialize_regex()
	return word

/datum/controller/subsystem/redaction/proc/reinitialize_regex()
	var/list/filter = list()
	for(var/line in redacted_words)
		filter += REGEX_QUOTE(line)
	redacted_words_regex = filter.len ? regex("\\b([jointext(filter, "|")](?:s|es|ed|ing|er|ers|est|ly|ness|ment|ments)?)\\b", "gi") : null

/datum/controller/subsystem/redaction/proc/redact_sentence(sentence, mob/user)
	var/redacted_sentence = replacetext_char(sentence, SSredaction.redacted_words_regex, GLOBAL_PROC_REF(replace_with_redactions))
	message_admins("[ADMIN_LOOKUPFLW(user)]] attempted to say the word: [SSredaction.redacted_words_regex.match]")
	return redacted_sentence

#define REDACTION "█"

/proc/replace_with_redactions(text)
	. = ""
	for(var/i = 1 to length_char(text))
		. += REDACTION

#undef REDACTION
