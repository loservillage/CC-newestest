//Anything related to NPC that does vore.
/mob/living
	var/vore_stomach_name				// The name for the first belly if not "stomach"
	var/vore_stomach_flavor				// The flavortext for the first belly if not the default
	var/vore_default_mode = DM_DIGEST	// Default bellymode (DM_DIGEST, DM_HOLD, DM_ABSORB)
	var/vore_default_flags = 0			// No flags
	var/vore_digest_chance = 0		// Chance to switch to digest mode if resisted
	var/vore_absorb_chance = 0			// Chance to switch to absorb mode if resisted
	var/vore_escape_chance = 25			// Chance of resisting out of mob
	var/vore_escape_chance_absorbed = 20// Chance of absorbed prey finishing an escape. Requires a successful escape roll against the above as well.
	var/vore_default_item_mode = IM_DIGEST_FOOD			//How belly will interact with items
	var/vore_default_contaminates = FALSE				//Will it contaminate? // CHOMPedit: Put back to true like it always was.
	var/vore_default_contamination_flavor = "Generic"	//Contamination descriptors
	var/vore_default_contamination_color = "green"		//Contamination color
	var/swallowTime = 5 SECONDS	

/mob/living/carbon/human
	//are they able to eat nerds.
	var/is_voracious_npc = FALSE

/mob/living/carbon/human/proc/increase_belly_size()
	var/obj/item/organ/belly/_belly = getorganslot("belly")
	if(!_belly)
		return
	_belly.belly_size = 3
	src.regenerate_icons()

/mob/living/carbon/human/proc/decrease_belly_size()
	var/obj/item/organ/belly/_belly = getorganslot("belly")
	if(!_belly)
		return
	_belly.belly_size = 0
	src.regenerate_icons()

/mob/living/proc/load_mob_bellies()
	//A much more detailed version of the default /living implementation
	var/obj/belly/B = new /obj/belly(src)
	vore_selected = B
	B.immutable = TRUE
	B.can_taste = TRUE
	B.name = vore_stomach_name ? vore_stomach_name : "stomach"
	B.desc = vore_stomach_flavor ? vore_stomach_flavor : "Your surroundings are warm, soft, and slimy. Makes sense, considering you're inside %pred."
	B.digest_mode = vore_default_mode
	B.mode_flags = vore_default_flags
	B.item_digest_mode = vore_default_item_mode
	B.contaminates = vore_default_contaminates
	B.contamination_flavor = vore_default_contamination_flavor
	B.contamination_color = vore_default_contamination_color
	B.escapable = vore_escape_chance > 0
	B.escapechance = vore_escape_chance
	B.escapechance_absorbed = vore_escape_chance_absorbed
	B.digestchance = vore_digest_chance
	B.absorbchance = vore_absorb_chance
	B.human_prey_swallow_time = swallowTime
	B.nonhuman_prey_swallow_time = swallowTime
	B.vore_verb = "swallow"
	B.emote_lists[DM_HOLD] = list( // We need more that aren't repetitive. I suck at endo. -Ace
		"The insides knead at you gently for a moment.",
		"The guts glorp wetly around you as some air shifts.",
		"The predator takes a deep breath and sighs, shifting you somewhat.",
		"The stomach squeezes you tight for a moment, then relaxes harmlessly.",
		"The predator's calm breathing and thumping heartbeat pulses around you.",
		"The warm walls kneads harmlessly against you.",
		"The liquids churn around you, though there doesn't seem to be much effect.",
		"The sound of bodily movements drown out everything for a moment.",
		"The predator's movements gently force you into a different position.")
	B.emote_lists[DM_DIGEST] = list(
		"The burning acids eat away at your form.",
		"The muscular stomach flesh grinds harshly against you.",
		"The caustic air stings your chest when you try to breathe.",
		"The slimy guts squeeze inward to help the digestive juices soften you up.",
		"The onslaught against your body doesn't seem to be letting up; you're food now.",
		"The predator's body ripples and crushes against you as digestive enzymes pull you apart.",
		"The juices pooling beneath you sizzle against your sore skin.",
		"The churning walls slowly pulverize you into meaty nutrients.",
		"The stomach glorps and gurgles as it tries to work you into slop.")
	can_be_drop_pred = TRUE // Mobs will eat anyone that decides to drop/slip into them by default.
	B.belly_fullscreen = "a_tumby"
	B.belly_fullscreen_color = "#823232"
	B.belly_fullscreen_color2 = "#823232"
//--------------------------------------------------------------------------
//Credit to Syribirb for doing the entirety of the belly descriptions!
/mob/living/proc/load_gob_bellies()
	//Loading goblin bellies for goblin NPCs
	var/obj/belly/M = new /obj/belly(src)
	vore_selected = M
	M.immutable = TRUE
	M.can_taste = TRUE
	M.name = vore_stomach_name ? vore_stomach_name : "maw"
	M.desc = vore_stomach_flavor ? vore_stomach_flavor : "Finally the little beast gets its hands on you.  Tired and numb, you can resist no longer as the greenskin yanks your armor down to bring you level with their lips.  Jagged white teeth gleam at the edges of your vision, and you get one final glimpse of a dripping and pulsing throat before it overtakes you entirely. </br></br>Its tongue drags across your features, tasting you as claws dig into your sides.   You can feel those jagged teeth finally scrape across your scalp and towards the back of your head.   It holds you there for a sadistic minute or two.  Shrill laughter rumbles against your scalp, leaving drool to ooze down your chest and hot breath to billow down your neck…"
	M.digest_mode = vore_default_mode
	M.mode_flags = vore_default_flags
	M.item_digest_mode = vore_default_item_mode
	M.contaminates = vore_default_contaminates
	M.contamination_flavor = vore_default_contamination_flavor
	M.contamination_color = vore_default_contamination_color
	M.escapable = vore_escape_chance > 0
	M.escapechance = vore_escape_chance
	M.escapechance_absorbed = vore_escape_chance_absorbed
	M.digestchance = 0
	M.absorbchance = 0
	M.human_prey_swallow_time = swallowTime
	M.nonhuman_prey_swallow_time = swallowTime
	M.digest_brute = 0
	M.digest_burn = 0
	M.digest_mode = "Hold"
	M.vore_verb = "swallow"
	M.examine_messages = list(
		"%pred has %prey's head stuck in their mouth!",
		"Drool oozes down %prey's frame as they're crudely tasted with their struggling frame shoved ever deeper…")
	M.emote_lists[DM_HOLD] = list( // We need more that aren't repetitive. I suck at endo. -Ace
		"The insides knead at you gently for a moment.",
		"The guts glorp wetly around you as some air shifts.",
		"The predator takes a deep breath and sighs, shifting you somewhat.",
		"The stomach squeezes you tight for a moment, then relaxes harmlessly.",
		"The predator's calm breathing and thumping heartbeat pulses around you.",
		"The warm walls kneads harmlessly against you.",
		"The liquids churn around you, though there doesn't seem to be much effect.",
		"The sound of bodily movements drown out everything for a moment.",
		"The predator's movements gently force you into a different position.")
	can_be_drop_pred = TRUE // Mobs will eat anyone that decides to drop/slip into them by default.
	M.escape_attempt_messages_prey = "You start to kick away from %pred's grasp!"
	M.escape_messages_outside = "%prey manages to escape %pred's clutches!"
	M.escape_messages_prey = "You managed to get away from %pred's grasp!"
	M.escape_fail_messages_prey = "You managed to slip up, getting further trapped!"
	M.autotransferable = 1
	M.autotransferlocation = "throat"
	M.autotransferwait = 300
	M.autotransferchance = 100
	M.autotransfer_min_amount = 1
	M.autotransfer_whitelist = 53
	M.autotransfer_enabled = 1
	M.belly_fullscreen = "vbo_maw14"
	M.belly_fullscreen_color = "#823232"
	M.belly_fullscreen_color2 = "#823232"

	var/obj/belly/T = new /obj/belly(src)
	T.immutable = TRUE
	T.can_taste = TRUE
	T.name = vore_stomach_name ? vore_stomach_name : "throat"
	T.desc = vore_stomach_flavor ? vore_stomach_flavor : "You can hear the tiny thing outside struggling to keep you contained.  Each noisome slurp drags their tongue further down your face, smearing you in spit and matting against your scalp.   As the muscles of their throat catch your head, and eventually your neck. </br></br>GHlLRK.  GLmp… glnrk…   Strained, repetitive swallows work over your form as your head… and steadily the rest of you become nothing but a prominent BULGE on the gobbie's neck.  Teeth scrape back across your skin, leaving dull puffy scratches.  You're sunk into ever-deeper tunnels of tightened flesh as gravity steadily reverses on you. </br></br>The tightness of that throat leaves the smug beast's claws free to slide up your body, grabbing still your kicking thighs and legs just to use the new grip to cram you in deeper.  You're half submerged in the overly tight tunnel of the short beast's esophagus, helpless but to feel it's tongue coil up your legs and taste the salt of your skin."
	T.digest_mode = vore_default_mode
	T.mode_flags = vore_default_flags
	T.item_digest_mode = vore_default_item_mode
	T.contaminates = vore_default_contaminates
	T.contamination_flavor = vore_default_contamination_flavor
	T.contamination_color = vore_default_contamination_color
	T.escapable = vore_escape_chance > 0
	T.escapechance = 10
	T.escapechance_absorbed = vore_escape_chance_absorbed
	T.digestchance = 0
	T.absorbchance = 0
	T.human_prey_swallow_time = swallowTime
	T.nonhuman_prey_swallow_time = swallowTime
	T.digest_brute = 0
	T.digest_burn = 0
	T.digest_mode = "Hold"
	T.vore_verb = "swallow"
	T.examine_messages = list(
		"%pred has %prey's head stuck in their mouth!",
		"Drool oozes down %prey's frame as they're crudely tasted with their struggling frame shoved ever deeper…")
	T.emote_lists[DM_HOLD] = list(
		"The insides knead at you gently for a moment.",
		"The guts glorp wetly around you as some air shifts.",
		"The predator takes a deep breath and sighs, shifting you somewhat.",
		"The stomach squeezes you tight for a moment, then relaxes harmlessly.",
		"The predator's calm breathing and thumping heartbeat pulses around you.",
		"The warm walls kneads harmlessly against you.",
		"The liquids churn around you, though there doesn't seem to be much effect.",
		"The sound of bodily movements drown out everything for a moment.",
		"The predator's movements gently force you into a different position.")
	T.emote_lists[DM_DIGEST] = list(
		"The burning acids eat away at your form.",
		"The muscular stomach flesh grinds harshly against you.",
		"The caustic air stings your chest when you try to breathe.",
		"The slimy guts squeeze inward to help the digestive juices soften you up.",
		"The onslaught against your body doesn't seem to be letting up; you're food now.",
		"The predator's body ripples and crushes against you as digestive enzymes pull you apart.",
		"The juices pooling beneath you sizzle against your sore skin.",
		"The churning walls slowly pulverize you into meaty nutrients.",
		"The stomach glorps and gurgles as it tries to work you into slop.")
	can_be_drop_pred = TRUE // Mobs will eat anyone that decides to drop/slip into them by default.
	T.escape_attempt_messages_prey = "You start to climb up %pred's greedy throat!"
	T.escape_messages_outside = "%prey manages to slide out from the now pissed off predator."
	T.escape_messages_prey = "You managed to slide out from %pred's greedy throat"
	T.escape_fail_messages_prey = "%pred stifles your escape attempt with another greedy swallow."
	T.autotransferable = 1
	T.autotransferlocation = "stomach"
	T.autotransferwait = 300
	T.autotransferchance = 100
	T.autotransfer_min_amount = 1
	T.autotransfer_whitelist = 53
	T.autotransfer_enabled = 1
	T.belly_fullscreen = "vboanim_belly1"
	T.belly_fullscreen_color = "#823232"
	T.belly_fullscreen_color2 = "#823232"

	var/obj/belly/B = new /obj/belly(src)
	B.immutable = TRUE
	B.can_taste = TRUE
	B.name = vore_stomach_name ? vore_stomach_name : "stomach"
	B.desc = vore_stomach_flavor ? vore_stomach_flavor : "Finally, you're deposited in a stinking, fetid bog of a stomach.   Your face is humiliatingly squeezed through a sphincter at the very end before being MASHED against its deepest pit.  A slop of acids and the goblin's previous meals slosh as your face parts the goop… and then the rest of you is forced to curl to fill what little space you have. </br></br>In a smooth slurp, the rest of your body falls down their throat and into a rounded, wobbling bulge on the greenskin's midriff.  Fabric RIPS on the outside as they struggle to even stand with you weighing them down.  You can hear a few strained breaths, a hiccup- and then a ragged BELCH that causes the whole chamber to rumble around you. </br></br>BwhhhhHHHRRRP. </br></br>It tightens and robs you of your air as you're left to contemplate how you even FIT in here.   It's vice-tight and sweltering, and the disgusting pit forces you to twist, turn, and roll within the creechur as your outline is perfectly visible from the outside.   You can even feel the thing wetly drool atop the rounded orb.   Its claws dig into the underside of your heft, weighing just how much MEAL it took in. </br></br>Glrp.  Glllrgl."
	B.digest_mode = vore_default_mode
	B.mode_flags = vore_default_flags
	B.item_digest_mode = vore_default_item_mode
	B.contaminates = vore_default_contaminates
	B.contamination_flavor = vore_default_contamination_flavor
	B.contamination_color = vore_default_contamination_color
	B.escapable = vore_escape_chance > 0
	B.escapechance_absorbed = vore_escape_chance_absorbed
	B.digestchance = vore_digest_chance
	B.absorbchance = vore_absorb_chance
	B.human_prey_swallow_time = swallowTime
	B.nonhuman_prey_swallow_time = swallowTime
	B.vore_verb = "swallow"
	B.digest_brute = 0.5
	B.digest_burn = 0.5
	B.emote_lists[DM_HOLD] = list( // We need more that aren't repetitive. I suck at endo. -Ace
		"The insides knead at you gently for a moment.",
		"The guts glorp wetly around you as some air shifts.",
		"The predator takes a deep breath and sighs, shifting you somewhat.",
		"The stomach squeezes you tight for a moment, then relaxes harmlessly.",
		"The predator's calm breathing and thumping heartbeat pulses around you.",
		"The warm walls kneads harmlessly against you.",
		"The liquids churn around you, though there doesn't seem to be much effect.",
		"The sound of bodily movements drown out everything for a moment.",
		"The predator's movements gently force you into a different position.")
	B.emote_lists[DM_DIGEST] = list(
		"The burning acids eat away at your form.",
		"The muscular stomach flesh grinds harshly against you.",
		"The caustic air stings your chest when you try to breathe.",
		"The slimy guts squeeze inward to help the digestive juices soften you up.",
		"The onslaught against your body doesn't seem to be letting up; you're food now.",
		"The predator's body ripples and crushes against you as digestive enzymes pull you apart.",
		"The juices pooling beneath you sizzle against your sore skin.",
		"The churning walls slowly pulverize you into meaty nutrients.",
		"The stomach glorps and gurgles as it tries to work you into slop.")
	can_be_drop_pred = TRUE // Mobs will eat anyone that decides to drop/slip into them by default.
	B.escape_attempt_messages_prey = "You begin to attack %pred's taught stomach effectively!"
	B.escape_messages_outside = "%pred lurches over, horking up %prey. Ugh..."
	B.escape_messages_prey = "A sudden reflex, and you manage to make %pred cough you up. Slimy, but alive!"
	B.escape_fail_messages_prey = "%pred's stomach clenches down hard, preventing your escape."
	B.escapechance = 5
	B.belly_fullscreen = "vbo_belly5"
	B.belly_fullscreen_color = "#823232"
	B.belly_fullscreen_color2 = "#823232"
//--------------------------------------------------------------------------
//Credit to Syribirb for doing the entirety of the belly descriptions!
/mob/living/proc/load_generic_bellies()
	//Loading genderless catchall bellies
	var/obj/belly/M = new /obj/belly(src)
	vore_selected = M
	M.immutable = TRUE
	M.can_taste = TRUE
	M.name = vore_stomach_name ? vore_stomach_name : "maw"
	M.desc = vore_stomach_flavor ? vore_stomach_flavor : "You're forcefully picked from the ground and lifted up to face your assailant. Their hands grip at your arms, holding them to your sides and restraining you. Your body is sore from fighting, you have a hard time breaking free of them. You're tugged in against their chest, the heat of their post-battle state settling into yours. You can hear their breath heave, their body taking a moment to rest as they look you over. There's a chuckle from up above, and when you finally look up to face them, there's a predatory look in %pred's eye. </br></br> They <b>heft</b> you a second time, lifting you up to their face as their lips part. A molten tongue slips up your cheek, leaving a wet trail of slobber across your face.   They make an appreciative little hum as their eyes flutter down at you.   Apparently you're delicious.  Their breath breaks against your face in warm billows. Their lips part, and you finally get a flash of their pulsing, dripping throat.</br></br>That's the last thing you see before you're smothered against their tongue. Teeth scrape against your scalp as their lips come around your neck. The wet muscle glides across your face as they <b>taste</b> you.  Breath billows around your body, drool oozes down your chest... It's easy to see where this is going."
	M.digest_mode = vore_default_mode
	M.mode_flags = vore_default_flags
	M.item_digest_mode = vore_default_item_mode
	M.contaminates = vore_default_contaminates
	M.contamination_flavor = vore_default_contamination_flavor
	M.contamination_color = vore_default_contamination_color
	M.escapable = vore_escape_chance > 0
	M.escapechance_absorbed = vore_escape_chance_absorbed
	M.digestchance = 0
	M.absorbchance = 0
	M.human_prey_swallow_time = swallowTime
	M.nonhuman_prey_swallow_time = swallowTime
	M.digest_brute = 0
	M.digest_burn = 0
	M.digest_mode = "Hold"
	M.vore_verb = "swallow"
	M.examine_messages = list(
		"%pred is currently lapping against %prey's face!  Threatening to swallow them down at any moment…")
	M.emote_lists[DM_HOLD] = list(
		"You're adjusted in that maw for a few moments, before you finally get another glimpse of daylight!  Of course, those lips slurp you back in within an instant as you struggle for air.",
		"%pred's tongue passes over your face, coating you in thick slobber as the rest of their maw clings tightly to your head.   Wet half-swallows prepare you for the upcoming plunge…",
		"%pred lets out a wet slurp around your neck, their hands wandering your body as they try to get a better handhold to shove you in!",
		"A groan emanates from %pred's midriff as you struggle against them.  You can feel it rumble against you, their body anticipating a meal.")
	M.struggle_messages_inside = list(
		"You struggle against %pred's grip!  Your body squirms against their grasp as their warm frame rubs up against you.",
		"Your resistance only pushes your face harder against %pred's molten tongue.  You can feel their throat pulse against your scalp… <i>schlrp</i>",
		"Slobber oozes down your chest as you resist %pred's attempt to shove you in deeper.  Their warm breath heaves across your face and neck, strained with the effort of trying to restrain you.",
		"You rail against %pred's greedy swallows, trying your hardest not to get sucked down their throat!",
		"Your arms push out against the tight grip holding them to your sides, and you try to kick your way free of your binds!   You can feel that mouth tighten, trying its best to swallow you down as you resist."
	)
	can_be_drop_pred = TRUE // Mobs will eat anyone that decides to drop/slip into them by default.
	M.escape_attempt_messages_prey = "You start to kick away from %pred's grasp!"
	M.escape_messages_outside = "%prey manages to escape %pred's clutches!"
	M.escape_messages_prey = "You managed to get away from %pred's grasp!"
	M.escape_fail_messages_prey = "You managed to slip up, getting further trapped!"
	M.escapechance = 25
	M.autotransferable = 1
	M.autotransferlocation = "throat"
	M.autotransferwait = 300
	M.autotransferchance = 100
	M.autotransfer_min_amount = 1
	M.autotransfer_whitelist = 53
	M.autotransfer_enabled = 1
	M.belly_fullscreen = "vbo_maw14"
	M.belly_fullscreen_color = "#823232"
	M.belly_fullscreen_color2 = "#823232"

	var/obj/belly/T = new /obj/belly(src)
	T.immutable = TRUE
	T.can_taste = TRUE
	T.name = vore_stomach_name ? vore_stomach_name : "throat"
	T.desc = vore_stomach_flavor ? vore_stomach_flavor : "They finally lift up your body and toss you back into their throat. Wet walls grip at you from every angle as you slide back down that wet, pulsing tunnel. Molten heat surges from the walls around you and into your body, and you're coated in the thick grool of their internal fluids.</br></br>From every angle all you can hear is messy gulps, slurps, and swallows. Muscles grinding in an attempt to pack away a meal they can hardly handle. You are a bulge, writhing as you pass down %pred's throat.</br></br>It won't be long now, you hear another anticipatory groan from beneath as you're pulled ever deeper into %pred.  Your legs are pulled up over their head as gravity fully reverses.You feel hands claw and grip at your hips, shoving you down yet further…"
	T.digest_mode = vore_default_mode
	T.mode_flags = vore_default_flags
	T.item_digest_mode = vore_default_item_mode
	T.contaminates = vore_default_contaminates
	T.contamination_flavor = vore_default_contamination_flavor
	T.contamination_color = vore_default_contamination_color
	T.escapable = vore_escape_chance > 0
	T.escapechance_absorbed = vore_escape_chance_absorbed
	T.digestchance = 0
	T.absorbchance = 0
	T.human_prey_swallow_time = swallowTime
	T.nonhuman_prey_swallow_time = swallowTime
	T.digest_brute = 0
	T.digest_burn = 0
	T.digest_mode = "Hold"
	T.vore_verb = "swallow"
	T.examine_messages = list(
		"%pred has %prey halfway shoved into their maw! The lower half of their body writhes and shifts against their grip, but their upper half is already nothing but a bulge.")
	T.emote_lists[DM_HOLD] = list( // We need more that aren't repetitive. I suck at endo. -Ace
		"You hear %pred's heartbeat through the pulsing walls that hold you.  Their tongue crawls down your midriff as you feel yourself sinking deeper.",
		"A thick swallow splits the air, another pulse wrings your entire body as you're slowly consumed.",
		"Hands slide down your lower body, gripping into your hips and ass for a better hold to shove you deeper.",
		"Another gulp.   Every push further into their throat sends a bounce through your entire frame.",
		"Your body is compressed by another push deeper, the thick grool of %pred's throat oozing into every inch of your clothing as teeth scrape up your frame.")
	can_be_drop_pred = TRUE // Mobs will eat anyone that decides to drop/slip into them by default.
	T.struggle_messages_inside = list(
		"You push back against %pred's throat, but your arms are pinned to your sides.  It's all you can do to attempt to shift your lower body in a way that's slightly less convenient for them to swallow.",
		"You thrash against the squeezing throat muscles, your hips bouncing against the warm, wet jaws that slide up your body.",
		"You kick against %pred's entrenched hands, but their nails just dig deep into your thighs.  You find yourself hard pressed to break their grip as they shove you in more firmly.",
		"A wet groan comes from the grinding muscles around you as you try to slip your way back out of that throat.   You have to buck against the grip on your hips, your arms struggling against wet, slick muscles.",
		"Your back arches as you attempt to wriggle your way up out of the clenching throat that surrounds you.  The effort makes your face press up against the clenching esophagus all the more, smearing you in %pred's fluids."
	)
	T.struggle_messages_outside = list(
		"%prey kicks against %pred's grip on their legs!  The bulge inside that throat shifts faintly…",
		"%prey arches their back, thrashing against the bulging throat holding them!  You can see their face in a perfect outline.",
		"%prey wriggles against the tight throat that holds them.  A wet <b>GLRNK</b> marks a stark descent and a bounce that ripples through their frame as they're lowered just a few inches deeper."
	)
	T.autotransferable = 1
	T.autotransferlocation = "stomach"
	T.autotransferwait = 300
	T.autotransferchance = 100
	T.autotransfer_min_amount = 1
	T.autotransfer_whitelist = 53
	T.autotransfer_enabled = 1
	T.escape_attempt_messages_prey = "You start to climb up %pred's greedy throat!"
	T.escape_messages_outside = "%prey manages to slide out from the now pissed off predator."
	T.escape_messages_prey = "You managed to slide out from %pred's greedy throat"
	T.escape_fail_messages_prey = "%pred stifles your escape attempt with another greedy swallow."
	T.escapechance = 10
	T.belly_fullscreen = "vboanim_belly1"
	T.belly_fullscreen_color = "#823232"
	T.belly_fullscreen_color2 = "#823232"

	var/obj/belly/B = new /obj/belly(src)
	B.immutable = TRUE
	B.can_taste = TRUE
	B.name = vore_stomach_name ? vore_stomach_name : "stomach"
	B.desc = vore_stomach_flavor ? vore_stomach_flavor : "<b>SCHLRP...ghlp... BHHHRRRRRRRP!!!</b></br></br>Your body is finally dropped through the rest of %pred's throat as you sliiide down their esophagus and into the pit of their gut. Face-first, you're smooshed into a thick grool comprising of all of their previous meals and a warm acrid fluid.</br></br>A hand braces your fall from beneath, you can feel it through the tight grip of the stomach that surrounds you.  It helps push the underside of that gut smothering against your face.  Your body is forced to curl in on itself by the gripping muscles. The atmosphere here is tainted with the smell of digestion, it creeps into your every breath.</br></br>By no force other than the tightness of the chamber that grips you, you finally manage to right yourself, feeling the sheer wobbly <b>bloat</b> you've forced upon the predator outside. The muscles that surround you churn, groan, and strain as they try their best to keep you contained. Your outline is nothing but a pretty decoration on %pred's midriff..."
	B.digest_mode = vore_default_mode
	B.mode_flags = vore_default_flags
	B.item_digest_mode = vore_default_item_mode
	B.contaminates = vore_default_contaminates
	B.contamination_flavor = vore_default_contamination_flavor
	B.contamination_color = vore_default_contamination_color
	B.escapable = vore_escape_chance > 0
	B.escapechance_absorbed = vore_escape_chance_absorbed
	B.digestchance = vore_digest_chance
	B.absorbchance = vore_absorb_chance
	B.human_prey_swallow_time = swallowTime
	B.nonhuman_prey_swallow_time = swallowTime
	B.vore_verb = "swallow"
	B.examine_messages = "%pred is bloated with some wriggling meal. Their stomach stretches over a bouncing, thick bulge, ripping through their clothing. Whoever it is occasionally shifts, pushing against the audibly straining, groaning muscles. They're still alive in there…"
	B.digest_brute = 0.5
	B.digest_burn = 0.5
	B.escape_attempt_messages_prey = "You begin to attack %pred's taught stomach effectively!"
	B.escape_messages_outside = "%pred lurches over, horking up %prey. Ugh..."
	B.escape_messages_prey = "A sudden reflex, and you manage to make %pred cough you up. Slimy, but alive!"
	B.escape_fail_messages_prey = "%pred's stomach clenches down hard, preventing your escape."
	B.escapechance = 5
	B.emote_lists[DM_DIGEST] = list(
		"You feel a hand pass over your frame from outside, then <b>SQUISH</b> you in against %pred's midriff.  It forces an idle belch up out of their lips…",
		"The noises of indigestion ripple from all around you as %pred's body struggles to take in such a massive meal. Each vibration of muscle straining against muscle ripples the entire chamber in wet <b>grrrrgls</b>.",
		"The stomach that surrounds you randomly clenches, forcing the acids up your body. You're drenched in %pred's internal fluids as you try to keep yourself righted.",
		"%pred simply goes about their day outside, each step sending a ripple through the thick, bloated gut that you occupy.",
		"You can hear %pred's heartbeat faintly through the walls, as well as their breath. There's a little delicate hitch in their breathing as a clench rolls through their middle.",
		"A vibration splits the air with a wet <b>glrbl</b> as that whole gut shifts you once again with a forceful clench.")
	can_be_drop_pred = TRUE // Mobs will eat anyone that decides to drop/slip into them by default.
	B.struggle_messages_inside = list(
		"You kick against the clenching walls that surround you, only to be greeted by yet more digestive noises.",
		"Your thrashing splashes the thick slop that surrounds you, forcing %pred's gut to slosh and wobble atop their midriff.",
		"You push your arms out against the tight stomach walls. You're greeted by another muscular clench, forcing them back in and threatening to flip you.",
		"As you wriggle and thrash against the tight stomach walls, your face is crammed up against them. You're smeared in thick digestive juices as you inadvertently smother yourself in those molten innards.",
		"A few struggles cause that gut to bounce, and a resulting clench causes gravity to reverse. Your face is squished against the pit of that stomach, and deprived of air you have to wriggle desperately to right yourself."
	)
	B.struggle_messages_outside = list(
		"%pred's bloated gut bounces with the shifting meal inside.",
		"You can see hands push out from within %pred's gut, before a liquid glorp and a clench shoves them back in.",
		"A rumble passes through %pred's fattened middle, the round of it wobbling with struggling prey.",
		"A thick bulge squirms inside the bloat of %pred's gut, and a clench forces out a muffled belch as the outline of some poor preything is briefly made visible."
	)
	B.belly_fullscreen = "vbo_belly5"
	B.belly_fullscreen_color = "#823232"
	B.belly_fullscreen_color2 = "#823232"
//--------------------------------------------------------------------------
//Credit to Syribirb for doing the entirety of the belly descriptions!
/mob/living/proc/load_lamia_bellies()
	//Loading genderless catchall bellies
	var/obj/belly/M = new /obj/belly(src)
	vore_selected = M
	M.immutable = TRUE
	M.can_taste = TRUE
	M.name = vore_stomach_name ? vore_stomach_name : "maw"
	M.desc = vore_stomach_flavor ? vore_stomach_flavor : "Smooth scales cling to your legs.   Before you know it, you’re dragged into waiting, warm coils.  The girth of %pred’s tail climbs up your body, and they look down at you with a pleased gleam in their eye. Hands gently hug you within those waiting binds, and you’re left to merely struggle as they lazily use their lower body to overpower you</br></br>Hair drapes across your chest, and their grin only gets more pleased as they rest their head there for just a few moments.<b>Glrg…rrgl…</b>There’s a thick groan from their midriff, they’re hungry- but first things first they need to hear your heartbeat… your fear.   You can see their soft lips part in a too-white, fanged grin from below you.  </br></br>You can hardly move, your arms squirm against too-smooth scales as the constriction is nearly crushing.  Still though, the rest of their body is afforded that lazy attitude.  You can feel their tailtip </br></br>Warm, gooey tongue oozes up your chest, leaving a slimy trail of spit until they pass your jaw an push up your cheek. “Delicioussss… morsssel.”  The naga giggles, their lashes fluttering as they pepper a kiss along the opposite side of your face. Up, up. They’re teasing you.</br></br>Their lips rest on your ear, gently nibbling at the lobe as their warm breath washes over your head. A playful little bite before you hear their wet maw expand… ‘schlp.’ Their jaw unnaturally unhinges, and you’re overtaken in their lips as the flesh of it is the last thing you see. Fangs scrape across your scalp as drool oozes across your face and down your neck.</br></br><b>Schlrp.</b>"
	M.digest_mode = vore_default_mode
	M.mode_flags = vore_default_flags
	M.item_digest_mode = vore_default_item_mode
	M.contaminates = vore_default_contaminates
	M.contamination_flavor = vore_default_contamination_flavor
	M.contamination_color = vore_default_contamination_color
	M.escapable = vore_escape_chance > 0
	M.escapechance_absorbed = vore_escape_chance_absorbed
	M.digestchance = 0
	M.absorbchance = 0
	M.human_prey_swallow_time = swallowTime
	M.nonhuman_prey_swallow_time = swallowTime
	M.digest_brute = 0
	M.digest_burn = 0
	M.digest_mode = "Hold"
	M.vore_verb = "swallow"
	M.examine_messages = list(
		"%pred is currently pushing their mouth over %prey’s face! They’re wrapped tightly in thick coils as the snake’s lithe body smothers them. The naga’s jaw is unhinging as fangs scrape across their victim’s head… it seems they’re meant to be food soon enough.")
	M.emote_lists[DM_HOLD] = list(
		"Coils swim around your every inch, catching your arms every time they come loose, clenching around the soft parts of your body as if feeling and appraising you.",
		"A curious tailtip works across your thighs, gently teasing across sensitive skin as you’re shoved into %pred’s waiting mouth.",
		"Drool oozes down your chest as the jaw surrounding your head unhinges all the more.  Fangs slide across your skin as you’re shoved deeper by the effort of %pred’s lower body.",
		"Hands dance across your skin, gently feeling your musculature and soft areas both as the naga takes in the delectable prey they managed to capture.   Their upper body embraces you lazily, free to let their tail do all the work.")
	M.struggle_messages_inside = list(
		"Thick coils keep you pinned as you writhe to get any solace from the constriction.   Their tailtip darts across your thigh, teasingly re-coiling your leg as their tail swims about your frame.",
		"You thrash against %pred, but they hardly put any effort into using their upper body to keep you restrained.  The coils do all the work as they simply reach a delicate hand down your midriff and giggle around your head.",
		"You stretch in those coils in an attempt to slip their grip, but all that you manage to do is shove your face deep into that waiting maw.  %pred’s tongue smothers your entire face as you’re washed in their warm breath.",
		"You push out against the winding tail that holds you still, but %pred just bites on your head in response.  Twin fangs scrape against the back of your head, and the pulsing of the throat ahead of you is a grim foreshadowing of your fate…",
		"A thick <b>GLRNK</b> sounds as their throat muscles try to catch you, but your tossing makes it difficult.  Pushing out against the smooth scales around you, you claw for any way to resist the lithe creature atop you.",
		"As you recklessly thrash against %pred, their drool oozes down your chest messily.  You’re making swallowing hard, so their tongue simply sets its molten girth to tasting you until you calm within the squeezing of their coils.",
		"You’re able to push their head off of you!  Their delicate features flutter lashes back at you curiously, drool oozing down their chin.   Their face is faintly flushed, and when they open their mouth again, you can see the pulse of a throat before they try to plunge you straight back in. <b>Schlrp…</b>"
	)
	M.struggle_messages_outside = list(
		"%Prey thrashes against %pred’s tight coils!  There’s a muffled squeal from inside the naga’s mouth as their head gets slowly shoved deeper.",
		"%Prey writhes against the thick snake-like lower body holding them tight.  Despite their thrashings, %pred seems keen on holding them tight inside their mouth.",
		"%Pred rests gingerly atop %prey as they rail and thrash against the thick, warm coils surrounding them.  They hardly put any upper-body effort into keeping them restrained."
	)
	can_be_drop_pred = TRUE // Mobs will eat anyone that decides to drop/slip into them by default.
	M.escape_attempt_messages_prey = "You start to kick away from %pred's grasp!"
	M.escape_messages_outside = "%prey manages to escape %pred's clutches!"
	M.escape_messages_prey = "You managed to get away from %pred's grasp!"
	M.escape_fail_messages_prey = "You managed to slip up, getting further trapped!"
	M.escapechance = 25
	M.autotransferable = 1
	M.autotransferlocation = "throat"
	M.autotransferwait = 300
	M.autotransferchance = 100
	M.autotransfer_min_amount = 1
	M.autotransfer_whitelist = 53
	M.autotransfer_enabled = 1
	M.belly_fullscreen = "vbo_maw14"
	M.belly_fullscreen_color = "#823232"
	M.belly_fullscreen_color2 = "#823232"

	var/obj/belly/T = new /obj/belly(src)
	T.immutable = TRUE
	T.can_taste = TRUE
	T.name = vore_stomach_name ? vore_stomach_name : "throat"
	T.desc = vore_stomach_flavor ? vore_stomach_flavor : "<b>TSCHLr-Ghk… glrk…</b></br></br>Your frame travels down the naga’s throat in a thick bulge. Your body noisily works its way down their surprisingly accommodating throat. Drool oozes into your every inch as slowly but steadily their hands glide down your body. A sighed breath washes across your frame, warm and humid as they’re finally content they have you restrained. As you’re steadily slid deeper your world becomes nothing but noisy, grinding muscles ushering you forward and wet walls smothering your face.</br></br>You can still feel their coils all across your lower body, their back arching as they lift you against gravity. Their tailtip <b>THAPS</b> your behind as they giggle, still more than happy to play with you as they simply slide you down. Every writhe and struggle you make like this, suspended, is perfectly set to be a feast for their eyes. Your body bounces with each swallow deeper.</br></br>Your face is crammed against a tight sphincter leading to their stomach, your legs still vainly attempting to kick outside. It’s hard with the exertion of battle, every sore spot you have is being lovingly caressed by the naga’s insides as your muscles scream for relaxation…"
	T.digest_mode = vore_default_mode
	T.mode_flags = vore_default_flags
	T.item_digest_mode = vore_default_item_mode
	T.contaminates = vore_default_contaminates
	T.contamination_flavor = vore_default_contamination_flavor
	T.contamination_color = vore_default_contamination_color
	T.escapable = vore_escape_chance > 0
	T.escapechance_absorbed = vore_escape_chance_absorbed
	T.digestchance = 0
	T.absorbchance = 0
	T.human_prey_swallow_time = swallowTime
	T.nonhuman_prey_swallow_time = swallowTime
	T.digest_brute = 0
	T.digest_burn = 0
	T.digest_mode = "Hold"
	T.vore_verb = "swallow"
	T.examine_messages = list(
		"%pred has %prey halfway shoved down their throat! Their lower body kicks and writhes as their back arches, trying to break free of the tight coils! A thick bulge is visible on the naga’s neck, clearly showing their struggling outline..")
	T.emote_lists[DM_HOLD] = list( // We need more that aren't repetitive. I suck at endo. -Ace
		"A thick pulse of muscle travels over your body, pulling you deeper towards the naga’s stomach.",
		"Wet drool oozes into your every inch, you can feel the snake’s tongue coil against you just as much as its tail.  It tries its best to drag you in too.",
		"A hitched sigh oozes up around your lower body, their breath hot against your hips as you slide deeper.",
		"The naga locks their teeth around your hips to suckle across your frame, tasting you as you slide down.")
	can_be_drop_pred = TRUE // Mobs will eat anyone that decides to drop/slip into them by default.
	T.struggle_messages_inside = list(
		"You push against the noisily swallowing muscles of their throat, earning a <b>GLRT</b> from the hardworking walls.",
		"The bulge you make in %pred’s throat swells as your body writhes, but the most you can do is inadvertently smother your face in their internal slime.",
		"You kick and thrash against %pred’s coils on your lower body!   They tighten in response, gleefully squeezing your hips to get you under control.",
		"You arch your back and push your legs against the tight coils outside, only to have %pred’s claws firmly SMACK and grip your behind.   They use it like a handhold to try to shove you deeper.",
		"Your hips swing against %pred’s jaws, only to have their tongue slide around them, coiling to tug you deeper.",
		"Your hips push and jump against the tightening grip across your lower body, only to have their tailtip disarmingly sliide between your legs.  It grips your thighs once again, preceding a new tightening of their coils."
	)
	T.struggle_messages_outside = list(
		"%prey pushes against the tight coils as they’re flipped upside-down and shoved into %pred’s throat!",
		"The wriggling bulge that is %prey pushes out from the naga’s throat, you can see their outline shift within.",
		"%prey’s legs kick against the coils holding them aloft!  You hear another messy, slobbery swallow from the naga below as they try to contain them."
	)
	T.autotransferable = 1
	T.autotransferlocation = "stomach"
	T.autotransferwait = 300
	T.autotransferchance = 100
	T.autotransfer_min_amount = 1
	T.autotransfer_whitelist = 53
	T.autotransfer_enabled = 1
	T.escape_attempt_messages_prey = "You start to climb up %pred's greedy throat!"
	T.escape_messages_outside = "%prey manages to slide out from the now pissed off predator."
	T.escape_messages_prey = "You managed to slide out from %pred's greedy throat"
	T.escape_fail_messages_prey = "%pred stifles your escape attempt with another greedy swallow."
	T.escapechance = 10
	T.belly_fullscreen = "vboanim_belly1"
	T.belly_fullscreen_color = "#823232"
	T.belly_fullscreen_color2 = "#823232"

	var/obj/belly/B = new /obj/belly(src)
	B.immutable = TRUE
	B.can_taste = TRUE
	B.name = vore_stomach_name ? vore_stomach_name : "stomach"
	B.desc = vore_stomach_flavor ? vore_stomach_flavor : "You’re finally dropped from %pred’s coils, only for their mouth to snap up your hips.  Its warmth overtakes them, and soon enough the rest of your body is sliding down their squeezing throat with just the help of gravity.</br></br>The thick bulge you’ve created begins to disappear past their collarbone and bloat their midriff as you’re deposited inside a clinging, tight stomach.  The air is tainted with the smell of gall and the acrid waftings from some grinding, glorping chamber below.</br></br>Your face is crammed into the lower half of that chamber, immersed in a thick, warm, viscous solution.  It doesn’t tingle or even burn, it simply soaks your every inch… you feel a <b>SMACK</b> against your frame from the outside as the naga takes in your form with a kind of pleasure.</br></br>The whole chamber squeezes you tight, bubbling the excess air up %pred’s throat in a liquidy <b>bwhhHHRRP!!!</b>.  You’re left to simply stew as the every winding motion of the pred outside causes the bulge you make to wobble to and fro atop their hips.  Your frame is forced to curl to accommodate the new tightness, and eventually you can finally right yourself as you’re prepared for the looong gut inside their tail…"
	B.digest_mode = vore_default_mode
	B.mode_flags = vore_default_flags
	B.item_digest_mode = vore_default_item_mode
	B.contaminates = vore_default_contaminates
	B.contamination_flavor = vore_default_contamination_flavor
	B.contamination_color = vore_default_contamination_color
	B.escapable = vore_escape_chance > 0
	B.escapechance_absorbed = vore_escape_chance_absorbed
	B.digestchance = vore_digest_chance
	B.absorbchance = vore_absorb_chance
	B.human_prey_swallow_time = swallowTime
	B.nonhuman_prey_swallow_time = swallowTime
	B.vore_verb = "swallow"
	B.examine_messages = "%pred has a grotesquely bloated midriff!  It glorps and churns over some poor unfortunate, their outline quite clear beneath the half-snake’s skin."
	B.digest_brute = 0
	B.digest_burn = 0
	B.autotransferable = 1
	B.autotransferlocation = "tail"
	B.autotransferwait = 300
	B.autotransferchance = 100
	B.autotransfer_min_amount = 1
	B.autotransfer_whitelist = 53
	B.autotransfer_enabled = 1
	B.escape_attempt_messages_prey = "You begin to attack %pred's taught stomach effectively!"
	B.escape_messages_outside = "%pred lurches over, horking up %prey. Ugh..."
	B.escape_messages_prey = "A sudden reflex, and you manage to make %pred cough you up. Slimy, but alive!"
	B.escape_fail_messages_prey = "%pred's stomach clenches down hard, preventing your escape."
	B.escapechance = 5
	B.emote_lists[DM_HOLD] = list(
		"The guts around you steadily pulse, washing new, bubbling fluids across your entire body.",
		"A clench pushes more of that slop up to your neck, making sure you’re properly softened and lubricated for the winding guts below.",
		"A liquid gurgle emanates from a chamber beneath you.  That looong tailgut awaits, preparing itself to break you down.",
		"%pred simply goes about their day outside, each step sending a ripple through the thick, bloated gut that you occupy.",
		"You can hear %pred's heartbeat faintly through the walls, as well as their breath. There's a little delicate hitch in their breathing as a clench rolls through their middle.",
		"A hand passes over the bulge you make in %pred’s midriff from the outside, giving you a grope from beneath.")
	can_be_drop_pred = TRUE // Mobs will eat anyone that decides to drop/slip into them by default.
	B.struggle_messages_inside = list(
		"You kick against the tightening, wringing walls inside %pred!   A liquid <b>glrt</b> and a clench of those muscles bring you right back into line.",
		"You let out muffled squeals as you try to break free of the guts that surround you!  They cling tightly, sticking to your face and drowning you in thick, viscous goo.",
		"You arch your back, pushing out your arms to try to resist the slow churning of %pred’s midriff, but you’re just smothering yourself in their walls.",
		"As you thrash inside that gut, you make it slosh atop %pred’s hips.   You can feel a new vibration ring through the whole chamber as they let out a pleased sigh.",
		"You try to resist the slow churn of those muscles, pushing out against them, but you feel a hand on the outside cram itself against your outline to still you.   The whole chamber clenches, and another belch bubbles up the Naga’s throat…"
	)
	B.struggle_messages_outside = list(
		"%pred’s midriff wobbles with a shifting prey, their outline pushing a hand out of the smooth skin of their gut.",
		"%pred stifles a belch as their fat stomach jumps with motion from within.  There’s a faint squeal from beneath their skin.",
		"%pred’s gut lets out a worrying <b>GLRT</b> as it clenches over some poor unfortunate.  You can see their outline struggling to break free."
	)
	B.belly_fullscreen = "vbo_belly5"
	B.belly_fullscreen_color = "#823232"
	B.belly_fullscreen_color2 = "#823232"

	var/obj/belly/TL = new /obj/belly(src)
	TL.immutable = TRUE
	TL.can_taste = TRUE
	TL.name = vore_stomach_name ? vore_stomach_name : "tail"
	TL.desc = vore_stomach_flavor ? vore_stomach_flavor : "That gut finally begins to wobble side to side as you feel another sphincter open beneath you.  It eventually catches your legs, allowing them space to straighten out.  Even if you resist now, you’d only be shoving yourself through the slick passage.   The muscles tighten, catch and <b>pull.</b>  You find yourself sinking deeper into %pred’s guts than you thought possible as their midriff finally shrinks away, transferring the bulge of your frame into their long, winding tail.</br></br><b>Glrp… glrrglrg…slrsh.</b></br></br>It’s devilishly tight across your entire body, and you’re immediately coated in a thicker, tingling slime as your pre-lubed frame obediently sliiiides past %pred’s hip-bones.  They let out a pleased sigh as your weight passes their organs, bullying them out of the way.    A shudder runs through their hips, a slow rolling and bucking helping your passage until you’re finally completely immersed in their tail.</br></br>It’s a slow process as a slimy grool of digestive fluids and previous meals smeared across the seemingly endless walls is wrung into your body with every slow, deliberate inch you’re passed deeper.  The walls push in tightly against you.  Up and down are no longer a constant as your body is straightened out.   Whenever you’re face down, you feel the ground drag beneath you with the snake’s every motion, smothering your face against the walls."
	TL.digest_mode = vore_default_mode
	TL.mode_flags = vore_default_flags
	TL.item_digest_mode = vore_default_item_mode
	TL.contaminates = vore_default_contaminates
	TL.contamination_flavor = vore_default_contamination_flavor
	TL.contamination_color = vore_default_contamination_color
	TL.escapable = vore_escape_chance > 0
	TL.escapechance_absorbed = vore_escape_chance_absorbed
	TL.digestchance = vore_digest_chance
	TL.absorbchance = vore_absorb_chance
	TL.human_prey_swallow_time = swallowTime
	TL.nonhuman_prey_swallow_time = swallowTime
	TL.vore_verb = "swallow"
	TL.examine_messages = "There’s a thick, still wriggling bulge in %pred’s tail.  They’ve clearly had a meal recently.  It wetly <b>glrts</b> as it works the poor unfortunate over."
	TL.digest_brute = 3
	TL.digest_burn = 3
	TL.escape_attempt_messages_prey = "You begin to attack %pred's taught stomach effectively!"
	TL.escape_messages_outside = "%pred lurches over, horking up %prey. Ugh..."
	TL.escape_messages_prey = "A sudden reflex, and you manage to make %pred cough you up. Slimy, but alive!"
	TL.escape_fail_messages_prey = "%pred's stomach clenches down hard, preventing your escape."
	TL.escapechance = 5
	TL.emote_lists[DM_DIGEST] = list(
		"The churning walls that surround you clench tightly over your body, washing you in tingling fluids.",
		"A bubble passes through the winding guts with a <b>glrp</b>, giving you a fresh breath of acrid digestion.",
		"The snake slithers outside, dragging your body against the ground.  You feel stretched by the tightly clinging muscles as they strain to keep you in place.",
		"You feel %pred sit atop you from outside, the thick bulge compressed by their weight.  It just helps smear you against their internal walls.",
		"A sudden sliding of that tail causes you to slosh.  You can hear those muscles <b>glrrrgl</b> as they try to contain the motion.",
		"You hear some liquid slop shift from somewhere deeper in the winding tunnel that surrounds you.  <b>slrsh…</b>")
	can_be_drop_pred = TRUE // Mobs will eat anyone that decides to drop/slip into them by default.
	TL.struggle_messages_inside = list(
		"You push out against the winding guts surrounding you, but your arms slip against the built-up slop atop the villi that hold you tight.",
		"You arch your back and try to wiggle within %pred, but the tight walls of that tail smother your face as you smear yourself against them.",
		"You thrash inside %pred, and the muscles of their tail strain to contain you.  You can hear their vibrating, groaning shifting as they barely give way.",
		"A tight pulse wrings your body as you try to resist the motions of that tail.  It lets out a wet gurgle as yet more fluids drown over you.",
		"You try to rock the tail outside to throw off %pred’s balance, but you instead just make a liquid slosh as you’re washed in the acrid gutslime coating you.",
		"You struggle to throw off the tight muscles pushing you deeper, only managing to induce an upset, liquid gurgle that passes down the length of %pred’s tail.",
		"Your body slips against the vice tight internal walls while you attempt to resist their motion, but they make a firm clench across your body that makes it hard to move.",
		"The tail surrounding you tosses you against each wall with every slither.  It’s surprising that the naga can even move normally with you inside, but their agility feels largely unaffected."
	)
	TL.struggle_messages_outside = list(
		"One of the bulges inside %pred’s long tail pushes out, you swear you can see a face outlined beneath the groaning, gurgling scales.",
		"You hear a frustrated grunt muffled by %pred’s long tail.  Someone is pushing out against the walls from inside, causing all manner of unholy noises to groan out from within.",
		"%pred’s tail bulges with the resisting outline of someone within, before it visibly clenches across their frame.  You can see it, straightened out and prone, slid across the ground with every slither."
	)
	TL.belly_fullscreen = "vboanim_snakebelly1"
	TL.belly_fullscreen_color = "#823232"
	TL.belly_fullscreen_color2 = "#823232"
