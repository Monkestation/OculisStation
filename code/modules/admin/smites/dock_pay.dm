/// Docks the target's pay
/datum/smite/dock_pay
	name = "Dock Pay"

/datum/smite/dock_pay/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target))
		to_chat(user, span_warning("This must be used on a carbon mob."), confidential = TRUE)
		return
	var/mob/living/carbon/dude = target
	var/obj/item/card/id/card = dude.get_idcard(TRUE)
	if (!card)
		to_chat(user, span_warning("[dude] does not have an ID card on!"), confidential = TRUE)
		return
	if (!card.registered_account)
		to_chat(user, span_warning("[dude] does not have an ID card with an account!"), confidential = TRUE)
		return
	if (card.registered_account.account_balance == 0)
		to_chat(user,  span_warning("ID Card lacks any funds. No pay to dock."))
		return
	var/new_cost = input("How much pay are we docking? Negative = giving money. Current balance: [card.registered_account.account_balance] [MONEY_NAME].", "BUDGET CUTS") as num|null
	if (!new_cost)
		return
	if(new_cost < 0)
		card.registered_account.adjust_money(new_cost, "Sectorial Command: Pay Bonus") // OCULIS EDIT - Central Command > Sectorial Command
		card.registered_account.bank_card_talk("[new_cost] [MONEY_NAME] added to your account based on performance review by Sectorial Command.", force = TRUE) // OCULIS EDIT - Central Command > Sectorial Command
	else
		SSeconomy.add_audit_entry(card.registered_account, new_cost, "Sectorial Command") // OCULIS EDIT - Central Command > Sectorial Command
		card.registered_account.adjust_money(-new_cost, "Sectorial Command: Pay Cut") // OCULIS EDIT - Central Command > Sectorial Command
		card.registered_account.bank_card_talk("[new_cost] [MONEY_NAME] deducted from your account based on performance review by Sectorial Command.", force = TRUE) // OCULIS EDIT - Central Command > Sectorial Command
	SEND_SOUND(target, 'sound/machines/buzz/buzz-sigh.ogg')
