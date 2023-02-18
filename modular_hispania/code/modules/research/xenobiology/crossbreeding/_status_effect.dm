///////////////////////////////////////////////////////
//////////////////STABILIZED EXTRACTS//////////////////
///////////////////////////////////////////////////////

/datum/status_effect/stabilized //The base stabilized extract effect, has no effect of its' own.
	id = "stabilizedbase"
	duration = -1
	alert_type = null
	var/obj/item/slimecross/stabilized/linked_extract
	var/colour = "null"

/datum/status_effect/stabilized/tick()
	if(!linked_extract || !linked_extract.loc) //Sanity checking
		qdel(src)
		return
	if(linked_extract && linked_extract.loc != owner && linked_extract.loc.loc != owner)
		linked_extract.linked_effect = null
		if(!QDELETED(linked_extract))
			linked_extract.owner = null
			START_PROCESSING(SSobj,linked_extract)
		qdel(src)
	return ..()

/datum/status_effect/stabilized/null //This shouldn't ever happen, but just in case.
	id = "stabilizednull"


//Stabilized effects start below.
/datum/status_effect/stabilized/grey
	id = "stabilizedgrey"
	colour = "grey"

/datum/status_effect/stabilized/grey/tick()
	for(var/mob/living/simple_animal/slime/S in range(1, get_turf(owner)))
		if(!(owner in S.Friends))
			to_chat(owner, "<span class='notice'>[linked_extract] pulses gently as it communicates with [S]</span>")
			S.Friends[owner] = 1
	return ..()

/datum/status_effect/stabilized/orange
	id = "stabilizedorange"
	colour = "orange"

/datum/status_effect/stabilized/orange/tick()
	var/body_temperature_difference = BODYTEMP_NORMAL - owner.bodytemperature
	owner.adjust_bodytemperature(min(5,body_temperature_difference))
	return ..()

/datum/status_effect/stabilized/purple
	id = "stabilizedpurple"
	colour = "purple"

/datum/status_effect/stabilized/purple/tick()
	var/is_healing = FALSE
	if(owner.getBruteLoss() > 0)
		owner.adjustBruteLoss(-0.2)
		is_healing = TRUE
	if(owner.getFireLoss() > 0)
		owner.adjustFireLoss(-0.2)
		is_healing = TRUE
	if(owner.getToxLoss() > 0)
		owner.adjustToxLoss(-0.2, forced = TRUE) //Slimepeople should also get healed.
		is_healing = TRUE
	if(is_healing)
		examine_text = "<span class='warning'>SUBJECTPRONOUN is regenerating slowly, purplish goo filling in small injuries!</span>"
		new /obj/effect/temp_visual/heal(get_turf(owner), "#FF0000")
	else
		examine_text = null
	..()

/datum/status_effect/stabilized/metal
	id = "stabilizedmetal"
	colour = "metal"
	var/cooldown = 30
	var/max_cooldown = 30

/datum/status_effect/stabilized/metal/tick()
	if(cooldown > 0)
		cooldown--
	else
		cooldown = max_cooldown
		var/list/sheets = list()
		for(var/obj/item/stack/sheet/S in owner.GetAllContents())
			if(S.amount < S.max_amount)
				sheets += S

		if(sheets.len > 0)
			var/obj/item/stack/sheet/S = pick(sheets)
			S.amount++
			to_chat(owner, "<span class='notice'>[linked_extract] adds a layer of slime to [S], which metamorphosizes into another sheet of material!</span>")
	return ..()

/datum/status_effect/stabilized/yellow
	id = "stabilizedyellow"
	colour = "yellow"
	var/cooldown = 10
	var/max_cooldown = 10
	examine_text = "<span class='warning'>Nearby electronics seem just a little more charged wherever SUBJECTPRONOUN goes.</span>"

/datum/status_effect/stabilized/yellow/tick()
    if(cooldown > 0)
        cooldown--
        return ..()
    cooldown = max_cooldown
    var/list/batteries = list()
    for(var/obj/item/stock_parts/cell/C in owner.GetAllContents())
        if(C.charge < C.maxcharge)
            batteries += C
    if(batteries.len)
        var/obj/item/stock_parts/cell/ToCharge = pick(batteries)
        ToCharge.charge += min(ToCharge.maxcharge - ToCharge.charge, ToCharge.maxcharge/10) //10% of the cell, or to maximum.
        for(var/obj/item/gun/energy/G in owner.GetAllContents())
            G.on_recharge()
            G.update_icon()
        to_chat(owner, "<span class='notice'>[linked_extract] discharges some energy into a device you have.</span>")
    return ..()

/datum/status_effect/stabilized/pyrite
	id = "stabilizedpyrite"
	colour = "pyrite"
	var/originalcolor

/datum/status_effect/stabilized/pyrite/on_apply()
	originalcolor = owner.color
	return ..()

/datum/status_effect/stabilized/pyrite/tick()
	owner.color = rgb(rand(0,255),rand(0,255),rand(0,255))
	return ..()

/datum/status_effect/stabilized/pyrite/on_remove()
	owner.color = originalcolor

/datum/status_effect/stabilized/rainbow
	id = "stabilizedrainbow"
	colour = "rainbow"

/datum/status_effect/stabilized/rainbow/tick()
	if(owner.health <= 0)
		var/obj/item/slimecross/stabilized/rainbow/X = linked_extract
		if(istype(X))
			if(X.regencore)
				X.regencore.afterattack(owner,owner,TRUE)
				X.regencore = null
				owner.visible_message("<span class='warning'>[owner] flashes a rainbow of colors, and [owner.p_their()] skin is coated in a milky regenerative goo!</span>")
				qdel(src)
				qdel(linked_extract)
	return ..()
