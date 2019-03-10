SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/Combine_turrets/Floor_turret.mdl"

SWEP.PrintName = "적외선 레이저 터렛"
SWEP.Description = "이 자동화 터렛은 유지/보수만 잘 해준다면 거점 방어에 매우 유용하다.\n > 주 공격 버튼으로 설치\n > 보조 공격 버튼 및 재장전 버튼으로 회전\n > 설치된 터렛에 사용 키를 눌러 보유중인 SMG 탄환을 터렛에 충전\n > 주인이 없는 터렛(파란 빛)에 사용 키를 눌러 소유권 획득"

SWEP.AmmoIfHas = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "thumper"
SWEP.Primary.Delay = 2
SWEP.Primary.Damage = 8.8

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.MaxStock = 5

SWEP.WalkSpeed = SPEED_NORMAL
SWEP.FullWalkSpeed = SPEED_SLOWEST

SWEP.GhostStatus = "ghost_gunturret"
SWEP.DeployClass = "prop_gunturret"
SWEP.Channel = "turret"

SWEP.TurretAmmoType = "smg1"
SWEP.TurretAmmoStartAmount = 250
SWEP.TurretSpread = 2

SWEP.NoDeploySpeedChange = true
SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_TURRET_SPREAD, -0.4)

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
	GAMEMODE:DoChangeDeploySpeed(self)
	self:HideViewAndWorldModel()

	self.ResupplyAmmoType = self.TurretAmmoType
end

function SWEP:SetReplicatedAmmo(count)
	self:SetDTInt(0, count)
end

function SWEP:GetReplicatedAmmo()
	return self:GetDTInt(0)
end

function SWEP:GetWalkSpeed()
	if self:GetPrimaryAmmoCount() > 0 then
		return self.FullWalkSpeed
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:CanPrimaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() then return false end

	if self:GetPrimaryAmmoCount() <= 0 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		return false
	end

	return true
end

function SWEP:Think()
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end

	if SERVER then
		local count = self:GetPrimaryAmmoCount()
		if count ~= self:GetReplicatedAmmo() then
			self:SetReplicatedAmmo(count)
			self:GetOwner():ResetSpeed()
		end
	end
end

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self:GetOwner(), self)

	self.IdleAnimation = CurTime() + self:SequenceDuration()

	return true
end

function SWEP:Holster()
	return true
end

util.PrecacheModel("models/Combine_turrets/Floor_turret.mdl")
