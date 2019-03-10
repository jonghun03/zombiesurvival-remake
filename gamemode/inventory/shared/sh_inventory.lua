INVCAT_TRINKETS = 1
INVCAT_COMPONENTS = 2
INVCAT_CONSUMABLES = 3

GM.ZSInventoryItemData = {}
GM.ZSInventoryCategories = {
	[INVCAT_TRINKETS] = "Trinkets",
	[INVCAT_COMPONENTS] = "Components",
	[INVCAT_CONSUMABLES] = "Consumables"
}
GM.ZSInventoryPrefix = {
	[INVCAT_TRINKETS] = "trin",
	[INVCAT_COMPONENTS] = "comp",
	[INVCAT_CONSUMABLES] = "cons"
}

GM.Assemblies = {}
GM.Breakdowns = {}

function GM:GetInventoryItemType(item)
	for typ, aff in pairs(self.ZSInventoryPrefix) do
		if string.sub(item, 1, 4) == aff then
			return typ
		end
	end

	return -1
end

local index = 1
function GM:AddInventoryItemData(intname, name, description, weles, tier, stocks)
	local datatab = {PrintName = name, DroppedEles = weles, Tier = tier, Description = description, Stocks = stocks, Index = index}
	self.ZSInventoryItemData[intname] = datatab
	self.ZSInventoryItemData[index] = datatab

	index = index + 1
end


function GM:AddWeaponBreakdownRecipe(weapon, result)
	local datatab = {Result = result, Index = index}
	self.Breakdowns[weapon] = datatab
	for i = 1, 3 do
		self.Breakdowns[self:GetWeaponClassOfQuality(weapon, i)] = datatab
		self.Breakdowns[self:GetWeaponClassOfQuality(weapon, i, 1)] = datatab
	end

	self.Breakdowns[#self.Breakdowns + 1] = datatab
end

GM:AddWeaponBreakdownRecipe("weapon_zs_stubber",							"comp_modbarrel")
GM:AddWeaponBreakdownRecipe("weapon_zs_z9000",								"comp_basicecore")
GM:AddWeaponBreakdownRecipe("weapon_zs_blaster",							"comp_pumpaction")
GM:AddWeaponBreakdownRecipe("weapon_zs_novablaster",						"comp_contaecore")
GM:AddWeaponBreakdownRecipe("weapon_zs_waraxe", 							"comp_focusbarrel")
GM:AddWeaponBreakdownRecipe("weapon_zs_innervator",							"comp_gaussframe")
GM:AddWeaponBreakdownRecipe("weapon_zs_swissarmyknife",						"comp_shortblade")
GM:AddWeaponBreakdownRecipe("weapon_zs_owens",								"comp_multibarrel")
GM:AddWeaponBreakdownRecipe("weapon_zs_onyx",								"comp_precision")
GM:AddWeaponBreakdownRecipe("weapon_zs_minelayer",							"comp_launcher")
GM:AddWeaponBreakdownRecipe("weapon_zs_fracture",							"comp_linearactuator")
GM:AddWeaponBreakdownRecipe("weapon_zs_harpoon",							"comp_metalpole")

-- Assemblies (Assembly, Component, Weapon)
GM.Assemblies["weapon_zs_waraxe"] 								= {"comp_modbarrel", 		"weapon_zs_glock3"}
GM.Assemblies["weapon_zs_bust"] 								= {"comp_busthead", 		"weapon_zs_plank"}
GM.Assemblies["weapon_zs_sawhack"] 								= {"comp_sawblade", 		"weapon_zs_axe"}
GM.Assemblies["weapon_zs_manhack_saw"] 							= {"comp_sawblade", 		"weapon_zs_manhack"}
GM.Assemblies["weapon_zs_megamasher"] 							= {"comp_propanecan", 		"weapon_zs_sledgehammer"}
GM.Assemblies["weapon_zs_electrohammer"] 						= {"comp_electrobattery",	"weapon_zs_hammer"}
GM.Assemblies["weapon_zs_novablaster"] 							= {"comp_basicecore",		"weapon_zs_magnum"}
GM.Assemblies["weapon_zs_tithonus"] 							= {"comp_contaecore",		"weapon_zs_oberon"}
GM.Assemblies["weapon_zs_fracture"] 							= {"comp_pumpaction",		"weapon_zs_sawedoff"}
GM.Assemblies["weapon_zs_seditionist"] 							= {"comp_focusbarrel",		"weapon_zs_deagle"}
GM.Assemblies["weapon_zs_molotov"] 								= {"comp_propanecan",		"weapon_zs_glassbottle"}
GM.Assemblies["weapon_zs_blareduct"] 							= {"trinket_ammovestii",	"weapon_zs_pipe"}
GM.Assemblies["weapon_zs_cinderrod"] 							= {"comp_propanecan",		"weapon_zs_blareduct"}
GM.Assemblies["weapon_zs_innervator"] 							= {"comp_electrobattery",	"weapon_zs_jackhammer"}
GM.Assemblies["weapon_zs_hephaestus"] 							= {"comp_gaussframe",		"weapon_zs_tithonus"}
GM.Assemblies["weapon_zs_stabber"] 								= {"comp_shortblade",		"weapon_zs_annabelle"}
GM.Assemblies["weapon_zs_galestorm"] 							= {"comp_multibarrel",		"weapon_zs_uzi"}
GM.Assemblies["weapon_zs_eminence"] 							= {"trinket_ammovestiii",	"weapon_zs_barrage"}
GM.Assemblies["weapon_zs_gladiator"] 							= {"trinket_ammovestiii",	"weapon_zs_sweepershotgun"}
GM.Assemblies["weapon_zs_ripper"]								= {"comp_sawblade",			"weapon_zs_zeus"}
GM.Assemblies["weapon_zs_avelyn"]								= {"trinket_ammovestiii",	"weapon_zs_charon"}
GM.Assemblies["weapon_zs_asmd"]									= {"comp_precision",		"weapon_zs_quasar"}
GM.Assemblies["weapon_zs_enkindler"]							= {"comp_launcher",			"weapon_zs_cinderrod"}
GM.Assemblies["weapon_zs_proliferator"]							= {"comp_linearactuator",	"weapon_zs_galestorm"}
GM.Assemblies["trinket_electromagnet"]							= {"comp_electrobattery",	"trinket_magnet"}
GM.Assemblies["trinket_projguide"]								= {"comp_cpuparts",			"trinket_targetingvisori"}
GM.Assemblies["trinket_projwei"]								= {"comp_busthead",			"trinket_projguide"}
GM.Assemblies["trinket_controlplat"]							= {"comp_cpuparts",			"trinket_mainsuite"}

GM:AddInventoryItemData("comp_modbarrel",		"모듈러 배럴",			"다른 총 배럴과 함께 사용하는 데 적합한 모듈식 배럴",								"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_burstmech",		"점사 원리",		"점사를 할 수 있게 개조하는 방법이 들어가 있다.",										"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_basicecore",		"평범한 에너지 코어",		"에너지 출력을 감당할 실린더 메커니즘이 있는 무기가 필요하다.",	"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_busthead",		"흉상",				"잡을 수 있는 것에 장착할 수 있을 것 같다.",								"models/props_combine/breenbust.mdl")
GM:AddInventoryItemData("comp_sawblade",		"톱날",				"빠르게 움직이는 물체에 장착할 수 있는 날카로운 톱날",								"models/props_junk/sawblade001a.mdl")
GM:AddInventoryItemData("comp_propanecan",		"프로판 가스",			"물체를 점화할 가능성이 있다.",				"models/props_junk/propane_tank001a.mdl")
GM:AddInventoryItemData("comp_electrobattery",	"배터리",			"수리하는 것을 개선하는 데 사용할 수 있을 것 같다.",								"models/items/car_battery01.mdl")
--GM:AddInventoryItemData("comp_hungrytether",	"Hungry Tether",			"A hungry tether from a devourer that comes from a devourer rib.",								"models/gibs/HGIBS_rib.mdl")]]
GM:AddInventoryItemData("comp_contaecore",		"압축된 에너지 코어",	"차지(충전) 메커니즘이 들어가 있다.",							"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_pumpaction",		"펌프 작용 원리",	"블래스터 샷건을 분해하여 얻은 펌프 액션 매커니즘",										"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_focusbarrel",		"밀집된 배럴",			"워엑스의 통으로 만들어진 큰 밀집된 배럴. 손대포에 적합하다.",		"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_gaussframe",		"가우스 프레임",				"고도의 기술이 들어간 가우스 프레임. 외계인이 디자인 한 것 같다.",			"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_metalpole",		"금속 막대",				"멀리서 물체를 공격하는 데 사용될 수 있는 긴 금속 막대기",							"models/props_c17/signpole001.mdl")
GM:AddInventoryItemData("comp_salleather",		"재사용 가죽",			"끔찍한 충격을 줄 정도로 단단한 가죽 조각",								"models/props_junk/shoe001.mdl")
GM:AddInventoryItemData("comp_gyroscope",		"자이로스코프",				"방향을 계산하는 데 사용되는 금속 자이로 스코프",												"models/maxofs2d/hover_rings.mdl")
GM:AddInventoryItemData("comp_reciever",		"수신기",					"라디오 수신기. 자동화 및 통신 목적으로 사용할 수 있다.",					"models/props_lab/reciever01b.mdl")
GM:AddInventoryItemData("comp_cpuparts",		"CPU 부품",				"중앙 처리 장치의 부품",																"models/props_lab/harddrive01.mdl")
GM:AddInventoryItemData("comp_launcher",		"런칭 튜브",			"물체를 발사하기 위해 만들어진 금속 튜브",															"models/weapons/w_rocket_launcher.mdl")
GM:AddInventoryItemData("comp_launcherh",		"헤비 런칭 튭,",		"무거운 물체를 발사하기 위해 만들어진 무거운 금속 튜브",												"models/weapons/w_rocket_launcher.mdl")
GM:AddInventoryItemData("comp_shortblade",		"짧은 날",				"찌르거나 자르기 위한 짧은 금속 날",												"models/weapons/w_knife_t.mdl")
GM:AddInventoryItemData("comp_multibarrel",		"다층 배럴",		"여러 발의 총알이 들어갈 수 있는 흔치 않은 배럴",							"models/props_lab/pipesystem03a.mdl")
GM:AddInventoryItemData("comp_holoscope",		"홀로그램 조준경",		"배율이 있는 홀로그램 조준경",												{
	["base"] = { type = "Model", model = "models/props_c17/utilityconnecter005.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.273, 1.728, -0.843), angle = Angle(74.583, 180, 0), size = Vector(2.207, 0.105, 0.316), color = Color(50, 50, 66, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_combine/tprotato1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.492, -1.03, 0), angle = Angle(0, -78.715, 90), size = Vector(0.03, 0.02, 0.032), color = Color(50, 50, 66, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} }
})
GM:AddInventoryItemData("comp_linearactuator",	"선형 액추에이터",			"셸 홀더에서 나오는 선형 액추에이터. 무거운 베이스가 올바르게 장착되어야 한다.",				"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_pulsespool",		"펄스 스풀",				"시스템에 더 많은 펄스 전력을 주입하는 데 사용된다. 무언가를 안정시키는 데 사용할 수 있다.",			"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_flak",			"플랙 챔버",				"가열된 고철을 투영하기 위한 내부 챔버",												"models/weapons/w_rocket_launcher.mdl")
GM:AddInventoryItemData("comp_precision",		"정밀 섀시",		"움직이는 대상을 정밀하게 사격하기 위한 설청.",									"models/Items/combine_rifle_cartridge01.mdl")

-- Trinkets
local trinket, description, trinketwep
local hpveles = {
	["ammo"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 3.5, 3), angle = Angle(15.194, 80.649, 180), size = Vector(0.6, 0.6, 1.2), color = Color(145, 132, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local hpweles = {
	["ammo"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.5, 2.5, 3), angle = Angle(15.194, 80.649, 180), size = Vector(0.6, 0.6, 1.2), color = Color(145, 132, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local ammoveles = {
	["ammo"] = { type = "Model", model = "models/props/de_prodigy/ammo_can_02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 3, -0.519), angle = Angle(0, 85.324, 101.688), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local ammoweles = {
	["ammo"] = { type = "Model", model = "models/props/de_prodigy/ammo_can_02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 2, -1.558), angle = Angle(5.843, 82.986, 111.039), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local mveles = {
	["band++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(2.599, 1, 1), angle = Angle(0, -25, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 3, -1), angle = Angle(97.013, 29.221, 0), size = Vector(0.045, 0.045, 0.025), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(-2.401, -1, 0.5), angle = Angle(0, 155.455, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} }
}
local mweles = {
	["band++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(2.599, 1, 1), angle = Angle(0, -25, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(-2.401, -1, 0.5), angle = Angle(0, 155.455, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.5, 2, -0.5), angle = Angle(111.039, -92.338, 97.013), size = Vector(0.045, 0.045, 0.025), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} }
}
local pveles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.557, -2.597), angle = Angle(5.843, 90, 0), size = Vector(0.25, 0.15, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local pweles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 0.5, -2), angle = Angle(5, 90, 0), size = Vector(0.25, 0.15, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local oveles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.799, 2, -1.5), angle = Angle(5, 180, 0), size = Vector(0.05, 0.039, 0.07), color = Color(196, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local oweles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.799, 2, -1.5), angle = Angle(5, 180, 0), size = Vector(0.05, 0.039, 0.07), color = Color(196, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local develes = {
	["perf"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.799, 2.5, -5.715), angle = Angle(5, 180, 0), size = Vector(0.1, 0.039, 0.09), color = Color(168, 155, 0, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal", skin = 0, bodygroup = {} }
}
local deweles = {
	["perf"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 2, -5.715), angle = Angle(0, 180, 0), size = Vector(0.1, 0.039, 0.09), color = Color(168, 155, 0, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal", skin = 0, bodygroup = {} }
}
local supveles = {
	["perf"] = { type = "Model", model = "models/props_lab/reciever01c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.299, 2.5, -2), angle = Angle(5, 180, 92.337), size = Vector(0.2, 0.699, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local supweles = {
	["perf"] = { type = "Model", model = "models/props_lab/reciever01c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.5, -2), angle = Angle(5, 180, 92.337), size = Vector(0.2, 0.699, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- Health Trinkets
trinket, trinketwep = GM:AddTrinket("건강용품", "vitpackagei", false, hpveles, hpweles, 2, "최대 체력 +10\n받는 회복량 +5%")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 10)
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 0.05)
trinketwep.PermitDismantle = true

trinket = GM:AddTrinket("활력소", "vitpackageii", false, hpveles, hpweles, 4, "최대 체력 +21\n받는 회복량 +6%")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 21)
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 0.06)

trinket, trinketwep = GM:AddTrinket("수혈 팩", "bloodpack", false, hpveles, hpweles, 2, "체력이 50% 이하일 경우 혈갑을 20만큼 재생\n활성화 시 소모됨", nil, 15)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("혈액 패키지", "cardpackagei", false, hpveles, hpweles, 2, "최대 혈갑량 +10")
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 10)
trinketwep.PermitDismantle = true

GM:AddSkillModifier(GM:AddTrinket("혈액 은행", "cardpackageii", false, hpveles, hpweles, 4, "최대 혈갑량 +30"), SKILLMOD_BLOODARMOR, 30)

GM:AddTrinket("재생", "regenimplant", false, hpveles, hpweles, 3, "최근에 데미지를 받지 않았을 경우 12초에 1씩 체력 재생")

trinket, trinketwep = GM:AddTrinket("바이오 클렌저", "biocleanser", false, hpveles, hpweles, 2, "20초에 한 번씩 유해한 상태를 막아줌")
trinketwep.PermitDismantle = true

GM:AddSkillModifier(GM:AddTrinket("식기 세트", "cutlery", false, hpveles, hpweles, nil, "음식 섭취 시간 -80%"), SKILLMOD_FOODEATTIME_MUL, -0.8)

-- Melee Trinkets

description = "주먹으로 공격을 5대 적중 시, 팔과 다리에 치명상을 입힘\n공격한 다음 비무장 공격력 -15%"
trinket = GM:AddTrinket("복싱 훈련 설명서", "boxingtraining", false, mveles, mweles, nil, description)
GM:AddSkillModifier(trinket, SKILLMOD_UNARMED_SWING_DELAY_MUL, -0.15)
GM:AddSkillFunction(trinket, function(pl, active) pl.BoxingTraining = active end)

trinket, trinketwep = GM:AddTrinket("탄력 증진", "momentumsupsysii", false, mveles, mweles, 2, "근접 무기 공격속도 +13%\n근접 무기 넉백 +10%")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.13)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_KNOCKBACK_MUL, 0.1)
trinketwep.PermitDismantle = true

trinket = GM:AddTrinket("탄력 증진 II", "momentumsupsysiii", false, mveles, mweles, 3, "근접 무기 공격속도 +20%\n접 무기 넉백 +12%")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.20)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_KNOCKBACK_MUL, 0.12)

GM:AddSkillModifier(GM:AddTrinket("아드레날린 변환 I", "hemoadrenali", false, mveles, mweles, nil, "근접 공격 데미지의 2%가 혈갑으로 바뀜"), SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.02)

trinket = GM:AddTrinket("아드레날린 증폭", "hemoadrenalii", false, mveles, mweles, 3, "근접 공격 데미지의 3%가 혈갑으로 바뀜\n근접 공격으로 사살한 후 10초동안 이동 속도 +30")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.03)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, 30)

GM:AddSkillModifier(GM:AddTrinket("아드레날린 변환 II", "hemoadrenaliii", false, mveles, mweles, 4, "근접 공격 데미지의 4%가 혈갑으로 바뀜"), SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.04)

GM:AddSkillModifier(GM:AddTrinket("핵주먹", "powergauntlet", false, mveles, mweles, 3, "공격 적중 시 데미지 충전 +45%\n빗나갈 시 초기화"), SKILLMOD_MELEE_POWERATTACK_MUL, 0.45)

GM:AddTrinket("피네스 키트", "sharpkit", false, mveles, mweles, 2, "슬로우 디버프에 걸린 좀비에게 공격력 증가 최대 +32%")

GM:AddTrinket("날카로운 돌", "sharpstone", false, mveles, mweles, 3, "근접 공격력 +5%")

-- Performance Trinkets
GM:AddTrinket("산소 탱크", "oxygentank", true, nil, {
	["base"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 3, -1), angle = Angle(180, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, nil, "잠수 상태에서 호흡 시간 10x", "oxygentank")

GM:AddSkillModifier(GM:AddTrinket("아크로벳 프레임", "acrobatframe", false, pveles, pweles, nil, "점프력 +8%"), SKILLMOD_JUMPPOWER_MUL, 0.08)

trinket = GM:AddTrinket("야간투시경", "nightvision", true, pveles, pweles, 2, "-50% effect of dim vision and ability to see in the dark\n-40% effect of vision affecting effects\n-45% fright duration")
GM:AddSkillModifier(trinket, SKILLMOD_DIMVISION_EFF_MUL, -0.5)
GM:AddSkillModifier(trinket, SKILLMOD_FRIGHT_DURATION_MUL, -0.45)
GM:AddSkillModifier(trinket, SKILLMOD_VISION_ALTER_DURATION_MUL, -0.4)
GM:AddSkillFunction(trinket, function(pl, active)
	if CLIENT and pl == MySelf and GAMEMODE.m_NightVision and not active then
		surface.PlaySound("items/nvg_off.wav")
		GAMEMODE.m_NightVision = false
	end
end)
trinketwep.PermitDismantle = true

trinket = GM:AddTrinket("Portable Weapons Satchel", "portablehole", false, pveles, pweles, nil, "+15% weapon switch speed\n+3% reload speed")
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYSPEED_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.03)

trinket = GM:AddTrinket("Agility Magnifier", "pathfinder", false, pveles, pweles, 2, "+40% barricade phasing movement speed\n-45% sigil teleportation time\n+13% jump power")
GM:AddSkillModifier(trinket, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.4)
GM:AddSkillModifier(trinket, SKILLMOD_SIGIL_TELEPORT_MUL, -0.45)
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, 0.13)

trinket = GM:AddTrinket("Galvanizer Implant", "analgestic", false, pveles, pweles, 3, "-50% low health slow intensity\n-50% slow vulnerability\n-50% knockdown time\n-66% duration of pulling attacks\n+25% weapon switch speed")
GM:AddSkillModifier(trinket, SKILLMOD_SLOW_EFF_TAKEN_MUL, -0.50)
GM:AddSkillModifier(trinket, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.50)
GM:AddSkillModifier(trinket, SKILLMOD_KNOCKDOWN_RECOVERY_MUL, -0.5)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYSPEED_MUL, 0.25)

GM:AddSkillModifier(GM:AddTrinket("Ammo Vest", "ammovestii", false, ammoveles, ammoweles, 2, "+5% reload speed"), SKILLMOD_RELOADSPEED_MUL, 0.05)
GM:AddSkillModifier(GM:AddTrinket("Ammo Bandolier", "ammovestiii", false, ammoveles, ammoweles, 4, "+12% reload speed"), SKILLMOD_RELOADSPEED_MUL, 0.12)

GM:AddTrinket("Automated Reloader", "autoreload", false, ammoveles, ammoweles, 2, "Reloads one weapon you switched away from 4 seconds ago automatically")

-- Offensive Implants
GM:AddSkillModifier(GM:AddTrinket("Targeting Visor", "targetingvisori", false, oveles, oweles, nil, "+5% tighter aiming reticule."), SKILLMOD_AIMSPREAD_MUL, -0.05)

GM:AddSkillModifier(GM:AddTrinket("Targeting Unifier", "targetingvisoriii", false, oveles, oweles, 4, "+11% tighter aiming reticule."), SKILLMOD_AIMSPREAD_MUL, -0.11)

GM:AddTrinket("Refined Subscope", "refinedsub", false, oveles, oweles, 4, "+27% tighter aiming reticule with tier 3 or lower weapons")

trinket = GM:AddTrinket("Aim Compensator", "aimcomp", false, oveles, oweles, 3, "-52% reduced effect of aim shake effects\n+5% tighter aiming reticule\nZombies you look at have an indicator showing their health")
GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_AIM_SHAKE_MUL, -0.52)
GM:AddSkillFunction(trinket, function(pl, active) pl.TargetLocus = active end)

GM:AddSkillModifier(GM:AddTrinket("Pulse Booster", "pulseampi", false, oveles, oweles, nil, "+14% slow from pulse weapons and stun batons"), SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.14)

trinket = GM:AddTrinket("Pulse Infuser", "pulseampii", false, oveles, oweles, 3, "+20% slow from pulse weapons and stun batons\n+7% explosion radius")
GM:AddSkillModifier(trinket, SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.2)
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_RADIUS, 0.07)

trinket = GM:AddTrinket("Resonance Cascade Device", "resonance", false, oveles, oweles, 4, "Dealing enough pulse damage will cause a pulse explosion\n-25% slow from pulse weapons and stun batons")
GM:AddSkillModifier(trinket, SKILLMOD_PULSE_WEAPON_SLOW_MUL, -0.25)

trinket = GM:AddTrinket("Cryogenic Inductor", "cryoindu", false, oveles, oweles, 4, "Ice based weapons have a chance to shatter zombies based on how much health they have")

trinket = GM:AddTrinket("Extended Magazine", "extendedmag", false, oveles, oweles, 3, "Increases the clip size of weapons with 8 or more clip size by +15%")

trinket = GM:AddTrinket("Pulse Impedance Module", "pulseimpedance", false, oveles, oweles, 5, "Slow from pulse weapons and stun batons also slow zombie attack speed\n+24% slow from pulse weapons and stun batons")
GM:AddSkillFunction(trinket, function(pl, active) pl.PulseImpedance = active end)
GM:AddSkillModifier(trinket, SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.24)

trinket = GM:AddTrinket("Curb Stompers", "curbstompers", false, oveles, oweles, 2, "Instantly kills headcrabs and deals 50 damage to torso classes you land on\nDeals 500% fall damage to zombies landed on\nNo fall damage taken when landing on zombies\n-25% slow down from landing or fall damage")
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, -0.25)

GM:AddTrinket("Superior Assembly", "supasm", false, oveles, oweles, 5, "Increases to weapon damage via remantling affect reload speed on tier 2 or lower weapons")

trinket = GM:AddTrinket("Olympian Frame", "olympianframe", false, oveles, oweles, 2, "+100% object throwing strength\n-25% prop carrying slow down\n-35% movement speed reduction with heavy weapons")
GM:AddSkillModifier(trinket, SKILLMOD_PROP_THROW_STRENGTH_MUL, 1)
GM:AddSkillModifier(trinket, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.25)
GM:AddSkillModifier(trinket, SKILLMOD_WEAPON_WEIGHT_SLOW_MUL, -0.35)

-- Defensive Trinkets
trinket, trinketwep = GM:AddTrinket("Kevlar Underlay", "kevlar", false, develes, deweles, 2, "-11% melee damage taken\n-11% projectile damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.11)
GM:AddSkillModifier(trinket, SKILLMOD_PROJECTILE_DAMAGE_TAKEN_MUL, -0.11)
trinketwep.PermitDismantle = true

trinket = GM:AddTrinket("Barbed Armor", "barbedarmor", false, develes, deweles, 3, "100% of melee damage taken reflected back to melee attackers\nAdditional 14 damage reflected back to melee attackers\nMelee attackers take 14 arm damage\n-4% melee damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT, 14)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT, 1)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.04)

trinket = GM:AddTrinket("Antitoxin Package", "antitoxinpack", false, develes, deweles, 2, "-17% poison damage taken\n-40% poison damage over time speed")
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.17)
GM:AddSkillModifier(trinket, SKILLMOD_POISON_SPEED_MUL, -0.4)

trinket = GM:AddTrinket("Hemostasis Implant", "hemostasis", false, develes, deweles, 2, "-30% bleed damage taken\n-60% bleeding speed.")
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, -0.3)
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_SPEED_MUL, -0.6)

trinket = GM:AddTrinket("EOD Vest", "eodvest", false, develes, deweles, 4, "-35% explosive damage taken\n-50% fire damage taken\n-5% self damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, -0.35)
GM:AddSkillModifier(trinket, SKILLMOD_FIRE_DAMAGE_TAKEN_MUL, -0.50)
GM:AddSkillModifier(trinket, SKILLMOD_SELF_DAMAGE_MUL, -0.05)

trinket = GM:AddTrinket("Feather Fall Frame", "featherfallframe", false, develes, deweles, 3, "-35% fall damage taken\n+30% fall damage threshold\n-65% slow down from landing or fall damage")
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_DAMAGE_MUL, -0.35)
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_THRESHOLD_MUL, 0.30)
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, -0.65)

local eicev = {
	["base"] = { type = "Model", model = "models/gibs/glass_shard04.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.339, 2.697, -2.309), angle = Angle(4.558, -34.502, -72.395), size = Vector(0.5, 0.5, 0.5), color = Color(0, 137, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

local eicew = {
	["base"] = { type = "Model", model = "models/gibs/glass_shard04.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.556, 2.519, -1.468), angle = Angle(0, -5.844, -75.974), size = Vector(0.5, 0.5, 0.5), color = Color(0, 137, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

GM:AddTrinket("Iceburst Shield", "iceburst", false, eicev, eicew, nil, "Releases an ice burst when taking a melee hit, slowing zombies down\nRecharges every 40 seconds")

GM:AddSkillModifier(GM:AddTrinket("Force Dampening Field Emitter", "forcedamp", false, develes, deweles, 2, "-33% physics impact damage taken\nImmune to knockdowns from props\nTake normal physics damage from shades."), SKILLMOD_PHYSICS_DAMAGE_TAKEN_MUL, -0.33)

GM:AddSkillFunction(GM:AddTrinket("Necrotic Senses Distorter", "necrosense", false, develes, deweles, 2, "Hides aura from zombies in close proximity"), function(pl, active) pl:SetDTBool(DT_PLAYER_BOOL_NECRO, active) end)

trinket, trinketwep = GM:AddTrinket("Reactive Flasher", "reactiveflasher", false, develes, deweles, 2, "Blinds and disorients melee attacker for 2 seconds\nRecharges every 75 seconds")
trinketwep.PermitDismantle = true

trinket = GM:AddTrinket("Composite Underlay", "composite", false, develes, deweles, 4, "-16% melee damage taken\n-16% projectile damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.16)
GM:AddSkillModifier(trinket, SKILLMOD_PROJECTILE_DAMAGE_TAKEN_MUL, -0.16)

-- Support Trinkets
trinket, trinketwep = GM:AddTrinket("Arsenal Pack", "arsenalpack", false, {
	["base"] = { type = "Model", model = "models/Items/item_item_crate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -1), angle = Angle(0, -90, 180), size = Vector(0.35, 0.35, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, {
	["base"] = { type = "Model", model = "models/Items/item_item_crate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -1), angle = Angle(0, -90, 180), size = Vector(0.35, 0.35, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, 4, "Allows nearby humans to purchase from the arsenal menu.", "arsenalpack", 3)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Resupply Pack", "resupplypack", true, nil, {
	["base"] = { type = "Model", model = "models/Items/ammocrate_ar2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -1), angle = Angle(0, -90, 180), size = Vector(0.35, 0.35, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, 4, "Allows humans to resupply from you\nPress LMB with the pack in your hand to resupply yourself.", "resupplypack", 3)
trinketwep.PermitDismantle = true

GM:AddTrinket("Magnet", "magnet", true, supveles, supweles, nil, "Slowly pulls ammo and weapons towards you\nMust be equipped to take effect", "magnet")
GM:AddTrinket("Electromagnet", "electromagnet", true, supveles, supweles, nil, "Pulls ammo and weapons towards you quickly\nMust be equipped to take effect", "magnet_electro")

trinket, trinketwep = GM:AddTrinket("Loading Exoskeleton", "loadingex", false, supveles, supweles, 2, "-55% prop carrying slow down\n-20% deployable pack time")
GM:AddSkillModifier(trinket, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.55)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYABLE_PACKTIME_MUL, -0.2)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Blueprints", "blueprintsi", false, supveles, supweles, 2, "+10% repair rate")
GM:AddSkillModifier(trinket, SKILLMOD_REPAIRRATE_MUL, 0.1)
trinketwep.PermitDismantle = true

GM:AddSkillModifier(GM:AddTrinket("Advanced Blueprints", "blueprintsii", false, supveles, supweles, 4, "+20% repair rate"), SKILLMOD_REPAIRRATE_MUL, 0.2)

trinket, trinketwep = GM:AddTrinket("Medical Processor", "processor", false, supveles, supweles, 2, "-5% medic kit cooldown\n-10% medic tool fire delay\nReprocess food into medical ammo with right click")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, -0.1)

trinket = GM:AddTrinket("Curative Kit", "curativeii", false, supveles, supweles, 3, "-10% medic kit cooldown\n-20% medic tool fire delay")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.1)
GM:AddSkillModifier(trinket, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, -0.2)

trinket = GM:AddTrinket("Remedial Booster", "remedy", false, supveles, supweles, 3, "+8% medic tool effectiveness")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.08)

trinket = GM:AddTrinket("Maintenance Suite", "mainsuite", false, supveles, supweles, 2, "+10% zapper and repair field range\n-7% zapper and repair field delay\n+10% turret range")
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_RANGE_MUL, 0.1)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_DELAY_MUL, -0.07)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_RANGE_MUL, 0.1)

trinket = GM:AddTrinket("Control Platform", "controlplat", false, supveles, supweles, 2, "+15% controllable health\n+15% controllable speed\n+20% manhack damage")
GM:AddSkillModifier(trinket, SKILLMOD_CONTROLLABLE_HEALTH_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_CONTROLLABLE_SPEED_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_DAMAGE_MUL, 0.2)

trinket = GM:AddTrinket("Projectile Guidance", "projguide", false, supveles, supweles, 2, "+25% projectile speed")
GM:AddSkillModifier(trinket, SKILLMOD_PROJ_SPEED, 0.25)

trinket = GM:AddTrinket("Projectile Weight", "projwei", false, supveles, supweles, 2, "-50% projectile speed\n+5% projectile damage")
GM:AddSkillModifier(trinket, SKILLMOD_PROJ_SPEED, -0.5)
GM:AddSkillModifier(trinket, SKILLMOD_PROJECTILE_DAMAGE_MUL, 0.05)

local ectov = {
	["base"] = { type = "Model", model = "models/props_junk/glassjug01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.381, 2.617, 2.062), angle = Angle(180, 12.243, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 4.07), angle = Angle(180, 12.243, 0), size = Vector(0.123, 0.123, 0.085), color = Color(0, 0, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

local ectow = {
	["base"] = { type = "Model", model = "models/props_junk/glassjug01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.506, 1.82, 1.758), angle = Angle(-164.991, 19.691, 8.255), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 4.07), angle = Angle(180, 12.243, 0), size = Vector(0.123, 0.123, 0.085), color = Color(0, 0, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

trinket = GM:AddTrinket("Reactive Chemicals", "reachem", false, ectov, ectow, 3, "+30% explosive damage taken\n+10% explosive damage radius")
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, 0.3)
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_RADIUS, 0.1)

trinket = GM:AddTrinket("Operations Matrix", "opsmatrix", false, supveles, supweles, 4, "+15% zapper and repair field range\n-13% zapper and repair field delay\n+15% turret range")
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_RANGE_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_DELAY_MUL, -0.13)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_RANGE_MUL, 0.15)

GM:AddSkillModifier(GM:AddTrinket("Acquisitions Manifest", "acqmanifest", false, supveles, supweles, 2, "-6% resupply delay time"), SKILLMOD_RESUPPLY_DELAY_MUL, -0.06)
GM:AddSkillModifier(GM:AddTrinket("Procurement Manifest", "promanifest", false, supveles, supweles, 4, "-9% resupply delay time"), SKILLMOD_RESUPPLY_DELAY_MUL, -0.09)

-- Boss Trinkets

local blcorev = {
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_Spine4", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = true},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0, 0.5, -1.701), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(20, 20, 20, 255), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} },
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_Spine4", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = true}
}

local blcorew = {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(20, 20, 20, 255), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} }
}

GM:AddTrinket("Bleak Soul", "bleaksoul", false, blcorev, blcorew, nil, "Blinds and knocks zombies away when attacked\nRecharges every 35 seconds")

trinket = GM:AddTrinket("Spirit Essence", "spiritess", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(255, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "+10% jump height.")
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, 0.13)

-- Starter Trinkets

trinket, trinketwep = GM:AddTrinket("Armband", "armband", false, mveles, mweles, nil, "-10% melee swing impact delay\n-6% melee damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.1)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.06)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Condiments", "condiments", false, supveles, supweles, nil, "+20% recovery from food\n-20% time to eat food")
GM:AddSkillModifier(trinket, SKILLMOD_FOODRECOVERY_MUL, 0.20)
GM:AddSkillModifier(trinket, SKILLMOD_FOODEATTIME_MUL, -0.20)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Escape Manual", "emanual", false, develes, deweles, nil, "+20% phasing speed\n-12% low health slow intensity")
GM:AddSkillModifier(trinket, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.20)
GM:AddSkillModifier(trinket, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.12)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Aiming Aid", "aimaid", false, develes, deweles, nil, "+5% tighter aiming reticule\n-7% reduced effect of aim shake effects")
GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_AIM_SHAKE_MUL, -0.06)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Vitamin Capsules", "vitamins", false, hpveles, hpweles, nil, "+5 maximum health\n-12% poison damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 5)
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.12)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Welfare Shield", "welfare", false, hpveles, hpweles, nil, "-5% resupply delay\n-7% self damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_SELF_DAMAGE_MUL, -0.07)
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("Chemistry Set", "chemistry", false, hpveles, hpweles, nil, "+6% medic tool effectiveness\n+12% cloud bomb time")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.06)
GM:AddSkillModifier(trinket, SKILLMOD_CLOUD_TIME, 0.12)
trinketwep.PermitDismantle = true
