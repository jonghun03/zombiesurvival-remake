AddCSLuaFile()

SWEP.Base = "weapon_zs_basefood"

SWEP.PrintName = "우유"

if CLIENT then
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_junk/garbage_milkcarton002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.75, 2.5, -2), angle = Angle(180, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_junk/garbage_milkcarton002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.75, 2.5, -2), angle = Angle(180, 0, -25), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/props_junk/garbage_milkcarton002a.mdl"

SWEP.Primary.Ammo = "foodmilk"

SWEP.FoodHealth = 13
SWEP.FoodEatTime = 3
SWEP.FoodIsLiquid = true
