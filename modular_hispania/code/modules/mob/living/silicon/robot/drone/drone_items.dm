/obj/item/gripper
	var/list/hispa_can_hold = list(
		/obj/item/stack/sheet/mineral
	)

/obj/item/gripper/Initialize(mapload)
	can_hold |= hispa_can_hold
	..()
