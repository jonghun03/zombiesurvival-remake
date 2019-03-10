SWEP.PrintName = "원격 폭발물 패키지"
SWEP.Description = "표면에 부착 가능하고 원격으로 폭발시킬 수 있는 폭발물 팩.\n > 주 공격 버튼으로 설치\n > 주 공격 버튼을 다시 눌러 폭파\n > 달리기 키를 눌러 회수"

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = Model("models/weapons/w_c4_planted.mdl")

SWEP.AmmoIfHas = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Ammo = "sniperpenetratedround"
SWEP.Primary.Delay = 0.1
SWEP.Primary.Automatic = true

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Ammo = "dummy"

SWEP.MaxStock = 8

SWEP.WalkSpeed = SPEED_NORMAL
SWEP.FullWalkSpeed = SPEED_SLOW

SWEP.NoDeploySpeedChange = true

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
	GAMEMODE:DoChangeDeploySpeed(self)
	self:HideViewAndWorldModel()
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

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self:GetOwner(), self)

	return true
end

function SWEP:Holster()
	return true
end
