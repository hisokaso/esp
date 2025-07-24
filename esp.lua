-- Eleies Hub GUI (lila Style) mit God Mode, ESP, Perk Freeze & Infinite Jump

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EleiesHub"
ScreenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 380)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(48, 25, 52) -- dunkles Lila
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui
mainFrame.Active = true
mainFrame.Draggable = true

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Eleies Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 30
title.TextColor3 = Color3.fromRGB(180, 130, 210) -- helles Lila
title.Parent = mainFrame

local function createButton(text, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 320, 0, 40)
    btn.Position = UDim2.new(0, 15, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(120, 70, 180)
    btn.TextColor3 = Color3.fromRGB(240, 230, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Text = text
    btn.Parent = mainFrame
    btn.AutoButtonColor = true
    return btn
end

-- ESP
local espOn = false
local espHighlightList = {}

local function toggleESP()
    espOn = not espOn
    if espOn then
        for _, modell in pairs(workspace:GetDescendants()) do
            local humanoid = modell:FindFirstChild("Humanoid")
            if humanoid and humanoid:IsA("Humanoid") then
                if not espHighlightList[modell] then
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = modell
                    highlight.FillColor = Color3.new(1, 0, 1) -- lila
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = modell
                    espHighlightList[modell] = highlight
                end
            end
        end
    else
        for modell, highlight in pairs(espHighlightList) do
            if highlight and highlight.Parent then
                highlight:Destroy()
            end
        end
        espHighlightList = {}
    end
end

-- Unendlich Perk (f auf 100 oder true)
local function perkFreeze()
    for _, obj in ipairs(getgc(true)) do
        if typeof(obj) == "table" then
            if rawget(obj, "f") ~= nil then
                if typeof(obj.f) == "number" then
                    obj.f = 100
                elseif typeof(obj.f) == "boolean" then
                    obj.f = true
                end
            end
        end
    end
    print("✅ Perk Freeze ausgeführt!")
end

-- God Mode
local godModeActive = false
local godModeCoroutine

local function toggleGodMode()
    godModeActive = not godModeActive
    if godModeActive then
        print("✅ God Mode aktiviert")
        godModeCoroutine = coroutine.create(function()
            while godModeActive do
                local char = LocalPlayer.Character
                if char then
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health < humanoid.MaxHealth then
                        humanoid.Health = humanoid.MaxHealth
                    end
                end
                wait(0.1)
            end
        end)
        coroutine.resume(godModeCoroutine)
    else
        print("❌ God Mode deaktiviert")
        godModeCoroutine = nil
    end
end

-- Infinite Jump
local infiniteJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

local function toggleInfiniteJump()
    infiniteJumpEnabled = not infiniteJumpEnabled
    print("Infinite Jump:", infiniteJumpEnabled and "An" or "Aus")
end

-- Buttons
local espBtn = createButton("ESP an/aus", 60)
local perkBtn = createButton("Perk Freeze aktivieren", 110)
local godBtn = createButton("God Mode an/aus", 160)
local jumpBtn = createButton("Infinite Jump an/aus", 210)

espBtn.MouseButton1Click:Connect(toggleESP)
perkBtn.MouseButton1Click:Connect(perkFreeze)
godBtn.MouseButton1Click:Connect(toggleGodMode)
jumpBtn.MouseButton1Click:Connect(toggleInfiniteJump)
