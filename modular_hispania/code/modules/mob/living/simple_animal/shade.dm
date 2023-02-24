/mob/living/simple_animal/shade/sword/update_runechat_msg_location()
	if(istype(loc, /obj/item/nullrod/scythe/talking))
		runechat_msg_location = loc.UID()
	else
		return ..()

/mob/living/simple_animal/shade/sword/Initialize(mapload)
	. = ..()
	AddSpell(new /obj/effect/proc_holder/spell/endure(null))

/obj/effect/proc_holder/spell/endure
	name = "Harden"
	desc = "You strengthen your metal with additional epidermal layers"
	school = "transmutation"
	base_cooldown = 15 SECONDS
	stat_allowed = 1
	clothes_req = FALSE
	sound = null
	invocation = "none"
	invocation_type = "none"
	cooldown_min = 1
	action_icon_state = "blood_swell"
	action_background_icon_state = "bg_demon"

/obj/effect/proc_holder/spell/endure/create_new_targeting()
	return new /datum/spell_targeting/self

/obj/effect/proc_holder/spell/endure/cast(list/targets, mob/living/user = usr)
	for(var/obj/item/nullrod/scythe/talking/A in world)
		if(A.name == user.name)//esto es horrible pero por como funciona el codigo de los shade no queda otra
			playsound(A.loc, 'modular_hispania/sound/effects/endure.ogg', 70, TRUE)
			A.add_atom_colour("#FF0000", TEMPORARY_COLOUR_PRIORITY)
			A.force += 20
			spawn(100) //10sec
				A.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY,"#FF0000")
				A.force -= 20
