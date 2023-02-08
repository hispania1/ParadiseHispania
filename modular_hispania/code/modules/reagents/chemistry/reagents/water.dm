/datum/reagent/holywater/on_mob_life(mob/living/M)
	var/update_flags = STATUS_UPDATE_NONE
	if(ishuman(M) && M.mind.isholy)
		update_flags |= M.adjustToxLoss(-1.5*REAGENTS_EFFECT_MULTIPLIER, FALSE)
