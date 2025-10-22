local player = game:GetService("Players").LocalPlayer
local tweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local tagMap = {
    ["Kaua_452"] = {tag = "👑 OWNER", color = Color3.fromRGB(255, 215, 0), gradient = Color3.fromRGB(255, 175, 0)},
    ["pedro312jee"] = {tag = "👑 SUB-OWNER", color = Color3.fromRGB(255, 30, 70), gradient = Color3.fromRGB(255, 90, 140)},
    ["thiagojuniorgamer12"] = {tag = "👑 SUB-OWNER", color = Color3.fromRGB(255, 30, 70), gradient = Color3.fromRGB(255, 90, 140)},
    ["Itz_Mariena"] = {tag = "🎩 OVERSEER", color = Color3.fromRGB(128, 0, 128), gradient = Color3.fromRGB(180, 0, 220)},
    ["User"] = {tag = "🛠 STAFF", color = Color3.fromRGB(0, 180, 255), gradient = Color3.fromRGB(0, 250, 255)},
}
local function getPlayerTag(plr)
    if tagMap[plr.Name] then
        return tagMap[plr.Name].tag, tagMap[plr.Name].color, tagMap[plr.Name].gradient
    elseif plr == player then
        return "💎 PREMIUM", Color3.fromRGB(0,120,255), Color3.fromRGB(0,180,255)
    else
        return nil, nil, nil
    end
end
local tagType, tagColor, tagGradient = getPlayerTag(player)

local musicIDs = {
    ["1"] = 94718473830640, ["2"] = 92209428926055, ["3"] = 133900561957103, ["4"] = 93768636184697,
    ["5"] = 92062588329352, ["6"] = 84773737820526, ["7"] = 87783857221289, ["8"] = 88342296270082,
    ["9"] = 85342086082111, ["10"] = 93058983119992, ["11"] = 92492039534399, ["12"] = 134035788881796,
    ["13"] = 18841893567, ["14"] = 73962723234161, ["15"] = 140268583413209, ["16"] = 77741294709660,
    ["17"] = 71531533552899, ["18"] = 16190782181, ["19"] = 117169209277972, ["20"] = 81299332131868,
    ["21"] = 77147911349059, ["22"] = 124092830839928, ["23"] = 122854357582130, ["24"] = 88094479399489,
    ["25"] = 88339486019486, ["26"] = 97765714111493, ["27"] = 92446612272052, ["28"] = 74366765967475,
    ["29"] = 112068892721408, ["30"] = 112143944982807, ["31"] = 111668097052966, ["32"] = 112214814544629,
    ["33"] = 101500915434329, ["34"] = 95046091312570, ["35"] = 110091098283354, ["36"] = 17422156627,
    ["37"] = 82411642961457, ["38"] = 87022583947683, ["39"] = 96974354995715, ["40"] = 119020235792430,
    ["41"] = 82411642961457, ["42"] = 96215620202470,
    ["43"] = 70782176012619, ["44"] = 112893354276338, ["45"] = 118507373399694, ["46"] = 98691879232718,
    ["47"] = 134457296749518, ["48"] = 118607303205005, ["49"] = 127504762051765, ["50"] = 118297487529239,
    ["51"] = 132082397247824, ["52"] = 106958630419629, ["53"] = 86685635786943, ["54"] = 101456813429584,
    ["55"] = 100533213305793,
}

local musicNames = {
    ["1"] = "Funk da Febre", ["2"] = "Switch The Colors (Jersey Club)", ["3"] = "Trash Funk",
    ["4"] = "2609 (Jersey Club)", ["5"] = "Spooky Scary Sunday (Jersey Club)", ["6"] = "ANOTE AÍ",
    ["7"] = "Temptation", ["8"] = "Ela Tano", ["9"] = "Seu fã",
    ["10"] = "MONTAGEM ECLIPSE ESTRELAR", ["11"] = "Em Dezembro de 81 - Flamengo",
    ["12"] = "Esquema Confirmado - Arrocha", ["13"] = "JERSEY WAVE", ["14"] = "Arrepia XL 2",
    ["15"] = "Meepcity (Jersey Club)", ["16"] = "Manda Meu Passinho", ["17"] = "Lembro até hoje",
    ["18"] = "HR - EEYUH!", ["19"] = "I love ha", ["20"] = "SHE DON'T - Lonelybwoi",
    ["21"] = "NY Drill Ritual", ["22"] = "It Doesn't Matter (Jersey Club)", ["23"] = "69 PHONK",
    ["24"] = "Ela se envolveu", ["25"] = "Montagem Pose", ["26"] = "Trem Fantasma Funk",
    ["27"] = "MTG ZUM ZUM ZUM", ["28"] = "EU NÃO ESTOU LOUCO", ["29"] = "FUNK DA PRAIA (SLOWED)",
    ["30"] = "Hogo Funk", ["31"] = "Novinha sapeca", ["32"] = "ANALOG HORROR FUNK",
    ["33"] = "Dum Dum", ["34"] = "Rebola pro pai", ["35"] = "Carro Bixo",
    ["36"] = "Onichan", ["37"] = "Arrepia XL 6", ["38"] = "Mandrake", ["39"] = "Toma Toma",
    ["40"] = "Lá no meu barraco", ["41"] = "Batida SP", ["42"] = "Funk SP",
    ["43"] = "Pega no cipó", ["44"] = "Rap do Minecraft (Funk)", ["45"] = "Melodia do Verão",
    ["46"] = "Funk do Famglia", ["47"] = "Vem no pique (Phonk)", ["48"] = "Michael Jackson FUNK",
    ["49"] = "Arrepia XL 4", ["50"] = "MONTAGEM NOVA MÁGICA 1.0", ["51"] = "V2 Daquela (XL Funk)",
    ["52"] = "Digitei seu número (Sertanejo)", ["53"] = "Auto toma", ["54"] = "Montagem Balanço",
    ["55"] = "Piseiro com sertanejo",
}

local gold = Color3.fromRGB(255,215,0)
local white = Color3.fromRGB(255,255,255)
local darkBg = Color3.fromRGB(20,20,20)
local accentBg = Color3.fromRGB(40,40,20)

local function getPlayerGui()
    local gui = player:FindFirstChildOfClass("PlayerGui")
    while not gui do wait() gui = player:FindFirstChildOfClass("PlayerGui") end
    return gui
end

-- TAG personalizada e animada
local function showTagForPlayer(plr)
    local tType, tColor, tGradient = getPlayerTag(plr)
    local function addTag()
        if not tType then return end
        local char = plr.Character
        if not char or not char:FindFirstChild("Head") then return end
        if char:FindFirstChild("AuralynxTag") then char.AuralynxTag:Destroy() end
        local tag = Instance.new("BillboardGui", char)
        tag.Name = "AuralynxTag"
        tag.Size = UDim2.new(0, 150, 0, 52)
        tag.StudsOffset = Vector3.new(0, 3.6, 0)
        tag.Adornee = char:FindFirstChild("Head")
        tag.AlwaysOnTop = true
        tag.MaxDistance = 70

        local bg = Instance.new("Frame", tag)
        bg.Size = UDim2.new(1,0,1,0)
        bg.BackgroundTransparency = 0.35
        bg.BackgroundColor3 = tColor or Color3.fromRGB(40,40,40)
        local corner = Instance.new("UICorner", bg)
        corner.CornerRadius = UDim.new(1, 0)

        local gradient = Instance.new("UIGradient", bg)
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, tColor or Color3.fromRGB(255,255,255)),
            ColorSequenceKeypoint.new(1, tGradient or Color3.fromRGB(200,200,200))
        }
        gradient.Rotation = 90

        local txt = Instance.new("TextLabel", bg)
        txt.Size = UDim2.new(1,0,1,0)
        txt.BackgroundTransparency = 1
        txt.Text = tType
        txt.TextColor3 = Color3.fromRGB(255,255,255)
        txt.TextStrokeTransparency = 0.2
        txt.Font = Enum.Font.FredokaOne
        txt.TextSize = 24
        txt.TextStrokeColor3 = tColor or Color3.fromRGB(255,255,255)
        txt.TextXAlignment = Enum.TextXAlignment.Center

        local glow = Instance.new("UIStroke", bg)
        glow.Color = tGradient or Color3.fromRGB(255,255,255)
        glow.Thickness = 3.5
        glow.Transparency = 0.4

        local pulseTween = tweenService:Create(bg, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.55})
        pulseTween:Play()
    end
    if plr.Character then addTag() end
    plr.CharacterAdded:Connect(function() wait(1) addTag() end)
end
for _,plr in ipairs(game:GetService("Players"):GetPlayers()) do
    showTagForPlayer(plr)
end
game:GetService("Players").PlayerAdded:Connect(function(plr)
    showTagForPlayer(plr)
end)

local tagType, tagColor, tagGradient = getPlayerTag(player)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AuralynxHubPremium"
screenGui.ResetOnSpawn = false
screenGui.Parent = getPlayerGui()
local mainFrame = Instance.new("Frame")
mainFrame.Name = "AuralynxMusicMain"
mainFrame.Size = UDim2.new(0, 370, 0, 470)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = darkBg
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = tagColor or gold
mainStroke.Thickness = 2
mainStroke.Transparency = 0.7

local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 54)
header.BackgroundTransparency = 1
header.Name = "Header"
header.ZIndex = 2

local icon = Instance.new("TextLabel", header)
icon.Text = "⭐"
icon.Font = Enum.Font.GothamBlack
icon.TextSize = 34
icon.TextColor3 = tagColor or gold
icon.Size = UDim2.new(0, 44, 0, 44)
icon.Position = UDim2.new(0, 0, 0, 0)
icon.BackgroundTransparency = 1

local headerTitle = Instance.new("TextLabel", header)
headerTitle.Text = "Auralynx - Premium"
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextSize = 15
headerTitle.TextColor3 = tagColor or gold
headerTitle.BackgroundTransparency = 1
headerTitle.Size = UDim2.new(1, -90, 0, 34)
headerTitle.Position = UDim2.new(0, 44, 0, 0)
headerTitle.TextXAlignment = Enum.TextXAlignment.Left

local divider = Instance.new("Frame", mainFrame)
divider.Name = "Divider"
divider.Size = UDim2.new(0.85, 0, 0, 2)
divider.Position = UDim2.new(0.075, 0, 0, 52)
divider.BackgroundColor3 = tagColor or gold
divider.BorderSizePixel = 0
local dividerGradient = Instance.new("UIGradient", divider)
dividerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, tagColor or gold),
    ColorSequenceKeypoint.new(0.5, white),
    ColorSequenceKeypoint.new(1, tagColor or gold)
})

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -44, 0, 8)
closeBtn.BackgroundColor3 = accentBg
closeBtn.Text = "X"
closeBtn.TextColor3 = tagColor or gold
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.AutoButtonColor = true
closeBtn.Active = true
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
local closeBtnStroke = Instance.new("UIStroke", closeBtn)
closeBtnStroke.Color = tagColor or gold
closeBtnStroke.Thickness = 1.25
closeBtnStroke.Transparency = 0.7

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 36, 0, 36)
minimizeBtn.Position = UDim2.new(1, -88, 0, 8)
minimizeBtn.BackgroundColor3 = accentBg
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = tagColor or gold
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
minimizeBtn.AutoButtonColor = true
minimizeBtn.Active = true
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(1, 0)
local minimizeBtnStroke = Instance.new("UIStroke", minimizeBtn)
minimizeBtnStroke.Color = tagColor or gold
minimizeBtnStroke.Thickness = 1.25
minimizeBtnStroke.Transparency = 0.7

local playMode = "REAL"
local visualizerEnabled = true
local playingSoundObj = nil
local visualizerParts, visualizerConn = {}, nil

local function formatTime(t)
    t = math.max(0, math.floor(t or 0))
    local m = math.floor(t/60)
    local s = t%60
    return string.format("%02d:%02d", m, s)
end

local function removeVisualizer()
    for _, part in ipairs(visualizerParts) do
        if part and part.Parent then part:Destroy() end
    end
    visualizerParts = {}
    if visualizerConn then visualizerConn:Disconnect() visualizerConn = nil end
end

local function getSoundForVisualizer()
    if playMode == "CLIENT" then return playingSoundObj end
    local char = player.Character
    if not char then return nil end
    for _, obj in ipairs(char:GetDescendants()) do
        if obj:IsA("Sound") and obj.IsPlaying then return obj end
    end
    return nil
end

local function createVisualizer()
    removeVisualizer()
    visualizerParts = {}
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local lines = 12
    local radius = 4
    for i = 1, lines do
        local line = Instance.new("Part")
        line.Size = Vector3.new(0.15, 0.7, 0.15)
        line.Anchored = true
        line.CanCollide = false
        line.Material = Enum.Material.Neon
        line.Transparency = 0.15
        line.Parent = workspace
        line.Name = "VisualizerLine"
        table.insert(visualizerParts, line)
    end
    visualizerConn = RunService.RenderStepped:Connect(function()
        if not char or not hrp or not visualizerEnabled then removeVisualizer() return end
        local soundObj = getSoundForVisualizer()
        local t = tick()
        for i, line in ipairs(visualizerParts) do
            local angle = math.rad((i-1)*(360/lines))
            local offset = Vector3.new(math.cos(angle)*radius, 0, math.sin(angle)*radius)
            local loud = 0
            if soundObj and soundObj.IsPlaying then
                loud = soundObj.PlaybackLoudness or 0
            end
            local freqOffset = math.sin(i * 2.8 + t * (2 + (i%4)*0.21)) * 0.7
            local barLoud = loud * (1 + 1 * math.sin(i*3 + t*2.6))
            local height = math.clamp(1.2 + (barLoud/320) + math.abs(math.sin(t*3 + i*1.5))*0.23 + freqOffset, 1, 4)
            line.Size = Vector3.new(0.22, height, 0.22)
            line.CFrame = hrp.CFrame * CFrame.new(offset) * CFrame.new(0, height/2, 0)
            if tagType == "👑 ᴏᴡɴᴇʀ" then
                line.Color = gold
            else
                line.Color = tagColor and tagColor:Lerp(Color3.fromRGB(255,255,255), 0.45 + 0.5 * math.abs(math.sin(t + i))) or gold
            end
        end
    end)
end

local function getPremiumSoundsFolder()
    local folder = workspace:FindFirstChild("PremiumSounds")
    if not folder then
        folder = Instance.new("Folder")
        folder.Name = "PremiumSounds"
        folder.Parent = workspace
    end
    return folder
end

local function stopAllPremiumSounds()
    local folder = workspace:FindFirstChild("PremiumSounds")
    if folder then
        for _, s in ipairs(folder:GetChildren()) do
            if s:IsA("Sound") then
                s:Stop()
                s:Destroy()
            end
        end
    end
end

local function parseAudioId(str)
    str = tostring(str or "")
    local id = str:match("rbxassetid://(%d+)")
    if id then return tonumber(id)
    elseif str:match("^%d+$") then return tonumber(str)
    else return nil end
end

local function playClientAudio(id)
    stopAllPremiumSounds()
    local folder = getPremiumSoundsFolder()
    local sound = Instance.new("Sound", folder)
    sound.SoundId = "rbxassetid://"..id
    sound.Volume = 1
    sound.Name = tostring(id)
    sound.Looped = true
    sound:Play()
    playingSoundObj = sound
    return sound
end

local function getAllBoomBoxRemotes()
    local remotes = {}
    if player.Character then
        for _, obj in ipairs(player.Character:GetDescendants()) do
            if obj:IsA("RemoteEvent") and (
                obj.Name:lower():find("boombox") or
                obj.Name:lower():find("radio") or
                obj.Name:lower():find("remote") or
                obj.Name:lower():find("sound")
            ) then
                table.insert(remotes, obj)
            end
        end
    end
    return remotes
end

local function tryPlayBoombox(audioId)
    local remotes = getAllBoomBoxRemotes()
    for _, remote in ipairs(remotes) do
        pcall(function() remote:FireServer("PlaySong", audioId) end)
    end
end

local modeLabel = Instance.new("TextLabel", mainFrame)
modeLabel.Size = UDim2.new(0, 140, 0, 24)
modeLabel.Position = UDim2.new(0, 10, 1, -134)
modeLabel.BackgroundTransparency = 1
modeLabel.Font = Enum.Font.GothamBold
modeLabel.TextSize = 14
modeLabel.TextColor3 = tagColor or gold
modeLabel.TextXAlignment = Enum.TextXAlignment.Left
modeLabel.ZIndex = 4
modeLabel.Text = "Modo: Áudio Real"

local modeButton = Instance.new("TextButton", mainFrame)
modeButton.Size = UDim2.new(0, 60, 0, 28)
modeButton.Position = UDim2.new(0, 10, 1, -104)
modeButton.BackgroundColor3 = accentBg
modeButton.Text = "REAL"
modeButton.TextColor3 = tagColor or gold
modeButton.Font = Enum.Font.GothamBold
modeButton.TextSize = 16
modeButton.ZIndex = 4
modeButton.AutoButtonColor = true
modeButton.Active = true
Instance.new("UICorner", modeButton).CornerRadius = UDim.new(1, 0)
local modeBtnStroke = Instance.new("UIStroke", modeButton)
modeBtnStroke.Color = tagColor or gold
modeBtnStroke.Thickness = 1.25
modeBtnStroke.Transparency = 0.7

local idBox = Instance.new("TextBox", mainFrame)
idBox.Size = UDim2.new(0, 140, 0, 28)
idBox.Position = UDim2.new(0, 85, 1, -104)
idBox.BackgroundColor3 = accentBg
idBox.PlaceholderText = "ID da música"
idBox.Text = ""
idBox.TextColor3 = tagColor or gold
idBox.Font = Enum.Font.Gotham
idBox.TextSize = 14
idBox.ZIndex = 4
idBox.ClearTextOnFocus = false
Instance.new("UICorner", idBox).CornerRadius = UDim.new(1, 0)
local idBoxStroke = Instance.new("UIStroke", idBox)
idBoxStroke.Color = tagColor or gold
idBoxStroke.Thickness = 1.25
idBoxStroke.Transparency = 0.7

local tocarBtn = Instance.new("TextButton", mainFrame)
tocarBtn.Text = "Tocar"
tocarBtn.Size = UDim2.new(0, 65, 0, 28)
tocarBtn.Position = UDim2.new(0, 235, 1, -104)
tocarBtn.BackgroundColor3 = accentBg
tocarBtn.TextColor3 = tagColor or gold
tocarBtn.Font = Enum.Font.GothamBold
tocarBtn.TextSize = 16
tocarBtn.ZIndex = 4
tocarBtn.AutoButtonColor = true
tocarBtn.Active = true
Instance.new("UICorner", tocarBtn).CornerRadius = UDim.new(1, 0)
local tocarBtnStroke = Instance.new("UIStroke", tocarBtn)
tocarBtnStroke.Color = tagColor or gold
tocarBtnStroke.Thickness = 1.25
tocarBtnStroke.Transparency = 0.7

local visualizerBtn = Instance.new("TextButton", mainFrame)
visualizerBtn.Size = UDim2.new(0, 36, 0, 28)
visualizerBtn.Position = UDim2.new(0, 10, 1, -68)
visualizerBtn.BackgroundColor3 = accentBg
visualizerBtn.Text = "✨"
visualizerBtn.TextColor3 = tagColor or gold
visualizerBtn.Font = Enum.Font.GothamBold
visualizerBtn.TextSize = 20
visualizerBtn.ZIndex = 4
visualizerBtn.AutoButtonColor = true
visualizerBtn.Active = true
Instance.new("UICorner", visualizerBtn).CornerRadius = UDim.new(1, 0)
local visualizerBtnStroke = Instance.new("UIStroke", visualizerBtn)
visualizerBtnStroke.Color = tagColor or gold
visualizerBtnStroke.Thickness = 1.25
visualizerBtnStroke.Transparency = 0.7

local clInfoFrame = Instance.new("Frame", mainFrame)
clInfoFrame.Size = UDim2.new(1, -68, 0, 48)
clInfoFrame.Position = UDim2.new(0, 56, 1, -68)
clInfoFrame.BackgroundTransparency = 1
clInfoFrame.Visible = false
clInfoFrame.ZIndex = 4

local clInfoName = Instance.new("TextLabel", clInfoFrame)
clInfoName.BackgroundTransparency = 1
clInfoName.Size = UDim2.new(1,0,0,26)
clInfoName.Position = UDim2.new(0,0,0,0)
clInfoName.Font = Enum.Font.GothamBold
clInfoName.TextSize = 18
clInfoName.TextColor3 = white
clInfoName.Text = ""
clInfoName.ZIndex = 4

local clInfoTime = Instance.new("TextLabel", clInfoFrame)
clInfoTime.BackgroundTransparency = 1
clInfoTime.Size = UDim2.new(1,0,0,20)
clInfoTime.Position = UDim2.new(0,0,0,26)
clInfoTime.Font = Enum.Font.Gotham
clInfoTime.TextSize = 14
clInfoTime.TextColor3 = Color3.fromRGB(200,200,200)
clInfoTime.Text = ""
clInfoTime.ZIndex = 4

local clInfoConn = nil
local function showCLInfo(name, soundObj)
    clInfoFrame.Visible = true
    clInfoName.Text = name or ""
    clInfoTime.Text = "00:00 - 00:00"
    if clInfoConn then clInfoConn:Disconnect() end
    clInfoConn = RunService.RenderStepped:Connect(function()
        if soundObj and soundObj.Parent and soundObj.IsPlaying then
            local pos = soundObj.TimePosition or 0
            local len = soundObj.TimeLength or 0
            clInfoTime.Text = formatTime(pos).." - "..formatTime(len)
        else
            clInfoTime.Text = "00:00 - 00:00"
        end
    end)
end
local function hideCLInfo()
    clInfoFrame.Visible = false
    clInfoName.Text = ""
    clInfoTime.Text = ""
    if clInfoConn then clInfoConn:Disconnect() clInfoConn = nil end
end

visualizerBtn.MouseButton1Click:Connect(function()
    visualizerEnabled = not visualizerEnabled
    visualizerBtn.Text = visualizerEnabled and "✨" or "❌"
    if not visualizerEnabled then removeVisualizer()
    elseif playingSoundObj or playMode == "REAL" then createVisualizer() end
end)

modeButton.MouseButton1Click:Connect(function()
    if playMode == "REAL" then
        playMode = "CLIENT"
        modeButton.Text = "CLIENT"
        modeLabel.Text = "Modo: Áudio Visual"
        stopAllPremiumSounds()
        removeVisualizer()
        hideCLInfo()
    else
        playMode = "REAL"
        modeButton.Text = "REAL"
        modeLabel.Text = "Modo: Áudio Real"
        stopAllPremiumSounds()
        removeVisualizer()
        hideCLInfo()
    end
end)

local function setMainInputsVisible(val)
    modeLabel.Visible = val
    modeButton.Visible = val
    idBox.Visible = val
    tocarBtn.Visible = val
    visualizerBtn.Visible = val
    clInfoFrame.Visible = val and clInfoFrame.Visible
end

local mainScroll = Instance.new("ScrollingFrame", mainFrame)
mainScroll.Position = UDim2.new(0, 12, 0, 64)
mainScroll.Size = UDim2.new(1, -68, 1, -198)
mainScroll.BackgroundTransparency = 1
mainScroll.CanvasSize = UDim2.new(0,0,0,0)
mainScroll.ScrollBarThickness = 7
mainScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
mainScroll.ZIndex = 2
mainScroll.Active = true
local grid = Instance.new("UIGridLayout", mainScroll)
grid.CellSize = UDim2.new(0, 105, 0, 44)
grid.CellPadding = UDim2.new(0, 10, 0, 10)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 2

-- Notificação animada CLIENT AUDIO (direita -> esquerda)
local function showClientAudioNotification(musicName, soundObj)
    if screenGui:FindFirstChild("AuralynxNoti") then
        screenGui.AuralynxNoti:Destroy()
    end
    local noti = Instance.new("Frame", screenGui)
    noti.Name = "AuralynxNoti"
    noti.Size = UDim2.new(0, 260, 0, 66)
    noti.Position = UDim2.new(1, 280, 1, -130)
    noti.BackgroundColor3 = tagColor or Color3.fromRGB(0,120,255)
    noti.BackgroundTransparency = 0.75
    noti.ZIndex = 99
    Instance.new("UICorner", noti).CornerRadius = UDim.new(1,0)
    local stroke = Instance.new("UIStroke", noti)
    stroke.Color = tagGradient or Color3.fromRGB(255,255,255)
    stroke.Thickness = 2
    stroke.Transparency = 0.45
    local gradient = Instance.new("UIGradient", noti)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, tagColor or Color3.fromRGB(0,120,255)),
        ColorSequenceKeypoint.new(1, tagGradient or Color3.fromRGB(0,180,255))
    }
    gradient.Rotation = 0
    local lblTitle = Instance.new("TextLabel", noti)
    lblTitle.Size = UDim2.new(1, -20, 0, 30)
    lblTitle.Position = UDim2.new(0, 10, 0, 4)
    lblTitle.BackgroundTransparency = 1
    lblTitle.Text = "🎵 "..musicName
    lblTitle.Font = Enum.Font.FredokaOne
    lblTitle.TextSize = 22
    lblTitle.TextColor3 = Color3.fromRGB(255,255,255)
    lblTitle.TextStrokeTransparency = 0.35
    lblTitle.TextXAlignment = Enum.TextXAlignment.Left
    local lblTime = Instance.new("TextLabel", noti)
    lblTime.Size = UDim2.new(1, -20, 0, 22)
    lblTime.Position = UDim2.new(0, 10, 0, 36)
    lblTime.BackgroundTransparency = 1
    lblTime.Font = Enum.Font.GothamBold
    lblTime.TextSize = 16
    lblTime.TextColor3 = Color3.fromRGB(220,220,220)
    lblTime.TextStrokeTransparency = 0.55
    lblTime.TextXAlignment = Enum.TextXAlignment.Left
    lblTime.Text = "00:00 - 00:00"
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if soundObj and soundObj.Parent and soundObj.IsPlaying then
            local pos = soundObj.TimePosition or 0
            local len = soundObj.TimeLength or 0
            lblTime.Text = string.format("%02d:%02d", math.floor(pos/60), math.floor(pos%60)).." - "..string.format("%02d:%02d", math.floor(len/60), math.floor(len%60))
        else
            lblTime.Text = "00:00 - 00:00"
        end
    end)
    local tweenIn = tweenService:Create(noti, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -270, 1, -130)
    })
    tweenIn:Play()
    spawn(function()
        local t0 = tick()
        while tick()-t0 < 8 and soundObj and soundObj.IsPlaying do wait() end
        if conn then conn:Disconnect() end
        if noti then
            local tweenOut = tweenService:Create(noti, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 280, 1, -130)
            })
            tweenOut:Play()
            tweenOut.Completed:Wait()
            noti:Destroy()
        end
    end)
end

for i = 1, 55 do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 105, 0, 44)
    btn.Text = tostring(i)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.TextColor3 = tagColor or gold
    btn.BackgroundColor3 = accentBg
    btn.ZIndex = 3
    btn.AutoButtonColor = true
    btn.Active = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = tagColor or gold
    btnStroke.Thickness = 1.25
    btnStroke.Transparency = 0.7
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = tagColor or gold btn.TextColor3 = darkBg end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = accentBg btn.TextColor3 = tagColor or gold end)
    btn.Parent = mainScroll
    btn.MouseButton1Click:Connect(function()
        local id = musicIDs[tostring(i)]
        local name = musicNames[tostring(i)] or ("ID: "..tostring(id))
        if playMode == "REAL" then
            stopAllPremiumSounds()
            tryPlayBoombox(id)
            playingSoundObj = nil
            if visualizerEnabled then createVisualizer() end
            hideCLInfo()
        else
            local soundObj = playClientAudio(id)
            if visualizerEnabled then createVisualizer(soundObj) end
            showCLInfo(name, soundObj)
            showClientAudioNotification(name, soundObj)
        end
    end)
end

tocarBtn.MouseButton1Click:Connect(function()
    local id = parseAudioId(idBox.Text)
    if not id then return end
    local name = "ID: "..tostring(id)
    if playMode == "REAL" then
        stopAllPremiumSounds()
        tryPlayBoombox(id)
        playingSoundObj = nil
        if visualizerEnabled then createVisualizer() end
        hideCLInfo()
    else
        local soundObj = playClientAudio(id)
        if visualizerEnabled then createVisualizer(soundObj) end
        showCLInfo(name, soundObj)
        showClientAudioNotification(name, soundObj)
    end
end)

local musicListFrame = Instance.new("Frame", mainFrame)
musicListFrame.Size = UDim2.new(1, -68, 1, -138)
musicListFrame.Position = UDim2.new(0, 12, 0, 64)
musicListFrame.BackgroundColor3 = darkBg
musicListFrame.Visible = false
musicListFrame.ZIndex = 3
musicListFrame.Active = true
Instance.new("UICorner", musicListFrame).CornerRadius = UDim.new(1, 0)
local stroke = Instance.new("UIStroke", musicListFrame)
stroke.Color = tagColor or gold
stroke.Thickness = 1.25
stroke.Transparency = 0.7
local musicScroll = Instance.new("ScrollingFrame", musicListFrame)
musicScroll.Size = UDim2.new(1, 0, 1, 0)
musicScroll.BackgroundTransparency = 1
musicScroll.CanvasSize = UDim2.new(0,0,0,0)
musicScroll.ScrollBarThickness = 6
musicScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
musicScroll.Name = "musicScroll"
musicScroll.ZIndex = 4
local musicListLayout = Instance.new("UIListLayout", musicScroll)
musicListLayout.Padding = UDim.new(0,8)
musicListLayout.SortOrder = Enum.SortOrder.LayoutOrder
for k = 1, 55 do
    local lbl = Instance.new("TextLabel", musicScroll)
    lbl.Size = UDim2.new(1, -10, 0, 28)
    lbl.BackgroundTransparency = 1
    lbl.Text = "["..k.."] - "..(musicNames[tostring(k)] or "Música "..k)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = tagColor or gold
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
end

local creditsFrame = Instance.new("Frame", mainFrame)
creditsFrame.Size = UDim2.new(1, -68, 1, -138)
creditsFrame.Position = UDim2.new(0, 12, 0, 64)
creditsFrame.BackgroundColor3 = darkBg
creditsFrame.Visible = false
creditsFrame.ZIndex = 3
creditsFrame.Active = true
Instance.new("UICorner", creditsFrame).CornerRadius = UDim.new(1, 0)
local creditsStroke = Instance.new("UIStroke", creditsFrame)
creditsStroke.Color = tagColor or gold
creditsStroke.Thickness = 1.25
creditsStroke.Transparency = 0.7
local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -16, 1, -16)
creditsLabel.Position = UDim2.new(0, 8, 0, 8)
creditsLabel.Text = "Feito por Freeman4i37\nObrigado por usar o script.\n⭐"
creditsLabel.Font = Enum.Font.GothamBold
creditsLabel.TextColor3 = tagColor or gold
creditsLabel.TextSize = 16
creditsLabel.BackgroundTransparency = 1
creditsLabel.ZIndex = 3

local loggerBtn = Instance.new("TextButton", mainFrame)
loggerBtn.Size = UDim2.new(0, 36, 0, 36)
loggerBtn.Position = UDim2.new(1, -44, 0, 180)
loggerBtn.Text = "🔍"
loggerBtn.BackgroundColor3 = accentBg
loggerBtn.TextColor3 = tagColor or gold
loggerBtn.Font = Enum.Font.GothamBold
loggerBtn.TextSize = 25
loggerBtn.ZIndex = 3
loggerBtn.AutoButtonColor = true
loggerBtn.Active = true
Instance.new("UICorner", loggerBtn).CornerRadius = UDim.new(1, 0)
local loggerBtnStroke = Instance.new("UIStroke", loggerBtn)
loggerBtnStroke.Color = tagColor or gold
loggerBtnStroke.Thickness = 1.25
loggerBtnStroke.Transparency = 0.7

loggerBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/audiologger.lua"))()
end)

local musicListBtn = Instance.new("TextButton", mainFrame)
musicListBtn.Size = UDim2.new(0, 36, 0, 36)
musicListBtn.Position = UDim2.new(1, -44, 0, 80)
musicListBtn.Text = "📜"
musicListBtn.BackgroundColor3 = accentBg
musicListBtn.TextColor3 = tagColor or gold
musicListBtn.Font = Enum.Font.GothamBold
musicListBtn.TextSize = 25
musicListBtn.ZIndex = 3
musicListBtn.AutoButtonColor = true
musicListBtn.Active = true
Instance.new("UICorner", musicListBtn).CornerRadius = UDim.new(1, 0)
local musicListBtnStroke = Instance.new("UIStroke", musicListBtn)
musicListBtnStroke.Color = tagColor or gold
musicListBtnStroke.Thickness = 1.25
musicListBtnStroke.Transparency = 0.7

local openIcon = Instance.new("TextButton", screenGui)
openIcon.Size = UDim2.new(0, 40, 0, 40)
openIcon.Position = UDim2.new(1, -50, 1, -50)
openIcon.BackgroundColor3 = tagColor or gold
openIcon.Text = "+"
openIcon.Visible = false
openIcon.TextSize = 22
openIcon.Font = Enum.Font.GothamBold
openIcon.TextColor3 = darkBg
openIcon.Active = true
openIcon.Draggable = true
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

local creditsButton = Instance.new("TextButton", mainFrame)
creditsButton.Size = UDim2.new(0, 36, 0, 36)
creditsButton.Position = UDim2.new(1, -44, 0, 130)
creditsButton.Text = "👤"
creditsButton.BackgroundColor3 = accentBg
creditsButton.TextColor3 = tagColor or gold
creditsButton.Font = Enum.Font.GothamBold
creditsButton.TextSize = 25
creditsButton.ZIndex = 3
creditsButton.AutoButtonColor = true
creditsButton.Active = true
Instance.new("UICorner", creditsButton).CornerRadius = UDim.new(1, 0)
local creditsBtnStroke = Instance.new("UIStroke", creditsButton)
creditsBtnStroke.Color = tagColor or gold
creditsBtnStroke.Thickness = 1.25
creditsBtnStroke.Transparency = 0.7

local musicListBtnClicked = false
local inCredits = false
local inLogger = false

musicListBtn.MouseButton1Click:Connect(function()
    musicListBtnClicked = not musicListBtnClicked
    mainScroll.Visible = not musicListBtnClicked
    musicListFrame.Visible = musicListBtnClicked
    creditsFrame.Visible = false
    inCredits = false
    inLogger = false
    setMainInputsVisible(not musicListBtnClicked)
end)

creditsButton.MouseButton1Click:Connect(function()
    inCredits = not inCredits
    mainScroll.Visible = not inCredits
    creditsFrame.Visible = inCredits
    musicListFrame.Visible = false
    musicListBtnClicked = false
    inLogger = false
    setMainInputsVisible(not inCredits)
end)

loggerBtn.MouseButton1Click:Connect(function()
    inLogger = not inLogger
    mainScroll.Visible = not inLogger
    creditsFrame.Visible = false
    musicListFrame.Visible = false
    musicListBtnClicked = false
    inCredits = false
    setMainInputsVisible(not inLogger)
    if inLogger then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/audiologger.lua"))()
    end
end)

mainScroll.Visible = true
musicListFrame.Visible = false
creditsFrame.Visible = false

closeBtn.MouseButton1Click:Connect(function()
    stopAllPremiumSounds()
    removeVisualizer()
    hideCLInfo()
    local folder = workspace:FindFirstChild("PremiumSounds")
    if folder then folder:Destroy() end
    task.wait(0.1)
    screenGui:Destroy()
end)

minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    openIcon.Visible = true
end)

openIcon.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openIcon.Visible = false
end)