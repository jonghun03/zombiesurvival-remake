GM.ZombieEscapeWeaponsPrimary = {
	"weapon_zs_zeakbar",
	"weapon_zs_zesweeper",
	"weapon_zs_zesmg",
	"weapon_zs_zeinferno",
	"weapon_zs_zestubber",
	"weapon_zs_zebulletstorm",
	"weapon_zs_zesilencer",
	"weapon_zs_zequicksilver",
	"weapon_zs_zeamigo",
	"weapon_zs_zem4"
}

GM.ZombieEscapeWeaponsSecondary = {
	"weapon_zs_zedeagle",
	"weapon_zs_zebattleaxe",
	"weapon_zs_zeeraser",
	"weapon_zs_zeglock",
	"weapon_zs_zetempest"
}

-- Change this if you plan to alter the cost of items or you severely change how Worth works.
-- Having separate cart files allows people to have separate loadouts for different servers.
GM.CartFile = "zscarts.txt"
GM.SkillLoadoutsFile = "zsskloadouts.txt"

ITEMCAT_GUNS = 1
ITEMCAT_AMMO = 2
ITEMCAT_MELEE = 3
ITEMCAT_TOOLS = 4
ITEMCAT_DEPLOYABLES = 5
ITEMCAT_TRINKETS = 6
ITEMCAT_OTHER = 7

ITEMSUBCAT_TRINKETS_DEFENSIVE = 1
ITEMSUBCAT_TRINKETS_OFFENSIVE = 2
ITEMSUBCAT_TRINKETS_MELEE = 3
ITEMSUBCAT_TRINKETS_PERFORMANCE = 4
ITEMSUBCAT_TRINKETS_SUPPORT = 5
ITEMSUBCAT_TRINKETS_SPECIAL = 6

GM.ItemCategories = {
	[ITEMCAT_GUNS] = "총",
	[ITEMCAT_AMMO] = "탄약",
	[ITEMCAT_MELEE] = "근접 무기",
	[ITEMCAT_TOOLS] = "도구",
	[ITEMCAT_DEPLOYABLES] = "설치물",
	[ITEMCAT_TRINKETS] = "장신구",
	[ITEMCAT_OTHER] = "기타"
}

GM.ItemSubCategories = {
	[ITEMSUBCAT_TRINKETS_DEFENSIVE] = "방어",
	[ITEMSUBCAT_TRINKETS_OFFENSIVE] = "공격",
	[ITEMSUBCAT_TRINKETS_MELEE] = "근접",
	[ITEMSUBCAT_TRINKETS_PERFORMANCE] = "능력",
	[ITEMSUBCAT_TRINKETS_SUPPORT] = "지원",
	[ITEMSUBCAT_TRINKETS_SPECIAL] = "특별"
}

--[[
Humans select what weapons (or other things) they want to start with and can even save favorites. Each object has a number of 'Worth' points.
Signature is a unique signature to give in case the item is renamed or reordered. Don't use a number or a string number!
A human can only use 100 points (default) when they join. Redeeming or joining late starts you out with a random loadout from above.
SWEP is a swep given when the player spawns with that perk chosen.
Callback is a function called. Model is a display model. If model isn't defined then the SWEP model will try to be used.
swep, callback, and model can all be nil or empty
]]
GM.Items = {}
function GM:AddItem(signature, category, price, swep, name, desc, model, callback)
	local tab = {Signature = signature, Name = name or "?", Description = desc, Category = category, Price = price or 0, SWEP = swep, Callback = callback, Model = model}

	tab.Worth = tab.Price -- compat

	self.Items[#self.Items + 1] = tab
	self.Items[signature] = tab

	return tab
end

function GM:AddStartingItem(signature, category, price, swep, name, desc, model, callback)
	local item = self:AddItem(signature, category, price, swep, name, desc, model, callback)
	item.WorthShop = true

	return item
end

function GM:AddPointShopItem(signature, category, price, swep, name, desc, model, callback)
	local item = self:AddItem("ps_"..signature, category, price, swep, name, desc, model, callback)
	item.PointShop = true

	return item
end

-- How much ammo is considered one 'clip' of ammo? For use with setting up weapon defaults. Works directly with zs_survivalclips
GM.AmmoCache = {}
GM.AmmoCache["ar2"]							= 32		-- Assault rifles.
GM.AmmoCache["alyxgun"]						= 24		-- Not used.
GM.AmmoCache["pistol"]						= 14		-- Pistols.
GM.AmmoCache["smg1"]						= 36		-- SMG's and some rifles.
GM.AmmoCache["357"]							= 8			-- Rifles, especially of the sniper variety.
GM.AmmoCache["xbowbolt"]					= 8			-- Crossbows
GM.AmmoCache["buckshot"]					= 12		-- Shotguns
GM.AmmoCache["ar2altfire"]					= 1			-- Not used.
GM.AmmoCache["slam"]						= 1			-- Force Field Emitters.
GM.AmmoCache["rpg_round"]					= 1			-- Not used. Rockets?
GM.AmmoCache["smg1_grenade"]				= 1			-- Not used.
GM.AmmoCache["sniperround"]					= 1			-- Barricade Kit
GM.AmmoCache["sniperpenetratedround"]		= 1			-- Remote Det pack.
GM.AmmoCache["grenade"]						= 1			-- Grenades.
GM.AmmoCache["thumper"]						= 1			-- Gun turret.
GM.AmmoCache["gravity"]						= 1			-- Unused.
GM.AmmoCache["battery"]						= 23		-- Used with the Medical Kit.
GM.AmmoCache["gaussenergy"]					= 2			-- Nails used with the Carpenter's Hammer.
GM.AmmoCache["combinecannon"]				= 1			-- Not used.
GM.AmmoCache["airboatgun"]					= 1			-- Arsenal crates.
GM.AmmoCache["striderminigun"]				= 1			-- Message beacons.
GM.AmmoCache["helicoptergun"]				= 1			-- Resupply boxes.
GM.AmmoCache["spotlamp"]					= 1
GM.AmmoCache["manhack"]						= 1
GM.AmmoCache["repairfield"]					= 1
GM.AmmoCache["zapper"]						= 1
GM.AmmoCache["pulse"]						= 30
GM.AmmoCache["impactmine"]					= 3
GM.AmmoCache["chemical"]					= 20
GM.AmmoCache["flashbomb"]					= 1
GM.AmmoCache["turret_buckshot"]				= 1
GM.AmmoCache["turret_assault"]				= 1
GM.AmmoCache["scrap"]						= 3

GM.AmmoResupply = table.ToAssoc({"ar2", "pistol", "smg1", "357", "xbowbolt", "buckshot", "battery", "pulse", "impactmine", "chemical", "gaussenergy", "scrap"})

-----------
-- 자본상점 --
-----------

GM:AddStartingItem("pshtr",				ITEMCAT_GUNS,			45,				"weapon_zs_peashooter")
GM:AddStartingItem("btlax",				ITEMCAT_GUNS,			45,				"weapon_zs_battleaxe")
GM:AddStartingItem("owens",				ITEMCAT_GUNS,			45,				"weapon_zs_owens")
GM:AddStartingItem("blstr",				ITEMCAT_GUNS,			45,				"weapon_zs_blaster")
GM:AddStartingItem("tossr",				ITEMCAT_GUNS,			45,				"weapon_zs_tosser")
GM:AddStartingItem("stbbr",				ITEMCAT_GUNS,			45,				"weapon_zs_stubber")
GM:AddStartingItem("crklr",				ITEMCAT_GUNS,			45,				"weapon_zs_crackler")
GM:AddStartingItem("sling",				ITEMCAT_GUNS,			45,				"weapon_zs_slinger")
GM:AddStartingItem("z9000",				ITEMCAT_GUNS,			45,				"weapon_zs_z9000")
GM:AddStartingItem("minelayer",			ITEMCAT_GUNS,			60,				"weapon_zs_minelayer")

GM:AddStartingItem("2pcp",				ITEMCAT_AMMO,			15,				nil,			"권총탄 28개",				nil,		"ammo_pistol",			function(pl) pl:GiveAmmo(28, "pistol", true) end)
GM:AddStartingItem("3pcp",				ITEMCAT_AMMO,			20,				nil,			"권총탄 42개",				nil,		"ammo_pistol",			function(pl) pl:GiveAmmo(42, "pistol", true) end)
GM:AddStartingItem("2sgcp",				ITEMCAT_AMMO,			15,				nil,			"샷건탄 24개",				nil,		"ammo_shotgun",			function(pl) pl:GiveAmmo(24, "buckshot", true) end)
GM:AddStartingItem("3sgcp",				ITEMCAT_AMMO,			20,				nil,			"샷건탄 36개",				nil,		"ammo_shotgun",			function(pl) pl:GiveAmmo(36, "buckshot", true) end)
GM:AddStartingItem("2smgcp",			ITEMCAT_AMMO,			15,				nil,			"SMG탄 72개",			nil,		"ammo_smg",				function(pl) pl:GiveAmmo(72, "smg1", true) end)
GM:AddStartingItem("3smgcp",			ITEMCAT_AMMO,			20,				nil,			"SMG탄 108개",			nil,		"ammo_smg",				function(pl) pl:GiveAmmo(108, "smg1", true) end)
GM:AddStartingItem("2arcp",				ITEMCAT_AMMO,			15,				nil,			"돌격소총탄 64개",		nil,		"ammo_assault",			function(pl) pl:GiveAmmo(64, "ar2", true) end)
GM:AddStartingItem("3arcp",				ITEMCAT_AMMO,			20,				nil,			"돌격소총탄 96개",		nil,		"ammo_assault",			function(pl) pl:GiveAmmo(96, "ar2", true) end)
GM:AddStartingItem("2rcp",				ITEMCAT_AMMO,			15,				nil,			"소총탄 16개",			nil,		"ammo_rifle",			function(pl) pl:GiveAmmo(16, "357", true) end)
GM:AddStartingItem("3rcp",				ITEMCAT_AMMO,			20,				nil,			"소총탄 24개",			nil,		"ammo_rifle",			function(pl) pl:GiveAmmo(24, "357", true) end)
GM:AddStartingItem("2pls",				ITEMCAT_AMMO,			15,				nil,			"펄스 에너지 60개",			nil,		"ammo_pulse",			function(pl) pl:GiveAmmo(60, "pulse", true) end)
GM:AddStartingItem("3pls",				ITEMCAT_AMMO,			20,				nil,			"펄스 에너지 90개",			nil,		"ammo_pulse",			function(pl) pl:GiveAmmo(90, "pulse", true) end)
GM:AddStartingItem("xbow1",				ITEMCAT_AMMO,			15,				nil,			"화살 16개",			nil,		"ammo_bolts",			function(pl) pl:GiveAmmo(16, "XBowBolt", true) end)
GM:AddStartingItem("xbow2",				ITEMCAT_AMMO,			20,				nil,			"화살 24개",			nil,		"ammo_bolts",			function(pl) pl:GiveAmmo(24, "XBowBolt", true) end)
GM:AddStartingItem("4mines",			ITEMCAT_AMMO,			15,				nil,			"지뢰 6개",				nil,		"ammo_explosive",		function(pl) pl:GiveAmmo(6, "impactmine", true) end)
GM:AddStartingItem("6mines",			ITEMCAT_AMMO,			20,				nil,			"지뢰 9개",				nil,		"ammo_explosive",		function(pl) pl:GiveAmmo(9, "impactmine", true) end)
GM:AddStartingItem("8nails",			ITEMCAT_AMMO,			15,				nil,			"못 8개",				nil, 		"ammo_nail", 			function(pl) pl:GiveAmmo(8, "GaussEnergy", true) end)
GM:AddStartingItem("12nails",			ITEMCAT_AMMO,			20,				nil,			"못 12개",				nil, 		"ammo_nail", 			function(pl) pl:GiveAmmo(12, "GaussEnergy", true) end)
GM:AddStartingItem("60mkit",			ITEMCAT_AMMO,			15,				nil,			"의약품 60개",			nil,		"ammo_medpower",		function(pl) pl:GiveAmmo(60, "Battery", true) end)
GM:AddStartingItem("90mkit",			ITEMCAT_AMMO,			25,				nil,			"의약품 90개",			nil,		"ammo_medpower",		function(pl) pl:GiveAmmo(90, "Battery", true) end)
GM:AddStartingItem("4board",			ITEMCAT_AMMO,			15,				nil,			"판자 4개",				nil,		"ammo_scrap",			function(pl) pl:GiveAmmo(4, "sniperround", true) end)
GM:AddStartingItem("8board",			ITEMCAT_AMMO,			25,				nil,			"판자 8개",				nil,		"ammo_scrap",			function(pl) pl:GiveAmmo(8, "sniperround", true) end)

GM:AddStartingItem("brassknuckles",		ITEMCAT_MELEE,			20,				"weapon_zs_brassknuckles").Model = "models/props_c17/utilityconnecter005.mdl"
GM:AddStartingItem("zpaxe",				ITEMCAT_MELEE,			40,				"weapon_zs_axe")
GM:AddStartingItem("crwbar",			ITEMCAT_MELEE,			40,				"weapon_zs_crowbar")
GM:AddStartingItem("stnbtn",			ITEMCAT_MELEE,			40,				"weapon_zs_stunbaton")
GM:AddStartingItem("csknf",				ITEMCAT_MELEE,			20,				"weapon_zs_swissarmyknife")
GM:AddStartingItem("zpplnk",			ITEMCAT_MELEE,			20,				"weapon_zs_plank")
GM:AddStartingItem("zpfryp",			ITEMCAT_MELEE,			30,				"weapon_zs_fryingpan")
GM:AddStartingItem("zpcpot",			ITEMCAT_MELEE,			30,				"weapon_zs_pot")
GM:AddStartingItem("ladel",				ITEMCAT_MELEE,			30,				"weapon_zs_ladel")
GM:AddStartingItem("pipe",				ITEMCAT_MELEE,			40,				"weapon_zs_pipe")
GM:AddStartingItem("hook",				ITEMCAT_MELEE,			40,				"weapon_zs_hook")

local item
GM:AddStartingItem("medkit",			ITEMCAT_TOOLS,			60,				"weapon_zs_medicalkit")
GM:AddStartingItem("medgun",			ITEMCAT_TOOLS,			55,				"weapon_zs_medicgun")
item =
GM:AddStartingItem("strengthshot",		ITEMCAT_TOOLS,			40,				"weapon_zs_strengthshot")
item.SkillRequirement = SKILL_U_STRENGTHSHOT
item =
GM:AddStartingItem("antidoteshot",		ITEMCAT_TOOLS,			40,				"weapon_zs_antidoteshot")
item.SkillRequirement = SKILL_U_ANTITODESHOT
GM:AddStartingItem("arscrate",			ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_arsenalcrate")
.Countables = "prop_arsenalcrate"
GM:AddStartingItem("resupplybox",		ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_resupplybox")
.Countables = "prop_resupplybox"
GM:AddStartingItem("remantler",			ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_remantler")
.Countables = "prop_remantler"
item =
GM:AddStartingItem("infturret",			ITEMCAT_DEPLOYABLES,			75,				"weapon_zs_gunturret",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret") pl:GiveAmmo(1, "thumper") pl:GiveAmmo(125, "smg1") end)
item.Countables = "prop_gunturret"
item.NoClassicMode = true
item =
GM:AddStartingItem("blastturret",		ITEMCAT_DEPLOYABLES,			75,				"weapon_zs_gunturret_buckshot",	nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_buckshot") pl:GiveAmmo(1, "turret_buckshot") pl:GiveAmmo(30, "buckshot") end)
item.Countables = "prop_gunturret_buckshot"
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_BLASTTURRET
item =
GM:AddStartingItem("repairfield",		ITEMCAT_DEPLOYABLES,			60,				"weapon_zs_repairfield",		nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_repairfield") pl:GiveAmmo(1, "repairfield") pl:GiveAmmo(50, "pulse") end)
item.Countables = "prop_repairfield"
item.NoClassicMode = true
item =
GM:AddStartingItem("zapper",			ITEMCAT_DEPLOYABLES,			75,				"weapon_zs_zapper",				nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_zapper") pl:GiveAmmo(1, "zapper") pl:GiveAmmo(50, "pulse") end)
item.Countables = "prop_zapper"
item.NoClassicMode = true

GM:AddStartingItem("manhack",			ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_manhack").Countables = "prop_manhack"
item =
GM:AddStartingItem("drone",				ITEMCAT_DEPLOYABLES,			55,				"weapon_zs_drone",				nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_drone") pl:GiveAmmo(1, "drone") pl:GiveAmmo(60, "smg1") end)
item.Countables = "prop_drone"
item =
GM:AddStartingItem("pulsedrone",		ITEMCAT_DEPLOYABLES,			55,				"weapon_zs_drone_pulse",		nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_drone_pulse") pl:GiveAmmo(1, "pulse_cutter") pl:GiveAmmo(60, "pulse") end)
item.Countables = "prop_drone_pulse"
item.SkillRequirement = SKILL_U_DRONE
item =
GM:AddStartingItem("hauldrone",			ITEMCAT_DEPLOYABLES,			25,				"weapon_zs_drone_hauler",		nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_drone_hauler") pl:GiveAmmo(1, "drone_hauler") end)
item.Countables = "prop_drone_hauler"
item.SkillRequirement = SKILL_HAULMODULE
item =
GM:AddStartingItem("rollermine",		ITEMCAT_DEPLOYABLES,			65,				"weapon_zs_rollermine",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_rollermine") pl:GiveAmmo(1, "rollermine") end)
item.Countables = "prop_rollermine"
item.SkillRequirement = SKILL_U_ROLLERMINE

GM:AddStartingItem("wrench",			ITEMCAT_TOOLS,			20,				"weapon_zs_wrench").NoClassicMode = true
GM:AddStartingItem("crphmr",			ITEMCAT_TOOLS,			40,				"weapon_zs_hammer").NoClassicMode = true
GM:AddStartingItem("junkpack",			ITEMCAT_DEPLOYABLES,	30,				"weapon_zs_boardpack")
GM:AddStartingItem("propanetank",		ITEMCAT_TOOLS,			30,				"comp_propanecan")
GM:AddStartingItem("busthead",			ITEMCAT_TOOLS,			35,				"comp_busthead")
GM:AddStartingItem("sawblade",			ITEMCAT_TOOLS,			35,				"comp_sawblade").SkillRequirement = SKILL_U_CRAFTINGPACK
GM:AddStartingItem("cpuparts",			ITEMCAT_TOOLS,			35,				"comp_cpuparts").SkillRequirement = SKILL_U_CRAFTINGPACK
GM:AddStartingItem("electrobattery",	ITEMCAT_TOOLS,			45,				"comp_electrobattery").SkillRequirement = SKILL_U_CRAFTINGPACK
GM:AddStartingItem("msgbeacon",			ITEMCAT_DEPLOYABLES,			10,				"weapon_zs_messagebeacon").Countables = "prop_messagebeacon"
item =
GM:AddStartingItem("ffemitter",			ITEMCAT_DEPLOYABLES,			45,				"weapon_zs_ffemitter",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_ffemitter") pl:GiveAmmo(1, "slam") pl:GiveAmmo(50, "pulse") end)
item.Countables = "prop_ffemitter"
GM:AddStartingItem("barricadekit",		ITEMCAT_DEPLOYABLES,			80,				"weapon_zs_barricadekit")
GM:AddStartingItem("camera",			ITEMCAT_DEPLOYABLES,			15,				"weapon_zs_camera").Countables = "prop_camera"
GM:AddStartingItem("tv",				ITEMCAT_DEPLOYABLES,			35,				"weapon_zs_tv").Countables = "prop_tv"

GM:AddStartingItem("oxtank",			ITEMCAT_TRINKETS,		5,				"trinket_oxygentank").SubCategory =				ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddStartingItem("boxingtraining",	ITEMCAT_TRINKETS,		10,				"trinket_boxingtraining").SubCategory =			ITEMSUBCAT_TRINKETS_MELEE
GM:AddStartingItem("cutlery",			ITEMCAT_TRINKETS,		10,				"trinket_cutlery").SubCategory =				ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("portablehole",		ITEMCAT_TRINKETS,		10,				"trinket_portablehole").SubCategory =			ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddStartingItem("acrobatframe",		ITEMCAT_TRINKETS,		15,				"trinket_acrobatframe").SubCategory=			ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddStartingItem("nightvision",		ITEMCAT_TRINKETS,		15,				"trinket_nightvision").SubCategory =			ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("targetingvisi",		ITEMCAT_TRINKETS,		15,				"trinket_targetingvisori").SubCategory =		ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddStartingItem("pulseampi",			ITEMCAT_TRINKETS,		15,				"trinket_pulseampi").SubCategory =				ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddStartingItem("blueprintsi",		ITEMCAT_TRINKETS,		15,				"trinket_blueprintsi").SubCategory =			ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddStartingItem("loadingframe",		ITEMCAT_TRINKETS,		15,				"trinket_loadingex").SubCategory =				ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddStartingItem("kevlar",			ITEMCAT_TRINKETS,		15,				"trinket_kevlar").SubCategory =					ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("momentumsupsysii",	ITEMCAT_TRINKETS,		15,				"trinket_momentumsupsysii").SubCategory =		ITEMSUBCAT_TRINKETS_MELEE
GM:AddStartingItem("hemoadrenali",		ITEMCAT_TRINKETS,		15,				"trinket_hemoadrenali").SubCategory =			ITEMSUBCAT_TRINKETS_MELEE
GM:AddStartingItem("vitpackagei",		ITEMCAT_TRINKETS,		20,				"trinket_vitpackagei").SubCategory =			ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("processor",			ITEMCAT_TRINKETS,		20,				"trinket_processor").SubCategory =				ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddStartingItem("cardpackagei",		ITEMCAT_TRINKETS,		20,				"trinket_cardpackagei").SubCategory =			ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("bloodpack",			ITEMCAT_TRINKETS,		20,				"trinket_bloodpack").SubCategory =				ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("biocleanser",		ITEMCAT_TRINKETS,		20,				"trinket_biocleanser").SubCategory =			ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("reactiveflasher",	ITEMCAT_TRINKETS,		25,				"trinket_reactiveflasher").SubCategory =		ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("magnet",			ITEMCAT_TRINKETS,		25,				"trinket_magnet").SubCategory =					ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddStartingItem("arsenalpack",		ITEMCAT_TRINKETS,		55,				"trinket_arsenalpack").SubCategory =			ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddStartingItem("resupplypack",		ITEMCAT_TRINKETS,		55,				"trinket_resupplypack").SubCategory =			ITEMSUBCAT_TRINKETS_SUPPORT

GM:AddStartingItem("stone",				ITEMCAT_OTHER,			10,				"weapon_zs_stone")
GM:AddStartingItem("grenade",			ITEMCAT_OTHER,			30,				"weapon_zs_grenade")
GM:AddStartingItem("flashbomb",			ITEMCAT_OTHER,			15,				"weapon_zs_flashbomb")
GM:AddStartingItem("molotov",			ITEMCAT_OTHER,			30,				"weapon_zs_molotov")
GM:AddStartingItem("betty",				ITEMCAT_OTHER,			30,				"weapon_zs_proxymine")
GM:AddStartingItem("corgasgrenade",		ITEMCAT_OTHER,			40,				"weapon_zs_corgasgrenade")
GM:AddStartingItem("crygasgrenade",		ITEMCAT_OTHER,			35,				"weapon_zs_crygasgrenade").SkillRequirement = SKILL_U_CRYGASGREN
GM:AddStartingItem("detpck",			ITEMCAT_OTHER,			35,				"weapon_zs_detpack").Countables = "prop_detpack"
item =
GM:AddStartingItem("sigfragment",		ITEMCAT_OTHER,			25,				"weapon_zs_sigilfragment")
item.NoClassicMode = true
item =
GM:AddStartingItem("corfragment",		ITEMCAT_OTHER,			35,				"weapon_zs_corruptedfragment")
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_CORRUPTEDFRAGMENT
item =
GM:AddStartingItem("medcloud",			ITEMCAT_OTHER,			25,				"weapon_zs_mediccloudbomb")
item.SkillRequirement = SKILL_U_MEDICCLOUD
item =
GM:AddStartingItem("nanitecloud",		ITEMCAT_OTHER,			25,				"weapon_zs_nanitecloudbomb")
item.SkillRequirement = SKILL_U_NANITECLOUD
GM:AddStartingItem("bloodshot",			ITEMCAT_OTHER,			35,				"weapon_zs_bloodshotbomb")

------------
-- 일반 상점 --
------------

-- Tier 1
GM:AddPointShopItem("pshtr",			ITEMCAT_GUNS,			15,				"weapon_zs_peashooter", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_peashooter") end)
GM:AddPointShopItem("btlax",			ITEMCAT_GUNS,			15,				"weapon_zs_battleaxe", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_battleaxe") end)
GM:AddPointShopItem("owens",			ITEMCAT_GUNS,			15,				"weapon_zs_owens", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_owens") end)
GM:AddPointShopItem("blstr",			ITEMCAT_GUNS,			15,				"weapon_zs_blaster", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_blaster") end)
GM:AddPointShopItem("tossr",			ITEMCAT_GUNS,			15,				"weapon_zs_tosser", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_tosser") end)
GM:AddPointShopItem("stbbr",			ITEMCAT_GUNS,			15,				"weapon_zs_stubber", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_stubber") end)
GM:AddPointShopItem("crklr",			ITEMCAT_GUNS,			15,				"weapon_zs_crackler", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_crackler") end)
GM:AddPointShopItem("sling",			ITEMCAT_GUNS,			15,				"weapon_zs_slinger", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_slinger") end)
GM:AddPointShopItem("z9000",			ITEMCAT_GUNS,			15,				"weapon_zs_z9000", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_z9000") end)
GM:AddPointShopItem("minelayer",		ITEMCAT_GUNS,			20,				"weapon_zs_minelayer", nil, nil, nil, function(pl) pl:GiveEmptyWeapon("weapon_zs_minelayer") end)
-- Tier 2
GM:AddPointShopItem("glock3",			ITEMCAT_GUNS,			35,				"weapon_zs_glock3")
GM:AddPointShopItem("magnum",			ITEMCAT_GUNS,			35,				"weapon_zs_magnum")
GM:AddPointShopItem("eraser",			ITEMCAT_GUNS,			35,				"weapon_zs_eraser")
GM:AddPointShopItem("sawedoff",			ITEMCAT_GUNS,			35,				"weapon_zs_sawedoff")
GM:AddPointShopItem("uzi",				ITEMCAT_GUNS,			35,				"weapon_zs_uzi")
GM:AddPointShopItem("annabelle",		ITEMCAT_GUNS,			35,				"weapon_zs_annabelle")
GM:AddPointShopItem("inquisitor",		ITEMCAT_GUNS,			35,				"weapon_zs_inquisitor")
GM:AddPointShopItem("amigo",			ITEMCAT_GUNS,			35,				"weapon_zs_amigo")
GM:AddPointShopItem("hurricane",		ITEMCAT_GUNS,			35,				"weapon_zs_hurricane")
-- Tier 3
GM:AddPointShopItem("deagle",			ITEMCAT_GUNS,			70,				"weapon_zs_deagle")
GM:AddPointShopItem("tempest",			ITEMCAT_GUNS,			70,				"weapon_zs_tempest")
GM:AddPointShopItem("ender",			ITEMCAT_GUNS,			70,				"weapon_zs_ender")
GM:AddPointShopItem("shredder",			ITEMCAT_GUNS,			70,				"weapon_zs_smg")
GM:AddPointShopItem("silencer",			ITEMCAT_GUNS,			70,				"weapon_zs_silencer")
GM:AddPointShopItem("hunter",			ITEMCAT_GUNS,			70,				"weapon_zs_hunter")
GM:AddPointShopItem("onyx",				ITEMCAT_GUNS,			70,				"weapon_zs_onyx")
GM:AddPointShopItem("charon",			ITEMCAT_GUNS,			70,				"weapon_zs_charon")
GM:AddPointShopItem("akbar",			ITEMCAT_GUNS,			70,				"weapon_zs_akbar")
GM:AddPointShopItem("oberon",			ITEMCAT_GUNS,			70,				"weapon_zs_oberon")
GM:AddPointShopItem("hyena",			ITEMCAT_GUNS,			70,				"weapon_zs_hyena")
GM:AddPointShopItem("pollutor",			ITEMCAT_GUNS,			70,				"weapon_zs_pollutor")
-- Tier 4
GM:AddPointShopItem("longarm",			ITEMCAT_GUNS,			125,			"weapon_zs_longarm")
GM:AddPointShopItem("sweeper",			ITEMCAT_GUNS,			125,			"weapon_zs_sweepershotgun")
GM:AddPointShopItem("jackhammer",		ITEMCAT_GUNS,			125,			"weapon_zs_jackhammer")
GM:AddPointShopItem("bulletstorm",		ITEMCAT_GUNS,			125,			"weapon_zs_bulletstorm")
GM:AddPointShopItem("reaper",			ITEMCAT_GUNS,			125,			"weapon_zs_reaper")
GM:AddPointShopItem("quicksilver",		ITEMCAT_GUNS,			125,			"weapon_zs_quicksilver")
GM:AddPointShopItem("slugrifle",		ITEMCAT_GUNS,			125,			"weapon_zs_slugrifle")
GM:AddPointShopItem("artemis",			ITEMCAT_GUNS,			125,			"weapon_zs_artemis")
GM:AddPointShopItem("zeus",				ITEMCAT_GUNS,			125,			"weapon_zs_zeus")
GM:AddPointShopItem("stalker",			ITEMCAT_GUNS,			125,			"weapon_zs_m4")
GM:AddPointShopItem("inferno",			ITEMCAT_GUNS,			125,			"weapon_zs_inferno")
GM:AddPointShopItem("quasar",			ITEMCAT_GUNS,			125,			"weapon_zs_quasar")
GM:AddPointShopItem("gluon",			ITEMCAT_GUNS,			125,			"weapon_zs_gluon")
GM:AddPointShopItem("barrage",			ITEMCAT_GUNS,			125,			"weapon_zs_barrage")
-- Tier 5
GM:AddPointShopItem("novacolt",			ITEMCAT_GUNS,			200,			"weapon_zs_novacolt")
GM:AddPointShopItem("bulwark",			ITEMCAT_GUNS,			200,			"weapon_zs_bulwark")
GM:AddPointShopItem("juggernaut",		ITEMCAT_GUNS,			200,			"weapon_zs_juggernaut")
GM:AddPointShopItem("scar",				ITEMCAT_GUNS,			200,			"weapon_zs_scar")
GM:AddPointShopItem("boomstick",		ITEMCAT_GUNS,			200,			"weapon_zs_boomstick")
GM:AddPointShopItem("deathdlrs",		ITEMCAT_GUNS,			200,			"weapon_zs_deathdealers")
GM:AddPointShopItem("colossus",			ITEMCAT_GUNS,			200,			"weapon_zs_colossus")
GM:AddPointShopItem("renegade",			ITEMCAT_GUNS,			200,			"weapon_zs_renegade")
GM:AddPointShopItem("crossbow",			ITEMCAT_GUNS,			200,			"weapon_zs_crossbow")
GM:AddPointShopItem("pulserifle",		ITEMCAT_GUNS,			200,			"weapon_zs_pulserifle")
GM:AddPointShopItem("spinfusor",		ITEMCAT_GUNS,			200,			"weapon_zs_spinfusor")
GM:AddPointShopItem("broadside",		ITEMCAT_GUNS,			200,			"weapon_zs_broadside")
GM:AddPointShopItem("smelter",			ITEMCAT_GUNS,			200,			"weapon_zs_smelter")

GM:AddPointShopItem("pistolammo",		ITEMCAT_AMMO,			9,				nil,							"권총탄 14개",				nil,									"ammo_pistol",						function(pl) pl:GiveAmmo(14, "pistol", true) end)
GM:AddPointShopItem("shotgunammo",		ITEMCAT_AMMO,			9,				nil,							"샷건탄 12개",				nil,									"ammo_shotgun",						function(pl) pl:GiveAmmo(12, "buckshot", true) end)
GM:AddPointShopItem("smgammo",			ITEMCAT_AMMO,			9,				nil,							"SMG탄 36개",					nil,									"ammo_smg",							function(pl) pl:GiveAmmo(36, "smg1", true) end)
GM:AddPointShopItem("rifleammo",		ITEMCAT_AMMO,			9,				nil,							"소총탄 8개",					nil,									"ammo_rifle",						function(pl) pl:GiveAmmo(8, "357", true) end)
GM:AddPointShopItem("crossbowammo",		ITEMCAT_AMMO,			9,				nil,							"화살 8개",				nil,									"ammo_bolts",						function(pl) pl:GiveAmmo(8,	"XBowBolt",	true) end)
GM:AddPointShopItem("assaultrifleammo",	ITEMCAT_AMMO,			9,				nil,							"돌격소총탄 32개",		nil,									"ammo_assault",						function(pl) pl:GiveAmmo(32, "ar2", true) end)
GM:AddPointShopItem("pulseammo",		ITEMCAT_AMMO,			9,				nil,							"펄스 에너지 30개",				nil,									"ammo_pulse",						function(pl) pl:GiveAmmo(30, "pulse", true) end)
GM:AddPointShopItem("impactmine",		ITEMCAT_AMMO,			9,				nil,							"지뢰 3개",					nil,									"ammo_explosive",					function(pl) pl:GiveAmmo(3, "impactmine", true) end)
GM:AddPointShopItem("chemical",			ITEMCAT_AMMO,			9,				nil,							"화학 약품 20개",			nil,									"ammo_chemical",					function(pl) pl:GiveAmmo(20, "chemical", true) end)
item =
GM:AddPointShopItem("25mkit",			ITEMCAT_AMMO,			15,				nil,							"의약품 25개",			"메디킷으로 치료할 수 있는 의약품을 25개 더 줍니다.",	"ammo_medpower",					function(pl) pl:GiveAmmo(25, "Battery", true) end)
item.CanMakeFromScrap = true
item =
GM:AddPointShopItem("nail",				ITEMCAT_AMMO,			4,				nil,							"못",							"못 하나다.",					"ammo_nail",						function(pl) pl:GiveAmmo(1, "GaussEnergy", true) end)
item.NoClassicMode = true
item.CanMakeFromScrap = true
GM:AddPointShopItem("board",				ITEMCAT_AMMO,			9,				nil,							"판자",							"판자 하나다.",					"ammo_scrap",						function(pl) pl:GiveAmmo(1, "sniperround", true) end)
-- Tier 1
GM:AddPointShopItem("brassknuckles",	ITEMCAT_MELEE,			10,				"weapon_zs_brassknuckles").Model = "models/props_c17/utilityconnecter005.mdl"
GM:AddPointShopItem("knife",			ITEMCAT_MELEE,			10,				"weapon_zs_swissarmyknife")
GM:AddPointShopItem("zpplnk",			ITEMCAT_MELEE,			10,				"weapon_zs_plank")
GM:AddPointShopItem("axe",				ITEMCAT_MELEE,			15,				"weapon_zs_axe")
GM:AddPointShopItem("zpfryp",			ITEMCAT_MELEE,			15,				"weapon_zs_fryingpan")
GM:AddPointShopItem("zpcpot",			ITEMCAT_MELEE,			15,				"weapon_zs_pot")
GM:AddPointShopItem("ladel",			ITEMCAT_MELEE,			15,				"weapon_zs_ladel")
GM:AddPointShopItem("crowbar",			ITEMCAT_MELEE,			15,				"weapon_zs_crowbar")
GM:AddPointShopItem("pipe",				ITEMCAT_MELEE,			15,				"weapon_zs_pipe")
GM:AddPointShopItem("stunbaton",		ITEMCAT_MELEE,			15,				"weapon_zs_stunbaton")
GM:AddPointShopItem("hook",				ITEMCAT_MELEE,			15,				"weapon_zs_hook")
-- Tier 2
GM:AddPointShopItem("broom",			ITEMCAT_MELEE,			30,				"weapon_zs_pushbroom")
GM:AddPointShopItem("shovel",			ITEMCAT_MELEE,			30,				"weapon_zs_shovel")
GM:AddPointShopItem("sledgehammer",		ITEMCAT_MELEE,			30,				"weapon_zs_sledgehammer")
GM:AddPointShopItem("harpoon",			ITEMCAT_MELEE,			30,				"weapon_zs_harpoon")
GM:AddPointShopItem("butcherknf",		ITEMCAT_MELEE,			30,				"weapon_zs_butcherknife")
-- Tier 3
GM:AddPointShopItem("longsword",		ITEMCAT_MELEE,			60,				"weapon_zs_longsword")
GM:AddPointShopItem("executioner",		ITEMCAT_MELEE,			60,				"weapon_zs_executioner")
GM:AddPointShopItem("rebarmace",		ITEMCAT_MELEE,			60,				"weapon_zs_rebarmace")
GM:AddPointShopItem("meattenderizer",	ITEMCAT_MELEE,			60,				"weapon_zs_meattenderizer")
-- Tier 4
GM:AddPointShopItem("graveshvl",		ITEMCAT_MELEE,			100,			"weapon_zs_graveshovel")
GM:AddPointShopItem("kongol",			ITEMCAT_MELEE,			100,			"weapon_zs_kongolaxe")
GM:AddPointShopItem("scythe",			ITEMCAT_MELEE,			100,			"weapon_zs_scythe")
GM:AddPointShopItem("powerfists",		ITEMCAT_MELEE,			100,			"weapon_zs_powerfists")
-- Tier 5
GM:AddPointShopItem("frotchet",			ITEMCAT_MELEE,			150,			"weapon_zs_frotchet")

GM:AddPointShopItem("crphmr",			ITEMCAT_TOOLS,			25,				"weapon_zs_hammer",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_hammer") pl:GiveAmmo(5, "GaussEnergy") end)
GM:AddPointShopItem("wrench",			ITEMCAT_TOOLS,			20,				"weapon_zs_wrench").NoClassicMode = true
GM:AddPointShopItem("arsenalcrate",		ITEMCAT_DEPLOYABLES,			40,				"weapon_zs_arsenalcrate").Countables = "prop_arsenalcrate"
GM:AddPointShopItem("resupplybox",		ITEMCAT_DEPLOYABLES,			40,				"weapon_zs_resupplybox").Countables = "prop_resupplybox"
GM:AddPointShopItem("remantler",		ITEMCAT_DEPLOYABLES,			40,				"weapon_zs_remantler").Countables = "prop_remantler"
GM:AddPointShopItem("msgbeacon",		ITEMCAT_DEPLOYABLES,			10,				"weapon_zs_messagebeacon").Countables = "prop_messagebeacon"
GM:AddPointShopItem("camera",			ITEMCAT_DEPLOYABLES,			15,				"weapon_zs_camera").Countables = "prop_camera"
GM:AddPointShopItem("tv",				ITEMCAT_DEPLOYABLES,			25,				"weapon_zs_tv").Countables = "prop_tv"
item =
GM:AddPointShopItem("infturret",		ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_gunturret",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret") pl:GiveAmmo(1, "thumper") end)
item.NoClassicMode = true
item.Countables = "prop_gunturret"
item =
GM:AddPointShopItem("blastturret",		ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_gunturret_buckshot",	nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_buckshot") pl:GiveAmmo(1, "turret_buckshot") end)
item.Countables = "prop_gunturret_buckshot"
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_BLASTTURRET
item =
GM:AddPointShopItem("assaultturret",	ITEMCAT_DEPLOYABLES,			125,			"weapon_zs_gunturret_assault",	nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_assault") pl:GiveAmmo(1, "turret_assault") end)
item.NoClassicMode = true
item.Countables = "prop_gunturret_assault"
item =
GM:AddPointShopItem("rocketturret",		ITEMCAT_DEPLOYABLES,			125,			"weapon_zs_gunturret_rocket",	nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_rocket") pl:GiveAmmo(1, "turret_rocket") end)
item.Countables = "prop_gunturret_rocket"
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_ROCKETTURRET
GM:AddPointShopItem("manhack",			ITEMCAT_DEPLOYABLES,			30,				"weapon_zs_manhack").Countables = "prop_manhack"
item =
GM:AddPointShopItem("drone",			ITEMCAT_DEPLOYABLES,			40,				"weapon_zs_drone")
item.Countables = "prop_drone"
item =
GM:AddPointShopItem("pulsedrone",		ITEMCAT_DEPLOYABLES,			40,				"weapon_zs_drone_pulse")
item.Countables = "prop_drone_pulse"
item.SkillRequirement = SKILL_U_DRONE
item =
GM:AddPointShopItem("hauldrone",		ITEMCAT_DEPLOYABLES,			15,				"weapon_zs_drone_hauler")
item.Countables = "prop_drone_hauler"
item.SkillRequirement = SKILL_HAULMODULE
item =
GM:AddPointShopItem("rollermine",		ITEMCAT_DEPLOYABLES,			35,				"weapon_zs_rollermine")
item.Countables = "prop_rollermine"
item.SkillRequirement = SKILL_U_ROLLERMINE

item =
GM:AddPointShopItem("repairfield",		ITEMCAT_DEPLOYABLES,			55,				"weapon_zs_repairfield",		nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_repairfield") pl:GiveAmmo(1, "repairfield") pl:GiveAmmo(30, "pulse") end)
item.Countables = "prop_repairfield"
item.NoClassicMode = true
item =
GM:AddPointShopItem("zapper",			ITEMCAT_DEPLOYABLES,			50,				"weapon_zs_zapper",				nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_zapper") pl:GiveAmmo(1, "zapper") pl:GiveAmmo(30, "pulse") end)
item.Countables = "prop_zapper"
item.NoClassicMode = true
item =
GM:AddPointShopItem("zapper_arc",		ITEMCAT_DEPLOYABLES,			100,			"weapon_zs_zapper_arc",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_zapper_arc") pl:GiveAmmo(1, "zapper_arc") pl:GiveAmmo(30, "pulse") end)
item.Countables = "prop_zapper_arc"
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_ZAPPER_ARC
item =
GM:AddPointShopItem("ffemitter",		ITEMCAT_DEPLOYABLES,			40,				"weapon_zs_ffemitter",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_ffemitter") pl:GiveAmmo(1, "slam") pl:GiveAmmo(30, "pulse") end)
item.Countables = "prop_ffemitter"
GM:AddPointShopItem("propanetank",		ITEMCAT_TOOLS,			15,				"comp_propanecan")
GM:AddPointShopItem("busthead",			ITEMCAT_TOOLS,			25,				"comp_busthead")
GM:AddPointShopItem("sawblade",			ITEMCAT_TOOLS,			30,				"comp_sawblade").SkillRequirement = SKILL_U_CRAFTINGPACK
GM:AddPointShopItem("cpuparts",			ITEMCAT_TOOLS,			30,				"comp_cpuparts").SkillRequirement = SKILL_U_CRAFTINGPACK
GM:AddPointShopItem("electrobattery",	ITEMCAT_TOOLS,			40,				"comp_electrobattery").SkillRequirement = SKILL_U_CRAFTINGPACK
GM:AddPointShopItem("barricadekit",		ITEMCAT_DEPLOYABLES,	85,				"weapon_zs_barricadekit")
GM:AddPointShopItem("medkit",			ITEMCAT_TOOLS,			30,				"weapon_zs_medicalkit")
GM:AddPointShopItem("medgun",			ITEMCAT_TOOLS,			30,				"weapon_zs_medicgun")
item =
GM:AddPointShopItem("strengthshot",		ITEMCAT_TOOLS,			30,				"weapon_zs_strengthshot")
item.SkillRequirement = SKILL_U_STRENGTHSHOT
item =
GM:AddPointShopItem("antidote",			ITEMCAT_TOOLS,			30,				"weapon_zs_antidoteshot")
item.SkillRequirement = SKILL_U_ANTITODESHOT
GM:AddPointShopItem("medrifle",			ITEMCAT_TOOLS,			55,				"weapon_zs_medicrifle")
GM:AddPointShopItem("healray",			ITEMCAT_TOOLS,			125,			"weapon_zs_healingray")

-- Tier 1
GM:AddPointShopItem("cutlery",			ITEMCAT_TRINKETS,		10,				"trinket_cutlery").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("boxingtraining",	ITEMCAT_TRINKETS,		10,				"trinket_boxingtraining").SubCategory =							ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("hemoadrenali",		ITEMCAT_TRINKETS,		10,				"trinket_hemoadrenali").SubCategory =							ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("oxtank",			ITEMCAT_TRINKETS,		10,				"trinket_oxygentank").SubCategory =								ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("acrobatframe",		ITEMCAT_TRINKETS,		10,				"trinket_acrobatframe").SubCategory =							ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("portablehole",		ITEMCAT_TRINKETS,		10,				"trinket_portablehole").SubCategory =							ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("magnet",			ITEMCAT_TRINKETS,		10,				"trinket_magnet").SubCategory =									ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("targetingvisi",	ITEMCAT_TRINKETS,		10,				"trinket_targetingvisori").SubCategory =						ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("pulseampi",		ITEMCAT_TRINKETS,		10,				"trinket_pulseampi").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
-- Tier 2
GM:AddPointShopItem("momentumsupsysii",	ITEMCAT_TRINKETS,		15,				"trinket_momentumsupsysii").SubCategory =						ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("sharpkit",			ITEMCAT_TRINKETS,		15,				"trinket_sharpkit").SubCategory =								ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("nightvision",		ITEMCAT_TRINKETS,		15,				"trinket_nightvision").SubCategory =							ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("loadingframe",		ITEMCAT_TRINKETS,		15,				"trinket_loadingex").SubCategory =								ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("pathfinder",		ITEMCAT_TRINKETS,		15,				"trinket_pathfinder").SubCategory =								ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("ammovestii",		ITEMCAT_TRINKETS,		15,				"trinket_ammovestii").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("olympianframe",	ITEMCAT_TRINKETS,		15,				"trinket_olympianframe").SubCategory =							ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("autoreload",		ITEMCAT_TRINKETS,		15,				"trinket_autoreload").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("curbstompers",		ITEMCAT_TRINKETS,		15,				"trinket_curbstompers").SubCategory =							ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("vitpackagei",		ITEMCAT_TRINKETS,		15,				"trinket_vitpackagei").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("cardpackagei",		ITEMCAT_TRINKETS,		15,				"trinket_cardpackagei").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("forcedamp",		ITEMCAT_TRINKETS,		15,				"trinket_forcedamp").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("kevlar",			ITEMCAT_TRINKETS,		15,				"trinket_kevlar").SubCategory =									ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("antitoxinpack",	ITEMCAT_TRINKETS,		15,				"trinket_antitoxinpack").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("hemostasis",		ITEMCAT_TRINKETS,		15,				"trinket_hemostasis").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("bloodpack",		ITEMCAT_TRINKETS,		15,				"trinket_bloodpack").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("reactiveflasher",	ITEMCAT_TRINKETS,		15,				"trinket_reactiveflasher").SubCategory =						ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("iceburst",			ITEMCAT_TRINKETS,		15,				"trinket_iceburst").SubCategory =								ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("biocleanser",		ITEMCAT_TRINKETS,		15,				"trinket_biocleanser").SubCategory =							ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("necrosense",		ITEMCAT_TRINKETS,		15,				"trinket_necrosense").SubCategory =								ITEMSUBCAT_TRINKETS_SPECIAL
GM:AddPointShopItem("blueprintsi",		ITEMCAT_TRINKETS,		15,				"trinket_blueprintsi").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("processor",		ITEMCAT_TRINKETS,		15,				"trinket_processor").SubCategory =								ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("acqmanifest",		ITEMCAT_TRINKETS,		15,				"trinket_acqmanifest").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("mainsuite",		ITEMCAT_TRINKETS,		15,				"trinket_mainsuite").SubCategory =								ITEMSUBCAT_TRINKETS_SUPPORT
-- Tier 3
--GM:AddPointShopItem("climbinggear",	ITEMCAT_TRINKETS,		30,				"trinket_climbinggear").SubCategory =							ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("reachem",			ITEMCAT_TRINKETS,		30,				"trinket_reachem").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("momentumsupsysiii",ITEMCAT_TRINKETS,		30,				"trinket_momentumsupsysiii").SubCategory =						ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("powergauntlet",	ITEMCAT_TRINKETS,		30,				"trinket_powergauntlet").SubCategory =							ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("hemoadrenalii",	ITEMCAT_TRINKETS,		30,				"trinket_hemoadrenalii").SubCategory =							ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("sharpstone",		ITEMCAT_TRINKETS,		30,				"trinket_sharpstone").SubCategory =								ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("analgestic",		ITEMCAT_TRINKETS,		30,				"trinket_analgestic").SubCategory =								ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("feathfallframe",	ITEMCAT_TRINKETS,		30,				"trinket_featherfallframe").SubCategory =						ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("aimcomp",			ITEMCAT_TRINKETS,		30,				"trinket_aimcomp").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("pulseampii",		ITEMCAT_TRINKETS,		30,				"trinket_pulseampii").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("extendedmag",		ITEMCAT_TRINKETS,		30,				"trinket_extendedmag").SubCategory =							ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("vitpackageii",		ITEMCAT_TRINKETS,		30,				"trinket_vitpackageii").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("cardpackageii",	ITEMCAT_TRINKETS,		30,				"trinket_cardpackageii").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("regenimplant",		ITEMCAT_TRINKETS,		30,				"trinket_regenimplant").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("barbedarmor",		ITEMCAT_TRINKETS,		30,				"trinket_barbedarmor").SubCategory =							ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("blueprintsii",		ITEMCAT_TRINKETS,		30,				"trinket_blueprintsii").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("curativeii",		ITEMCAT_TRINKETS,		30,				"trinket_curativeii").SubCategory =								ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("remedy",			ITEMCAT_TRINKETS,		30,				"trinket_remedy").SubCategory =									ITEMSUBCAT_TRINKETS_SUPPORT
-- Tier 4
GM:AddPointShopItem("hemoadrenaliii",	ITEMCAT_TRINKETS,		50,				"trinket_hemoadrenaliii").SubCategory =							ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("ammoband",			ITEMCAT_TRINKETS,		50,				"trinket_ammovestiii").SubCategory =							ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("resonance",		ITEMCAT_TRINKETS,		50,				"trinket_resonance").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("cryoindu",			ITEMCAT_TRINKETS,		50,				"trinket_cryoindu").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("refinedsub",		ITEMCAT_TRINKETS,		50,				"trinket_refinedsub").SubCategory =								ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("targetingvisiii",	ITEMCAT_TRINKETS,		50,				"trinket_targetingvisoriii").SubCategory =						ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("eodvest",			ITEMCAT_TRINKETS,		50,				"trinket_eodvest").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("composite",		ITEMCAT_TRINKETS,		50,				"trinket_composite").SubCategory =								ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("arsenalpack",		ITEMCAT_TRINKETS,		50,				"trinket_arsenalpack").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("resupplypack",		ITEMCAT_TRINKETS,		50,				"trinket_resupplypack").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("promanifest",		ITEMCAT_TRINKETS,		50,				"trinket_promanifest").SubCategory =							ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("opsmatrix",		ITEMCAT_TRINKETS,		50,				"trinket_opsmatrix").SubCategory =								ITEMSUBCAT_TRINKETS_SUPPORT
-- Tier 5
GM:AddPointShopItem("supasm",			ITEMCAT_TRINKETS,		70,				"trinket_supasm").SubCategory =									ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("pulseimpedance",	ITEMCAT_TRINKETS,		70,				"trinket_pulseimpedance").SubCategory =							ITEMSUBCAT_TRINKETS_OFFENSIVE

GM:AddPointShopItem("flashbomb",		ITEMCAT_OTHER,			25,				"weapon_zs_flashbomb")
GM:AddPointShopItem("molotov",			ITEMCAT_OTHER,			30,				"weapon_zs_molotov")
GM:AddPointShopItem("grenade",			ITEMCAT_OTHER,			35,				"weapon_zs_grenade")
GM:AddPointShopItem("betty",			ITEMCAT_OTHER,			35,				"weapon_zs_proxymine")
GM:AddPointShopItem("detpck",			ITEMCAT_OTHER,			40,				"weapon_zs_detpack")
item =
GM:AddPointShopItem("crygasgrenade",	ITEMCAT_OTHER,			40,				"weapon_zs_crygasgrenade")
item.SkillRequirement = SKILL_U_CRYGASGREN
GM:AddPointShopItem("corgasgrenade",	ITEMCAT_OTHER,			45,				"weapon_zs_corgasgrenade")
GM:AddPointShopItem("sigfragment",		ITEMCAT_OTHER,			30,				"weapon_zs_sigilfragment")
GM:AddPointShopItem("bloodshot",		ITEMCAT_OTHER,			45,				"weapon_zs_bloodshotbomb")
item =
GM:AddPointShopItem("corruptedfragment",ITEMCAT_OTHER,			55,				"weapon_zs_corruptedfragment")
item.NoClassicMode = true
item.SkillRequirement = SKILL_U_CORRUPTEDFRAGMENT
item =
GM:AddPointShopItem("medcloud",			ITEMCAT_OTHER,			40,				"weapon_zs_mediccloudbomb")
item.SkillRequirement = SKILL_U_MEDICCLOUD
item =
GM:AddPointShopItem("nanitecloud",		ITEMCAT_OTHER,			40,				"weapon_zs_nanitecloudbomb")
item.SkillRequirement = SKILL_U_NANITECLOUD

-- These are the honorable mentions that come at the end of the round.

local function genericcallback(pl, magnitude) return pl:Name(), magnitude end
GM.HonorableMentions = {}
GM.HonorableMentions[HM_MOSTZOMBIESKILLED] = {Name = "좀비 학살자", String = "플레이어 %s님에 의해 %d마리의 좀비가 살해되었다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_MOSTDAMAGETOUNDEAD] = {Name = "좀비 폭력", String = "플레이어 %s님이 좀비에게 총합 %d 데미지를 가했다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_MOSTHEADSHOTS] = {Name = "헤드슈터", String = "플레이어 %님이 헤드샷으로 좀비를 %s마리 죽였다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_PACIFIST] = {Name = "평화주의자", String = "플레이어 %s님은 구조될 때까지 단 한 마리의 좀비도 죽이지 않았다!", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_MOSTHELPFUL] = {Name = "뛰어난 서포터", String = "플레이어 %s님이 %d마리의 좀비 처치를 도왔다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_LASTHUMAN] = {Name = "Last-Stand", String = "플레이어 %s님이 최후의 생존자이다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_OUTLANDER] = {Name = "도망자", String = "플레이어 %s님은 좀비 스폰 지점에서 %d피트나 떨어진 장소에서 살해당했다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_GOODDOCTOR] = {Name = "진정한 의느님", String = "플레이어 %s님이 아군의 체력을 %d 회복시켰다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_HANDYMAN] = {Name = "숭고한 공밀레", String = "플레이어 %s님이 바리케이드의 내구도를 총합 %d 회복시켰다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_SCARECROW] = {Name = "죄 없는 까마귀", String = "플레이어 %s님이 까마귀 %d마리를 무참히 살해했다.", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_MOSTBRAINSEATEN] = {Name = "인간 학살자", String = "BJ %s님의 인간 뇌 먹방! 오늘은 %d명의 뇌를 먹어치워보겠습니다!", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_MOSTDAMAGETOHUMANS] = {Name = "너 나한테 시비 걸었냐?", String = "플레이어 %s님이 시비를 거는 인간들에게 %d 데미지로 응징했다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_LASTBITE] = {Name = "심판자", String = "플레이어 %s님이 최후의 인간을 먹어치웠다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_USEFULTOOPPOSITE] = {Name = "TROLOLOLOL", String = "플레이어 %s님이 %d킬을 포기해버렸다!", Callback = genericcallback, Color = COLOR_RED}
GM.HonorableMentions[HM_STUPID] = {Name = "똥멍청이", String = "플레이어 %s님은 좀비 스폰 지점에서 겨우 %d피트 떨어진 곳에서 살해당했다.", Callback = genericcallback, Color = COLOR_RED}
GM.HonorableMentions[HM_SALESMAN] = {Name = "스티븐 잡스", String = "플레이어 %s님이 상점 상자로 무려 %d포인트를 벌어들였다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_WAREHOUSE] = {Name = "살아있는 보급창고", String = "플레이어 %s님의 보급창고가 아군에게 %d회 탄약을 지급했다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_DEFENCEDMG] = {Name = "디펜더", String = "플레이어 %s님이 인간들에게 방어 버프를 주어 %d의 데미지로부터 지켜주었다.", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_STRENGTHDMG] = {Name = "연금술사", String = "플레이어 %s님이 데미지 버프를 주어 %d의 데미지를 추가로 더 주게 하였다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_BARRICADEDESTROYER] = {Name = "바리케이드 디스트로이어", String = "플레이어 %s님이 바리케이드에 총합 %d 데미지를 가했다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_NESTDESTROYER] = {Name = "네스트 디스트로이어", String = "플레이어 %s님이 %d개의 둥지를 흔적도 없이 날려버렸다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_NESTMASTER] = {Name = "네스트 마스터", String = "플레이어 %s님이 %d마리의 좀비를 자신의 둥지에서 부활시켰다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}

-- 인간팀이 사용하지 못하게 하는 플레이어모델 목록
GM.RestrictedModels = {
	"models/player/zombie_classic.mdl",
	"models/player/zombie_classic_hbfix.mdl",
	"models/player/zombine.mdl",
	"models/player/zombie_soldier.mdl",
	"models/player/zombie_fast.mdl",
	"models/player/corpse1.mdl",
	"models/player/charple.mdl",
	"models/player/skeleton.mdl",
	"models/player/combine_soldier_prisonguard.mdl",
	"models/player/soldier_stripped.mdl",
	"models/player/zelpa/stalker.mdl",
	"models/player/fatty/fatty.mdl",
	"models/player/zombie_lacerator2.mdl",
	"models/jazzmcfly/wrs/wrs.mdl",
	"models/jazzmcfly/brs/brs.mdl",
	"models/jazzmcfly/ibrs/ibrs.mdl"
}

-- If a person has no player model then use one of these (auto-generated).
GM.RandomPlayerModels = {}
for name, mdl in pairs(player_manager.AllValidModels()) do
	if not table.HasValue(GM.RestrictedModels, string.lower(mdl)) then
		table.insert(GM.RandomPlayerModels, name)
	end
end

GM.DeployableInfo = {}
function GM:AddDeployableInfo(class, name, wepclass)
	local tab = {Class = class, Name = name or "?", WepClass = wepclass}

	self.DeployableInfo[#self.DeployableInfo + 1] = tab
	self.DeployableInfo[class] = tab

	return tab
end
GM:AddDeployableInfo("prop_arsenalcrate", 		"상점 상자", 		"weapon_zs_arsenalcrate")
GM:AddDeployableInfo("prop_resupplybox", 		"보급 상자", 		"weapon_zs_resupplybox")
GM:AddDeployableInfo("prop_remantler", 			"무기 정제기", 	"weapon_zs_remantler")
GM:AddDeployableInfo("prop_messagebeacon", 		"메세지 비콘", 		"weapon_zs_messagebeacon")
GM:AddDeployableInfo("prop_camera", 			"카메라",	 			"weapon_zs_camera")
GM:AddDeployableInfo("prop_gunturret", 			"적외선 레이저 터렛",	 		"weapon_zs_gunturret")
GM:AddDeployableInfo("prop_gunturret_assault", 	"어썰트 터렛",	 	"weapon_zs_gunturret_assault")
GM:AddDeployableInfo("prop_gunturret_buckshot",	"샷건 터렛",	 		"weapon_zs_gunturret_buckshot")
GM:AddDeployableInfo("prop_gunturret_rocket",	"로켓 터렛",	 	"weapon_zs_gunturret_rocket")
GM:AddDeployableInfo("prop_repairfield",		"수리 장치",	"weapon_zs_repairfield")
GM:AddDeployableInfo("prop_zapper",				"코일",				"weapon_zs_zapper")
GM:AddDeployableInfo("prop_zapper_arc",			"아크 코일",			"weapon_zs_zapper_arc")
GM:AddDeployableInfo("prop_ffemitter",			"방어막 전개 장치",	"weapon_zs_ffemitter")
GM:AddDeployableInfo("prop_manhack",			"맨핵",				"weapon_zs_manhack")
GM:AddDeployableInfo("prop_manhack_saw",		"톱날 맨핵",		"weapon_zs_manhack_saw")
GM:AddDeployableInfo("prop_drone",				"드론",				"weapon_zs_drone")
GM:AddDeployableInfo("prop_drone_pulse",		"펄스 드론",			"weapon_zs_drone_pulse")
GM:AddDeployableInfo("prop_drone_hauler",		"운반 드론",			"weapon_zs_drone_hauler")
GM:AddDeployableInfo("prop_rollermine",			"롤러마인",			"weapon_zs_rollermine")


GM.MaxSigils = 3

GM.DefaultRedeem = math.ceil(4--[[희생양 추가값]] + CreateConVar("zs_redeem", "4", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "구원하기 위한 희생양의 수"):GetInt())
cvars.AddChangeCallback("zs_redeem", function(cvar, oldvalue, newvalue)
	GAMEMODE.DefaultRedeem = math.max(0, tonumber(newvalue) or 0)
end)

GM.WaveOneZombies = 0.15--math.Round(CreateConVar("zs_waveonezombies", "0.1", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "The percentage of players that will start as zombies when the game begins."):GetFloat(), 2)
-- cvars.AddChangeCallback("zs_waveonezombies", function(cvar, oldvalue, newvalue)
-- 	GAMEMODE.WaveOneZombies = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
-- end)

GM.NumberOfWaves = math.ceil(2--[[라운드 조정]] + CreateConVar("zs_numberofwaves", "6", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "한 게임당 라운드 횟수."):GetInt())
cvars.AddChangeCallback("zs_numberofwaves", function(cvar, oldvalue, newvalue)
	GAMEMODE.NumberOfWaves = tonumber(newvalue) or 1
end)

-- Game feeling too easy? Just change these values!
GM.ZombieSpeedMultiplier = math.Round(CreateConVar("zs_zombiespeedmultiplier", "1", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Zombie running speed will be scaled by this value."):GetFloat(), 2)
cvars.AddChangeCallback("zs_zombiespeedmultiplier", function(cvar, oldvalue, newvalue)
	GAMEMODE.ZombieSpeedMultiplier = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
end)

-- 좀비의 저항력이며 0.5는 받는 피해의 반을, 0.25는 받는 피해의 1/4를 차지한다.
GM.ZombieDamageMultiplier = math.Round(CreateConVar("zs_zombiedamagemultiplier", "1", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Scales the amount of damage that zombies take. Use higher values for easy zombies, lower for harder."):GetFloat(), 2)
cvars.AddChangeCallback("zs_zombiedamagemultiplier", function(cvar, oldvalue, newvalue)
	GAMEMODE.ZombieDamageMultiplier = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
end)

GM.TimeLimit = CreateConVar("zs_timelimit", "15", FCVAR_ARCHIVE + FCVAR_NOTIFY, "Time in minutes before the game will change maps. It will not change maps if a round is currently in progress but after the current round ends. -1 means never switch maps. 0 means always switch maps."):GetInt() * 60
cvars.AddChangeCallback("zs_timelimit", function(cvar, oldvalue, newvalue)
	GAMEMODE.TimeLimit = tonumber(newvalue) or 15
	if GAMEMODE.TimeLimit ~= -1 then
		GAMEMODE.TimeLimit = GAMEMODE.TimeLimit * 60
	end
end)

GM.RoundLimit = CreateConVar("zs_roundlimit", "3", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How many times the game can be played on the same map. -1 means infinite or only use time limit. 0 means once."):GetInt()
cvars.AddChangeCallback("zs_roundlimit", function(cvar, oldvalue, newvalue)
	GAMEMODE.RoundLimit = tonumber(newvalue) or 3
end)

-- Static values that don't need convars...

-- 첫 웨이브 시간
GM.WaveOneLength = 220

-- 다음 웨이브마다 시간 증가
GM.TimeAddedPerWave = 15

-- New players are put on the zombie team if the current wave is this or higher. Do not put it lower than 1 or you'll break the game.
GM.NoNewHumansWave = 2

-- 이 웨이브 이하는 자살불가
GM.NoSuicideWave = 1

-- 게임 시작하기까지 앞으로 남은 시간
GM.WaveZeroLength = 185		-- 150

-- 쉬는 시간
GM.WaveIntermissionLength = 90		-- 60

-- 최종으로 라운드 끝나고 다음 맵으로 체인지하는데 걸리는 시간
GM.EndGameTime = 30		--45

-- 처음 얻는 무기에 지급되는 탄약(해당 탄창의 배수로 지급)
GM.SurvivalClips = 10 --2

-- How long do humans have to wait before being able to get more ammo from a resupply box?
GM.ResupplyBoxCooldown = 60

-- Put your unoriginal, 5MB Rob Zombie and Metallica music here.
GM.LastHumanSound = Sound("zombiesurvival/lasthuman.ogg")

-- 인간이 모두 죽엇을때의 브금
GM.AllLoseSound = Sound("zombiesurvival/music_lose.ogg")

-- 인간이 승리했을 때의 브금
GM.HumanWinSound = Sound("zombiesurvival/music_win.ogg")

-- Sound played to a person when they die as a human.
GM.DeathSound = Sound("zombiesurvival/human_death_stinger.ogg")

-- Fetch map profiles and node profiles from noxiousnet database?
GM.UseOnlineProfiles = true

-- This multiplier of points will save over to the next round. 1 is full saving. 0 is disabled.
-- Setting this to 0 will not delete saved points and saved points do not "decay" if this is less than 1.
GM.PointSaving = 0

-- Lock item purchases to waves. Tier 2 items can only be purchased on wave 2, tier 3 on wave 3, etc.
-- HIGHLY suggested that this is on if you enable point saving. Always false if objective map, zombie escape, classic mode, or wave number is changed by the map.
GM.LockItemTiers = false

-- Don't save more than this amount of points. 0 for infinite.
GM.PointSavingLimit = 0		--0

-- For Classic Mode
GM.WaveIntermissionLengthClassic = 20
GM.WaveOneLengthClassic = 120
GM.TimeAddedPerWaveClassic = 10

-- Max amount of damage left to tick on these. Any more pending damage is ignored.
GM.MaxPoisonDamage = 50
GM.MaxBleedDamage = 50

-- 인간이 라운드에서 끝날시 얻게 될 점수
GM.EndWavePointsBonus = 8		-- 5

-- 매 라운드 마다 얻는 점수 증가
GM.EndWavePointsBonusPerWave = 1
