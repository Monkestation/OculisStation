#define MAX_PRONOUNS 5
// This list is non-exhaustive
GLOBAL_LIST_INIT(pronouns_valid, list(
	"he", "him", "his",
	"she","her","hers",
	"hyr", "hyrs",
	"they", "them", "their","theirs",
	"it", "its",
	"xey", "xe", "xem", "xyr", "xyrs",
	"ze", "zir", "zirs",
	"ey", "em", "eir", "eirs",
	"fae", "faer", "faers",
	"ve", "ver", "vis", "vers",
	"ne", "nem", "nir", "nirs"
))

// examples:
// "she/fae"
// "she/fae - small comment"
// "she/her/they - sysadmin"
// "they/ve - sysadmin"

// at least ONE is required
GLOBAL_LIST_INIT(pronouns_required, list(
	"he", "her", "she", "they", "them", "it", "fae", "its"
))

/datum/preference/text/ooc_pronouns
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "oocpronouns"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/text/ooc_pronouns/create_default_value()
	return ""

/datum/preference/text/ooc_pronouns/is_valid(value)
	value = lowertext(value)

	if (!value || trim(value) == "")
		return TRUE

	var/regex/reg = regex(@"^[a-z/]+", "i")
	reg.Find(value)
	if (!length(reg.match))
		to_chat(usr, span_warning("Could not find any pronouns. Make sure they are separated by slashes (/) and contain only letters."))
		return FALSE
	var/pronouns = splittext(reg.match, "/")
	if (length(pronouns) > MAX_PRONOUNS)
		to_chat(usr, span_warning("You can only set up to [MAX_PRONOUNS] different pronouns."))
		return FALSE


	for (var/pronoun in pronouns)
		// while parsing, remove common suffixes

		if (endswith(pronoun, "s"))
			pronoun = copytext(pronoun, 1, length(pronoun) - 1)
		if (endswith(pronoun, "self"))
			pronoun = copytext(pronoun, 1, length(pronoun) - 4)
		pronoun = trim(pronoun)

		if (!(pronoun in GLOB.pronouns_valid))
			to_chat(usr, span_warning("Invalid pronoun: [pronoun]. Valid pronouns are: [GLOB.pronouns_valid.Join(", ")]"))
			return FALSE

	if (length(pronouns) != length(unique_list(pronouns)))
		to_chat(usr, span_warning("You can't use the same pronoun multiple times."))
		return FALSE

	for (var/pronoun in GLOB.pronouns_required)
		if (pronoun in pronouns)
			return TRUE

	to_chat(usr, span_warning("Please include at least one of the following pronouns: [GLOB.pronouns_required.Join(", ")]"))
	// Someone may yell at me i dont know
	return FALSE

#undef MAX_PRONOUNS
