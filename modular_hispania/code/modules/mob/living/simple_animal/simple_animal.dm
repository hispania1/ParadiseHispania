/mob/living/simple_animal
	var/list/butcher_results_hispania = list()

/mob/living/simple_animal/Initialize()
	..()
	if(butcher_results == null)
		butcher_results = butcher_results_hispania
	else
		butcher_results |= butcher_results_hispania
