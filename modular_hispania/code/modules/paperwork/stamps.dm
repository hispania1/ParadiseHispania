/obj/item/stamp/suicide_act(mob/user)
	playsound(loc, 'modular_hispania/sound/misc/stamp_suicide.ogg', 70, TRUE) //Hispania Sounds


/obj/item/stamp/afterattack(atom/target, mob/user, proximity)
	..()
	if(!proximity)
		return
	if(istype(target,/obj/item/paper))
		playsound(loc, 'modular_hispania/sound/misc/stamp.ogg', 70, TRUE) //Hispania Sounds
