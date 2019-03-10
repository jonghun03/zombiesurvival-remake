INC_CLIENT()

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65

SWEP.HUD3DBone = "Base"
SWEP.HUD3DPos = Vector(3, -0.5, -13)
SWEP.HUD3DAng = Angle(180, 0, 0)
SWEP.HUD3DScale = 0.03

SWEP.VElements = {
	["base"] = { type = "Model", model = "models/jazzmcfly/brs/brs_minigun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.019, 1.184, -19.267), angle = Angle(10, -94.974, -65), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["base"] = { type = "Model", model = "models/jazzmcfly/brs/brs_minigun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.019, 1.184, -19.267), angle = Angle(4.933, -94.974, -3.143), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(1, 0, 9), angle = Angle(0, 0, 0) },
	["Base"] = { scale = Vector(1, 1, 1), pos = Vector(-12.412, -2.212, -0.42), angle = Angle(0, 0, 0) }
}

SWEP.LastVel = 0

SWEP.IronSightsPos = Vector(1.24, 0, 2.359)
SWEP.IronSightsAng = Vector(0, 0, 0)

function SWEP:Think()
	self:CheckSpool()
end

local colBG = Color(16, 16, 16, 90)
local colRed = Color(220, 0, 0, 230)
local colWhite = Color(220, 220, 220, 230)

function SWEP:Draw2DHUD()
	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72
	local spare = self:GetPrimaryAmmoCount()

	draw.RoundedBox(16, x, y, wid, hei, colBG)
	draw.SimpleTextBlurry(spare, spare >= 1000 and "ZSHUDFont" or "ZSHUDFontBig", x + wid * 0.5, y + hei * 0.5, spare == 0 and colRed or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	local rotators = self.VElements["circle1"].angle
	local vel = Lerp(0.01, self.LastVel, self:GetSpool() * FrameTime() * 2000)
	rotators.r = rotators.r + vel

	self.LastVel = vel
end

function SWEP:Draw3DHUD(vm, pos, ang)
	local wid, hei = 180, 64
	local x, y = wid * -0.6, hei * -0.5
	local spare = self:GetPrimaryAmmoCount()

	cam.Start3D2D(pos, ang, self.HUD3DScale / 2)
		draw.RoundedBoxEx(32, x, y, wid, hei, colBG, true, false, true, false)
		draw.SimpleTextBlurry(spare, spare >= 1000 and "ZS3D2DFontSmall" or "ZS3D2DFont", x + wid * 0.5, y + hei * 0.5, spare == 0 and colRed or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end

local ghostlerp = 0
function SWEP:CalcViewModelView(vm, oldpos, oldang, pos, ang)
	local Offset = self.IronSightsPos
	if self.IronSightsAng then
		ang = Angle(ang.p, ang.y, ang.r)
		ang:RotateAroundAxis(ang:Right(), self.IronSightsAng.x)
		ang:RotateAroundAxis(ang:Up(), self.IronSightsAng.y)
		ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z)
	end

	pos = pos + Offset.x * ang:Right() + Offset.y * ang:Forward() + Offset.z * ang:Up()

	if not self:GetSpooling() then
		ghostlerp = math.min(1, ghostlerp + FrameTime() * 1)
	elseif ghostlerp > 0 then
		ghostlerp = math.max(0, ghostlerp - FrameTime() * 1.5)
	end

	if ghostlerp > 0 then
		pos = pos - 35.5 * ghostlerp * ang:Up()
		ang:RotateAroundAxis(ang:Right(), 70 * ghostlerp)
	end

	return pos, ang
end
