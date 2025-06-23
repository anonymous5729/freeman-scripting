local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local gui = Instance.new("ScreenGui")
gui.Name = "RLD_UI"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local mainColor = Color3.fromRGB(18, 18, 18)
local borderColor = Color3.fromRGB(30, 30, 30)
local accentColor = Color3.fromRGB(40, 120, 255)
local buttonColor = Color3.fromRGB(30, 30, 30)
local textColor = Color3.fromRGB(255,255,255)
local closeColor = Color3.fromRGB(180,30,30)
local minimizeColor = Color3.fromRGB(60,60,60)
local notificationColor = Color3.fromRGB(15,15,15)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 270, 0, 360)
frame.Position = UDim2.new(0.06, 0, 0.18, 0)
frame.BackgroundColor3 = mainColor
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = borderColor
titleBar.BorderSizePixel = 0
titleBar.Parent = frame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel")
title.Text = "Freeman’s HUB: RLD"
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.Size = UDim2.new(0,36,0,32)
closeButton.Position = UDim2.new(1, -44, 0, 3)
closeButton.BackgroundColor3 = closeColor
closeButton.TextColor3 = textColor
closeButton.Font = Enum.Font.GothamBold
closeButton.TextScaled = true
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

local minimizeButton = Instance.new("TextButton")
minimizeButton.Text = "_"
minimizeButton.Size = UDim2.new(0,32,0,32)
minimizeButton.Position = UDim2.new(1, -80, 0, 3)
minimizeButton.BackgroundColor3 = minimizeColor
minimizeButton.TextColor3 = textColor
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextScaled = true
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = titleBar
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 6)

local miniButton = Instance.new("TextButton")
miniButton.Size = UDim2.new(0, 38, 0, 38)
miniButton.Position = UDim2.new(0, 8, 0, 8)
miniButton.BackgroundColor3 = mainColor
miniButton.Text = "+"
miniButton.TextColor3 = textColor
miniButton.Font = Enum.Font.GothamBold
miniButton.TextScaled = true
miniButton.Visible = false
miniButton.BorderSizePixel = 0
miniButton.Parent = gui
Instance.new("UICorner", miniButton).CornerRadius = UDim.new(0, 8)

local btnHolder = Instance.new("Frame")
btnHolder.Size = UDim2.new(1, -24, 0, 220)
btnHolder.Position = UDim2.new(0, 12, 0, 54)
btnHolder.BackgroundTransparency = 1
btnHolder.Parent = frame

local function CreateButton(text, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 34)
	btn.Position = UDim2.new(0, 0, 0, y)
	btn.BackgroundColor3 = buttonColor
	btn.Text = text
	btn.TextColor3 = textColor
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.Parent = btnHolder
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	return btn
end

local espButton = CreateButton("ESP: ON", 0)
local autoDoorsButton = CreateButton("Auto Doors: OFF", 44)
local spawnedEntitiesButton = CreateButton("Spawned Entities", 88)
local alertEntitiesButton = CreateButton("Alert Entities: OFF", 132)
local entitiesListButton = CreateButton("ENTITIES LIST", 176)

local credit = Instance.new("TextLabel")
credit.Text = "Freeman4i37"
credit.Size = UDim2.new(1, 0, 0, 22)
credit.Position = UDim2.new(0, 0, 1, -28)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(100, 100, 100)
credit.Font = Enum.Font.Gotham
credit.TextScaled = true
credit.Parent = frame

local alertEntitiesEnabled = false
alertEntitiesButton.MouseButton1Click:Connect(function()
	alertEntitiesEnabled = not alertEntitiesEnabled
	alertEntitiesButton.Text = alertEntitiesEnabled and "Alert Entities: ON" or "Alert Entities: OFF"
end)

local function showEntityNotification(entityNames)
	local notifFrame = Instance.new("Frame")
	notifFrame.Size = UDim2.new(0, 320, 0, 58)
	notifFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	notifFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	notifFrame.BackgroundColor3 = notificationColor
	notifFrame.BackgroundTransparency = 0
	notifFrame.Parent = gui
	notifFrame.ZIndex = 8
	Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 12)
	local notifLabel = Instance.new("TextLabel")
	notifLabel.Size = UDim2.new(1, -16, 1, 0)
	notifLabel.Position = UDim2.new(0, 8, 0, 0)
	notifLabel.BackgroundTransparency = 1
	notifLabel.TextColor3 = Color3.fromRGB(255,255,255)
	notifLabel.Font = Enum.Font.GothamBold
	notifLabel.TextScaled = true
	notifLabel.ZIndex = 9
	notifLabel.Parent = notifFrame
	if #entityNames == 1 then
		notifLabel.Text = entityNames[1] .. " spawned, hide!"
	else
		notifLabel.Text = table.concat(entityNames, ", ") .. " spawned, hide!"
	end
	game:GetService("TweenService"):Create(
		notifFrame,
		TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{BackgroundTransparency = 0}
	):Play()
	task.spawn(function()
		task.wait(4)
		notifFrame:Destroy()
	end)
end

local lastEntities = {}
task.spawn(function()
	while true do
		if alertEntitiesEnabled then
			local folder = workspace:FindFirstChild("SpawnedEnitites")
			if folder then
				local current = {}
				for _, entity in pairs(folder:GetChildren()) do
					current[entity] = true
				end
				local newNames = {}
				for entity,_ in pairs(current) do
					if not lastEntities[entity] then
						table.insert(newNames, entity.Name)
					end
				end
				if #newNames > 0 then
					showEntityNotification(newNames)
				end
				lastEntities = current
			end
		end
		task.wait(0.1)
	end
end)

local entitiesListConfirmFrame = Instance.new("Frame")
entitiesListConfirmFrame.Size = UDim2.new(0, 365, 0, 110)
entitiesListConfirmFrame.AnchorPoint = Vector2.new(0.5, 0.5)
entitiesListConfirmFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
entitiesListConfirmFrame.BackgroundColor3 = mainColor
entitiesListConfirmFrame.Visible = false
entitiesListConfirmFrame.Parent = gui
entitiesListConfirmFrame.ZIndex = 100
Instance.new("UICorner", entitiesListConfirmFrame).CornerRadius = UDim.new(0, 12)

local confirmLabel = Instance.new("TextLabel")
confirmLabel.Text = "This button will show all the names of the entities and their functionalities (for beginners), do you really want to see this?"
confirmLabel.Size = UDim2.new(1, -18, 0, 56)
confirmLabel.Position = UDim2.new(0, 9, 0, 10)
confirmLabel.BackgroundTransparency = 1
confirmLabel.TextColor3 = textColor
confirmLabel.Font = Enum.Font.Gotham
confirmLabel.TextWrapped = true
confirmLabel.TextScaled = true
confirmLabel.Parent = entitiesListConfirmFrame
confirmLabel.ZIndex = 101

local yesButton = Instance.new("TextButton")
yesButton.Text = "YES"
yesButton.Size = UDim2.new(0.46, -6, 0, 34)
yesButton.Position = UDim2.new(0.04, 0, 1, -44)
yesButton.BackgroundColor3 = accentColor
yesButton.TextColor3 = textColor
yesButton.Font = Enum.Font.GothamBold
yesButton.TextScaled = true
yesButton.ZIndex = 102
yesButton.Parent = entitiesListConfirmFrame
Instance.new("UICorner", yesButton).CornerRadius = UDim.new(0, 7)

local noButton = Instance.new("TextButton")
noButton.Text = "NO"
noButton.Size = UDim2.new(0.46, -6, 0, 34)
noButton.Position = UDim2.new(0.5, 6, 1, -44)
noButton.BackgroundColor3 = closeColor
noButton.TextColor3 = textColor
noButton.Font = Enum.Font.GothamBold
noButton.TextScaled = true
noButton.ZIndex = 102
noButton.Parent = entitiesListConfirmFrame
Instance.new("UICorner", noButton).CornerRadius = UDim.new(0, 7)

local entitiesListFrame = Instance.new("Frame")
entitiesListFrame.Size = UDim2.new(0, 680, 0, 480)
entitiesListFrame.AnchorPoint = Vector2.new(0.5, 0.5)
entitiesListFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
entitiesListFrame.BackgroundColor3 = mainColor
entitiesListFrame.Visible = false
entitiesListFrame.Parent = gui
entitiesListFrame.Active = true
entitiesListFrame.Draggable = true
entitiesListFrame.ZIndex = 105
Instance.new("UICorner", entitiesListFrame).CornerRadius = UDim.new(0, 13)

local elTitleBar = Instance.new("Frame")
elTitleBar.Size = UDim2.new(1, 0, 0, 44)
elTitleBar.BackgroundColor3 = borderColor
elTitleBar.Parent = entitiesListFrame
elTitleBar.ZIndex = 106
Instance.new("UICorner", elTitleBar).CornerRadius = UDim.new(0, 13)

local elTitle = Instance.new("TextLabel")
elTitle.Text = "Entities List - BETA"
elTitle.Size = UDim2.new(1, -90, 1, 0)
elTitle.Position = UDim2.new(0, 16, 0, 0)
elTitle.BackgroundTransparency = 1
elTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
elTitle.Font = Enum.Font.GothamBold
elTitle.TextScaled = true
elTitle.TextXAlignment = Enum.TextXAlignment.Left
elTitle.Parent = elTitleBar
elTitle.ZIndex = 107

local elCloseButton = Instance.new("TextButton")
elCloseButton.Text = "X"
elCloseButton.Size = UDim2.new(0,36,0,36)
elCloseButton.Position = UDim2.new(1, -46, 0, 4)
elCloseButton.BackgroundColor3 = closeColor
elCloseButton.TextColor3 = textColor
elCloseButton.Font = Enum.Font.GothamBold
elCloseButton.TextScaled = true
elCloseButton.BorderSizePixel = 0
elCloseButton.Parent = elTitleBar
elCloseButton.ZIndex = 108
Instance.new("UICorner", elCloseButton).CornerRadius = UDim.new(0, 8)

local elMinimizeButton = Instance.new("TextButton")
elMinimizeButton.Text = "_"
elMinimizeButton.Size = UDim2.new(0,36,0,36)
elMinimizeButton.Position = UDim2.new(1, -90, 0, 4)
elMinimizeButton.BackgroundColor3 = minimizeColor
elMinimizeButton.TextColor3 = textColor
elMinimizeButton.Font = Enum.Font.GothamBold
elMinimizeButton.TextScaled = true
elMinimizeButton.BorderSizePixel = 0
elMinimizeButton.Parent = elTitleBar
elMinimizeButton.ZIndex = 108
Instance.new("UICorner", elMinimizeButton).CornerRadius = UDim.new(0, 8)

local elScroll = Instance.new("ScrollingFrame")
elScroll.Size = UDim2.new(1, -24, 1, -56)
elScroll.Position = UDim2.new(0, 12, 0, 52)
elScroll.BackgroundTransparency = 1
elScroll.CanvasSize = UDim2.new(0, 0, 0, 1500)
elScroll.ScrollBarThickness = 8
elScroll.Parent = entitiesListFrame
elScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
elScroll.ZIndex = 110

local elText = Instance.new("TextLabel")
elText.Text = [[SECTION A

Happyman, Scaredman, Joyfulman, Shortman, Tallman, Mournfulman, Smartman, Mushman, Microman, Sleepyman - No need to hide.
Nerdman - Get the user and ask them for a random math problem (write the correct answer in the chat).
Bigman - Eats an Locker, no need to hide.
Glee - Helpful entity, alert that entity is on the way.
A-1 - Do not touch him, this applies to some entities such as C-1, SN-1 and JB-1.
1-A - Hide to avoid taking multiple damage.
A-25 - He's a rebounder entity, so hide.
A-45 - Faster than A-25, then hide.
A-60 - Faster than A-45, then hide.
A-75 - You will hear a loud bang sound, and then hide and DO NOT come out of it because this entity has Aimscript.
A-105 - The map will turn green, and hide in tables, A-105 kills in GRAY LOCKERS and is a rebounder.
A-120 - No need to hide, it will just spawn a random entity from section A (in that case you will have to hide).
A-150 - It will spawn several clones (audio warning) and you have to hide.
A-185 - Hide in GRAY LOCKERS and tables, he kills in blue cabinets.
A-200 - He will appear at the current door and wander through the rooms, hide and don't come out.
A-225 - He will begin approaching a random targetted player. He will stalk and follow them forever until either A-225 is too far from the player, gets close enough to kill them, the player hiding, or the player looking at for long enough.
A-250 - Just hide.
A-275 - Hide at least 3/4 doors back to avoid dying from the A-275's orbs.
A-300 - Spawns clones called CV-300 that one of them kills on tables and one of them will wander and bounce off the walls dealing damage of unhiding players.

MORE ENTITIES LIST SOON!]]
elText.Size = UDim2.new(1, -12, 0, 1500)
elText.Position = UDim2.new(0, 6, 0, 0)
elText.BackgroundTransparency = 1
elText.TextColor3 = textColor
elText.Font = Enum.Font.Gotham
elText.TextXAlignment = Enum.TextXAlignment.Left
elText.TextYAlignment = Enum.TextYAlignment.Top
elText.TextWrapped = true
elText.TextScaled = false
elText.TextSize = 18
elText.Parent = elScroll
elText.ZIndex = 111

entitiesListButton.MouseButton1Click:Connect(function()
	entitiesListConfirmFrame.Visible = true
end)

yesButton.MouseButton1Click:Connect(function()
	entitiesListConfirmFrame.Visible = false
	entitiesListFrame.Visible = true
end)
noButton.MouseButton1Click:Connect(function()
	entitiesListConfirmFrame.Visible = false
end)
elCloseButton.MouseButton1Click:Connect(function()
	entitiesListFrame.Visible = false
end)
elMinimizeButton.MouseButton1Click:Connect(function()
	entitiesListFrame.Visible = false
end)

local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "RLD_ESP"
local espEnabled = true

local function CreateESP(part, entity)
	if part:FindFirstChild("ESP_Billboard") then return end
	local Billboard = Instance.new("BillboardGui")
	Billboard.Name = "ESP_Billboard"
	Billboard.Adornee = part
	Billboard.Size = UDim2.new(0, 140, 0, 50)
	Billboard.AlwaysOnTop = true
	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, 0, 1, 0)
	Label.BackgroundTransparency = 1
	Label.TextStrokeTransparency = 0
	Label.TextScaled = true
	Label.Font = Enum.Font.GothamBold
	Label.TextColor3 = Color3.new(1, 1, 1)
	Label.Text = entity.Name .. " | 0m"
	Label.Parent = Billboard
	Billboard.Parent = ESPFolder
	local connection = game:GetService("RunService").RenderStepped:Connect(function()
		if Billboard and Billboard.Adornee and espEnabled then
			local distance = (player.Character.HumanoidRootPart.Position - Billboard.Adornee.Position).Magnitude
			Label.Text = entity.Name .. " | " .. math.floor(distance) .. "m"
			Billboard.Enabled = true
		elseif not espEnabled then
			Billboard.Enabled = false
		else
			Billboard:Destroy()
			connection:Disconnect()
		end
	end)
	entity.AncestryChanged:Connect(function(_, parent)
		if not parent then
			Billboard:Destroy()
			connection:Disconnect()
		end
	end)
end

task.spawn(function()
	while true do
		if espEnabled then
			local folder = workspace:FindFirstChild("SpawnedEnitites")
			if folder then
				for _, entity in pairs(folder:GetChildren()) do
					local part = entity.PrimaryPart or entity:FindFirstChildWhichIsA("BasePart")
					if part then
						CreateESP(part, entity)
					end
				end
			end
		end
		task.wait(1)
	end
end)

espButton.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	espButton.Text = espEnabled and "ESP: ON" or "ESP: OFF"
end)

if not getgenv().RLD_AutoDoorsLock then
	getgenv().RLD_AutoDoorsLock = true
	task.spawn(function()
		while true do
			if getgenv().RLD_AutoDoorsEnabled then
				for _, section in pairs({"CurrentRoomsA", "CurrentRoomsB", "CurrentRoomsG"}) do
					local folder = workspace:FindFirstChild(section)
					if folder then
						for _, room in pairs(folder:GetChildren()) do
							for _, obj in pairs(room:GetDescendants()) do
								if obj:IsA("ProximityPrompt") and obj.ActionText == "Open" and obj.MaxActivationDistance >= 0 then
									fireproximityprompt(obj)
									task.wait(0.01)
								end
							end
						end
					end
				end
			end
			task.wait(0.1)
		end
	end)
end

autoDoorsButton.MouseButton1Click:Connect(function()
	getgenv().RLD_AutoDoorsEnabled = not getgenv().RLD_AutoDoorsEnabled
	autoDoorsButton.Text = getgenv().RLD_AutoDoorsEnabled and "Auto Doors: ON" or "Auto Doors: OFF"
end)

local entitiesFrame = Instance.new("Frame")
entitiesFrame.Size = UDim2.new(0, 340, 0, 310)
entitiesFrame.Position = UDim2.new(0.18, 0, 0.19, 0)
entitiesFrame.BackgroundColor3 = mainColor
entitiesFrame.Visible = false
entitiesFrame.Parent = gui
entitiesFrame.Active = true
entitiesFrame.Draggable = true
Instance.new("UICorner", entitiesFrame).CornerRadius = UDim.new(0, 8)

local entitiesTitle = Instance.new("TextLabel")
entitiesTitle.Text = "Spawned Entities"
entitiesTitle.Size = UDim2.new(1, 0, 0, 36)
entitiesTitle.BackgroundTransparency = 1
entitiesTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
entitiesTitle.Font = Enum.Font.GothamBold
entitiesTitle.TextScaled = true
entitiesTitle.Parent = entitiesFrame

local entitiesScrolling = Instance.new("ScrollingFrame")
entitiesScrolling.Size = UDim2.new(1, -18, 1, -54)
entitiesScrolling.Position = UDim2.new(0, 9, 0, 44)
entitiesScrolling.BackgroundTransparency = 1
entitiesScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
entitiesScrolling.ScrollBarThickness = 6
entitiesScrolling.Parent = entitiesFrame
entitiesScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y

local minimizeEntitiesButton = Instance.new("TextButton")
minimizeEntitiesButton.Text = "_"
minimizeEntitiesButton.Size = UDim2.new(0, 30, 0, 30)
minimizeEntitiesButton.Position = UDim2.new(1, -74, 0, 6)
minimizeEntitiesButton.BackgroundColor3 = minimizeColor
minimizeEntitiesButton.TextColor3 = textColor
minimizeEntitiesButton.Font = Enum.Font.GothamBold
minimizeEntitiesButton.TextScaled = true
minimizeEntitiesButton.Parent = entitiesFrame
Instance.new("UICorner", minimizeEntitiesButton).CornerRadius = UDim.new(0, 6)

local closeEntitiesButton = Instance.new("TextButton")
closeEntitiesButton.Text = "X"
closeEntitiesButton.Size = UDim2.new(0, 30, 0, 30)
closeEntitiesButton.Position = UDim2.new(1, -38, 0, 6)
closeEntitiesButton.BackgroundColor3 = closeColor
closeEntitiesButton.TextColor3 = textColor
closeEntitiesButton.Font = Enum.Font.GothamBold
closeEntitiesButton.TextScaled = true
closeEntitiesButton.Parent = entitiesFrame
Instance.new("UICorner", closeEntitiesButton).CornerRadius = UDim.new(0, 6)

local miniEntitiesButton = Instance.new("TextButton")
miniEntitiesButton.Size = UDim2.new(0, 38, 0, 38)
miniEntitiesButton.Position = UDim2.new(0.18, 0, 0.19, 0)
miniEntitiesButton.BackgroundColor3 = mainColor
miniEntitiesButton.Text = "+"
miniEntitiesButton.TextColor3 = textColor
miniEntitiesButton.Font = Enum.Font.GothamBold
miniEntitiesButton.TextScaled = true
miniEntitiesButton.Visible = false
miniEntitiesButton.Parent = gui
Instance.new("UICorner", miniEntitiesButton).CornerRadius = UDim.new(0, 8)

local function getEntityColor(entity)
    local monsterGui = entity:FindFirstChild("Monster Gui")
    if monsterGui then
        local image1 = monsterGui:FindFirstChild("Image1")
        if image1 and image1:IsA("ImageLabel") then
            return image1.ImageColor3
        end
    end
    local part = entity.PrimaryPart or entity:FindFirstChildWhichIsA("BasePart")
    if part and part:IsA("BasePart") then
        return part.Color
    end
    return Color3.new(1, 1, 1)
end

local unviewButton = nil
local lastCameraSubject = nil
local entityRows = {}

local function clearEntitiesList()
	for _, row in pairs(entityRows) do
		if row and row.Frame then
			row.Frame:Destroy()
		end
	end
	entityRows = {}
end

local function startSpectate(part, entity)
	lastCameraSubject = camera.CameraSubject
	camera.CameraSubject = part
	entitiesFrame.Visible = false
	miniEntitiesButton.Visible = false
	if unviewButton then unviewButton:Destroy() end
	unviewButton = Instance.new("TextButton")
	unviewButton.Size = UDim2.new(0, 120, 0, 35)
	unviewButton.Position = UDim2.new(0.5, -60, 1, -50)
	unviewButton.AnchorPoint = Vector2.new(0.5, 1)
	unviewButton.BackgroundColor3 = accentColor
	unviewButton.Text = "UNVIEW"
	unviewButton.TextColor3 = textColor
	unviewButton.Font = Enum.Font.GothamBold
	unviewButton.TextScaled = true
	unviewButton.Parent = gui
	Instance.new("UICorner", unviewButton).CornerRadius = UDim.new(0, 8)
	unviewButton.MouseButton1Click:Connect(function()
		camera.CameraSubject = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid") or lastCameraSubject
		if unviewButton then
			unviewButton:Destroy()
			unviewButton = nil
		end
		entitiesFrame.Visible = true
	end)
end

local function buildEntitiesList()
	clearEntitiesList()
	local folder = workspace:FindFirstChild("SpawnedEnitites")
	if not folder then
		entitiesTitle.Text = "Spawned Entities (none)"
		return
	else
		entitiesTitle.Text = "Spawned Entities"
	end
	local y = 0
	for _, entity in pairs(folder:GetChildren()) do
		local part = entity.PrimaryPart or entity:FindFirstChildWhichIsA("BasePart")
		if part then
			local row = {}
			local itemFrame = Instance.new("Frame")
			itemFrame.Size = UDim2.new(1, 0, 0, 36)
			itemFrame.Position = UDim2.new(0, 0, 0, y)
			itemFrame.BackgroundTransparency = 1
			itemFrame.Parent = entitiesScrolling
			local nameLabel = Instance.new("TextLabel")
			nameLabel.Text = entity.Name
			nameLabel.Size = UDim2.new(0.43, 0, 1, 0)
			nameLabel.Position = UDim2.new(0, 0, 0, 0)
			nameLabel.BackgroundTransparency = 1
			nameLabel.TextXAlignment = Enum.TextXAlignment.Left
			nameLabel.Font = Enum.Font.GothamBold
			nameLabel.TextScaled = true
			nameLabel.TextColor3 = getEntityColor(entity)
			nameLabel.Parent = itemFrame
			local viewBtn = Instance.new("TextButton")
			viewBtn.Size = UDim2.new(0.22, 0, 1, -8)
			viewBtn.Position = UDim2.new(0.45, 0, 0, 4)
			viewBtn.BackgroundColor3 = accentColor
			viewBtn.Text = "VIEW"
			viewBtn.TextColor3 = textColor
			viewBtn.Font = Enum.Font.GothamBold
			viewBtn.TextScaled = true
			viewBtn.Parent = itemFrame
			Instance.new("UICorner", viewBtn).CornerRadius = UDim.new(0, 5)
			local distLabel = Instance.new("TextLabel")
			distLabel.Text = "0 studs away"
			distLabel.Size = UDim2.new(0.32, 0, 1, 0)
			distLabel.Position = UDim2.new(0.69, 0, 0, 0)
			distLabel.BackgroundTransparency = 1
			distLabel.TextColor3 = textColor
			distLabel.Font = Enum.Font.GothamBold
			distLabel.TextScaled = true
			distLabel.TextXAlignment = Enum.TextXAlignment.Right
			distLabel.Parent = itemFrame
			viewBtn.MouseButton1Click:Connect(function()
				startSpectate(part, entity)
			end)
			row.Frame = itemFrame
			row.Entity = entity
			row.Part = part
			row.NameLabel = nameLabel
			row.DistLabel = distLabel
			table.insert(entityRows, row)
			y = y + 38
		end
	end
	entitiesScrolling.CanvasSize = UDim2.new(0, 0, 0, y)
end

local function updateEntityRows()
	local folder = workspace:FindFirstChild("SpawnedEnitites")
	if not folder then return end
	if #folder:GetChildren() ~= #entityRows then
		buildEntitiesList()
	end
	for i, row in ipairs(entityRows) do
		if row and row.Entity and row.Part and row.NameLabel and row.DistLabel then
			if row.Entity.Parent == folder then
				local dist = 0
				local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
				if hrp and row.Part and row.Part.Parent then
					dist = (hrp.Position - row.Part.Position).Magnitude
				end
				row.DistLabel.Text = math.floor(dist) .. " studs away"
				row.NameLabel.TextColor3 = getEntityColor(row.Entity)
			else
				if row.Frame then row.Frame:Destroy() end
			end
		end
	end
end

spawnedEntitiesButton.MouseButton1Click:Connect(function()
	entitiesFrame.Visible = true
	miniEntitiesButton.Visible = false
	buildEntitiesList()
end)

closeEntitiesButton.MouseButton1Click:Connect(function()
	entitiesFrame.Visible = false
	miniEntitiesButton.Visible = false
end)

minimizeEntitiesButton.MouseButton1Click:Connect(function()
	entitiesFrame.Visible = false
	miniEntitiesButton.Visible = true
end)

miniEntitiesButton.MouseButton1Click:Connect(function()
	entitiesFrame.Visible = true
	miniEntitiesButton.Visible = false
	buildEntitiesList()
end)

entitiesFrame:GetPropertyChangedSignal("Visible"):Connect(function()
	if entitiesFrame.Visible then
		buildEntitiesList()
	end
end)

task.spawn(function()
	while true do
		if entitiesFrame.Visible then
			updateEntityRows()
		end
		task.wait(0.01)
	end
end)

closeButton.MouseButton1Click:Connect(function()
	gui:Destroy()
	ESPFolder:Destroy()
end)

minimizeButton.MouseButton1Click:Connect(function()
	frame.Visible = false
	miniButton.Visible = true
end)

miniButton.MouseButton1Click:Connect(function()
	frame.Visible = true
	miniButton.Visible = false
end)