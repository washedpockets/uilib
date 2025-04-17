-- Notification UI Library
local TweenService = game:GetService("TweenService")

local NotificationLib = {}

function NotificationLib.Notify(titleText, messageText, duration)
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NotifyScreenGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = playerGui

    -- Shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Position = UDim2.new(1.095, 0, 0.83, 0)
    Shadow.Size = UDim2.new(0, 275, 0, 92)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.Parent = ScreenGui

    -- Main notification
    local Noti = Instance.new("Frame")
    Noti.Name = "Noti"
    Noti.Size = UDim2.new(0, 263, 0, 80)
    Noti.Position = UDim2.new(1, 0, 0.8, 0)
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

    -- Title text
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Position = UDim2.new(0.0646388, 0, 0.075, 0)
    TextLabel.Size = UDim2.new(0.3, 0, 0.3, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = titleText or "Notification"
    TextLabel.TextColor3 = Color3.fromRGB(135, 119, 255)
    TextLabel.TextSize = 14
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/Michroma.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextLabel.Parent = Noti

    -- Body text
    local TextLabel2 = Instance.new("TextLabel")
    TextLabel2.Position = UDim2.new(0.511407, 0, 0.55, 0)
    TextLabel2.Size = UDim2.new(0.9, 0, 0.9, 0)
    TextLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel2.BackgroundTransparency = 1
    TextLabel2.Text = messageText or "Default message"
    TextLabel2.TextColor3 = Color3.fromRGB(208, 208, 208)
    TextLabel2.TextSize = 13
    TextLabel2.TextWrapped = true
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel2.FontFace = Font.new("rbxasset://fonts/families/Michroma.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TextLabel2.Parent = Noti

    -- Slide in
    local slideIn = TweenService:Create(Noti, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.775, 0, 0.800251, 0)
    })
    local shadowIn = TweenService:Create(Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.78, 0, 0.83, 0)
    })

    slideIn:Play()
    shadowIn:Play()

    slideIn.Completed:Connect(function()
        local barTween = TweenService:Create(Bar, TweenInfo.new(duration or 5, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, 0, 1, 0)
        })
        barTween:Play()

        barTween.Completed:Connect(function()
            local slideOut = TweenService:Create(Noti, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 0, 0.800251, 0)
            })
            local shadowOut = TweenService:Create(Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = UDim2.new(1.095, 0, 0.83, 0)
            })
            slideOut:Play()
            shadowOut:Play()

            shadowOut.Completed:Connect(function()
                ScreenGui:Destroy()
            end)
        end)
    end)
end

return NotificationLib
