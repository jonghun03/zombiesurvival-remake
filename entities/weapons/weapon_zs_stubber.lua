AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'스터버' 소총"
SWEP.Description = "평범한 소총이다. 헤드샷을 하면 강력한 피해를 준다."

SWEP.Slot = 3
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false

	SWEP.HUD3DBone = "v_weapon.scout_Parent"
	SWEP.HUD3DPos = Vector(-1, -2.75, -6)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_snip_scout.mdl"
SWEP.WorldModel = "models/weapons/w_snip_scout.mdl"
SWEP.UseHands = true

SWEP.ReloadSound = Sound("Weapon_Scout.ClipOut")
SWEP.Primary.Sound = Sound("Weapon_Scout.Single")
SWEP.Primary.Damage = 55
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 1.25
SWEP.ReloadDelay = SWEP.Primary.Delay

SWEP.Primary.ClipSize = 5
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "357"
SWEP.Primary.DefaultClip = 25

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN

SWEP.ConeMax = 3.75
SWEP.ConeMin = 0

SWEP.IronSightsPos = Vector(5.015, -8, 2.52)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.WalkSpeed = SPEED_SLOW

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'프로더' 소총", "배율과 헤드샷 데미지가 약간 늘어나지만, 연사 속도가 줄어들고 장탄수가 절반이 된다.", function(wept)
	wept.HeadshotMulti = 2.2
	wept.Primary.ClipSize = math.ceil(wept.Primary.ClipSize / 2)
	wept.Primary.Delay = wept.Primary.Delay * 1.7

	wept.IronsightsMultiplier = 0.15
end)

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end

function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound, 85, 100)
end

if CLIENT then
	SWEP.IronsightsMultiplier = 0.25

	function SWEP:GetViewModelPosition(pos, ang)
		if GAMEMODE.DisableScopes then return end

		if self:IsScoped() then
			return pos + ang:Up() * 256, ang
		end

		return BaseClass.GetViewModelPosition(self, pos, ang)
	end

	function SWEP:DrawHUDBackground()
		if GAMEMODE.DisableScopes then return end

		if self:IsScoped() then
			self:DrawRegularScope()
		end
	end
end