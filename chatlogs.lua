local HUB_NAME = "Freeman's HUB - Chat Logs"
local player = game:GetService("Players").LocalPlayer
local tweenService = game:GetService("TweenService")
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "FreemanChatLogsUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 430, 0, 480)
frame.Position = UDim2.new(1, -445, 0.5, -240)
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
title.Size = UDim2.new(1, -180, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = HUB_NAME
title.TextColor3 = Color3.fromRGB(0, 255, 127)
title.Font = Enum.Font.FredokaOne
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

local btnSpacing = 8

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

local minimize = Instance.new("TextButton", header)
minimize.Size = UDim2.new(0, 35, 1, 0)
minimize.Position = UDim2.new(1, -35 - btnSpacing - 35, 0, 0)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimize.BorderSizePixel = 0
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 12)

local clearBtn = Instance.new("TextButton", header)
clearBtn.Size = UDim2.new(0, 60, 1, 0)
clearBtn.Position = UDim2.new(1, -35 - btnSpacing - 35 - btnSpacing - 60, 0, 0)
clearBtn.Text = "CLEAR"
clearBtn.Font = Enum.Font.GothamBold
clearBtn.TextSize = 14
clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
clearBtn.BorderSizePixel = 0
Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 12)

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
mainFrame.Size = UDim2.new(1, 0, 1, -35)
mainFrame.BackgroundTransparency = 1

local gameTitle = Instance.new("TextLabel", mainFrame)
gameTitle.Size = UDim2.new(1, 0, 0, 30)
gameTitle.Position = UDim2.new(0, 0, 0, 0)
gameTitle.BackgroundTransparency = 1
gameTitle.TextColor3 = Color3.fromRGB(255,255,255)
gameTitle.Font = Enum.Font.FredokaOne
gameTitle.TextSize = 16
gameTitle.Text = ""

local function updateGameTitle()
    local gameName = "Game"
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Game"
    end)
    while true do
        local dt = os.date("*t")
        local dateStr = string.format("%02d/%02d/%04d - %02d:%02d:%02d", dt.month, dt.day, dt.year, dt.hour, dt.min, dt.sec)
        gameTitle.Text = string.format("%s - %s", gameName, dateStr)
        wait(1)
    end
end
spawn(updateGameTitle)

local chatLogBox = Instance.new("ScrollingFrame", mainFrame)
chatLogBox.Size = UDim2.new(1, -18, 1, -48)
chatLogBox.Position = UDim2.new(0, 9, 0, 38)
chatLogBox.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
chatLogBox.BorderSizePixel = 0
chatLogBox.CanvasSize = UDim2.new(0,0,0,0)
chatLogBox.AutomaticCanvasSize = Enum.AutomaticSize.Y
chatLogBox.ScrollBarThickness = 8
Instance.new("UICorner", chatLogBox).CornerRadius = UDim.new(0, 10)
local uiList = Instance.new("UIListLayout", chatLogBox)
uiList.Padding = UDim.new(0, 4)
uiList.SortOrder = Enum.SortOrder.LayoutOrder

local lastMessagePerUser = {}

local function isFriend(userId)
    local success, res = pcall(function()
        return player:IsFriendsWith(userId)
    end)
    return success and res
end

local function addLog(username, message, color)
    if lastMessagePerUser[username] == message then return end
    lastMessagePerUser[username] = message
    local item = Instance.new("TextLabel")
    item.Size = UDim2.new(1, -8, 0, 22)
    item.BackgroundTransparency = 1
    item.Text = username..": "..message
    item.Font = Enum.Font.GothamBold
    item.TextSize = 15
    item.TextColor3 = color
    item.TextXAlignment = Enum.TextXAlignment.Left
    item.Parent = chatLogBox
    chatLogBox.CanvasPosition = Vector2.new(0, chatLogBox.AbsoluteCanvasSize.Y+100)
end

local function cleanMessage(msg)
    return string.gsub(msg, "[\n\r]", "")
end

local function pruneLog()
    local labels = {}
    for _,v in ipairs(chatLogBox:GetChildren()) do
        if v:IsA("TextLabel") then table.insert(labels, v) end
    end
    if #labels > 1050 then
        for i=1,50 do
            if labels[i] then labels[i]:Destroy() end
        end
    end
end

clearBtn.MouseButton1Click:Connect(function()
    for _,v in ipairs(chatLogBox:GetChildren()) do
        if v:IsA("TextLabel") then
            v:Destroy()
        end
    end
    lastMessagePerUser = {}
end)

for _,plr in ipairs(game.Players:GetPlayers()) do
    plr.Chatted:Connect(function(text, recipient)
        local username = plr.Name
        local color = Color3.fromRGB(255,255,255)
        if recipient then
            color = Color3.fromRGB(255,255,0)
        elseif isFriend(plr.UserId) then
            color = Color3.fromRGB(0,255,0)
        end
        local msg = cleanMessage(text)
        addLog(username, msg, color)
        pruneLog()
    end)
end
game.Players.PlayerAdded:Connect(function(plr)
    plr.Chatted:Connect(function(text, recipient)
        local username = plr.Name
        local color = Color3.fromRGB(255,255,255)
        if recipient then
            color = Color3.fromRGB(255,255,0)
        elseif isFriend(plr.UserId) then
            color = Color3.fromRGB(0,255,0)
        end
        local msg = cleanMessage(text)
        addLog(username, msg, color)
        pruneLog()
    end)
end)

minimize.MouseButton1Click:Connect(function()
    local tween = tweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = UDim2.new(1, -445, 0.5, -330)})
    tween:Play()
    tween.Completed:Wait()
    frame.Visible = false
    openIcon.Visible = true
end)
openIcon.MouseButton1Click:Connect(function()
    frame.Visible = true
    openIcon.Visible = false
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(1, -445, 0.5, -330)
    local tween = tweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(1, -445, 0.5, -240)})
    tween:Play()
end)
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)