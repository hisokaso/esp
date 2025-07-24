
--// Variablen
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

--// ESP Funktionen
local highlightTable = {}

local function enableESP()
    for _, model in pairs(workspace:GetDescendants()) do
        local humanoid = model:FindFirstChildOfClass("Humanoid")
        if humanoid and not highlightTable[model] then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = model
            highlight.FillColor = Color3.new(1, 0, 0)
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = model
            highlightTable[model] = highlight
        end
    end
end

local function disableESP()
    for model, highlight in pairs(highlightTable) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    highlightTable = {}
end

--// GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ESPGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 120, 0, 40)
Button.Position = UDim2.new(0, 20, 0, 20)
Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Text = "ESP AN"
Button.Parent = ScreenGui

local espActive = false

Button.MouseButton1Click:Connect(function()
    espActive = not espActive
    if espActive then
        enableESP()
        Button.Text = "ESP AUS"
    else
        disableESP()
        Button.Text = "ESP AN"
    end
end)

-- Optional: Damit neu gespawnte Spieler auch markiert werden, wenn ESP aktiv ist
RunService.Heartbeat:Connect(function()
    if espActive then
        enableESP()
    end
end)
