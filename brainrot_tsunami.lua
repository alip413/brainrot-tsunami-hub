--[[
╔══════════════════════════════════════════════════════════════╗
║         BRAINROT TSUNAMI HUB V3 - GHOST EDITION              ║
║              Ghost Mode + Minimize Circle + Dupe             ║
║                    for Delta Executor                        ║
╚══════════════════════════════════════════════════════════════╝
]]

local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local virtualUser = game:GetService("VirtualUser")
local virtualInput = game:GetService("VirtualInputManager")
local tweenService = game:GetService("TweenService")
local coreGui = game:GetService("CoreGui")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Anti-kick
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    if method == "Kick" then
        return warn("[ANTI-KICK] Server kick blocked")
    end
    return oldNamecall(...)
end)
setreadonly(mt, true)

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TsunamiHubV3"
gui.Parent = coreGui
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999

-- ==================== MINIMIZE CIRCLE ====================
local circleBtn = Instance.new("TextButton")
circleBtn.Name = "MinimizeCircle"
circleBtn.Size = UDim2.new(0, 50, 0, 50)
circleBtn.Position = UDim2.new(1, -70, 1, -80)
circleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
circleBtn.BackgroundTransparency = 0.2
circleBtn.Text = "🌊"
circleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
circleBtn.TextScaled = true
circleBtn.Font = Enum.Font.GothamBold
circleBtn.BorderSizePixel = 0
circleBtn.Visible = false
circleBtn.Parent = gui

-- Circle gradient
local circleGradient = Instance.new("UIGradient")
circleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
})
circleGradient.Rotation = 90
circleGradient.Parent = circleBtn

-- Circle shadow
local circleShadow = Instance.new("ImageLabel")
circleShadow.Size = UDim2.new(1.2, 0, 1.2, 0)
circleShadow.Position = UDim2.new(-0.1, 0, -0.1, 0)
circleShadow.BackgroundTransparency = 1
circleShadow.Image = "rbxassetid://1316045217"
circleShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
circleShadow.ImageTransparency = 0.5
circleShadow.Parent = circleBtn

-- Make circle round
local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = circleBtn

-- ==================== MAIN UI ====================
local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.new(0, 300, 0, 450)
main.Position = UDim2.new(0.5, -150, 0.5, -225)
main.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
main.BackgroundTransparency = 0.1
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

-- Main shadow
local mainShadow = Instance.new("ImageLabel")
mainShadow.Size = UDim2.new(1.1, 0, 1.1, 0)
mainShadow.Position = UDim2.new(-0.05, 0, -0.05, 0)
mainShadow.BackgroundTransparency = 1
mainShadow.Image = "rbxassetid://1316045217"
mainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
mainShadow.ImageTransparency = 0.7
mainShadow.Parent = main

-- Corner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = main

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
header.BorderSizePixel = 0
header.Parent = main

-- Header corner
local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = header

-- Header gradient
local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
})
headerGradient.Rotation = 90
headerGradient.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌊 GHOST HUB V3"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Minimize button (to circle)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
minimizeBtn.Position = UDim2.new(1, -55, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
minimizeBtn.Text = "⏺"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.TextScaled = true
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = header

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -25, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Minimize function
minimizeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    circleBtn.Visible = true
    -- Animasi circle muncul
    circleBtn.Size = UDim2.new(0, 0, 0, 0)
    tweenService:Create(circleBtn, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 50, 0, 50)}):Play()
end)

-- Maximize from circle
circleBtn.MouseButton1Click:Connect(function()
    circleBtn.Visible = false
    main.Visible = true
    -- Animasi main muncul
    main.Size = UDim2.new(0, 0, 0, 0)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    tweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 300, 0, 450),
        Position = UDim2.new(0.5, -150, 0.5, -225)
    }):Play()
end)

-- DRAG FUNCTION
local dragging = false
local dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)
header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
userInput.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Tabs
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, 40)
tabFrame.Position = UDim2.new(0, 0, 0, 40)
tabFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = main

local tabs = {"👻 GHOST", "🔄 DUPE", "⚡ SPEED"}
local tabBtns = {}
for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/3, -2, 1, -4)
    btn.Position = UDim2.new((i-1)/3, i == 1 and 2 or (i == 2 and 1 or 0), 0, 2)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = tabFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = btn
    
    table.insert(tabBtns, btn)
end

-- Content
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -10, 0, 340)
content.Position = UDim2.new(0, 5, 0, 85)
content.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
content.BackgroundTransparency = 0.5
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.Parent = main

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 8)
contentCorner.Parent = content

-- ==================== GHOST MODE ====================
local ghostMode = false
local ghostConnection
local originalCanCollide = {}

function toggleGhost(state)
    ghostMode = state
    if ghostConnection then ghostConnection:Disconnect() end
    
    if ghostMode then
        ghostConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                local character = player.Character
                if character then
                    -- Save original collide states and set all parts to no collide
                    for _, part in ipairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            if not originalCanCollide[part] then
                                originalCanCollide[part] = part.CanCollide
                            end
                            part.CanCollide = false
                            part.Transparency = math.min(part.Transparency + 0.3, 0.7)
                        end
                    end
                    
                    -- Ghost effect: semi-transparent
                    if character:FindFirstChild("Humanoid") then
                        character.Humanoid.WalkSpeed = character.Humanoid.WalkSpeed -- maintain speed
                    end
                end
            end)
        end)
    else
        -- Restore original states
        pcall(function()
            local character = player.Character
            if character then
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

-- ==================== DUPE BRAINROT ====================
local dupeActive = false
local dupeConnection
local selectedBrainrot = nil

function getHeldBrainrot()
    -- Cek brainrot yang dipegang player
    local character = player.Character
    if character then
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") and tool.Name:lower():match("brainrot") then
                return tool
            end
        end
        -- Cek di backpack
        for _, tool in ipairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name:lower():match("brainrot") then
                return tool
            end
        end
    end
    return nil
end

function duplicateBrainrot()
    local held = getHeldBrainrot()
    if not held then
        warn("[DUPE] No brainrot found in hand/backpack")
        return false
    end
    
    pcall(function()
        -- Method 1: Clone langsung (untuk game tertentu)
        local clone = held:Clone()
        clone.Parent = player.Backpack
        clone.Name = held.Name .. " (DUPE)"
        
        -- Method 2: Trigger remote event (untuk game yang pakai sistem dupe)
        for _, remote in ipairs(replicatedStorage:GetDescendants()) do
            if remote:IsA("RemoteEvent") and (remote.Name:lower():match("dupe") or remote.Name:lower():match("clone") or remote.Name:lower():match("duplicate")) then
                remote:FireServer(held)
            end
        end
        
        -- Method 3: Spawn di base
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = player.Character.HumanoidRootPart.Position + Vector3.new(2, 1, 0)
            local newBrainrot = held:Clone()
            newBrainrot.Parent = workspace
            if newBrainrot:IsA("Tool") then
                newBrainrot.Grip = CFrame.new(pos)
                newBrainrot:SetPrimaryPartCFrame(CFrame.new(pos))
            end
        end
    end)
    
    return true
end

function startAutoDupe(state)
    dupeActive = state
    if dupeConnection then dupeConnection:Disconnect() end
    
    if dupeActive then
        dupeConnection = runService.Heartbeat:Connect(function()
            duplicateBrainrot()
            task.wait(0.5) -- Delay antar dupe biar nggak overload
        end)
    end
end

-- ==================== SPEED X10000 ====================
local speedValue = 10000
local speedConnection

function toggleSpeed(state)
    if state then
        speedConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = speedValue
                end
            end)
        end)
    else
        if speedConnection then
            speedConnection:Disconnect()
            pcall(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = 16
                end
            end)
        end
    end
end

-- ==================== UI CONTENT ====================
function switchTab(tabIndex)
    for _, v in ipairs(content:GetChildren()) do
        v:Destroy()
    end
    
    local y = 10
    
    if tabIndex == 1 then -- GHOST TAB
        -- Ghost mode toggle
        y = createToggle(content, y, "👻 GHOST MODE", "Tembus tsunami & noclip", ghostMode, function(state)
            toggleGhost(state)
        end)
        
        -- Ghost description
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(1, -20, 0, 50)
        desc.Position = UDim2.new(0, 10, 0, y)
        desc.BackgroundTransparency = 1
        desc.Text = "• Tembus tsunami\n• No damage\n• Semi-transparent"
        desc.TextColor3 = Color3.fromRGB(200, 200, 255)
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.TextYAlignment = Enum.TextYAlignment.Top
        desc.Font = Enum.Font.Gotham
        desc.TextScaled = true
        desc.RichText = true
        desc.Parent = content
        y = y + 55
        
        -- No fall damage
        y = createToggle(content, y, "❌ NO FALL DAMAGE", "Nggak mati kalo jatuh", false, function(state)
            if state then
                runService.Heartbeat:Connect(function()
                    pcall(function()
                        if player.Character and player.Character:FindFirstChild("Humanoid") then
                            player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
                            player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                        end
                    end)
                end)
            end
        end)
        
    elseif tabIndex == 2 then -- DUPE TAB
        -- Current brainrot info
        local infoFrame = Instance.new("Frame")
        infoFrame.Size = UDim2.new(1, -20, 0, 60)
        infoFrame.Position = UDim2.new(0, 10, 0, y)
        infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        infoFrame.BackgroundTransparency = 0.3
        infoFrame.BorderSizePixel = 0
        infoFrame.Parent = content
        
        local infoCorner = Instance.new("UICorner")
        infoCorner.CornerRadius = UDim.new(0, 5)
        infoCorner.Parent = infoFrame
        
        local infoTitle = Instance.new("TextLabel")
        infoTitle.Size = UDim2.new(1, -10, 0, 20)
        infoTitle.Position = UDim2.new(0, 5, 0, 5)
        infoTitle.BackgroundTransparency = 1
        infoTitle.Text = "🔍 CURRENT BRAINROT:"
        infoTitle.TextColor3 = Color3.fromRGB(150, 150, 255)
        infoTitle.TextXAlignment = Enum.TextXAlignment.Left
        infoTitle.Font = Enum.Font.GothamBold
        infoTitle.TextScaled = true
        infoTitle.Parent = infoFrame
        
        local brainrotName = Instance.new("TextLabel")
        brainrotName.Size = UDim2.new(1, -10, 0, 25)
        brainrotName.Position = UDim2.new(0, 5, 0, 30)
        brainrotName.BackgroundTransparency = 1
        brainrotName.Text = "Loading..."
        brainrotName.TextColor3 = Color3.fromRGB(0, 255, 200)
        brainrotName.TextXAlignment = Enum.TextXAlignment.Left
        brainrotName.Font = Enum.Font.GothamBold
        brainrotName.TextScaled = true
        brainrotName.Parent = infoFrame
        
        -- Update brainrot info periodically
        spawn(function()
            while infoFrame and infoFrame.Parent do
                local held = getHeldBrainrot()
                if held then
                    brainrotName.Text = held.Name
                else
                    brainrotName.Text = "No brainrot detected"
                end
                task.wait(1)
            end
        end)
        
        y = y + 70
        
        -- Manual dupe button
        y = createButton(content, y, "🔄 DUPE NOW", function()
            if duplicateBrainrot() then
                local notif = createNotification("✅ Duplicated!", Color3.fromRGB(0, 255, 0))
                notif.Parent = gui
                task.wait(1.5)
                notif:Destroy()
            else
                local notif = createNotification("❌ No brainrot found", Color3.fromRGB(255, 0, 0))
                notif.Parent = gui
                task.wait(1.5)
                notif:Destroy()
            end
        end)
        
        -- Auto dupe toggle
        y = createToggle(content, y, "⚡ AUTO DUPE", "Duplicate terus menerus", dupeActive, function(state)
            startAutoDupe(state)
        end)
        
        -- Dupe info
        local dupeInfo = Instance.new("TextLabel")
        dupeInfo.Size = UDim2.new(1, -20, 0, 40)
        dupeInfo.Position = UDim2.new(0, 10, 0, y)
        dupeInfo.BackgroundTransparency = 1
        dupeInfo.Text = "⚠️ Auto dupe setiap 0.5 detik\nPastikan punya cukup inventory space"
        dupeInfo.TextColor3 = Color3.fromRGB(255, 255, 100)
        dupeInfo.TextScaled = true
        dupeInfo.Font = Enum.Font.Gotham
        dupeInfo.Parent = content
        y = y + 45
        
    elseif tabIndex == 3 then -- SPEED TAB
        -- Speed x10000 toggle
        y = createToggle(content, y, "⚡ SPEED X10000", "Lari secepat kilat", speedConnection ~= nil, function(state)
            toggleSpeed(state)
        end)
        
        -- Speed slider
        y = createSlider(content, y, "SPEED VALUE", 16, 50000, speedValue, function(val)
            speedValue = val
            if speedConnection then
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = val
                end
            end
        end)
        
        -- Infinite jump
        local infiniteJump = false
        y = createToggle(content, y, "🚀 INFINITE JUMP", "Lompat terus tanpa batas", infiniteJump, function(state)
            infiniteJump = state
            if infiniteJump then
                userInput.JumpRequest:Connect(function()
                    if infiniteJump and player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
            end
        end)
    end
    
    content.CanvasSize = UDim2.new(0, 0, 0, y + 20)
end

-- Helper functions
function createToggle(parent, y, text, desc, state, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 45)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 5)
    frameCorner.Parent = frame
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -70, 0, 20)
    textLabel.Position = UDim2.new(0, 10, 0, 5)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextScaled = true
    textLabel.Parent = frame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -70, 0, 15)
    descLabel.Position = UDim2.new(0, 10, 0, 25)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextScaled = true
    descLabel.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 30)
    btn.Position = UDim2.new(1, -60, 0, 7)
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(80, 80, 80)
    btn.Text = state and "ON" or "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    local btnState = state
    btn.MouseButton1Click:Connect(function()
        btnState = not btnState
        btn.BackgroundColor3 = btnState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(80, 80, 80)
        btn.Text = btnState and "ON" or "OFF"
        callback(btnState)
    end)
    
    return y + 50
end

function createButton(parent, y, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = parent
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    
    return y + 45
end

function createSlider(parent, y, text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 50)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 5)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, -10, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.5, -10, 0, 20)
    valueLabel.Position = UDim2.new(0.5, 0, 0, 5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextScaled = true
    valueLabel.Parent = frame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -20, 0, 10)
    sliderBg.Position = UDim2.new(0, 10, 0, 30)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = frame
    
    local sliderBgCorner = Instance.new("UICorner")
    sliderBgCorner.CornerRadius = UDim.new(0, 5)
    sliderBgCorner.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(0, 5)
    sliderFillCorner.Parent = sliderFill
    
    local sliderBtn = Instance.new("TextButton")
    sliderBtn.Size = UDim2.new(0, 20, 0, 20)
    sliderBtn.Position = UDim2.new((default - min) / (max - min), -10, 0, -5)
    sliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBtn.Text = ""
    sliderBtn.BorderSizePixel = 0
    sliderBtn.Parent = sliderBg
    
    local sliderBtnCorner = Instance.new("UICorner")
    sliderBtnCorner.CornerRadius = UDim.new(1, 0)
    sliderBtnCorner.Parent = sliderBtn
    
    local dragging = false
    sliderBtn.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
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
            sliderBtn.Position = UDim2.new(relativeX / sliderSize, -10, 0, -5)
            
            callback(newValue)
        end
    end)
    
    return y + 55
end

function createNotification(text, color)
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 200, 0, 40)
    notif.Position = UDim2.new(0.5, -100, 0, 100)
    notif.BackgroundColor3 = color or Color3.fromRGB(0, 255, 0)
    notif.BackgroundTransparency = 0.2
    notif.Text = text
    notif.TextColor3 = Color3.fromRGB(255, 255, 255)
    notif.TextScaled = true
    notif.Font = Enum.Font.GothamBold
    notif.BorderSizePixel = 0
    notif.ZIndex = 1000
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 10)
    notifCorner.Parent = notif
    
    return notif
end

-- Tab switching
for i, btn in ipairs(tabBtns) do
    btn.MouseButton1Click:Connect(function()
        for _, b in ipairs(tabBtns) do
            b.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
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
    while wait(60) do
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                virtualUser:CaptureController()
                virtualUser:ClickButton2(Vector2.new())
            end
        end)
    end
end)

-- Welcome notification
local welcome = createNotification("✅ GHOST HUB V3 LOADED", Color3.fromRGB(0, 150, 255))
welcome.Parent = gui
tweenService:Create(welcome, TweenInfo.new(3), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
task.wait(3)
pcall(function() welcome:Destroy() end)
