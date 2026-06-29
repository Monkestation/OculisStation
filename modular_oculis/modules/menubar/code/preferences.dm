// Makes the menubar a preference
/datum/preference/toggle/menubar_enabled
	savefile_key = "menubar_enabled"
	savefile_identifier = PREFERENCE_PLAYER
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = TRUE

/datum/preference/toggle/menubar_enabled/apply_to_client_updated(client/client, value)
	if(value)
		winset(client, SKIN_MAINWINDOW, "menu=menu")
	else
		winset(client, SKIN_MAINWINDOW, "menu=")

// New preference options - Core ones can be found at code/modules/client/preferences_menu.dm

/datum/verbs/menu/Preferences/verb/open_keybindings()
	set category = "OOC"
	set name = "Open Keybindings"
	set desc = "Open Keybindings"

	var/datum/preferences/preferences = usr?.client?.prefs
	if(!preferences)
		return
	preferences.current_window = PREFERENCE_TAB_KEYBINDINGS
	preferences.update_static_data(usr)
	preferences.ui_interact(usr)

/client/New()
	. = ..()
	if(!prefs.read_preference(/datum/preference/toggle/menubar_enabled))
		winset(src, SKIN_MAINWINDOW, "menu=")
