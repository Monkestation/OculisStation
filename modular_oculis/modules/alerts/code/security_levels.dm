/datum/security_level/crimson
	name = "crimson"
	sound = 'sound/announcer/notice/notice3.ogg'
	name_shortform = "CRM"
	announcement_color = "crimson"
	fire_alarm_light_color = LIGHT_COLOR_FLARE
	number_level = SEC_LEVEL_CRIMSON
	shuttle_call_time_mod = 0.5
	disables_mail = TRUE
	status_display_icon_state = "orangealert"  // TEMP
	elevating_to_announcement = "A critical engineering emergency has developed that threatens the integrity of the station. All personnel aboard are required to obey all relevant instructions from engineering staff and evacuate affected areas. Engineering staff will have expanded access to areas of the station during the emergency."
	lowering_to_announcement = "A critical engineering emergency has developed that threatens the integrity of the station. All personnel aboard are required to obey all relevant instructions from engineering staff and evacuate affected areas. Engineering staff will have expanded access to areas of the station during the emergency."

/datum/security_level/white
	name = "white"
	sound = 'sound/announcer/notice/notice3.ogg'
	name_shortform = "WHT"
	announcement_color = "white"
	fire_alarm_light_color = COLOR_WHITE
	number_level = SEC_LEVEL_WHITE
	shuttle_call_time_mod = 0.5
	disables_mail = TRUE
	status_display_icon_state = "violetalert"  // TEMP
	elevating_to_announcement = "A critical medical emergency has developed aboard. All personnel are required to obey relevant instructions from medical staff. Security personnel are advised to assist medical staff during the emergency. Adherence to ordered quarantines is compulsory."
	lowering_to_announcement = "A critical medical emergency has developed aboard. All personnel are required to obey relevant instructions from medical staff. Security personnel are advised to assist medical staff during the emergency. Adherence to ordered quarantines is compulsory."

/datum/security_level/black
	name = "black"
	sound = 'modular_iris/modules/alerts/sound/alerts/doomalarm.ogg'
	name_shortform = "BLK"
	announcement_color = "black"
	fire_alarm_light_color = COLOR_ALMOST_BLACK
	number_level = SEC_LEVEL_BLACK
	shuttle_call_time_mod = 0.4
	disables_mail = TRUE
	status_display_icon_state = "deltaalert"  // TEMP
	elevating_to_announcement = "Station control has been lost. An existential threat to the station and its crew is present and all measures to neutralize the threat have failed or proved ineffective. All duties have been suspended; all personnel aboard the station are advised to seek shelter immediately and take any necessary measures to ensure their survival. This is not a drill."
	lowering_to_announcement = "The destruction of the station has been averted; however, control of the station remains lost. An existential threat to the station remains. All personnel aboard the station are advised to seek shelter immediately and take any necessary measures to ensure their survival. This is not a drill."
