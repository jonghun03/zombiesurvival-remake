SWEP.Base = "weapon_zs_basemelee"

SWEP.PrintName = "목수의 망치"
SWEP.Description = "가성비 최강의 서바이벌 용품. 프롭에 못을 박아 바리케이드를 건설할 수 있게 해준다.\n보조 공격 버튼으로 못 박기. 바라보는 프롭과 그 뒤의 프롭 또는 월드가 고정된다.\n > 재장전 버튼으로 못 뽑기\n > 주 공격 버튼으로 좀비의 머리통 깨기, 혹은 못 수리\n내구도가 상한 못을 수리하면 포인트를 얻지만, 다른 플레이어의 못을 제거하면 포인트를 잃는다."

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/v_hammer/c_hammer.mdl"
SWEP.WorldModel = "models/weapons/w_hammer.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "GaussEnergy"
SWEP.Primary.Delay = 1
SWEP.Primary.DefaultClip = 16

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Ammo = "dummy"

--SWEP.MeleeDamage = 35 -- Reduced due to instant swing speed
SWEP.MeleeDamage = 15
SWEP.MeleeRange = 50
SWEP.MeleeSize = 0.875

SWEP.MaxStock = 5

SWEP.UseMelee1 = true

SWEP.NoPropThrowing = true

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture

SWEP.HealStrength = 1

SWEP.NoHolsterOnCarry = true

SWEP.NoGlassWeapons = true

SWEP.AllowQualityWeapons = true

GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.04)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_RANGE, 3, 1)

function SWEP:SetNextAttack()
	local owner = self:GetOwner()
	local armdelay = owner:GetMeleeSpeedMul()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * (owner.HammerSwingDelayMul or 1) * armdelay)
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/melee/crowbar/crowbar_hit-"..math.random(4)..".ogg", 75, math.random(110, 115))
end

function SWEP:PlayRepairSound(hitent)
	hitent:EmitSound("npc/dog/dog_servo"..math.random(7, 8)..".wav", 70, math.random(100, 105))
end
