-- =========================================
-- قائمة تحكم خفيفة ومصممة للجوال والكمبيوتر
-- =========================================

-- إزالة أي قائمة قديمة لو كانت مفتوحة لمنع التكرار
if game.CoreGui:FindFirstChild("MyCustomMenu") then
    game.CoreGui.MyCustomMenu:Destroy()
end

-- 1. إنشاء الواجهة الرئيسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyCustomMenu"
ScreenGui.Parent = game.CoreGui

-- 2. زر عائم لفتح/إغلاق القائمة (متحرك ومناسب للجوال)
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
OpenBtn.Draggable = true -- يمكنك سحبه بأصبعك في أي مكان بالمراد

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 8)
openCorner.Parent = OpenBtn

-- 3. نافذة التحكم الرئيسية
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 260, 0, 200)
MainFrame.Position = UDim2.new(0.5, -130, 0.4, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Active = true
MainFrame.Draggable = true -- يمكنك سحب النافذة نفسها
MainFrame.Visible = true

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = MainFrame

-- عنوان النافذة
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

-- زر الإغلاق (X)
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

-- -----------------------------------------
-- قسم السرعة (WalkSpeed)
-- -----------------------------------------
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainFrame
SpeedLabel.Size = UDim2.new(1, -20, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0, 42)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "السرعة (WalkSpeed):"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.TextSize = 13
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedBox = Instance.new("TextBox")
SpeedBox.Parent = MainFrame
SpeedBox.Size = UDim2.new(1, -20, 0, 32)
SpeedBox.Position = UDim2.new(0, 10, 0, 64)
SpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SpeedBox.Text = "16"
SpeedBox.PlaceholderText = "اكتب رقم السرعة (مثلاً 100)"
SpeedBox.TextColor3 = Color3.fromRGB(0, 255, 150)
SpeedBox.TextSize = 14
SpeedBox.Font = Enum.Font.SourceSansBold

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 6)
speedCorner.Parent = SpeedBox

-- -----------------------------------------
-- قسم القفز (JumpPower)
-- -----------------------------------------
local JumpLabel = Instance.new("TextLabel")
JumpLabel.Parent = MainFrame
JumpLabel.Size = UDim2.new(1, -20, 0, 20)
JumpLabel.Position = UDim2.new(0, 10, 0, 105)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "قوة القفز (JumpPower):"
JumpLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpLabel.TextSize = 13
JumpLabel.Font = Enum.Font.SourceSans
JumpLabel.TextXAlignment = Enum.TextXAlignment.Left

local JumpBox = Instance.new("TextBox")
JumpBox.Parent = MainFrame
JumpBox.Size = UDim2.new(1, -20, 0, 32)
JumpBox.Position = UDim2.new(0, 10, 0, 127)
JumpBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
JumpBox.Text = "50"
JumpBox.PlaceholderText = "اكتب رقم القفز (مثلاً 150)"
JumpBox.TextColor3 = Color3.fromRGB(0, 200, 255)
JumpBox.TextSize = 14
JumpBox.Font = Enum.Font.SourceSansBold

local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(0, 6)
jumpCorner.Parent = JumpBox

-- -----------------------------------------
-- التفاعل والأوامر البرمجية
-- -----------------------------------------

-- تطبيق السرعة فور الانتهاء من الكتابة الضغط على Enter/تم
SpeedBox.FocusLost:Connect(function()
    local val = tonumber(SpeedBox.Text)
    if val then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = val
        end
    end
end)

-- تطبيق القفز فور الانتهاء من الكتابة
JumpBox.FocusLost:Connect(function()
    val = tonumber(JumpBox.Text)
    if val then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.UseJumpPower = true
            char.Humanoid.JumpPower = val
        end
    end
end)

-- فتح وإغلاق النافذة عند الضغط على الزر العائم أو زر X
OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)
