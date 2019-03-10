AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "신선한 좀비"

SWEP.MeleeDamage = 20

function SWEP:Reload()
	self:SecondaryAttack()
end

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:IsMoaning()
	return false
end
