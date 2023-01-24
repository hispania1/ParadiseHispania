/obj/effect/landmark/spawner/feedmespawn
	name = "feed me spawn"
	icon = 'icons/effects/spawner_icons.dmi'
	icon_state = "clown"

/obj/effect/landmark/spawner/feedmespawn/Initialize(mapload)
	spawner_list = GLOB.feedmespawn
	return ..()
