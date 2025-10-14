-- Proteção reforçada: só executa se o loader correto rodou antes
local keyName = "_G.X9FJ3LK29_MMM"
if not (_G.X9FJ3LK29_MMM and _G.X9FJ3LK29_MMM == true) then
    game.Players.LocalPlayer:Kick("Nice try.")
    return
end
-- Limpa a variável para não ser reaproveitada por outro script
_G.X9FJ3LK29_MMM = nil

if game.CoreGui:FindFirstChild("MMM_UI") then game.CoreGui.MMM_UI:Destroy() end

local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local gui = Instance.new("ScreenGui")
gui.Name = "MMM_UI"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local mainColor = Color3.fromRGB(18, 18, 18)
local borderColor = Color3.fromRGB(30, 30, 30)
local accentColor = Color3.fromRGB(40, 120, 255)
local buttonColor = Color3.fromRGB(10, 10, 10)
local textColor = Color3.fromRGB(255,255,255)
local closeColor = Color3.fromRGB(180,30,30)
local minimizeColor = Color3.fromRGB(60,60,60)
local onColor = Color3.fromRGB(60,200,90)
local offColor = Color3.fromRGB(200,60,60)

getgenv().MMM_AUTOPLAY = false
getgenv().MMM_ANTILAG = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 230)
frame.Position = UDim2.new(0.13, 0, 0.21, 0)
frame.BackgroundColor3 = mainColor
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = frame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 44)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = borderColor
titleBar.BorderSizePixel = 0
titleBar.Parent = frame
local titleBarCorner = Instance.new("UICorner")
titleBarCorner.CornerRadius = UDim.new(0, 10)
titleBarCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Text = "Freeman HUB: MMM"
title.Size = UDim2.new(1, -110, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.Size = UDim2.new(0,34,0,32)
closeButton.Position = UDim2.new(1, -46, 0, 6)
closeButton.BackgroundColor3 = closeColor
closeButton.TextColor3 = textColor
closeButton.Font = Enum.Font.GothamBold
closeButton.TextScaled = true
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar
local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(0, 7)
closeButtonCorner.Parent = closeButton

local minimizeButton = Instance.new("TextButton")
minimizeButton.Text = "-"
minimizeButton.Size = UDim2.new(0,32,0,32)
minimizeButton.Position = UDim2.new(1, -86, 0, 6)
minimizeButton.BackgroundColor3 = minimizeColor
minimizeButton.TextColor3 = textColor
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextScaled = true
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = titleBar
local minimizeButtonCorner = Instance.new("UICorner")
minimizeButtonCorner.CornerRadius = UDim.new(0, 7)
minimizeButtonCorner.Parent = minimizeButton

local miniButton = Instance.new("TextButton")
miniButton.Size = UDim2.new(0, 40, 0, 40)
miniButton.Position = UDim2.new(0, 8, 0, 8)
miniButton.BackgroundColor3 = mainColor
miniButton.Text = "+"
miniButton.TextColor3 = textColor
miniButton.Font = Enum.Font.GothamBold
miniButton.TextScaled = true
miniButton.Visible = false
miniButton.BorderSizePixel = 0
miniButton.Parent = gui
local miniButtonCorner = Instance.new("UICorner")
miniButtonCorner.CornerRadius = UDim.new(0, 10)
miniButtonCorner.Parent = miniButton

local btnHolder = Instance.new("Frame")
btnHolder.Size = UDim2.new(1, -32, 0, 96)
btnHolder.Position = UDim2.new(0, 16, 0, 68)
btnHolder.BackgroundTransparency = 1
btnHolder.Parent = frame

local function makeBtn(txt, y)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.BackgroundColor3 = buttonColor
    btn.Text = txt
    btn.TextColor3 = textColor
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Parent = btnHolder
    btn.BorderSizePixel = 0
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 7)
    btnCorner.Parent = btn
    return btn
end

local autoplayBtn = makeBtn("Autoplay: Off", 0)
local antilagBtn = makeBtn("Antilag: Off", 42)

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Text = "FPS: 0"
fpsLabel.Size = UDim2.new(1, 0, 0, 30)
fpsLabel.Position = UDim2.new(0, 0, 1, -64)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = textColor
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextScaled = true
fpsLabel.Parent = frame

local credit = Instance.new("TextLabel")
credit.Text = "Freeman4i37"
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -32)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(100, 100, 100)
credit.Font = Enum.Font.Gotham
credit.TextScaled = true
credit.Parent = frame

local function updateBtnStates()
    autoplayBtn.Text = "Autoplay: " .. (getgenv().MMM_AUTOPLAY and "On" or "Off")
    autoplayBtn.BackgroundColor3 = buttonColor
    autoplayBtn.TextColor3 = textColor
    antilagBtn.Text = "Antilag: " .. (getgenv().MMM_ANTILAG and "On" or "Off")
    antilagBtn.BackgroundColor3 = buttonColor
    antilagBtn.TextColor3 = textColor
end

local autoplayThread
autoplayBtn.MouseButton1Click:Connect(function()
    getgenv().MMM_AUTOPLAY = not getgenv().MMM_AUTOPLAY
    updateBtnStates()
    if getgenv().MMM_AUTOPLAY then
        if autoplayThread and coroutine.status(autoplayThread) == "suspended" then
            coroutine.resume(autoplayThread)
            return
        end
        autoplayThread = coroutine.create(function()
            if not game:IsLoaded() then game.Loaded:Wait() end
            local VIM = game:GetService("VirtualInputManager")
            local RS = game:GetService("RunService")
            local Opts = getrenv()._G.PlayerData and getrenv()._G.PlayerData.Options or {}
            local TYP = {"Left", "Right"}
            local KeyMap = {
                [9] = {"Left", "Down", "Up", "Right", "Space", "Left2", "Down2", "Up2", "Right2"},
                [8] = {"Left", "Down", "Up", "Right", "Left2", "Down2", "Up2", "Right2"},
                [7] = {"Left", "Up", "Right", "Space", "Left2", "Down", "Right2"},
                [6] = {"Left", "Up", "Right", "Left2", "Down", "Right2"},
                [5] = {"Left", "Down", "Space", "Up", "Right"},
                [4] = {"Left", "Down", "Up", "Right"}
            }
            local function sorter(p)
                local c = p:GetChildren()
                table.sort(c, function(a, b)
                    return a.AbsolutePosition.X < b.AbsolutePosition.X
                end)
                return c
            end
            local function getMatch()
                for _,v in ipairs(getgc(true)) do
                    if type(v) == "table" and rawget(v, "MatchFolder") then
                        return v
                    end
                end
            end
            local C0nns = {}
            local lIlIlI = true
            getgenv().MMM_AUTOPLAY_STOP = function() lIlIlI = false end

            while getgenv().MMM_AUTOPLAY and lIlIlI do
                for _,v in ipairs(C0nns) do v:Disconnect() end
                table.clear(C0nns)
                local m = getMatch()
                if not m then task.wait(1) continue end
                repeat task.wait() until rawget(m, "Songs")
                local s = TYP[m.PlayerType]
                local G = m.ArrowGui[s]
                local cont = sorter(G.MainArrowContainer)
                local long = sorter(G.LongNotes)
                local notes = sorter(G.Notes)
                local max = m.MaxArrows
                local keys = KeyMap[max]
                local binds = max < 5 and Opts or (Opts.ExtraKeySettings and Opts.ExtraKeySettings[tostring(max)])
                for i,holder in ipairs(notes) do
                    local name = keys[i]
                    local keycode = binds and binds[name.."Key"]
                    local fakeNote = cont[i]
                    local longNote = long[i]
                    local dist = 10 * max
                    C0nns[#C0nns+1] = holder.ChildAdded:Connect(function(n)
                        while (fakeNote.AbsolutePosition - n.AbsolutePosition).Magnitude >= dist do
                            RS.RenderStepped:Wait()
                        end
                        if not getgenv().MMM_AUTOPLAY then return end
                        VIM:SendKeyEvent(true, keycode, false, nil)
                        if #longNote:GetChildren() == 0 then
                            VIM:SendKeyEvent(false, keycode, false, nil)
                        end
                    end)
                end
                for i,holder in ipairs(long) do
                    local name = keys[i]
                    local keycode = binds and binds[name.."Key"]
                    C0nns[#C0nns+1] = holder.ChildRemoved:Connect(function()
                        if not getgenv().MMM_AUTOPLAY then return end
                        VIM:SendKeyEvent(false, keycode, false, nil)
                    end)
                end
                m.MatchFolder.Destroying:Wait()
            end
            for _,v in ipairs(C0nns) do v:Disconnect() end
        end)
        coroutine.resume(autoplayThread)
    else
        pcall(function() if getgenv().MMM_AUTOPLAY_STOP then getgenv().MMM_AUTOPLAY_STOP() end end)
    end
end)

local antilagThread = nil
antilagBtn.MouseButton1Click:Connect(function()
    getgenv().MMM_ANTILAG = not getgenv().MMM_ANTILAG
    updateBtnStates()
    if getgenv().MMM_ANTILAG then
        if antilagThread and coroutine.status(antilagThread) == "suspended" then
            coroutine.resume(antilagThread)
            return
        end
        antilagThread = coroutine.create(function()
            while getgenv().MMM_ANTILAG do
                pcall(function() if setfpscap then setfpscap(120) end end)
                task.wait(0.001)
            end
        end)
        coroutine.resume(antilagThread)
    end
end)

do
    local last = tick()
    local frames = 0
    local fps = 60
    RS.RenderStepped:Connect(function()
        frames = frames + 1
        local now = tick()
        if now - last >= 1 then
            fps = frames/(now-last)
            fpsLabel.Text = "FPS: "..math.floor(fps)
            last = now
            frames = 0
        end
    end)
end

updateBtnStates()

minimizeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
    miniButton.Visible = true
end)
miniButton.MouseButton1Click:Connect(function()
    frame.Visible = true
    miniButton.Visible = false
end)
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
    getgenv().MMM_AUTOPLAY = false
    getgenv().MMM_ANTILAG = false
    pcall(function() if getgenv().MMM_AUTOPLAY_STOP then getgenv().MMM_AUTOPLAY_STOP() end end)
end)