--[[
╔════════════════════════════════════════════════════╗
║     BRAINROT TSUNAMI HUB - EXTREME EDITION        ║
║         for Delta Executor | Tsunami Brainrot     ║
║                  FITUR GILA + GOD MODE            ║
╚════════════════════════════════════════════════════╝
]]

-- Anti-kick & Bypass
local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local virtualUser = game:GetService("VirtualUser")
local virtualInput = game:GetService("VirtualInputManager")
local tweenService = game:GetService("TweenService")
local coreGui = game:GetService("CoreGui")

-- Block all kicks
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "Kick" then
        return warn("[ANTI-KICK] Server tried to kick you")
    end
    return oldNamecall(...)
end)
setreadonly(mt, true)

-- Create GUI (RAM - TIPIS BANGET)
local gui = Instance.new("ScreenGui")
gui.Name = "TsunamiHub"
gui.Parent = coreGui
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN FRAME (KECIL & RAPIH)
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 280, 0, 380)
main.Position = UDim2.new(0.5, -140, 0.5, -190)
main.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
main.BackgroundTransparency = 0.1
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

-- NEON BORDER (BIAR KEREN)
local border = Instance.new("Frame")
border.Size = UDim2.new(1, 0, 1, 0)
border.BackgroundTransparency = 1
border.BorderSizePixel = 2
border.BorderColor3 = Color3.fromRGB(0, 200, 255)
border.Parent = main

-- HEADER (BISA DRAG)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
header.BorderSizePixel = 0
header.Parent = main

-- HEADER GRADIENT
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
})
gradient.Rotation = 90
gradient.Parent = header

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌊 TSUNAMI HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- CLOSE BUTTON
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -25, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- DRAG FUNCTION
local dragging = false
local dragInput, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
userInput.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- TAB BUTTONS (COMPACT)
local tabs = {"🔥 MAIN", "💀 GOD"}
local tabBtns = {}
for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.5, -2, 0, 30)
    btn.Position = UDim2.new((i-1) * 0.5, i == 1 and 2 or 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = main
    table.insert(tabBtns, btn)
end

-- CONTENT FRAME (SCROLL LANCAR)
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -10, 0, 300)
content.Position = UDim2.new(0, 5, 0, 70)
content.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
content.BackgroundTransparency = 0.5
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.Parent = main

-- ==================== FITUR GILA ====================

-- GOD MODE (NO CD)
local godMode = false
local godConnection

function toggleGodMode(state)
    godMode = state
    if godMode then
        godConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                -- Reset semua cooldown & stamina
                local character = player.Character
                if character then
                    for _, v in ipairs(character:GetDescendants()) do
                        if v:IsA("NumberValue") and (v.Name:lower():match("cooldown") or v.Name:lower():match("stamina")) then
                            v.Value = 0
                        end
                        if v:IsA("BoolValue") and v.Name:lower():match("can") then
                            v.Value = true
                        end
                    end
                end
                -- God mode effect
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.MaxHealth = 9e9
                    character.Humanoid.Health = 9e9
                end
            end)
        end)
    else
        if godConnection then godConnection:Disconnect() end
    end
end

-- SPEED X10000
local speedValue = 10000
local speedConnection

function toggleSpeed(state)
    if state then
        speedConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = speedValue
                    -- Force update movement
                    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
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

-- INFINITE JUMP
local infiniteJump = false
local jumpConnection

userInput.JumpRequest:Connect(function()
    if infiniteJump and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- NO FALL DAMAGE
local noFallConnection

function toggleNoFall(state)
    if noFallConnection then noFallConnection:Disconnect() end
    if state then
        noFallConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
                    player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                end
            end)
        end)
    else
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            end
        end)
    end
end

-- AUTO WIN TSUNAMI
local autoWin = false
local winConnection

function toggleAutoWin(state)
    autoWin = state
    if winConnection then winConnection:Disconnect() end
    if autoWin then
        winConnection = runService.Heartbeat:Connect(function()
            pcall(function()
                -- Cari trigger tsunami/win
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Part") and (obj.Name:lower():match("win") or obj.Name:lower():match("finish") or obj.Name:lower():match("tsunami") and obj:FindFirstChild("TouchInterest")) then
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            player.Character.HumanoidRootPart.CFrame = obj.CFrame
                        end
                    end
                end
            end)
        end)
    end
end

-- NUKE MAP (GOD MODE + CLEAR OBSTACLES)
function nukeMap()
    pcall(function()
        -- Destroy semua obstacle
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Part") and obj.Parent ~= player.Character and not obj.Name:lower():match("base") and not obj.Name:lower():match("spawn") then
                if obj:FindFirstChild("TouchInterest") or obj:FindFirstChild("ClickDetector") then
                    obj:Destroy()
                end
            end
        end
    end)
end

-- TP TO PLAYERS
function teleportToPlayer(target)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
    end
end

-- ==================== UI CONTENT ====================

function switchTab(tab)
    -- Clear content
    for _, v in ipairs(content:GetChildren()) do
        v:Destroy()
    end
    
    local y = 5
    
    if tab == "🔥 MAIN" then
        -- Speed toggle
        y = createToggle(content, y, "⚡ SPEED X10000", speedConnection ~= nil, function(state)
            toggleSpeed(state)
        end)
        
        -- Infinite Jump
        y = createToggle(content, y, "🚀 INFINITE JUMP", infiniteJump, function(state)
            infiniteJump = state
        end)
        
        -- No Fall Damage
        y = createToggle(content, y, "❌ NO FALL", noFallConnection ~= nil, function(state)
            toggleNoFall(state)
        end)
        
        -- Auto Win Tsunami
        y = createToggle(content, y, "🏆 AUTO WIN", autoWin, function(state)
            toggleAutoWin(state)
        end)
        
        -- Nuke Button
        y = createButton(content, y, "💥 NUKE MAP", function()
            nukeMap()
        end)
        
        -- Player list for TP
        local playerLabel = Instance.new("TextLabel")
        playerLabel.Size = UDim2.new(1, -10, 0, 20)
        playerLabel.Position = UDim2.new(0, 5, 0, y)
        playerLabel.BackgroundTransparency = 1
        playerLabel.Text = "📋 PLAYER LIST:"
        playerLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
        playerLabel.TextXAlignment = Enum.TextXAlignment.Left
        playerLabel.Font = Enum.Font.GothamBold
        playerLabel.TextScaled = true
        playerLabel.Parent = content
        y = y + 25
        
        for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
            if plr ~= player then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -10, 0, 25)
                btn.Position = UDim2.new(0, 5, 0, y)
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                btn.Text = plr.Name
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.TextScaled = true
                btn.Font = Enum.Font.Gotham
                btn.BorderSizePixel = 0
                btn.Parent = content
                
                btn.MouseButton1Click:Connect(function()
                    teleportToPlayer(plr)
                end)
                
                y = y + 28
            end
        end
        
    elseif tab == "💀 GOD" then
        -- God Mode
        y = createToggle(content, y, "👑 GOD MODE", godMode, function(state)
            toggleGodMode(state)
        end)
        
        -- Anti Kick (already active)
        y = createLabel(content, y, "✅ ANTI-KICK ACTIVE")
        
        -- God mode description
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(1, -10, 0, 40)
        desc.Position = UDim2.new(0, 5, 0, y)
        desc.BackgroundTransparency = 1
        desc.Text = "GOD MODE:\n• No cooldowns\n• Infinite health\n• Unli stamina"
        desc.TextColor3 = Color3.fromRGB(200, 200, 200)
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.TextYAlignment = Enum.TextYAlignment.Top
        desc.Font = Enum.Font.Gotham
        desc.TextScaled = true
        desc.RichText = true
        desc.Parent = content
        y = y + 45
    end
    
    content.CanvasSize = UDim2.new(0, 0, 0, y + 10)
end

-- Helper functions
function createToggle(parent, y, text, state, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 30)
    frame.Position = UDim2.new(0, 5, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 24)
    btn.Position = UDim2.new(1, -55, 0, 3)
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(80, 80, 80)
    btn.Text = state and "ON" or "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = frame
    
    local btnState = state
    btn.MouseButton1Click:Connect(function()
        btnState = not btnState
        btn.BackgroundColor3 = btnState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(80, 80, 80)
        btn.Text = btnState and "ON" or "OFF"
        callback(btnState)
    end)
    
    return y + 35
end

function createButton(parent, y, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = parent
    
    btn.MouseButton1Click:Connect(callback)
    
    return y + 40
end

function createLabel(parent, y, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 25)
    label.Position = UDim2.new(0, 5, 0, y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(100, 255, 100)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = parent
    
    return y + 30
end

-- Tab switching
tabBtns[1].MouseButton1Click:Connect(function()
    tabBtns[1].BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    tabBtns[2].BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    switchTab("🔥 MAIN")
end)

tabBtns[2].MouseButton1Click:Connect(function()
    tabBtns[2].BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    tabBtns[1].BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    switchTab("💀 GOD")
end)

-- Initial tab
tabBtns[1].BackgroundColor3 = Color3.fromRGB(50, 50, 80)
switchTab("🔥 MAIN")

-- Anti-AFK
spawn(function()
    while wait(60) do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            virtualUser:CaptureController()
            virtualUser:ClickButton2(Vector2.new())
        end
    end
end)

-- Notification
local notif = Instance.new("TextLabel")
notif.Size = UDim2.new(0, 200, 0, 40)
notif.Position = UDim2.new(0.5, -100, 0, 20)
notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notif.BackgroundTransparency = 0.3
notif.Text = "✅ TSUNAMI HUB LOADED!"
notif.TextColor3 = Color3.fromRGB(0, 255, 100)
notif.TextScaled = true
notif.Font = Enum.Font.GothamBold
notif.BorderSizePixel = 0
notif.Parent = gui

tweenService:Create(notif, TweenInfo.new(3, Enum.EasingStyle.Quad), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
wait(3)
notif:Destroy()
