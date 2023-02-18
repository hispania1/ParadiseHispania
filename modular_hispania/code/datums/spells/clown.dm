/obj/effect/proc_holder/spell/clown/pie_cannon 			//pie cannon spell
	name = "Deploy pie cannon"
	desc = "Activate to deploy your very own auto-recharging pie cannon."
	school = "clown"
	panel = "Clown"
	clothes_req = FALSE
	base_cooldown = 15 SECONDS
	human_req = TRUE
	action_icon_state = "clown"
	action_background_icon_state = "bg_mime"
	var/gun = /obj/item/gun/throw/piecannon/auto_piecannon

/obj/effect/proc_holder/spell/clown/create_new_targeting()
	return new /datum/spell_targeting/self

/obj/effect/proc_holder/spell/clown/pie_cannon/cast(list/targets, mob/user = usr)
	for(var/mob/living/carbon/human/C in targets)
		if(!istype(C.get_active_hand(), gun) && !istype(C.get_inactive_hand(), gun))
			to_chat(user, "<span class='notice'>You draw your pie cannon!</span>")
			C.drop_item()
			C.put_in_hands(new gun)
		else
			to_chat(user, "<span class='notice'>Holster your pie cannon first.</span>")
			revert_cast(user)

//empieza el lube floor spell
/obj/effect/proc_holder/spell/clown/floor_lube
	name = "Floor lube"
	desc = "placeholder"
	school = "clown"
	panel = "Clown"
	clothes_req = FALSE
	base_cooldown = 8 SECONDS
	human_req = TRUE

/obj/effect/proc_holder/spell/clown/floor_lube/create_new_targeting()
	return new /datum/spell_targeting/self

/obj/effect/proc_holder/spell/clown/floor_lube/cast(list/targets, mob/user = usr)
	if(user.dir == SOUTH || user.dir == NORTH)
		for(var/turf/simulated/floor/O in range("3x1", usr))
			O.MakeSlippery(TURF_WET_LUBE, 20 SECONDS)
	else
		for(var/turf/simulated/floor/O in range("1x3", usr))
			O.MakeSlippery(TURF_WET_LUBE, 20 SECONDS)

///Empieza el spellbook
/obj/item/spellbook/oneuse/clown
	spellname = "Advanced Clowning"
	name = "Tome of: "
	desc = "As soon as you open the book images of the HonkMother start flashing inside your mind.. So beautiful."
	icon_state = "bookmime"
	var/ash_type = /obj/effect/decal/cleanable/ash

/obj/item/spellbook/oneuse/clown/attack_self(mob/user)
	if(usr.mind.miming)
		if(do_after(usr, 150, target = usr))
			usr.gib()
	else
		var/obj/effect/proc_holder/spell/S = new spell
		for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
			if(knownspell.type == S.type)
				if(user.mind)
					to_chat(user, "<span class='notice'>You've already read this one.</span>")
				return
		if(used)
			recoil(user)
		else
			user.mind.AddSpell(new /obj/effect/proc_holder/spell/clown/pie_cannon(null))
			user.mind.AddSpell(new /obj/effect/proc_holder/spell/clown/floor_lube(null))
			to_chat(user, "<span class='notice'>As soon as you open the book images of the HonkMother start flashing inside your mind.. So beautiful.</span>")
			user.create_log(MISC_LOG, "learned the spell [spellname] ([S])")
			user.create_attack_log("<font color='orange'>[key_name(user)] learned the spell [spellname] ([S]).</font>")
			onlearned(user)

/obj/item/spellbook/oneuse/clown/recoil(mob/user)
	to_chat(user, "<span class='notice'>You flip through the pages. Nothing of interest to you.</span>")

/obj/item/spellbook/oneuse/clown/onlearned(mob/user)
	used = TRUE
	user.drop_item()
	new ash_type((get_turf(src)))
	qdel(src)
