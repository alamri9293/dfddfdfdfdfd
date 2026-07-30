-- =========================================
-- قائمة تحكم خفيفة (تتضمن السرعة، القفز، والأوتو فارم)
-- =========================================

if game.CoreGui:FindFirstChild("MyCustomMenu") then
    game.CoreGui.MyCustomMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyCustomMenu"
ScreenGui.Parent = game.CoreGui

-- الزر العائم
local OpenBtn = Instance.new("TextButton")
OpenBtn.Name = "OpenButton"
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 75, 0, 35)
OpenBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
OpenBtn.Text = "🎮 MENU"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextSize = 13
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.Active = true
OpenBtn.Draggable = true

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 8)
openCorner.Parent = OpenBtn

-- النافذة الرئيسية (تم تكبير الطول ليتسع للزر الجديد)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 260, 0, 260) -- كبرنا الطول هنا
MainFrame.Position = UDim2.new(0.5, -130, 0.4, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -40, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "⚙️ قائمة التحكم"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -33, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = CloseBtn

-- قسم السرعة
local SpeedBox = Instance.new("TextBox")
SpeedBox.Parent = MainFrame
SpeedBox.Size = UDim2.new(1, -20, 0, 32)
SpeedBox.Position = UDim2.new(0, 10, 0, 50)
SpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SpeedBox.Text = "16"
SpeedBox.PlaceholderText = "السرعة"
SpeedBox.TextColor3 = Color3.fromRGB(0, 255, 150)
SpeedBox.TextSize = 14
SpeedBox.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 6)

-- قسم القفز
local JumpBox = Instance.new("TextBox")
JumpBox.Parent = MainFrame
JumpBox.Size = UDim2.new(1, -20, 0, 32)
JumpBox.Position = UDim2.new(0, 10, 0, 90)
JumpBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
JumpBox.Text = "50"
JumpBox.PlaceholderText = "قوة القفز"
JumpBox.TextColor3 = Color3.fromRGB(0, 200, 255)
JumpBox.TextSize = 14
JumpBox.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", JumpBox).CornerRadius = UDim.new(0, 6)

-- -----------------------------------------
-- الزر الجديد: التجميع التلقائي (Auto-Farm)
-- -----------------------------------------
local AutoFarmBtn = Instance.new("TextButton")
AutoFarmBtn.Parent = MainFrame
AutoFarmBtn.Size = UDim2.new(1, -20, 0, 40)
AutoFarmBtn.Position = UDim2.new(0, 10, 0, 140)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- لون أحمر (طافي)
AutoFarmBtn.Text = "تجميع الفلوس: طافي ❌"
AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmBtn.TextSize = 15
AutoFarmBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", AutoFarmBtn).CornerRadius = UDim.new(0, 6)


-- -----------------------------------------
-- الأوامر البرمجية
-- -----------------------------------------

-- تفعيل السرعة
SpeedBox.FocusLost:Connect(function()
    local val = tonumber(SpeedBox.Text)
    if val then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = val
        end
    end
end)

-- تفعيل القفز
JumpBox.FocusLost:Connect(function()
    local val = tonumber(JumpBox.Text)
    if val then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.UseJumpPower = true
            char.Humanoid.JumpPower = val
        end
    end
end)

-- أوامر زر الأوتو فارم
local autoFarmEnabled = false

AutoFarmBtn.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled -- يعكس الحالة
    
    if autoFarmEnabled then
        AutoFarmBtn.Text = "تجميع الفلوس: شغال ✅"
        AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- لون أخضر
        
        -- اللوب اللي يشتغل في الخلفية ويجمع كل ثانية
        task.spawn(function()
            while autoFarmEnabled do
                task.wait(1) -- ينتظر ثانية عشان ما يعلق السيرفر
                
                -- ===================================================
                -- هنا تضع كود الـ RemoteEvent الخاص بالماب الذي يجمع الفلوس
                -- مثال (احذفه وضع كود الماب الحقيقي بدله لاحقاً):
                -- game:GetService("ReplicatedStorage").Events.Collect:FireServer()
                -- ===================================================
                
            end
        end)
    else
        AutoFarmBtn.Text = "تجميع الفلوس: طافي ❌"
        AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- يرجع أحمر
    end
end)

-- فتح وإغلاق النافذة
OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)
