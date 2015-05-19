include('shared.lua')
include('cl_player.lua')

include('vgui/plinkbackground.lua')
include('vgui/plinkbutton.lua')

DEFINE_BASECLASS("gamemode_base")

GM.BPM = 360
GM.Beats = 0
GM.Sounds = {}

GM.Instruments = {
	'drums',
	'voice',
	'bee_long',
	'bassdist',
	'woody',
	'bziaou',
	'8bit_stab',
	'syntklocka_stab',
	'note'
}

GM.Colors = {
	Color(0, 192, 0),
	Color(250, 102, 250),
	Color(140, 140, 140),
	Color(15, 150, 250),
	Color(250, 175, 89),
	Color(250, 0, 0),
	Color(23, 87, 100),
	Color(250, 250, 50),
	Color(250, 250, 50),
	Color(250, 175, 89)
}

GM.SoundPitches = 16
GM.PitchHeight = ScrH() / GM.SoundPitches
GM.PitchHeightPercent = (GM.PitchHeight / ScrH()) * 100

function GM:Initialize()
	
	self.GUI = vgui.Create('PlinkBackground')
	
	timer.Create('Beats', 1 / (self.BPM / 60), 0, function()
		self:Beat()
	end)
	
	timer.Create('GUIUpdate', (1 / (self.BPM / 60)) / 8, 0, function()
		self.GUI:Beat()
	end)
	
	for k, v in pairs(self.Instruments) do
		for i = 1, 16 do
			util.PrecacheSound('plink/' .. v .. '/' .. v .. '_' .. i .. '.mp3')
		end
	end
	
end

function GM:InitPostEntity()
	
	self:CreateSounds()
	
end

function GM:CreateSounds()
	
	for k, v in pairs(self.Instruments) do
		self.Sounds[k] = {}
		
		for i = 1, 16 do
			--self.Sounds[k][i] = CreateSound(LocalPlayer(), )
		end
	end
	
end

function GM:PlaySound(id, note)

	if not self.Sounds[id] then Error('Invalid instrument: ' .. id) end
	
	surface.PlaySound('plink/' .. self.Instruments[id] .. '/' .. self.Instruments[id] .. '_' .. note .. '.mp3')
	
end

function GM:Beat()
	
	self.Beats = self.Beats + 1
	
	if self.Beats % 4 == 0 then
		
		self:PlaySound(1, 1)
		
	end
	
	if self.Beats % 8 == 0 then
		
		self:PlaySound(1, 2)
		
	end

	for _, ply in pairs(player.GetAll()) do
		if ply:GetMouseDown() then			
			self:PlaySound(ply:GetInstrument(), self:PercentageToNote(ply:GetPitch())) -- pitches from 0 to 200 instead of 100
		end
	end
	
end

function GM:PercentageToNote(percentage)

	return 1 + math.floor(percentage / 6.66)
	
end
