function OpenFuckingMenu()
	local sizew = ScrW() / 2
	local sizeh = ScrH() / 2
	local Frame = vgui.Create("DFrame")
	Frame:SetPos( sizew - sizew / 2 , sizeh - sizeh / 2 )
    Frame:SetSize( sizew, sizeh )
	Frame:SetTitle( "" )
	Frame:SetDeleteOnClose( true )
	Frame:ShowCloseButton( false )
	Frame:SetDraggable( false )
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 200 ) ) -- Draw a red box instead of the frame
		draw.SimpleText( "클래스를 선택해주세요", "DefaultFontLargestAA", sizew / 2.375, sizeh / 16, Color( 0, 0, 0, 255 ) )
	end

	local mdl1 = vgui.Create( "DModelPanel", Frame )
	mdl1:Dock( LEFT )
	mdl1:DockMargin(sizew / 8, 0, 0, 0)
	mdl1:SetSize( 350, 350 )
	mdl1:SetModel( "models/player/Group01/male_07.mdl" )
	mdl1:SetCamPos( Vector( 40, 40, 40 ) )
	mdl1:SetAnimated( true )
	mdl1:SetText( "민간인" )
	mdl1:SetFont( "DefaultFontLargestAA" )
	mdl1:SetTextColor( Color( 163, 201, 255 ) )
	function mdl1.Entity:GetPlayerColor() return Vector ( 226, 48, 16 ) end
	-- function mdl1:LayoutEntity ( ent )
	-- 	ent:SetSequence( ent:LookupSequence( "taunt_muscle" ) )
	-- 	if ( ent:GetCycle() >= 0.98 ) then ent:SetCycle( 0.02 ) end
	-- 	mdl1:RunAnimation()
	-- end

	mdl1.DoClick = function()
		InitialWorthMenu()
		Frame:Close()
	end

	local mdl2 = vgui.Create( "DModelPanel", Frame )
	mdl2:Dock( RIGHT )
	mdl2:DockMargin(0, 0, sizew / 8, 0)
	mdl2:SetSize( 350, 350 )
	mdl2:SetModel( "models/player/combine_soldier_prisonguard.mdl" )
	mdl2:SetCamPos( Vector( 40, 40, 40 ) )
	mdl2:SetAnimated( true )
	mdl2:SetText( "특수 병과" )
	mdl2:SetFont( "DefaultFontLargestAA" )
	mdl2:SetTextColor( Color( 163, 201, 255 ) )
	function mdl2.Entity:GetPlayerColor() return Vector ( 1, 0, 0 ) end

	mdl2.DoClick = function()
		OpenClassSelect()
		Frame:Close()
	end

end

function OpenClassSelect()
	local sizew = ScrW() / 2
	local sizeh = ScrH() / 2
	local Frame = vgui.Create("DFrame")
	Frame:SetPos( sizew - sizew / 2 , sizeh - sizeh / 2 )
    Frame:SetSize( sizew, sizeh )
	Frame:SetTitle( "" )
	Frame:SetDeleteOnClose( true )
	Frame:ShowCloseButton( false )
	Frame:SetDraggable( false )
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 200 ) ) -- Draw a red box instead of the frame
		draw.SimpleText( "병과 선택", "DefaultFontLargestAA", 5, 5, Color( 0, 0, 0, 255 ) )
	end

	local listclass = vgui.Create( 'DHorizontalScroller', Frame )
	listclass:Dock( FILL )

	for _, lst in pairs(Config.StartingClass) do
		local classitem = vgui.Create( "DModelPanel", listclass )
		classitem:SetSize( 300, 300 )
		classitem:Dock( LEFT )
		classitem:DockMargin( 5, 5, 5, 5 )
		classitem:SetText( lst.name )
		classitem:SetFont( "DefaultFontLargestAA" )\
		classitem:SetModel( table.Random( lst.model ) )
		classitem:SetCamPos( Vector( 40, 40, 40 ) )
		classitem:SetAnimated( true )
	end


// TODO : config.lua에서 classes 불러오기
	
end