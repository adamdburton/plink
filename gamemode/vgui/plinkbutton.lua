local PANEL = {}

function PANEL:Init()
	
	self:Show()
	
end

function PANEL:DoClick()
	
	LocalPlayer():SetInstrument(self.InstrumentID)
	
end

function PANEL:Paint()
	
	-- background
	
	surface.SetDrawColor(GAMEMODE.Colors[self.InstrumentID])
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
	

end

vgui.Register('PlinkButton', PANEL, 'DButton')