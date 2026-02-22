--[[
╔══════════════════════════════════════════════════════════════════════════╗
║               BRAINROT LASER GHOST V5 - PREMIUM EDITION                  ║
║                                                                          ║
║     Features:                                                            ║
║     • Laser Ghost Mode - Tembus laser & anti-damage                     ║
║     • Auto Lock Base - Base otomatis kebal serangan                     ║
║     • Steal Protection - Brainrot gak balik kalo dipukul                ║
║     • Player Teleport - Teleport ke player manapun                       ║
║     • Radius System - Fitur dengan radius detection                     ║
║     • Smooth UI + Animations                                            ║
╚══════════════════════════════════════════════════════════════════════════╝
]]

-- ==================== INITIAL SETUP ====================
local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local coreGui = game:GetService("CoreGui")
local replicatedStorage = game:GetService("ReplicatedStorage")
local virtualUser = game:GetService("VirtualUser")
local lighting = game:GetService("Lighting")

-- Anti-kick ultimate [citation:8]
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
local oldIndex = mt.__index
local oldNewindex = mt.__newindex
setreadonly(mt, false)

-- Block kick & detection
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    local blocked = {
        Kick = true, Crash = true, Disconnect = true,
        Exit = true, Shutdown = true, ["kick"] = true,
    }
    
    if blocked[method] then
        return warn("[ANTI-KICK] Blocked:", method)
    end
    
    return oldNamecall(self, ...)
end)

-- Block property changes
mt.__newindex = newcclosure(function(t, k, v)
    if t == player and (k == "Character" or k == "Parent") then
        return
    end
    return oldNewindex(t, k, v)
end)

setreadonly(mt, true)

-- ==================== DETECT MOBILE ====================
local isMobile = userInput.TouchEnabled and not userInput.MouseEnabled
local uiScale = isMobile and 0.75 or 1

-- ==================== CREATE GUI ====================
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotLaserGhost"
gui.Parent = coreGui
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999999999
gui.IgnoreGuiInset = true

-- ==================== SMOOTH UI COMPONENTS ====================
local uiCorner = function(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius * uiScale)
    corner.Parent = parent
    return corner
end

local uiStroke = function(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(255, 255, 255)
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

local uiGradient = function(parent, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(colors)
    gradient.Rotation = rotation or 90
    gradient.Parent = parent
    return gradient
end

-- ==================== MAIN FRAME (GLASS MORPHISM) ====================
local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.new(0, 300 * uiScale, 0, 450 * uiScale)
main.Position = UDim2.new(0.5, -150 * uiScale, 0.5, -225 * uiScale)
main.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
main.BackgroundTransparency = 0.15
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

-- Glass effect
local glassBlur = Instance.new("Frame")
glassBlur.Size = UDim2.new(1, 0, 1, 0)
glassBlur.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glassBlur.BackgroundTransparency = 0.95
glassBlur.BorderSizePixel = 0
glassBlur.Parent = main

uiCorner(main, 16)
uiStroke(main, Color3.fromRGB(0, 200, 255), 1.5)

-- Shadow
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1.1, 0, 1.1, 0)
shadow.Position = UDim2.new(-0.05, 0, -0.05, 0)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.Parent = main

-- ==================== HEADER WITH ANIMATION ====================
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45 * uiScale)
header.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
header.BorderSizePixel = 0
header.Parent = main

uiCorner(header, 16)
uiGradient(header, {
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
}, 90)

-- Title with glow
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🧠 LASER GHOST V5"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Title glow
local titleGlow = Instance.new("ImageLabel")
titleGlow.Size = UDim2.new(1, 20, 1, 10)
titleGlow.Position = UDim2.new(0, -10, 0, -5)
titleGlow.BackgroundTransparency = 1
titleGlow.Image = "rbxassetid://5028857084"
titleGlow.ImageColor3 = Color3.fromRGB(0, 200, 255)
titleGlow.ImageTransparency = 0.7
titleGlow.Parent = title

-- Minimize button (to circle)
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 28 * uiScale, 0, 28 * uiScale)
miniBtn.Position = UDim2.new(1, -60 * uiScale, 0, 8 * uiScale)
miniBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
miniBtn.Text = "⏺"
miniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBtn.TextScaled = true
miniBtn.Font = Enum.Font.GothamBold
miniBtn.BorderSizePixel = 0
miniBtn.Parent = header

uiCorner(miniBtn, 8)

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28 * uiScale, 0, 28 * uiScale)
closeBtn.Position = UDim2.new(1, -28 * uiScale, 0, 8 * uiScale)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

uiCorner(closeBtn, 8)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- ==================== MINIMIZE CIRCLE (DRAGGABLE) ====================
local circle = Instance.new("ImageButton")
circle.Name = "MenuCircle"
circle.Size = UDim2.new(0, 55 * uiScale, 0, 55 * uiScale)
circle.Position = UDim2.new(0.5, -27 * uiScale, 0.5, -27 * uiScale)
circle.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
circle.BackgroundTransparency = 0.2
circle.Image = "rbxassetid://3570695787"
circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
circle.ScaleType = Enum.ScaleType.Fit
circle.BorderSizePixel = 0
circle.Visible = false
circle.Parent = gui
circle.Active = true
circle.Draggable = true -- Auto draggable!

-- Circle glow
local circleGlow = Instance.new("ImageLabel")
circleGlow.Size = UDim2.new(1.3, 0, 1.3, 0)
circleGlow.Position = UDim2.new(-0.15, 0, -0.15, 0)
circleGlow.BackgroundTransparency = 1
circleGlow.Image = "rbxassetid://5028857084"
circleGlow.ImageColor3 = Color3.fromRGB(0, 200, 255)
circleGlow.ImageTransparency = 0.5
circleGlow.Parent = circle

uiCorner(circle, 30)

-- Circle icon
local circleIcon = Instance.new("TextLabel")
circleIcon.Size = UDim2.new(1, 0, 1, 0)
circleIcon.BackgroundTransparency = 1
circleIcon.Text = "🧠"
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

-- Minimize/Maximize
miniBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    circle.Visible = true
    -- Animasi muncul
    circle.Size = UDim2.new(0, 0, 0, 0)
    tweenService:Create(circle, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 55 * uiScale, 0, 55 * uiScale)
    }):Play()
end)

circle.MouseButton1Click:Connect(function()
    circle.Visible = false
    main.Visible = true
    -- Animasi main muncul
    main.Size = UDim2.new(0, 0, 0, 0)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    tweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 300 * uiScale, 0, 450 * uiScale),
        Position = UDim2.new(0.5, -150 * uiScale, 0.5, -225 * uiScale)
    }):Play()
end)

-- ==================== DRAG FUNCTION ====================
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
tabFrame.Size = UDim2.new(1, 0, 0, 40 * uiScale)
tabFrame.Position = UDim2.new(0, 0, 0, 50 * uiScale)
tabFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
tabFrame.BackgroundTransparency = 0.5
tabFrame.BorderSizePixel = 0
tabFrame.Parent = main

local tabs = {"👻 GHOST", "🛡️ LOCK", "📡 RADIUS", "👥 TP"}
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
    
    uiCorner(btn, 8)
    uiStroke(btn, Color3.fromRGB(0, 200, 255), 0.5)
    
    -- Hover effect
    btn.MouseEnter:Connect(function()
        tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 55)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 ~= Color3.fromRGB(50, 50, 80) then
            tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 35)}):Play()
        end
    end)
    
    table.insert(tabBtns, btn)
end

-- ==================== CONTENT FRAME (SMOOTH SCROLL) ====================
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 0, 330 * uiScale)
content.Position = UDim2.new(0, 10, 0, 100 * uiScale)
content.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
content.BackgroundTransparency = 0.5
content.BorderSizePixel = 0
content.ScrollBarThickness = 4 * uiScale
content.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.Parent = main

uiCorner(content, 12)

-- ==================== FEATURE FUNCTIONS ====================

-- 1. LASER GHOST MODE (Tembus laser + anti damage)
local laserGhost = false
local laserConnection
local originalCollisions = {}

function toggleLaserGhost(state)
    laserGhost = state
    
    if laserConnection then laserConnection:Disconnect() end
    
    if laserGhost then
        laserConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                local char = player.Character
                if not char then return end
                
                -- Ghost mode: tembus semua object
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if not originalCollisions[part] then
                            originalCollisions[part] = part.CanCollide
                        end
                        part.CanCollide = false
                        part.Transparency = math.min(part.Transparency + 0.3, 0.6)
                    end
                end
                
                -- Destroy laser parts biar ga kena damage
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Part") and (obj.Name:lower():find("laser") or obj.Name:lower():find("beam") or obj.Name:lower():find("hazard")) then
                        if obj:FindFirstChild("TouchInterest") then
                            obj.TouchInterest:Destroy()
                        end
                    end
                end
                
                -- Humanoid god mode
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    hum.MaxHealth = 9e9
                    hum.Health = 9e9
                    hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
                    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
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
            end
        end)
        originalCollisions = {}
    end
end

-- 2. STEAL PROTECTION (Brainrot ga balik kalo dipukul)
local stealProtection = false
local protectConnection

function toggleStealProtection(state)
    stealProtection = state
    
    if protectConnection then protectConnection:Disconnect() end
    
    if stealProtection then
        protectConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                -- Cari brainrot yang dipegang atau di backpack
                local heldBrainrot = nil
                local char = player.Character
                if char then
                    for _, tool in ipairs(char:GetChildren()) do
                        if tool:IsA("Tool") and (tool.Name:lower():find("brainrot") or tool.Name:lower():find("brain")) then
                            heldBrainrot = tool
                            break
                        end
                    end
                end
                
                if not heldBrainrot then
                    for _, tool in ipairs(player.Backpack:GetChildren()) do
                        if tool:IsA("Tool") and (tool.Name:lower():find("brainrot") or tool.Name:lower():find("brain")) then
                            heldBrainrot = tool
                            break
                        end
                    end
                end
                
                if heldBrainrot then
                    -- Lock brainrot biar ga balik
                    heldBrainrot.Parent = player.Backpack -- Force keep in backpack
                    
                    -- Cegah remote steal
                    for _, remote in ipairs(replicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") and (remote.Name:lower():find("steal") or remote.Name:lower():find("take") or remote.Name:lower():find("remove")) then
                            remote:FireServer(heldBrainrot, "block") -- Block steal attempt
                        end
                    end
                end
            end)
        end)
    end
end

-- 3. AUTO LOCK BASE [citation:2][citation:5]
local baseLock = false
local baseConnection

function toggleBaseLock(state)
    baseLock = state
    
    if baseConnection then baseConnection:Disconnect() end
    
    if baseLock then
        baseConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                -- Cari base player
                local baseParts = {}
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Part") and (obj.Name:lower():find("base") or obj.Name:lower():find("spawn") or obj.Name:lower():match("house")) then
                        table.insert(baseParts, obj)
                    end
                end
                
                -- Lock base dengan forcefield
                for _, part in ipairs(baseParts) do
                    if not part:FindFirstChild("ForceField") then
                        local ff = Instance.new("ForceField")
                        ff.Visible = false
                        ff.Parent = part
                    end
                    
                    -- Destroy touch interest biar ga bisa diambil
                    if part:FindFirstChild("TouchInterest") then
                        part.TouchInterest:Destroy()
                    end
                    
                    -- Heal base
                    if part:FindFirstChild("Health") and part.Health:IsA("NumberValue") then
                        part.Health.Value = 9e9
                    end
                end
            end)
        end)
    end
end

-- 4. RADIUS DETECTION SYSTEM [citation:1]
local radiusEnabled = false
local radiusConnection
local radiusValue = 30
local espEnabled = false
local espObjects = {}

function toggleRadius(state)
    radiusEnabled = state
    
    if radiusConnection then radiusConnection:Disconnect() end
    
    if radiusEnabled then
        radiusConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                
                local myPos = char.HumanoidRootPart.Position
                
                -- Deteksi player dalam radius
                for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                    if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (myPos - plr.Character.HumanoidRootPart.Position).Magnitude
                        
                        if distance <= radiusValue then
                            -- Dalam radius, kasih warning
                            if not plr.Character:FindFirstChild("RadiusWarning") then
                                local bill = Instance.new("BillboardGui")
                                bill.Name = "RadiusWarning"
                                bill.Size = UDim2.new(0, 100, 0, 30)
                                bill.StudsOffset = Vector3.new(0, 3, 0)
                                bill.Parent = plr.Character:FindFirstChild("Head") or plr.Character:FindFirstChild("HumanoidRootPart")
                                
                                local label = Instance.new("TextLabel")
                                label.Size = UDim2.new(1, 0, 1, 0)
                                label.BackgroundTransparency = 1
                                label.Text = "⚠️ IN RADIUS"
                                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                                label.TextScaled = true
                                label.Font = Enum.Font.GothamBold
                                label.Parent = bill
                            end
                        else
                            -- Hapus warning jika keluar radius
                            local head = plr.Character:FindFirstChild("Head") or plr.Character:FindFirstChild("HumanoidRootPart")
                            if head then
                                local warning = head:FindFirstChild("RadiusWarning")
                                if warning then warning:Destroy() end
                            end
                        end
                    end
                end
                
                -- Deteksi brainrot dalam radius
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Tool") and (obj.Name:lower():find("brainrot") or obj.Name:lower():find("brain")) then
                        if obj:FindFirstChild("Handle") then
                            local distance = (myPos - obj.Handle.Position).Magnitude
                            if distance <= radiusValue then
                                -- Highlight brainrot dalam radius
                                if not obj:FindFirstChild("RadiusGlow") then
                                    local highlight = Instance.new("Highlight")
                                    highlight.Name = "RadiusGlow"
                                    highlight.FillColor = Color3.fromRGB(0, 255, 100)
                                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                    highlight.FillTransparency = 0.5
                                    highlight.Parent = obj
                                end
                            else
                                local glow = obj:FindFirstChild("RadiusGlow")
                                if glow then glow:Destroy() end
                            end
                        end
                    end
                end
            end)
        end)
    else
        -- Bersihkan semua radius indicators
        for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
            if plr.Character then
                local head = plr.Character:FindFirstChild("Head") or plr.Character:FindFirstChild("HumanoidRootPart")
                if head then
                    local warning = head:FindFirstChild("RadiusWarning")
                    if warning then warning:Destroy() end
                end
            end
        end
        
        for _, obj in ipairs(workspace:GetDescendants()) do
            local glow = obj:FindFirstChild("RadiusGlow")
            if glow then glow:Destroy() end
        end
    end
end

-- 5. ESP TOGGLE (dipisah dari radius) [citation:1][citation:3]
function toggleESP(state)
    espEnabled = state
    
    if espEnabled then
        -- Hapus ESP lama
        for _, obj in ipairs(espObjects) do
            pcall(function() obj:Destroy() end)
        end
        espObjects = {}
        
        -- Buat ESP baru
        for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
            if plr ~= player then
                createESP(plr)
            end
        end
        
        -- Monitor player baru
        game:GetService("Players").PlayerAdded:Connect(function(newPlr)
            if espEnabled and newPlr ~= player then
                createESP(newPlr)
            end
        end)
    else
        -- Hapus semua ESP
        for _, obj in ipairs(espObjects) do
            pcall(function() obj:Destroy() end)
        end
        espObjects = {}
    end
end

function createESP(plr)
    pcall(function()
        -- Highlight
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_" .. plr.Name
        highlight.FillColor = Color3.fromRGB(255, 50, 50)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.Parent = plr.Character
        table.insert(espObjects, highlight)
        
        -- Name tag
        local bill = Instance.new("BillboardGui")
        bill.Name = "ESPName_" .. plr.Name
        bill.Size = UDim2.new(0, 150, 0, 40)
        bill.StudsOffset = Vector3.new(0, 3, 0)
        bill.AlwaysOnTop = true
        bill.Parent = plr.Character:FindFirstChild("Head") or plr.Character:FindFirstChild("HumanoidRootPart")
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = plr.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0.3
        nameLabel.TextScaled = true
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Parent = bill
        
        local distLabel = Instance.new("TextLabel")
        distLabel.Size = UDim2.new(1, 0, 0.4, 0)
        distLabel.Position = UDim2.new(0, 0, 0.6, 0)
        distLabel.BackgroundTransparency = 1
        distLabel.Text = "📍"
        distLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
        distLabel.TextScaled = true
        distLabel.Font = Enum.Font.Gotham
        distLabel.Parent = bill
        
        table.insert(espObjects, bill)
    end)
end

-- 6. TELEPORT KE PLAYER [citation:3][citation:5]
function teleportToPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        showNotification("❌ Player not found", Color3.fromRGB(255, 0, 0))
        return
    end
    
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = targetPlayer.Character.HumanoidRootPart.Position
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 5, 0))
        showNotification("✅ Teleported to " .. targetPlayer.Name, Color3.fromRGB(0, 255, 0))
    end
end

-- 7. NOTIFICATION SYSTEM
function showNotification(text, color)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 200 * uiScale, 0, 40 * uiScale)
    notif.Position = UDim2.new(0.5, -100 * uiScale, 0, 50 * uiScale)
    notif.BackgroundColor3 = color or Color3.fromRGB(0, 150, 255)
    notif.BackgroundTransparency = 0.2
    notif.BorderSizePixel = 0
    notif.Parent = gui
    
    uiCorner(notif, 10)
    uiStroke(notif, Color3.fromRGB(255, 255, 255), 1)
    
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
        Position = UDim2.new(0.5, -100 * uiScale, 0, 20 * uiScale),
        BackgroundTransparency = 1,
        TextTransparency = 1
    }):Play()
    
    task.wait(2)
    pcall(function() notif:Destroy() end)
end

-- ==================== UI CONTENT BUILDER ====================
function createToggle(parent, y, title, desc, state, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -16, 0, 50 * uiScale)
    frame.Position = UDim2.new(0, 8, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    uiCorner(frame, 8)
    uiStroke(frame, Color3.fromRGB(0, 200, 255), 0.5)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -70, 0, 22 * uiScale)
    titleLabel.Position = UDim2.new(0, 10, 0, 6 * uiScale)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextScaled = true
    titleLabel.Parent = frame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -70, 0, 16 * uiScale)
    descLabel.Position = UDim2.new(0, 10, 0, 28 * uiScale)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextScaled = true
    descLabel.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50 * uiScale, 0, 30 * uiScale)
    btn.Position = UDim2.new(1, -60 * uiScale, 0, 10 * uiScale)
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(80, 80, 80)
    btn.Text = state and "ON" or "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = frame
    
    uiCorner(btn, 6)
    
    local btnState = state
    btn.MouseButton1Click:Connect(function()
        btnState = not btnState
        btn.BackgroundColor3 = btnState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(80, 80, 80)
        btn.Text = btnState and "ON" or "OFF"
        callback(btnState)
    end)
    
    return y + 58 * uiScale
end

function createSlider(parent, y, title, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -16, 0, 55 * uiScale)
    frame.Position = UDim2.new(0, 8, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    uiCorner(frame, 8)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.7, -10, 0, 20 * uiScale)
    titleLabel.Position = UDim2.new(0, 10, 0, 8 * uiScale)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextScaled = true
    titleLabel.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.3, -10, 0, 20 * uiScale)
    valueLabel.Position = UDim2.new(0.7, 0, 0, 8 * uiScale)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextScaled = true
    valueLabel.Parent = frame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -20, 0, 10 * uiScale)
    sliderBg.Position = UDim2.new(0, 10, 0, 35 * uiScale)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = frame
    
    uiCorner(sliderBg, 5)
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    uiCorner(sliderFill, 5)
    
    local sliderBtn = Instance.new("TextButton")
    sliderBtn.Size = UDim2.new(0, 20 * uiScale, 0, 20 * uiScale)
    sliderBtn.Position = UDim2.new((default - min) / (max - min), -10 * uiScale, 0, -5 * uiScale)
    sliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBtn.Text = ""
    sliderBtn.BorderSizePixel = 0
    sliderBtn.Parent = sliderBg
    
    uiCorner(sliderBtn, 10)
    
    local dragging = false
    sliderBtn.MouseButton1Down:Connect(function() dragging = true end)
    
    userInput.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    userInput.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = userInput:GetMouseLocation()
            local sliderPos = sliderBg.AbsolutePosition
            local sliderSize = sliderBg.AbsoluteSize.X
            
            local relativeX = math.clamp(mousePos.X - sliderPos.X, 0, sliderSize)
            local newValue = math.floor(min + (relativeX / sliderSize) * (max - min))
            
            valueLabel.Text = tostring(newValue)
            sliderFill.Size = UDim2.new(relativeX / sliderSize, 0, 1, 0)
            sliderBtn.Position = UDim2.new(relativeX / sliderSize, -10 * uiScale, 0, -5 * uiScale)
            
            callback(newValue)
        end
    end)
    
    return y + 63 * uiScale
end

function createPlayerList(parent, y)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -16, 0, 150 * uiScale)
    frame.Position = UDim2.new(0, 8, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    uiCorner(frame, 8)
    
    local listLabel = Instance.new("TextLabel")
    listLabel.Size = UDim2.new(1, -10, 0, 25 * uiScale)
    listLabel.Position = UDim2.new(0, 5, 0, 5 * uiScale)
    listLabel.BackgroundTransparency = 1
    listLabel.Text = "👥 PLAYER LIST:"
    listLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    listLabel.TextXAlignment = Enum.TextXAlignment.Left
    listLabel.Font = Enum.Font.GothamBold
    listLabel.TextScaled = true
    listLabel.Parent = frame
    
    local listFrame = Instance.new("ScrollingFrame")
    listFrame.Size = UDim2.new(1, -10, 0, 100 * uiScale)
    listFrame.Position = UDim2.new(0, 5, 0, 35 * uiScale)
    listFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    listFrame.BackgroundTransparency = 0.5
    listFrame.BorderSizePixel = 0
    listFrame.ScrollBarThickness = 4
    listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    listFrame.Parent = frame
    
    uiCorner(listFrame, 6)
    
    local listY = 5
    local players = game:GetService("Players"):GetPlayers()
    
    for _, plr in ipairs(players) do
        if plr ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 30 * uiScale)
            btn.Position = UDim2.new(0, 5, 0, listY)
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            btn.Text = plr.Name .. "  [TP]"
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextScaled = true
            btn.Font = Enum.Font.Gotham
            btn.BorderSizePixel = 0
            btn.Parent = listFrame
            
            uiCorner(btn, 6)
            
            btn.MouseButton1Click:Connect(function()
                teleportToPlayer(plr)
            end)
            
            listY = listY + 35 * uiScale
        end
    end
    
    listFrame.CanvasSize = UDim2.new(0, 0, 0, listY + 10)
    
    return y + 160 * uiScale
end

-- ==================== TAB CONTENT ====================
function switchTab(index)
    for _, v in ipairs(content:GetChildren()) do
        v:Destroy()
    end
    
    local y = 8 * uiScale
    
    if index == 1 then -- GHOST TAB
        y = createToggle(content, y, "👻 LASER GHOST MODE", "Tembus laser & anti damage", laserGhost, function(state)
            toggleLaserGhost(state)
            showNotification(state and "Laser Ghost ON" or "Laser Ghost OFF", Color3.fromRGB(0, 200, 255))
        end)
        
        y = createToggle(content, y, "🛡️ STEAL PROTECTION", "Brainrot ga balik kalo dipukul", stealProtection, function(state)
            toggleStealProtection(state)
            showNotification(state and "Steal Protection ON" or "Steal Protection OFF", Color3.fromRGB(255, 200, 0))
        end)
        
        local info = Instance.new("TextLabel")
        info.Size = UDim2.new(1, -20, 0, 60 * uiScale)
        info.Position = UDim2.new(0, 10, 0, y)
        info.BackgroundTransparency = 1
        info.Text = "✨ EFFECTS:\n• Tembus semua laser\n• No damage from hazards\n• Brainrot stay in backpack\n• Ghost visual effect"
        info.TextColor3 = Color3.fromRGB(200, 200, 255)
        info.TextXAlignment = Enum.TextXAlignment.Left
        info.TextYAlignment = Enum.TextYAlignment.Top
        info.Font = Enum.Font.Gotham
        info.TextScaled = true
        info.RichText = true
        info.Parent = content
        y = y + 65 * uiScale
        
    elseif index == 2 then -- LOCK TAB
        y = createToggle(content, y, "🏰 AUTO LOCK BASE", "Base otomatis kebal serangan", baseLock, function(state)
            toggleBaseLock(state)
            showNotification(state and "Base Locked" or "Base Unlocked", Color3.fromRGB(100, 100, 255))
        end)
        
        y = createToggle(content, y, "👁️ ESP PLAYER", "Lihat player melalui tembok", espEnabled, function(state)
            toggleESP(state)
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
        
    elseif index == 3 then -- RADIUS TAB
        y = createToggle(content, y, "📡 RADIUS DETECTION", "Deteksi player & brainrot dalam radius", radiusEnabled, function(state)
            toggleRadius(state)
        end)
        
        y = createSlider(content, y, "RADIUS VALUE", 10, 100, radiusValue, function(val)
            radiusValue = val
        end)
        
        local radiusInfo = Instance.new("TextLabel")
        radiusInfo.Size = UDim2.new(1, -20, 0, 50 * uiScale)
        radiusInfo.Position = UDim2.new(0, 10, 0, y)
        radiusInfo.BackgroundTransparency = 1
        radiusInfo.Text = "🎯 RADIUS EFFECT:\n• Player in radius = red warning\n• Brainrot in radius = green glow"
        radiusInfo.TextColor3 = Color3.fromRGB(150, 255, 150)
        radiusInfo.TextXAlignment = Enum.TextXAlignment.Left
        radiusInfo.TextYAlignment = Enum.TextYAlignment.Top
        radiusInfo.Font = Enum.Font.Gotham
        radiusInfo.TextScaled = true
        radiusInfo.RichText = true
        radiusInfo.Parent = content
        y = y + 55 * uiScale
        
    elseif index == 4 then -- TP TAB
        y = createPlayerList(content, y)
        
        local tpInfo = Instance.new("TextLabel")
        tpInfo.Size = UDim2.new(1, -20, 0, 40 * uiScale)
        tpInfo.Position = UDim2.new(0, 10, 0, y)
        tpInfo.BackgroundTransparency = 1
        tpInfo.Text = "⚡ Click player name to teleport\n📍 Teleport ke player manapun"
        tpInfo.TextColor3 = Color3.fromRGB(255, 255, 100)
        tpInfo.TextXAlignment = Enum.TextXAlignment.Left
        tpInfo.TextYAlignment = Enum.TextYAlignment.Top
        tpInfo.Font = Enum.Font.Gotham
        tpInfo.TextScaled = true
        tpInfo.RichText = true
        tpInfo.Parent = content
        y = y + 45 * uiScale
    end
    
    content.CanvasSize = UDim2.new(0, 0, 0, y + 20 * uiScale)
end

-- Tab switching
for i, btn in ipairs(tabBtns) do
    btn.MouseButton1Click:Connect(function()
        for _, b in ipairs(tabBtns) do
            tweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 35)}):Play()
        end
        tweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 80)}):Play()
        switchTab(i)
    end)
end

-- Initial tab
tabBtns[1].BackgroundColor3 = Color3.fromRGB(50, 50, 80)
switchTab(1)

-- Anti-AFK [citation:3]
spawn(function()
    while wait(30) do
        pcall(function()
            virtualUser:CaptureController()
            virtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

-- Welcome notification
showNotification("🧠 LASER GHOST V5 LOADED", Color3.fromRGB(0, 200, 255))
