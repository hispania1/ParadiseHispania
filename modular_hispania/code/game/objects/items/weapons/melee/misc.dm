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
	if(ramming)
		to_chat(user, "<span class='warning'>You are already ramming!</span>")
		return
	if(!proximity)
		return
	if(is_type_in_list(target,objetos_rompibles))
		ramming = TRUE
		var/obj/A = target
		rammear(A,user)
	ramming = FALSE

/obj/item/twohanded/required/ram/proc/rammear(obj/A,mob/user)
	user.do_attack_animation(A)
	playsound(get_turf(A), 'modular_hispania/sound/weapons/ram.ogg', 150, 1, -1)
	to_chat(viewers(user), "<span class='danger'>[user] rams [A]!</span>")
	if(do_after(usr, 10, target = A))
		if(A.obj_integrity <= 0)	//ya lo destruyo nuestro basico, no hagamos nada
			return
		if(A.take_damage(dmg_deal, damtype, "melee", 1) < A.obj_integrity)	//si aun le queda vida vuelve a pegar
			rammear(A,user)
		else
			if(QDELETED(A))	//por las dudas deq ya no exista
				return
			var/old_loc = null
			if(istype(A,/obj/machinery/door/airlock))
				old_loc = A.loc
			A.take_damage(dmg_deal, damtype, "melee", 1)	//ultimo hit!!
			if(old_loc != null)
				eliminar_restos(old_loc)

/obj/item/twohanded/required/ram/proc/eliminar_restos(old_loc)	//es lo mejor q se puede hacer sin tener q tocar el codigo de los airlocks
	for(var/obj/item/airlock_electronics/D in old_loc)	//destruye el airlock_assembly dropeado
		qdel(D)
	for(var/obj/structure/door_assembly/E in old_loc)	//destruye el assembly
		qdel(E)
