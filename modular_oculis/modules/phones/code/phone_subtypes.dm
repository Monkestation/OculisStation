/// Index to a define to point at a runtime-global list at compile-time.
#define NETWORK_ID 1
/// Index to a string, for the contact title.
#define OUR_ROLE 2
/// Index to a boolean, on whether to replace role with job title (or alt-title).
#define USE_JOB_TITLE 3

/datum/computer_file/program/phone_call
	contact_networks_pre_init = list(
		alist(NETWORK_ID = STATION_NETWORK, USE_JOB_TITLE = FALSE)
		)

#undef NETWORK_ID
#undef OUR_ROLE
#undef USE_JOB_TITLE
