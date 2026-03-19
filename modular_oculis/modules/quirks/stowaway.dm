/proc/is_stowaway(mob/living/carbon/human/person, client/person_client)
	if(!person)
		return FALSE

	var/client/target_client = person_client || person.client
	var/list/all_quirks = target_client?.prefs.all_quirks

	return person.has_quirk(/datum/quirk/item_quirk/stowaway) || (all_quirks && ("Stowaway" in all_quirks))

/proc/force_stowaway_unassigned_role(mob/living/carbon/human/person, client/person_client)
	if(!person?.mind || is_unassigned_job(person.mind.assigned_role))
		return

	var/datum/job/previous_role = person.mind.assigned_role
	if(previous_role?.title)
		SSjob.FreeRole(previous_role.title)

	person.mind.set_assigned_role(SSjob.get_job_type(/datum/job/unassigned))

/proc/process_stowaway_latejoin(mob/living/carbon/human/person, datum/job/current_job, client/person_client)
	if(!person?.mind || !is_stowaway(person, person_client))
		return

	if((current_job?.job_flags & JOB_ASSIGN_QUIRKS) && CONFIG_GET(flag/roundstart_traits))
		SSquirks.AssignQuirks(person, person_client)

	force_stowaway_unassigned_role(person, person_client)
