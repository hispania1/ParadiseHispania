/obj/item/photo/attack(mob/living/carbon/M, mob/living/carbon/user, def_zone)
	if(!ishuman(M))
		return ..()
	var/mob/living/carbon/human/H = M
	if(user.zone_selected == "eyes")
		user.visible_message("<span class='notice'>[user] holds up a photo and shows it to [H].</span>",
			"<span class='notice'>You show the photo to [H].</span>")
		show(H)
	else
		return ..()
