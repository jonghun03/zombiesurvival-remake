SWEP.PrintName = "'이지스' 바리케이드 키트"
SWEP.Description = "언제든지 사용할 수 있는 바리케이드 설치 키트.\n거의 모든 재질의 벽 사이에 바리케이드를 손쉽게 설치할 수 있다.\n > 주 공격 버튼으로 설치\n > 보조 공격 및 재장전 버튼으로 회전\n고스트의 색으로 설치 가능 지역인지 판별"
SWEP.Slot = 4
SWEP.SlotPos = 0

SWEP.ViewModel = "models/weapons/c_rpg.mdl"
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "SniperRound"
SWEP.Primary.Delay = 1.25
SWEP.Primary.DefaultClip = 5

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Ammo = "dummy"
SWEP.Secondary.Automatic = false

SWEP.UseHands = true

SWEP.MaxStock = 5

if CLIENT then
	SWEP.ViewModelFOV = 60
end

SWEP.WalkSpeed = SPEED_SLOWEST

function SWEP:Initialize()
	self:SetWeaponHoldType("rpg")
	GAMEMODE:DoChangeDeploySpeed(self)
end

function SWEP:Deploy()
	GAMEMODE:DoChangeDeploySpeed(self)

	return true
end

function SWEP:CanPrimaryAttack()
	local owner = self:GetOwner()

	if owner:IsHolding() or owner:GetBarricadeGhosting() then return false end

	if self:GetPrimaryAmmoCount() <= 0 then
		self:EmitSound("Weapon_Shotgun.Empty")
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		return false
	end

	return true
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

util.PrecacheModel("models/props_debris/wood_board05a.mdl")
util.PrecacheSound("npc/dog/dog_servo12.wav")
