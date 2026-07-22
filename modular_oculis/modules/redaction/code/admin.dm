
ADMIN_VERB(redact_word, R_ADMIN, "Redact Word", "Redacts a word from everyone in the game, replacing it with noise.", ADMIN_CATEGORY_EVENTS)
	var/redacted_word = SSredaction.add_word(user.mob)

	if(!redacted_word)
		return

	log_admin("[key_name(user.mob)] redacted the word: [redacted_word]")
	message_admins("[key_name_admin(user.mob)] redacted the word: [redacted_word]")
	SSblackbox.record_feedback("tally", "redact_word", 1, "Redacted the word: [redacted_word]") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

ADMIN_VERB(allow_word, R_ADMIN, "Allow Word", "Allows a word to be spoken by everyone in the game.", ADMIN_CATEGORY_EVENTS)
	if(!length(SSredaction.redacted_words))
		return

	var/allowed_word = SSredaction.remove_word(user.mob)

	log_admin("[key_name(user.mob)] allowed the word: [allowed_word]")
	message_admins("[key_name_admin(user.mob)] allowed the word: [allowed_word]")
	SSblackbox.record_feedback("tally", "allow_word", 1, "Allowed the word: [allowed_word]") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
