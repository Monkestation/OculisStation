/datum/emote/roll
	key = "roll"
	affected_by_pitch = FALSE
	message = null

/datum/emote/roll/run_emote(mob/user, params, type_override, intentional)
	// Check if its a valid dice combination.
	var/static/regex/compatible_line_regex = regex("\[0-9\]+d\[0-9\]+", "g")
	if(!findtext(params, compatible_line_regex))
		to_chat(user, span_warning("That's not a valid dice combination! Please use the combination of \[dice amount\]d\[dice sides\] and optionally \[+-number\] or \[reason\]! Like so: 2d20 or 2d20+5 or 2d20+5 reason."))
		return FALSE

	// Do we have a reason given?
	var/reason
	var/list/split_text = splittext(params, " ") // This can actually have more than one word in the reason
	var/dice_text = split_text[1] // so we take the first part (the dice and modifier)
	split_text -= dice_text // and set it aside
	if(length(split_text)) // and make the rest the reason.
		reason = jointext(split_text, " ")

	// Do we have a modifier?
	var/modifier = findtext(dice_text, regex("\\+\[0-9\]+|\\-\[0-9\]+", "g"))
	modifier = modifier ? modifier : null // Purely because findtext proc returns 0 instead of null on finding nothing.
	var/list/text_without_modifier
	if(modifier)
		text_without_modifier = splittext(dice_text, modifier)
	else
		text_without_modifier = list(dice_text)

	// Time to do actual dice calculations. And sanitization.
	var/list/split_dice_text = splittext(text_without_modifier[1], "d")
	// If at this point we ever have anything that isnt a normal number, take the first number and ignore the rest.
	var/dice_count = splittext(split_dice_text[1], regex("[0-9]+"))
	dice_count = dice_count[1]
	var/dice_sides = splittext(split_dice_text[2], regex("[0-9]+"))
	dice_sides = dice_sides[1]

	// Roll the dice.
	var/answer = roll("[dice_count]d[dice_sides][modifier]")

	user.client?.looc_message("[user] rolls [dice_count]d[dice_sides][modifier] and gets [answer].[reason ? " Reason: [reason]" : null]")
	params = null
	return ..()
