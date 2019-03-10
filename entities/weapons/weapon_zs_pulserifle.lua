AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'아도니스' 펄스 라이플"
SWEP.Description = "대상을 느리게 하고 큰 피해를 준다."

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "Vent"
	SWEP.HUD3DPos = Vector(1, 0, 0)
	SWEP.HUD3DScale = 0.018
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_IRifle.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.Primary.Sound = Sound("Airboat.FireGunHeavy")
SWEP.Primary.Damage = 29
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.2

SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pulse"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 3
SWEP.ConeMin = 1

SWEP.WalkSpeed = SPEED_SLOW

SWEP.IronSightsPos = Vector(-3, 1, 1)

SWEP.Tier = 5
SWEP.MaxStock = 2

SWEP.PointsMultiplier = GAMEMODE.PulsePointsMultiplier

SWEP.TracerName = "AR2Tracer"

SWEP.FireAnimSpeed = 0.4
SWEP.LegDamage = 5.5

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.014, 1)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'서비터' 펄스 라이플", "죽이는 순간 재사용 대기 시간을 새로 고친다. 다리 데미지도 커지지만, 정확도와 재장전 속도가 감소한다", function(wept)
	wept.ConeMin = 2.25
	wept.ConeMax = 3.75
	wept.ReloadSpeed = 0.85
	wept.LegDamage = 8

	wept.OnZombieKilled = function(self)
		local killer = self:GetOwner()

		if killer:IsValid() then
			for _,v in pairs(ents.FindByClass("prop_zapper*")) do
				if v:GetObjectOwner() == killer then
					v:SetNextZap(0)
				end
			end
		end
	end
end)

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	if ent:IsValidZombie() then
		local activ = attacker:GetActiveWeapon()
		ent:AddLegDamageExt(activ.LegDamage, attacker, activ, SLOWTYPE_PULSE)
	end

	if IsFirstTimePredicted() then
		util.CreatePulseImpactEffect(tr.HitPos, tr.HitNormal)
	end
end
