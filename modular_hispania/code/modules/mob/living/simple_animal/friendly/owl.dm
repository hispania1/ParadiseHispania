/mob/living/simple_animal/friendly/owl
	name = "Garronte"
	desc = "When you sleep, he is awake!. In the eyes you can look the future."
	gender = MALE
	health = 25
	maxHealth = 25
	density = TRUE
	icon = 'modular_hispania/icons/mob/animals.dmi'
	icon_state = "owl"
	icon_living = "owl"
	icon_dead = "owl_dead"
	speak = list("Hoot.","Hoot?","Hoot!","Cough.")
	speak_emote = list("hoot")
	emote_hear = list("hoot")
	emote_see = list("hoot")
	var/owl_sound = 'modular_hispania/sound/mob/owl_hoot.ogg'	//Used in emote.
	speak_chance = 1
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat = 3)
	turns_per_move = 10
	can_collar = FALSE
	unique_pet = TRUE
	melee_damage_lower = 0
	melee_damage_upper = 2
	attacktext = "scratch"
	attack_sound = 'sound/weapons/pierce.ogg'
	speak_chance = 1

/datum/emote/living/simple_animal/friendly/owl
	key = "hoot"
	key_third_person = "hoots"
	message = "Hoots!"
	message_simple = "hoots."
	emote_type = EMOTE_SOUND | EMOTE_MOUTH
	volume = 80
	sound = 'modular_hispania/sound/mob/owl_hoot.ogg'
/datum/keybinding/emote/living/simple_animal/friendly/owl
	linked_emote = /datum/emote/living/simple_animal/friendly/owl
	name = "Hoot"

/mob/living/simple_animal/friendly/owl/handle_automated_speech()
	..()
	if(prob(speak_chance) && !incapacitated())
		playsound(src, owl_sound, 50, 1)
