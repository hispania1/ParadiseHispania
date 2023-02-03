/mob/living/silicon/robot/nations
	base_icon = "droidpeace"
	icon_state = "droidpeace"
	modtype = "Nations"
	designation = "Nations"
	hud_possible = list(SPECIALROLE_HUD, DIAG_STAT_HUD, DIAG_HUD,NATIONS_HUD)

/mob/living/silicon/robot/nations/init()
	..()
	module = new /obj/item/robot_module/nations(src)
	//languages
	module.add_languages(src)
	//subsystems
	module.add_subsystems_and_actions(src)

	status_flags &= ~CANPUSH

	notify_ai(2)

/obj/item/robot_module/nations
	name = "nations robot module"
	module_type = "Malf"

/obj/item/robot_module/nations/New()
	..()
	modules += new /obj/item/restraints/handcuffs/cable/zipties/cyborg(src)
	modules += new /obj/item/pickaxe/drill/jackhammer(src)
	modules += new /obj/item/borg/destroyer/mobility(src)
	modules += new /obj/item/wrench/cyborg(src)
	modules += new /obj/item/melee/baton/loaded(src)
	modules += new /obj/item/gun/energy/disabler/cyborg(src)

	fix_modules()

/obj/item/robot_module/janitor/Initialize(mapload)
	..()
	var/list/hispa = (/obj/item/clothing/head/plunger)
	basic_modules |= hispa
