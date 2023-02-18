/obj/item/storage/fancy/cigarettes/cigpack_xeno
	name = "\improper Xeno Filtered packet"
	desc = "Loaded with 100% pure slime. And also nicotine."
	icon = 'modular_hispania/icons/obj/items.dmi'
	icon_state = "slime"

/obj/item/storage/fancy/heart_box
	name = "heart-shaped box"
	desc = "A heart-shaped box for holding tiny chocolates."
	icon = 'modular_hispania/icons/obj/containers.dmi'
	item_state = "chocolatebox"
	icon_state = "chocolatebox"
	icon_type = "chocolate"
	lefthand_file = 'modular_hispania/icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'modular_hispania/icons/mob/inhands/items_righthand.dmi'
	storage_slots = 8
	can_hold = list(/obj/item/reagent_containers/food/snacks/tinychocolate)

/obj/item/storage/fancy/heart_box/New()
	..()
	for(var/i = 1 to storage_slots)
		new /obj/item/reagent_containers/food/snacks/tinychocolate(src)
