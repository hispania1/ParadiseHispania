/datum/species
	var/list/male_laugh_sound
	var/list/female_laugh_sound
	var/list/male_cry_sound
	var/list/female_cry_sound
	var/list/male_yawn_sound
	var/list/female_yawn_sound

/datum/species/New()
	male_scream_sound = list('modular_hispania/sound/voice/human/malescream_1.ogg',
	'modular_hispania/sound/voice/human/malescream_2.ogg',
	'modular_hispania/sound/voice/human/malescream_3.ogg',
	'modular_hispania/sound/voice/human/malescream_4.ogg',
	'modular_hispania/sound/voice/human/malescream_5.ogg',
	'sound/goonstation/voice/male_scream.ogg',)

	female_scream_sound = list('modular_hispania/sound/voice/human/femalescream_1.ogg',
	'modular_hispania/sound/voice/human/femalescream_2.ogg',
	'modular_hispania/sound/voice/human/femalescream_3.ogg',
	'modular_hispania/sound/voice/human/femalescream_4.ogg',
	'modular_hispania/sound/voice/human/femalescream_5.ogg',
	'sound/goonstation/voice/female_scream.ogg',)

	male_laugh_sound = list('modular_hispania/sound/voice/human/manlaugh.ogg')

	female_laugh_sound = list('modular_hispania/sound/voice/human/womanlaugh.ogg')

	female_cry_sound = list('modular_hispania/sound/voice/human/femalecry1.ogg',
	'modular_hispania/sound/voice/human/femalecry2.ogg')

	female_yawn_sound = list('modular_hispania/sound/voice/human/femaleyawn1.ogg',
	'modular_hispania/sound/voice/human/femaleyawn2.ogg')

	male_yawn_sound = list('modular_hispania/sound/voice/human/maleyawn1.ogg',
	'modular_hispania/sound/voice/human/maleyawn2.ogg')

