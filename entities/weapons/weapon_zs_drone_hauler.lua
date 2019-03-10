AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_drone")

SWEP.Base = "weapon_zs_drone"

SWEP.PrintName = "운반 드론"
SWEP.Description = "정찰 및 검색에 적합하다.\n프롭과 아이템을 빠른 속도로 끌고 다니지만 공격하지 못한다."

SWEP.Primary.Ammo = "drone_hauler"

SWEP.DeployClass = "prop_drone_hauler"
SWEP.DeployAmmoType = false
SWEP.ResupplyAmmoType = nil
