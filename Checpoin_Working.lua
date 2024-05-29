-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Variables
local CHECKPOINT_POSITION = Vector3.new(0, 5, 0) -- The position of the checkpoint
local CHECKPOINT_RADIUS = 5 -- The radius of the checkpoint

-- Function to check if a player is in the checkpoint
local function checkCheckpoint(player)
	-- Get the player's character
	local character = player.Character
	if character then
		-- Get the player's humanoid
		local humanoid = character:WaitForChild("Humanoid")
		if humanoid then
			-- Check if the player is in the checkpoint
			local distance = (humanoid.RootPart.Position - CHECKPOINT_POSITION).Magnitude
			if distance <= CHECKPOINT_RADIUS then
				-- Teleport the player to the checkpoint
				humanoid.RootPart.CFrame = CFrame.new(CHECKPOINT_POSITION)
			end
		end
	end
end

-- Listen for player joins
Players.PlayerAdded:Connect(function(player)
	-- Wait for the player's character to load
	player.CharacterAdded:Wait()
	-- Check if the player is in the checkpoint
	checkCheckpoint(player)
end)

-- Listen for player movements
RunService.Heartbeat:Connect(function()
	-- Check if any players are in the checkpoint
	for _, player in pairs(Players:GetPlayers()) do
		checkCheckpoint(player)
	end
end)