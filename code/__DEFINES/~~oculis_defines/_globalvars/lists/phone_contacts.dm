// Important Contacts

GLOBAL_LIST_EMPTY(phones_list)
GLOBAL_LIST_EMPTY(important_contacts)

// Contact Networks

GLOBAL_LIST_EMPTY(station_network)

#define STATION_NETWORK 1

// An indexed list of all the different phone networks that connect the phones that are part of them together.
GLOBAL_LIST_INIT(contact_networks, alist(
		STATION_NETWORK = GLOB.station_network,
	))
