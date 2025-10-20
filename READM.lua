--[[

YOUTUBE TUTORIAL: https://www.youtube.com/watch?v=Yb2GXlsTmNM
MADE BY @uerd

]]
Config = {
    api = "bf53180d-34f4-41e1-bded-b1c725fb5593", 
    service = "Premium Key",
    provider = "SeisenPremium"
}

local KeySystemData = {
    Name = "Seisen Hub",
    Colors = {
        Background = Color3.fromRGB(245, 245, 245), -- white background
        Title = Color3.fromRGB(20, 20, 20),         -- black title
        InputField = Color3.fromRGB(255, 255, 255), -- pure white input
        InputFieldBorder = Color3.fromRGB(20, 20, 20), -- black border
        Button = Color3.fromRGB(20, 20, 20),        -- black button
        ButtonHover = Color3.fromRGB(40, 40, 40),   -- dark gray hover
        Error = Color3.fromRGB(20, 20, 20),         -- black error
        Success = Color3.fromRGB(80, 200, 80),      -- green success
        Discord = Color3.fromRGB(20, 20, 20)        -- black discord button
    },
    Service = "Seisen Hub",
    SilentMode = false,
    DiscordInvite = "https://discord.gg/F4sAf6z8Ph",
    WebsiteURL = "https://yourwebsite.com/", -- leave like that
    FileName = "seisen/key.txt"
}

-- Auto-load key from file if present and valid (before any UI)
if getgenv().RedExecutorKeySys then return end
getgenv().RedExecutorKeySys = true

local function main()
    -- Load Ken-884's main.lua after key validation
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Ken-884/roblox/refs/heads/main/premium/main.lua"))()
    end)
    if not success then
        warn("Failed to load main.lua:", err)
    end
end

if isfile and readfile then
    local keyFile = KeySystemData.FileName
    if isfile(keyFile) then
        local savedKey = readfile(keyFile):gsub("%s+", "")
        if savedKey and savedKey ~= "" then
            local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
            local API_KEY = Config.api
            local SERVICE = Config.service
            local isValid = JunkieKeySystem.verifyKey(API_KEY, savedKey, SERVICE)
            if isValid then
                getgenv().RedExecutorKeySys = nil
                main()
                return
            end
        end
    end
end

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local function CreateObject(class, props)
    local obj = Instance.new(class)
    for prop, value in pairs(props) do 
        if prop ~= "Parent" then
            obj[prop] = value
        end
    end
    if props.Parent then
        obj.Parent = props.Parent
    end
    return obj
end

local function SmoothTween(obj, time, properties)
    local tween = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

local ScreenGui = CreateObject("ScreenGui", {
    Name = "RedExecutorKeySystem", 
    Parent = CoreGui, 
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999
})

local MainFrame = CreateObject("Frame", {
    Name = "MainFrame",
    Parent = ScreenGui,
    BackgroundColor3 = KeySystemData.Colors.Background,
    BorderColor3 = KeySystemData.Colors.InputFieldBorder,
    BorderSizePixel = 2,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0, 350, 0, 250),
    ClipsDescendants = true
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 8), Parent = MainFrame})

local CloseButton = CreateObject("TextButton", {
    Name = "CloseButton",
    Parent = MainFrame,
    BackgroundColor3 = Color3.fromRGB(20, 20, 20),
    Text = "✖",
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Size = UDim2.new(0, 32, 0, 32),
    Position = UDim2.new(1, -40, 0, 8),
    AnchorPoint = Vector2.new(0, 0),
    AutoButtonColor = true,
    ZIndex = 10
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 8), Parent = CloseButton})

local TitleBar = CreateObject("Frame", {
    Name = "TitleBar",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.Background,
    Size = UDim2.new(1, 0, 0, 30),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0, 0)
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 8, 0, 0), Parent = TitleBar})

local Title = CreateObject("TextLabel", {
    Name = "Title",
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Text = KeySystemData.Name .. " Key System",
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 200, 0, 20),
    Font = Enum.Font.GothamBold,
    TextColor3 = KeySystemData.Colors.Title,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Center,
    AnchorPoint = Vector2.new(0.5, 0.5)
})

local KeyInput = CreateObject("TextBox", {
    Name = "KeyInput",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.InputField,
    Text = "",
    PlaceholderText = "Enter your key here...",
    Position = UDim2.new(0.5, 0, 0.3, 0),
    Size = UDim2.new(0, 280, 0, 35),
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(220, 220, 220),
    PlaceholderColor3 = Color3.fromRGB(140, 140, 140),
    TextXAlignment = Enum.TextXAlignment.Left,
    AnchorPoint = Vector2.new(0.5, 0),
    ClipsDescendants = true,
    ClearTextOnFocus = false
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = KeyInput})
CreateObject("UIStroke", {
    Parent = KeyInput,
    Color = KeySystemData.Colors.InputFieldBorder,
    Thickness = 1,
    Transparency = 0.8
})
CreateObject("UIPadding", {
    Parent = KeyInput,
    PaddingLeft = UDim.new(0, 10)
})

local SubmitButton = CreateObject("TextButton", {
    Name = "ValidateButton",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.Button,
    BorderColor3 = KeySystemData.Colors.InputFieldBorder,
    BorderSizePixel = 1,
    Position = UDim2.new(0.3, 0, 0.48, 0),
    Size = UDim2.new(0, 110, 0, 32),
    Text = "Verify Key",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0)
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = SubmitButton})

local GetKeyButton = CreateObject("TextButton", {
    Name = "GetKeyButton",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.Button,
    BorderColor3 = KeySystemData.Colors.InputFieldBorder,
    BorderSizePixel = 1,
    Position = UDim2.new(0.7, 0, 0.48, 0),
    Size = UDim2.new(0, 110, 0, 32),
    Text = "Get Key",
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0)
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = GetKeyButton})

local DiscordButton = CreateObject("TextButton", {
    Name = "DiscordButton",
    Parent = MainFrame,
    BackgroundColor3 = Color3.fromRGB(88, 101, 242), -- Discord blue
    Position = UDim2.new(0.5, 0, 0.65, 0),
    Size = UDim2.new(0, 220, 0, 32),
    Text = "Join Discord",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0)
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = DiscordButton})

local PremiumKeyButton = CreateObject("TextButton", {
    Name = "PremiumKeyButton",
    Parent = MainFrame,
    BackgroundColor3 = Color3.fromRGB(242, 153, 74), -- orange for premium
    Position = UDim2.new(0.5, 0, 0.82, 0), -- increased Y for spacing
    Size = UDim2.new(0, 220, 0, 32),
    Text = "Get Premium Key",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0)
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = PremiumKeyButton})

local StatusLabel = CreateObject("TextLabel", {
    Name = "StatusLabel",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0.21, 0),
    Size = UDim2.new(0, 280, 0, 22),
    Font = Enum.Font.Gotham,
    Text = "",
    TextColor3 = KeySystemData.Colors.Error,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Center,
    AnchorPoint = Vector2.new(0.5, 0),
    TextTransparency = 1
})

local function ShowStatusMessage(text, _)
    local green = Color3.fromRGB(0, 255, 0)
    StatusLabel.TextTransparency = 0
    StatusLabel.Text = text
    StatusLabel.TextColor3 = green
    SmoothTween(StatusLabel, 0.3, {TextTransparency = 0})
    task.spawn(function()
        task.wait(3)
        if StatusLabel.Text == text then
            SmoothTween(StatusLabel, 0.5, {TextTransparency = 1})
        end
    end)
end

local function AddHoverEffect(button)
    button.MouseEnter:Connect(function()
        SmoothTween(button, 0.2, {
            BackgroundColor3 = KeySystemData.Colors.ButtonHover
        })
    end)
    
    button.MouseLeave:Connect(function()
        SmoothTween(button, 0.2, {
            BackgroundColor3 = KeySystemData.Colors.Button
        })
    end)
end

AddHoverEffect(SubmitButton)
AddHoverEffect(GetKeyButton)

KeyInput.Focused:Connect(function()
    SmoothTween(KeyInput.UIStroke, 0.2, {
        Color = KeySystemData.Colors.Title, 
        Transparency = 0.3
    })
end)

KeyInput.FocusLost:Connect(function()
    SmoothTween(KeyInput.UIStroke, 0.2, {
        Color = KeySystemData.Colors.InputFieldBorder, 
        Transparency = 0.8
    })
end)

local function openGetKey()
    ShowStatusMessage("Getting key...")
    local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    local API_KEY = Config.api
    local PROVIDER = Config.provider
    local SERVICE = Config.service
    local link = JunkieKeySystem.getLink(API_KEY, PROVIDER, SERVICE)
    if link then
        if setclipboard then
            setclipboard(link)
            ShowStatusMessage("Verification link copied!")
        else
            ShowStatusMessage("Link: " .. link)
        end
    else
        ShowStatusMessage("Failed to generate link")
    end
end

local function validateKey()
    local userKey = KeyInput.Text:gsub("%s+", "")
    if not userKey or userKey == "" then
        ShowStatusMessage("Please enter a key.")
        return
    end
    ShowStatusMessage("Validating key...")
    local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    local API_KEY = Config.api
    local SERVICE = Config.service
    local isValid = JunkieKeySystem.verifyKey(API_KEY, userKey, SERVICE)
    if isValid then
        ShowStatusMessage("Key valid! Loading executor...")
        if writefile then
            -- Ensure 'seisen' folder exists before saving key
            if isfolder and not isfolder("seisen") then
                makefolder("seisen")
            end
            writefile(KeySystemData.FileName, userKey)
        end
        SmoothTween(MainFrame, 0.5, {
            Position = UDim2.new(0.5, 0, -0.5, 0),
            BackgroundTransparency = 1
        })
        task.wait(0.5)
        ScreenGui:Destroy()
        getgenv().RedExecutorKeySys = nil
        main()
    else
        ShowStatusMessage("Invalid key. Try again!")
    end
end

SubmitButton.MouseButton1Click:Connect(validateKey)
GetKeyButton.MouseButton1Click:Connect(openGetKey)

local dragging, dragInput, dragStart, startPos
local function onInputChanged(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(onInputChanged)


DiscordButton.MouseButton1Click:Connect(function()
    local discordUrl = "https://discord.gg/" .. KeySystemData.DiscordInvite
    if setclipboard then
        setclipboard(discordUrl)
        ShowStatusMessage("Copied Discord invite!", Color3.fromRGB(123, 48, 220))
    else
        ShowStatusMessage("Join: " .. discordUrl, Color3.fromRGB(123, 48, 220))
    end
end)

PremiumKeyButton.MouseButton1Click:Connect(function()
    local premiumUrl = "https://seisenhub.mysellauth.com/"
    if setclipboard then
        setclipboard(premiumUrl)
        ShowStatusMessage("Premium key link copied!", KeySystemData.Colors.Success)
    else
        ShowStatusMessage("Link: " .. premiumUrl, KeySystemData.Colors.Success)
    end
end)

KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        validateKey()
    end
end)


MainFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.BackgroundTransparency = 1

SmoothTween(MainFrame, 0.5, {
    Size = UDim2.new(0, 350, 0, 250), 
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundTransparency = 0
})

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    getgenv().RedExecutorKeySys = nil
end)
