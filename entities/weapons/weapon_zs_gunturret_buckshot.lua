AddCSLuaFile()

SWEP.Base = "weapon_zs_gunturret"

SWEP.PrintName = "샷건 터렛"
SWEP.Description = "이 자동화 터렛은 샷건탄을 발사한다.\n > 주 공격 버튼으로 설치\n > 보조 공격 버튼 및 재장전 버튼으로 회전\n > 설치된 터렛에 사용 키를 눌러 보유중인 샷건탄을 터렛에 충전\n > 주인이 없는 터렛(파란 빛)에 사용 키를 눌러 소유권 획득"

SWEP.Primary.Damage = 6.75

SWEP.GhostStatus = "ghost_gunturret_buckshot"
SWEP.DeployClass = "prop_gunturret_buckshot"
SWEP.TurretAmmoType = "buckshot"
SWEP.TurretAmmoStartAmount = 25
SWEP.TurretSpread = 5

SWEP.Primary.Ammo = "turret_buckshot"

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_TURRET_SPREAD, -0.9)
