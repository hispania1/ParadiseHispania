/obj/machinery/computer/cargo_upgrades
	name = "Cargo upgrades"
	var/list/recipes = list()
	var/tiempo = 2
	icon = 'icons/obj/computer.dmi'
	icon_keyboard = "syndie_key"
	icon_screen = "tcboss"

/obj/machinery/computer/cargo_upgrades/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "cargoupgrades", name, 400, 300, master_ui, state)
		ui.open()

/obj/machinery/computer/cargo_upgrades/attack_hand(mob/user)
	ui_interact(user)

/obj/machinery/computer/cargo_upgrades/ui_act(action, params)
	if(..())
		return
	. = TRUE
	switch(action)
		if("money_loss")
			to_chat(world,"aprete boton")

	add_fingerprint(usr)
