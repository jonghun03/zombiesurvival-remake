AddCSLuaFile()

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.PrintName = "붐-스틱"
SWEP.Description = "4발을 장전할 수 있으며 한 번에 쏠 수 있다. 재장전을 잘 해줘야 한다."

if CLIENT then
	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(1.65, 0, -8)
	SWEP.HUD3DScale = 0.025

	SWEP.ViewModelFlip = false
end

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadDelay = 0.5

SWEP.Primary.Sound = Sound("weapons/shotgun/shotgun_dbl_fire.wav")
SWEP.Primary.Damage = 27
SWEP.Primary.NumShots = 6
SWEP.Primary.Delay = 1

SWEP.Recoil = 7.5

SWEP.Primary.ClipSize = 4
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.DefaultClip = 28

SWEP.ConeMax = 11.5
SWEP.ConeMin = 10

SWEP.Tier = 5
SWEP.MaxStock = 2

SWEP.WalkSpeed = SPEED_SLOWER
SWEP.FireAnimSpeed = 0.4
SWEP.Knockback = 80

SWEP.PumpActivity = ACT_SHOTGUN_PUMP
SWEP.PumpSound = Sound("Weapon_Shotgun.Special1")
SWEP.ReloadSound = Sound("Weapon_Shotgun.Reload")

GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.07)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "유연한 붐-스틱", "데미지가 줄어들지만 재장전이 빨라지고, 넉백과 이동속도가 증가한다", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 0.75
	wept.ReloadSpeed = wept.ReloadSpeed * 1.25
	wept.Primary.Delay = wept.Primary.Delay * 0.5
	wept.Knockback = 100
	wept.WalkSpeed = SPEED_SLOW
end)

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self:GetOwner()

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitSound(self.Primary.Sound)

	local clip = self:Clip1()

	self:ShootBullets(self.Primary.Damage, self.Primary.NumShots * clip, self:GetCone())

	self:TakePrimaryAmmo(clip)
	owner:ViewPunch(clip * 0.5 * self.Recoil * Angle(math.Rand(-0.1, -0.1), math.Rand(-0.1, 0.1), 0))

	owner:SetGroundEntity(NULL)
	owner:SetVelocity(-self.Knockback * clip * owner:GetAimVector())

	self.IdleAnimation = CurTime() + self:SequenceDuration()
end