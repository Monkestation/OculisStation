// TODO: add proper sprites. Make a list that holds all the upgrades so the deactivate proc can work properly

/obj/item/pai_upgrade
	name = "blank pAI upgrade"
	desc = "An upgrade for older pAI systems."
	w_class = WEIGHT_CLASS_SMALL
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP

	// The card this upgrade is attached to
	var/obj/item/pai_card_oculis/paicard
	// How many upgrade slots this upgrade occupies
	var/slots_taken = 1
	// The message given to the pAI when this upgrade is installed successfully
	var/upgrade_message = "The upgrade confirms that it's been installed, but offers no additional functionality..."

// What happens when the upgrade is inserted into the card
/obj/item/pai_upgrade/proc/upgrade_activate(card, user)
	// Proc should never be called outside of it being inserted into a pAI, but to be on the safe side...
	if(!card)
		return
	paicard = card
	if(paicard.installed_upgrades == paicard.max_upgrades || (paicard.installed_upgrades + slots_taken) > paicard.max_upgrades)
		to_chat(user, span_alert("[paicard] doesn't have enough upgrade slots for this."))
		return
	forceMove(paicard)
	paicard.installed_upgrades = paicard.installed_upgrades + slots_taken
	to_chat(paicard.pai, span_notice("[upgrade_message]"))
	to_chat(user, span_notice("You successfully install the upgrade."))

// What happens when the upgrade is removed from the card
/obj/item/pai_upgrade/proc/upgrade_remove()
	return

// Upgrade that enables pAI exosuit access
/obj/item/pai_upgrade/exosuit
	name = "pAI upgrade: Mech pilot credentials"
	desc = "An upgrade for older pAI systems. This one provides a pAI with the necessary software keys needed to interface with and pilot an exosuit."
	upgrade_message = "EXOSUIT CREDENTIAL KEYS GRANTED!"

/obj/item/pai_upgrade/exosuit/upgrade_activate(card)
	. = ..()
	paicard.pai.set_mech_access()
	return
