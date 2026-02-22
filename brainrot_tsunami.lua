--[[
╔═══════════════════════════════════════════════════════════════════════╗
║         BRAINROT LASER GHOST V6 - REAL STEAL A BRAINROT              ║
║                                                                       ║
║     ✓ Laser Ghost - Tembus laser & masuk ruangan orang               ║
║     ✓ No Bounce - Brainrot ga mental kalo dipukul                    ║
║     ✓ Base Shield - Base auto kebal                                   ║
║     ✓ Player Teleport - TP ke player manapun                         ║
║     ✓ Smooth UI + Real Features                                      ║
╚═══════════════════════════════════════════════════════════════════════╝
]]

-- ==================== INIT (WAJIB) ====================
local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local coreGui = game:GetService("CoreGui")
local replicatedStorage = game:GetService("ReplicatedStorage")
local virtualUser = game:GetService("VirtualUser")

-- Anti-kick (biar ga di kick server)
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
local oldIndex = mt.__index
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "kick" then
        return warn("[ANTI-KICK] Server kick blocked")
    end
    return oldNamecall(self, ...)
end)

mt.__index = newcclosure(function(self, key)
    if self == player and key == "Kick" then
        return function() return warn("[ANTI-KICK] Blocked") end
    end
    return oldIndex(self, key)
end)
setreadonly(mt, true)

-- ==================== GUI SETUP ====================
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotV6"
gui.Parent = coreGui
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999999
gui.IgnoreGuiInset = true

-- Detect mobile
local isMobile = userInput.TouchEnabled and not userInput.MouseEnabled
local uiScale = isMobile and 0.75 or 1

-- ==================== MAIN FRAME ====================
local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.new(0, 280 * uiScale, 0, 400 * uiScale)
main.Position = UDim2.new(0.5, -140 * uiScale, 0.5, -200 * uiScale)
main.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
main.BackgroundTransparency = 0.1
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Active = true
main.Parent = gui

-- Shadow
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1.1, 0, 1.1, 0)
shadow.Position = UDim2.new(-0.05, 0, -0.05, 0)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.Parent = main

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12 * uiScale)
corner.Parent = main

-- ==================== HEADER ====================
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40 * uiScale)
header.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12 * uiScale)
headerCorner.Parent = header

-- Gradient
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
})
gradient.Rotation = 90
gradient.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🧠 BRAINROT V6"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Minimize circle
local circle = Instance.new("ImageButton")
circle.Name = "Circle"
circle.Size = UDim2.new(0, 45 * uiScale, 0, 45 * uiScale)
circle.Position = UDim2.new(1, -55 * uiScale, 1, -55 * uiScale)
circle.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
circle.BackgroundTransparency = 0.2
circle.Image = "rbxassetid://3570695787"
circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
circle.ScaleType = Enum.ScaleType.Fit
circle.BorderSizePixel = 0
circle.Visible = false
circle.Parent = gui
circle.Active = true
circle.Draggable = true

-- Circle icon
local circleIcon = Instance.new("TextLabel")
circleIcon.Size = UDim2.new(1, 0, 1, 0)
circleIcon.BackgroundTransparency = 1
circleIcon.Text = "🧠"
circleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
circleIcon.TextScaled = true
circleIcon.Font = Enum.Font.GothamBold
circleIcon.Parent = circle

-- Minimize button
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 25 * uiScale, 0, 25 * uiScale)
miniBtn.Position = UDim2.new(1, -55 * uiScale, 0, 7 * uiScale)
miniBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
miniBtn.Text = "⏺"
miniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBtn.TextScaled = true
miniBtn.Font = Enum.Font.GothamBold
miniBtn.BorderSizePixel = 0
miniBtn.Parent = header

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 6 * uiScale)
miniCorner.Parent = miniBtn

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25 * uiScale, 0, 25 * uiScale)
closeBtn.Position = UDim2.new(1, -25 * uiScale, 0, 7 * uiScale)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6 * uiScale)
closeCorner.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Minimize function
miniBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    circle.Visible = true
    circle.Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset + main.AbsoluteSize.X/2, 
                               main.Position.Y.Scale, main.Position.Y.Offset - 20)
end)

circle.MouseButton1Click:Connect(function()
    circle.Visible = false
    main.Visible = true
    main.Size = UDim2.new(0, 0, 0, 0)
    tweenService:Create(main, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 280 * uiScale, 0, 400 * uiScale)
    }):Play()
end)

-- Drag function
local dragging = false
local dragStart, startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

userInput.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- ==================== TABS ====================
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, 35 * uiScale)
tabFrame.Position = UDim2.new(0, 0, 0, 45 * uiScale)
tabFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
tabFrame.BackgroundTransparency = 0.5
tabFrame.BorderSizePixel = 0
tabFrame.Parent = main

local tabs = {"👻 GHOST", "🛡️ SHIELD", "👥 TP", "⚙️ EXTRA"}
local tabBtns = {}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25, -2, 1, -8)
    btn.Position = UDim2.new((i-1) * 0.25, i == 1 and 2 or (i == 2 and 1 or (i == 3 and 0 or -1)), 0, 4)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = tabFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6 * uiScale)
    btnCorner.Parent = btn
    
    table.insert(tabBtns, btn)
end

-- ==================== CONTENT ====================
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -10, 0, 290 * uiScale)
content.Position = UDim2.new(0, 5, 0, 90 * uiScale)
content.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
content.BackgroundTransparency = 0.5
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 100)
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.Parent = main

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 8 * uiScale)
contentCorner.Parent = content

-- ==================== FITUR REAL ====================

-- 1. LASER GHOST (TEMBUS LASER & MASUK RUANGAN)
local laserGhost = false
local ghostConnection
local originalCanCollide = {}

function toggleLaserGhost(state)
    laserGhost = state
    
    if ghostConnection then ghostConnection:Disconnect() end
    
    if laserGhost then
        ghostConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                local char = player.Character
                if not char then return end
                
                -- Set semua part character jadi no collide (tembus)
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if not originalCanCollide[part] then
                            originalCanCollide[part] = part.CanCollide
                        end
                        part.CanCollide = false
                        -- Efek transparan dikit biar keliatan keren
                        part.Transparency = math.min(part.Transparency + 0.2, 0.5)
                    end
                end
                
                -- MATIKAN SEMUA LASER & HAZARD DI MAP
                for _, obj in ipairs(workspace:GetDescendants()) do
                    -- Laser detection (berdasarkan nama umum)
                    if obj:IsA("Part") and (
                        obj.Name:lower():find("laser") or 
                        obj.Name:lower():find("beam") or 
                        obj.Name:lower():find("hazard") or
                        obj.Name:lower():find("kill") or
                        obj.Name:lower():find("death") or
                        obj.Name:lower():find("lava") or
                        obj.Name:lower():find("acid") or
                        obj:FindFirstChild("TouchInterest")
                    ) then
                        -- Hapus TouchInterest biar ga kena damage
                        if obj:FindFirstChild("TouchInterest") then
                            obj.TouchInterest:Destroy()
                        end
                        -- Hapus juga kalo ada ClickDetector yang berbahaya
                        if obj:FindFirstChild("ClickDetector") then
                            obj.ClickDetector:Destroy()
                        end
                        -- Opsional: bikin transparan
                        obj.Transparency = 0.5
                    end
                    
                    -- Cari "walls" yang ngehalang masuk ruangan orang
                    if obj:IsA("Part") and (
                        obj.Name:lower():find("wall") or 
                        obj.Name:lower():find("door") or 
                        obj.Name:lower():find("gate") or
                        obj.Name:lower():find("barrier")
                    ) then
                        -- Bikin no collide juga biar bisa tembus
                        obj.CanCollide = false
                        obj.Transparency = 0.3
                    end
                end
            end)
        end)
    else
        -- Restore collisions
        pcall(function()
            local char = player.Character
            if char then
                for part, canCollide in pairs(originalCanCollide) do
                    if part and part.Parent then
                        part.CanCollide = canCollide
                        part.Transparency = 0
                    end
                end
            end
        end)
        originalCanCollide = {}
    end
end

-- 2. NO BOUNCE (BRAINROT GA MENTAL)
local noBounce = false
local bounceConnection

function toggleNoBounce(state)
    noBounce = state
    
    if bounceConnection then bounceConnection:Disconnect() end
    
    if noBounce then
        bounceConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                -- Cari brainrot yang dipegang
                local heldBrainrot = nil
                
                -- Cek di tangan
                local char = player.Character
                if char then
                    for _, tool in ipairs(char:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name:lower():find("brainrot") then
                            heldBrainrot = tool
                            break
                        end
                    end
                end
                
                -- Kalo ga di tangan, cek di backpack
                if not heldBrainrot then
                    for _, tool in ipairs(player.Backpack:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name:lower():find("brainrot") then
                            heldBrainrot = tool
                            break
                        end
                    end
                end
                
                if heldBrainrot then
                    -- Force tetap di backpack dengan clone trick
                    if heldBrainrot.Parent ~= player.Backpack then
                        local clone = heldBrainrot:Clone()
                        clone.Parent = player.Backpack
                        heldBrainrot:Destroy()
                    end
                    
                    -- Block remote steal (otak-atik game)
                    for _, remote in ipairs(replicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") then
                            if remote.Name:lower():find("steal") or remote.Name:lower():find("take") or remote.Name:lower():find("remove") then
                                -- Kirim sinyal palsu biar server ngira aman
                                remote:FireServer("block_steal")
                            end
                        end
                    end
                end
            end)
        end)
    end
end

-- 3. BASE SHIELD (AUTO LOCK BASE)
local baseShield = false
local shieldConnection

function toggleBaseShield(state)
    baseShield = state
    
    if shieldConnection then shieldConnection:Disconnect() end
    
    if baseShield then
        shieldConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                -- Cari base player
                local baseParts = {}
                
                -- Deteksi base (biasanya spawn area)
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Part") and (
                        obj.Name:lower():find("base") or 
                        obj.Name:lower():find("spawn") or 
                        obj.Name:lower():find("house") or
                        obj.Name:lower():find("home")
                    ) then
                        table.insert(baseParts, obj)
                    end
                end
                
                for _, part in ipairs(baseParts) do
                    -- Hapus touch interest biar ga bisa diambil/dirusak
                    if part:FindFirstChild("TouchInterest") then
                        part.TouchInterest:Destroy()
                    end
                    
                    -- Buat forcefield biar aman
                    if not part:FindFirstChild("ForceField") then
                        local ff = Instance.new("ForceField")
                        ff.Visible = false
                        ff.Parent = part
                    end
                    
                    -- Set health kalo ada
                    if part:FindFirstChild("Health") and part.Health:IsA("NumberValue") then
                        part.Health.Value = 9e9
                    end
                end
            end)
        end)
    end
end

-- 4. PLAYER TELEPORT
function teleportToPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        notif("❌ Player not found", Color3.fromRGB(255, 0, 0))
        return
    end
    
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = targetPlayer.Character.HumanoidRootPart.Position
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 5, 0))
        notif("✅ Teleported to " .. targetPlayer.Name, Color3.fromRGB(0, 255, 0))
    end
end

-- 5. WALKSPEED BOOST
local speedBoost = false
local speedValue = 100
local speedConnection

function toggleSpeed(state)
    speedBoost = state
    
    if speedConnection then speedConnection:Disconnect() end
    
    if speedBoost then
        speedConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = speedValue
                end
            end)
        end)
    else
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = 16
            end
        end)
    end
end

-- 6. INFINITE JUMP
local infJump = false

userInput.JumpRequest:Connect(function()
    if infJump and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- NOTIFICATION
function notif(text, color)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.new(0, 180 * uiScale, 0, 35 * uiScale)
    n.Position = UDim2.new(0.5, -90 * uiScale, 0, 50 * uiScale)
    n.BackgroundColor3 = color or Color3.fromRGB(255, 50, 100)
    n.BackgroundTransparency = 0.2
    n.Text = text
    n.TextColor3 = Color3.fromRGB(255, 255, 255)
    n.TextScaled = true
    n.Font = Enum.Font.GothamBold
    n.BorderSizePixel = 0
    n.Parent = gui
    
    local nCorner = Instance.new("UICorner")
    nCorner.CornerRadius = UDim.new(0, 8 * uiScale)
    nCorner.Parent = n
    
    tweenService:Create(n, TweenInfo.new(2), {
        Position = UDim2.new(0.5, -90 * uiScale, 0, 20 * uiScale),
        BackgroundTransparency = 1,
        TextTransparency = 1
    }):Play()
    
    task.wait(2)
    pcall(function() n:Destroy() end)
end

-- ==================== UI BUILDER ====================
function createToggle(parent, y, text, desc, state, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -16, 0, 48 * uiScale)
    frame.Position = UDim2.new(0, 8, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8 * uiScale)
    frameCorner.Parent = frame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -70, 0, 22 * uiScale)
    titleLabel.Position = UDim2.new(0, 10, 0, 5 * uiScale)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = text
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextScaled = true
    titleLabel.Parent = frame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -70, 0, 15 * uiScale)
    descLabel.Position = UDim2.new(0, 10, 0, 27 * uiScale)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextScaled = true
    descLabel.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50 * uiScale, 0, 28 * uiScale)
    btn.Position = UDim2.new(1, -60 * uiScale, 0, 10 * uiScale)
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(80, 80, 80)
    btn.Text = state and "ON" or "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6 * uiScale)
    btnCorner.Parent = btn
    
    local btnState = state
    btn.MouseButton1Click:Connect(function()
        btnState = not btnState
        btn.BackgroundColor3 = btnState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(80, 80, 80)
        btn.Text = btnState and "ON" or "OFF"
        callback(btnState)
    end)
    
    return y + 56 * uiScale
end

function createPlayerList(parent, y)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -16, 0, 140 * uiScale)
    frame.Position = UDim2.new(0, 8, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8 * uiScale)
    frameCorner.Parent = frame
    
    local listLabel = Instance.new("TextLabel")
    listLabel.Size = UDim2.new(1, -10, 0, 22 * uiScale)
    listLabel.Position = UDim2.new(0, 5, 0, 5 * uiScale)
    listLabel.BackgroundTransparency = 1
    listLabel.Text = "👥 ONLINE PLAYERS:"
    listLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    listLabel.TextXAlignment = Enum.TextXAlignment.Left
    listLabel.Font = Enum.Font.GothamBold
    listLabel.TextScaled = true
    listLabel.Parent = frame
    
    local listScroll = Instance.new("ScrollingFrame")
    listScroll.Size = UDim2.new(1, -10, 0, 95 * uiScale)
    listScroll.Position = UDim2.new(0, 5, 0, 32 * uiScale)
    listScroll.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    listScroll.BackgroundTransparency = 0.5
    listScroll.BorderSizePixel = 0
    listScroll.ScrollBarThickness = 4
    listScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 100)
    listScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    listScroll.Parent = frame
    
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 6 * uiScale)
    listCorner.Parent = listScroll
    
    local listY = 5
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 30 * uiScale)
            btn.Position = UDim2.new(0, 5, 0, listY)
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            btn.Text = plr.Name .. " [TP]"
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextScaled = true
            btn.Font = Enum.Font.Gotham
            btn.BorderSizePixel = 0
            btn.Parent = listScroll
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 5 * uiScale)
            btnCorner.Parent = btn
            
            btn.MouseButton1Click:Connect(function()
                teleportToPlayer(plr)
            end)
            
            listY = listY + 35 * uiScale
        end
    end
    
    listScroll.CanvasSize = UDim2.new(0, 0, 0, listY + 10)
    return y + 150 * uiScale
end

function createLabel(parent, y, text, color)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 25 * uiScale)
    label.Position = UDim2.new(0, 10, 0, y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.Parent = parent
    
    return y + 30 * uiScale
end

-- ==================== TAB HANDLER ====================
function switchTab(index)
    for _, v in ipairs(content:GetChildren()) do
        v:Destroy()
    end
    
    local y = 8 * uiScale
    
    if index == 1 then -- GHOST TAB
        y = createToggle(content, y, "👻 LASER GHOST", "Tembus laser & masuk ruangan orang", laserGhost, function(state)
            toggleLaserGhost(state)
            notif(state and "Laser Ghost ON - Kamu bisa tembus!" or "Laser Ghost OFF", Color3.fromRGB(255, 100, 100))
        end)
        
        y = createToggle(content, y, "🔄 NO BOUNCE", "Brainrot ga mental kalo dipukul", noBounce, function(state)
            toggleNoBounce(state)
            notif(state and "No Bounce ON - Brainrot aman!" or "No Bounce OFF", Color3.fromRGB(255, 200, 0))
        end)
        
        y = createLabel(content, y, "⚡ ENABLE BOTH BIAR MAKSIMAL!", Color3.fromRGB(0, 255, 200))
        
    elseif index == 2 then -- SHIELD TAB
        y = createToggle(content, y, "🛡️ BASE SHIELD", "Base kamu auto kebal serangan", baseShield, function(state)
            toggleBaseShield(state)
            notif(state and "Base Shield ON - Aman!" or "Base Shield OFF", Color3.fromRGB(100, 100, 255))
        end)
        
    elseif index == 3 then -- TP TAB
        y = createPlayerList(content, y)
        
    elseif index == 4 then -- EXTRA TAB
        y = createToggle(content, y, "⚡ SPEED BOOST", "Jalan super cepat (x100)", speedBoost, function(state)
            toggleSpeed(state)
        end)
        
        y = createToggle(content, y, "🚀 INFINITE JUMP", "Lompat terus ga terbatas", infJump, function(state)
            infJump = state
            notif(state and "Infinite Jump ON" or "Infinite Jump OFF", Color3.fromRGB(0, 255, 200))
        end)
    end
    
    content.CanvasSize = UDim2.new(0, 0, 0, y + 20 * uiScale)
end

-- Tab switching
for i, btn in ipairs(tabBtns) do
    btn.MouseButton1Click:Connect(function()
        for _, b in ipairs(tabBtns) do
            b.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
        end
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        switchTab(i)
    end)
end

-- Initial tab
tabBtns[1].BackgroundColor3 = Color3.fromRGB(50, 50, 80)
switchTab(1)

-- Anti-AFK
spawn(function()
    while wait(45) do
        pcall(function()
            virtualUser:CaptureController()
            virtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

-- Welcome
notif("🧠 BRAINROT V6 LOADED", Color3.fromRGB(255, 50, 100))
