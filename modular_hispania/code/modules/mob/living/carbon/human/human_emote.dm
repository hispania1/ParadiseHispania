/datum/emote/living/carbon/human/scream/get_sound(mob/living/user)//esto funciona porque se queda con el primer return, se llama primero
	var/mob/living/carbon/human/human = user
	if(human.mind?.miming || !istype(human))
		return
	if(human.gender == FEMALE)
		return pick(human.dna.species.female_scream_sound)
	else
		return pick(human.dna.species.male_scream_sound)

/datum/emote/living/carbon/laugh/New()
	..()
	emote_type = EMOTE_SOUND | EMOTE_MOUTH

/datum/emote/living/carbon/human/cry/New()
	..()
	emote_type = EMOTE_SOUND | EMOTE_MOUTH

/datum/emote/living/carbon/yawn/New()
	..()
	emote_type = EMOTE_SOUND | EMOTE_MOUTH

/datum/emote/living/carbon/yawn/get_sound(mob/living/user)
	var/mob/living/carbon/human = user
	if(human.mind?.miming || !istype(human))
		return
	if(human.gender == FEMALE)
		return pick(human.dna.species.female_yawn_sound)
	else
		return pick(human.dna.species.male_yawn_sound)

/datum/emote/living/carbon/human/cry/get_sound(mob/living/user)
	var/mob/living/carbon/human/human = user
	if(human.mind?.miming || !istype(human))
		return
	if(human.gender == FEMALE)
		return pick(human.dna.species.female_cry_sound)
	else
		return pick(human.dna.species.male_cry_sound)


/datum/emote/living/carbon/laugh/get_sound(mob/living/user)
	var/mob/living/carbon/human/human = user
	if(human.mind?.miming || !istype(human))
		return
	if(human.gender == FEMALE)
		return pick(human.dna.species.female_laugh_sound)
	else
		return pick(human.dna.species.male_laugh_sound)
