/datum/virtue/combat/crimson_curse
	name = "Crimson Curse (-3 TRI)"
	desc = "You suffer from the Crimson Curse, a weak form of Vampirism acquired from dark rites or a particularly cruel hex. Unlike a 'true' Vampire, you are incapable of converting others or commiting Diablerie."
	custom_text = span_bloody("CON IS ADJUSTED BY -1!")
	triumph_cost = 3

/datum/virtue/combat/crimson_curse/apply_to_human(mob/living/carbon/human/recipient)
	//Hacky but we need to do this, otherwise the CC trait isn't applied before vampire checks for the trait and stops us from being Clan Leader
	ADD_TRAIT(recipient, TRAIT_CRIMSON_CURSE, TRAIT_GENERIC)
	addtimer(CALLBACK(src, .proc/crimson_apply, recipient), 30)

/datum/virtue/combat/crimson_curse/proc/crimson_apply(mob/living/carbon/human/recipient)
	var/datum/antagonist/vampire/stray/new_antag = new /datum/antagonist/vampire/stray(incoming_clan = /datum/clan/strays, forced_clan = FALSE, generation = GENERATION_FAILVAMP)
	recipient.mind.add_antag_datum(new_antag)
	recipient.change_stat(STATKEY_CON, -1)


/// crimsmssieee curseee
/datum/antagonist/vampire/stray
	name = "Stray Vampire"
	antag_hud_type = null
	antag_hud_name = null
	default_clan = /datum/clan/strays
	clan_selected = TRUE

/datum/antagonist/vampire/stray/New(incoming_clan = /datum/clan/strays, forced_clan = FALSE, generation = GENERATION_FAILVAMP)
	. = ..(incoming_clan, forced_clan, generation)

/datum/antagonist/vampire/stray/add_antag_hud(antag_hud_type, antag_hud_name, mob/living/mob_override)
	return


/datum/status_effect/buff/crimson_curse_blood
	id = "crimson_curse_blood"
	alert_type = /atom/movable/screen/alert/status_effect/buff/crimson_curse_blood
	duration = 30 SECONDS
	status_type = STATUS_EFFECT_REFRESH

/atom/movable/screen/alert/status_effect/buff/crimson_curse_blood
	name = "Sanguine Curse"
	desc = span_good("Crimson Curse is a joke. Yet, their blood is surprisingly exquisite and nourishing!")
	icon_state = "hunger2"

/datum/status_effect/buff/crimson_curse_blood/on_apply()
	. = ..()
	if(.)
		owner.add_stress(/datum/stressevent/nourishing_blood)
		owner.adjustBruteLoss(5)

/datum/status_effect/buff/crimson_curse_blood/on_remove()
	. = ..()
	owner.remove_stress(/datum/stressevent/nourishing_blood)

/datum/stressevent/nourishing_blood
	desc = span_good("That blood was tasty!")
	stressadd = -2
	max_stacks = 10
	stressadd_per_extra_stack = -2
	timer = 10 MINUTES

/// Toreador from Temu.
/datum/clan_leader/strays
	lord_spells = list(
	)
	lord_verbs = list(
	)
	lord_traits = list()
	lord_title = "Elder"
	vitae_bonus = 500

/datum/clan/strays
	name = "Strays"
	desc = "Strays can hardly be called vampires in the traditional sense. They are individuals who have been cursed with a mild form of vampirism, often through dark rituals or exposure to malevolent forces. Unlike true vampires, Strays lack the ability to convert others or commit Diablerie, making them outcasts among their kind. They struggle to control their thirst for blood and are often shunned by both humans and vampires alike."
	curse = "Aimlessness"
	blood_preference = BLOOD_PREFERENCE_ALL
	clane_traits = list(
		TRAIT_NOHUNGER,
		TRAIT_ZOMBIE_IMMUNE,
		TRAIT_NOBREATH,
		TRAIT_NOPAINSTUN,
		TRAIT_TOXIMMUNE,
		TRAIT_NOSLEEP,
		TRAIT_VAMP_DREAMS,
		TRAIT_SILVER_WEAK,
		TRAIT_CRIMSON_CURSE
		)
	clane_covens = list()
	leader = /datum/clan_leader/strays
	covens_to_select = 0

/datum/status_effect/debuff/sunspurn
	id = "Sunspurn"
	alert_type =  /atom/movable/screen/alert/status_effect/debuff/sunspurn
	effectedstats = list("strength" = -2, "endurance" = -3, "constitution" = -3)
	duration = 1 MINUTES

/atom/movable/screen/alert/status_effect/debuff/sunspurn
	name = "Sunspurned"
	desc = "Astrata spurns me! I feel so weak..."
	icon_state = "muscles"
