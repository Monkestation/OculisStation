/**
 * Subsystem that is responsible for handling the phone system.
 * Generates a list of all phone numbers roundstart and lists them respectively to who needs them.
 */
SUBSYSTEM_DEF(phones)
	name = "Phones"
	ss_flags = SS_NO_FIRE|SS_NO_INIT

	// Seven digits, always start with 5
	var/list/assigned_phone_numbers = list()
	// List of frequencies in use
	var/list/frequencies_in_use = list()

// Generates a random phone number from the available ranges, ten digits, starts with a 415 or 628.
/datum/controller/subsystem/phones/proc/random_number()
	return "[pick("415","628")][rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"

// Generates a random landline phone number from the available ranges, ten digits, starts with a 1415 or 1628.
/datum/controller/subsystem/phones/proc/random_landline_number()
	return "1[pick("415","628")][rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"

// If this ever cannot generate a unique number after 10 tries, we have a problem.
/datum/controller/subsystem/phones/proc/generate_phone_number(obj/item/sim_card/sim_card, landline = FALSE)
	for(var/generation_attempt in 1 to 10)
		var/randomly_generated_phone_number
		if(landline)
			randomly_generated_phone_number = random_landline_number()
		else
			randomly_generated_phone_number = random_number()
		if(randomly_generated_phone_number in assigned_phone_numbers)
			continue
		assigned_phone_numbers[sim_card] = randomly_generated_phone_number
		return randomly_generated_phone_number
	CRASH("[src] failed to generate a unique phone number after 10 attempts.")

// Returns a valid frequency for a phone to use for a phone call.
/datum/controller/subsystem/phones/proc/establish_secure_frequency()
	var/frequency_to_use = USABLE_RADIO_FREQUENCY_FOR_PHONE_RANGE
	while(frequency_to_use in frequencies_in_use)
		if(frequency_to_use >= MAX_RADIO_FREQUENCY_FOR_PHONE_RANGE)
			stack_trace("Phones have somehow connected over [MAX_RADIO_FREQUENCY_FOR_PHONE_RANGE - USABLE_RADIO_FREQUENCY_FOR_PHONE_RANGE] connections without being freed up. Something is wrong.")
			break
		frequency_to_use++
	frequencies_in_use += frequency_to_use
	return frequency_to_use

// Returns a valid frequency for a phone to use for a phone call.
/datum/controller/subsystem/phones/proc/free_secure_frequency(frequency_to_free)
	frequencies_in_use -= frequency_to_free
	return TRUE

// Returns a reference to a phone from a phone number.
/datum/controller/subsystem/phones/proc/get_phone_from_number(phone_number)
	var/obj/item/sim_card/gotten_sim_card
	for(var/obj/item/sim_card/sim_card as anything in assigned_phone_numbers)
		if(sim_card.phone_number == phone_number)
			gotten_sim_card = sim_card
	var/gotten_phone = gotten_sim_card?.phone_weakref?.resolve()
	return gotten_phone
