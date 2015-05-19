surface.CreateFont('PlayerName', { font = 'Trebuchet MS', size = 20, weight = 900 })
local playercircle = surface.GetTextureID("plink/playercircle");
local playercircle2 = surface.GetTextureID("plink/playercircle2");

local PANEL = {}

function PANEL:Init()
	
	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)
	
	self:Show()
	
	gui.EnableScreenClicker(true)
	
	-- instrument buttons
	
	local half = self:GetTall() / 2
	local instruments = #GAMEMODE.Instruments
	local buttonsize = 30
	
	local x = 0
	local y = half - (buttonsize * (instruments / 2))
	
	for k, v in pairs(GAMEMODE.Instruments) do
		local button = vgui.Create('PlinkButton', self)
		button.InstrumentID = k
		button:SetPos(x, y)
		button:SetSize(buttonsize, buttonsize)
		button:SetText('')
		button:Show()
		
		y = y + buttonsize
	end
	
end

function PANEL:OnMousePressed(mc)
	
	if mc == MOUSE_LEFT then
		LocalPlayer():SetMouseDown(true)
	end
	
end

function PANEL:OnMouseReleased(mc)
	
	if mc == MOUSE_LEFT then
		LocalPlayer():SetMouseDown(false)
	end
	
end

function PANEL:OnCursorMoved(x, y)

	local dist = self:GetTall() - y
	local percentage = (dist / self:GetTall()) * 100
	
	LocalPlayer():SetPitch(percentage)
	
end

function PANEL:Beat()
	
	for _, ply in pairs(player.GetAll()) do
		if not ply.History then ply.History = {} end
		
		table.insert(ply.History, {
			y = self:PercentageToY(ply:GetPitch()),
			down = ply:GetMouseDown()
		})
		
		if #ply.History > (ScrW() / 2) / 16 then
			table.remove(ply.History, 1)
		end
	end
	
end

function PANEL:Paint()
	
	-- background
	
	if GAMEMODE.Beats % 4 == 0 then
		surface.SetDrawColor(45, 45, 45, 255)
	else
		surface.SetDrawColor(40, 40, 40, 255)
	end
	
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
	
	-- lines
	
	surface.SetDrawColor(67, 67, 67, 255)
	
	for i = 1, GAMEMODE.SoundPitches - 1 do
		surface.DrawLine(0, i * GAMEMODE.PitchHeight, ScrW(), i * GAMEMODE.PitchHeight)
	end
	
	-- players
	
	for _, ply in pairs(player.GetAll()) do
		
		surface.SetDrawColor(GAMEMODE.Colors[ply:GetInstrument()])
		
		if ply.History then
			for k, info in pairs(ply.History) do
				if info.down then
					surface.SetTexture(playercircle)
				else
					surface.SetTexture(playercircle2)
				end
				
				surface.DrawTexturedRect((k * 16) - 32, info.y - 8, 16, 16)
			end
		end
		
		surface.DrawTexturedRect((self:GetWide() / 2) - 16, self:PercentageToY(ply:GetPitch()) - 16, 32, 32)
		draw.SimpleText(ply:Nick(), 'PlayerName', (self:GetWide() / 2) + 16, self:PercentageToY(ply:GetPitch()) + 16, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

end

function PANEL:PercentageToY(percentage)
	
	local dist = (percentage / 100) * self:GetTall()
	
	return self:GetTall() - dist
	
end

vgui.Register('PlinkBackground', PANEL)