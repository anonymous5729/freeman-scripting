local player = game:GetService("Players").LocalPlayer

local tweenService = game:GetService("TweenService")

local runService = game:GetService("RunService")

local soundFolder = workspace:FindFirstChild("PremiumClientSounds") or Instance.new("Folder", workspace)

soundFolder.Name = "PremiumClientSounds"

local tagMap = {

    ["Kaua_452"] = {tag="👑 OWNER",colors={Color3.fromRGB(212,175,55),Color3.fromRGB(5,5,5),Color3.fromRGB(255,0,0)}},

    ["Itz_Mariena"] = {tag="🎀 YUMI",colors={Color3.fromRGB(160,0,200),Color3.fromRGB(75,0,110)}},

    ["pedro312jee"] = {tag="🎩 SUPERVISOR",colors={Color3.fromRGB(0,15,85),Color3.fromRGB(0,60,255)}},

    ["UserModerator"] = {tag="🛡 MODERADOR",colors={Color3.fromRGB(255,90,0),Color3.fromRGB(255,215,0)}},

    ["user"] = {tag="🛠 STAFF",colors={Color3.fromRGB(0,80,255),Color3.fromRGB(120,120,130)}},

}

local function getPlayerTag(plr)

    if tagMap[plr.Name] then

        return tagMap[plr.Name].tag, tagMap[plr.Name].colors

    elseif plr == player then

        return "💎 PREMIUM", {Color3.fromHex("#ff1493"), Color3.fromRGB(255,215,0)}

    else

        return nil, nil

    end

end

local tagType, tagColors = getPlayerTag(player)

local white = Color3.fromRGB(255,255,255)

local darkBg = Color3.fromRGB(20,20,20)

local accentBg = Color3.fromRGB(40,40,20)

local musicIDs = {
    ["1"]=94718473830640,["2"]=92209428926055,["3"]=133900561957103,["4"]=93768636184697,["5"]=92062588329352,
    ["6"]=84773737820526,["7"]=87783857221289,["8"]=88342296270082,["9"]=85342086082111,["10"]=93058983119992,
    ["11"]=92492039534399,["12"]=134035788881796,["13"]=18841893567,["14"]=73962723234161,["15"]=140268583413209,
    ["16"]=77741294709660,["17"]=71531533552899,["18"]=16190782181,["19"]=117169209277972,["20"]=81299332131868,
    ["21"]=77147911349059,["22"]=124092830839928,["23"]=122854357582130,["24"]=88094479399489,["25"]=88339486019486,
    ["26"]=97765714111493,["27"]=92446612272052,["28"]=74366765967475,["29"]=112068892721408,["30"]=112143944982807,
    ["31"]=111668097052966,["32"]=112214814544629,["33"]=101500915434329,["34"]=95046091312570,["35"]=110091098283354,
    ["36"]=17422156627,["37"]=82411642961457,["38"]=87022583947683,["39"]=96974354995715,["40"]=119020235792430,
    ["41"]=82411642961457,["42"]=96215620202470,["43"]=70782176012619,["44"]=112893354276338,["45"]=118507373399694,
    ["46"]=98691879232718,["47"]=134457296749518,["48"]=118607303205005,["49"]=127504762051765,["50"]=118297487529239,
    ["51"]=132082397247824,["52"]=106958630419629,["53"]=86685635786943,["54"]=101456813429584,["55"]=100533213305793,
    ["56"]=112930367758222,["57"]=100828050594137,["58"]=124085422276732,["59"]=122114766584918
}
local musicNames = {
    ["1"]="Funk da Febre",["2"]="Switch The Colors (Jersey Club)",["3"]="Trash Funk",["4"]="2609 (Jersey Club)",
    ["5"]="Spooky Scary Sunday (Jersey Club)",["6"]="ANOTE AÍ",["7"]="Temptation",["8"]="Ela Tano",["9"]="Seu fã",
    ["10"]="MONTAGEM ECLIPSE ESTRELAR",["11"]="Em Dezembro de 81 - Flamengo",["12"]="Esquema Confirmado - Arrocha",
    ["13"]="JERSEY WAVE",["14"]="Arrepia XL 2",["15"]="Meepcity (Jersey Club)",["16"]="Manda Meu Passinho",
    ["17"]="Lembro até hoje",["18"]="HR - EEYUH!",["19"]="I love ha",["20"]="SHE DON'T - Lonelybwoi",
    ["21"]="NY Drill Ritual",["22"]="It Doesn't Matter (Jersey Club)",["23"]="69 PHONK",["24"]="Ela se envolveu",
    ["25"]="Montagem Pose",["26"]="Trem Fantasma Funk",["27"]="MTG ZUM ZUM ZUM",["28"]="EU NÃO ESTOU LOUCO",
    ["29"]="FUNK DA PRAIA (SLOWED)",["30"]="Hogo Funk",["31"]="Novinha sapeca",["32"]="ANALOG HORROR FUNK",
    ["33"]="Dum Dum",["34"]="Rebola pro pai",["35"]="Carro Bixo",["36"]="Onichan",["37"]="Arrepia XL 6",
    ["38"]="Mandrake",["39"]="Toma Toma",["40"]="Lá no meu barraco",["41"]="Batida SP",["42"]="Funk SP",
    ["43"]="Pega no cipó",["44"]="Rap do Minecraft (Funk)",["45"]="Melodia do Verão",["46"]="Funk do Famglia",
    ["47"]="Vem no pique (Phonk)",["48"]="Michael Jackson FUNK",["49"]="Arrepia XL 4",["50"]="MONTAGEM NOVA MÁGICA 1.0",
    ["51"]="V2 Daquela (XL Funk)",["52"]="Digitei seu número (Sertanejo)",["53"]="Auto toma",["54"]="Montagem Balanço",
    ["55"]="Piseiro com sertanejo",["56"]="Montagem Vozes Talentinho",["57"]="Spooky Scary (Funk)",
    ["58"]="SENTA (NGL x XL)",["59"]="Haha (NGL)"
}

local function createGradientAnim(obj, colors, speed)

    local seq = {}

    for i,c in ipairs(colors) do table.insert(seq,ColorSequenceKeypoint.new((i-1)/(#colors-1),c)) end

    local grad = Instance.new("UIGradient", obj)

    grad.Color = ColorSequence.new(seq)

    spawn(function()

        local t0 = tick()

        while grad.Parent do

            grad.Offset = Vector2.new(0.5+0.5*math.sin((tick()-t0)*speed),0)

            wait(0.03)

        end

    end)

    return grad

end

local function showTagForPlayer(plr)

    local tType, colors = getPlayerTag(plr)

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

        tag.MaxDistance = 700

        local bg = Instance.new("Frame", tag)

        bg.Size = UDim2.new(1,0,1,0)

        bg.BackgroundTransparency = 0.35

        bg.BackgroundColor3 = colors[1]

        local corner = Instance.new("UICorner", bg)

        corner.CornerRadius = UDim.new(1, 0)

        createGradientAnim(bg, colors, 1.3)

        local txt = Instance.new("TextLabel", bg)

        txt.Size = UDim2.new(1,0,1,0)

        txt.BackgroundTransparency = 1

        txt.Text = tType

        txt.TextColor3 = white

        txt.TextStrokeTransparency = 0.2

        txt.Font = Enum.Font.FredokaOne

        txt.TextSize = 19

        txt.TextStrokeColor3 = colors[#colors]

        txt.TextXAlignment = Enum.TextXAlignment.Center

        createGradientAnim(txt, colors, 1.5)

        local glow = Instance.new("UIStroke", bg)

        glow.Color = colors[#colors]

        glow.Thickness = 3.5

        glow.Transparency = 0.4

        local pulseTween = tweenService:Create(bg, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.55})

        pulseTween:Play()

    end

    if plr.Character then addTag() end

    plr.CharacterAdded:Connect(function() wait(1) addTag() end)

end

for _,plr in ipairs(game:GetService("Players"):GetPlayers()) do showTagForPlayer(plr) end

game:GetService("Players").PlayerAdded:Connect(function(plr) showTagForPlayer(plr) end)

local screenGui = Instance.new("ScreenGui")

screenGui.Name = "AuralynxHubPremium"

screenGui.ResetOnSpawn = false

screenGui.Parent = player:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")

mainFrame.Name = "AuralynxMusicMain"

mainFrame.Size = UDim2.new(0, 380, 0, 510)

mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

mainFrame.BackgroundColor3 = darkBg

mainFrame.BorderSizePixel = 0

mainFrame.Parent = screenGui

mainFrame.Active = true

mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)

local mainStroke = Instance.new("UIStroke", mainFrame)

mainStroke.Color = tagColors[#tagColors]

mainStroke.Thickness = 2

mainStroke.Transparency = 0.2

createGradientAnim(mainFrame, tagColors, 1.2)

local header = Instance.new("Frame", mainFrame)

header.Size = UDim2.new(1, 0, 0, 60)

header.BackgroundColor3 = darkBg

header.ZIndex = 10

header.Position = UDim2.new(0,0,0,0)

header.Active = true

Instance.new("UICorner", header).CornerRadius = UDim.new(0, 20)

createGradientAnim(header, tagColors, 1.3)

local headerTitle = Instance.new("TextLabel", header)

headerTitle.Text = "Auralynx Premium"

headerTitle.Font = Enum.Font.GothamBold

headerTitle.TextSize = 21

headerTitle.TextColor3 = white

headerTitle.BackgroundTransparency = 1

headerTitle.Size = UDim2.new(0, 220, 0, 32)

headerTitle.Position = UDim2.new(0, 18, 0, 14)

headerTitle.TextXAlignment = Enum.TextXAlignment.Left

headerTitle.ZIndex = 11

createGradientAnim(headerTitle, tagColors, 1.3)

local minimizeBtn = Instance.new("TextButton", header)

minimizeBtn.Size = UDim2.new(0, 35, 0, 32)

minimizeBtn.Position = UDim2.new(1, -81, 0, 14)

minimizeBtn.BackgroundColor3 = accentBg

minimizeBtn.Text = "-"

minimizeBtn.TextColor3 = white

minimizeBtn.Font = Enum.Font.GothamBold

minimizeBtn.TextSize = 21

minimizeBtn.ZIndex = 11

Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(1, 0)

createGradientAnim(minimizeBtn, tagColors, 1.25)

local closeBtn = Instance.new("TextButton", header)

closeBtn.Size = UDim2.new(0, 35, 0, 32)

closeBtn.Position = UDim2.new(1, -41, 0, 14)

closeBtn.BackgroundColor3 = accentBg

closeBtn.Text = "X"

closeBtn.TextColor3 = white

closeBtn.Font = Enum.Font.GothamBold

closeBtn.TextSize = 21

closeBtn.ZIndex = 11

Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

createGradientAnim(closeBtn, tagColors, 1.25)

local tabsBar = Instance.new("Frame", mainFrame)

tabsBar.Size = UDim2.new(1, -32, 0, 37)

tabsBar.Position = UDim2.new(0, 16, 0, 66)

tabsBar.BackgroundTransparency = 1

tabsBar.ZIndex = 1000

local tabScroll = Instance.new("ScrollingFrame", tabsBar)

tabScroll.Size = UDim2.new(1, 0, 1, 0)

tabScroll.Position = UDim2.new(0,0,0,0)

tabScroll.BackgroundTransparency = 1

tabScroll.ScrollBarThickness = 0

tabScroll.CanvasSize = UDim2.new(0,0,0,0)

tabScroll.AutomaticCanvasSize = Enum.AutomaticSize.X

tabScroll.ZIndex = 5

local tabLayout = Instance.new("UIListLayout", tabScroll)

tabLayout.FillDirection = Enum.FillDirection.Horizontal

tabLayout.Padding = UDim.new(0,8)

tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

local tabs = {

    {name = "IDs", label = "IDs"},

    {name = "MusicList", label = "Music List"},

    {name = "ClientAudio", label = "Client Audio"},

    {name = "Scripts", label = "Scripts"},

    {name = "Credits", label = "Credits"}

}

local tabFrames = {}

local tabButtons = {}

local selectedTab = 1

local minimized = false

local notificationBar = nil

local notificationConn = nil

local playingSound = nil

local isClientAudio, isLoop, currentVolume, currentPitch = false, false, 1, 1

local visualizerParts, visualizerConn = {}, nil

local function showTab(idx)

    for i, frame in ipairs(tabFrames) do

        frame.Visible = (not minimized) and (i == idx)

    end

    tabsBar.Visible = not minimized

    tabScroll.Visible = not minimized

end

for i, tab in ipairs(tabs) do

    local btn = Instance.new("TextButton", tabScroll)

    btn.Size = UDim2.new(0, 106, 0, 32)

    btn.Text = tab.label

    btn.Font = Enum.Font.GothamBold

    btn.TextSize = 15

    btn.TextColor3 = white

    btn.BackgroundColor3 = accentBg

    btn.ZIndex = 6

    btn.AutoButtonColor = true

    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    createGradientAnim(btn, tagColors, 1.25)

    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = tagColors[#tagColors] btn.TextColor3 = darkBg end)

    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = accentBg btn.TextColor3 = white end)

    btn.MouseButton1Click:Connect(function()

        selectedTab = i

        showTab(i)

    end)

    tabButtons[i] = btn

    local frame = Instance.new("Frame", mainFrame)

    frame.Size = UDim2.new(1, -32, 1, -110)

    frame.Position = UDim2.new(0, 16, 0, 104)

    frame.BackgroundColor3 = darkBg

    frame.Visible = (i == 1)

    frame.ZIndex = 10

    createGradientAnim(frame, tagColors, 1.22)

    tabFrames[i] = frame

end

local function setMinimized(m)

    minimized = m

    showTab(selectedTab)

    minimizeBtn.Text = minimized and "+" or "-"

    local goal = minimized and UDim2.new(0, 380, 0, 60) or UDim2.new(0, 380, 0, 510)

    tweenService:Create(mainFrame, TweenInfo.new(0.27, Enum.EasingStyle.Quart), {Size = goal}):Play()

end

minimizeBtn.MouseButton1Click:Connect(function()

    setMinimized(not minimized)

end)

closeBtn.MouseButton1Click:Connect(function()

    for _, s in ipairs(soundFolder:GetChildren()) do if s:IsA("Sound") then s:Stop() s:Destroy() end end

    playingSound = nil

    if notificationConn then notificationConn:Disconnect() end

    if notificationBar then notificationBar:Destroy() notificationBar = nil end

    if visualizerConn then visualizerConn:Disconnect() end

    for _, part in ipairs(visualizerParts) do if part and part.Parent then part:Destroy() end end

    visualizerParts = {}

    screenGui:Destroy()

end)

local function showMusicNotification(musicName, duration, isLoop, sound)

    if notificationConn then notificationConn:Disconnect() end

    if notificationBar then notificationBar:Destroy() end

    notificationBar = Instance.new("Frame", screenGui)

    notificationBar.Size = UDim2.new(0, 340, 0, 64)

    notificationBar.Position = UDim2.new(0, 705, 0, 10)

    notificationBar.BackgroundColor3 = tagColors[1]

    notificationBar.BorderSizePixel = 0

    notificationBar.ZIndex = 9999

    local corner = Instance.new("UICorner", notificationBar)

    corner.CornerRadius = UDim.new(0,16)

    local stroke = Instance.new("UIStroke", notificationBar)

    stroke.Color = tagColors[#tagColors]

    stroke.Thickness = 3

    stroke.Transparency = 0.1

    createGradientAnim(notificationBar, tagColors, 1.2)

    local nameLabel = Instance.new("TextLabel", notificationBar)

    nameLabel.Size = UDim2.new(1, -10, 0, 34)

    nameLabel.Position = UDim2.new(0,5,0,5)

    nameLabel.BackgroundTransparency = 1

    nameLabel.Text = musicName

    nameLabel.TextColor3 = white

    nameLabel.TextSize = 22

    nameLabel.Font = Enum.Font.GothamBold

    nameLabel.ZIndex = 9999

    nameLabel.TextWrapped = true

    createGradientAnim(nameLabel, tagColors, 1.5)

    local durLabel = Instance.new("TextLabel", notificationBar)

    durLabel.Size = UDim2.new(1, -10, 0, 22)

    durLabel.Position = UDim2.new(0,5,0,38)

    durLabel.BackgroundTransparency = 1

    durLabel.TextColor3 = white

    durLabel.TextSize = 16

    durLabel.Font = Enum.Font.Gotham

    durLabel.ZIndex = 9999

    durLabel.TextWrapped = true

    createGradientAnim(durLabel, tagColors, 1.5)

    notificationBar.BackgroundTransparency = 1

    nameLabel.TextTransparency = 1

    durLabel.TextTransparency = 1

    tweenService:Create(notificationBar, TweenInfo.new(0.25,Enum.EasingStyle.Quart),{BackgroundTransparency=0.8}):Play()

    tweenService:Create(nameLabel, TweenInfo.new(0.25,Enum.EasingStyle.Quart),{TextTransparency=0}):Play()

    tweenService:Create(durLabel, TweenInfo.new(0.25,Enum.EasingStyle.Quart),{TextTransparency=0}):Play()

    local function sec2str(sec)

        sec = math.floor(sec)

        local m = math.floor(sec/60)

        local s = sec%60

        return string.format("%02d:%02d",m,s)

    end

    local total = math.floor(duration)

    local function updateDur()

        if sound and sound.IsLoaded then

            local pos = math.floor(sound.TimePosition)

            durLabel.Text = sec2str(pos).." - "..sec2str(total)

        else

            durLabel.Text = "00:00 - "..sec2str(total)

        end

    end

    updateDur()

    notificationConn = runService.RenderStepped:Connect(function()

        if not notificationBar or not durLabel or not sound then return end

        updateDur()

    end)

    if not isLoop then

        sound.Ended:Connect(function()

            if notificationConn then notificationConn:Disconnect() end

            tweenService:Create(notificationBar, TweenInfo.new(0.22,Enum.EasingStyle.Quart),{BackgroundTransparency=1}):Play()

            for _,v in ipairs(notificationBar:GetChildren()) do

                if v:IsA("TextLabel") then tweenService:Create(v, TweenInfo.new(0.18,Enum.EasingStyle.Quart),{TextTransparency=1}):Play() end

            end

            wait(0.3)

            if notificationBar then notificationBar:Destroy() end

            notificationBar = nil

        end)

    end

end

local function stopAllClientSounds()

    for _, s in ipairs(soundFolder:GetChildren()) do

        if s:IsA("Sound") then s:Stop() s:Destroy() end

    end

    playingSound = nil

    if notificationConn then notificationConn:Disconnect() end

    if notificationBar then notificationBar:Destroy() notificationBar = nil end

    if visualizerConn then visualizerConn:Disconnect() end

    for _, part in ipairs(visualizerParts) do if part and part.Parent then part:Destroy() end end

    visualizerParts = {}

end

local function getBoomBoxRemotes()

    local remotes = {}

    if player.Character then

        for _, obj in ipairs(player.Character:GetDescendants()) do

            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then

                if obj.Name:lower():find("boombox") or obj.Name:lower():find("radio") or obj.Name:lower():find("sound") or obj.Name:lower():find("remote") then

                    table.insert(remotes, obj)

                end

            end

        end

    end

    return remotes

end

local function tryPlayBoombox(audioId)

    if isClientAudio then return end

    local remotes = getBoomBoxRemotes()

    local argsList = {

        {audioId},

        {"PlaySong", audioId},

        {"Play", audioId},

        {audioId, true},

    }

    for _, remote in ipairs(remotes) do

        for _, args in ipairs(argsList) do

            pcall(function()

                if remote:IsA("RemoteEvent") then

                    remote:FireServer(unpack(args))

                elseif remote:IsA("RemoteFunction") then

                    remote:InvokeServer(unpack(args))

                end

            end)

        end

    end

end

local function createVisualizer()

    for _, part in ipairs(visualizerParts) do if part and part.Parent then part:Destroy() end end

    visualizerParts = {}

    if visualizerConn then visualizerConn:Disconnect() end

    if not isClientAudio or not playingSound or not playingSound.IsPlaying then return end

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

    visualizerConn = runService.RenderStepped:Connect(function()

        if not char or not hrp or not isClientAudio or not playingSound or not playingSound.IsPlaying then

            for _, part in ipairs(visualizerParts) do if part and part.Parent then part:Destroy() end end

            visualizerParts = {}

            if visualizerConn then visualizerConn:Disconnect() end

            visualizerConn = nil

            return

        end

        local t = tick()

        for i, line in ipairs(visualizerParts) do

            local angle = math.rad((i-1)*(360/lines))

            local offset = Vector3.new(math.cos(angle)*radius, 0, math.sin(angle)*radius)

            local loud = playingSound.PlaybackLoudness or 0

            local freqOffset = math.sin(i * 2.8 + t * (2 + (i%4)*0.21)) * 0.7

            local barLoud = loud * (1 + 1 * math.sin(i*3 + t*2.6))

            local height = math.clamp(1.2 + (barLoud/320) + math.abs(math.sin(t*3 + i*1.5))*0.23 + freqOffset, 1, 4)

            line.Size = Vector3.new(0.22, height, 0.22)

            line.CFrame = hrp.CFrame * CFrame.new(offset) * CFrame.new(0, height/2, 0)

            local colorOffset = 0.5 + 0.5 * math.sin(t + i)

            if #tagColors==3 then

                local c1, c2, c3 = tagColors[1], tagColors[2], tagColors[3]

                if colorOffset < 0.5 then

                    line.Color = c1:Lerp(c2, colorOffset*2)

                else

                    line.Color = c2:Lerp(c3, (colorOffset-0.5)*2)

                end

            else

                line.Color = tagColors[1]:Lerp(tagColors[#tagColors], colorOffset)

            end

        end

    end)

end

local function playClientAudio(id)

    stopAllClientSounds()

    if not id or type(id) ~= "number" then return end

    local sound = Instance.new("Sound")

    sound.SoundId = "rbxassetid://"..id

    sound.Volume = currentVolume or 1

    sound.Looped = isLoop

    sound.Pitch = currentPitch or 1

    sound.Name = tostring(id)

    sound.Parent = soundFolder

    sound:Play()

    playingSound = sound

    local musicName = nil

    for num, audioId in pairs(musicIDs) do

        if audioId == id then musicName = musicNames[num] break end

    end

    musicName = musicName or ("Audio "..id)

    sound.Loaded:Connect(function()

        local length = sound.TimeLength or 0

        local pitch = currentPitch or 1

        if pitch == 0 then pitch = 1 end

        showMusicNotification(musicName, length/pitch, isLoop, sound)

        createVisualizer() -- Always create visualizer when playing client audio

    end)

    sound.Ended:Connect(function()

        if visualizerConn then visualizerConn:Disconnect() end

        for _, part in ipairs(visualizerParts) do if part and part.Parent then part:Destroy() end end

        visualizerParts = {}

    end)

    return sound

end

-- IDs TAB

do

    local idsFrame = tabFrames[1]

    local mainScroll = Instance.new("ScrollingFrame", idsFrame)

    mainScroll.Size = UDim2.new(1, -20, 1, -68)

    mainScroll.Position = UDim2.new(0, 10, 0, 10)

    mainScroll.BackgroundTransparency = 1

    mainScroll.CanvasSize = UDim2.new(0,0,0,0)

    mainScroll.ScrollBarThickness = 7

    mainScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

    mainScroll.ZIndex = 11

    local grid = Instance.new("UIGridLayout", mainScroll)

    grid.CellSize = UDim2.new(0, 105, 0, 44)

    grid.CellPadding = UDim2.new(0, 10, 0, 10)

    grid.HorizontalAlignment = Enum.HorizontalAlignment.Center

    grid.VerticalAlignment = Enum.VerticalAlignment.Top

    grid.FillDirectionMaxCells = 2

    for i = 1, 59 do

        local btn = Instance.new("TextButton")

        btn.Size = UDim2.new(0, 105, 0, 44)

        btn.Text = tostring(i)

        btn.Font = Enum.Font.GothamBold

        btn.TextSize = 20

        btn.TextColor3 = white

        btn.BackgroundColor3 = accentBg

        btn.ZIndex = 12

        btn.AutoButtonColor = true

        Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

        createGradientAnim(btn, tagColors, 1.2)

        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = tagColors[#tagColors] btn.TextColor3 = darkBg end)

        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = accentBg btn.TextColor3 = white end)

        btn.Parent = mainScroll

        btn.MouseButton1Click:Connect(function()

            local id = tonumber(musicIDs[tostring(i)])

            if isClientAudio then

                if playingSound and playingSound.IsPlaying and playingSound.Name == tostring(id) then return end

                playClientAudio(id)

            else

                tryPlayBoombox(id)

            end

        end)

    end

    local idsInput = Instance.new("TextBox", idsFrame)

    idsInput.PlaceholderText = "Enter ID here..."

    idsInput.Size = UDim2.new(0.62, -10, 0, 36)

    idsInput.Position = UDim2.new(0, 14, 1, -48)

    idsInput.BackgroundColor3 = accentBg

    idsInput.TextColor3 = white

    idsInput.PlaceholderColor3 = Color3.fromRGB(200,200,200)

    idsInput.Font = Enum.Font.Gotham

    idsInput.TextSize = 15

    idsInput.Text = ""

    idsInput.ClearTextOnFocus = false

    idsInput.ZIndex = 13

    idsInput.AutoLocalize = false

    Instance.new("UICorner", idsInput).CornerRadius = UDim.new(1, 0)

    createGradientAnim(idsInput, tagColors, 1.25)

    local idsPlayBtn = Instance.new("TextButton", idsFrame)

    idsPlayBtn.Text = "Play"

    idsPlayBtn.Size = UDim2.new(0.36, -10, 0, 36)

    idsPlayBtn.Position = UDim2.new(0.62, 0, 1, -48)

    idsPlayBtn.BackgroundColor3 = accentBg

    idsPlayBtn.TextColor3 = white

    idsPlayBtn.Font = Enum.Font.GothamBold

    idsPlayBtn.TextSize = 16

    idsPlayBtn.ZIndex = 13

    idsPlayBtn.AutoButtonColor = true

    Instance.new("UICorner", idsPlayBtn).CornerRadius = UDim.new(1, 0)

    createGradientAnim(idsPlayBtn, tagColors, 1.19)

    idsPlayBtn.MouseEnter:Connect(function() idsPlayBtn.BackgroundColor3 = tagColors[#tagColors] idsPlayBtn.TextColor3 = darkBg end)

    idsPlayBtn.MouseLeave:Connect(function() idsPlayBtn.BackgroundColor3 = accentBg idsPlayBtn.TextColor3 = white end)

    idsPlayBtn.MouseButton1Click:Connect(function()

        local input = idsInput.Text:gsub("rbxassetid://", "")

        local id = tonumber(input)

        if isClientAudio then

            if playingSound and playingSound.IsPlaying and playingSound.Name == tostring(id) then return end

            playClientAudio(id)

        else

            tryPlayBoombox(id)

        end

    end)

end

-- MusicList TAB

do

    local musicListFrame = tabFrames[2]

    local musicScroll = Instance.new("ScrollingFrame", musicListFrame)

    musicScroll.Size = UDim2.new(1, -24, 1, -24)

    musicScroll.Position = UDim2.new(0, 12, 0, 12)

    musicScroll.BackgroundTransparency = 1

    musicScroll.CanvasSize = UDim2.new(0,0,0,0)

    musicScroll.ScrollBarThickness = 6

    musicScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

    musicScroll.Name = "musicScroll"

    musicScroll.ZIndex = 14

    local musicListLayout = Instance.new("UIListLayout", musicScroll)

    musicListLayout.Padding = UDim.new(0,8)

    musicListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    for k = 1, 59 do

        local lbl = Instance.new("TextLabel", musicScroll)

        lbl.Size = UDim2.new(1, -10, 0, 28)

        lbl.BackgroundTransparency = 1

        lbl.Text = "["..k.."] - "..musicNames[tostring(k)]

        lbl.Font = Enum.Font.GothamBold

        lbl.TextColor3 = white

        lbl.TextSize = 15

        lbl.TextXAlignment = Enum.TextXAlignment.Left

        lbl.ZIndex = 14

        createGradientAnim(lbl, tagColors, 1.24)

    end

end

-- ClientAudio TAB

do

    local clientAudioFrame = tabFrames[3]

    local clientAudioToggleBtn = Instance.new("TextButton", clientAudioFrame)

    clientAudioToggleBtn.Size = UDim2.new(1, -20, 0, 36)

    clientAudioToggleBtn.Position = UDim2.new(0, 10, 0, 10)

    clientAudioToggleBtn.BackgroundColor3 = accentBg

    clientAudioToggleBtn.TextColor3 = white

    clientAudioToggleBtn.Font = Enum.Font.GothamBold

    clientAudioToggleBtn.TextSize = 15

    clientAudioToggleBtn.ZIndex = 15

    Instance.new("UICorner", clientAudioToggleBtn).CornerRadius = UDim.new(1, 0)

    createGradientAnim(clientAudioToggleBtn, tagColors, 1.2)

    clientAudioToggleBtn.Text = "Client Audio: Off"

    local clientAudioLoopBtn = Instance.new("TextButton", clientAudioFrame)

    clientAudioLoopBtn.Text = "Loop: NO"

    clientAudioLoopBtn.Size = UDim2.new(0.5, -14, 0, 30)

    clientAudioLoopBtn.Position = UDim2.new(0, 10, 0, 56)

    clientAudioLoopBtn.BackgroundColor3 = accentBg

    clientAudioLoopBtn.TextColor3 = white

    clientAudioLoopBtn.Font = Enum.Font.GothamBold

    clientAudioLoopBtn.TextSize = 13

    clientAudioLoopBtn.ZIndex = 15

    clientAudioLoopBtn.Visible = isClientAudio

    Instance.new("UICorner", clientAudioLoopBtn).CornerRadius = UDim.new(1, 0)

    createGradientAnim(clientAudioLoopBtn, tagColors, 1.19)

    local clientAudioVolumeBtn = Instance.new("TextButton", clientAudioFrame)

    clientAudioVolumeBtn.Text = "Volume: "..tostring(currentVolume)

    clientAudioVolumeBtn.Size = UDim2.new(0.5, -14, 0, 30)

    clientAudioVolumeBtn.Position = UDim2.new(0.5, 8, 0, 56)

    clientAudioVolumeBtn.BackgroundColor3 = accentBg

    clientAudioVolumeBtn.TextColor3 = white

    clientAudioVolumeBtn.Font = Enum.Font.GothamBold

    clientAudioVolumeBtn.TextSize = 13

    clientAudioVolumeBtn.ZIndex = 15

    clientAudioVolumeBtn.Visible = isClientAudio

    Instance.new("UICorner", clientAudioVolumeBtn).CornerRadius = UDim.new(1, 0)

    createGradientAnim(clientAudioVolumeBtn, tagColors, 1.22)

    local clientAudioPitchBtn = Instance.new("TextButton", clientAudioFrame)

    clientAudioPitchBtn.Text = "Pitch: "..tostring(currentPitch)

    clientAudioPitchBtn.Size = UDim2.new(0.5, -14, 0, 30)

    clientAudioPitchBtn.Position = UDim2.new(0, 10, 0, 96)

    clientAudioPitchBtn.BackgroundColor3 = accentBg

    clientAudioPitchBtn.TextColor3 = white

    clientAudioPitchBtn.Font = Enum.Font.GothamBold

    clientAudioPitchBtn.TextSize = 13

    clientAudioPitchBtn.ZIndex = 15

    clientAudioPitchBtn.Visible = isClientAudio

    Instance.new("UICorner", clientAudioPitchBtn).CornerRadius = UDim.new(1, 0)

    createGradientAnim(clientAudioPitchBtn, tagColors, 1.22)

    local selectorPopup = nil

    function showSelectorPopup(title, values, callback)

        if selectorPopup then selectorPopup:Destroy() selectorPopup = nil end

        selectorPopup = Instance.new("Frame", screenGui)

        selectorPopup.Size = UDim2.new(0, 210, 0, 36 + 40*#values)

        selectorPopup.Position = UDim2.new(0.5, -105, 0.5, -((36 + 40*#values)//2))

        selectorPopup.BackgroundColor3 = accentBg

        selectorPopup.ZIndex = 5000

        Instance.new("UICorner", selectorPopup).CornerRadius = UDim.new(0, 12)

        createGradientAnim(selectorPopup, tagColors, 1.3)

        local titleLabel = Instance.new("TextLabel", selectorPopup)

        titleLabel.Text = title

        titleLabel.Size = UDim2.new(1, 0, 0, 36)

        titleLabel.Position = UDim2.new(0, 0, 0, 0)

        titleLabel.BackgroundTransparency = 1

        titleLabel.TextColor3 = white

        titleLabel.Font = Enum.Font.GothamBold

        titleLabel.TextSize = 18

        titleLabel.ZIndex = 5001

        createGradientAnim(titleLabel, tagColors, 1.25)

        for i, val in ipairs(values) do

            local btn = Instance.new("TextButton", selectorPopup)

            local mark = " "

            if title == "Choose Volume:" and val == currentVolume then mark = "➡ " end

            if title == "Choose Pitch:" and val == currentPitch then mark = "➡ " end

            btn.Text = mark .. tostring(val)

            btn.Size = UDim2.new(1, -20, 0, 32)

            btn.Position = UDim2.new(0, 10, 0, 36 + (i-1)*40)

            btn.BackgroundColor3 = darkBg

            btn.TextColor3 = white

            btn.Font = Enum.Font.GothamBold

            btn.TextSize = 16

            btn.ZIndex = 5002

            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

            createGradientAnim(btn, tagColors, 1.25)

            btn.MouseButton1Click:Connect(function()

                if selectorPopup then selectorPopup:Destroy() selectorPopup = nil end

                callback(val)

            end)

        end

    end

    clientAudioToggleBtn.MouseButton1Click:Connect(function()

        isClientAudio = not isClientAudio

        clientAudioToggleBtn.Text = "Client Audio: "..(isClientAudio and "On" or "Off")

        clientAudioLoopBtn.Visible = isClientAudio

        clientAudioVolumeBtn.Visible = isClientAudio

        clientAudioPitchBtn.Visible = isClientAudio

        if not isClientAudio then

            stopAllClientSounds()

            if visualizerConn then visualizerConn:Disconnect() end

            for _, part in ipairs(visualizerParts) do if part and part.Parent then part:Destroy() end end

            visualizerParts = {}

        end

    end)

    clientAudioLoopBtn.MouseButton1Click:Connect(function()

        isLoop = not isLoop

        clientAudioLoopBtn.Text = isLoop and "Loop: YES" or "Loop: NO"

        if playingSound then playingSound.Looped = isLoop end

    end)

    clientAudioVolumeBtn.MouseButton1Click:Connect(function()

        showSelectorPopup("Choose Volume:", {0.5,0.75,1.0,1.5,2.0,2.5}, function(vol)

            currentVolume = vol or 1

            clientAudioVolumeBtn.Text = "Volume: "..tostring(currentVolume)

            for _, s in ipairs(soundFolder:GetChildren()) do

                if s:IsA("Sound") then s.Volume = currentVolume end

            end

        end)

    end)

    clientAudioPitchBtn.MouseButton1Click:Connect(function()

        showSelectorPopup("Choose Pitch:", {0.5,0.75,1.0}, function(pitch)

            currentPitch = pitch or 1

            clientAudioPitchBtn.Text = "Pitch: "..tostring(currentPitch)

            for _, s in ipairs(soundFolder:GetChildren()) do

                if s:IsA("Sound") then s.Pitch = currentPitch end

            end

        end)

    end)

end

-- Scripts TAB

do

    local scriptsFrame = tabFrames[4]

    local loggerBtn = Instance.new("TextButton", scriptsFrame)

    loggerBtn.Size = UDim2.new(1, -20, 0, 38)

    loggerBtn.Position = UDim2.new(0, 10, 0, 28)

    loggerBtn.BackgroundColor3 = accentBg

    loggerBtn.TextColor3 = white

    loggerBtn.Font = Enum.Font.GothamBold

    loggerBtn.TextSize = 15

    loggerBtn.ZIndex = 17

    loggerBtn.Text = "Execute Audio Logger"

    Instance.new("UICorner", loggerBtn).CornerRadius = UDim.new(1, 0)

    createGradientAnim(loggerBtn, tagColors, 1.29)

    loggerBtn.MouseButton1Click:Connect(function()

        loadstring(game:HttpGet("https://pastefy.app/AKzADxrc/raw"))()

    end)

end

-- Credits TAB

do

    local creditsFrame = tabFrames[5]

    local creditsLabel = Instance.new("TextLabel", creditsFrame)

    creditsLabel.Size = UDim2.new(1, -16, 1, -60)

    creditsLabel.Position = UDim2.new(0, 8, 0, 8)

    creditsLabel.Text = "Made by LynxDev.\nAuralynx © 2025."

    creditsLabel.Font = Enum.Font.GothamBold

    creditsLabel.TextColor3 = white

    creditsLabel.TextSize = 16

    creditsLabel.BackgroundTransparency = 1

    creditsLabel.ZIndex = 18

    createGradientAnim(creditsLabel, tagColors, 1.32)

end

showTab(1)