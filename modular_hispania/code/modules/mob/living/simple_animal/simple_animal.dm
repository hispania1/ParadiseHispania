/mob/living/simple_animal
	var/list/butcher_results_hispania = list()

/mob/living/simple_animal/Initialize()
	..()
	butcher_results |= butcher_results_hispania
