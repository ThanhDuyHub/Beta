local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local TranslateButton = Instance.new("TextButton")
local TimerBar = Instance.new("Frame")

ScreenGui.Name = "PolsecNotification"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.1, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 110)
MainFrame.Active = true
MainFrame.Draggable = true

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

TimerBar.Name = "TimerBar"
TimerBar.Parent = MainFrame
TimerBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
TimerBar.BorderSizePixel = 0
TimerBar.Position = UDim2.new(0, 0, 1, -3)
TimerBar.Size = UDim2.new(1, 0, 0, 3)

local function closeGui()
	ScreenGui:Destroy()
	loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/6d8be5a3a0af4d09c15220ae592ae581216c5d3ace7c08add21b8b54c61319d6.lua"))()
end

CloseButton.MouseButton1Click:Connect(closeGui)

TranslateButton.MouseButton1Click:Connect(function()
	if TranslateButton.Text == "Translate to Vietnamese" then
		TitleLabel.Text = "Nhập Mã: Trial"
		TranslateButton.Text = "Translate to English"
	else
		TitleLabel.Text = "Enter Key: Trial"
		TranslateButton.Text = "Translate to Vietnamese"
	end
end)

task.spawn(function()
	local duration = 15
	local startTime = tick()
	while tick() - startTime < duration do
		if not ScreenGui.Parent then return end
		local elapsed = tick() - startTime
		local alpha = 1 - (elapsed / duration)
		TimerBar.Size = UDim2.new(alpha, 0, 0, 3)
		task.wait(0.03)
	end
	if ScreenGui.Parent then
		closeGui()
	end
end)
