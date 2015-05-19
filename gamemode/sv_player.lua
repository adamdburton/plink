local Player = FindMetaTable('Player')

-- mouse down

function Player:SetMouseDown(bool)
	net.Start('MouseDown')
		net.WriteEntity(self)
		net.WriteBit(bool)
	net.Broadcast()
end

-- pitch

function Player:SetPitch(pitch)
	net.Start('Pitch')
		net.WriteEntity(self)
		net.WriteDouble(pitch)
	net.Broadcast()
end

function Player:SetInstrument(instrument)
	net.Start('Instrument')
		net.WriteEntity(self)
		net.WriteDouble(instrument, 1)
	net.Broadcast()
end

-- net hooks

net.Receive('MouseDown', function(length, ply)
	local down = net.ReadBit()	
	ply:SetMouseDown(down == 1 and true or false)
end)

net.Receive('Pitch', function(length, ply)
	local pitch = net.ReadDouble()	
	ply:SetPitch(pitch)
end)

net.Receive('Instrument', function(length, ply)
	local instrument = net.ReadDouble()
	ply:SetInstrument(instrument)
end)

-- network strings

util.AddNetworkString('MouseDown')
util.AddNetworkString('Pitch')
util.AddNetworkString('Instrument')