
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

local tweenTime = 0.25
local tweenStyle = Enum.EasingStyle.Quad
local tweenDirection = Enum.EasingDirection.Out

-- ================== СИСТЕМА КЛЮЧА ==================
local VALID_KEY = "1234"

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HelperFarmGUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Окно ввода ключа
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 260, 0, 120)
keyFrame.Position = UDim2.new(0.5, -130, 0.5, -60)
keyFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 46)
keyFrame.BorderSizePixel = 0
keyFrame.Visible = true
keyFrame.Parent = screenGui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 24)
keyTitle.Position = UDim2.new(0, 0, 0, 8)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "Введите ключ"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 16
keyTitle.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -30, 0, 28)
keyInput.Position = UDim2.new(0, 15, 0, 40)
keyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
keyInput.BorderSizePixel = 0
keyInput.Text = ""
keyInput.PlaceholderText = "Ключ..."
keyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 14
keyInput.Parent = keyFrame
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 4)

local keyError = Instance.new("TextLabel")
keyError.Size = UDim2.new(1, 0, 0, 16)
keyError.Position = UDim2.new(0, 0, 0, 72)
keyError.BackgroundTransparency = 1
keyError.Text = ""
keyError.TextColor3 = Color3.fromRGB(255, 80, 80)
keyError.Font = Enum.Font.Gotham
keyError.TextSize = 11
keyError.Parent = keyFrame

local keyButton = Instance.new("TextButton")
keyButton.Size = UDim2.new(0, 70, 0, 24)
keyButton.Position = UDim2.new(0.5, -35, 0, 88)
keyButton.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
keyButton.BorderSizePixel = 0
keyButton.Text = "OK"
keyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
keyButton.Font = Enum.Font.GothamBold
keyButton.TextSize = 14
keyButton.Parent = keyFrame
Instance.new("UICorner", keyButton).CornerRadius = UDim.new(0, 4)

local mainFrame = nil

keyButton.MouseButton1Click:Connect(function()
	if keyInput.Text == VALID_KEY then
		keyFrame:Destroy()
		createMainMenu()
	else
		keyError.Text = "Неверный ключ!"
	end
end)

-- ================== СОЗДАНИЕ ОСНОВНОГО МЕНЮ ==================
function createMainMenu()
	mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 380, 0, 400)
	mainFrame.Position = UDim2.new(0.5, -190, 0.5, -200)
	mainFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 46)
	mainFrame.BorderSizePixel = 0
	mainFrame.Visible = false
	mainFrame.Parent = screenGui

	local mainCorner = Instance.new("UICorner")
	mainCorner.CornerRadius = UDim.new(0, 10)
	mainCorner.Parent = mainFrame

	-- Верхняя панель
	local topBar = Instance.new("Frame")
	topBar.Size = UDim2.new(1, 0, 0, 36)
	topBar.BackgroundColor3 = Color3.fromRGB(22, 33, 62)
	topBar.BorderSizePixel = 0
	local topBarCorner = Instance.new("UICorner")
	topBarCorner.CornerRadius = UDim.new(0, 10)
	topBarCorner.Parent = topBar
	topBar.Parent = mainFrame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -100, 1, 0)
	titleLabel.Position = UDim2.new(0, 12, 0, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "Helper farm"
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 15
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = topBar

	-- Кнопка сворачивания
	local minimizeButton = Instance.new("TextButton")
	minimizeButton.Size = UDim2.new(0, 22, 0, 22)
	minimizeButton.Position = UDim2.new(1, -54, 0, 7)
	minimizeButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
	minimizeButton.BorderSizePixel = 0
	minimizeButton.Text = "—"
	minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	minimizeButton.Font = Enum.Font.GothamBold
	minimizeButton.TextSize = 12
	Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 5)
	minimizeButton.Parent = topBar

	-- Кнопка закрытия
	local closeButton = Instance.new("TextButton")
	closeButton.Size = UDim2.new(0, 22, 0, 22)
	closeButton.Position = UDim2.new(1, -30, 0, 7)
	closeButton.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
	closeButton.BorderSizePixel = 0
	closeButton.Text = "X"
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.Font = Enum.Font.GothamBold
	closeButton.TextSize = 12
	Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 5)
	closeButton.Parent = topBar
	closeButton.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

	-- Зоны перетаскивания
	local dragBottom = Instance.new("Frame")
	dragBottom.Size = UDim2.new(1, -16, 0, 32)
	dragBottom.Position = UDim2.new(0, 8, 1, -38)
	dragBottom.BackgroundTransparency = 1
	dragBottom.BorderSizePixel = 0
	dragBottom.Parent = mainFrame

	local dragLeft = Instance.new("Frame")
	dragLeft.Size = UDim2.new(0, 16, 1, -76)
	dragLeft.Position = UDim2.new(0, 0, 0, 38)
	dragLeft.BackgroundTransparency = 1
	dragLeft.BorderSizePixel = 0
	dragLeft.Parent = mainFrame

	local dragRight = Instance.new("Frame")
	dragRight.Size = UDim2.new(0, 16, 1, -76)
	dragRight.Position = UDim2.new(1, -16, 0, 38)
	dragRight.BackgroundTransparency = 1
	dragRight.BorderSizePixel = 0
	dragRight.Parent = mainFrame

	-- Перетаскивание
	local isDragging = false
	local dragStartPos = nil
	local frameStartPos = nil

	local function startDrag(input)
		isDragging = true
		dragStartPos = input.Position
		frameStartPos = mainFrame.Position
	end

	topBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			startDrag(input)
		end
	end)

	dragBottom.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			startDrag(input)
		end
	end)

	dragLeft.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			startDrag(input)
		end
	end)

	dragRight.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			startDrag(input)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStartPos
			mainFrame.Position = UDim2.new(
				frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X,
				frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = false
		end
	end)

	-- Панель вкладок
	local tabBar = Instance.new("Frame")
	tabBar.Size = UDim2.new(1, -16, 0, 24)
	tabBar.Position = UDim2.new(0, 8, 0, 40)
	tabBar.BackgroundTransparency = 1
	tabBar.Parent = mainFrame

	local mainTab = Instance.new("TextButton")
	mainTab.Size = UDim2.new(0, 50, 0, 20)
	mainTab.Position = UDim2.new(0, 0, 0, 2)
	mainTab.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
	mainTab.BorderSizePixel = 0
	mainTab.Text = "Main"
	mainTab.TextColor3 = Color3.fromRGB(255, 255, 255)
	mainTab.Font = Enum.Font.GothamBold
	mainTab.TextSize = 12
	Instance.new("UICorner", mainTab).CornerRadius = UDim.new(0, 4)
	mainTab.Parent = tabBar

	-- Вкладка soon (Inf Jump)
	local soonTab = Instance.new("TextButton")
	soonTab.Size = UDim2.new(0, 50, 0, 20)
	soonTab.Position = UDim2.new(0, 54, 0, 2)
	soonTab.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	soonTab.BorderSizePixel = 0
	soonTab.Text = "soon"
	soonTab.TextColor3 = Color3.fromRGB(255, 255, 255)
	soonTab.Font = Enum.Font.GothamBold
	soonTab.TextSize = 12
	Instance.new("UICorner", soonTab).CornerRadius = UDim.new(0, 4)
	soonTab.Parent = tabBar

	local teleportTab = Instance.new("TextButton")
	teleportTab.Size = UDim2.new(0, 70, 0, 20)
	teleportTab.Position = UDim2.new(0, 108, 0, 2)
	teleportTab.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	teleportTab.BorderSizePixel = 0
	teleportTab.Text = "Teleport"
	teleportTab.TextColor3 = Color3.fromRGB(255, 255, 255)
	teleportTab.Font = Enum.Font.GothamBold
	teleportTab.TextSize = 11
	Instance.new("UICorner", teleportTab).CornerRadius = UDim.new(0, 4)
	teleportTab.Parent = tabBar

	-- Контентные области
	local mainTabContent = Instance.new("Frame")
	mainTabContent.Size = UDim2.new(1, -16, 0, 298)
	mainTabContent.Position = UDim2.new(0, 8, 0, 66)
	mainTabContent.BackgroundTransparency = 1
	mainTabContent.Visible = true
	mainTabContent.Parent = mainFrame

	local soonTabContent = Instance.new("Frame")
	soonTabContent.Size = UDim2.new(1, -16, 0, 298)
	soonTabContent.Position = UDim2.new(0, 8, 0, 66)
	soonTabContent.BackgroundTransparency = 1
	soonTabContent.Visible = false
	soonTabContent.Parent = mainFrame

	local teleportTabContent = Instance.new("Frame")
	teleportTabContent.Size = UDim2.new(1, -16, 0, 298)
	teleportTabContent.Position = UDim2.new(0, 8, 0, 66)
	teleportTabContent.BackgroundTransparency = 1
	teleportTabContent.Visible = false
	teleportTabContent.Parent = mainFrame

	-- Скроллинг внутри mainTabContent
	local scrollingFrame = Instance.new("ScrollingFrame")
	scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
	scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
	scrollingFrame.BackgroundTransparency = 1
	scrollingFrame.BorderSizePixel = 0
	scrollingFrame.ScrollBarThickness = 3
	scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(233, 69, 96)
	scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	scrollingFrame.Parent = mainTabContent

	-- ================== SOON TAB CONTENT (Inf Jump с мобильной кнопкой Jump) ==================
	local soonTitle = Instance.new("TextLabel")
	soonTitle.Size = UDim2.new(1, 0, 0, 24)
	soonTitle.Position = UDim2.new(0, 0, 0, 10)
	soonTitle.BackgroundTransparency = 1
	soonTitle.Text = "Бесконечный прыжок"
	soonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	soonTitle.Font = Enum.Font.GothamSemibold
	soonTitle.TextSize = 14
	soonTitle.TextXAlignment = Enum.TextXAlignment.Left
	soonTitle.Parent = soonTabContent

	local infJumpToggleGroup = Instance.new("Frame")
	infJumpToggleGroup.Size = UDim2.new(1, 0, 0, 34)
	infJumpToggleGroup.Position = UDim2.new(0, 0, 0, 40)
	infJumpToggleGroup.BackgroundTransparency = 1
	infJumpToggleGroup.Parent = soonTabContent

	local infJumpLabel = Instance.new("TextLabel")
	infJumpLabel.Size = UDim2.new(1, -46, 0, 14)
	infJumpLabel.BackgroundTransparency = 1
	infJumpLabel.Text = "Inf Jump"
	infJumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	infJumpLabel.Font = Enum.Font.GothamSemibold
	infJumpLabel.TextSize = 12
	infJumpLabel.TextXAlignment = Enum.TextXAlignment.Left
	infJumpLabel.Parent = infJumpToggleGroup

	local infJumpDesc = Instance.new("TextLabel")
	infJumpDesc.Size = UDim2.new(1, -46, 0, 11)
	infJumpDesc.Position = UDim2.new(0, 0, 0, 14)
	infJumpDesc.BackgroundTransparency = 1
	infJumpDesc.Text = "Бесконечный прыжок (Space или кнопка Jump)"
	infJumpDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
	infJumpDesc.Font = Enum.Font.Gotham
	infJumpDesc.TextSize = 9
	infJumpDesc.TextXAlignment = Enum.TextXAlignment.Left
	infJumpDesc.Parent = infJumpToggleGroup

	local infJumpToggleBox = Instance.new("Frame")
	infJumpToggleBox.Size = UDim2.new(0, 32, 0, 18)
	infJumpToggleBox.Position = UDim2.new(1, -38, 0, 7)
	infJumpToggleBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	infJumpToggleBox.BorderSizePixel = 0
	Instance.new("UICorner", infJumpToggleBox).CornerRadius = UDim.new(0, 9)
	infJumpToggleBox.Parent = infJumpToggleGroup

	local infJumpIndicator = Instance.new("Frame")
	infJumpIndicator.Size = UDim2.new(0, 12, 0, 12)
	infJumpIndicator.Position = UDim2.new(0, 3, 0, 3)
	infJumpIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	infJumpIndicator.BorderSizePixel = 0
	Instance.new("UICorner", infJumpIndicator).CornerRadius = UDim.new(0, 6)
	infJumpIndicator.Parent = infJumpToggleBox

	local infJumpToggleButton = Instance.new("TextButton")
	infJumpToggleButton.Size = UDim2.new(1, 0, 1, 0)
	infJumpToggleButton.BackgroundTransparency = 1
	infJumpToggleButton.Text = ""
	infJumpToggleButton.Parent = infJumpToggleBox

	-- Видимая мобильная кнопка Jump (появляется при включении)
	local mobileJumpButton = Instance.new("TextButton")
	mobileJumpButton.Size = UDim2.new(0, 80, 0, 80)
	mobileJumpButton.Position = UDim2.new(0.5, -40, 1, -110)  -- внизу по центру
	mobileJumpButton.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
	mobileJumpButton.BackgroundTransparency = 0.3
	mobileJumpButton.BorderSizePixel = 0
	mobileJumpButton.Text = "JUMP"
	mobileJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	mobileJumpButton.Font = Enum.Font.GothamBold
	mobileJumpButton.TextSize = 18
	mobileJumpButton.Visible = false
	mobileJumpButton.ZIndex = 10
	Instance.new("UICorner", mobileJumpButton).CornerRadius = UDim.new(1, 0)  -- круглая
	mobileJumpButton.Parent = screenGui

	local infJumpEnabled = false

	-- Функция прыжка (общая для ПК и мобильных)
	local function performJump()
		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			local root = char.HumanoidRootPart
			root.Velocity = Vector3.new(root.Velocity.X, 50, root.Velocity.Z)
		end
	end

	infJumpToggleButton.MouseButton1Click:Connect(function()
		infJumpEnabled = not infJumpEnabled
		if infJumpEnabled then
			infJumpToggleBox.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
			infJumpIndicator.Position = UDim2.new(1, -15, 0, 3)
			mobileJumpButton.Visible = true
		else
			infJumpToggleBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
			infJumpIndicator.Position = UDim2.new(0, 3, 0, 3)
			mobileJumpButton.Visible = false
		end
	end)

	-- Обработка прыжка с клавиатуры (ПК)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode.Space and infJumpEnabled then
			performJump()
		end
	end)

	-- Обработка тапа по мобильной кнопке Jump
	mobileJumpButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch and infJumpEnabled then
			performJump()
		end
	end)

	-- ================== TELEPORT TAB CONTENT ==================
	local gpsLabel = Instance.new("TextLabel")
	gpsLabel.Size = UDim2.new(0, 200, 0, 40)
	gpsLabel.Position = UDim2.new(0, 10, 1, -50)
	gpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	gpsLabel.BackgroundTransparency = 0.5
	gpsLabel.BorderSizePixel = 0
	gpsLabel.Text = "GPS выкл"
	gpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	gpsLabel.Font = Enum.Font.Gotham
	gpsLabel.TextSize = 14
	gpsLabel.TextXAlignment = Enum.TextXAlignment.Center
	gpsLabel.TextYAlignment = Enum.TextYAlignment.Center
	gpsLabel.Visible = false
	gpsLabel.Parent = screenGui

	local gpsConnection = nil
	local gpsEnabled = false

	local function updateGPS()
		if gpsEnabled then
			local char = player.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				local pos = char.HumanoidRootPart.Position
				gpsLabel.Text = string.format("X: %d  Y: %d  Z: %d", math.floor(pos.X), math.floor(pos.Y), math.floor(pos.Z))
			else
				gpsLabel.Text = "Нет персонажа"
			end
		end
	end

	local coordInputsFrame = Instance.new("Frame")
	coordInputsFrame.Size = UDim2.new(1, 0, 0, 90)
	coordInputsFrame.Position = UDim2.new(0, 0, 0, 60)
	coordInputsFrame.BackgroundTransparency = 1
	coordInputsFrame.Parent = teleportTabContent

	local xLabel = Instance.new("TextLabel")
	xLabel.Size = UDim2.new(0, 30, 0, 20)
	xLabel.Position = UDim2.new(0, 0, 0, 0)
	xLabel.BackgroundTransparency = 1
	xLabel.Text = "X:"
	xLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	xLabel.Font = Enum.Font.Gotham
	xLabel.TextSize = 12
	xLabel.Parent = coordInputsFrame

	local xInput = Instance.new("TextBox")
	xInput.Size = UDim2.new(1, -40, 0, 20)
	xInput.Position = UDim2.new(0, 35, 0, 0)
	xInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	xInput.BorderSizePixel = 0
	xInput.Text = ""
	xInput.PlaceholderText = "132"
	xInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	xInput.Font = Enum.Font.Gotham
	xInput.TextSize = 12
	Instance.new("UICorner", xInput).CornerRadius = UDim.new(0, 4)
	xInput.Parent = coordInputsFrame

	local yLabel = Instance.new("TextLabel")
	yLabel.Size = UDim2.new(0, 30, 0, 20)
	yLabel.Position = UDim2.new(0, 0, 0, 25)
	yLabel.BackgroundTransparency = 1
	yLabel.Text = "Y:"
	yLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	yLabel.Font = Enum.Font.Gotham
	yLabel.TextSize = 12
	yLabel.Parent = coordInputsFrame

	local yInput = Instance.new("TextBox")
	yInput.Size = UDim2.new(1, -40, 0, 20)
	yInput.Position = UDim2.new(0, 35, 0, 25)
	yInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	yInput.BorderSizePixel = 0
	yInput.Text = ""
	yInput.PlaceholderText = "533"
	yInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	yInput.Font = Enum.Font.Gotham
	yInput.TextSize = 12
	Instance.new("UICorner", yInput).CornerRadius = UDim.new(0, 4)
	yInput.Parent = coordInputsFrame

	local zLabel = Instance.new("TextLabel")
	zLabel.Size = UDim2.new(0, 30, 0, 20)
	zLabel.Position = UDim2.new(0, 0, 0, 50)
	zLabel.BackgroundTransparency = 1
	zLabel.Text = "Z:"
	zLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	zLabel.Font = Enum.Font.Gotham
	zLabel.TextSize = 12
	zLabel.Parent = coordInputsFrame

	local zInput = Instance.new("TextBox")
	zInput.Size = UDim2.new(1, -40, 0, 20)
	zInput.Position = UDim2.new(0, 35, 0, 50)
	zInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	zInput.BorderSizePixel = 0
	zInput.Text = ""
	zInput.PlaceholderText = "905"
	zInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	zInput.Font = Enum.Font.Gotham
	zInput.TextSize = 12
	Instance.new("UICorner", zInput).CornerRadius = UDim.new(0, 4)
	zInput.Parent = coordInputsFrame

	local teleportButton = Instance.new("TextButton")
	teleportButton.Size = UDim2.new(1, 0, 0, 30)
	teleportButton.Position = UDim2.new(0, 0, 0, 160)
	teleportButton.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
	teleportButton.BorderSizePixel = 0
	teleportButton.Text = "Teleport"
	teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	teleportButton.Font = Enum.Font.GothamBold
	teleportButton.TextSize = 14
	Instance.new("UICorner", teleportButton).CornerRadius = UDim.new(0, 4)
	teleportButton.Parent = teleportTabContent

	teleportButton.MouseButton1Click:Connect(function()
		local x = tonumber(xInput.Text)
		local y = tonumber(yInput.Text)
		local z = tonumber(zInput.Text)
		if x and y and z then
			local char = player.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				char:SetPrimaryPartCFrame(CFrame.new(x, y, z))
			end
		end
	end)

	-- GPS тумблер
	local gpsToggleGroup = Instance.new("Frame")
	gpsToggleGroup.Size = UDim2.new(1, 0, 0, 34)
	gpsToggleGroup.Position = UDim2.new(0, 0, 0, 0)
	gpsToggleGroup.BackgroundTransparency = 1
	gpsToggleGroup.Parent = teleportTabContent

	local gpsToggleLabel = Instance.new("TextLabel")
	gpsToggleLabel.Size = UDim2.new(1, -46, 0, 14)
	gpsToggleLabel.BackgroundTransparency = 1
	gpsToggleLabel.Text = "GPS"
	gpsToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	gpsToggleLabel.Font = Enum.Font.GothamSemibold
	gpsToggleLabel.TextSize = 12
	gpsToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
	gpsToggleLabel.Parent = gpsToggleGroup

	local gpsDescLabel = Instance.new("TextLabel")
	gpsDescLabel.Size = UDim2.new(1, -46, 0, 11)
	gpsDescLabel.Position = UDim2.new(0, 0, 0, 14)
	gpsDescLabel.BackgroundTransparency = 1
	gpsDescLabel.Text = "Показать координаты"
	gpsDescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
	gpsDescLabel.Font = Enum.Font.Gotham
	gpsDescLabel.TextSize = 9
	gpsDescLabel.TextXAlignment = Enum.TextXAlignment.Left
	gpsDescLabel.Parent = gpsToggleGroup

	local gpsToggleBox = Instance.new("Frame")
	gpsToggleBox.Size = UDim2.new(0, 32, 0, 18)
	gpsToggleBox.Position = UDim2.new(1, -38, 0, 7)
	gpsToggleBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	gpsToggleBox.BorderSizePixel = 0
	Instance.new("UICorner", gpsToggleBox).CornerRadius = UDim.new(0, 9)
	gpsToggleBox.Parent = gpsToggleGroup

	local gpsIndicator = Instance.new("Frame")
	gpsIndicator.Size = UDim2.new(0, 12, 0, 12)
	gpsIndicator.Position = UDim2.new(0, 3, 0, 3)
	gpsIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	gpsIndicator.BorderSizePixel = 0
	Instance.new("UICorner", gpsIndicator).CornerRadius = UDim.new(0, 6)
	gpsIndicator.Parent = gpsToggleBox

	local gpsToggleButton = Instance.new("TextButton")
	gpsToggleButton.Size = UDim2.new(1, 0, 1, 0)
	gpsToggleButton.BackgroundTransparency = 1
	gpsToggleButton.Text = ""
	gpsToggleButton.Parent = gpsToggleBox

	gpsToggleButton.MouseButton1Click:Connect(function()
		gpsEnabled = not gpsEnabled
		if gpsEnabled then
			gpsToggleBox.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
			gpsIndicator.Position = UDim2.new(1, -15, 0, 3)
			gpsLabel.Visible = true
			if gpsConnection then gpsConnection:Disconnect() end
			gpsConnection = RunService.Heartbeat:Connect(updateGPS)
			updateGPS()
		else
			gpsToggleBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
			gpsIndicator.Position = UDim2.new(0, 3, 0, 3)
			gpsLabel.Visible = false
			if gpsConnection then
				gpsConnection:Disconnect()
				gpsConnection = nil
			end
		end
	end)

	-- ================== ПЕРЕКЛЮЧЕНИЕ ВКЛАДОК ==================
	local currentTab = "Main"

	local function resetTabs()
		mainTab.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
		soonTab.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
		teleportTab.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
		mainTabContent.Visible = false
		soonTabContent.Visible = false
		teleportTabContent.Visible = false
	end

	local function showTab(tabName)
		currentTab = tabName
		resetTabs()
		if tabName == "Main" then
			mainTab.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
			mainTabContent.Visible = true
		elseif tabName == "soon" then
			soonTab.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
			soonTabContent.Visible = true
		elseif tabName == "Teleport" then
			teleportTab.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
			teleportTabContent.Visible = true
		end
	end

	mainTab.MouseButton1Click:Connect(function() showTab("Main") end)
	soonTab.MouseButton1Click:Connect(function() showTab("soon") end)
	teleportTab.MouseButton1Click:Connect(function() showTab("Teleport") end)

	-- ================== ОСНОВНЫЕ ФУНКЦИИ (Main Tab) ==================
	local currentSpeed = 16
	local currentJump = 50
	local flyEnabled = false
	local flySpeed = 50
	local bodyVelocity, bodyGyro, flyConnection
	local btnForward, btnBackward, btnUp, btnDown
	local forwardPressed = false
	local backwardPressed = false
	local upPressed = false
	local downPressed = false

	-- Утилиты создания слайдеров и тумблеров
	local function createSlider(name, desc, minVal, maxVal, defaultVal, positionY, parent)
		local group = Instance.new("Frame")
		group.Size = UDim2.new(1, 0, 0, 40)
		group.Position = UDim2.new(0, 0, 0, positionY)
		group.BackgroundTransparency = 1
		group.Parent = parent

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, 0, 0, 14)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = name
		nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		nameLabel.Font = Enum.Font.GothamSemibold
		nameLabel.TextSize = 12
		nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.Parent = group

		local descLabel = Instance.new("TextLabel")
		descLabel.Size = UDim2.new(1, 0, 0, 11)
		descLabel.Position = UDim2.new(0, 0, 0, 14)
		descLabel.BackgroundTransparency = 1
		descLabel.Text = desc
		descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		descLabel.Font = Enum.Font.Gotham
		descLabel.TextSize = 9
		descLabel.TextXAlignment = Enum.TextXAlignment.Left
		descLabel.Parent = group

		local track = Instance.new("Frame")
		track.Size = UDim2.new(1, -44, 0, 6)
		track.Position = UDim2.new(0, 0, 0, 28)
		track.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
		track.BorderSizePixel = 0
		Instance.new("UICorner", track).CornerRadius = UDim.new(0, 3)
		track.Parent = group

		local fill = Instance.new("Frame")
		fill.Size = UDim2.new(0, 0, 1, 0)
		fill.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
		fill.BorderSizePixel = 0
		Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 3)
		fill.Parent = track

		local thumb = Instance.new("Frame")
		thumb.Size = UDim2.new(0, 12, 0, 12)
		thumb.AnchorPoint = Vector2.new(0.5, 0.5)
		thumb.Position = UDim2.new(0, 0, 0.5, 0)
		thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		thumb.BorderSizePixel = 0
		Instance.new("UICorner", thumb).CornerRadius = UDim.new(0, 6)
		thumb.Parent = track

		local sliderButton = Instance.new("TextButton")
		sliderButton.Size = UDim2.new(1, 0, 1, 0)
		sliderButton.BackgroundTransparency = 1
		sliderButton.Text = ""
		sliderButton.Parent = track

		local valueLabel = Instance.new("TextLabel")
		valueLabel.Size = UDim2.new(0, 38, 0, 14)
		valueLabel.Position = UDim2.new(1, -38, 0, 28)
		valueLabel.BackgroundTransparency = 1
		valueLabel.Text = tostring(defaultVal)
		valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		valueLabel.Font = Enum.Font.GothamBold
		valueLabel.TextSize = 11
		valueLabel.TextXAlignment = Enum.TextXAlignment.Right
		valueLabel.Parent = group

		local currentValue = defaultVal
		local function updateVisual()
			local fraction = (currentValue - minVal) / (maxVal - minVal)
			fill.Size = UDim2.new(fraction, 0, 1, 0)
			thumb.Position = UDim2.new(fraction, 0, 0.5, 0)
			valueLabel.Text = tostring(currentValue)
		end
		updateVisual()

		local dragCallback = nil
		local sliderDragging = false
		local sliderDragConnChanged, sliderDragConnEnded

		sliderButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				sliderDragging = true
				local trackWidth = track.AbsoluteSize.X
				if trackWidth > 0 then
					local relativeX = input.Position.X - track.AbsolutePosition.X
					local fraction = math.clamp(relativeX / trackWidth, 0, 1)
					currentValue = math.clamp(math.floor(minVal + fraction * (maxVal - minVal) + 0.5), minVal, maxVal)
					updateVisual()
					if dragCallback then dragCallback(currentValue) end
				end
				sliderDragConnChanged = UserInputService.InputChanged:Connect(function(inputChanged)
					if sliderDragging and (inputChanged.UserInputType == Enum.UserInputType.MouseMovement or inputChanged.UserInputType == Enum.UserInputType.Touch) then
						local trackWidth = track.AbsoluteSize.X
						if trackWidth > 0 then
							local relativeX = inputChanged.Position.X - track.AbsolutePosition.X
							local fraction = math.clamp(relativeX / trackWidth, 0, 1)
							currentValue = math.clamp(math.floor(minVal + fraction * (maxVal - minVal) + 0.5), minVal, maxVal)
							updateVisual()
							if dragCallback then dragCallback(currentValue) end
						end
					end
				end)
				sliderDragConnEnded = UserInputService.InputEnded:Connect(function(inputEnded)
					if inputEnded.UserInputType == Enum.UserInputType.MouseButton1 or inputEnded.UserInputType == Enum.UserInputType.Touch then
						sliderDragging = false
						if sliderDragConnChanged then sliderDragConnChanged:Disconnect(); sliderDragConnChanged = nil end
						if sliderDragConnEnded then sliderDragConnEnded:Disconnect(); sliderDragConnEnded = nil end
					end
				end)
			end
		end)

		return {
			Group = group,
			GetValue = function() return currentValue end,
			SetValue = function(val) currentValue = val; updateVisual() end,
			OnDrag = function(callback) dragCallback = callback end
		}
	end

	local function createToggle(name, desc, positionY, parent)
		local group = Instance.new("Frame")
		group.Size = UDim2.new(1, 0, 0, 34)
		group.Position = UDim2.new(0, 0, 0, positionY)
		group.BackgroundTransparency = 1
		group.Parent = parent

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, -46, 0, 14)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = name
		nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		nameLabel.Font = Enum.Font.GothamSemibold
		nameLabel.TextSize = 12
		nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.Parent = group

		local descLabel = Instance.new("TextLabel")
		descLabel.Size = UDim2.new(1, -46, 0, 11)
		descLabel.Position = UDim2.new(0, 0, 0, 14)
		descLabel.BackgroundTransparency = 1
		descLabel.Text = desc
		descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		descLabel.Font = Enum.Font.Gotham
		descLabel.TextSize = 9
		descLabel.TextXAlignment = Enum.TextXAlignment.Left
		descLabel.Parent = group

		local toggleBox = Instance.new("Frame")
		toggleBox.Size = UDim2.new(0, 32, 0, 18)
		toggleBox.Position = UDim2.new(1, -38, 0, 7)
		toggleBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
		toggleBox.BorderSizePixel = 0
		Instance.new("UICorner", toggleBox).CornerRadius = UDim.new(0, 9)
		toggleBox.Parent = group

		local indicator = Instance.new("Frame")
		indicator.Size = UDim2.new(0, 12, 0, 12)
		indicator.Position = UDim2.new(0, 3, 0, 3)
		indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		indicator.BorderSizePixel = 0
		Instance.new("UICorner", indicator).CornerRadius = UDim.new(0, 6)
		indicator.Parent = toggleBox

		local toggleButton = Instance.new("TextButton")
		toggleButton.Size = UDim2.new(1, 0, 1, 0)
		toggleButton.BackgroundTransparency = 1
		toggleButton.Text = ""
		toggleButton.Parent = toggleBox

		local enabled = false
		local toggleCallback = nil
		local function updateVisual()
			if enabled then
				toggleBox.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
				indicator.Position = UDim2.new(1, -15, 0, 3)
			else
				toggleBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
				indicator.Position = UDim2.new(0, 3, 0, 3)
			end
		end
		updateVisual()

		toggleButton.MouseButton1Click:Connect(function()
			enabled = not enabled
			updateVisual()
			if toggleCallback then toggleCallback(enabled) end
		end)

		return {
			Group = group,
			IsEnabled = function() return enabled end,
			SetEnabled = function(val) enabled = val; updateVisual() end,
			OnToggle = function(callback) toggleCallback = callback end
		}
	end

	-- Speed
	local speedSlider = createSlider("Speed Changer", "Скорость бега (16-150)", 16, 150, 16, 0, scrollingFrame)
	speedSlider.OnDrag(function(val)
		currentSpeed = val
		local char = player.Character
		if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = val end
		if flyToggle.IsEnabled() then flyToggle.SetEnabled(false) stopFly() end
	end)

	-- Jump
	local jumpSlider = createSlider("Jump Power", "Высота прыжка (1-999)", 1, 999, 50, 40, scrollingFrame)
	jumpSlider.OnDrag(function(val)
		currentJump = val
		local char = player.Character
		if char and char:FindFirstChild("Humanoid") then
			char.Humanoid.UseJumpPower = true
			char.Humanoid.JumpPower = val
		end
	end)

	-- Fly
	local flyGroup = Instance.new("Frame")
	flyGroup.Size = UDim2.new(1, 0, 0, 74)
	flyGroup.Position = UDim2.new(0, 0, 0, 80)
	flyGroup.BackgroundTransparency = 1
	flyGroup.Parent = scrollingFrame

	local flyToggle = createToggle("Fly", "WASD/Space/Shift или кнопки", 0, flyGroup)
	local flySpeedSlider = createSlider("Fly Speed", "Скорость (0-9999)", 0, 9999, 50, 34, flyGroup)

	flyToggle.OnToggle(function(on)
		flyEnabled = on
		if on then startFly() else stopFly() end
	end)
	flySpeedSlider.OnDrag(function(val) flySpeed = val end)

	-- Noclip
	local noclipToggle = createToggle("Noclip", "Прохождение сквозь стены", 154, scrollingFrame)
	local noclipEnabled = false
	noclipToggle.OnToggle(function(on)
		noclipEnabled = on
		local char = player.Character
		if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = not on end end end
		if on and not flyToggle.IsEnabled() then flyToggle.SetEnabled(true) startFly() end
	end)

	-- ESP (исправлен через ScreenGui)
	local espToggle = createToggle("ESP", "Отображение игроков через стены", 188, scrollingFrame)
	local espEnabled = false
	local espFrames = {}

	local function createESPFrame(targetPlayer)
		local frame = Instance.new("Frame")
		frame.Name = "ESP_" .. targetPlayer.Name
		frame.Size = UDim2.new(0, 100, 0, 100)
		frame.Position = UDim2.new(0, 0, 0, 0)
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.Visible = false
		frame.Parent = screenGui

		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(233, 69, 96)
		stroke.Thickness = 2
		stroke.Parent = frame

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, 0, 0, 20)
		nameLabel.Position = UDim2.new(0, 0, -1, -20)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = targetPlayer.Name
		nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.TextSize = 12
		nameLabel.TextStrokeTransparency = 0
		nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		nameLabel.Parent = frame

		espFrames[targetPlayer] = { frame = frame, nameLabel = nameLabel }
	end

	local function removeESPFrame(targetPlayer)
		local data = espFrames[targetPlayer]
		if data then
			data.frame:Destroy()
			espFrames[targetPlayer] = nil
		end
	end

	local function updateESPFrame(targetPlayer)
		local data = espFrames[targetPlayer]
		if not data then return end
		local character = targetPlayer.Character
		if not character then data.frame.Visible = false return end
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		local head = character:FindFirstChild("Head")
		local humanoid = character:FindFirstChild("Humanoid")
		if not (rootPart and head and humanoid and humanoid.Health > 0) then
			data.frame.Visible = false
			return
		end
		local screenPosRoot, onScreenRoot = Camera:WorldToViewportPoint(rootPart.Position)
		local screenPosHead, onScreenHead = Camera:WorldToViewportPoint(head.Position)
		if not (onScreenRoot and onScreenHead and screenPosRoot.Z > 0 and screenPosHead.Z > 0) then
			data.frame.Visible = false
			return
		end
		local height = math.abs(screenPosRoot.Y - screenPosHead.Y)
		local width = height * 0.6
		if width < 40 then width = 40 end
		if height < 40 then height = 40 end
		local framePos = Vector2.new(screenPosHead.X - width/2, screenPosHead.Y - height)
		data.frame.Position = UDim2.new(0, framePos.X, 0, framePos.Y)
		data.frame.Size = UDim2.new(0, width, 0, height)
		data.frame.Visible = true
		data.nameLabel.Text = targetPlayer.Name
	end

	local espConnection = nil
	espToggle.OnToggle(function(on)
		espEnabled = on
		if on then
			for _, p in ipairs(game.Players:GetPlayers()) do
				if p ~= player then createESPFrame(p) end
			end
			game.Players.PlayerAdded:Connect(function(p) if p ~= player then createESPFrame(p) end end)
			game.Players.PlayerRemoving:Connect(function(p) removeESPFrame(p) end)
			if espConnection then espConnection:Disconnect() end
			espConnection = RunService.Heartbeat:Connect(function()
				for targetPlayer, _ in pairs(espFrames) do updateESPFrame(targetPlayer) end
			end)
		else
			if espConnection then espConnection:Disconnect(); espConnection = nil end
			for targetPlayer, data in pairs(espFrames) do data.frame:Destroy() end
			espFrames = {}
		end
	end)

	-- Freeze Player
	local freezeToggle = createToggle("Freeze Player", "Заморозить/разморозить персонажа", 222, scrollingFrame)
	local freezeEnabled = false
	freezeToggle.OnToggle(function(on)
		freezeEnabled = on
		local char = player.Character
		if char then
			local root = char:FindFirstChild("HumanoidRootPart")
			if root then
				if on then
					if flyEnabled then flyToggle.SetEnabled(false) stopFly() end
					root.Anchored = true
					root.Velocity = Vector3.zero
				else
					root.Anchored = false
				end
			end
		end
	end)

	-- Teleport to Player (список в Main)
	local teleportSection = Instance.new("Frame")
	teleportSection.Size = UDim2.new(1, 0, 0, 90)
	teleportSection.Position = UDim2.new(0, 0, 0, 256)
	teleportSection.BackgroundTransparency = 1
	teleportSection.Parent = scrollingFrame

	local teleportTitle = Instance.new("TextLabel")
	teleportTitle.Size = UDim2.new(1, 0, 0, 14)
	teleportTitle.BackgroundTransparency = 1
	teleportTitle.Text = "Teleport to Player"
	teleportTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	teleportTitle.Font = Enum.Font.GothamSemibold
	teleportTitle.TextSize = 12
	teleportTitle.TextXAlignment = Enum.TextXAlignment.Left
	teleportTitle.Parent = teleportSection

	local playersList = Instance.new("ScrollingFrame")
	playersList.Size = UDim2.new(1, 0, 0, 72)
	playersList.Position = UDim2.new(0, 0, 0, 16)
	playersList.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
	playersList.BorderSizePixel = 0
	playersList.ScrollBarThickness = 2
	playersList.ScrollBarImageColor3 = Color3.fromRGB(233, 69, 96)
	Instance.new("UICorner", playersList).CornerRadius = UDim.new(0, 4)
	playersList.Parent = teleportSection

	local function createPlayerButton(name)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, -4, 0, 22)
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
		btn.BorderSizePixel = 0
		btn.Text = name
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 11
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
		btn.MouseButton1Click:Connect(function()
			local tp = game.Players:FindFirstChild(name)
			if tp and tp.Character and tp.Character:FindFirstChild("HumanoidRootPart") then
				local mc = player.Character
				if mc and mc:FindFirstChild("HumanoidRootPart") then
					mc:SetPrimaryPartCFrame(tp.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0))
				end
			end
		end)
		return btn
	end

	local function refreshPlayerList()
		for _, c in ipairs(playersList:GetChildren()) do
			if c:IsA("TextButton") or c:IsA("UIListLayout") then c:Destroy() end
		end
		local layout = Instance.new("UIListLayout")
		layout.Padding = UDim.new(0, 2)
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		layout.SortOrder = Enum.SortOrder.Name
		layout.Parent = playersList
		local players = game.Players:GetPlayers()
		table.sort(players, function(a, b) return a.Name < b.Name end)
		local cnt = 0
		for _, p in ipairs(players) do
			if p ~= player then
				createPlayerButton(p.Name).Parent = playersList
				cnt = cnt + 1
			end
		end
		playersList.CanvasSize = UDim2.new(0, 0, 0, cnt * 24 + 6)
	end
	refreshPlayerList()
	game.Players.PlayerAdded:Connect(function(p) if p ~= player then refreshPlayerList() end end)
	game.Players.PlayerRemoving:Connect(function(p) refreshPlayerList() end)

	scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, teleportSection.Position.Y.Offset + teleportSection.Size.Y.Offset + 10)

	-- Destroy кнопка
	local destroyButton = Instance.new("TextButton")
	destroyButton.Size = UDim2.new(0, 120, 0, 28)
	destroyButton.Position = UDim2.new(0.5, -60, 1, -34)
	destroyButton.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
	destroyButton.BorderSizePixel = 0
	destroyButton.Text = "Destroy GUI"
	destroyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	destroyButton.Font = Enum.Font.GothamBold
	destroyButton.TextSize = 13
	Instance.new("UICorner", destroyButton).CornerRadius = UDim.new(0, 6)
	destroyButton.Parent = mainFrame
	destroyButton.MouseButton1Click:Connect(function()
		screenGui:Destroy()
	end)

	-- Сворачивание (с сохранением вкладки)
	local isMinimized = false
	minimizeButton.MouseButton1Click:Connect(function()
		if not isMinimized then
			isMinimized = true
			minimizeButton.Text = "+"
			tabBar.Visible = false
			mainTabContent.Visible = false
			soonTabContent.Visible = false
			teleportTabContent.Visible = false
			dragBottom.Visible = false
			dragLeft.Visible = false
			dragRight.Visible = false
			destroyButton.Visible = false
			local minimizeTween = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 380, 0, 36)
			})
			minimizeTween:Play()
		else
			isMinimized = false
			minimizeButton.Text = "—"
			tabBar.Visible = true
			dragBottom.Visible = true
			dragLeft.Visible = true
			dragRight.Visible = true
			destroyButton.Visible = true
			showTab(currentTab)  -- восстанавливаем текущую вкладку
			local expandTween = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 380, 0, 400)
			})
			expandTween:Play()
		end
	end)

	-- Анимация открытия
	local openTween = TweenService:Create(mainFrame, TweenInfo.new(tweenTime, tweenStyle, tweenDirection), {
		Size = UDim2.new(0, 380, 0, 400),
		Position = UDim2.new(0.5, -190, 0.5, -200),
		BackgroundTransparency = 0
	})
	mainFrame.Size = UDim2.new(0, 0, 0, 0)
	mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	mainFrame.BackgroundTransparency = 1
	mainFrame.Visible = true
	openTween:Play()

	local function toggleMenu()
		if mainFrame.Visible then
			local closeTween = TweenService:Create(mainFrame, TweenInfo.new(tweenTime, tweenStyle, tweenDirection), {
				Size = UDim2.new(0, 0, 0, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BackgroundTransparency = 1
			})
			closeTween:Play()
			closeTween.Completed:Connect(function() mainFrame.Visible = false end)
		else
			mainFrame.Visible = true
			local reOpen = TweenService:Create(mainFrame, TweenInfo.new(tweenTime, tweenStyle, tweenDirection), {
				Size = UDim2.new(0, 380, 0, 400),
				Position = UDim2.new(0.5, -190, 0.5, -200),
				BackgroundTransparency = 0
			})
			reOpen:Play()
		end
	end
	UserInputService.InputBegan:Connect(function(input, gpe)
		if input.KeyCode == Enum.KeyCode.Insert and not gpe then
			toggleMenu()
		end
	end)

	player.CharacterAdded:Connect(function(char)
		local hum = char:WaitForChild("Humanoid")
		if hum then
			hum.WalkSpeed = currentSpeed
			hum.UseJumpPower = true
			hum.JumpPower = currentJump
		end
		if noclipEnabled then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
		if flyEnabled then stopFly(); flyEnabled = true; startFly() end
		if freezeEnabled then
			local root = char:FindFirstChild("HumanoidRootPart")
			if root then root.Anchored = true; root.Velocity = Vector3.zero end
		end
	end)

	if player.Character then
		local char = player.Character
		local hum = char:FindFirstChild("Humanoid")
		if hum then hum.WalkSpeed = currentSpeed; hum.UseJumpPower = true; hum.JumpPower = currentJump end
		if freezeEnabled then
			local root = char:FindFirstChild("HumanoidRootPart")
			if root then root.Anchored = true; root.Velocity = Vector3.zero end
		end
	end

	-- Функции Fly (с кнопками)
	function createMobileControls()
		btnForward = Instance.new("TextButton")
		btnForward.Size = UDim2.new(0, 60, 0, 60)
		btnForward.Position = UDim2.new(0, 20, 1, -140)
		btnForward.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
		btnForward.BackgroundTransparency = 0.4
		btnForward.BorderSizePixel = 0
		btnForward.Text = "W"
		btnForward.TextColor3 = Color3.fromRGB(255, 255, 255)
		btnForward.Font = Enum.Font.GothamBold
		btnForward.TextSize = 20
		Instance.new("UICorner", btnForward).CornerRadius = UDim.new(0, 30)
		btnForward.Parent = screenGui

		btnBackward = Instance.new("TextButton")
		btnBackward.Size = UDim2.new(0, 60, 0, 60)
		btnBackward.Position = UDim2.new(0, 90, 1, -140)
		btnBackward.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
		btnBackward.BackgroundTransparency = 0.4
		btnBackward.BorderSizePixel = 0
		btnBackward.Text = "S"
		btnBackward.TextColor3 = Color3.fromRGB(255, 255, 255)
		btnBackward.Font = Enum.Font.GothamBold
		btnBackward.TextSize = 20
		Instance.new("UICorner", btnBackward).CornerRadius = UDim.new(0, 30)
		btnBackward.Parent = screenGui

		btnUp = Instance.new("TextButton")
		btnUp.Size = UDim2.new(0, 60, 0, 60)
		btnUp.Position = UDim2.new(1, -90, 1, -140)
		btnUp.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
		btnUp.BackgroundTransparency = 0.4
		btnUp.BorderSizePixel = 0
		btnUp.Text = "UP"
		btnUp.TextColor3 = Color3.fromRGB(255, 255, 255)
		btnUp.Font = Enum.Font.GothamBold
		btnUp.TextSize = 16
		Instance.new("UICorner", btnUp).CornerRadius = UDim.new(0, 30)
		btnUp.Parent = screenGui

		btnDown = Instance.new("TextButton")
		btnDown.Size = UDim2.new(0, 60, 0, 60)
		btnDown.Position = UDim2.new(1, -160, 1, -140)
		btnDown.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
		btnDown.BackgroundTransparency = 0.4
		btnDown.BorderSizePixel = 0
		btnDown.Text = "DN"
		btnDown.TextColor3 = Color3.fromRGB(255, 255, 255)
		btnDown.Font = Enum.Font.GothamBold
		btnDown.TextSize = 16
		Instance.new("UICorner", btnDown).CornerRadius = UDim.new(0, 30)
		btnDown.Parent = screenGui

		btnForward.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then forwardPressed = true end
		end)
		btnForward.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then forwardPressed = false end
		end)
		btnBackward.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then backwardPressed = true end
		end)
		btnBackward.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then backwardPressed = false end
		end)
		btnUp.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then upPressed = true end
		end)
		btnUp.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then upPressed = false end
		end)
		btnDown.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then downPressed = true end
		end)
		btnDown.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then downPressed = false end
		end)

		btnForward.Visible = false
		btnBackward.Visible = false
		btnUp.Visible = false
		btnDown.Visible = false
	end

	function createFlyParts(char)
		local root = char:WaitForChild("HumanoidRootPart")
		if bodyVelocity then bodyVelocity:Destroy() end
		if bodyGyro then bodyGyro:Destroy() end
		bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bodyVelocity.Velocity = Vector3.zero
		bodyVelocity.Parent = root
		bodyGyro = Instance.new("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
		bodyGyro.CFrame = root.CFrame
		bodyGyro.Parent = root
	end

	function startFly()
		if flyConnection then return end
		createMobileControls()
		local char = player.Character
		if char then createFlyParts(char) end
		btnForward.Visible = true
		btnBackward.Visible = true
		btnUp.Visible = true
		btnDown.Visible = true

		flyConnection = RunService.Heartbeat:Connect(function()
			if not flyEnabled then return end
			local char = player.Character
			if not char then return end
			local root = char:FindFirstChild("HumanoidRootPart")
			if not root then return end
			if not bodyVelocity or not bodyVelocity.Parent then createFlyParts(char) end
			if not bodyGyro or not bodyGyro.Parent then createFlyParts(char) end

			local moveDir = Vector3.zero
			local cam = Camera.CFrame

			if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then moveDir -= Vector3.new(0,1,0) end

			if forwardPressed then moveDir += cam.LookVector end
			if backwardPressed then moveDir -= cam.LookVector end
			if upPressed then moveDir += Vector3.new(0,1,0) end
			if downPressed then moveDir -= Vector3.new(0,1,0) end

			if bodyVelocity then
				bodyVelocity.Velocity = moveDir.Magnitude > 0 and moveDir.Unit * flySpeed or Vector3.zero
			end
			if bodyGyro then
				bodyGyro.CFrame = CFrame.lookAt(root.Position, root.Position + cam.LookVector)
			end
		end)
	end

	function stopFly()
		if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
		if bodyVelocity then bodyVelocity:Destroy(); bodyVelocity = nil end
		if bodyGyro then bodyGyro:Destroy(); bodyGyro = nil end
		local char = player.Character
		if char and char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end
		if btnForward then
			btnForward.Visible = false
			btnBackward.Visible = false
			btnUp.Visible = false
			btnDown.Visible = false
			forwardPressed = false
			backwardPressed = false
			upPressed = false
			downPressed = false
		end
	end
end -- конец createMainMenu
