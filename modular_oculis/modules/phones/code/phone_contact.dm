/datum/contact_network
	var/list/contacts = null
	var/our_role = null

/datum/contact_network/New(list/contacts, our_role)
	src.contacts = contacts
	src.our_role = our_role

/datum/contact
	var/name = "Unknown"
	var/number = null
	var/role = null
	var/datum/weakref/phone_ref = null

/datum/contact/New(name, number, role, phone_ref)
	if(!isnull(name))
		src.name = name
	if(!isnull(number))
		src.number = number
	if(!isnull(role))
		src.role = role
	if(!isnull(phone_ref))
		src.phone_ref = phone_ref

/datum/phonecontact
	var/name = "Unknown"
	var/number = ""

/datum/phonecontact/New(name, number)
	if(!isnull(name))
		src.name = name
	if(!isnull(number))
		src.number = number
