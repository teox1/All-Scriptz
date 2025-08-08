local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local speed = 0
local active = false
local hrp = nil

local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

task.spawn(function()
    while true do
        if active then
            pcall(function()
                hrp = hrp or getHRP()
                hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * speed)
            end)
        end
        RunService.RenderStepped:Wait()
    end
end)

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "TeoxSpeedUI"

local Intro = Instance.new("TextLabel", ScreenGui)
Intro.Size = UDim2.new(0, 300, 0, 100)
Intro.Position = UDim2.new(0.5, -150, 0.4, 0)
Intro.Text = "made by teox"
Intro.Font = Enum.Font.GothamBlack
Intro.TextSize = 40
Intro.BackgroundTransparency = 1
Intro.TextStrokeTransparency = 0
Intro.TextStrokeColor3 = Color3.new(0, 0, 0)

task.spawn(function()
	while wait() do
		local t = tick() * 1.5
		local r = math.sin(t) * 0.5 + 0.5
		local g = math.sin(t + 2) * 0.5 + 0.5
		local b = math.sin(t + 4) * 0.5 + 0.5
		Intro.TextColor3 = Color3.new(r, g, b)
	end
end)

task.delay(1.5, function()
    Intro:Destroy()

    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 250, 0, 150)
    Frame.Position = UDim2.new(0, 50, 0, 50)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.BorderSizePixel = 0
    Frame.Active = true
    Frame.Draggable = true

    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = "Speed Hack"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 24

    local Slider = Instance.new("TextBox", Frame)
    Slider.Position = UDim2.new(0, 10, 0, 40)
    Slider.Size = UDim2.new(0, 230, 0, 30)
    Slider.PlaceholderText = "Enter speed (e.g. 50)"
    Slider.Text = ""
    Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
    Slider.Font = Enum.Font.SourceSans
    Slider.TextSize = 18

    local Toggle = Instance.new("TextButton", Frame)
    Toggle.Position = UDim2.new(0, 10, 0, 80)
    Toggle.Size = UDim2.new(0, 230, 0, 40)
    Toggle.Text = "Enable"
    Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Font = Enum.Font.SourceSansBold
    Toggle.TextSize = 20

    Toggle.MouseButton1Click:Connect(function()
        active = not active
        Toggle.Text = active and "Disable" or "Enable"
    end)

    Slider.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local val = tonumber(Slider.Text)
            if val then
                speed = val
            end
        end
    end)
end)
