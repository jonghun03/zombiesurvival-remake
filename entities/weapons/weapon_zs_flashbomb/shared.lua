SWEP.PrintName = "섬광탄"
SWEP.Description = "데미지를 주지는 않지만, 좀비의 시야를 가릴 수 있다."

SWEP.Base = "weapon_zs_basethrown"

SWEP.ViewModel = "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel = "models/weapons/w_eq_flashbang.mdl"

SWEP.Primary.Ammo = "flashbomb"
SWEP.Primary.Sound = Sound("weapons/pinpull.wav")

SWEP.MaxStock = 12

function SWEP:Precache()
	util.PrecacheSound("weapons/pinpull.wav")
end
