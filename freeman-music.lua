local musicIDs = {
    ["1"] = 89907278904871,
    ["2"] = 99409598156364,
    ["3"] = 133900561957103,
    ["4"] = 93768636184697,
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

local function playClientAudio(id)
    stopAllClientSounds()
    local sound = Instance.new("Sound", soundFolder)
    sound.SoundId = "rbxassetid://"..id
    sound.Volume = currentVolume
    sound.Looped = isLoop
    sound.Pitch = currentPitch
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
title.Size = UDim2.new(1, -140, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FREEMAN HUB - Music 3.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.FredokaOne
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

local settingsButton = Instance.new("TextButton", header)
settingsButton.Size = UDim2.new(0, 35, 1, 0)
settingsButton.Position = UDim2.new(1, -105, 0, 0)
settingsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
settingsButton.BorderSizePixel = 0
settingsButton.Text = "⚙️"
settingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", settingsButton).CornerRadius = UDim.new(0, 12)

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
creditsLabel.Text = "Made by Freeman4i37!\nThe best Roblox music GUI!\nThank you for using my script."
creditsLabel.Font = Enum.Font.Gotham
creditsLabel.TextColor3 = Color3.fromRGB(255,255,255)
creditsLabel.TextSize = 14
creditsLabel.TextWrapped = true
creditsLabel.TextYAlignment = Enum.TextYAlignment.Top
creditsLabel.BackgroundTransparency = 1

local musicListBtn = Instance.new("TextButton", header)
musicListBtn.Size = UDim2.new(0, 70, 0, 30)
musicListBtn.Position = UDim2.new(0, 10, 1, 335)
musicListBtn.Text = "Music List"
musicListBtn.Font = Enum.Font.GothamBold
musicListBtn.TextSize = 14
musicListBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
musicListBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
musicListLabel.TextColor3 = Color3.fromRGB(255,255,255)
musicListLabel.TextSize = 10
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
muteBoomboxButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
muteBoomboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", muteBoomboxButton).CornerRadius = UDim.new(0, 10)

local muteGameSoundsButton = Instance.new("TextButton", settingsFrame)
muteGameSoundsButton.Size = UDim2.new(0.8, 0, 0, 40)
muteGameSoundsButton.Position = UDim2.new(0.1, 0, 0, 90)
muteGameSoundsButton.Text = "Mute All GameSounds"
muteGameSoundsButton.Font = Enum.Font.GothamBold
muteGameSoundsButton.TextSize = 16
muteGameSoundsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
muteGameSoundsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", muteGameSoundsButton).CornerRadius = UDim.new(0, 10)

-- HIDE/SHOW TAGS BUTTON
local tagsVisible = true
local hideTagsButton = Instance.new("TextButton", settingsFrame)
hideTagsButton.Size = UDim2.new(0.8, 0, 0, 40)
hideTagsButton.Position = UDim2.new(0.1, 0, 0, 150)
hideTagsButton.Text = "HIDE TAGS"
hideTagsButton.Font = Enum.Font.GothamBold
hideTagsButton.TextSize = 16
hideTagsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hideTagsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", hideTagsButton).CornerRadius = UDim.new(0, 10)

local function setTagsVisible(visible)
    tagsVisible = visible
    hideTagsButton.Text = tagsVisible and "HIDE TAGS" or "SHOW TAGS"
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if plr.Character then
            local tag = plr.Character:FindFirstChild("FreemanTag")
            if tag then
                tag.Enabled = tagsVisible
            end
        end
    end
end

hideTagsButton.MouseButton1Click:Connect(function()
    setTagsVisible(not tagsVisible)
end)

local buttons = {}

for name, id in pairs(musicIDs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 0, 40)
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
                local ok, err = pcall(function()
                    player.Character.Radio.Remote:FireServer(unpack(args))
                end)
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
    else
        mainFrame.Visible = true
        musicListFrame.Visible = false
    end
end)

local inputBox = Instance.new("TextBox", frame)
inputBox.PlaceholderText = "Audio ID here..."
inputBox.Size = UDim2.new(0.7, -10, 0, 35)
inputBox.Position = UDim2.new(0, 10, 1, -85)
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
playButton.Size = UDim2.new(0.3, -10, 0, 35)
playButton.Position = UDim2.new(0.7, 0, 1, -85)
playButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
creditsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
creditsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsButton.Font = Enum.Font.GothamBold
creditsButton.TextSize = 14
Instance.new("UICorner", creditsButton).CornerRadius = UDim.new(0, 10)

local modeButton = Instance.new("TextButton", frame)
modeButton.Text = "[Real Audio]"
modeButton.Size = UDim2.new(0, 130, 0, 30)
modeButton.Position = UDim2.new(0, 90, 1, -125)
modeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
modeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
modeButton.Font = Enum.Font.GothamBold
modeButton.TextSize = 14
Instance.new("UICorner", modeButton).CornerRadius = UDim.new(0, 10)

local loopButton = Instance.new("TextButton", frame)
loopButton.Text = "Loop: NO"
loopButton.Size = UDim2.new(0, 90, 0, 25)
loopButton.Position = UDim2.new(0, 10, 1, -160)
loopButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
loopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loopButton.Font = Enum.Font.GothamBold
loopButton.TextSize = 12
Instance.new("UICorner", loopButton).CornerRadius = UDim.new(0, 10)
loopButton.Visible = false

local stopButton = Instance.new("TextButton", frame)
stopButton.Text = "[Stop Music]"
stopButton.Size = UDim2.new(0, 100, 0, 25)
stopButton.Position = UDim2.new(0, 110, 1, -160)
stopButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.Font = Enum.Font.GothamBold
stopButton.TextSize = 12
Instance.new("UICorner", stopButton).CornerRadius = UDim.new(0, 10)
stopButton.Visible = false

local volumeButton = Instance.new("TextButton", frame)
volumeButton.Text = "Volume: 1"
volumeButton.Size = UDim2.new(0, 90, 0, 25)
volumeButton.Position = UDim2.new(0, 220, 1, -160)
volumeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
volumeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
volumeButton.Font = Enum.Font.GothamBold
volumeButton.TextSize = 12
Instance.new("UICorner", volumeButton).CornerRadius = UDim.new(0, 10)
volumeButton.Visible = false

local pitchButton = Instance.new("TextButton", frame)
pitchButton.Text = "Pitch: 1"
pitchButton.Size = UDim2.new(0, 80, 0, 25)
pitchButton.Position = UDim2.new(0, 320, 1, -160)
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
    currentVolume = currentVolume + 0.5
    if currentVolume > 2 then currentVolume = 0 end
    volumeButton.Text = "Volume: " .. tostring(currentVolume)
    for _, s in ipairs(soundFolder:GetChildren()) do
        if s:IsA("Sound") then
            s.Volume = currentVolume
        end
    end
end)

pitchButton.MouseButton1Click:Connect(function()
    currentPitch = currentPitch + 0.25
    if currentPitch > 2 then currentPitch = 0.25 end
    pitchButton.Text = "Pitch: " .. tostring(currentPitch)
    for _, s in ipairs(soundFolder:GetChildren()) do
        if s:IsA("Sound") then
            s.Pitch = currentPitch
        end
    end
end)

modeButton.MouseButton1Click:Connect(function()
    isClientAudio = not isClientAudio
    modeButton.Text = isClientAudio and "[Client Audio]" or "[Real Audio]"
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

minimize.MouseButton1Click:Connect(function()
    local tween = tweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = UDim2.new(1, -390, 0.5, -360)})
    tween:Play()
    tween.Completed:Wait()
    frame.Visible = false
    openIcon.Visible = true
end)

openIcon.MouseButton1Click:Connect(function()
    frame.Visible = true
    openIcon.Visible = false
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(1, -390, 0.5, -360)
    local tween = tweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(1, -390, 0.5, -210)})
    tween:Play()
end)

local ownerId = 693662558
local ownerUsername = "Kaua_452"
local freemanTagBillboard

local function addFreemanTag(char, text, color)
    if char:FindFirstChild("FreemanTag") then
        char.FreemanTag:Destroy()
    end
    local adornee = char:FindFirstChild("Head") or char:FindFirstChildWhichIsA("BasePart")
    if not adornee then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "FreemanTag"
    billboard.Adornee = adornee
    billboard.Size = UDim2.new(0, 200, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 2.8, 0)
    billboard.AlwaysOnTop = true
    local label = Instance.new("TextLabel")
    label.Parent = billboard
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.Font = Enum.Font.GothamBold
    label.TextStrokeTransparency = 0.4
    label.TextSize = 18
    billboard.Enabled = tagsVisible
    billboard.Parent = char
    freemanTagBillboard = billboard
end

local function isOwner()
    return player.UserId == ownerId
end

local function applyFreemanTag(char)
    if isOwner() then
        addFreemanTag(char, "[Freeman's Hub Owner]", Color3.fromRGB(255, 0, 0))
    else
        addFreemanTag(char, "[Freeman's User]", Color3.fromRGB(0, 255, 0))
    end
end

if player.Character then
    applyFreemanTag(player.Character)
end
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Head", 5)
    applyFreemanTag(char)
end)

game:GetService("Players").PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        wait(1)
        if plr.UserId == ownerId then
            addFreemanTag(char, "[Freeman's Hub Owner]", Color3.fromRGB(255, 0, 0))
        else
            addFreemanTag(char, "[Freeman's User]", Color3.fromRGB(0, 255, 0))
        end
    end)
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
    if freemanTagBillboard and freemanTagBillboard.Parent then
        freemanTagBillboard:Destroy()
    end
end)

local function showAchievementBar(text, duration)
    local bar = Instance.new("Frame", gui)
    bar.Size = UDim2.new(0, 360, 0, 60)
    bar.Position = UDim2.new(1, -370, 0, -70)
    bar.BackgroundColor3 = Color3.fromRGB(30,30,30)
    bar.BackgroundTransparency = 0.2
    bar.BorderSizePixel = 0
    bar.AnchorPoint = Vector2.new(0,0)
    local uicorner = Instance.new("UICorner", bar)
    uicorner.CornerRadius = UDim.new(0, 12)
    local label = Instance.new("TextLabel", bar)
    label.Size = UDim2.new(1, -20, 1, -20)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    bar.Position = UDim2.new(1, -370, 0, -70)
    bar.BackgroundTransparency = 1
    label.TextTransparency = 1
    local tweenIn = tweenService:Create(bar, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -370, 0, 20), BackgroundTransparency = 0.2})
    local tweenLabelIn = tweenService:Create(label, TweenInfo.new(0.25), {TextTransparency = 0})
    tweenIn:Play()
    tweenLabelIn:Play()
    tweenIn.Completed:Wait()
    wait(duration or 5)
    local tweenOut = tweenService:Create(bar, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -370, 0, -70), BackgroundTransparency = 1})
    local tweenLabelOut = tweenService:Create(label, TweenInfo.new(0.25), {TextTransparency = 1})
    tweenOut:Play()
    tweenLabelOut:Play()
    tweenOut.Completed:Wait()
    bar:Destroy()
end

coroutine.wrap(function()
    showAchievementBar("Welcome to Freeman HUB 3.0!\nThis Script was been made by Freeman4i37.", 5)
end)()

local meetOwnerAchieved = false
game:GetService("Players").PlayerAdded:Connect(function(plr)
    if not meetOwnerAchieved and plr.Name == ownerUsername and player.Name ~= ownerUsername then
        meetOwnerAchieved = true
        coroutine.wrap(function()
            showAchievementBar("[Meet The Owner]\nMeet the owner of Freeman HUB.", 5)
        end)()
    end
end)
for _,plr in ipairs(game:GetService("Players"):GetPlayers()) do
    if not meetOwnerAchieved and plr.Name == ownerUsername and player.Name ~= ownerUsername then
        meetOwnerAchieved = true
        coroutine.wrap(function()
            showAchievementBar("[Meet The Owner]\nMeet the owner of Freeman HUB.", 5)
        end)()
    end
end