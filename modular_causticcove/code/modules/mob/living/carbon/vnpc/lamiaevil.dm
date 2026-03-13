GLOBAL_LIST_INIT(lamia_aggro, world.file2list("strings/rt/evillamiaaggrolines.txt"))

/mob/living/carbon/human/species/lamiaevil
	name = "lamia"
	skin_tone = SKIN_COLOR_GROONN
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	var/lamiaevil_outfit = /datum/outfit/job/roguetown/lamiaevil/npc
	var/is_silent = FALSE

	race = /datum/species/demihuman
	gender = MALE
	bodyparts = list(/obj/item/bodypart/chest, /obj/item/bodypart/head, /obj/item/bodypart/l_arm,
					 /obj/item/bodypart/r_arm, /obj/item/bodypart/r_leg, /obj/item/bodypart/l_leg)
	ambushable = FALSE

	base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/unarmed/claw)
	a_intent = INTENT_HELP
	d_intent = INTENT_PARRY
	possible_mmb_intents = list(INTENT_SPECIAL, INTENT_JUMP, INTENT_KICK, INTENT_BITE)
	possible_rmb_intents = list(/datum/rmb_intent/feint, /datum/rmb_intent/aimed, /datum/rmb_intent/strong, /datum/rmb_intent/weak, /datum/rmb_intent/swift, /datum/rmb_intent/riposte)

/mob/living/carbon/human/species/lamiaevil/npc
	faction = list("vbandit", "station")
	aggressive = 1
	rude = TRUE
	mode = NPC_AI_IDLE
	wander = FALSE
	cmode_music = FALSE
	is_voracious_npc = TRUE
	voremode = TRUE

/mob/living/carbon/human/species/lamiaevil/npc/Initialize()
	. = ..()
	set_species(/datum/species/demihuman)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	load_lamia_bellies()

/mob/living/carbon/human/species/lamiaevil/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(!is_silent && target != newtarg)
			say(pick(GLOB.lamia_aggro))
			pointed(target)


/mob/living/carbon/human/species/lamiaevil/npc/load_mob_bellies()
	..()


/mob/living/carbon/human/species/lamiaevil/npc/after_creation()
	..()
	job = "Bandit"
	equipOutfit(new lamiaevil_outfit)
	gender = pick(MALE, FEMALE)
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	var/hairf = pick(list(/datum/sprite_accessory/hair/head/himecut,
						/datum/sprite_accessory/hair/head/countryponytailalt,
						/datum/sprite_accessory/hair/head/stacy,
						/datum/sprite_accessory/hair/head/kusanagi_alt))
	var/hairm = pick(list(/datum/sprite_accessory/hair/head/ponytailwitcher,
						/datum/sprite_accessory/hair/head/dave,
						/datum/sprite_accessory/hair/head/emo,
						/datum/sprite_accessory/hair/head/sabitsuki,
						/datum/sprite_accessory/hair/head/sabitsuki_ponytail))
	head.sellprice = 30

	src.set_patron(/datum/patron/divine/dendor)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NATURAL_ARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CHUNKYFINGERS, TRAIT_GENERIC)
	var/datum/bodypart_feature/hair/head/new_hair = new()
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	var/obj/item/organ/ears/organ_ears = getorgan(/obj/item/organ/ears)

	if(organ_eyes)
		organ_eyes.eye_color = "#FF0000"
		organ_eyes.accessory_colors = "#FF0000#FF0000"
	var/skinchoose = rand(1,5)
	var/skincolor = "#fff0e9"
	var/skincolor2 = "fff0e9"
	switch(skinchoose) //choosing the skincolor of the snek
		if(1)
			skincolor = "#fff0e9"
			skincolor2 = "fff0e9"
		if(2)
			skincolor = "#edc6b3"
			skincolor2 = "edc5b3"
		if(3)
			skincolor = "#ba9882"
			skincolor2 = "ba9882"
		if(4)
			skincolor = "#9c6f52"
			skincolor2 = "9c6f52"
		if(5)
			skincolor = "#5d4c41"
			skincolor2 = "5d4c41"
	var/tailchoose = rand(1,5)
	var/tailcolor = "#520f0f"
	switch(tailchoose) //choosing the skincolor of the snek
		if(1)
			tailcolor = "#520f0f"
		if(2)
			tailcolor = "#1e5704"
		if(3)
			tailcolor = "#161c69"
		if(4)
			tailcolor = "#dfb988"
		if(5)
			tailcolor = "#9e6905"
	Taurize(/obj/item/bodypart/taur/lamia, tailcolor)

	skin_tone = skincolor2

	if(organ_ears)
		organ_ears.accessory_colors = skincolor

	if(gender == FEMALE)
		new_hair.set_accessory_type(hairf, null, src)
		var/obj/item/organ/breasts/breasts = src.getorganslot(ORGAN_SLOT_BREASTS)
		if(!breasts)
			breasts = new()
			breasts.Insert(src, TRUE, FALSE)
		breasts.accessory_type = /datum/sprite_accessory/breasts/pair
		breasts.breast_size = rand(1,16)
		breasts.accessory_colors = skincolor

	else
		new_hair.set_accessory_type(hairm, null, src)
		
	var/obj/item/organ/butt/butt = src.getorganslot(ORGAN_SLOT_BUTT)
	if(!butt)
		butt = new()
		butt.Insert(src, TRUE, FALSE)
	butt.accessory_type = /datum/sprite_accessory/butt/pair
	butt.organ_size = rand(0,5)
	butt.accessory_colors = skincolor

	var/obj/item/organ/belly/belly = src.getorganslot(ORGAN_SLOT_BELLY)
	if(!belly)
		belly = new()
		belly.Insert(src, TRUE, FALSE)
	belly.accessory_type = /datum/sprite_accessory/belly
	belly.belly_size = 0
	belly.accessory_colors = skincolor

	head.add_bodypart_feature(new_hair)

	new_hair.accessory_colors = "#31302E"
	new_hair.hair_color = "#31302E"
	hair_color = "#31302E"

	dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
	dna.species.handle_body(src)
	if(gender == FEMALE)
		real_name = pick(world.file2list("strings/rt/names/elf/elfwf.txt"))
	else
		real_name = pick(world.file2list("strings/rt/names/elf/elfwm.txt"))
	update_hair()
	update_body()

/datum/outfit/job/roguetown/lamiaevil/npc/pre_equip(mob/living/carbon/human/H) //tribal ass sneks in your area
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		wrists = /obj/item/clothing/wrists/roguetown/bracers/copper
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	neck = /obj/item/clothing/neck/roguetown/gorget/copper
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/leather
	H.STASTR = 14
	H.STASPD = 14
	H.STACON = 12
	H.STAWIL = 11
	H.STAPER = 11
	H.STAINT = 3 //stupid snakes
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
