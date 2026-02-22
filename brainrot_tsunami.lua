--[[
╔══════════════════════════════════════════════════════════════════╗
║                    BRAINROT TSUNAMI HUB v2.0                     ║
║                     specialized for Delta Executor               ║
║                         [ Game: Steal a Brainrot ]               ║
╚══════════════════════════════════════════════════════════════════╝
]]

-- ======================== LOADING SCREEN ========================
local player = game:GetService("Players").LocalPlayer
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local virtualInput = game:GetService("VirtualInputManager")
local coreGui = game:GetService("CoreGui")

-- Anti-kick protection
local function antiKick()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "Kick" then
            return warn("Anti-Kick: Blocked server kick attempt")
        end
        
        return oldNamecall(...)
    end)
    
    setreadonly(mt, true)
end

-- ======================== UI SETUP ========================

-- Create main screen gui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainrotTsunamiHub"
screenGui.Parent = coreGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Loading screen
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 500, 0, 300)
loadingFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
loadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
loadingFrame.BackgroundTransparency = 0.2
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = screenGui

-- Loading gradient
local loadingGradient = Instance.new("UIGradient")
loadingGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
})
loadingGradient.Rotation = 45
loadingGradient.Parent = loadingFrame

-- Loading title
local loadingTitle = Instance.new("TextLabel")
loadingTitle.Size = UDim2.new(1, 0, 0, 50)
loadingTitle.Position = UDim2.new(0, 0, 0, 20)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "BRAINROT TSUNAMI"
loadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingTitle.TextScaled = true
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.Parent = loadingFrame

-- Loading subtitle
local loadingSub = Instance.new("TextLabel")
loadingSub.Size = UDim2.new(1, 0, 0, 30)
loadingSub.Position = UDim2.new(0, 0, 0, 80)
loadingSub.BackgroundTransparency = 1
loadingSub.Text = "LOADING SYSTEM..."
loadingSub.TextColor3 = Color3.fromRGB(200, 200, 255)
loadingSub.TextScaled = true
loadingSub.Font = Enum.Font.Gotham
loadingSub.Parent = loadingFrame

-- Loading bar background
local loadingBarBg = Instance.new("Frame")
loadingBarBg.Size = UDim2.new(0.8, 0, 0, 20)
loadingBarBg.Position = UDim2.new(0.1, 0, 0, 140)
loadingBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
loadingBarBg.BorderSizePixel = 0
loadingBarBg.Parent = loadingFrame

-- Loading bar fill
local loadingBarFill = Instance.new("Frame")
loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
loadingBarFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
loadingBarFill.BorderSizePixel = 0
loadingBarFill.Parent = loadingBarBg

-- Loading bar gradient
local barGradient = Instance.new("UIGradient")
barGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 255))
})
barGradient.Rotation = 45
barGradient.Parent = loadingBarFill

-- Loading percentage
local loadingPercent = Instance.new("TextLabel")
loadingPercent.Size = UDim2.new(1, 0, 0, 30)
loadingPercent.Position = UDim2.new(0, 0, 0, 170)
loadingPercent.BackgroundTransparency = 1
loadingPercent.Text = "0%"
loadingPercent.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingPercent.TextScaled = true
loadingPercent.Font = Enum.Font.GothamBold
loadingPercent.Parent = loadingFrame

-- Loading animation
local loadValue = 0
local loadConnection
loadConnection = runService.Heartbeat:Connect(function()
    loadValue = loadValue + 0.02
    if loadValue >= 1 then
        loadConnection:Disconnect()
        loadingFrame:TweenSizeAndPosition(
            UDim2.new(0, 500, 0, 0),
            UDim2.new(0.5, -250, 0.5, -150),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.5,
            true,
            function()
                loadingFrame:Destroy()
                createMainUI()
            end
        )
    end
    loadingBarFill.Size = UDim2.new(loadValue, 0, 1, 0)
    loadingPercent.Text = math.floor(loadValue * 100) .. "%"
end)

-- ======================== MAIN UI CREATION ========================
function createMainUI()
    -- Main frame dengan efek glass morphism
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 700, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    -- Background blur effect
    local blurEffect = Instance.new("Frame")
    blurEffect.Size = UDim2.new(1, 0, 1, 0)
    blurEffect.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blurEffect.BackgroundTransparency = 0.5
    blurEffect.BorderSizePixel = 0
    blurEffect.Parent = mainFrame
    
    -- Gradient border
    local borderGradient = Instance.new("UIGradient")
    borderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
    })
    borderGradient.Rotation = 90
    borderGradient.Parent = mainFrame
    
    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 60)
    header.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    -- Header gradient
    local headerGradient = Instance.new("UIGradient")
    headerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 255))
    })
    headerGradient.Rotation = 90
    headerGradient.Parent = header
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = "🌊 BRAINROT TSUNAMI HUB"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = header
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 0, 65)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "⚡ Delta Executor Optimized | Steal a Brainrot ⚡"
    subtitle.TextColor3 = Color3.fromRGB(180, 180, 255)
    subtitle.TextScaled = true
    subtitle.Font = Enum.Font.Gotham
    subtitle.Parent = mainFrame
    
    -- Tab buttons
    local tabs = {"⚔️ COMBAT", "💰 FARM", "👁️ ESP", "⚙️ SETTINGS"}
    local tabColors = {
        Color3.fromRGB(255, 70, 70),
        Color3.fromRGB(70, 255, 70),
        Color3.fromRGB(70, 70, 255),
        Color3.fromRGB(255, 255, 70)
    }
    
    local tabButtons = {}
    local currentTab = "COMBAT"
    
    for i, tabName in ipairs(tabs) do
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "Tab" .. tabName
        tabBtn.Size = UDim2.new(0.25, -5, 0, 35)
        tabBtn.Position = UDim2.new((i-1) * 0.25, 2, 0, 90)
        tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        tabBtn.Text = tabName
        tabBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
        tabBtn.TextScaled = true
        tabBtn.Font = Enum.Font.GothamBold
        tabBtn.BorderSizePixel = 0
        tabBtn.Parent = mainFrame
        
        -- Tab hover effect
        tabBtn.MouseEnter:Connect(function()
            if tabBtn.BackgroundColor3 ~= tabColors[i] then
                tabBtn:TweenSize(UDim2.new(0.25, -5, 0, 38), "Out", "Quad", 0.2)
            end
        end)
        
        tabBtn.MouseLeave:Connect(function()
            if tabBtn.BackgroundColor3 ~= tabColors[i] then
                tabBtn:TweenSize(UDim2.new(0.25, -5, 0, 35), "Out", "Quad", 0.2)
            end
        end)
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, btn in ipairs(tabButtons) do
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                btn.TextColor3 = Color3.fromRGB(200, 200, 255)
            end
            tabBtn.BackgroundColor3 = tabColors[i]
            tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            currentTab = string.split(tabName, " ")[2] or string.split(tabName, " ")[1]
            updateContent(currentTab)
        end)
        
        table.insert(tabButtons, tabBtn)
    end
    
    -- Content frame
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, -20, 0, 320)
    contentFrame.Position = UDim2.new(0, 10, 0, 135)
    contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    contentFrame.BackgroundTransparency = 0.5
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 8
    contentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.Parent = mainFrame
    
    -- Content gradient
    local contentGradient = Instance.new("UIGradient")
    contentGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 30))
    })
    contentGradient.Rotation = 90
    contentGradient.Parent = contentFrame
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = header
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Minimize button
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 30, 0, 30)
    minBtn.Position = UDim2.new(1, -70, 0, 5)
    minBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
    minBtn.Text = "−"
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.TextScaled = true
    minBtn.Font = Enum.Font.GothamBold
    minBtn.BorderSizePixel = 0
    minBtn.Parent = header
    
    local minimized = false
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            mainFrame:TweenSize(UDim2.new(0, 700, 0, 60), "Out", "Quad", 0.3)
            contentFrame.Visible = false
            for _, btn in ipairs(tabButtons) do
                btn.Visible = false
            end
            subtitle.Visible = false
        else
            mainFrame:TweenSize(UDim2.new(0, 700, 0, 500), "Out", "Quad", 0.3)
            contentFrame.Visible = true
            for _, btn in ipairs(tabButtons) do
                btn.Visible = true
            end
            subtitle.Visible = true
        end
    end)
    
    -- Draggable functionality
    local dragging = false
    local dragStart
    local startPos
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    userInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- ======================== FEATURE FUNCTIONS ========================
    
    -- Auto Steal
    local autoStealEnabled = false
    local autoStealConnection
    
    function startAutoSteal()
        if autoStealConnection then autoStealConnection:Disconnect() end
        autoStealConnection = runService.Heartbeat:Connect(function()
            if not autoStealEnabled then return end
            
            -- Find nearby players with brainrots
            for _, otherPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (player.Character.HumanoidRootPart.Position - otherPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < 30 then
                        -- Simulate steal action (adjust based on game mechanics)
                        virtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                        task.wait(0.1)
                        virtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                    end
                end
            end
        end)
    end
    
    -- Auto Farm
    local autoFarmEnabled = false
    local farmConnection
    
    function startAutoFarm()
        if farmConnection then farmConnection:Disconnect() end
        farmConnection = runService.Heartbeat:Connect(function()
            if not autoFarmEnabled then return end
            
            -- Auto collect coins/resources
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Part") and obj.Name:find("Coin") or obj.Name:find("Cash") or obj.Name:find("Brainrot") then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = obj.CFrame * CFrame.new(0, 5, 0)
                        task.wait(0.5)
                    end
                end
            end
        end)
    end
    
    -- ESP
    local espEnabled = false
    local espObjects = {}
    
    function toggleESP()
        if espEnabled then
            -- Remove ESP
            for _, obj in ipairs(espObjects) do
                if obj and obj.Parent then
                    obj:Destroy()
                end
            end
            espObjects = {}
        else
            -- Create ESP for players
            for _, otherPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
                if otherPlayer ~= player then
                    createPlayerESP(otherPlayer)
                end
            end
            
            -- Create ESP for brainrots
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name:find("Brainrot") then
                    createObjectESP(obj, Color3.fromRGB(255, 100, 255))
                end
            end
        end
        espEnabled = not espEnabled
    end
    
    function createPlayerESP(plr)
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_" .. plr.Name
        highlight.FillColor = Color3.fromRGB(255, 50, 50)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = plr.Character
        table.insert(espObjects, highlight)
        
        -- Billboard GUI with name
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESPName_" .. plr.Name
        billboard.Size = UDim2.new(0, 100, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = plr.Character:FindFirstChild("Head") or plr.Character:FindFirstChild("HumanoidRootPart")
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = plr.Name .. " ❤️"
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.TextScaled = true
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Parent = billboard
        
        table.insert(espObjects, billboard)
    end
    
    function createObjectESP(obj, color)
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_" .. obj.Name
        highlight.FillColor = color or Color3.fromRGB(100, 255, 100)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = obj
        table.insert(espObjects, highlight)
    end
    
    -- Teleport to base
    function teleportToBase()
        -- Find base location (adjust based on game)
        local baseLocation = Vector3.new(0, 50, 0) -- Default spawn
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Base" or obj.Name == "Spawn" then
                baseLocation = obj.Position
                break
            end
        end
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(baseLocation)
        end
    end
    
    -- No Clip
    local noclipEnabled = false
    local noclipConnection
    
    function toggleNoClip()
        noclipEnabled = not noclipEnabled
        if noclipEnabled then
            noclipConnection = runService.Stepped:Connect(function(_, _)
                if player.Character then
                    for _, part in ipairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                if player.Character then
                    for _, part in ipairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
            end
        end
    end
    
    -- Speed boost
    local speedBoostEnabled = false
    local speedValue = 50
    local speedConnection
    
    function toggleSpeedBoost()
        speedBoostEnabled = not speedBoostEnabled
        if speedBoostEnabled then
            speedConnection = runService.Heartbeat:Connect(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = speedValue
                end
            end)
        else
            if speedConnection then
                speedConnection:Disconnect()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = 16
                end
            end
        end
    end
    
    -- Jump boost
    local jumpBoostEnabled = false
    local jumpValue = 100
    local jumpConnection
    
    function toggleJumpBoost()
        jumpBoostEnabled = not jumpBoostEnabled
        if jumpBoostEnabled then
            jumpConnection = runService.Heartbeat:Connect(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.JumpPower = jumpValue
                end
            end)
        else
            if jumpConnection then
                jumpConnection:Disconnect()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.JumpPower = 50
                end
            end
        end
    end
    
    -- Fly mode
    local flyEnabled = false
    local flyConnection
    local flySpeed = 50
    local bodyGyro, bodyVelocity
    
    function toggleFly()
        flyEnabled = not flyEnabled
        if flyEnabled then
            local character = player.Character
            if not character then return end
            
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            
            if not humanoid or not rootPart then return end
            
            humanoid.PlatformStand = true
            
            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
            bodyGyro.P = 2000
            bodyGyro.D = 100
            bodyGyro.Parent = rootPart
            
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Parent = rootPart
            
            flyConnection = runService.Heartbeat:Connect(function()
                if not flyEnabled then return end
                if not character or not character.Parent then
                    toggleFly()
                    return
                end
                
                local moveDirection = Vector3.new(0, 0, 0)
                if userInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector
                end
                if userInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector
                end
                if userInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector
                end
                if userInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector
                end
                if userInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                end
                if userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    moveDirection = moveDirection + Vector3.new(0, -1, 0)
                end
                
                if moveDirection.Magnitude > 0 then
                    moveDirection = moveDirection.Unit * flySpeed
                end
                
                bodyVelocity.Velocity = moveDirection
                bodyGyro.CFrame = workspace.CurrentCamera.CFrame
            end)
        else
            if flyConnection then
                flyConnection:Disconnect()
            end
            if bodyGyro then bodyGyro:Destroy() end
            if bodyVelocity then bodyVelocity:Destroy() end
            
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.PlatformStand = false
                end
            end
        end
    end
    
    -- ======================== UI CONTENT UPDATE ========================
    
    function updateContent(tab)
        -- Clear content frame
        for _, child in ipairs(contentFrame:GetChildren()) do
            child:Destroy()
        end
        
        local yPos = 10
        
        if tab == "COMBAT" then
            -- Auto Steal toggle
            yPos = createToggle(contentFrame, yPos, "⚡ Auto Steal", "Automatically steal brainrots from nearby players", autoStealEnabled, function(state)
                autoStealEnabled = state
                if state then startAutoSteal() end
            end)
            
            -- No Clip toggle
            yPos = createToggle(contentFrame, yPos, "🔓 No Clip", "Walk through walls and obstacles", noclipEnabled, function(state)
                toggleNoClip()
            end)
            
            -- Fly toggle
            yPos = createToggle(contentFrame, yPos, "🕊️ Fly Mode", "Free flight around the map", flyEnabled, function(state)
                toggleFly()
            end)
            
            -- Teleport button
            yPos = createButton(contentFrame, yPos, "🏠 Teleport to Base", "Instantly return to your base", function()
                teleportToBase()
            end)
            
        elseif tab == "FARM" then
            -- Auto Farm toggle
            yPos = createToggle(contentFrame, yPos, "💰 Auto Farm", "Automatically collect coins and brainrots", autoFarmEnabled, function(state)
                autoFarmEnabled = state
                if state then startAutoFarm() end
            end)
            
            -- Speed Boost toggle with slider
            yPos = createToggle(contentFrame, yPos, "⚡ Speed Boost", "Increase movement speed", speedBoostEnabled, function(state)
                toggleSpeedBoost()
            end)
            
            yPos = createSlider(contentFrame, yPos, "Speed Value", 16, 200, speedValue, function(value)
                speedValue = value
                if speedBoostEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = value
                end
            end)
            
            -- Jump Boost toggle with slider
            yPos = createToggle(contentFrame, yPos, "🚀 Jump Boost", "Increase jump power", jumpBoostEnabled, function(state)
                toggleJumpBoost()
            end)
            
            yPos = createSlider(contentFrame, yPos, "Jump Value", 50, 200, jumpValue, function(value)
                jumpValue = value
                if jumpBoostEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.JumpPower = value
                end
            end)
            
        elseif tab == "ESP" then
            -- ESP toggle
            yPos = createToggle(contentFrame, yPos, "👁️ Enable ESP", "See players and brainrots through walls", espEnabled, function(state)
                toggleESP()
            end)
            
            -- Highlight colors info
            local infoLabel = Instance.new("TextLabel")
            infoLabel.Size = UDim2.new(1, -20, 0, 40)
            infoLabel.Position = UDim2.new(0, 10, 0, yPos)
            infoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            infoLabel.BackgroundTransparency = 0.5
            infoLabel.Text = "🎨 ESP Colors:\n🔴 Players | 🟣 Brainrots | 🟢 Items"
            infoLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
            infoLabel.TextScaled = true
            infoLabel.Font = Enum.Font.Gotham
            infoLabel.BorderSizePixel = 0
            infoLabel.Parent = contentFrame
            yPos = yPos + 45
            
        elseif tab == "SETTINGS" then
            -- Anti-kick
            local antiKickEnabled = true
            yPos = createToggle(contentFrame, yPos, "🛡️ Anti-Kick", "Prevent server from kicking you", antiKickEnabled, function(state)
                if state then
                    antiKick()
                end
            end)
            
            -- UI Theme selector
            local themeLabel = Instance.new("TextLabel")
            themeLabel.Size = UDim2.new(1, -20, 0, 30)
            themeLabel.Position = UDim2.new(0, 10, 0, yPos)
            themeLabel.BackgroundTransparency = 1
            themeLabel.Text = "🎨 UI Theme:"
            themeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            themeLabel.TextXAlignment = Enum.TextXAlignment.Left
            themeLabel.Font = Enum.Font.GothamBold
            themeLabel.Parent = contentFrame
            yPos = yPos + 35
            
            local themes = {"Ocean Blue", "Midnight Purple", "Forest Green", "Sunset Red"}
            local themeButtons = {}
            for i, theme in ipairs(themes) do
                local themeBtn = Instance.new("TextButton")
                themeBtn.Size = UDim2.new(0.25, -10, 0, 30)
                themeBtn.Position = UDim2.new((i-1) * 0.25, 5, 0, yPos)
                themeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
                themeBtn.Text = theme
                themeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                themeBtn.TextScaled = true
                themeBtn.Font = Enum.Font.Gotham
                themeBtn.BorderSizePixel = 0
                themeBtn.Parent = contentFrame
                
                table.insert(themeButtons, themeBtn)
            end
            yPos = yPos + 40
            
            -- Destroy UI button
            yPos = createButton(contentFrame, yPos, "🗑️ Destroy UI", "Close and remove the script", function()
                screenGui:Destroy()
                if autoStealConnection then autoStealConnection:Disconnect() end
                if farmConnection then farmConnection:Disconnect() end
                if noclipConnection then noclipConnection:Disconnect() end
                if flyConnection then flyConnection:Disconnect() end
                if speedConnection then speedConnection:Disconnect() end
                if jumpConnection then jumpConnection:Disconnect() end
            end)
        end
        
        -- Update canvas size
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)
    end
    
    -- Helper function to create toggle
    function createToggle(parent, y, title, desc, defaultState, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -20, 0, 50)
        frame.Position = UDim2.new(0, 10, 0, y)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        frame.BackgroundTransparency = 0.5
        frame.BorderSizePixel = 0
        frame.Parent = parent
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(0.7, -10, 0, 25)
        titleLabel.Position = UDim2.new(0, 10, 0, 5)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextScaled = true
        titleLabel.Parent = frame
        
        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(0.7, -10, 0, 15)
        descLabel.Position = UDim2.new(0, 10, 0, 30)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = desc
        descLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Font = Enum.Font.Gotham
        descLabel.TextScaled = true
        descLabel.Parent = frame
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, 50, 0, 30)
        toggleBtn.Position = UDim2.new(1, -60, 0, 10)
        toggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 100, 100)
        toggleBtn.Text = defaultState and "ON" or "OFF"
        toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleBtn.TextScaled = true
        toggleBtn.Font = Enum.Font.GothamBold
        toggleBtn.BorderSizePixel = 0
        toggleBtn.Parent = frame
        
        local state = defaultState
        toggleBtn.MouseButton1Click:Connect(function()
            state = not state
            toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 100, 100)
            toggleBtn.Text = state and "ON" or "OFF"
            callback(state)
        end)
        
        return y + 55
    end
    
    -- Helper function to create button
    function createButton(parent, y, title, desc, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -20, 0, 60)
        frame.Position = UDim2.new(0, 10, 0, y)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        frame.BackgroundTransparency = 0.5
        frame.BorderSizePixel = 0
        frame.Parent = parent
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(0.7, -10, 0, 25)
        titleLabel.Position = UDim2.new(0, 10, 0, 5)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextScaled = true
        titleLabel.Parent = frame
        
        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(0.7, -10, 0, 15)
        descLabel.Position = UDim2.new(0, 10, 0, 30)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = desc
        descLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Font = Enum.Font.Gotham
        descLabel.TextScaled = true
        descLabel.Parent = frame
        
        local actionBtn = Instance.new("TextButton")
        actionBtn.Size = UDim2.new(0, 80, 0, 30)
        actionBtn.Position = UDim2.new(1, -90, 0, 15)
        actionBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        actionBtn.Text = "GO"
        actionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        actionBtn.TextScaled = true
        actionBtn.Font = Enum.Font.GothamBold
        actionBtn.BorderSizePixel = 0
        actionBtn.Parent = frame
        
        actionBtn.MouseButton1Click:Connect(callback)
        
        return y + 65
    end
    
    -- Helper function to create slider
    function createSlider(parent, y, title, min, max, default, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -20, 0, 50)
        frame.Position = UDim2.new(0, 10, 0, y)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        frame.BackgroundTransparency = 0.5
        frame.BorderSizePixel = 0
        frame.Parent = parent
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(0.5, -10, 0, 25)
        titleLabel.Position = UDim2.new(0, 10, 0, 5)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextScaled = true
        titleLabel.Parent = frame
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0, 50, 0, 25)
        valueLabel.Position = UDim2.new(1, -60, 0, 5)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = tostring(default)
        valueLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        valueLabel.Font = Enum.Font.GothamBold
        valueLabel.TextScaled = true
        valueLabel.Parent = frame
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(0.8, -10, 0, 10)
        sliderBg.Position = UDim2.new(0, 10, 0, 35)
        sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = frame
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        sliderFill.BorderSizePixel = 0
        sliderFill.Parent = sliderBg
        
        local sliderButton = Instance.new("TextButton")
        sliderButton.Size = UDim2.new(0, 20, 0, 20)
        sliderButton.Position = UDim2.new((default - min) / (max - min), -10, 0, -5)
        sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        sliderButton.Text = ""
        sliderButton.BorderSizePixel = 0
        sliderButton.Parent = sliderBg
        
        local dragging = false
        sliderButton.MouseButton1Down:Connect(function()
            dragging = true
        end)
        
        userInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        userInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mousePos = userInputService:GetMouseLocation()
                local sliderPos = sliderBg.AbsolutePosition
                local sliderSize = sliderBg.AbsoluteSize.X
                
                local relativeX = math.clamp(mousePos.X - sliderPos.X, 0, sliderSize)
                local newValue = min + (relativeX / sliderSize) * (max - min)
                newValue = math.floor(newValue)
                
                valueLabel.Text = tostring(newValue)
                sliderFill.Size = UDim2.new(relativeX / sliderSize, 0, 1, 0)
                sliderButton.Position = UDim2.new(relativeX / sliderSize, -10, 0, -5)
                
                callback(newValue)
            end
        end)
        
        return y + 55
    end
    
    -- Initialize with Combat tab
    updateContent("COMBAT")
    
    -- Activate anti-kick by default
    antiKick()
end
