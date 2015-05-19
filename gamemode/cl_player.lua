local Player = FindMetaTable('Player')

-- mouse down

function Player:GetMouseDown()
	return self.MouseDown or false
end

function Player:SetMouseDown(bool)
	net.Start('MouseDown')
		net.WriteBit(bool)
	net.SendToServer()
end

-- mouse height

function Player:GetPitch()
	return self.Pitch or 0
end

function Player:SetPitch(pitch)
	net.Start('Pitch')
		net.WriteDouble(pitch)
	net.SendToServer()
end

-- instrument

function Player:GetInstrument()
	return self.Instrument or 1
end

function Player:SetInstrument(instrument)
	net.Start('Instrument')
		net.WriteDouble(instrument)
	net.SendToServer()
end

-- net hooks

net.Receive('MouseDown', function()
	local ply = net.ReadEntity()
	local down = net.ReadBit()
	
	ply.MouseDown = down == 1 and true or false
end)

net.Receive('Pitch', function()
	local ply = net.ReadEntity()
	local pitch = net.ReadDouble()
	
	ply.Pitch = pitch
end)

net.Receive('Instrument', function()
	local ply = net.ReadEntity()
	local instrument = net.ReadDouble()
	
	if not GAMEMODE.Instruments[instrument] then print('inv:', instrument) end
	
	ply.Instrument = instrument
end)
