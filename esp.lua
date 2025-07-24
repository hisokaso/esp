for _, modell in pairs(workspace:GetDescendants()) do
    local humanoid = modell:FindFirstChild("internal humanoid")
    if humanoid and humanoid:IsA("Humanoid") then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = modell
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = modell
    end
end
