/obj/item/twohanded/required/ram
	name = "ram"
	desc = "A heavy ram used to take down those annoying doors or other structures in your way."
	icon = 'modular_hispania/icons/obj/items.dmi'
	icon_state = "ram"
	item_state = "ram"
	force = 10
	throwforce = 24
	throw_range = 3
	force_wielded = 20 // La fire-axe hace 24
	attack_verb = list("rammed")
	hitsound = 'modular_hispania/sound/weapons/ram.ogg'
	usesound = 'modular_hispania/sound/weapons/ram.ogg'
	max_integrity = 100
	drop_sound = 'modular_hispania/sound/items/heavy_weapon_drop.ogg'
	hispania_icon = TRUE
	var/ramming = FALSE
	var/dmg_deal = 120
	var/list/objetos_rompibles = list(
	/obj/machinery/door/airlock,
	/obj/structure/door_assembly,
	/obj/machinery/door/window,
	/obj/structure/window,
	/obj/structure/grille,
	/obj/structure/table,
	/obj/structure/barricade,
	/obj/structure/closet,
	)


/obj/item/twohanded/required/ram/afterattack(atom/target, mob/user, proximity)
	var/borrar_asembly = FALSE
	if(ramming)
		to_chat(user, "<span class='warning'>You are already ramming!</span>")
		return
	if(!proximity)
		return
	if(is_type_in_list(target,objetos_rompibles))
		ramming = TRUE
		var/obj/A = target
		playsound(get_turf(A), 'modular_hispania/sound/weapons/ram.ogg', 150, 1, -1)
		if(do_after(usr, 10, target = A))
			ramming = FALSE
			user.do_attack_animation(A)
			to_chat(viewers(user), "<span class='danger'>[user] rams [A]!</span>")
			if(A.take_damage(dmg_deal, damtype, "melee", 1) < A.obj_integrity) 	//Si el golpe no va destruir la puerta
				afterattack(A, user, proximity)
			else
				var/old_loc = A.loc
				if(istype(A,/obj/machinery/door/airlock))
					borrar_asembly = TRUE
				A.take_damage(dmg_deal, damtype, "melee", 1)
				if(borrar_asembly)
					for(var/obj/item/airlock_electronics/D in old_loc)	//destruye el airlock_assembly dropeado
						qdel(D)
					for(var/obj/structure/door_assembly/E in old_loc)	//destruye el assembly
						qdel(E)
