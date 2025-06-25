local musicIDs = {
    ["1"] = 89907278904871,
    ["2"] = 99409598156364,
    ["3"] = 133900561957103,
    ["4"] = 93768636184697,
    ["5"] = 72334211564889,
    ["6"] = 140296674808875,
}

local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "FreemanMusicUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local musicListBtnClicked = false
local isClientAudio = false
local isLoop = false
local currentVolume = 1
local currentPitch = 1

local soundFolder = workspace:FindFirstChild("FreemanClientSounds")
if not soundFolder then
    soundFolder = Instance.new("Folder")
    soundFolder.Name = "FreemanClientSounds"
    soundFolder.Parent = workspace
end

local function stopAllClientSounds()
    for _, s in ipairs(soundFolder:GetChildren()) do
        if s:IsA("Sound") then
            s:Stop()
            s:Destroy()
        end
    end
end

local function playClientAudio(id, parent)
    stopAllClientSounds()
    local sound = Instance.new("Sound", parent or soundFolder)
    sound.SoundId = "rbxassetid://"..id
    sound.Volume = currentVolume
    sound.Looped = isLoop
    sound.Pitch = currentPitch
    sound.Name = tostring(id)
    sound:Play()
    return sound
end

local function destroyAllNotificationBlocks()
    for _, guiObj in ipairs(game:GetService("CoreGui"):GetChildren()) do
        if guiObj:IsA("ScreenGui") or guiObj:IsA("Frame") then
            for _, frame in ipairs(guiObj:GetDescendants()) do
                if frame.Name == "block" or frame.Name == "_G.FreemanAudioLogPopup" or (frame:IsA("Frame") and frame.ZIndex == 10000) then
                    pcall(function() frame:Destroy() end)
                end
            end
        end
    end
    if _G.FreemanAudioLogPopup and typeof(_G.FreemanAudioLogPopup) == "Instance" then
        pcall(function() _G.FreemanAudioLogPopup:Destroy() end)
        _G.FreemanAudioLogPopup = nil
    end
end

local function showSelectorPopup(titleText, options, callback)
    if gui:FindFirstChild("SelectorPopup") then gui.SelectorPopup:Destroy() end
    if gui:FindFirstChild("SelectorPopupBlock") then gui.SelectorPopupBlock:Destroy() end

    local block = Instance.new("Frame", gui)
    block.Name = "SelectorPopupBlock"
    block.Size = UDim2.new(1,0,1,0)
    block.BackgroundTransparency = 0.35
    block.BackgroundColor3 = Color3.fromRGB(0,0,0)
    block.ZIndex = 19999
    block.Active = true

    local popup = Instance.new("Frame", gui)
    popup.Name = "SelectorPopup"
    popup.Size = UDim2.new(0, 330, 0, 130)
    popup.Position = UDim2.new(0.5, -165, 0.5, -65)
    popup.BackgroundColor3 = Color3.fromRGB(25,25,25)
    popup.BorderSizePixel = 0
    popup.ZIndex = 20000
    popup.Active = true
    Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 14)

    local title = Instance.new("TextLabel", popup)
    title.Size = UDim2.new(1, -16, 0, 32)
    title.Position = UDim2.new(0,8,0,7)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextSize = 16
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 20001

    local btnCount = #options
    local btnW = math.floor((298-(btnCount-1)*7)/btnCount) -- padding entre
    for i, opt in ipairs(options) do
        local btn = Instance.new("TextButton", popup)
        btn.Size = UDim2.new(0, btnW, 0, 38)
        btn.Position = UDim2.new(0, 16+((btnW+7)*(i-1)), 0, 50)
        btn.Text = tostring(opt)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.ZIndex = 20001
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        btn.MouseButton1Click:Connect(function()
            popup:Destroy()
            block:Destroy()
            if callback then callback(opt) end
        end)
    end
end

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 340, 0, 360)
frame.Position = UDim2.new(1, -355, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
frame.BackgroundTransparency = 0

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -110, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Freeman HUB ðŸŽµ 4.75"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.FredokaOne
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

local minimize = Instance.new("TextButton", header)
minimize.Size = UDim2.new(0, 35, 1, 0)
minimize.Position = UDim2.new(1, -70, 0, 0)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimize.BorderSizePixel = 0
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 12)

local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0, 35, 1, 0)
close.Position = UDim2.new(1, -35, 0, 0)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
close.BorderSizePixel = 0
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 12)

local sideBar = Instance.new("Frame", frame)
sideBar.Size = UDim2.new(0, 44, 1, -35)
sideBar.Position = UDim2.new(1, -44, 0, 35)
sideBar.BackgroundTransparency = 1

local iconBtnY = 8
local iconBtnDelta = 50

local function makeIconBtn(parent, icon, y)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -8, 0, 36)
    btn.Position = UDim2.new(0, 4, 0, y)
    btn.Text = icon
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 24
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    btn.BorderSizePixel = 0
    return btn
end

local musicListBtn = makeIconBtn(sideBar, "ðŸ“œ", iconBtnY)
local settingsButton = makeIconBtn(sideBar, "âš™ï¸", iconBtnY + iconBtnDelta*1)
local modeButton = makeIconBtn(sideBar, isClientAudio and "ðŸ”Šâœ…" or "ðŸ”ŠâŽ", iconBtnY + iconBtnDelta*2)
local creditsButton = makeIconBtn(sideBar, "ðŸ‘¤", iconBtnY + iconBtnDelta*3)
local audioLogButton = makeIconBtn(sideBar, "ðŸ”Ž", iconBtnY + iconBtnDelta*4)

local openIcon = Instance.new("TextButton", gui)
openIcon.Size = UDim2.new(0, 40, 0, 40)
openIcon.Position = UDim2.new(1, -50, 1, -50)
openIcon.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
openIcon.Text = "+"
openIcon.Visible = false
openIcon.TextSize = 24
openIcon.Font = Enum.Font.GothamBold
openIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)
openIcon.Active = true
openIcon.Draggable = true

local mainFrame = Instance.new("Frame", frame)
mainFrame.Position = UDim2.new(0, 0, 0, 35)
mainFrame.Size = UDim2.new(1, -44, 1, -110)
mainFrame.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", mainFrame)
grid.CellSize = UDim2.new(0, 100, 0, 40)
grid.CellPadding = UDim2.new(0, 10, 0, 10)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 2

local creditsFrame = Instance.new("Frame", frame)
creditsFrame.Position = UDim2.new(0, 0, 0, 35)
creditsFrame.Size = UDim2.new(1, -44, 1, -110)
creditsFrame.BackgroundTransparency = 1
creditsFrame.Visible = false

local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -20, 1, -20)
creditsLabel.Position = UDim2.new(0, 10, 0, 10)
creditsLabel.Text = "Made by Freeman4i37!\nThe best Roblox music GUI!\nThank you for using my script."
creditsLabel.Font = Enum.Font.Gotham
creditsLabel.TextColor3 = Color3.fromRGB(255,255,255)
creditsLabel.TextSize = 14
creditsLabel.TextWrapped = true
creditsLabel.TextYAlignment = Enum.TextYAlignment.Top
creditsLabel.BackgroundTransparency = 1

local musicListFrame = Instance.new("Frame", frame)
musicListFrame.Position = UDim2.new(0, 0, 0, 35)
musicListFrame.Size = UDim2.new(1, -44, 1, -110)
musicListFrame.BackgroundTransparency = 1
musicListFrame.Visible = false

local musicListLabel = Instance.new("TextLabel", musicListFrame)
musicListLabel.Size = UDim2.new(1, -20, 1, -20)
musicListLabel.Position = UDim2.new(0, 10, 0, 10)
musicListLabel.Text = "[1] - Funk da Praia, added by Freeman\n[2] - Retrolam Funk, added by Freeman\n[3] - Trash Funk, added by Freeman\n[4] - 2609 (Jersey Club), added by Freeman,\n[5] - Met Her on The Internet, added by Freeman\n[6] - Old Swing Funk, added by Freeman"
musicListLabel.Font = Enum.Font.Gotham
musicListLabel.TextColor3 = Color3.fromRGB(255,255,255)
musicListLabel.TextSize = 10
musicListLabel.TextWrapped = true
musicListLabel.TextYAlignment = Enum.TextYAlignment.Top
musicListLabel.BackgroundTransparency = 1

local settingsFrame = Instance.new("Frame", frame)
settingsFrame.Position = UDim2.new(0, 0, 0, 35)
settingsFrame.Size = UDim2.new(1, -44, 1, -110)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Visible = false

local muteBoomboxButton = Instance.new("TextButton", settingsFrame)
muteBoomboxButton.Size = UDim2.new(1, 0, 0, 40)
muteBoomboxButton.Position = UDim2.new(0, 0, 0, 10)
muteBoomboxButton.Text = "Mute All Boomboxes"
muteBoomboxButton.Font = Enum.Font.GothamBold
muteBoomboxButton.TextSize = 16
muteBoomboxButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
muteBoomboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", muteBoomboxButton).CornerRadius = UDim.new(0, 10)

local muteGameSoundsButton = Instance.new("TextButton", settingsFrame)
muteGameSoundsButton.Size = UDim2.new(1, 0, 0, 40)
muteGameSoundsButton.Position = UDim2.new(0, 0, 0, 60)
muteGameSoundsButton.Text = "Mute All GameSounds"
muteGameSoundsButton.Font = Enum.Font.GothamBold
muteGameSoundsButton.TextSize = 16
muteGameSoundsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
muteGameSoundsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", muteGameSoundsButton).CornerRadius = UDim.new(0, 10)

local buttons = {}
for _, name in ipairs({"1", "2", "3", "4", "5", "6"}) do
    local id = musicIDs[name]
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 40)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    btn.Parent = mainFrame
    btn.MouseButton1Click:Connect(function()
        if isClientAudio then
            playClientAudio(id)
        else
            if player.Character and player.Character:FindFirstChild("Radio") and player.Character.Radio:FindFirstChild("Remote") then
                local args = { [1] = "PlaySong", [2] = id }
                pcall(function()
                    player.Character.Radio.Remote:FireServer(unpack(args))
                end)
            else
                warn("Radio or Remote not found!")
            end
        end
    end)
    table.insert(buttons, btn)
end

musicListBtn.MouseButton1Click:Connect(function()
    musicListBtnClicked = not musicListBtnClicked
    mainFrame.Visible = not musicListBtnClicked
    musicListFrame.Visible = musicListBtnClicked
    creditsFrame.Visible = false
    settingsFrame.Visible = false
end)

local inputBox = Instance.new("TextBox", frame)
inputBox.PlaceholderText = "Audio ID here..."
inputBox.Size = UDim2.new(0.6, -10, 0, 35)
inputBox.Position = UDim2.new(0, 10, 1, -70)
inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 16
inputBox.Text = ""
inputBox.ClearTextOnFocus = false
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 10)

local playButton = Instance.new("TextButton", frame)
playButton.Text = "PLAY"
playButton.Size = UDim2.new(0.4, -10, 0, 35)
playButton.Position = UDim2.new(0.6, 0, 1, -70)
playButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
playButton.Font = Enum.Font.GothamBold
playButton.TextSize = 18
Instance.new("UICorner", playButton).CornerRadius = UDim.new(0, 10)

playButton.MouseButton1Click:Connect(function()
    local input = inputBox.Text:gsub("rbxassetid://", "")
    local id = tonumber(input)
    if id then
        if isClientAudio then
            playClientAudio(id)
        else
            if player.Character and player.Character:FindFirstChild("Radio") and player.Character.Radio:FindFirstChild("Remote") then
                local args = { [1] = "PlaySong", [2] = id }
                pcall(function()
                    player.Character.Radio.Remote:FireServer(unpack(args))
                end)
            else
                warn("Radio or Remote not found!")
            end
        end
    else
        warn("INVALID ID")
    end
end)

local loopButton = Instance.new("TextButton", frame)
loopButton.Text = "Loop: NO"
loopButton.Size = UDim2.new(0, 70, 0, 25)
loopButton.Position = UDim2.new(0, 10, 1, -35)
loopButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
loopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loopButton.Font = Enum.Font.GothamBold
loopButton.TextSize = 12
Instance.new("UICorner", loopButton).CornerRadius = UDim.new(0, 10)
loopButton.Visible = false

local stopButton = Instance.new("TextButton", frame)
stopButton.Text = "Stop"
stopButton.Size = UDim2.new(0, 70, 0, 25)
stopButton.Position = UDim2.new(0, 90, 1, -35)
stopButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.Font = Enum.Font.GothamBold
stopButton.TextSize = 12
Instance.new("UICorner", stopButton).CornerRadius = UDim.new(0, 10)
stopButton.Visible = false

local volumeButton = Instance.new("TextButton", frame)
volumeButton.Text = "Vol: 1"
volumeButton.Size = UDim2.new(0, 70, 0, 25)
volumeButton.Position = UDim2.new(0, 170, 1, -35)
volumeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
volumeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
volumeButton.Font = Enum.Font.GothamBold
volumeButton.TextSize = 12
Instance.new("UICorner", volumeButton).CornerRadius = UDim.new(0, 10)
volumeButton.Visible = false

local pitchButton = Instance.new("TextButton", frame)
pitchButton.Text = "Pitch: 1"
pitchButton.Size = UDim2.new(0, 70, 0, 25)
pitchButton.Position = UDim2.new(0, 250, 1, -35)
pitchButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
pitchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
pitchButton.Font = Enum.Font.GothamBold
pitchButton.TextSize = 12
Instance.new("UICorner", pitchButton).CornerRadius = UDim.new(0, 10)
pitchButton.Visible = false

loopButton.MouseButton1Click:Connect(function()
    isLoop = not isLoop
    loopButton.Text = isLoop and "Loop: YES" or "Loop: NO"
end)

stopButton.MouseButton1Click:Connect(function()
    stopAllClientSounds()
end)

volumeButton.MouseButton1Click:Connect(function()
    showSelectorPopup("CHOOSE THE VOLUME", {0.5,0.75,1.0,1.5,2.0,3.0,4.0,5.0,6.0}, function(vol)
        currentVolume = vol
        volumeButton.Text = "Vol: " .. tostring(currentVolume)
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then
                s.Volume = currentVolume
            end
        end
    end)
end)

pitchButton.MouseButton1Click:Connect(function()
    showSelectorPopup("CHOOSE THE PITCH", {0.75,1.0,1.5,2.0,3.0}, function(pitch)
        currentPitch = pitch
        pitchButton.Text = "Pitch: " .. tostring(currentPitch)
        for _, s in ipairs(soundFolder:GetChildren()) do
            if s:IsA("Sound") then
                s.Pitch = currentPitch
            end
        end
    end)
end)

modeButton.MouseButton1Click:Connect(function()
    isClientAudio = not isClientAudio
    modeButton.Text = isClientAudio and "ðŸ”Šâœ…" or "ðŸ”ŠâŽ"
    loopButton.Visible = isClientAudio
    stopButton.Visible = isClientAudio
    volumeButton.Visible = isClientAudio
    pitchButton.Visible = isClientAudio
end)

local inCredits = false
creditsButton.MouseButton1Click:Connect(function()
    inCredits = not inCredits
    mainFrame.Visible = not inCredits
    creditsFrame.Visible = inCredits
    musicListFrame.Visible = false
    settingsFrame.Visible = false
end)

local inSettings = false
settingsButton.MouseButton1Click:Connect(function()
    inSettings = not inSettings
    mainFrame.Visible = not inSettings
    creditsFrame.Visible = false
    musicListFrame.Visible = false
    settingsFrame.Visible = inSettings
    muteBoomboxButton.Text = boomboxMuted and "Unmute All Boomboxes" or "Mute All Boomboxes"
    muteGameSoundsButton.Text = gameSoundsMuted and "Unmute All GameSounds" or "Mute All GameSounds"
end)

local boomboxMuted = false
muteBoomboxButton.MouseButton1Click:Connect(function()
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= player and plr.Character then
            local radio = plr.Character:FindFirstChild("Radio")
            if radio then
                for _, s in ipairs(radio:GetDescendants()) do
                    if s:IsA("Sound") then
                        s.Volume = not boomboxMuted and 0 or 1
                    end
                end
            end
        end
    end
    boomboxMuted = not boomboxMuted
    muteBoomboxButton.Text = boomboxMuted and "Unmute All Boomboxes" or "Mute All Boomboxes"
end)

local gameSoundsMuted = false
local muteGameSoundsConn

local function isMyBoombox(sound)
    if sound:IsDescendantOf(soundFolder) then return true end
    if player.Character then
        local radio = player.Character:FindFirstChild("Radio")
        if radio and sound:IsDescendantOf(radio) then return true end
    end
    return false
end

local function setGameSoundsMuted(mute)
    if mute and not muteGameSoundsConn then
        muteGameSoundsConn = runService.RenderStepped:Connect(function()
            for _, s in ipairs(workspace:GetDescendants()) do
                if s:IsA("Sound") and not isMyBoombox(s) then s.Volume = 0 end
            end
            for _, s in ipairs(game:GetService("SoundService"):GetDescendants()) do
                if s:IsA("Sound") then s.Volume = 0 end
            end
        end)
    elseif not mute and muteGameSoundsConn then
        muteGameSoundsConn:Disconnect()
        muteGameSoundsConn = nil
        for _, s in ipairs(workspace:GetDescendants()) do
            if s:IsA("Sound") and not isMyBoombox(s) then s.Volume = 1 end
        end
        for _, s in ipairs(game:GetService("SoundService"):GetDescendants()) do
            if s:IsA("Sound") then s.Volume = 1 end
        end
    end
    gameSoundsMuted = mute
    muteGameSoundsButton.Text = mute and "Unmute All GameSounds" or "Mute All GameSounds"
end

muteGameSoundsButton.MouseButton1Click:Connect(function()
    setGameSoundsMuted(not gameSoundsMuted)
end)

minimize.MouseButton1Click:Connect(function()
    local tween = tweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = UDim2.new(1, -355, 0.5, -280)})
    tween:Play()
    tween.Completed:Wait()
    frame.Visible = false
    openIcon.Visible = true
end)

openIcon.MouseButton1Click:Connect(function()
    frame.Visible = true
    openIcon.Visible = false
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(1, -355, 0.5, -280)
    local tween = tweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(1, -355, 0.5, -180)})
    tween:Play()
end)

close.MouseButton1Click:Connect(function()
    destroyAllNotificationBlocks()
    gui:Destroy()
    if soundFolder then soundFolder:Destroy() end
    if muteGameSoundsConn then muteGameSoundsConn:Disconnect() muteGameSoundsConn = nil end
    if _G.FreemanAudioLogUI then _G.FreemanAudioLogUI:Destroy() end
end)

local function showAchievementBar(text, duration)
    local bar = Instance.new("Frame", gui)
    bar.Size = UDim2.new(0, 250, 0, 45)
    bar.Position = UDim2.new(1, -260, 0, -50)
    bar.BackgroundColor3 = Color3.fromRGB(30,30,30)
    bar.BackgroundTransparency = 0.2
    bar.BorderSizePixel = 0
    bar.AnchorPoint = Vector2.new(0,0)
    local uicorner = Instance.new("UICorner", bar)
    uicorner.CornerRadius = UDim.new(0, 12)
    local label = Instance.new("TextLabel", bar)
    label.Size = UDim2.new(1, -16, 1, -12)
    label.Position = UDim2.new(0, 8, 0, 6)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    bar.Position = UDim2.new(1, -260, 0, -50)
    bar.BackgroundTransparency = 1
    label.TextTransparency = 1
    local tweenIn = tweenService:Create(bar, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -260, 0, 18), BackgroundTransparency = 0.2})
    local tweenLabelIn = tweenService:Create(label, TweenInfo.new(0.25), {TextTransparency = 0})
    tweenIn:Play()
    tweenLabelIn:Play()
    tweenIn.Completed:Wait()
    wait(duration or 5)
    local tweenOut = tweenService:Create(bar, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -260, 0, -50), BackgroundTransparency = 1})
    local tweenLabelOut = tweenService:Create(label, TweenInfo.new(0.25), {TextTransparency = 1})
    tweenOut:Play()
    tweenLabelOut:Play()
    tweenOut.Completed:Wait()
    bar:Destroy()
end

coroutine.wrap(function()
    showAchievementBar("Welcome to Freeman HUB 4.75!\nScript by Freeman4i37.",4)
end)()

local ownerUsername = "Kaua_452"
local meetOwnerAchieved = false
game:GetService("Players").PlayerAdded:Connect(function(plr)
    if not meetOwnerAchieved and plr.Name == ownerUsername and player.Name ~= ownerUsername then
        meetOwnerAchieved = true
        coroutine.wrap(function()
            showAchievementBar("[Meet The Owner]\nMeet the owner of Freemanâ€™s HUB.",5)
        end)()
    end
end)
for _,plr in ipairs(game:GetService("Players"):GetPlayers()) do
    if not meetOwnerAchieved and plr.Name == ownerUsername and player.Name ~= ownerUsername then
        meetOwnerAchieved = true
        coroutine.wrap(function()
            showAchievementBar("[Meet The Owner]\nMeet the owner of Freeman HUB.",5)
        end)()
    end
end

local function createNotification(msg, yesCallback, noCallback)
    if _G.FreemanAudioLogPopup then _G.FreemanAudioLogPopup:Destroy() end
    local block = Instance.new("Frame", gui)
    block.Size = UDim2.new(1, 0, 1, 0)
    block.BackgroundTransparency = 1
    block.ZIndex = 10000
    block.Active = true
    block.Name = "block"

    local popup = Instance.new("Frame", block)
    _G.FreemanAudioLogPopup = popup
    popup.Size = UDim2.new(0, 370, 0, 130)
    popup.Position = UDim2.new(0.5, -185, 0.5, -65)
    popup.BackgroundColor3 = Color3.fromRGB(0,0,0)
    popup.BorderSizePixel = 0
    popup.ZIndex = 10001
    popup.Active = true

    Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 16)
    local label = Instance.new("TextLabel", popup)
    label.Size = UDim2.new(1, -20, 0, 80)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextSize = 15
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    label.Text = msg

    local yesBtn = Instance.new("TextButton", popup)
    yesBtn.Size = UDim2.new(0, 120, 0, 30)
    yesBtn.Position = UDim2.new(0, 30, 1, -45)
    yesBtn.Text = "YES"
    yesBtn.Font = Enum.Font.GothamBold
    yesBtn.TextColor3 = Color3.fromRGB(255,255,255)
    yesBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", yesBtn).CornerRadius = UDim.new(0,10)

    local noBtn = Instance.new("TextButton", popup)
    noBtn.Size = UDim2.new(0, 120, 0, 30)
    noBtn.Position = UDim2.new(1, -150, 1, -45)
    noBtn.Text = "NO"
    noBtn.Font = Enum.Font.GothamBold
    noBtn.TextColor3 = Color3.fromRGB(255,255,255)
    noBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", noBtn).CornerRadius = UDim.new(0,10)

    yesBtn.MouseButton1Click:Connect(function()
        block:Destroy()
        _G.FreemanAudioLogPopup = nil
        if yesCallback then yesCallback() end
    end)
    noBtn.MouseButton1Click:Connect(function()
        block:Destroy()
        _G.FreemanAudioLogPopup = nil
        if noCallback then noCallback() end
    end)
end

local function getAudioCreator(sound)
    if typeof(sound.CreatorId) == "number" and pcall(function() return game:GetService("Players"):GetNameFromUserIdAsync(sound.CreatorId) end) then
        return game:GetService("Players"):GetNameFromUserIdAsync(sound.CreatorId)
    end
    return "Unknown"
end

local function createAudioLoggerPlayer(parent, audioData, onBack)
    for _, child in ipairs(parent:GetChildren()) do
        child.Visible = false
    end
    local panel = Instance.new("Frame", parent)
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.BackgroundColor3 = Color3.fromRGB(10,10,10)
    panel.BorderSizePixel = 0
    panel.ZIndex = 15
    for _,v in ipairs(panel.Parent:GetChildren()) do
        if v ~= panel then v.Visible = false end
    end
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0,13)

    local backBtn = Instance.new("TextButton", panel)
    backBtn.Size = UDim2.new(0, 70, 0, 30)
    backBtn.Position = UDim2.new(0, 15, 0, 15)
    backBtn.Text = "BACK"
    backBtn.Font = Enum.Font.GothamBold
    backBtn.TextColor3 = Color3.fromRGB(255,255,255)
    backBtn.TextSize = 14
    backBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", backBtn).CornerRadius = UDim.new(0,8)

    local stopBtn = Instance.new("TextButton", panel)
    stopBtn.Size = UDim2.new(0, 70, 0, 30)
    stopBtn.Position = UDim2.new(0, 95, 0, 15)
    stopBtn.Text = "STOP"
    stopBtn.Font = Enum.Font.GothamBold
    stopBtn.TextColor3 = Color3.fromRGB(255,255,255)
    stopBtn.TextSize = 14
    stopBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0,8)

    local playBtn = Instance.new("TextButton", panel)
    playBtn.Size = UDim2.new(0, 70, 0, 30)
    playBtn.Position = UDim2.new(0, 175, 0, 15)
    playBtn.Text = "PLAY"
    playBtn.Font = Enum.Font.GothamBold
    playBtn.TextColor3 = Color3.fromRGB(255,255,255)
    playBtn.TextSize = 14
    playBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", playBtn).CornerRadius = UDim.new(0,8)

    local copyBtn = Instance.new("TextButton", panel)
    copyBtn.Size = UDim2.new(0, 70, 0, 30)
    copyBtn.Position = UDim2.new(0, 255, 0, 15)
    copyBtn.Text = "COPY"
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
    copyBtn.TextSize = 14
    copyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0,8)

    local infoLbl = Instance.new("TextLabel", panel)
    infoLbl.Size = UDim2.new(1, -30, 0, 30)
    infoLbl.Position = UDim2.new(0, 15, 0, 55)
    infoLbl.BackgroundTransparency = 1
    infoLbl.Text = (audioData.name or "Unknown") .. " - ID: " .. tostring(audioData.id) .. " - [".. (audioData.creator or "Unknown") .. "]"
    infoLbl.Font = Enum.Font.GothamBold
    infoLbl.TextColor3 = Color3.fromRGB(255,255,255)
    infoLbl.TextSize = 13
    infoLbl.TextWrapped = true
    infoLbl.TextXAlignment = Enum.TextXAlignment.Left

    local timeLbl = Instance.new("TextLabel", panel)
    timeLbl.Size = UDim2.new(1, -30, 0, 30)
    timeLbl.Position = UDim2.new(0, 15, 0, 85)
    timeLbl.BackgroundTransparency = 1
    timeLbl.Text = "0:00 / Identify"
    timeLbl.Font = Enum.Font.GothamBold
    timeLbl.TextColor3 = Color3.fromRGB(255,255,255)
    timeLbl.TextSize = 13
    timeLbl.TextXAlignment = Enum.TextXAlignment.Left

    local currentSound = nil
    local updateConn = nil

    local function updateTimer()
        if currentSound and currentSound.IsLoaded then
            local len = math.floor(currentSound.TimeLength)
            local pos = math.floor(currentSound.TimePosition)
            local function secToStr(s)
                return string.format("%d:%02d", math.floor(s/60), s%60)
            end
            timeLbl.Text = secToStr(pos) .. " / " .. secToStr(len)
        else
            timeLbl.Text = "0:00 / Identify"
        end
    end

    local function stopSound()
        if updateConn then updateConn:Disconnect() updateConn = nil end
        if currentSound then
            currentSound:Stop()
            currentSound:Destroy()
            currentSound = nil
        end
        updateTimer()
    end

    playBtn.MouseButton1Click:Connect(function()
        stopSound()
        currentSound = playClientAudio(audioData.id, soundFolder)
        updateConn = runService.RenderStepped:Connect(updateTimer)
        currentSound.Ended:Connect(function()
            stopSound()
        end)
    end)
    stopBtn.MouseButton1Click:Connect(function()
        stopSound()
    end)
    copyBtn.MouseButton1Click:Connect(function()
        setclipboard(tostring(audioData.id))
        showAchievementBar("Audio ID copied!", 1.5)
    end)
    backBtn.MouseButton1Click:Connect(function()
        stopSound()
        panel:Destroy()
        for _, child in ipairs(parent:GetChildren()) do
            child.Visible = true
        end
        if onBack then onBack() end
    end)
end

local function createAudioLogUI()
    if _G.FreemanAudioLogUI then _G.FreemanAudioLogUI:Destroy() end
    local logGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    logGui.Name = "FreemanAudioLogUI"
    logGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    logGui.ResetOnSpawn = false
    _G.FreemanAudioLogUI = logGui

    local bigFrame = Instance.new("Frame", logGui)
    bigFrame.Size = UDim2.new(0, 550, 0, 470)
    bigFrame.Position = UDim2.new(0.5, -275, 0.5, -235)
    bigFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    bigFrame.BorderSizePixel = 0
    bigFrame.Active = true
    bigFrame.Draggable = true
    Instance.new("UICorner", bigFrame).CornerRadius = UDim.new(0, 15)

    local topBar = Instance.new("Frame", bigFrame)
    topBar.Size = UDim2.new(1, 0, 0, 40)
    topBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
    topBar.BorderSizePixel = 0
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 15)

    local logTitle = Instance.new("TextLabel", topBar)
    logTitle.Size = UDim2.new(1, -90, 1, 0)
    logTitle.Position = UDim2.new(0, 10, 0, 0)
    logTitle.BackgroundTransparency = 1
    logTitle.Text = "Freeman's Audio Logging (BETA)"
    logTitle.TextColor3 = Color3.fromRGB(255,255,255)
    logTitle.Font = Enum.Font.FredokaOne
    logTitle.TextSize = 20
    logTitle.TextXAlignment = Enum.TextXAlignment.Left

    local clearBtn = Instance.new("TextButton", topBar)
    clearBtn.Size = UDim2.new(0, 65, 1, -8)
    clearBtn.Position = UDim2.new(1, -110, 0, 4)
    clearBtn.Text = "CLEAR ALL"
    clearBtn.Font = Enum.Font.GothamBold
    clearBtn.TextColor3 = Color3.fromRGB(255,255,255)
    clearBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    clearBtn.TextSize = 13
    Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 8)

    local logClose = Instance.new("TextButton", topBar)
    logClose.Size = UDim2.new(0, 40, 1, 0)
    logClose.Position = UDim2.new(1, -45, 0, 0)
    logClose.Text = "X"
    logClose.Font = Enum.Font.GothamBold
    logClose.TextSize = 18
    logClose.TextColor3 = Color3.fromRGB(255,255,255)
    logClose.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", logClose).CornerRadius = UDim.new(0, 13)
    logClose.MouseButton1Click:Connect(function()
        destroyAllNotificationBlocks()
        logGui:Destroy()
        _G.FreemanAudioLogUI = nil
    end)

    local autoScanBtn = Instance.new("TextButton", bigFrame)
    autoScanBtn.Size = UDim2.new(0, 220, 0, 38)
    autoScanBtn.Position = UDim2.new(0, 35, 0, 60)
    autoScanBtn.Text = "AUTO SCAN"
    autoScanBtn.Font = Enum.Font.GothamBold
    autoScanBtn.TextSize = 16
    autoScanBtn.TextColor3 = Color3.fromRGB(255,255,255)
    autoScanBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", autoScanBtn).CornerRadius = UDim.new(0,10)

    local completeScanBtn = Instance.new("TextButton", bigFrame)
    completeScanBtn.Size = UDim2.new(0, 220, 0, 38)
    completeScanBtn.Position = UDim2.new(0, 295, 0, 60)
    completeScanBtn.Text = "COMPLETE SCAN"
    completeScanBtn.Font = Enum.Font.GothamBold
    completeScanBtn.TextSize = 16
    completeScanBtn.TextColor3 = Color3.fromRGB(255,255,255)
    completeScanBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", completeScanBtn).CornerRadius = UDim.new(0,10)

    local audioListFrame = Instance.new("Frame", bigFrame)
    audioListFrame.Position = UDim2.new(0, 25, 0, 120)
    audioListFrame.Size = UDim2.new(1, -50, 1, -140)
    audioListFrame.BackgroundTransparency = 1

    local scroll = Instance.new("ScrollingFrame", audioListFrame)
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundColor3 = Color3.fromRGB(15,15,15)
    scroll.BackgroundTransparency = 0
    scroll.BorderSizePixel = 0
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.ScrollBarThickness = 6
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ZIndex = 6
    scroll.Name = "AudioLogScroll"
    Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 10)

    local uiList = Instance.new("UIListLayout", scroll)
    uiList.Padding = UDim.new(0,8)
    uiList.SortOrder = Enum.SortOrder.LayoutOrder

    local function clearList()
        for _,child in ipairs(scroll:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
    end

    clearBtn.MouseButton1Click:Connect(function()
        clearList()
    end)

    local foundAudios = {}

    local function addAudioToList(audioData)
        for _,child in ipairs(scroll:GetChildren()) do
            if child:IsA("Frame") and child.Name == tostring(audioData.id) then return end
        end
        local item = Instance.new("Frame")
        item.Size = UDim2.new(1, -8, 0, 42)
        item.BackgroundColor3 = Color3.fromRGB(24,24,24)
        item.Name = tostring(audioData.id)
        item.Parent = scroll
        Instance.new("UICorner", item).CornerRadius = UDim.new(0,10)

        local audioNameLabel = Instance.new("TextButton", item)
        audioNameLabel.Size = UDim2.new(0.7, -10, 1, 0)
        audioNameLabel.Position = UDim2.new(0,10,0,0)
        audioNameLabel.BackgroundTransparency = 1
        audioNameLabel.Text = (audioData.name or "Unknown") .. " ["..tostring(audioData.id).."]"
        audioNameLabel.TextColor3 = Color3.fromRGB(255,255,255)
        audioNameLabel.TextXAlignment = Enum.TextXAlignment.Left
        audioNameLabel.TextSize = 13
        audioNameLabel.Font = Enum.Font.Gotham

        local copyBtn = Instance.new("TextButton", item)
        copyBtn.Size = UDim2.new(0.25, -8, 1, -8)
        copyBtn.Position = UDim2.new(0.75, 4, 0, 4)
        copyBtn.Text = "COPY"
        copyBtn.Font = Enum.Font.GothamBold
        copyBtn.TextSize = 12
        copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
        copyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0,7)

        copyBtn.MouseButton1Click:Connect(function()
            setclipboard(tostring(audioData.id))
            showAchievementBar("Audio ID copied!", 1.5)
        end)

        audioNameLabel.MouseButton1Click:Connect(function()
            createAudioLoggerPlayer(audioListFrame, audioData, function()
                for _,v in ipairs(audioListFrame:GetChildren()) do if v:IsA("Frame") then v.Visible = true end end
            end)
        end)
    end

    local function getAudioName(sound)
        if sound.Name and #sound.Name > 0 then return sound.Name end
        if sound.SoundId and sound.SoundId:match("%d+") then return "Audio "..sound.SoundId:match("%d+") end
        return "Unknown"
    end

    local function getAudioCreatorSafe(sound)
        local success, creator = pcall(function() return sound.CreatorId and game:GetService("Players"):GetNameFromUserIdAsync(sound.CreatorId) end)
        return (success and creator) or "Unknown"
    end

    local function scanAllAudios()
        clearList()
        foundAudios = {}
        local found = {}
        for _,s in ipairs(workspace:GetDescendants()) do
            if s:IsDescendantOf(player.Character) then continue end
            if s:IsA("Sound") and s.SoundId and s.SoundId:match("%d+") then
                local id = s.SoundId:match("%d+")
                if not found[id] then
                    found[id] = true
                    local creator = getAudioCreatorSafe(s)
                    local audioData = {id=id, name=getAudioName(s), creator=creator}
                    addAudioToList(audioData)
                    foundAudios[id] = audioData
                end
            end
        end
        for _,s in ipairs(game:GetService("SoundService"):GetDescendants()) do
            if s:IsDescendantOf(player.Character) then continue end
            if s:IsA("Sound") and s.SoundId and s.SoundId:match("%d+") then
                local id = s.SoundId:match("%d+")
                if not found[id] then
                    found[id] = true
                    local creator = getAudioCreatorSafe(s)
                    local audioData = {id=id, name=getAudioName(s), creator=creator}
                    addAudioToList(audioData)
                    foundAudios[id] = audioData
                end
            end
        end
        showAchievementBar("Complete scan finished!", 2)
    end

    local scanning = false
    local newConn1, newConn2
    local foundDuringScan = {}

    local function autoScan()
        clearList()
        foundDuringScan = {}
        for _,s in ipairs(workspace:GetDescendants()) do
            if s:IsDescendantOf(player.Character) then continue end
            if s:IsA("Sound") and s.SoundId and s.SoundId:match("%d+") then
                local id = s.SoundId:match("%d+")
                foundDuringScan[id] = true
                local creator = getAudioCreatorSafe(s)
                local audioData = {id=id, name=getAudioName(s), creator=creator}
                addAudioToList(audioData)
            end
        end
        for _,s in ipairs(game:GetService("SoundService"):GetDescendants()) do
            if s:IsDescendantOf(player.Character) then continue end
            if s:IsA("Sound") and s.SoundId and s.SoundId:match("%d+") then
                local id = s.SoundId:match("%d+")
                foundDuringScan[id] = true
                local creator = getAudioCreatorSafe(s)
                local audioData = {id=id, name=getAudioName(s), creator=creator}
                addAudioToList(audioData)
            end
        end
        scanning = true
        showAchievementBar("Auto Scan activated!", 2)
        newConn1 = workspace.DescendantAdded:Connect(function(obj)
            if obj:IsA("Sound") and obj.SoundId and obj.SoundId:match("%d+") then
                local id = obj.SoundId:match("%d+")
                if not foundDuringScan[id] then
                    foundDuringScan[id] = true
                    local creator = getAudioCreatorSafe(obj)
                    local audioData = {id=id, name=getAudioName(obj), creator=creator}
                    addAudioToList(audioData)
                    showAchievementBar("New audio detected!", 1)
                end
            end
        end)
        newConn2 = game:GetService("SoundService").DescendantAdded:Connect(function(obj)
            if obj:IsA("Sound") and obj.SoundId and obj.SoundId:match("%d+") then
                local id = obj.SoundId:match("%d+")
                if not foundDuringScan[id] then
                    foundDuringScan[id] = true
                    local creator = getAudioCreatorSafe(obj)
                    local audioData = {id=id, name=getAudioName(obj), creator=creator}
                    addAudioToList(audioData)
                    showAchievementBar("New audio detected!", 1)
                end
            end
        end)
    end

    local function stopAutoScan()
        scanning = false
        if newConn1 then newConn1:Disconnect() newConn1 = nil end
        if newConn2 then newConn2:Disconnect() newConn2 = nil end
        showAchievementBar("Auto Scan stopped!", 2)
    end

    autoScanBtn.MouseButton1Click:Connect(function()
        if scanning then
            stopAutoScan()
            return
        end
        createNotification("AUTO SCAN: This button will start scanning all new audios that will appear on the server. Are you sure you want to activate it?", function()
            autoScan()
        end)
    end)
    completeScanBtn.MouseButton1Click:Connect(function()
        if scanning then stopAutoScan() end
        createNotification("COMPLETE SCAN: This button will scan all audios currently in the server (not just new ones). Are you sure you want to activate it?", function()
            scanAllAudios()
        end)
    end)
end

audioLogButton.MouseButton1Click:Connect(function()
    createAudioLogUI()
end)

playButton.MouseButton1Click:Connect(function()
    local input = inputBox.Text:gsub("rbxassetid://", "")
    local id = tonumber(input)
    if id then
        local soundPreview = Instance.new("Sound")
        soundPreview.SoundId = "rbxassetid://" .. id
        soundPreview.Parent = soundFolder
        soundPreview.Volume = 0
        soundPreview:Play()
        local nameGot = "Audio " .. id
        soundPreview:GetPropertyChangedSignal("IsLoaded"):Wait()
        if soundPreview.Name and #soundPreview.Name > 0 then nameGot = soundPreview.Name end
        soundPreview:Destroy()
        createNotification(nameGot.."\nIs this the correct audio?", function()
            if isClientAudio then
                playClientAudio(id)
            else
                if player.Character and player.Character:FindFirstChild("Radio") and player.Character.Radio:FindFirstChild("Remote") then
                    local args = { [1] = "PlaySong", [2] = id }
                    pcall(function()
                        player.Character.Radio.Remote:FireServer(unpack(args))
                    end)
                else
                    warn("Radio or Remote not found!")
                end
            end
        end, function()
            warn("User cancelled playback.")
        end)
    else
        warn("INVALID ID")
    end
end)