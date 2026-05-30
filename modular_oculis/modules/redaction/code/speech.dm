#define REDACTION_FILTER_CHECK(T) (SSredaction.redacted_words_regex && findtext(T, SSredaction.redacted_words_regex))

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
	if(!lowertext(REDACTION_FILTER_CHECK(message)))
		return ..()
	message = SSredaction.redact_sentence(message, src)
	..()

#undef REDACTION_FILTER_CHECK
