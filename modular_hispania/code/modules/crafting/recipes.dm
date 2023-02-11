/datum/crafting_recipe/noose
	name = "Noose"
	result = list(/obj/structure/chair/noose)
	time = 80 // Building a functioning guillotine takes time
	reqs = list(/obj/item/stack/cable_coil = 30)
	category = CAT_MISC

/datum/crafting_recipe/femur_breaker
	name = "Femur Breaker"
	result = list(/obj/structure/femur_breaker)
	time = 150
	reqs = list(/obj/item/stack/sheet/plasteel = 10,
				/obj/item/stack/sheet/plastic = 2,
				/obj/item/stack/sheet/metal = 10,
		        /obj/item/stack/cable_coil = 10)
	tools = list(TOOL_WRENCH, TOOL_WELDER, TOOL_WIRECUTTER)
	category = CAT_MISC
