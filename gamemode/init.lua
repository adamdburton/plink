AddCSLuaFile('shared.lua')
AddCSLuaFile('cl_init.lua')
AddCSLuaFile('cl_player.lua')

AddCSLuaFile('vgui/plinkbackground.lua')
AddCSLuaFile('vgui/plinkbutton.lua')

for _, n in pairs({ '8bit_stab', 'bassdist', 'bee_long', 'bziaou', 'drums', 'note', 'syntklocka_stab', 'voice', 'woody' }) do
	for i = 1, 16 do
		resource.AddFile('sound/plink/' .. n .. '/' .. n .. '_' .. i .. '.mp3')
	end
end

resource.AddFile('materials/plink/playercircle.vtf')
resource.AddFile('materials/plink/playercircle.vmt')
resource.AddFile('materials/plink/playercircle2.vtf')
resource.AddFile('materials/plink/playercircle2.vmt')

include('shared.lua')
include('sv_player.lua')

DEFINE_BASECLASS("gamemode_base")

function GM:Think()
	
end