/datum/advclass/trader/travelling_merchant
	name = "Travelling Merchant"
	tutorial = "You are a merchant forever on the move, stopping by for this week in the duchy of Azure Peak. While this isn't your home, you are extremely well connected, and can aquire goods for half the normal cost by pulling favours and rank, although getting to said supplies might be a bit bothersome. Better hire some mercs! Whenever you set up your own little peddling place, or work to supply the city's own merchant, keep in mind that you have little use for mammons, and would rather use them to expand your influence, as you are a multinational businessperson, and have little desire for local currency."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_TRADER, CTAG_COURTAGENT, CTAG_LICKER_WRETCH)
	class_select_category = CLASS_CAT_TRADER

/datum/outfit/job/roguetown/adventurer/trader/travelling_merchant/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning("You are a merchant forever on the move, stopping by for this week in the duchy of Azure Peak. While this isn't your home, you are extremely well connected, and can aquire goods for half the normal cost by pulling favours and rank, although getting to said supplies might be a bit bothersome. Better hire some mercs! Whenever you set up your own little peddling place, or work to supply the city's own merchant, keep in mind that you have little use for mammons, and would rather use them to expand your influence, as you are a multinational businessperson, and have little desire for local currency."))
	//H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/travelling_merchant/checkfavours)
	//H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/travelling_merchant_sourcegoods)
	//H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/travelling_merchant_sellgoods)
	//H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/travelling_merchant_exploitmarket)
	//H.AddComponent(/datum/component/travelling_merchant)


/*/obj/effect/proc_holder/spell/invoked/travelling_merchant/proc/getFavours(mob/living/user)
	var/datum/travelling_merchant = user.GetComponent(datum/travelling_merchant)
	return travelling_merchant.favours

/obj/effect/proc_holder/spell/invoked/travelling_merchant/checkfavours
	name = "Check favours"
	desc = "Using your trusty journal, you can take a moment to remember how much clout you have with your connections."

/obj/effect/proc_holder/spell/invoked/travelling_merchant/checkfavours/cast(mob/living/user)
	var favours = getFavours(user)
	to_chat(user, span_info("According to these pages, once you add everything up, it comes out to around [favours] mammons worth of clout."))

/obj/effect/proc_holder/spell/invoked/travelling_merchant/sourcegoods
	name = "Source goods"
	desc = "Use it on a hermes post to contact suppliers, arranging a dead drop for you to fetch.\nCooldown and package location difficulty is dependent on the amount of favours you are using."



/obj/effect/proc_holder/spell/invoked/travelling_merchant/sellgoods
	name = "Sell goods"
	desc = "Use it on a hermes post to contact buyers, arranging a dead drop for you to deliver.\nCooldown and package location difficulty is dependent on the amount of favours you are getting."

/obj/effect/proc_holder/spell/invoked/travelling_merchant/exploitmarket
	name = "Exploit market"
	desc = "Use it on a hermes post to contact counting houses, aquiring information on the favourable imports and exports of the world.\nCooldown and package location difficulty is dependent on the amount of favours you are using or getting."
*/

/datum/component/travelling_merchant
	var/favours = 300
	var/favourtimer
	var/list/allcats = list(
		"Alcohols",
		"Apparel",
		"Consumable",
		"Gems",
		"Instruments",
		"Luxury",
		"Livestock",
		"Cosmetics",
		"Raw Materials",
		"Seeds",
		"Tools",
		"Wardrobe",
		"Adventuring Supplies",
		"Armor (Light)",
		"Armor (Iron)",
		"Armor (Steel)",
		"Armor (Exotic)",
		"Potions",
		"Weapons (Ranged)",
		"Weapons (Iron and Shields)",
		"Weapons (Steel)",
		"Weapons (Foreign)",
		"Diplomacy and Persuasion",
		"Beverages",
		"Exotic Import",
		"General Labour",
		"Health and Hygiene",
		"Self Defense")
	var/list/unlockedcats = list()
	var/catunlockspending = 3
	var/list/current_cart = list()

/datum/component/travelling_merchant/Initialize(...)
	. = ..()
	favourtimer = addtimer(CALLBACK(src, PROC_REF(AddFavours)),5 MINUTES, TIMER_STOPPABLE | TIMER_LOOP)
	var/choice = SelectCategory()
	while(choice && catunlockspending)
		catunlockspending -= 1
		unlockedcats += choice
		choice = SelectCategory()
	
/datum/component/travelling_merchant/proc/SelectCategory()
	var/list/catchoices = allcats - unlockedcats
	var/choice = tgui_input_list(parent,"Category slots currently left: [catunlockspending]","Choose your starting categories. You can choose additional categories later, at any hermes, and buy additional slots as well.",catchoices)
	return choice

/datum/component/travelling_merchant/proc/AddFavours()
	to_chat(parent,"Your previous deals still reverberate through your channels. Their debts, material or sentimental ever incuring interest... you are now 50 favours richer, for a total of [favours] favours.")
	favours += 50

/datum/component/travelling_merchant/Destroy()
	deltimer(favourtimer)
	favourtimer = null
	. = ..()


/datum/component/travelling_merchant/proc/ui_static_data_fill_in()
	var/list/data = list()
	data["supplypacks"] = SSmerchant.supply_packs
	return data
	

/datum/component/travelling_merchant/proc/ui_dynamic_data_fill_in()
	var/list/data = list()
	data["favours"] = favours
	data["unlockedCats"] = unlockedcats
	data["catunlockspending"] = catunlockspending
	return data

