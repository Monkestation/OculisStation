/proc/is_stowaway(mob/living/carbon/human/person, client/person_client)
	if(!person)
		return FALSE

	var/client/target_client = person_client || person.client
	var/list/all_quirks = target_client?.prefs.all_quirks

	return HAS_TRAIT(person, TRAIT_STOWAWAY_HIDDEN) || person.has_quirk(/datum/quirk/item_quirk/stowaway) || (all_quirks && ("Stowaway" in all_quirks))


/proc/force_stowaway_unassigned_role(mob/living/carbon/human/person, client/person_client) // set role to unassigned for stowaways, should handle records/manifest/mail properly
	if(!person?.mind)
		return FALSE
	if(!is_stowaway(person, person_client))
		return FALSE
	if(is_unassigned_job(person.mind.assigned_role))
		return FALSE

	var/datum/job/previous_role = person.mind.assigned_role
	if(previous_role?.title)
		SSjob.FreeRole(previous_role.title)

	person.mind.set_assigned_role(SSjob.get_job_type(/datum/job/unassigned))
	return TRUE
