--[[
╔═══════════════════════════════════════════════════════════════════════╗
║         BRAINROT TSUNAMI HUB V4 - SUPER GOD EDITION                   ║
║              Ghost Mode + True God Mode + Premium Dupe                ║
║                    Dragable Circle + Mobile Optimized                 ║
╚═══════════════════════════════════════════════════════════════════════╝
]]

-- ==================== INITIAL SETUP ====================
local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local coreGui = game:GetService("CoreGui")
local replicatedStorage = game:GetService("ReplicatedStorage")
local virtualUser = game:GetService("VirtualUser")
local virtualInput = game:GetService("VirtualInputManager")
local marketplace = game:GetService("MarketplaceService")

-- Anti-kick ultimate
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
local oldIndex = mt.__index
local oldNewindex = mt.__newindex
setreadonly(mt, false)

-- Block kick and other dangerous functions
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    local blockedMethods = {
        Kick = true,
        Crash = true,
        Disconnect = true,
        Exit = true,
        Shutdown = true,
        ["kick"] = true,
        ["Kick"] = true,
    }
    
    if blockedMethods[method] then
        return warn("[SUPER ANTI-KICK] Blocked:", method)
    end
    
    -- Block remote spy detection
    if type(args[1]) == "string" and (args[1]:lower():find("kick") or args[1]:lower():find("ban")) then
        return warn("[SUPER ANTI-KICK] Blocked remote:", args[1])
    end
    
    return oldNamecall(self, ...)
end)

-- Block property changes that could kick
mt.__newindex = newcclosure(function(t, k, v)
    if t == player and (k == "Character" or k == "Parent") then
        return
    end
    return oldNewindex(t, k, v)
end)

setreadonly(mt, true)

-- ==================== GUI SETUP ====================
local gui = Instance.new("ScreenGui")
gui.Name = "TsunamiHubV4"
gui.Parent = coreGui
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999999999
gui.IgnoreGuiInset = true

-- Ukuran lebih kecil untuk HP
local isMobile = userInput.TouchEnabled and not userInput.MouseEnabled
local uiScale = isMobile and 0.8 or 1

-- ==================== DRAGGABLE CIRCLE ====================
local circle = Instance.new("ImageButton")
circle.Name = "MenuCircle"
circle.Size = UDim2.new(0, 55 * uiScale, 0, 55 * uiScale)
circle.Position = UDim2.new(0.5, -27 * uiScale, 0.5, -27 * uiScale) -- Tengah dulu
circle.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
circle.BackgroundTransparency = 0.2
circle.Image = "rbxassetid://3570695787" -- Circle texture
circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
circle.ScaleType = Enum.ScaleType.Fit
circle.BorderSizePixel = 0
circle.Visible = false
circle.Parent = gui
circle.Active = true
circle.Draggable = true -- Auto draggable!

-- Efek glow
local circleGlow = Instance.new("ImageLabel")
circleGlow.Size = UDim2.new(1.3, 0, 1.3, 0)
circleGlow.Position = UDim2.new(-0.15, 0, -0.15, 0)
circleGlow.BackgroundTransparency = 1
circleGlow.Image = "rbxassetid://5028857084"
circleGlow.ImageColor3 = Color3.fromRGB(0, 200, 255)
circleGlow.ImageTransparency = 0.5
circleGlow.Parent = circle

-- Icon di dalam circle
local circleIcon = Instance.new("TextLabel")
circleIcon.Size = UDim2.new(1, 0, 1, 0)
circleIcon.BackgroundTransparency = 1
circleIcon.Text = "🌊"
circleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
circleIcon.TextScaled = true
circleIcon.Font = Enum.Font.GothamBold
circleIcon.Parent = circle

-- Pulse animation
spawn(function()
    while circle do
        tweenService:Create(circleGlow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            ImageTransparency = 0.2,
            Size = UDim2.new(1.4, 0, 1.4, 0)
        }):Play()
        wait(1.5)
    end
end)

-- ==================== MAIN UI ====================
local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.new(0, 260 * uiScale, 0, 380 * uiScale) -- Lebih kecil!
main.Position = UDim2.new(0.5, -130 * uiScale, 0.5, -190 * uiScale)
main.BackgroundColor3 = Color3.fromRGB(8, 8, 16)
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

-- Border gradient
local borderGradient = Instance.new("UIGradient")
borderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
})
borderGradient.Rotation = 90
borderGradient.Parent = main

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 35 * uiScale)
header.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12 * uiScale)
headerCorner.Parent = header

local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
})
headerGradient.Rotation = 90
headerGradient.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -65, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌊 GHOST V4"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Minimize to circle
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 25 * uiScale, 0, 25 * uiScale)
miniBtn.Position = UDim2.new(1, -55 * uiScale, 0, 5 * uiScale)
miniBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
miniBtn.Text = "⏺"
miniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBtn.TextScaled = true
miniBtn.Font = Enum.Font.GothamBold
miniBtn.BorderSizePixel = 0
miniBtn.Parent = header

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 5 * uiScale)
miniCorner.Parent = miniBtn

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25 * uiScale, 0, 25 * uiScale)
closeBtn.Position = UDim2.new(1, -25 * uiScale, 0, 5 * uiScale)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5 * uiScale)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- DRAG FUNCTION (untuk main UI)
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

-- Minimize/Maximize
miniBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    circle.Visible = true
    -- Set circle ke posisi main sebelumnya + offset biar ga ketutupan
    circle.Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset + main.AbsoluteSize.X/2, 
                                 main.Position.Y.Scale, main.Position.Y.Offset - 30)
end)

circle.MouseButton1Click:Connect(function()
    circle.Visible = false
    main.Visible = true
    -- Animasi muncul
    main.Size = UDim2.new(0, 0, 0, 0)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    tweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 260 * uiScale, 0, 380 * uiScale),
        Position = UDim2.new(0.5, -130 * uiScale, 0.5, -190 * uiScale)
    }):Play()
end)

-- Tabs
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, 35 * uiScale)
tabFrame.Position = UDim2.new(0, 0, 0, 40 * uiScale)
tabFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = main

local tabs = {"👻 GOD", "🔄 DUPE", "⚡ FARM"}
local tabBtns = {}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/3, -2, 1, -4)
    btn.Position = UDim2.new((i-1)/3, i == 1 and 2 or (i == 2 and 1 or 0), 0, 2)
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
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

-- Content frame
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -10, 0, 290 * uiScale)
content.Position = UDim2.new(0, 5, 0, 80 * uiScale)
content.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
content.BackgroundTransparency = 0.5
content.BorderSizePixel = 0
content.ScrollBarThickness = 4 * uiScale
content.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.Parent = main

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 8 * uiScale)
contentCorner.Parent = content

-- ==================== SUPER GOD MODE + GHOST ====================
local godMode = false
local godConnection
local originalCollisions = {}

function toggleGodMode(state)
    godMode = state
    
    if godConnection then godConnection:Disconnect() end
    
    if godMode then
        godConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                local char = player.Character
                if not char then return end
                
                -- 1. GHOST MODE - Tembus semua
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if not originalCollisions[part] then
                            originalCollisions[part] = part.CanCollide
                        end
                        part.CanCollide = false
                        part.Transparency = math.min(part.Transparency + 0.4, 0.7)
                    end
                end
                
                -- 2. HUMANID GOD MODE
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    -- Health
                    hum.MaxHealth = 9e9
                    hum.Health = 9e9
                    
                    -- Disable all damage states
                    hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
                    
                    -- Anti drowning
                    hum.BreakJointsOnDeath = false
                end
                
                -- 3. HITBOX REMOVAL - Ga kena damage tsunami
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Part") and (obj.Name:lower():find("tsunami") or obj.Name:lower():find("wave") or obj.Name:lower():find("water")) then
                        if obj:FindFirstChild("TouchInterest") then
                            obj.TouchInterest:Destroy()
                        end
                    end
                end
                
                -- 4. Teleport out of danger
                local pos = char:FindFirstChild("HumanoidRootPart")
                if pos and workspace:FindPart(Ray.new(pos.Position, Vector3.new(0, -10, 0))) then
                    -- Safe
                else
                    -- In danger, teleport to safe spot
                    local safeSpot = findSafeSpot()
                    if safeSpot then
                        pos.CFrame = CFrame.new(safeSpot)
                    end
                end
            end)
        end)
    else
        -- Restore collisions
        pcall(function()
            local char = player.Character
            if char then
                for part, canCollide in pairs(originalCollisions) do
                    if part and part.Parent then
                        part.CanCollide = canCollide
                        part.Transparency = 0
                    end
                end
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                end
            end
        end)
        originalCollisions = {}
    end
end

function findSafeSpot()
    -- Cari spot aman (biasanya base)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and (obj.Name:lower():find("base") or obj.Name:lower():find("spawn") or obj.Name:lower():find("safe")) then
            return obj.Position + Vector3.new(0, 5, 0)
        end
    end
    return Vector3.new(0, 50, 0) -- Default
end

-- ==================== PREMIUM DUPE SYSTEM ====================
local dupeActive = false
local dupeConnection
local currentBrainrot = nil

-- Fungsi cari brainrot dengan multi-method
function getCurrentBrainrot()
    local char = player.Character
    local backpack = player.Backpack
    
    -- Method 1: Cek tool yang dipegang
    if char then
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:lower():find("brainrot") or tool.Name:lower():find("brain") or tool:FindFirstChild("Brainrot")) then
                return tool, "HAND"
            end
        end
    end
    
    -- Method 2: Cek backpack
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.Name:lower():find("brainrot") or tool.Name:lower():find("brain") or tool:FindFirstChild("Brainrot")) then
            return tool, "BACKPACK"
        end
    end
    
    -- Method 3: Cek dengan pattern umum
    for _, obj in ipairs(player:GetDescendants()) do
        if obj:IsA("Tool") or obj:IsA("Part") then
            if obj.Name:match("Brain") or obj.Name:match("brain") or obj.Name:match("ROT") then
                return obj, "DESCENDANT"
            end
        end
    end
    
    return nil, nil
end

-- Fungsi dupe dengan berbagai metode
function duplicateBrainrot()
    local brainrot, location = getCurrentBrainrot()
    if not brainrot then
        return false, "No brainrot found"
    end
    
    local success = false
    local methods = {}
    
    pcall(function()
        -- METHOD 1: Clone ke backpack
        local clone1 = brainrot:Clone()
        clone1.Name = brainrot.Name .. " (DUPE)"
        clone1.Parent = player.Backpack
        table.insert(methods, "Backpack Clone")
        success = true
        
        -- METHOD 2: Clone ke workspace di depan player
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = player.Character.HumanoidRootPart.Position + player.Character.HumanoidRootPart.CFrame.LookVector * 5
            local clone2 = brainrot:Clone()
            clone2.Name = brainrot.Name .. " (DROP)"
            clone2.Parent = workspace
            if clone2:IsA("Tool") then
                clone2.Handle.CFrame = CFrame.new(pos)
            elseif clone2:IsA("Part") then
                clone2.CFrame = CFrame.new(pos)
            end
            table.insert(methods, "Drop Clone")
        end
        
        -- METHOD 3: Cari remote event dupe
        for _, remote in ipairs(replicatedStorage:GetDescendants()) do
            if remote:IsA("RemoteEvent") and (remote.Name:lower():find("dupe") or remote.Name:lower():find("clone") or remote.Name:lower():find("duplicate")) then
                remote:FireServer(brainrot)
                table.insert(methods, "Remote Event")
                success = true
            end
        end
        
        -- METHOD 4: Cek fungsi global (untuk game tertentu)
        if _G.dupe or _G.duplicate then
            if type(_G.dupe) == "function" then
                _G.dupe(brainrot)
                table.insert(methods, "Global Function")
                success = true
            end
        end
        
        -- METHOD 5: Force sell & buy method (untuk game yang punya shop)
        for _, remote in ipairs(replicatedStorage:GetDescendants()) do
            if remote:IsA("RemoteEvent") and (remote.Name:lower():find("sell") or remote.Name:lower():find("buy") or remote.Name:lower():find("purchase")) then
                remote:FireServer(brainrot)
                table.insert(methods, "Shop Exploit")
                success = true
            end
        end
    end)
    
    return success, methods
end

function startAutoDupe(state)
    dupeActive = state
    if dupeConnection then dupeConnection:Disconnect() end
    
    if dupeActive then
        dupeConnection = runService.Heartbeat:Connect(function()
            local success, methods = duplicateBrainrot()
            if success then
                showNotification("✅ Dupe Success!", Color3.fromRGB(0, 255, 0))
            end
            task.wait(0.3) -- Cepat tapi aman
        end)
    end
end

-- ==================== AUTO FARM TOKEN ====================
local farmActive = false
local farmConnection

function startAutoFarm(state)
    farmActive = state
    if farmConnection then farmConnection:Disconnect() end
    
    if farmActive then
        farmConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                
                -- 1. Auto collect coins/tokens
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Part") and (obj.Name:lower():find("coin") or obj.Name:lower():find("token") or obj.Name:lower():find("cash") or obj.Name:lower():find("money")) then
                        if obj:FindFirstChild("TouchInterest") then
                            char.HumanoidRootPart.CFrame = obj.CFrame * CFrame.new(0, 2, 0)
                            task.wait(0.1)
                        end
                    end
                end
                
                -- 2. Auto grab brainrots
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Tool") and (obj.Name:lower():find("brainrot") or obj.Name:lower():find("brain")) then
                        if obj:FindFirstChild("Handle") then
                            char.HumanoidRootPart.CFrame = obj.Handle.CFrame * CFrame.new(0, 2, 0)
                            task.wait(0.1)
                            -- Auto equip
                            obj.Parent = player.Backpack
                        end
                    end
                end
                
                -- 3. Auto rebirth jika ada token
                for _, remote in ipairs(replicatedStorage:GetDescendants()) do
                    if remote:IsA("RemoteEvent") and remote.Name:lower():find("rebirth") then
                        remote:FireServer()
                    end
                end
            end)
        end)
    end
end

-- ==================== NOTIFICATION SYSTEM ====================
function showNotification(text, color)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 180 * uiScale, 0, 35 * uiScale)
    notif.Position = UDim2.new(0.5, -90 * uiScale, 0, 100 * uiScale)
    notif.BackgroundColor3 = color or Color3.fromRGB(0, 150, 255)
    notif.BackgroundTransparency = 0.2
    notif.BorderSizePixel = 0
    notif.Parent = gui
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 8 * uiScale)
    notifCorner.Parent = notif
    
    local notifText = Instance.new("TextLabel")
    notifText.Size = UDim2.new(1, -10, 1, 0)
    notifText.Position = UDim2.new(0, 5, 0, 0)
    notifText.BackgroundTransparency = 1
    notifText.Text = text
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextScaled = true
    notifText.Font = Enum.Font.GothamBold
    notifText.Parent = notif
    
    tweenService:Create(notif, TweenInfo.new(2, Enum.EasingStyle.Quad), {
        Position = UDim2.new(0.5, -90 * uiScale, 0, 50 * uiScale),
        BackgroundTransparency = 1,
        TextTransparency = 1
    }):Play()
    
    task.wait(2)
    pcall(function() notif:Destroy() end)
end

-- ==================== UI CONTENT ====================
function switchTab(index)
    for _, v in ipairs(content:GetChildren()) do
        v:Destroy()
    end
    
    local y = 8 * uiScale
    
    if index == 1 then -- GOD TAB
        y = createToggle(content, y, "👑 SUPER GOD MODE", "Ghost + Invincible + No Damage", godMode, function(state)
            toggleGodMode(state)
        end)
        
        y = createLabel(content, y, "✨ EFFECTS:", Color3.fromRGB(255, 200, 0))
        y = createBullet(content, y, "• Tembus tsunami")
        y = createBullet(content, y, "• No damage")
        y = createBullet(content, y, "• Health 9e9")
        y = createBullet(content, y, "• Auto teleport if danger")
        y = y + 5 * uiScale
        
        y = createToggle(content, y, "⚡ SPEED X10000", "Lari secepat kilat", false, function(state)
            if state then
                runService.Heartbeat:Connect(function()
                    pcall(function()
                        if player.Character and player.Character:FindFirstChild("Humanoid") then
                            player.Character.Humanoid.WalkSpeed = 10000
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
        end)
        
        y = createToggle(content, y, "🚀 INFINITE JUMP", "Lompat terus", false, function(state)
            if state then
                userInput.JumpRequest:Connect(function()
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
            end
        end)
        
    elseif index == 2 then -- DUPE TAB
        -- Current brainrot display
        local infoFrame = Instance.new("Frame")
        infoFrame.Size = UDim2.new(1, -16, 0, 45 * uiScale)
        infoFrame.Position = UDim2.new(0, 8, 0, y)
        infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        infoFrame.BackgroundTransparency = 0.3
        infoFrame.BorderSizePixel = 0
        infoFrame.Parent = content
        
        local infoCorner = Instance.new("UICorner")
        infoCorner.CornerRadius = UDim.new(0, 6 * uiScale)
        infoCorner.Parent = infoFrame
        
        local infoTitle = Instance.new("TextLabel")
        infoTitle.Size = UDim2.new(1, -10, 0, 16 * uiScale)
        infoTitle.Position = UDim2.new(0, 5, 0, 3 * uiScale)
        infoTitle.BackgroundTransparency = 1
        infoTitle.Text = "🧠 CURRENT BRAINROT:"
        infoTitle.TextColor3 = Color3.fromRGB(150, 150, 255)
        infoTitle.TextXAlignment = Enum.TextXAlignment.Left
        infoTitle.Font = Enum.Font.GothamBold
        infoTitle.TextScaled = true
        infoTitle.Parent = infoFrame
        
        local brainrotName = Instance.new("TextLabel")
        brainrotName.Size = UDim2.new(1, -10, 0, 20 * uiScale)
        brainrotName.Position = UDim2.new(0, 5, 0, 20 * uiScale)
        brainrotName.BackgroundTransparency = 1
        brainrotName.Text = "Scanning..."
        brainrotName.TextColor3 = Color3.fromRGB(0, 255, 200)
        brainrotName.TextXAlignment = Enum.TextXAlignment.Left
        brainrotName.Font = Enum.Font.GothamBold
        brainrotName.TextScaled = true
        brainrotName.Parent = infoFrame
        
        -- Update every second
        spawn(function()
            while infoFrame and infoFrame.Parent do
                local br, loc = getCurrentBrainrot()
                if br then
                    brainrotName.Text = br.Name .. " [" .. (loc or "UNKNOWN") .. "]"
                else
                    brainrotName.Text = "No brainrot detected"
                end
                task.wait(1)
            end
        end)
        
        y = y + 55 * uiScale
        
        y = createButton(content, y, "🔄 DUPE NOW", function()
            local success, methods = duplicateBrainrot()
            if success then
                local methodText = methods and #methods > 0 and " (" .. table.concat(methods, ", ") .. ")" or ""
                showNotification("✅ Duplicated!" .. methodText, Color3.fromRGB(0, 255, 0))
            else
                showNotification("❌ No brainrot found", Color3.fromRGB(255, 0, 0))
            end
        end)
        
        y = createToggle(content, y, "⚡ AUTO DUPE (0.3s)", "Duplicate terus menerus", dupeActive, function(state)
            startAutoDupe(state)
        end)
        
        y = createLabel(content, y, "📌 5 DUPE METHODS:", Color3.fromRGB(255, 200, 0))
        y = createBullet(content, y, "• Clone to Backpack")
        y = createBullet(content, y, "• Drop to ground")
        y = createBullet(content, y, "• Remote events")
        y = createBullet(content, y, "• Global functions")
        y = createBullet(content, y, "• Shop exploit")
        
    elseif index == 3 then -- FARM TAB
        y = createToggle(content, y, "💰 AUTO FARM TOKEN", "Collect coins & brainrots", farmActive, function(state)
            startAutoFarm(state)
        end)
        
        y = createToggle(content, y, "⚡ AUTO UPGRADE", "Upgrade base otomatis", false, function(state)
            if state then
                runService.Heartbeat:Connect(function()
                    pcall(function()
                        for _, remote in ipairs(replicatedStorage:GetDescendants()) do
                            if remote:IsA("RemoteEvent") and (remote.Name:lower():find("upgrade") or remote.Name:lower():find("baseupgrade")) then
                                remote:FireServer()
                            end
                        end
                    end)
                end)
            end
        end)
        
        y = createToggle(content, y, "🔄 AUTO REBIRTH", "Rebirth otomatis", false, function(state)
            if state then
                runService.Heartbeat:Connect(function()
                    pcall(function()
                        for _, remote in ipairs(replicatedStorage:GetDescendants()) do
                            if remote:IsA("RemoteEvent") and remote.Name:lower():find("rebirth") then
                                remote:FireServer()
                            end
                        end
                    end)
                end)
            end
        end)
        
        y = createToggle(content, y, "📦 AUTO SELL", "Jual brainrot otomatis", false, function(state)
            if state then
                runService.Heartbeat:Connect(function()
                    pcall(function()
                        for _, remote in ipairs(replicatedStorage:GetDescendants()) do
                            if remote:IsA("RemoteEvent") and remote.Name:lower():find("sell") then
                                remote:FireServer()
                            end
                        end
                    end)
                end)
            end
        end)
        
        y = createLabel(content, y, "💰 TOKEN MULTIPLIER", Color3.fromRGB(255, 200, 0))
        y = createButton(content, y, "✨ INSTANT GOD (8x)", function()
            pcall(function()
                for _, remote in ipairs(replicatedStorage:GetDescendants()) do
                    if remote:IsA("RemoteEvent") and remote.Name:lower():find("god") then
                        remote:FireServer(8)
                    end
                end
            end)
            showNotification("✅ God token applied!", Color3.fromRGB(255, 200, 0))
        end)
    end
    
    content.CanvasSize = UDim2.new(0, 0, 0, y + 15 * uiScale)
end

-- Helper functions
function createToggle(parent, y, text, desc, state, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -16, 0, 45 * uiScale)
    frame.Position = UDim2.new(0, 8, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 6 * uiScale)
    frameCorner.Parent = frame
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -70, 0, 20 * uiScale)
    textLabel.Position = UDim2.new(0, 8, 0, 4 * uiScale)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextScaled = true
    textLabel.Parent = frame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -70, 0, 15 * uiScale)
    descLabel.Position = UDim2.new(0, 8, 0, 24 * uiScale)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextScaled = true
    descLabel.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 45 * uiScale, 0, 25 * uiScale)
    btn.Position = UDim2.new(1, -55 * uiScale, 0, 10 * uiScale)
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(80, 80, 80)
    btn.Text = state and "ON" or "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5 * uiScale)
    btnCorner.Parent = btn
    
    local btnState = state
    btn.MouseButton1Click:Connect(function()
        btnState = not btnState
        btn.BackgroundColor3 = btnState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(80, 80, 80)
        btn.Text = btnState and "ON" or "OFF"
        callback(btnState)
    end)
    
    return y + 52 * uiScale
end

function createButton(parent, y, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 35 * uiScale)
    btn.Position = UDim2.new(0, 8, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(100, 30, 200)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = parent
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6 * uiScale)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    
    return y + 42 * uiScale
end

function createLabel(parent, y, text, color)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -16, 0, 20 * uiScale)
    label.Position = UDim2.new(0, 8, 0, y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.Parent = parent
    
    return y + 25 * uiScale
end

function createBullet(parent, y, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -24, 0, 16 * uiScale)
    label.Position = UDim2.new(0, 16, 0, y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextScaled = true
    label.Parent = parent
    
    return y + 20 * uiScale
end

-- Tab switching
for i, btn in ipairs(tabBtns) do
    btn.MouseButton1Click:Connect(function()
        for _, b in ipairs(tabBtns) do
            b.BackgroundColor3 = Color3.fromRGB(22, 22, 36)
        end
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
        switchTab(i)
    end)
end

-- Initial tab
tabBtns[1].BackgroundColor3 = Color3.fromRGB(45, 45, 70)
switchTab(1)

-- Anti-AFK
spawn(function()
    while wait(30) do
        pcall(function()
            virtualUser:CaptureController()
            virtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

-- Welcome
showNotification("🌊 GHOST V4 LOADED", Color3.fromRGB(0, 200, 255))
