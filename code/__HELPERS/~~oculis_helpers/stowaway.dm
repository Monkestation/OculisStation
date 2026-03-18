/// hiding someone from manifest or arrival
/proc/is_hidden_from_manifest_and_arrival(mob/living/carbon/human/person, client/person_client)
	if(!person)
		return FALSE

	var/client/target_client = person_client || person.client
	var/list/all_quirks = target_client?.prefs.all_quirks

	return HAS_TRAIT(person, TRAIT_STOWAWAY_HIDDEN) || person.has_quirk(/datum/quirk/item_quirk/stowaway) || (all_quirks && ("Stowaway" in all_quirks))
