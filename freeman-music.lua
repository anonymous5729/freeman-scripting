local musicIDs = {
    ["1"] = 89907278904871,
    ["2"] = 99409598156364,
    ["3"] = 133900561957103,
    ["4"] = 93768636184697,
}

local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "FreemanMusicUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local musicListBtnClicked = false
local isClientAudio = false
local isLoop = false
local currentVolume = 1

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

local function playClientAudio(id)
    stopAllClientSounds()
    local sound = Instance.new("Sound", soundFolder)
    sound.SoundId = "rbxassetid://"..id
    sound.Volume = currentVolume
    sound.Looped = isLoop
    sound.Playing = true
    sound.Name = tostring(id)
    if not isLoop then
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
end

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 380, 0, 420)
frame.Position = UDim2.new(1, -390, 0.5, -210)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -140, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FREEMAN HUB - Music"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.FredokaOne
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

local settingsButton = Instance.new("TextButton", header)
settingsButton.Size = UDim2.new(0, 35, 1, 0)
settingsButton.Position = UDim2.new(1, -105, 0, 0)
settingsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
settingsButton.BorderSizePixel = 0
settingsButton.Text = "⚙️"
Instance.new("UICorner", settingsButton).CornerRadius = UDim.new(0, 12)

local minimize = Instance.new("TextButton", header)
minimize.Size = UDim2.new(0, 35, 1, 0)
minimize.Position = UDim2.new(1, -70, 0, 0)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
minimize.BorderSizePixel = 0
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 12)

local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0, 35, 1, 0)
close.Position = UDim2.new(1, -35, 0, 0)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundColor3 = Color3.fromRGB(60, 50, 50)
close.BorderSizePixel = 0
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 12)

local openIcon = Instance.new("TextButton", gui)
openIcon.Size = UDim2.new(0, 40, 0, 40)
openIcon.Position = UDim2.new(1, -50, 1, -50)
openIcon.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
openIcon.Text = "+"
openIcon.Visible = false
openIcon.TextSize = 24
openIcon.Font = Enum.Font.GothamBold
openIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

local mainFrame = Instance.new("Frame", frame)
mainFrame.Position = UDim2.new(0, 0, 0, 35)
mainFrame.Size = UDim2.new(1, 0, 1, -130)
mainFrame.BackgroundTransparency = 1

local grid = Instance.new("UIGridLayout", mainFrame)
grid.CellSize = UDim2.new(0, 90, 0, 40)
grid.CellPadding = UDim2.new(0, 10, 0, 10)
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.VerticalAlignment = Enum.VerticalAlignment.Top
grid.FillDirectionMaxCells = 3

local creditsFrame = Instance.new("Frame", frame)
creditsFrame.Position = UDim2.new(0, 0, 0, 35)
creditsFrame.Size = UDim2.new(1, 0, 1, -130)
creditsFrame.BackgroundTransparency = 1
creditsFrame.Visible = false

local creditsLabel = Instance.new("TextLabel", creditsFrame)
creditsLabel.Size = UDim2.new(1, -20, 1, -20)
creditsLabel.Position = UDim2.new(0, 10, 0, 10)
creditsLabel.Text = "CREDITS\nMade by Freeman4i37.\nA simple guide of some songs chosen by the owner himself.\nIf you want me to add buttons with your songs, tell me on my discord (go to scriptblox).\nYou can put yours in the box below and play!"
creditsLabel.Font = Enum.Font.Gotham
creditsLabel.TextColor3 = Color3.new(1,1,1)
creditsLabel.TextSize = 14
creditsLabel.TextWrapped = true
creditsLabel.TextYAlignment = Enum.TextYAlignment.Top
creditsLabel.BackgroundTransparency = 1

local function rainbowColor(offset)
    local hue = tick() * 0.2 + offset
    return Color3.fromHSV(hue % 1, 1, 1)
end

local musicListBtn = Instance.new("TextButton", header)
musicListBtn.Size = UDim2.new(0, 70, 0, 30)
musicListBtn.Position = UDim2.new(0, 10, 1, 335)
musicListBtn.Text = "Music List"
musicListBtn.Font = Enum.Font.GothamBold
musicListBtn.TextSize = 14
musicListBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
musicListBtn.BackgroundColor3 = Color3.fromRGB(60, 70, 150)
musicListBtn.BorderSizePixel = 0
Instance.new("UICorner", musicListBtn).CornerRadius = UDim.new(0, 12)

local musicListFrame = Instance.new("Frame", frame)
musicListFrame.Position = UDim2.new(0, 0, 0, 35)
musicListFrame.Size = UDim2.new(1, 0, 1, -130)
musicListFrame.BackgroundTransparency = 1
musicListFrame.Visible = false

local musicListLabel = Instance.new("TextLabel", musicListFrame)
musicListLabel.Size = UDim2.new(1, -20, 1, -20)
musicListLabel.Position = UDim2.new(0, 10, 0, 10)
musicListLabel.Text = [[
[1] - Funk da Praia, added by Freeman
[3] - Trash Funk, added by Freeman
[2] - Retrolam Funk, added by Freeman
[4] - 2609 (Jersey Club), added by Freeman
]]
musicListLabel.Font = Enum.Font.Gotham
musicListLabel.TextColor3 = Color3.new(1,1,1)
musicListLabel.TextSize = 8
musicListLabel.TextWrapped = true
musicListLabel.TextYAlignment = Enum.TextYAlignment.Top
musicListLabel.BackgroundTransparency = 1

local settingsFrame = Instance.new("Frame", frame)
settingsFrame.Position = UDim2.new(0, 0, 0, 35)
settingsFrame.Size = UDim2.new(1, 0, 1, -130)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Visible = false

local muteBoomboxButton = Instance.new("TextButton", settingsFrame)
muteBoomboxButton.Size = UDim2.new(0.8, 0, 0, 40)
muteBoomboxButton.Position = UDim2.new(0.1, 0, 0, 30)
muteBoomboxButton.Text = "Mute All Boomboxes"
muteBoomboxButton.Font = Enum.Font.GothamBold
muteBoomboxButton.TextSize = 16
muteBoomboxButton.BackgroundColor3 = Color3.fromRGB(120, 80, 80)
muteBoomboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", muteBoomboxButton).CornerRadius = UDim.new(0, 10)

local muteGameSoundsButton = Instance.new("TextButton", settingsFrame)
muteGameSoundsButton.Size = UDim2.new(0.8, 0, 0, 40)
muteGameSoundsButton.Position = UDim2.new(0.1, 0, 0, 90)
muteGameSoundsButton.Text = "Mute All GameSounds"
muteGameSoundsButton.Font = Enum.Font.GothamBold
muteGameSoundsButton.TextSize = 16
muteGameSoundsButton.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
muteGameSoundsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", muteGameSoundsButton).CornerRadius = UDim.new(0, 10)

local buttons = {}

for name, id in pairs(musicIDs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 0, 40)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(60, 70, 150)
    Instance.new("UIStroke", btn).Transparency = 0.2
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    btn.Parent = mainFrame

    btn.MouseButton1Click:Connect(function()
        if isClientAudio then
            playClientAudio(id)
        else
            if player.Character and player.Character:FindFirstChild("Radio") and player.Character.Radio:FindFirstChild("Remote") then
                local args = { [1] = "PlaySong", [2] = id }
                local ok, err = pcall(function()
                    player.Character.Radio.Remote:FireServer(unpack(args))
                end)
                if not ok then warn("Failed to play the song:", err) end
            else
                warn("Radio ou Remote não encontrados!")
            end
        end
    end)

    table.insert(buttons, btn)
end

musicListBtn.MouseButton1Click:Connect(function()
    musicListBtnClicked = not musicListBtnClicked
    if musicListBtnClicked then
        mainFrame.Visible = false
        musicListFrame.Visible = true
        creditsFrame.Visible = false
        settingsFrame.Visible = false
        creditsButtonClicked = false
    else
        mainFrame.Visible = true
        musicListFrame.Visible = false
    end
end)

local inputBox = Instance.new("TextBox", frame)
inputBox.PlaceholderText = "Audio ID here..."
inputBox.Size = UDim2.new(0.7, -10, 0, 35)
inputBox.Position = UDim2.new(0, 10, 1, -85)
inputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 16
inputBox.Text = ""
inputBox.ClearTextOnFocus = false
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 10)

local playButton = Instance.new("TextButton", frame)
playButton.Text = "PLAY"
playButton.Size = UDim2.new(0.3, -10, 0, 35)
playButton.Position = UDim2.new(0.7, 0, 1, -85)
playButton.BackgroundColor3 = Color3.fromRGB(70, 80, 160)
playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
playButton.Font = Enum.Font.GothamBold
playButton.TextSize = 20
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
                local ok, err = pcall(function()
                    player.Character.Radio.Remote:FireServer(unpack(args))
                end)
                if not ok then warn("Error playing manual audio:", err) end
            else
                warn("Radio ou Remote não encontrados!")
            end
        end
    else
        warn("INVALID ID")
    end
end)

local creditsButton = Instance.new("TextButton", frame)
creditsButton.Text = "Credits"
creditsButton.Size = UDim2.new(0, 70, 0, 30)
creditsButton.Position = UDim2.new(0, 10, 1, -125)
creditsButton.BackgroundColor3 = Color3.fromRGB(60, 70, 150)
creditsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsButton.Font = Enum.Font.GothamBold
creditsButton.TextSize = 14
Instance.new("UICorner", creditsButton).CornerRadius = UDim.new(0, 10)

local modeButton = Instance.new("TextButton", frame)
modeButton.Text = "[Real Audio]"
modeButton.Size = UDim2.new(0, 130, 0, 30)
modeButton.Position = UDim2.new(0, 90, 1, -125)
modeButton.BackgroundColor3 = Color3.fromRGB(60, 70, 150)
modeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
modeButton.Font = Enum.Font.GothamBold
modeButton.TextSize = 14
Instance.new("UICorner", modeButton).CornerRadius = UDim.new(0, 10)

local loopButton = Instance.new("TextButton", frame)
loopButton.Text = "Loop: NO"
loopButton.Size = UDim2.new(0, 90, 0, 25)
loopButton.Position = UDim2.new(0, 10, 1, -160)
loopButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
loopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loopButton.Font = Enum.Font.GothamBold
loopButton.TextSize = 12
Instance.new("UICorner", loopButton).CornerRadius = UDim.new(0, 10)
loopButton.Visible = false

local stopButton = Instance.new("TextButton", frame)
stopButton.Text = "[Stop Music]"
stopButton.Size = UDim2.new(0, 100, 0, 25)
stopButton.Position = UDim2.new(0, 110, 1, -160)
stopButton.BackgroundColor3 = Color3.fromRGB(120, 60, 60)
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.Font = Enum.Font.GothamBold
stopButton.TextSize = 12
Instance.new("UICorner", stopButton).CornerRadius = UDim.new(0, 10)
stopButton.Visible = false

local volumeButton = Instance.new("TextButton", frame)
volumeButton.Text = "Volume: 1"
volumeButton.Size = UDim2.new(0, 90, 0, 25)
volumeButton.Position = UDim2.new(0, 220, 1, -160)
volumeButton.BackgroundColor3 = Color3.fromRGB(60, 80, 60)
volumeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
volumeButton.Font = Enum.Font.GothamBold
volumeButton.TextSize = 12
Instance.new("UICorner", volumeButton).CornerRadius = UDim.new(0, 10)
volumeButton.Visible = false

loopButton.MouseButton1Click:Connect(function()
    isLoop = not isLoop
    loopButton.Text = isLoop and "Loop: YES" or "Loop: NO"
end)

stopButton.MouseButton1Click:Connect(function()
    stopAllClientSounds()
end)

volumeButton.MouseButton1Click:Connect(function()
    currentVolume = currentVolume + 0.5
    if currentVolume > 2 then currentVolume = 0 end
    volumeButton.Text = "Volume: " .. tostring(currentVolume)
    for _, s in ipairs(soundFolder:GetChildren()) do
        if s:IsA("Sound") then
            s.Volume = currentVolume
        end
    end
end)

modeButton.MouseButton1Click:Connect(function()
    isClientAudio = not isClientAudio
    modeButton.Text = isClientAudio and "[Client Audio]" or "[Real Audio]"
    loopButton.Visible = isClientAudio
    stopButton.Visible = isClientAudio
    volumeButton.Visible = isClientAudio
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
    if sound:IsDescendantOf(soundFolder) then
        return true
    end
    if player.Character then
        local radio = player.Character:FindFirstChild("Radio")
        if radio and sound:IsDescendantOf(radio) then
            return true
        end
    end
    return false
end

local function setGameSoundsMuted(mute)
    if mute and not muteGameSoundsConn then
        muteGameSoundsConn = runService.RenderStepped:Connect(function()
            for _, s in ipairs(workspace:GetDescendants()) do
                if s:IsA("Sound") and not isMyBoombox(s) then
                    s.Volume = 0
                end
            end
            for _, s in ipairs(game:GetService("SoundService"):GetDescendants()) do
                if s:IsA("Sound") then
                    s.Volume = 0
                end
            end
        end)
    elseif not mute and muteGameSoundsConn then
        muteGameSoundsConn:Disconnect()
        muteGameSoundsConn = nil
        for _, s in ipairs(workspace:GetDescendants()) do
            if s:IsA("Sound") and not isMyBoombox(s) then
                s.Volume = 1
            end
        end
        for _, s in ipairs(game:GetService("SoundService"):GetDescendants()) do
            if s:IsA("Sound") then
                s.Volume = 1
            end
        end
    end
    gameSoundsMuted = mute
    muteGameSoundsButton.Text = mute and "Unmute All GameSounds" or "Mute All GameSounds"
end

muteGameSoundsButton.MouseButton1Click:Connect(function()
    setGameSoundsMuted(not gameSoundsMuted)
end)

runService.RenderStepped:Connect(function()
    for i, btn in ipairs(buttons) do
        btn.BackgroundColor3 = rainbowColor(i * 0.1)
    end
    creditsButton.BackgroundColor3 = rainbowColor(0.3)
    modeButton.BackgroundColor3 = rainbowColor(0.6)
    musicListBtn.BackgroundColor3 = rainbowColor(0.5)
    settingsButton.BackgroundColor3 = rainbowColor(0.8)
end)

minimize.MouseButton1Click:Connect(function()
    frame.Visible = false
    openIcon.Visible = true
end)

openIcon.MouseButton1Click:Connect(function()
    frame.Visible = true
    openIcon.Visible = false
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
    if soundFolder then
        soundFolder:Destroy()
    end
    if muteGameSoundsConn then
        muteGameSoundsConn:Disconnect()
        muteGameSoundsConn = nil
    end
end)