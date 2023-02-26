// humo de saga para las puertas

/obj/machinery/door/airlock/obj_break()
	var/datum/effect_system/smoke_spread/smoke = new
	smoke.set_up(4, 0, loc)
	smoke.start()
	..()


//keypad airlock
/obj/machinery/door/airlock/
	var/haskeypad = 0

/obj/machinery/door/airlock/keypad // HERE
	name = "Keypad Entry Airlock"
	icon = 'modular_hispania/icons/obj/doors/airlocks/station/doorkeypad.dmi'
	desc = "A door with a keypad lock."
	assemblytype = /obj/structure/door_assembly/door_assembly_keyp
	haskeypad = 1
	var/code = ""
	var/l_code = null
	var/l_set = 0
	var/l_setshort = 0
	var/l_hacking = 0
	var/open = 0

/obj/machinery/door/airlock/keypad/Topic(href, href_list)
	..()
	if((usr.stat || usr.restrained()) || (get_dist(src, usr) > 1))
		return
	if(href_list["type"])
		if(href_list["type"] == "E")
			if((src.l_set == 0) && (length(src.code) == 5) && (!src.l_setshort) && (src.code != "ERROR"))
				src.l_code = src.code
				src.l_set = 1
			else if((src.code == src.l_code) && (src.emagged == 0) && (src.l_set == 1))
				src.locked = 0
				playsound(src,boltUp, 30, 0, 3)
				update_icon()
				src.overlays = null
				src.code = null
			else
				src.code = "ERROR"
		else
			if((href_list["type"] == "R") && (src.emagged == 0) && (!src.l_setshort))
				src.locked = 1
				playsound(src,boltDown, 30, 0, 3)
				src.overlays = null
				update_icon()
				src.code = null
				src.close(usr)
			else
				src.code += text("[]", href_list["type"])
				if(length(src.code) > 5)
					src.code = "ERROR"
		add_fingerprint(usr)
		for(var/mob/M in viewers(1, src.loc))
			if((M.client && M.machine == src))
				attack_hand(M)
			return
	return

/obj/machinery/door/airlock/keypad/attack_hand(mob/user as mob)
	if(!istype(user, /mob/living/silicon))
		if(src.isElectrified())
			if(src.shock(user, 100))
				return

	if(!istype(user, /mob/living/silicon))
		user.set_machine(src)
		var/dat = text("<TT><B>[]</B><BR>\n\nLock Status: []",src, (src.locked ? "LOCKED" : "UNLOCKED"))
		var/message = "Code"
		if(!l_set && !emagged && !l_setshort)
			dat += text("<p>\n<b>5-DIGIT PASSCODE NOT SET.<br>ENTER NEW PASSCODE.</b>")
		if(emagged)
			dat += text("<p>\n<font color=red><b>LOCKING SYSTEM ERROR - 1701</b></font>")
		if(l_setshort)
			dat += text("<p>\n<font color=red><b>ALERT: MEMORY SYSTEM ERROR - 6040 201</b></font>")
		message = text("[]", code)
		if(!locked)
			message = "*****"
		dat += {"<HR>\n>[message]<BR>\n
		<A href='?src=[UID()];type=1'>1</A>-
		<A href='?src=[UID()];type=2'>2</A>-
		<A href='?src=[UID()];type=3'>3</A><BR>\n
		<A href='?src=[UID()];type=4'>4</A>-
		<A href='?src=[UID()];type=5'>5</A>-
		<A href='?src=[UID()];type=6'>6</A><BR>\n
		<A href='?src=[UID()];type=7'>7</A>-
		<A href='?src=[UID()];type=8'>8</A>-
		<A href='?src=[UID()];type=9'>9</A><BR>\n
		<A href='?src=[UID()];type=R'>R</A>-
		<A href='?src=[UID()];type=0'>0</A>-
		<A href='?src=[UID()];type=E'>E</A><BR>\n</TT>"}
		user << browse(dat, "window=caselock;size=300x280")

	if(panel_open)
		wires.Interact(user)
	else
		..(user)
	return
