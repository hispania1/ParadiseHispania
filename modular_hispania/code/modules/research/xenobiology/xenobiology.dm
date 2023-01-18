/obj/item/slimepotion/speed/old
	name = "slime speed potion"
	desc = "A potent chemical mix that will remove the slowdown from any item."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle3"
	origin_tech = "biotech=5"

/obj/item/slimepotion/speed/old/afterattack(obj/O, mob/user, proximity_flag)
	if(!proximity_flag)
		return
	..()
	if(!istype(O))
		to_chat(user, "<span class='warning'>The potion can only be used on items or vehicles!</span>")

	if(isitem(O))
		var/obj/item/I = O
		if(I.slowdown <= 0)
			to_chat(user, "<span class='warning'>[I] can't be made any faster!</span>")
			return ..()
		I.slowdown = 0

	if(istype(O, /obj/vehicle))
		var/obj/vehicle/V = O
		var/vehicle_speed_mod = GLOB.configuration.movement.base_run_speed
		if(V.vehicle_move_delay <= vehicle_speed_mod)
			to_chat(user, "<span class='warning'>[V] can't be made any faster!</span>")
			return ..()
		V.vehicle_move_delay = vehicle_speed_mod

	to_chat(user, "<span class='notice'>You slather the red gunk over [O], making it faster.</span>")
	O.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	O.add_atom_colour("#FF0000", FIXED_COLOUR_PRIORITY)

/obj/item/slimepotion/speed/old/MouseDrop(obj/over_object)
	if(usr.incapacitated())
		return
	if(loc == usr && loc.Adjacent(over_object))
		afterattack(over_object, usr, TRUE)
