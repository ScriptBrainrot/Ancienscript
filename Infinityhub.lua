local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

local FLY_HEIGHT = 150
local isFlying = false
local AirPlatform = nil

-- Fonction de vol
local function CreateSkyPlatform()
    if AirPlatform then return end
    AirPlatform = Instance.new("Part")
    AirPlatform.Name = "PermanentSkyPlatform"
    AirPlatform.Size = Vector3.new(10000, 5, 10000)
    AirPlatform.Position = Vector3.new(0, FLY_HEIGHT, 0)
    AirPlatform.Anchored = true
    AirPlatform.Transparency = 1
    AirPlatform.CanCollide = true
    AirPlatform.Parent = Workspace
    AirPlatform:SetAttribute("Permanent", true)
end

-- Création du ScreenGui
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "InfinityHubKeySystem"
ScreenGui.ResetOnSpawn = false

-- UI de vérification de clé
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyFrame.BorderSizePixel = 0
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)

-- Titre
local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0.25, 0)
KeyTitle.Position = UDim2.new(0, 0, 0, 0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "Code System"
KeyTitle.TextColor3 = Color3.new(1, 1, 1)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextScaled = true

-- Zone de texte
local TextBox = Instance.new("TextBox", KeyFrame)
TextBox.Size = UDim2.new(0.9, 0, 0.3, 0)
TextBox.Position = UDim2.new(0.05, 0, 0.35, 0)
TextBox.PlaceholderText = "Enter Code Here"
TextBox.Text = ""
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.Gotham
TextBox.TextScaled = true
TextBox.TextColor3 = Color3.new(0, 0, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

-- Bouton Check
local CheckButton = Instance.new("TextButton", KeyFrame)
CheckButton.Size = UDim2.new(0.6, 0, 0.25, 0)
CheckButton.Position = UDim2.new(0.2, 0, 0.7, 0)
CheckButton.Text = "CHECK"
CheckButton.TextScaled = true
CheckButton.Font = Enum.Font.GothamBold
CheckButton.TextColor3 = Color3.new(1, 1, 1)
CheckButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
Instance.new("UICorner", CheckButton).CornerRadius = UDim.new(0, 8)

-- Fonction d'affichage du GUI principal
local function ShowMainGUI()
    -- Fenêtre principale
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 200, 0, 100)
    Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Active = true
    Frame.Draggable = true
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

    -- Titre
    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(1, 0, 0.4, 0)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.Text = "Steal | Infinity Hub"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextScaled = true

    -- Bouton principal
    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(0.7, 0, 0.4, 0)
    Button.Position = UDim2.new(0.15, 0, 0.5, 0)
    Button.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Font = Enum.Font.GothamBold
    Button.TextScaled = true
    Button.Text = "Steal"
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

    -- Notification verte personnalisée
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

    task.delay(8, function()
        if Notify then Notify:Destroy() end
    end)

    -- Fonction du bouton
    Button.MouseButton1Click:Connect(function()
        if not isFlying then
            CreateSkyPlatform()
            isFlying = true
            RootPart.CFrame = CFrame.new(RootPart.Position.X, FLY_HEIGHT + 3, RootPart.Position.Z)
            Humanoid:ChangeState(Enum.HumanoidStateType.Running)
            Button.Text = "Down"
        else
            local rayOrigin = Vector3.new(RootPart.Position.X, FLY_HEIGHT - 2, RootPart.Position.Z)
            local rayResult = Workspace:Raycast(rayOrigin, Vector3.new(0, -1000, 0))
            if rayResult then
                RootPart.CFrame = CFrame.new(rayResult.Position + Vector3.new(0, 3, 0))
            end
            isFlying = false
            Button.Text = "Steal"
        end
    end)
end

-- Vérification de la clé
CheckButton.MouseButton1Click:Connect(function()
    local entered = string.lower(TextBox.Text)
    if entered == "infinity hub" then
        KeyFrame:Destroy()
        ShowMainGUI()
    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "❌ Invalid Code"
    end
end)
