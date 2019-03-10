SWEP.PrintName = "'하이에나' 점착 폭탄 발사기"
SWEP.Description = "점착 폭탄을 발사한다. 폭탄은 최대 피해까지 3초가 걸린다. > Alt 버튼으로 원격 폭파"

SWEP.Base = "weapon_zs_baseproj"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/w_smg_p90.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Delay = 0.2
SWEP.Primary.ClipSize = 3
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "impactmine"
SWEP.Primary.DefaultClip = 3
SWEP.Primary.Damage = 80

SWEP.ConeMin = 0.0001
SWEP.ConeMax = 0.0001

SWEP.WalkSpeed = SPEED_SLOW

SWEP.Tier = 3

SWEP.MaxBombs = 3

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.1)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'링스' 냉동 점착폭탄 발사기", "냉동 가스 수류탄을 발사하여 좀비들이 느려질 수 있지만 데미지가 줄어든다.", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 0.8
	if SERVER then
		wept.EntModify = function(self, ent)
			self:SetNextSecondaryFire(CurTime() + 0.2)
			ent:SetDTBool(0, true)
		end
	end
	if CLIENT then
		wept.VElements.clipbase.color = Color(30, 95, 150)
	end
end)

function SWEP:CanPrimaryAttack()
	if self.BaseClass.CanPrimaryAttack(self) then
		local c = 0
		for _, ent in pairs(ents.FindByClass("projectile_bomb_sticky")) do
			if ent:GetOwner() == self:GetOwner() then
				c = c + 1
			end
		end

		if c >= self.MaxBombs then return false end

		return true
	end

	return false
end

function SWEP:EmitFireSound()
	self:EmitSound("weapons/ar2/ar2_altfire.wav", 70, math.random(112, 120), 0.50)
	self:EmitSound("weapons/physcannon/superphys_launch1.wav", 70, math.random(145, 155), 0.5, CHAN_AUTO + 20)
end
