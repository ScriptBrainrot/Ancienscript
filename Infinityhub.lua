-- Infinity Hub - Mobile Compatible Full Script with Auto Lock Fix

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "InfinityHubUI"
ScreenGui.ResetOnSpawn = false

local openButton = Instance.new("TextButton", ScreenGui)
openButton.Size = UDim2.new(0, 150, 0, 50)
openButton.Position = UDim2.new(0, 20, 0, 140)
openButton.Text = "🌸 Infinity Hub"
openButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
openButton.TextScaled = true
openButton.TextColor3 = Color3.new(1,1,1)
openButton.Font = Enum.Font.GothamBold

local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 350, 0, 420)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
Instance.new("UICorner", mainFrame)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "🌸 Infinity Hub"
title.BackgroundTransparency = 1
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Tabs
local tabButtons, contentFrames = {}, {}
local tabNames = {"Main", "AutoFarm", "Misc"}

for i, name in ipairs(tabNames) do
	local button = Instance.new("TextButton", mainFrame)
	button.Size = UDim2.new(0, 100, 0, 30)
	button.Position = UDim2.new(0, 10 + (i - 1) * 110, 0, 55)
	button.Text = name
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	button.TextColor3 = Color3.new(1,1,1)
	button.Font = Enum.Font.Gotham
	button.TextScaled = true
	tabButtons[name] = button

	local frame = Instance.new("Frame", mainFrame)
	frame.Size = UDim2.new(1, -20, 1, -100)
	frame.Position = UDim2.new(0, 10, 0, 95)
	frame.BackgroundTransparency = 1
	frame.Visible = name == "Main"
	contentFrames[name] = frame
end

for name, button in pairs(tabButtons) do
	button.MouseButton1Click:Connect(function()
		for n, frame in pairs(contentFrames) do
			frame.Visible = n == name
		end
	end)
end

-- Save Preferences
local function savePreferences()
	writefile("InfinityHub_Preferences.txt", "Saved.")
end

-- Auto Steal
local function launchAutoStealScript()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Youifpg/Steal-a-Brianrot/refs/heads/main/ArbixHubBEST.lua"))()
end

-- Speed Boost
local function speedBoost()
	local function applySpeed()
		local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = 200 end
	end
	applySpeed()
	LocalPlayer.CharacterAdded:Connect(function()
		wait(1)
		applySpeed()
	end)
end

-- ESP
local function createESPForPlayer(p)
	if p ~= LocalPlayer then
		local function addESP(char)
			local head = char:WaitForChild("Head", 5)
			if head and not head:FindFirstChild("ESPTag") then
				local esp = Instance.new("BillboardGui", head)
				esp.Name = "ESPTag"
				esp.Size = UDim2.new(0, 200, 0, 50)
				esp.AlwaysOnTop = true
				esp.StudsOffset = Vector3.new(0, 2, 0)
				local nameLabel = Instance.new("TextLabel", esp)
				nameLabel.Size = UDim2.new(1, 0, 1, 0)
				nameLabel.BackgroundTransparency = 1
				nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
				nameLabel.Text = p.Name
				nameLabel.TextScaled = true
				nameLabel.Font = Enum.Font.GothamBold
			end
		end
		if p.Character then addESP(p.Character) end
		p.CharacterAdded:Connect(addESP)
	end
end

local function enableESP()
	for _, p in pairs(Players:GetPlayers()) do
		createESPForPlayer(p)
	end
	Players.PlayerAdded:Connect(function(p)
		createESPForPlayer(p)
	end)
end

-- Auto Lock (Mobile-Compatible)
local autoLockEnabled = false
local rotationConnection

local function toggleAutoLock()
	autoLockEnabled = not autoLockEnabled

	if autoLockEnabled then
		StarterGui:SetCore("SendNotification", {
			Title = "Infinity Hub",
			Text = "Auto Lock ACTIVATED (mobile compatible)",
			Duration = 4
		})

		rotationConnection = RunService.RenderStepped:Connect(function()
			if not LocalPlayer.Character then return end
			local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			local cam = workspace.CurrentCamera
			if hrp and cam then
				local look = cam.CFrame.lookVector
				local yaw = CFrame.new(Vector3.zero, Vector3.new(look.X, 0, look.Z))
				hrp.CFrame = CFrame.new(hrp.Position) * yaw
			end
		end)
	else
		if rotationConnection then
			rotationConnection:Disconnect()
			rotationConnection = nil
		end
		StarterGui:SetCore("SendNotification", {
			Title = "Infinity Hub",
			Text = "Auto Lock DEACTIVATED",
			Duration = 4
		})
	end
end

-- Copy Discord
local function copyDiscordLink()
	setclipboard("https://discord.gg/cRBvSXukR7")
	StarterGui:SetCore("SendNotification", {
		Title = "Infinity Hub",
		Text = "Infinity Hub link copy !",
		Duration = 4
	})
end

-- Button builder
local function createButton(parent, text, callback, order)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(1, 0, 0, 45)
	btn.Position = UDim2.new(0, 0, 0, (order - 1) * 50)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	btn.MouseButton1Click:Connect(callback)
end

-- Onglet Main
createButton(contentFrames.Main, "🏯 Auto Steal", launchAutoStealScript, 1)
createButton(contentFrames.Main, "⚡️ Speed Boost", speedBoost, 2)
createButton(contentFrames.Main, "💾 Save Preferences", savePreferences, 3)

-- Onglet AutoFarm
createButton(contentFrames.AutoFarm, "🎨 ESP", enableESP, 1)
createButton(contentFrames.AutoFarm, "➕ Auto Lock", toggleAutoLock, 2)

-- Onglet Misc
createButton(contentFrames.Misc, "Copy the link discord", copyDiscordLink, 1)

-- Toggle UI
openButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Multicolor Text
RunService.RenderStepped:Connect(function()
	local t = tick() * 0.4
	local color = Color3.fromHSV(t % 1, 1, 1)
	title.TextColor3 = color
	openButton.TextColor3 = color
end)
