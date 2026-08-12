/datum/emote/roll
	key = "roll"
	affected_by_pitch = FALSE
	message = null

/datum/emote/roll/run_emote(mob/user, params, type_override, intentional)
	// Check if its a valid dice combination.
	var/static/regex/compatible_line_regex = regex("\[0-9\]+d\[0-9\]+", "g")
	if(!findtext(params, compatible_line_regex))
		to_chat(user, span_warning("That's not a valid dice combination! Please use the combination of \[dice amount\]d\[dice sides\] and optionally \[+-number\]. Like so: 2d20+5 or 2d20"))
		return FALSE

	// Do we have a reason given?
	var/reason
	var/list/split_text = splittext(params, " ") // This can actually have more than one word in the reason
	var/dice_text = split_text[1] // so we take the first part (the dice and modifier)
	split_text -= dice_text // and set it aside
	if(length(split_text)) // and make the rest the reason.
		reason = jointext(split_text, " ")

	// Do we have a modifier?
	var/modifier = findtext(dice_text, regex("\\+\[0-9\]+|-\[0-9\]+", "g"))
	var/list/text_without_modifier
	if(modifier)
		text_without_modifier = splittext(dice_text, modifier)
	else
		text_without_modifier = list(dice_text)

	// Time to do actual dice calculations.
	var/list/split_dice_text = splittext(text_without_modifier[1], "d")
	var/dice_count = split_dice_text[1]
	var/dice_sides = split_dice_text[2]

	// Roll the dice.
	var/answer = roll("[dice_count]d[dice_sides][modifier]")

	user.client?.looc_message("[user] rolls [dice_count]d[dice_sides][modifier] and gets [answer]. [reason ? "Reason: [reason]" : null]")
	params = null
	return ..()
