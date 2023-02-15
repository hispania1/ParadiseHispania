/obj/item
	var/pixelYoffset = 0
	var/hispania_icon = FALSE

/obj/item/proc/swapped(mob/usr)
	return

/obj/item/proc/swappedto(mob/usr)
	return

/obj/item/proc/hotkeyequip(mob/usr)
	return

/obj/item/proc/gotcha(mob/usr) // Al conseguir un objeto mediante put_in_hands()
	return

/obj/item/Initialize()
	..()

	icon = (hispania_icon ? 'modular_hispania/icons/obj/items.dmi' : icon)
	lefthand_file = (hispania_icon ? 'modular_hispania/icons/mob/inhands/items_lefthand.dmi' : lefthand_file)
	righthand_file = (hispania_icon ? 'modular_hispania/icons/mob/inhands/items_righthand.dmi' : righthand_file)
