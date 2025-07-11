local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

local FLY_HEIGHT = 150
local isFlying = false
local AirPlatform = nil

local function CreateSkyPlatform()
    if AirPlatform then return end
    AirPlatform = Instance.new("Part")
    AirPlatform.Name = "PermanentSkyPlatform"
    AirPlatform.Size = Vector3.new(10000, 5, 10000)
    AirPlatform.Position = Vector3.new(0, FLY_HEIGHT, 0)
    AirPlatform.Anchored = true
    AirPlatform.Transparency = 1
    AirPlatform.CanCollide = true
    AirPlatform.CollisionGroup = "SkyPlatform"
    AirPlatform.Parent = Workspace
    AirPlatform:SetAttribute("Permanent", true)
end

-- GUI principale
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "StealInfinityGUI"
ScreenGui.ResetOnSpawn = false

-- Fenêtre principale (noire arrondie)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

-- Titre Steal | Infinity Hub
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0.4, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Steal | Infinity Hub"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- Bouton bleu Steal / Down
local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0.7, 0, 0.4, 0)
Button.Position = UDim2.new(0.15, 0, 0.5, 0)
Button.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Font = Enum.Font.GothamBold
Button.TextScaled = true
Button.Text = "Steal"
Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

-- Notification personnalisée verte en bas
local Notify = Instance.new("TextLabel", ScreenGui)
Notify.Size = UDim2.new(0.8, 0, 0, 40)
Notify.Position = UDim2.new(0.1, 0, 1, -60)
Notify.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Notify.TextColor3 = Color3.new(0, 0, 0)
Notify.Font = Enum.Font.GothamSemibold
Notify.TextScaled = true
Notify.Text = "Thanks use our script for better join our discord server for v2 https://discord.gg/ZVX8GNMNaD"
Notify.BackgroundTransparency = 0.2
Notify.BorderSizePixel = 0
Instance.new("UICorner", Notify).CornerRadius = UDim.new(1, 0)

-- Auto-destruction après 8 secondes
task.delay(8, function()
    if Notify then
        Notify:Destroy()
    end
end)

-- Action du bouton Steal/Down
Button.MouseButton1Click:Connect(function()
    if not isFlying then
        CreateSkyPlatform()
        isFlying = true
        local pos = RootPart.Position
        RootPart.CFrame = CFrame.new(pos.X, FLY_HEIGHT + 3, pos.Z)
        Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        Button.Text = "Down"
    else
        local rayOrigin = Vector3.new(RootPart.Position.X, FLY_HEIGHT - 2, RootPart.Position.Z)
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {Character}
        rayParams.CollisionGroup = "Default"
        local rayResult = Workspace:Raycast(rayOrigin, Vector3.new(0, -1000, 0), rayParams)
        if rayResult then
            RootPart.CFrame = CFrame.new(rayResult.Position + Vector3.new(0, 3, 0))
        end
        isFlying = false
        Button.Text = "Steal"
    end
end)

-- Maintien du sol actif
workspace.ChildAdded:Connect(function(child)
    if child.Name == "PermanentSkyPlatform" then
        child:SetAttribute("Permanent", true)
    end
end)

print("✅ Steal | Infinity Hub chargé avec notification.")
