GLOBAL_VAR(relay_config)

/client/verb/go2relay()
	set category = "OOC"
	set name = "Internet Routing Relays"

	if(is_localhost())
		to_chat(src, span_notice("You are on localhost, this verb is useless to you."))
		return

	if(!length(GLOB.relay_config))
		to_chat(src, span_notice("Relay configuration is missing or empty."))
		return

	var/list/names = list()
	var/list/name_to_relay = list()

	for(var/list/relay in GLOB.relay_config)
		var/name = relay["name"]
		names += name
		name_to_relay[name] = relay

	var/choice = tgui_input_list(src, "Which relay do you wish to use? Relays can help improve ping for some users.", "Relay Select", names)
	if(!choice)
		to_chat(src, span_notice("You didn't select a relay."))
		return

	var/list/relay = name_to_relay[choice]
	if(!relay)
		to_chat(src, span_notice("Invalid relay selection."))
		return

	var/address = replacetext(relay["address"], "{port}", "[world.port]")

	var/quickname = relay["quickname"]

	to_chat_immediate(
		target = src,
		html = boxed_message(span_info(span_big("Connecting you to [quickname]\nIf nothing happens, try manually connecting to the relay ([address]), or the RELAY may be down!"))),
		type = MESSAGE_TYPE_INFO,
	)
	DIRECT_OUTPUT(src, link(address))

/datum/controller/configuration/LoadMisc()
	. = ..()
	LoadRelays()

/datum/controller/configuration/proc/LoadRelays()
	var/config_path = "[directory]/relays.toml"
	if(!fexists(file(config_path)))
		log_config("relays.toml does not exist.")
		return

	var/list/result = rustg_raw_read_toml_file(config_path)
	if(!result["success"])
		log_config("Notify Server Operators: The relay config (relays.toml) is not configured correctly! [result["content"]]")
		return

	var/list/content = json_decode(result["content"])
	if(!length(content))
		return

	GLOB.relay_config = content["relay"]
