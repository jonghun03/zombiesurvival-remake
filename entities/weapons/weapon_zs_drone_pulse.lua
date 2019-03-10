AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_drone")

SWEP.Base = "weapon_zs_drone"

SWEP.PrintName = "펄스 드론"
SWEP.Description = "정찰, 회수, 공격용 원격 조종 드론.\n총알 대신 발사체를 쓴다."

SWEP.Primary.Ammo = "pulse_cutter"

SWEP.DeployClass = "prop_drone_pulse"
SWEP.DeployAmmoType = "pulse"
SWEP.ResupplyAmmoType = "pulse"
