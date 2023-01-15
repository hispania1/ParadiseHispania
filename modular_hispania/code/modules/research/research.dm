/datum/research/clothelate

/datum/research/clothelate/DesignHasReqs(datum/design/D)
	return D && (D.build_type & CRAFTLATHE) && ("initial" in D.category)

/datum/research/clothelate/CanAddDesign2Known(datum/design/design)
	// Specifically excludes circuit imprinter and mechfab
	if(design.locked || !(design.build_type & (AUTOLATHE|PROTOLATHE|CRAFTLATHE)))
		return FALSE

	for(var/mat in design.materials)
		if(mat != MAT_METAL)
			return FALSE

	return ..()
