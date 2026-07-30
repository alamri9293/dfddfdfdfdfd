-- =========================================
-- السكربت الأول: تعديل قدرات الشخصية
-- =========================================

-- 1. طباعة رسالة في الكونسول للتأكد إن السكربت اشتغل
print("-----------------------------------")
print("تم تشغيل السكربت بنجاح!")
print("-----------------------------------")

-- 2. تحديد المتغيرات الأساسية (القيم اللي نبي نغيرها)
local mySpeed = 100    -- السرعة العادية في روبلوكس تكون 16
local myJump = 120     -- القفز العادي في روبلوكس يكون 50

-- 3. الوصول للاعب وشخصيته داخل اللعبة
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- 4. تطبيق التغييرات على الشخصية
humanoid.WalkSpeed = mySpeed
humanoid.JumpPower = myJump