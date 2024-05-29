local checkpoints = {} -- Table to store checkpoint data

-- Function to set a checkpoint
function setCheckpoint(checkpointName, position)
	checkpoints[checkpointName] = position
end

-- Function to teleport player to a checkpoint
function teleportToCheckpoint(checkpointName)
	if checkpoints[checkpointName] then
		local player = game.Players.LocalPlayer
		local character = player.Character
		character:MoveTo(checkpoints[checkpointName])
	else
		print("Checkpoint not found:", checkpointName)
	end
end

-- Set up initial checkpoints
setCheckpoint("Start", game.Workspace.SpawnLocation.Position)
setCheckpoint("Checkpoint1", Vector3.new(100, 50, 0))
setCheckpoint("Checkpoint2", Vector3.new(200, 100, 0))

-- Handle player respawn
local player = game.Players.LocalPlayer
player.Character.Humanoid.Died:Connect(function()
	teleportToCheckpoint("Start")
end)

-- Handle checkpoint triggers
local function touchCheckpoint(part)
	if part.Parent:FindFirstChild("Checkpoint") then
		local checkpointName = part.Parent.Name
		teleportToCheckpoint(checkpointName)
		print("Reached checkpoint:", checkpointName)
	end
end

game.Workspace.TouchTransmitter:Connect(touchCheckpoint)
