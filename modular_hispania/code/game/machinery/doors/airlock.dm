/obj/machinery/door/airlock/obj_break()
	var/datum/effect_system/smoke_spread/smoke = new
	smoke.set_up(4, 0, loc)
	smoke.start()
	..()
