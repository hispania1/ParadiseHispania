/obj/item/slime_extract
	var/effectmod
	var/list/activate_reagents = list() //Reagents required for activation
	var/recurring = FALSE

/obj/item/slime_extract/examine(mob/user)
	. = ..()
	if(Uses > 1)
		. += "It has [Uses] uses remaining."


//Core-crossing: Feeding adult slimes extracts to obtain a much more powerful, single extract.
/obj/item/slime_extract/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return
	if(!M.is_adult)
		to_chat(user, "<span class='warning'>The slime must be an adult to cross its core!</span>")
		return
	if(M.effectmod && M.effectmod != effectmod)
		to_chat(user, "<span class='warning'>The slime is already being crossed with a different extract!</span>")
		return

	if(!M.effectmod)
		M.effectmod = effectmod

	M.applied++
	qdel(src)
	to_chat(user, "<span class='notice'>You feed the slime [src], [M.applied == 1 ? "starting to mutate its core." : "further mutating its core."]</span>")
	playsound(M, 'sound/effects/attackblob.ogg', 50, TRUE)

	if(M.applied >= SLIME_EXTRACT_CROSSING_REQUIRED)
		M.spawn_corecross()


/obj/item/slime_extract/grey
	effectmod = "reproductive"
	activate_reagents = list("blood","plasma_dust","water")
	color_slime = "grey"

/obj/item/slime_extract/gold
	effectmod = "symbiont"
	activate_reagents = list("blood","plasma_dust","water")
	color_slime = "gold"

/obj/item/slime_extract/silver
	effectmod = "consuming"
	activate_reagents = list("plasma_dust","water")
	color_slime = "silver"

/obj/item/slime_extract/metal
	effectmod = "industrial"
	activate_reagents = list("plasma_dust","water")
	color_slime = "metal"

/obj/item/slime_extract/purple
	effectmod = "regenerative"
	activate_reagents = list("plasma_dust")
	color_slime = "purple"

/obj/item/slime_extract/darkpurple
	effectmod = "self-sustaining"
	activate_reagents = list("plasma_dust")
	color_slime = "darkpurple"

/obj/item/slime_extract/orange
	effectmod = "burning"
	activate_reagents = list("blood","plasma_dust")
	color_slime = "orange"

/obj/item/slime_extract/yellow
	effectmod = "charged"
	activate_reagents = list("blood","plasma_dust","water")
	color_slime = "yellow"

/obj/item/slime_extract/red
	effectmod = "sanguine"
	activate_reagents = list("blood","plasma_dust","water")
	color_slime = "red"

/obj/item/slime_extract/blue
	effectmod = "stabilized"
	activate_reagents = list("blood","plasma_dust")
	color_slime = "blue"

/obj/item/slime_extract/darkblue
	effectmod = "chilling"
	activate_reagents = list("plasma_dust","water")
	color_slime = "darkblue"

/obj/item/slime_extract/pink
	effectmod = "gentle"
	activate_reagents = list("plasma_dust")
	color_slime = "pink"

/obj/item/slime_extract/green
	effectmod = "mutative"
	activate_reagents = list("plasma_dust")
	color_slime = "green"

/obj/item/slime_extract/lightpink
	effectmod = "loyal"
	activate_reagents = list("plasma_dust")
	color_slime = "lightpink"

/obj/item/slime_extract/black
	effectmod = "transformative"
	activate_reagents = list("plasma_dust")
	color_slime = "black"

/obj/item/slime_extract/oil
	effectmod = "detonating"
	activate_reagents = list("plasma_dust")
	color_slime = "oil"

/obj/item/slime_extract/adamantine
	effectmod = "crystalline"
	activate_reagents = list("plasma_dust")
	color_slime = "adamantine"

/obj/item/slime_extract/bluespace
	effectmod = "warping"
	activate_reagents = list("blood","plasma_dust")
	color_slime = "bluespace"

/obj/item/slime_extract/pyrite
	effectmod = "prismatic"
	activate_reagents = list("plasma_dust")
	color_slime = "pyrite"

/obj/item/slime_extract/cerulean
	effectmod = "recurring"
	activate_reagents = list("blood","plasma_dust")
	color_slime = "cerulean"

/obj/item/slime_extract/sepia
	effectmod = "lengthened"
	activate_reagents = list("blood","plasma_dust")
	color_slime = "sepia"

/obj/item/slime_extract/rainbow
	effectmod = "hyperchromatic"
	activate_reagents = list("blood","plasma_dust")
	color_slime = "rainbow"
