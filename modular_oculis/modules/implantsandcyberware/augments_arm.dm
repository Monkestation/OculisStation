/obj/item/organ/cyberimp/arm/wristwatch
	name = "internal chronometer"
	desc = "This relatively simple implant consists of a microchip and small flexible display embedded into the wrist, allowing the user to easily tell the date and time anywhere."
	zone = BODY_ZONE_R_ARM
	slot = ORGAN_SLOT_WRISTWATCH_R
	valid_zones = list(
		BODY_ZONE_R_ARM = ORGAN_SLOT_WRISTWATCH_R,
		BODY_ZONE_L_ARM = ORGAN_SLOT_WRISTWATCH_L,
	)
	actions_types = list(/datum/action/item_action/organ_action/use)

/obj/item/organ/cyberimp/arm/wristwatch/ui_action_click(mob/user, actiontype)
	if(organ_flags & ORGAN_FAILING)
		owner.visible_message(span_notice("[owner] glances at [owner.p_their()] wrist."), span_warning("You glance at [src]. The time is @#*%&^% and 999999999 seconds. The date, apparently, is DAYNOTFOUNDday, Febuary 30rd, The Year Of The Staphylococcus Aureus Bacterium. Enlightening."))
		return
	var/thetime = span_notice("You glance at [src]. The time is [server_timestamp(format = "hh:mm and ss seconds. The date is DDD, MMM DD, YYYY", ic_time = TRUE, twelve_hour_clock = owner.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))]")
	owner.visible_message(span_notice("[owner] glances at [owner.p_their()] wrist."), thetime)

/obj/item/organ/cyberimp/arm/wristwatch/emp_act(severity)
	. = ..()
	if((organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return
	organ_flags |= ORGAN_FAILING
	to_chat(owner, span_warning("Internal chronometer timing systems disrupted!"))
	addtimer(CALLBACK(src, PROC_REF(reboot)), 90 / severity)

/obj/item/organ/cyberimp/arm/wristwatch/proc/reboot()
	organ_flags &= ~ORGAN_FAILING
	to_chat(owner, span_notice("Internal chronometer resynchronized."))


/obj/item/organ/cyberimp/arm/wristwatch/left
	zone = BODY_ZONE_L_ARM
	slot = ORGAN_SLOT_WRISTWATCH_L

/datum/augment_item/implant/l_arm
	icon = FA_ICON_ARROW_LEFT

/datum/augment_item/implant/r_arm
	icon = FA_ICON_ARROW_RIGHT

/datum/augment_item/implant/wristwatch
	name = "internal chronometer"
	extra_info = "Tells the time."
	cost = 2
	path = /obj/item/organ/cyberimp/arm/wristwatch
	slot = AUGMENT_SLOT_R_ARM_IMPLANT

/datum/augment_item/implant/wristwatch/left
	path = /obj/item/organ/cyberimp/arm/wristwatch/left
	slot = AUGMENT_SLOT_L_ARM_IMPLANT

/datum/design/wristwatch
	name = "internal chronometer"
	desc = "Simple cybernetic that turns your wrist itself into a wristwatch, so that you can tell the time anywhere, anytime."
	id = "ci-wristwatch"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 6 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*8,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*8,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/organ/cyberimp/arm/wristwatch
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/wristwatch
	id = TECHWEB_NODE_WRISTWATCH
	display_name = "Biomorphological Tempotechnics"
	description = "Timetelling in the age of cybernetic enhancement."
	prereq_ids = list(TECHWEB_NODE_CYBER_IMPLANTS, TECHWEB_NODE_HOLOGRAPHICS)
	design_ids = list(
		"ci-wristwatch"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS / 2)
	announce_channels = list(RADIO_CHANNEL_SERVICE, RADIO_CHANNEL_MEDICAL, RADIO_CHANNEL_SCIENCE)
