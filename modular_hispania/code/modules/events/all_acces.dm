/datum/event/all_access
	announceWhen = 3
	endWhen = 40

/datum/event/all_access/start()
	for(var/obj/machinery/door/airlock/D in GLOB.airlocks)
		if(is_station_level(D.z))
			D.emergency = 1
			D.update_icon()
	GLOB.minor_announcement.Announce("Los accesos de [station_name()] estan teniendo dificultades tecnicas. Porfavor mantengan la calma mientras se reestablecen")
	GLOB.station_all_access = 1

/datum/event/all_access/end()
	for(var/obj/machinery/door/airlock/D in GLOB.airlocks)
		if(is_station_level(D.z))
			D.emergency = 0
			D.update_icon()
	GLOB.minor_announcement.Announce("Los accesos ya funcionan con normalidad. Muchas gracias")
	GLOB.station_all_access = 0
