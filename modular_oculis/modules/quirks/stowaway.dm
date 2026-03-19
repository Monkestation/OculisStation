/proc/is_stowaway(mob/living/carbon/human/person, client/person_client)
	if(!person)
		return FALSE

	var/client/target_client = person_client || person.client
	var/list/all_quirks = target_client?.prefs.all_quirks

	return person.has_quirk(/datum/quirk/item_quirk/stowaway) || (all_quirks && ("Stowaway" in all_quirks))

/// for stowaways, swap assigned role to unassigned, should handle records/manifest/mail properly due to not having JOB_STATION_FLAGS
/proc/force_stowaway_unassigned_role(mob/living/carbon/human/person, client/person_client)
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
