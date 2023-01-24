/datum/reagent/consumable/drink/hispania/agave
	name = "Agave Juice"
	id = "agave"
	description = "Principal reagent to make tequila."
	color = "#C9B25D"
	drink_icon = "agave_juice"
	drink_name = "Glass of Agave Juice"
	drink_desc = "Principal reagent to make tequila, are you sure about this?"
	taste_description = "Bland"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM

/datum/reagent/consumable/drink/hispania/anonna
	name = "Anonna Juice"
	id = "anonnajuice"
	description = "Magic juice with lovely taste"
	color = "#C1AA8D"
	drink_icon = "anonna_juice"
	drink_name = "Glass of Anonna Juice"
	drink_desc = "Magic juice with lovely taste."
	taste_description = "Sugary"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM

/datum/reagent/consumable/drink/hispania/kiwi
	name = "Kiwi Juice"
	id = "kiwi"
	description = "For some reasons kinda tastes like feathers"
	color = "#C5CA4C"
	drink_icon = "kiwi_juice"
	drink_name = "Glass of Kiwi Juice"
	drink_desc = "For some reasons kinda tastes like feathers."
	taste_description = "Sour Sweet"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM

/datum/reagent/consumable/drink/hispania/mango
	name = "Mango Juice"
	id = "mangojuice"
	description = "Sweat and pulpy"
	color = "#FF9903"
	drink_icon = "mango_juice"
	drink_name = "Glass of Mango Juice"
	drink_desc = "For some reasons kinda tastes like feathers."
	taste_description = "pulpy"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM

/datum/reagent/consumable/drink/hispania/mate
	name = "Mate"
	id = "mate"
	description = "Hipster stuff"
	color = "#948870"
	drink_icon = "glass_mate"
	drink_name = "Glass of Mate"
	drink_desc = "Hipster stuff"
	taste_description = "hipster"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM

/datum/reagent/consumable/drink/hispania/nispero
	name = "Nispero Juice"
	id = "nisperojuice"
	description = "Weird stuff no idea what is this"
	color = "#9B723C"
	drink_icon = "nispero_juice"
	drink_name = "Glass of Nispero Juice"
	drink_desc = "Weird stuff no idea what is this"
	taste_description = "sour sweet"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM

/datum/reagent/consumable/drink/hispania/peach
	name = "Peach Juice"
	id = "peachjuice"
	description = "Coloured, juicy fruit"
	color = "#FFB5B6"
	drink_icon = "peach_juice"
	drink_name = "Glass of Peach Juice"
	drink_desc = "Coloured, juicy fruit"
	taste_description = "deliciously sweet"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM

/datum/reagent/consumable/drink/hispania/castor
	name = "Castor Oil"
	id = "castor_oil"
	description = "smells like beans"
	color = "#9D8F62"
	drink_icon = "castor_oil"
	drink_name = "Glass of Castor Oil"
	drink_desc = "smells like beans"
	taste_description = "beans"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM

/datum/reagent/consumable/castor/on_mob_life(mob/living/carbon/M)
	var/update_flags = STATUS_UPDATE_NONE
	update_flags |= M.adjustBruteLoss(-2*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	update_flags |= M.adjustFireLoss(-2*REAGENTS_EFFECT_MULTIPLIER, FALSE)
	return ..() | update_flags

/datum/reagent/consumable/drink/hispania/strawberry
	name = "Strawberry Juice"
	id = "strawberry"
	description = "Acidic and sweet"
	color = "#FF292E"
	drink_icon = "straw_juice"
	drink_name = "Glass of Strawberry Juice"
	drink_desc = "Acidic and sweet"
	taste_description = "sweet citric"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM

/datum/reagent/consumable/drink/hispania/cactusjuice
	name = "Prickly Pear Cactus Juice"
	id = "cactusjuice"
	description = "The lower tier of the avocado."
	color = "#5BB615"
	drink_icon = "cactus_juice"
	drink_name = "Glass of Prickly Pear Cactus Juice"
	drink_desc = "Wait what, cactus?"
	taste_description = "bland water"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM

/datum/reagent/consumable/drink/hispania/green_juice
	name= "Green Juice"
	id = "green_juice"
	description = "A drinkable salad?"
	color = "#2D572C"
	nutriment_factor = 2 * REAGENTS_METABOLISM
	drink_icon = "green_juice"
	drink_name = "Glass of Green Juice"
	drink_desc = "A drinkable salad?"
	taste_description = "grassy"

/datum/reagent/consumable/drink/hispania/drakeblood
	name = "Drake Blood"
	id = "drakeblood"
	description = "The raw essence of a Drake."
	color = "#E6502F"
	drink_icon = "drakeblood"
	drink_name = "Glass of drake blood"
	drink_desc = "The raw essence of a Drake RAAWR"
	taste_description = "fresh blood."
