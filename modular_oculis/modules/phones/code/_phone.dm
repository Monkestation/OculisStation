/obj/item/modular_computer
	// Who owns this phone on initialization?
	var/datum/weakref/owner_weakref
	// There's a radio in my phone that calls me stud muffin.
	var/obj/item/radio/phone_radio
	// Do we have a SIM card?
	var/obj/item/sim_card/sim_card
	// Passive particle effect generation for when on call
	var/obj/effect/abstract/particle_holder/particle_generator

/obj/item/modular_computer/Initialize(mapload)
	. = ..()
	GLOB.phones_list += src
	if(!sim_card)
		sim_card = new()
		sim_card.phone_weakref = WEAKREF(src)
	phone_radio = new(src)
	phone_radio.keyslot = new
	phone_radio.radio_noise = FALSE
	phone_radio.canhear_range = 1
	become_hearing_sensitive(ROUNDSTART_TRAIT)

/// Index to a define to point at a runtime-global list at compile-time.
#define NETWORK_ID 1
/// Index to a string, for the contact title.
#define OUR_ROLE 2
/// Index to a boolean, on whether to replace role with job title (or alt-title).
#define USE_JOB_TITLE 3

/datum/computer_file/program/phone_call/proc/update_initialized_contacts()
	var/mob/living/carbon/owner = computer.owner_weakref.resolve()
	if(LAZYLEN(contact_networks_pre_init))
		LAZYINITLIST(contact_networks)
		for(var/list/contact_network_info as anything in contact_networks_pre_init)
			var/list/network_contacts = GLOB.contact_networks[contact_network_info[NETWORK_ID]]

			var/our_role = contact_network_info[OUR_ROLE]
			if(contact_network_info[USE_JOB_TITLE] && !isnull(owner) && owner?.job)
				var/datum/job/job = SSjob.get_job(owner.job)
				our_role = job.title

			var/datum/contact_network/contact_network = new(network_contacts, our_role)
			contact_networks += contact_network

			var/datum/contact/our_contact = new(owner.real_name, computer.sim_card.phone_number, our_role, WEAKREF(src))
			network_contacts |= our_contact

	for(var/datum/computer_file/program/phone_call/P as anything in GLOB.phones_list)
		P.update_contacts()

	if(important_contact_of && owner && computer.sim_card.phone_number)
		GLOB.important_contacts[important_contact_of] = new /datum/phonecontact(owner.real_name, computer.sim_card.phone_number)

#undef NETWORK_ID
#undef OUR_ROLE
#undef USE_JOB_TITLE

/datum/computer_file/program/phone_call/Destroy()
	for(var/datum/contact_network/contact_network as anything in contact_networks)
		for(var/datum/contact/our_contact in contact_network.contacts)
			if(our_contact.number == computer.sim_card.phone_number)
				contact_network.contacts -= our_contact
	return ..()

/obj/item/modular_computer/Destroy(force)
	GLOB.phones_list -= src

	if(particle_generator)
		QDEL_NULL(particle_generator)

	lose_hearing_sensitivity(ROUNDSTART_TRAIT)
	UnregisterSignal(src, COMSIG_MOVABLE_HEAR)
	if(sim_card)
		sim_card.phone_weakref = null
		QDEL_NULL(sim_card)
	if(phone_radio)
		QDEL_NULL(phone_radio.keyslot)
		QDEL_NULL(phone_radio)
	return ..()

/proc/log_phone(text, list/data)
	logger.Log(LOG_CATEGORY_PDA_CHAT, text, data)
