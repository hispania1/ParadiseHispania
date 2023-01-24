/obj/item/reagent_containers/hypospray/attack(mob/living/M, mob/user)
	playsound(src, 'modular_hispania/sound/effects/hypospray.ogg',25)
	if(..())
		user.do_attack_animation(M)

/obj/item/reagent_containers/borghypo/attack(mob/living/carbon/human/M, mob/user)
	playsound(src, 'modular_hispania/sound/effects/hypospray.ogg',25)
	if(..())
		user.do_attack_animation(M)

/obj/item/reagent_containers/syringe/afterattack(atom/target, mob/user , proximity)
	if(..())
		user.do_attack_animation(target)
