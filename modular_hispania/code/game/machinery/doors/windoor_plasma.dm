#define EMPTY_ASSEMBLY "01"
#define WIRED_ASSEMBLY "02"

/obj/structure/windoor_assembly/plasma

/obj/machinery/door/window/plasma
	icon = 'icons/obj/doors/windoor.dmi'
	icon_state = "left"
	max_integrity = 400

/obj/machinery/door/window/brigdoor/plasma
	name = "secure door"
	icon_state = "leftsecure"
	base_state = "leftsecure"
	max_integrity = 600

/obj/structure/windoor_assembly/plasma/crowbar_act(mob/user, obj/item/I)	//Crowbar to complete the assembly, Step 7 complete.
	if(state != WIRED_ASSEMBLY)
		return
	. = TRUE
	if(!electronics)
		to_chat(user, "<span class='warning'>[src] is missing electronics!</span>")
		return
	if(!I.tool_use_check(user, 0))
		return
	user << browse(null, "window=windoor_access")
	user.visible_message("[user] pries the windoor into the frame.", "You start prying the windoor into the frame...")

	if(!I.use_tool(src, user, 40, volume = I.tool_volume))
		return
	if(loc && electronics)
		for(var/obj/machinery/door/window/WD in loc)
			if(WD.dir == dir)
				return

		density = TRUE //Shouldn't matter but just incase
		to_chat(user, "<span class='notice'>You finish the windoor.</span>")
		var/obj/machinery/door/window/plasma/windoor
		if(secure)
			windoor = new /obj/machinery/door/window/brigdoor/plasma(src.loc)
			if(facing == "l")
				windoor.icon_state = "leftsecureopen"
				windoor.base_state = "leftsecure"
			else
				windoor.icon_state = "rightsecureopen"
				windoor.base_state = "rightsecure"
		else
			windoor = new /obj/machinery/door/window/plasma(loc)
			if(facing == "l")
				windoor.icon_state = "leftopen"
				windoor.base_state = "left"
			else
				windoor.icon_state = "rightopen"
				windoor.base_state = "right"
		windoor.setDir(dir)
		windoor.density = FALSE
		windoor.polarized_glass = polarized_glass

		if(electronics.one_access)
			windoor.req_one_access = electronics.selected_accesses
		else
			windoor.req_access = electronics.selected_accesses
		windoor.unres_sides = electronics.unres_access_from
		windoor.electronics = src.electronics
		electronics.forceMove(windoor)
		electronics = null
		if(created_name)
			windoor.name = created_name
		qdel(src)
		windoor.close()
