/obj/item/reagent_containers/hypospray/attack(mob/living/M, mob/user)
	. = ..()
	playsound(src, 'modular_hispania/sound/effects/hypospray.ogg',25)
	user.do_attack_animation(M)

/obj/item/reagent_containers/borghypo/attack(mob/living/carbon/human/M, mob/user)
	. = ..()
	playsound(src, 'modular_hispania/sound/effects/hypospray.ogg',25)
	user.do_attack_animation(M)

/*
/obj/item/reagent_containers/syringe/afterattack(atom/target, mob/user , proximity)
	var/mob/living/L
	if(!isliving(target))
		return
	L = target
	if(!L.can_inject(user, TRUE))
		return
	user.do_attack_animation(target)
	. = ..()
	user.do_attack_animation(target)
*/
