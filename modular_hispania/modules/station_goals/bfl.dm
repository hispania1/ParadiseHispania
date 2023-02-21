/datum/station_goal/bfl
	name = "BFL Mining laser"
	var/plasma_required = 500

/datum/station_goal/bfl/get_report()
	return {"<b>Mining laser construcion</b><br>
	Our surveillance drone detected an enormous deposit, oozing with plasma. We need you to construct a BFL system to collect 500 plasma ores.
	<br>
	The parts of the BFL should be available for shipping with the cargo console.
	<br>
	In order to complete the mission, you must gather 500 plasma ores wih the machine.
	<br>
	The emitter BFL has to be constructed in the station it makes a breach under it and should be activaded once the receiver is ready. It requires a significant amount of energy
	<br>
	The receiver BFL should be constructed in lavaland on the plasma crack deposit. It doesnt require energy to function.
	<br>
	In order to receive the signal from the emitter one len is required.
	<br><br>
	-Nanotrasen Naval Command"}


/datum/station_goal/bfl/on_report()
	//Unlock BFL related things
	var/datum/supply_packs/misc/station_goal/P = SSeconomy.supply_packs["[/datum/supply_packs/misc/station_goal/bfl]"]
	P.special_enabled = TRUE

	P =  SSeconomy.supply_packs["[/datum/supply_packs/misc/station_goal/bfl_lens]"]
	P.special_enabled = TRUE

/datum/station_goal/bfl/check_completion()
	if(..())
		return TRUE
	for(var/obj/machinery/power/bfl_emitter/B in world)
		if(B.receiver.plasma_collected >= plasma_required)
			return TRUE
	return FALSE

////////////
//Building//
////////////
/obj/item/circuitboard/machine/bfl_emitter
	name = "BFL Emitter (Machine Board)"
	desc = "This can be built and installed in the station, it demands a significant amount of energy and there should a cable under it. It is a 3x3 structure."
	build_path = /obj/machinery/power/bfl_emitter
	origin_tech = "engineering=4;combat=4;bluespace=4"
	req_components = list(
					/obj/item/stack/sheet/metal = 5,
					/obj/item/stack/rods = 20,
					/obj/item/stack/sheet/plasmaglass = 4,
					/obj/item/stock_parts/manipulator/nano = 2,
					/obj/item/stock_parts/capacitor/super = 5,
					/obj/item/stock_parts/micro_laser/high = 5,
					/obj/item/stack/cable_coil = 5)

/obj/item/circuitboard/machine/bfl_receiver
	name = "BFL Receiver (Machine Board)"
	desc = "Must be built on the middle of the deposit and it doesnt require energy. Deposits are found in lavaland"
	build_path = /obj/machinery/bfl_receiver
	origin_tech = "engineering=4;combat=4;bluespace=4"
	req_components = list(
					/obj/item/stack/sheet/metal = 20,
					/obj/item/stack/sheet/plasteel = 5,
					/obj/item/stack/sheet/plasmaglass = 5,
					/obj/item/stack/sheet/mineral/diamond = 1)

///////////
//Emitter//
///////////
/obj/machinery/power/bfl_emitter
	name = "BFL Emitter"
	icon = 'modular_hispania/icons/obj/machines/BFL_mission/Emitter.dmi'
	icon_state = "Emitter_Off"
	anchored = TRUE
	density = TRUE
	power_state = NO_POWER_USE
	idle_power_consumption = 50
	active_power_consumption = 50000
	pixel_x = -32
	pixel_y = 0

	var/emag = FALSE
	var/state = FALSE
	var/obj/singularity/bfl_red/laser = null
	var/obj/machinery/bfl_receiver/receiver = FALSE
	var/deactivate_time = 0
	var/list/obj/structure/fillers = list()

/obj/machinery/power/bfl_emitter/emag_act()
	. = ..()
	if(!emag)
		emag = TRUE
		to_chat(usr, "Emitter successfully sabotaged")

/obj/machinery/power/bfl_emitter/process()
	if(state)
		add_load(active_power_consumption)
	else
		add_load(idle_power_consumption)
		return
	if(surplus() < active_power_consumption)
		emitter_deactivate()
		return
	if(laser)
		return
	if(!receiver || !receiver.state || emag || !receiver.lens || !receiver.lens.anchored)
		var/turf/rand_location = locate(rand((2*TRANSITIONEDGE), world.maxx - (2*TRANSITIONEDGE)), rand((2*TRANSITIONEDGE), world.maxy - (2*TRANSITIONEDGE)), 3)
		laser = new (rand_location)
		for(var/M in GLOB.player_list)
			var/turf/mob_turf = get_turf(M)
			if(mob_turf?.z == 3)
				to_chat(M, "<span class='boldwarning'>You see bright red flash in the sky. Then clouds of smoke rises, uncovering giant red ray striking from the sky.</span>")
		laser.move = rand_location.x
		if(receiver)
			receiver.mining = FALSE
			if(receiver.lens)
				receiver.lens.deactivate_lens()
		receiver = FALSE

/obj/machinery/power/bfl_emitter/proc/emitter_activate()
	if(laser) //just in case
		qdel(laser)
		laser = null
	state = TRUE
	icon_state = "Emitter_On"
	var/turf/location = get_step(src, NORTH)
	location.ex_act(1)
	if(receiver && receiver.state && receiver.lens && receiver.lens.anchored)
		receiver.lens.activate_lens()
		receiver.mining = TRUE
	working_sound()


/obj/machinery/power/bfl_emitter/proc/emitter_sync_with_receiver()
	for(var/obj/machinery/bfl_receiver/T in world)
		if(!T.state)
			atom_say("Receiver found but its closed. Open manually the deposit with a crowbar")
			receiver = FALSE
			return
		if(!T.lens || !T.lens.anchored)
			atom_say("The receiver has no lens installed")
			receiver = FALSE
			return
		if(T.state && T.lens && T.lens.anchored)
			receiver = T
		else
			receiver = FALSE
		return
	atom_say("No receivers found")

/obj/machinery/power/bfl_emitter/proc/emitter_deactivate()
	state = FALSE
	icon_state = "Emitter_Off"
	var/turf/location = get_step(src, NORTH)
	location.ChangeTurf(/turf/simulated/floor/plating)
	if(receiver)
		receiver.mining = FALSE
		if(receiver.lens && receiver.lens.state)
			receiver.lens.deactivate_lens()

	if(laser)
		qdel(laser)
		laser = null

/obj/machinery/power/bfl_emitter/proc/working_sound()
	set waitfor = FALSE
	while(state)
		playsound(src, 'modular_hispania/sound/BFL/emitter.ogg', 100, 1)
		sleep(25)

//code stolen from bluespace_tap, including comment below. He was right about the new datum
//code stolen from dna vault, inculding comment below. Taking bets on that datum being made ever.
//TODO: Replace this,bsa and gravgen with some big machinery datum
/obj/machinery/power/bfl_emitter/Initialize()
	.=..()
	playsound(src, 'modular_hispania/sound/BFL/drill_sound.ogg', 25, 1)

	var/list/occupied = list()
	for(var/direction in list(NORTH, NORTHWEST, NORTHEAST, EAST, WEST))
		occupied += get_step(src, direction)
	occupied += locate(x, y + 2, z)
	occupied += locate(x + 1, y + 2, z)
	occupied += locate(x - 1, y + 2, z)
	for(var/T in occupied)
		var/obj/structure/filler/F = new(T)
		F.parent = src
		fillers += F

	if(!powernet)
		connect_to_network()

/obj/machinery/power/bfl_emitter/Destroy()
	emitter_deactivate()
	QDEL_LIST_CONTENTS(fillers)
	return ..()

/////////////////
//Emitter TGUI//
////////////////

/obj/machinery/power/bfl_emitter/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "bfl_emitter", name, 400, 220, master_ui, state)
		ui.open()

/obj/machinery/power/bfl_emitter/attack_hand(mob/user)
	add_fingerprint(user)
	ui_interact(user)

/obj/machinery/power/bfl_emitter/attack_ai(mob/user)
	add_hiddenprint(user)
	ui_interact(user)

/obj/machinery/power/bfl_emitter/attack_ghost(mob/user)
	ui_interact(user)

/obj/machinery/power/bfl_emitter/ui_data(mob/user)
	var/list/data = list()
	data["state"] = state	// 1 o 0, funcionando o apagado
	data["receiver"] = (receiver != FALSE && receiver != null)	// si tiene un receiver syncronizado
	if(receiver != FALSE && receiver != null)
		data["plasma_collected"] = receiver.plasma_collected
	else
		data["plasma_collected"] = 0
	return data

/obj/machinery/power/bfl_emitter/ui_act(action, params)
	if(..())
		return
	. = TRUE
	switch(action)
		if("activate")
			if(state == TRUE)//just in case
				return
			if(!powernet)
				connect_to_network()
			if(!powernet)
				atom_say("Powernet not found. There must cable under the emitter green screen")
				return
			if(surplus() < active_power_consumption)
				atom_say("The connected wire doesn't have enough power")
				return
			if(world.time - deactivate_time < 5 SECONDS)
				atom_say("Error, emitter is still cooling down")
				return
			emitter_activate()

		if("deactivate")
			if(state == FALSE)//just in case
				return
			if(emag)
				visible_message("BFL software update, please wait.<br> 99% complete")
				//playsound(src, 'modular_hispania/sound/BFL/prank.ogg', 100, 1)
			else
				emitter_deactivate()
				deactivate_time = world.time

		if("sync")
			if(state)
				atom_say("Please deactivate laser before syncing")//just in case
			else
				emitter_sync_with_receiver()





////////////
//Receiver//
////////////
#define PLASMA 2
#define SAND 1
#define NOTHING 0

/obj/item/storage/bag/ore/bfl_storage
	storage_slots = 20

/obj/item/storage/bag/ore/bfl_storage/proc/empty_storage(turf/location)
	var/OB
	for(var/obj/structure/ore_box/B in range(2,src.loc))
		OB = B
	if(OB)//to orebox
		for(var/obj/item/I in contents)
			remove_from_storage(I, OB)
			CHECK_TICK
		to_chat(usr, "You empty [src] contents in the ore box")
	else//to the floor
		for(var/obj/item/I in contents)
			var/s_location = get_step(location, SOUTH)
			remove_from_storage(I, s_location)
			CHECK_TICK
		to_chat(usr, "You empty [src] contents in the floor, having an orebox would be smarter")



/obj/machinery/bfl_receiver/verb/quick_empty()
	set name = "Empty Contents"
	set category = "Object"
	set src in view(1)
	var/turf/location = get_turf(src)
	internal.empty_storage(location)

/obj/machinery/bfl_receiver
	name = "BFL Receiver"
	desc = "A huge machine designed to drill plasma or sand. It needs an activaded BFL emitter to start mining, you can open the drilling hole with a crowbar"
	icon = 'modular_hispania/icons/obj/machines/BFL_mission/Hole.dmi'
	icon_state = "Receiver_Off"
	anchored = TRUE

	var/state = FALSE
	var/mining = FALSE
	var/obj/item/storage/bag/ore/bfl_storage/internal
	var/internal_type = /obj/item/storage/bag/ore/bfl_storage
	var/obj/machinery/bfl_lens/lens = null
	var/ore_type = FALSE
	var/last_user_ckey
	pixel_x = -32
	pixel_y = -32
	var/plasma_collected = 0

/obj/machinery/bfl_receiver/crowbar_act(mob/user, obj/item/I)
	playsound(loc,'sound/machines/airlockforced.ogg',30,1)
	. = TRUE
	if(!I.use_tool(src, user, 0, volume = 0))
		return
	if(state)
		receiver_deactivate()
	else
		receiver_activate()

/obj/machinery/bfl_receiver/process()
	overlays.Cut()
	overlays += image('modular_hispania/icons/obj/machines/BFL_Mission/Hole.dmi', icon_state = "Receiver_Light_[internal.contents.len]")
	if (!(mining && state))
		return
	switch(ore_type)
		if(PLASMA)
			var/make = rand(1,2)
			if(make==1)
				internal.handle_item_insertion(new /obj/item/stack/ore/plasma, 1)
				plasma_collected++
			else
				internal.handle_item_insertion(new /obj/item/stack/ore/plasma, 1)
				internal.handle_item_insertion(new /obj/item/stack/ore/plasma, 1)
				plasma_collected += 2
		if(SAND)
			internal.handle_item_insertion(new /obj/item/stack/ore/glass, 1)

/obj/machinery/bfl_receiver/Initialize()
	. = ..()
	internal = new internal_type(src)
	playsound(src, 'modular_hispania/sound/BFL/drill_sound.ogg', 25, 1)

	var/turf/turf_under = get_turf(src)
	if(locate(/obj/bfl_crack) in range(2,turf_under)) //doesnt have to be the exact position
		ore_type = PLASMA
	else if(istype(turf_under, /turf/simulated/floor/plating/asteroid/basalt/lava_land_surface))
		ore_type = SAND
	else
		ore_type = NOTHING

/obj/machinery/bfl_receiver/proc/receiver_activate()
	state = TRUE
	icon_state = "Receiver_On"

/obj/machinery/bfl_receiver/proc/receiver_deactivate()
	var/turf/turf_under = get_step(src, SOUTH)
	var/turf/T = get_turf(src)
	state = FALSE
	icon_state = "Receiver_Off"
	T.ChangeTurf(turf_under.type)

/obj/machinery/bfl_receiver/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(istype(AM, /obj/machinery/bfl_lens))
		lens = AM
		lens.step_count = 0

/obj/machinery/bfl_receiver/Uncrossed(atom/movable/AM)
	. = ..()
	if(AM == lens)
		lens = null

#undef PLASMA
#undef SAND
#undef NOTHING
////////
//Lens//
////////
/obj/machinery/bfl_lens
	name = "High-precision lens"
	desc = "Extremely fragile, handle with care."
	icon = 'modular_hispania/icons/obj/machines/BFL_Mission/Hole.dmi'
	icon_state = "Lens_Pull"
	max_integrity = 40
	layer = ABOVE_OBJ_LAYER
	density = 1

	pixel_x = -32
	pixel_y = -32

	var/step_count = 0
	var/state = FALSE
	var/last_time

/obj/machinery/bfl_lens/update_icon()
	if(state)
		icon_state = "Lens_On"
	else if(anchored)
		icon_state = "Lens_Off"
	else
		icon_state = "Lens_Pull"
	..()

/obj/machinery/bfl_lens/proc/activate_lens()
	state = TRUE
	update_icon()
	overlays += image('modular_hispania/icons/obj/machines/BFL_Mission/Laser.dmi', icon_state = "Laser_Blue", pixel_y = 64, layer = GASFIRE_LAYER)
	set_light(8)
	working_sound()

/obj/machinery/bfl_lens/proc/deactivate_lens()
	overlays.Cut()
	state = FALSE
	update_icon()
	set_light(0)

/obj/machinery/bfl_lens/proc/working_sound()
	set waitfor = FALSE
	while(state)
		playsound(src, 'modular_hispania/sound/BFL/receiver.ogg', 100, 1)
		sleep(25)

/obj/machinery/bfl_lens/wrench_act(mob/user, obj/item/I)
	. = TRUE
	if(!I.use_tool(src, user, 0, volume = 0))
		return
	default_unfasten_wrench(user, I, time = 140)
	update_icon()

/obj/machinery/bfl_lens/Initialize()
	. = ..()
	//pixel_x = -32
	//pixel_y = -32

/obj/machinery/bfl_lens/Destroy()
	anchored = FALSE
	visible_message("Lens shatters in a million pieces")
	playsound(src, "shatter", 70, 1)
	new /obj/item/shard(src.loc)
	new /obj/effect/decal/cleanable/glass(src.loc)
	overlays.Cut()
	return ..()


/obj/machinery/bfl_lens/Move(atom/newloc, direction, movetime)// its fragile!
	. = ..()
	if(!.)
		return
	if(last_time)// ignore first time
		if((world.time-last_time)< 4)
			Destroy()
	last_time = world.time

//everything else
/obj/bfl_crack
	name = "rich plasma deposit"
	can_be_hit = FALSE
	anchored = TRUE
	icon = 'modular_hispania/icons/obj/machines/BFL_Mission/Hole.dmi'
	icon_state = "Crack"
	pixel_x = -32
	pixel_y = -32
	layer = HIGH_TURF_LAYER
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

	//space for gps tracker
	var/obj/item/tank/internal
	var/internal_type = /obj/item/gps/internal/bfl_crack

/obj/bfl_crack/Initialize(mapload)
	. = ..()
	internal = new internal_type(src)

/obj/item/gps/internal/bfl_crack
	gpstag = "NT signal"

/obj/structure/toilet/golden_toilet/bfl_goal
	name = "\[NT REDACTED\]"
/obj/singularity/bfl_red
	name = "BFL"
	desc = "Giant laser, which is supposed for mining"
	icon = 'modular_hispania/icons/obj/machines/BFL_Mission/Laser.dmi'
	icon_state = "Laser_Red"
	speed_process = TRUE
	var/move = 0

/obj/singularity/bfl_red/move(force_move)
	if(!move_self)
		return 0

	var/movement_dir = pick(GLOB.alldirs - last_failed_movement)

	if(force_move)
		movement_dir = force_move
		step(src, movement_dir)
	else
		move++
		forceMove(locate((move % 255) + 1, (sin(move + 1) + 1)*125 + 3, 3))

/obj/singularity/bfl_red/expand()
	. = ..()
	icon = 'modular_hispania/icons/obj/machines/BFL_Mission/Laser.dmi'
	icon_state = "Laser_Red"
	pixel_x = -32
	pixel_y = 0
	grav_pull = 1

/obj/singularity/bfl_red/singularity_act()
	return 0

/obj/singularity/bfl_red/New(loc, var/starting_energy = 50, var/temp = 0)
	starting_energy = 250
	. = ..(loc, starting_energy, temp)
