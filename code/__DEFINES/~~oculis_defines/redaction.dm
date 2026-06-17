#define REDACTION_FILTER_CHECK(T) (SSredaction.redacted_words_regex && findtext(T, SSredaction.redacted_words_regex))
