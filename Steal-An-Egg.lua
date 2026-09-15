local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

print("Anti-Lag: Initializing optimization process...")

pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.QualityLevel.Level01
    
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").FogEnd = 999999
end)

task.spawn(function()
    while true do
        task.wait(30)
        
        collectgarbage("collect")
        
        local memoryUsage = Stats:GetTotalMemoryUsageMb()
        if memoryUsage > 1024 then
            warn("Anti-Lag: High memory usage detected: " .. math.round(memoryUsage) .. " MB")
        end
    end
end)

local targetFPS = 60
local frameInterval = 1 / targetFPS
local lastTick = tick()

RunService.Heartbeat:Connect(function()
    local currentTick = tick()
    local delta = currentTick - lastTick
    
    if delta < frameInterval then
        task.wait(frameInterval - delta)
    end
    lastTick = tick()
end)

print("Anti-Lag: Successfully activated!.")

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local TranslateButton = Instance.new("TextButton")
local TimerBar = Instance.new("Frame")
local UICornerMain = Instance.new("UICorner")
local UICornerClose = Instance.new("UICorner")
local UICornerTranslate = Instance.new("UICorner")

ScreenGui.Name = "PolsecNotification"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.1, -150)
MainFrame.Size = UDim2.new(0, 300, 0, 110)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BackgroundTransparency = 1

UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 15)
TitleLabel.Size = UDim2.new(0, 220, 0, 45)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "Enter Key: Trial"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.TextTransparency = 1

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -35, 0, 10)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.BackgroundTransparency = 1
CloseButton.TextTransparency = 1

UICornerClose.CornerRadius = UDim.new(0, 6)
UICornerClose.Parent = CloseButton

TranslateButton.Name = "TranslateButton"
TranslateButton.Parent = MainFrame
TranslateButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TranslateButton.BorderSizePixel = 0
TranslateButton.Position = UDim2.new(0, 15, 0, 70)
TranslateButton.Size = UDim2.new(0, 270, 0, 25)
TranslateButton.Font = Enum.Font.SourceSans
TranslateButton.Text = "Translate to Vietnamese"
TranslateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TranslateButton.TextSize = 14
TranslateButton.BackgroundTransparency = 1
TranslateButton.TextTransparency = 1

UICornerTranslate.CornerRadius = UDim.new(0, 6)
UICornerTranslate.Parent = TranslateButton

TimerBar.Name = "TimerBar"
TimerBar.Parent = MainFrame
TimerBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
TimerBar.BorderSizePixel = 0
TimerBar.Position = UDim2.new(0, 0, 1, -3)
TimerBar.Size = UDim2.new(1, 0, 0, 3)
TimerBar.BackgroundTransparency = 1

local tweenInfoOpen = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
TweenService:Create(MainFrame, tweenInfoOpen, {Position = UDim2.new(0.5, -150, 0.1, 0), BackgroundTransparency = 0}):Play()
TweenService:Create(TitleLabel, tweenInfoOpen, {TextTransparency = 0}):Play()
TweenService:Create(CloseButton, tweenInfoOpen, {BackgroundTransparency = 0, TextTransparency = 0}):Play()
TweenService:Create(TranslateButton, tweenInfoOpen, {BackgroundTransparency = 0, TextTransparency = 0}):Play()
TweenService:Create(TimerBar, tweenInfoOpen, {BackgroundTransparency = 0}):Play()

local function animateButton(button)
	local originalSize = button.Size
	local originalPos = button.Position
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	TweenService:Create(button, tweenInfo, {
		Size = originalSize - UDim2.new(0, 4, 0, 4),
		Position = originalPos + UDim2.new(0, 2, 0, 2)
	}):Play()
	
	task.wait(0.1)
	
	TweenService:Create(button, tweenInfo, {
		Size = originalSize,
		Position = originalPos
	}):Play()
end

CloseButton.MouseButton1Click:Connect(function()
	animateButton(CloseButton)
	
	local tweenInfoClose = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
	TweenService:Create(MainFrame, tweenInfoClose, {Position = UDim2.new(0.5, -150, 0.1, -150), BackgroundTransparency = 1}):Play()
	TweenService:Create(TitleLabel, tweenInfoClose, {TextTransparency = 1}):Play()
	TweenService:Create(CloseButton, tweenInfoClose, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
	TweenService:Create(TranslateButton, tweenInfoClose, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
	TweenService:Create(TimerBar, tweenInfoClose, {BackgroundTransparency = 1}):Play()
	
	task.wait(0.4)
	ScreenGui:Destroy()
	loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/6d8be5a3a0af4d09c15220ae592ae581216c5d3ace7c08add21b8b54c61319d6.lua"))()
end)

TranslateButton.MouseButton1Click:Connect(function()
	animateButton(TranslateButton)
end)
