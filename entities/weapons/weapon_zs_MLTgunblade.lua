AddCSLuaFile()

SWEP.PrintName = "건블레이드"
SWEP.Description = "피해량, 범위 등 다양한 측면에서 균형 잡힌 간단한 도끼이다."

if CLIENT then
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false
	
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/jazzmcfly/ibrs/ibrs_gunblade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-35--[[상하]], -19--[[좌우]], -35--[[전후]]), angle = Angle(20--[[좌우]], 80--[[]], 0--[[상하]]), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/jazzmcfly/ibrs/ibrs_gunblade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-35.2--[[상하]], -17.15--[[좌우]], -35--[[전후]]), angle = Angle(20--[[좌우]], 80--[[]], 20--[[상하]]), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/jazzmcfly/ibrs/ibrs_gunblade.mdl"
SWEP.UseHands = true

SWEP.HoldType = "knife"			--쥐는 동작

SWEP.MeleeDamage = 75			--데미지
SWEP.MeleeRange = 215			--사거리
SWEP.MeleeSize = 15.5			--사이즈
SWEP.MeleeKnockBack = 500		--넉백

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.SwingTime = 0.45		--공속
SWEP.SwingRotation = Angle(0, -20, -40)
SWEP.SwingOffset = Vector(10, 0, 0)
SWEP.SwingHoldType = "knife"

SWEP.HitDecal = "Manhackcut"


SWEP.Undroppable = true
SWEP.NoPickupNotification = true
SWEP.NoDismantle = true
SWEP.Ungiveable = true
SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_RANGE, 5)

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(65, 70))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/melee/golf club/golf_hit-0"..math.random(4)..".ogg")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end

function SWEP:StartSwinging()
	if self.StartSwingAnimation then
		self:SendWeaponAnim(self.StartSwingAnimation)
		self.IdleAnimation = CurTime() + self:SequenceDuration()
	end
	self:PlayStartSwingSound()
	self:SetSwingEnd(CurTime() + self.SwingTime)
	
	local owner = self.Owner
	
	local trace = owner:CompensatedMeleeTrace(self.MeleeRange, self.MeleeSize)
	if trace.HitNonWorld and not trace.Entity:IsPlayer() then
		trace.IsPreHit = true
		self.PreHit = trace
	end
end

function SWEP:MeleeSwing()
	local owner = self.Owner
	owner:DoAttackEvent()

	--owner:LagCompensation(true)

	local traces = owner:CompensatedZombieMeleeTrace(self.MeleeRange, self.MeleeSize)
	for _, tr in pairs(traces) do
		if not tr.Hit then continue end
		if tr.Hit then
			local damagemultiplier = (owner.BuffMuscular and owner:Team()==TEAM_HUMAN) and 1.2 or 1
			local damage = self.MeleeDamage * damagemultiplier
			local hitent = tr.Entity
			local hitflesh = tr.MatType == MAT_FLESH or tr.MatType == MAT_BLOODYFLESH or tr.MatType == MAT_ANTLION or tr.MatType == MAT_ALIENFLESH

			if self.HitAnim then
				self:SendWeaponAnim(self.HitAnim)
			end
			self.IdleAnimation = CurTime() + self:SequenceDuration()

			if hitflesh then
				util.Decal(self.BloodDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
				self:PlayHitFleshSound()
				if SERVER and not (hitent:IsValid() and hitent:IsPlayer() and hitent:Team() == owner:Team()) then
					util.Blood(tr.HitPos, math.Rand(damage * 0.001, damage * 0.01), (tr.HitPos - owner:GetShootPos()):GetNormalized(), math.Rand(damage * 0.01, damage * 0.1), true)
				end
				if not self.NoHitSoundFlesh then
					self:PlayHitSound()
				end
			else
				util.Decal(self.HitDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
				self:PlayHitSound()
			end

			if self.OnMeleeHit and self:OnMeleeHit(hitent, hitflesh, tr) then
				--owner:LagCompensation(false)
				return
			end

			if SERVER and hitent:IsValid() then
				damage = self.MeleeDamage * damagemultiplier
				
				if hitent:GetClass() == "func_breakable_surf" then
					hitent:Fire("break", "", 0.01) -- Delayed because no way to do prediction.
				else
					local dmginfo = DamageInfo()
					dmginfo:SetDamagePosition(tr.HitPos)
					dmginfo:SetDamage(damage)
					dmginfo:SetAttacker(owner)
					dmginfo:SetInflictor(self)
					dmginfo:SetDamageType(self.DamageType)
					if hitent:IsPlayer() then
						hitent:MeleeViewPunch(damage)
						if hitent:IsHeadcrab() then
							damage = damage * 2
							dmginfo:SetDamage(damage)
						end
						gamemode.Call("ScalePlayerDamage", hitent, tr.HitGroup, dmginfo)

						if self.MeleeKnockBack > 0 then
							hitent:ThrowFromPositionSetZ(tr.HitPos, self.MeleeKnockBack, nil, true)
						end
						if hitent:IsPlayer() and hitent:WouldDieFrom(damage, dmginfo:GetDamagePosition()) then
							dmginfo:SetDamageForce(math.min(self.MeleeDamage, 50) * 400 * owner:GetAimVector())
						end
					end

					if hitent:IsPlayer() then
						hitent:TakeDamageInfo(dmginfo)
					else
						-- Again, no way to do prediction.
						timer.Simple(0, function()
							if hitent:IsValid() then
								-- Workaround for propbroken not calling.
								local h = hitent:Health()

								hitent:TakeDamageInfo(dmginfo)

								if hitent:Health() <= 0 and h ~= hitent:Health() then
									gamemode.Call("PropBroken", hitent, owner)
								end

								local phys = hitent:GetPhysicsObject()
								if hitent:GetMoveType() == MOVETYPE_VPHYSICS and phys:IsValid() and phys:IsMoveable() then
									hitent:SetPhysicsAttacker(owner)
								end
							end
						end)
					end
				end
			end

			if self.PostOnMeleeHit then self:PostOnMeleeHit(hitent, hitflesh, tr) end
		else
			if self.MissAnim then
				self:SendWeaponAnim(self.MissAnim)
			end
			self.IdleAnimation = CurTime() + self:SequenceDuration()
			self:PlaySwingSound()

			if self.PostOnMeleeMiss then self:PostOnMeleeMiss(tr) end
		end
	end

	--owner:LagCompensation(false)
end
