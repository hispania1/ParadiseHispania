
/obj/machinery/kitchen_machine/oven
	name = "oven"
	desc = "Cookies are ready, dear."
	icon = 'icons/obj/cooking_machines.dmi'
	icon_state = "oven_off"
	cook_verbs = list("Baking", "Roasting", "Broiling")
	recipe_type = RECIPE_OVEN
	off_icon = "oven_off"
	on_icon = "oven_on"
	dirty_icon = "oven_dirty"
	open_icon = "oven_open"
	soundloop_type = /datum/looping_sound/kitchen/oven

// see code/modules/food/recipes_oven.dm for recipes

/*******************
*   Initialising
********************/

/obj/machinery/kitchen_machine/oven/Initialize(mapload)
	. = ..()
	component_parts = list()
	component_parts += new /obj/item/circuitboard/oven(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	component_parts += new /obj/item/stack/sheet/glass(null)
	component_parts += new /obj/item/stack/cable_coil(null, 5)
	RefreshParts()

/obj/machinery/kitchen_machine/oven/upgraded/Initialize(mapload)
	. = ..()
	component_parts = list()
	component_parts += new /obj/item/circuitboard/oven(null)
	component_parts += new /obj/item/stock_parts/micro_laser/ultra(null)
	component_parts += new /obj/item/stock_parts/micro_laser/ultra(null)
	component_parts += new /obj/item/stack/sheet/glass(null)
	component_parts += new /obj/item/stack/cable_coil(null, 5)
	RefreshParts()

/obj/machinery/kitchen_machine/oven/RefreshParts()
	var/E
	for(var/obj/item/stock_parts/micro_laser/M in component_parts)
		E += M.rating
	efficiency = round((E/2), 1) // There's 2 lasers, so halve the effect on the efficiency to keep it balanced

/obj/machinery/kitchen_machine/oven/special_attack(obj/item/grab/G, mob/user)
	if(ishuman(G.affecting))
		if(G.state < GRAB_AGGRESSIVE)
			to_chat(user, "<span class='warning'>You need a better grip to do that!</span>")
			return 0
		var/mob/living/carbon/human/C = G.affecting
		var/obj/item/organ/external/head/head = C.get_organ("head")
		if(!istype(head))
			to_chat(user, "<span class='warning'>This person doesn't have a head!</span>")
			return 0
		C.visible_message("<span class='danger'>[user] bashes [C]'s head in [src]'s door!</span>", \
						"<span class='userdanger'>[user] bashes your head in [src]'s door! It feels rather hot in the oven!</span>")
		C.emote("scream")
		user.changeNext_move(CLICK_CD_MELEE)
		C.apply_damage(5, BURN, "head") //5 fire damage, 15 brute damage, and weakening because your head was just in a hot oven with the door bashing into your neck!
		C.apply_damage(15, BRUTE, "head")
		C.Weaken(4 SECONDS)
		add_attack_logs(user, G.affecting, "Smashed with [src]")
		qdel(G) //Removes the grip to prevent rapid bashes. With the weaken, you PROBABLY can't run unless they are slow to grab you again...
		return 0
	return 0
