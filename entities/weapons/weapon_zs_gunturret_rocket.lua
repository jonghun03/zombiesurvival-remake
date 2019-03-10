AddCSLuaFile()

SWEP.Base = "weapon_zs_gunturret"

SWEP.PrintName = "로켓 터렛"
SWEP.Description = "이 자동화 터렛은 총알 대신 폭발물을 발사한다.\n > 주 공격 버튼으로 설치\n > 보조 공격 버튼 및 재장전 버튼으로 회전\n > 설치된 터렛에 사용 키를 눌러 보유중인 폭발물을 터렛에 충전\n > 주인이 없는 터렛(파란 빛)에 사용 키를 눌러 소유권 획득"

SWEP.Primary.Damage = 104

SWEP.GhostStatus = "ghost_gunturret_rocket"
SWEP.DeployClass = "prop_gunturret_rocket"
SWEP.TurretAmmoType = "impactmine"
SWEP.TurretAmmoStartAmount = 12
SWEP.TurretSpread = 1

SWEP.Primary.Ammo = "turret_rocket"

SWEP.Tier = 4

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_TURRET_SPREAD, -0.45)
