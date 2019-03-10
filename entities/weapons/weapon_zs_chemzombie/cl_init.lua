INC_CLIENT()

SWEP.PrintName = "챔 좀비"
SWEP.DrawCrosshair = false

function SWEP:Think()
end

function SWEP:DrawHUD()
	if GetConVar("crosshair"):GetInt() ~= 1 then return end
	self:DrawCrosshairDot()
end
