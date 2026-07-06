/obj/effect/mapping_helpers/atmos_auto_connect
	name = "atmos auto-connect helper"
	desc = "Place this on a portable atmospherics like canister to automatically connect it to the connector on the same tile."
	late = TRUE

/obj/effect/mapping_helpers/atmos_auto_connect/LateInitialize()
	var/obj/machinery/portable_atmospherics/port_atmos = locate(/obj/machinery/portable_atmospherics) in loc
	var/obj/machinery/atmospherics/components/unary/portables_connector/connector = locate(/obj/machinery/atmospherics/components/unary/portables_connector) in loc
	if(port_atmos && connector)
		port_atmos.connect(connector)
		qdel(src)
		return
	CRASH("Failed to find a portable atmospherics or a portables connector at [AREACOORD(src)]")
