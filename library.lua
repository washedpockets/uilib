-- Notification UI Library
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local lib = {}

function lib.Notify(titleText, bodyText, duration)
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

	-- Create GUI
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "ScreenGui"
	ScreenGui.Parent = playerGui

	local Noti = Instance.new("Frame")
	Noti.Name = "Noti"
	Noti.Size = UDim2.new(0, 263, 0, 80)
	Noti.Position = UDim2.new(1, 0, 0.8, 0) -- Start off-screen (right side)
	Noti.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	Noti.BorderSizePixel = 0
	Noti.Parent = ScreenGui

	Instance.new("UICorner", Noti)

	-- Bar background
	local TimeFrame_Background = Instance.new("Frame")
	TimeFrame_Background.Name = "TimeFrame_Background"
	TimeFrame_Background.Size = UDim2.new(0, 229, 0, 2)
	TimeFrame_Background.Position = UDim2.new(0.064, 0, 0.9, 0)
	TimeFrame_Background.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
	TimeFrame_Background.BorderSizePixel = 0
	TimeFrame_Background.Parent = Noti

	-- Progress bar
	local Bar = Instance.new("Frame")
	Bar.Name = "Bar"
	Bar.Size = UDim2.new(1, 0, 1, 0)
	Bar.AnchorPoint = Vector2.new(1, 0.5)
	Bar.Position = UDim2.new(1, 0, 0.5, 0)
	Bar.BackgroundColor3 = Color3.fromRGB(135, 119, 255)
	Bar.BorderSizePixel = 0
	Bar.Parent = TimeFrame_Background

	-- Title
	local Title = Instance.new("TextLabel")
	Title.Position = UDim2.new(0.0646388, 0, 0.075, 0)
	Title.Size = UDim2.new(0.3, 0, 0.3, 0)
	Title.BackgroundTransparency = 1
	Title.Text = titleText or "Notification"
	Title.TextColor3 = Color3.fromRGB(135, 119, 255)
	Title.TextSize = 14
	Title.FontFace = Font.new("rbxasset://fonts/families/Michroma.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Title.Parent = Noti

	-- Body text
	local Body = Instance.new("TextLabel")
	Body.Position = UDim2.new(0.511407, 0, 0.55, 0)
	Body.Size = UDim2.new(0.9, 0, 0.9, 0)
	Body.AnchorPoint = Vector2.new(0.5, 0.5)
	Body.BackgroundTransparency = 1
	Body.Text = bodyText or "Loading..."
	Body.TextColor3 = Color3.fromRGB(208, 208, 208)
	Body.TextSize = 13
	Body.TextWrapped = true
	Body.TextXAlignment = Enum.TextXAlignment.Left
	Body.FontFace = Font.new("rbxasset://fonts/families/Michroma.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Body.Parent = Noti

	-- Slide in animation
	local slideIn = TweenService:Create(Noti, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.77, 0, 0.800251, 0)
	})
	slideIn:Play()

	slideIn.Completed:Connect(function()
		-- Shrink bar
		duration = duration or 5
		local barTween = TweenService:Create(Bar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
			Size = UDim2.new(0, 0, 1, 0)
		})
		barTween:Play()

		barTween.Completed:Connect(function()
			-- Slide out
			local slideOut = TweenService:Create(Noti, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Position = UDim2.new(1, 0, 0.800251, 0)
			})
			slideOut:Play()

			slideOut.Completed:Connect(function()
				ScreenGui:Destroy()
			end)
		end)
	end)
end

return lib
