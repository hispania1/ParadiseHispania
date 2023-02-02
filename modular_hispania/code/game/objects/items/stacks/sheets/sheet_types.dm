/obj/item/stack/sheet/wood/Initialize()
	. = ..()
	recipes |= GLOB.wood_recipes_hispania

/obj/item/stack/sheet/metal/Initialize()
	. = ..()
	recipes |= GLOB.metal_recipes_hispania

/obj/item/stack/sheet/plasteel/Initialize()
	. = ..()
	recipes |= GLOB.plasteel_recipes_hispania

/obj/item/stack/sheet/cloth/Initialize()
	. = ..()
	recipes |= GLOB.cloth_recipes_hispania

/obj/item/stack/sheet/cardboard/Initialize()
	. = ..()
	recipes |= GLOB.cardboard_recipes_hispania


/obj/item/stack/sheet/runed_metal/Initialize()
	. = ..()
	recipes |= GLOB.cult_recipes_hispania

/obj/item/stack/tile/brass/Initialize()
	. = ..()
	recipes |= GLOB.brass_recipes_hispania

/obj/item/stack/sheet/plastic/Initialize()
	. = ..()
	recipes |= GLOB.plastic_recipes_hispania


// OBJETOS CRAFTEABLES HISPANIA A PARTIR DE SHEETS

//wood
GLOBAL_LIST_INIT(wood_recipes_hispania, list(
	null,
	new /datum/stack_recipe("wood cabinet", /obj/structure/closet/cabinet, 10, time = 15),
))

//metal
GLOBAL_LIST_INIT(metal_recipes_hispania, list(
	null,
))

//plasteel
GLOBAL_LIST_INIT(plasteel_recipes_hispania, list(
	null,
))

//cloth
GLOBAL_LIST_INIT(cloth_recipes_hispania, list (
	null,
))

//cardobard
GLOBAL_LIST_INIT(cardboard_recipes_hispania, list (
	null,
))

//cult
GLOBAL_LIST_INIT(cult_recipes_hispania, list (
	null,
))

//brass
GLOBAL_LIST_INIT(brass_recipes_hispania, list (
	null,
))

//plastic
GLOBAL_LIST_INIT(plastic_recipes_hispania, list(
	null,
))


