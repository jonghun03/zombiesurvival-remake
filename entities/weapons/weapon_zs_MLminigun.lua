AddCSLuaFile()

SWEP.PrintName = "게틀링건"

if CLIENT then
	SWEP.ViewModelFOV = 65
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/jazzmcfly/brs/brs_minigun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.019, 1.184, -19.267), angle = Angle(4.933, -94.974, -3.143), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/jazzmcfly/brs/brs_minigun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.019, 1.184, -19.267), angle = Angle(4.933, -94.974, -3.143), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/jazzmcfly/brs/brs_minigun.mdl"
SWEP.UseHands = true

SWEP.HoldType = "shotgun"

SWEP.DamageType = DMG_CLUB

SWEP.MeleeDamage = 650
SWEP.MeleeRange = 120
SWEP.MeleeSize = 0.5

SWEP.Primary.Delay = 0.3		--전체 딜레이

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.SwingRotation = Angle(0, -90, -60)
SWEP.SwingOffset = Vector(0, 30, -40)
SWEP.SwingTime = 0.125		--시전후 공격 나가기까지 딜레이
SWEP.SwingHoldType = "knife"

SWEP.AllowQualityWeapons = true
SWEP.DismantleDiv = 2
SWEP.Unarmed = true

SWEP.Undroppable = true
SWEP.NoPickupNotification = true
SWEP.NoDismantle = true
SWEP.Ungiveable = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.1)

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 80, math.Rand(65, 70))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_solid_impact_hard"..math.random(4, 5)..".wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end
