#define TECHWEB_NODE_CONTACT_SCIENCE "contact_science"

/datum/techweb_node/contact_science
	display_name = "Storm Contact"
	description = "Make contact with anomalous resonances trapped within the Storm. Speak with them, learn their secrets."
	prerequisite_nodes = list(/datum/techweb_node/bluespace_travel)
	unlocked_designs = list(
		/datum/design/board/contactscanner,
		/datum/design/board/contactplatform,
		/datum/design/contactanalyzer,
		/datum/design/contactresonator,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)
