/datum/event/all_access
	announceWhen = 3
	endWhen = 40

/datum/event/all_access/start()
	for(var/obj/machinery/door/airlock/D in GLOB.airlocks)
		if(is_station_level(D.z))
			D.emergency = 1
			D.update_icon()
	GLOB.minor_announcement.Announce(" [station_name()] is having technical difficulties processing station acceses. Please remain calm until its fixed")
	GLOB.station_all_access = 1

/datum/event/all_access/end()
	for(var/obj/machinery/door/airlock/D in GLOB.airlocks)
		if(is_station_level(D.z))
			D.emergency = 0
			D.update_icon()
	GLOB.minor_announcement.Announce("Station accesses are working back, thank you have a nice day")
	GLOB.station_all_access = 0
