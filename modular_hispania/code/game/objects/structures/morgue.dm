/obj/structure/morgue/attack_ai(mob/user as mob)
	if(isrobot(user))
		var/mob/living/silicon/robot/R = user
		if(istype(R.module,/obj/item/robot_module/medical))
			return attack_hand(user)
	return


/obj/structure/m_tray/attack_ai(mob/user as mob)
	if(isrobot(user))
		var/mob/living/silicon/robot/R = user
		if(istype(R.module,/obj/item/robot_module/medical))
			return attack_hand(user)
	return


/*
if(isrobot(user))
	var/mob/living/silicon/robot/R = user
	if(istype(R.module,/obj/item/robot_module/medical)
		return attack_hand(user)

	var/mob/living/silicon/robot/A = user
	if(A.module == /obj/item/robot_module/medical)
		return attack_hand(user)

	if(istype(user,/mob/living/silicon/robot))
		return attack_hand(user)
*/
