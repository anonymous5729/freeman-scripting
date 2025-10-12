local player = game:GetService("Players").LocalPlayer

-- Atenção, aqui abaixo é onde deve adicionar os players.

local premiumUsers = {
    ["JumexD24"] = true,
    ["PremiumUser1"] = true,
    ["PremiumUser2"] = true,
    ["NovoPremium"] = true
}

local function isAllowed(name)
    return premiumUsers[name]
end

local gui = Instance.new("ScreenGui")
gui.Name = "FreemanVerificationHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 120)
frame.Position = UDim2.new(0.5, -150, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,32)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "FREEMAN HUB - VERIFICATION"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(0,120,255)

local msg = Instance.new("TextLabel", frame)
msg.Size = UDim2.new(1,-16,0,42)
msg.Position = UDim2.new(0,8,0,40)
msg.BackgroundTransparency = 1
msg.Text = "Verificando acesso..."
msg.Font = Enum.Font.Gotham
msg.TextSize = 18
msg.TextColor3 = Color3.fromRGB(255,255,255)

local function executarPremium()
    msg.Text = "Função premium executada!"
    frame.BackgroundColor3 = Color3.fromRGB(10, 60, 20)
    wait(1.5)
    gui:Destroy()
end

coroutine.wrap(function()
    msg.Text = "Verificando acesso..."
    wait(3)
    if isAllowed(player.Name) then
        msg.Text = "✅ Usuário Liberado, executando premium..."
        wait(1)
        executarPremium()
    else
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://3069892996"
        s.Volume = 5
        s.Looped = false
        s.Parent = workspace
        s:Play()
        wait(1)
        player:Kick("Você não tem permissão para usar esse script,\nadquira no nosso discord.")
    end
end)()