local _XN_KEY = (_G.Xeno_Secret == "XENO_AUTH_2025") and 1 or 0

if _XN_KEY == 0 then 
    warn("XENO OS: ACCESO DENEGADO - LLAVE INVÁLIDA")
    return 
end

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

if CoreGui:FindFirstChild("xenoOS") then CoreGui.xenoOS:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "xenoOS"
ScreenGui.Enabled = (_XN_KEY == 1)

-- CONFIGURACIÓN MAESTRA
local Config = {
    Title = "MI PROPIO HUB",
    TitleColor = Color3.fromRGB(255, 255, 255),
    AccentColor = Color3.fromRGB(255, 255, 255),
    ClickEffectColor = Color3.fromRGB(255, 255, 255),
    IconColor = Color3.fromRGB(255, 255, 255),
    TabTextColor = Color3.fromRGB(255, 255, 255),
    NotifyAccentColor = Color3.fromRGB(255, 255, 255),
    CornerSize = UDim.new(0, 15), 
    
    OpenBtnImage = "rbxassetid://109016980957024",
    OpenBtnCorner = UDim.new(0, 10),
    
    MainTransparency = 0,
    SidebarTransparency = 0,
    TabsTransparency = 0,
    WindowSize = UDim2.new(0, 600, 0, 360),
    SliderColor = Color3.fromRGB(255, 255, 255),
    SliderBarColor = Color3.fromRGB(0, 0, 0),
}

local function CreateGlobalClickEffect(pos)
    local ClickFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")

    ClickFrame.Parent = ScreenGui 
    ClickFrame.Name = "GlobalRipple"
    ClickFrame.Size = UDim2.new(0, 0, 0, 0)
    ClickFrame.Position = UDim2.new(0, pos.X, 0, pos.Y)
    ClickFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- Usamos tu nueva variable de color aquí
    ClickFrame.BackgroundColor3 = Config.ClickEffectColor
    ClickFrame.BackgroundTransparency = 0.8
    ClickFrame.ZIndex = 999

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = ClickFrame

    UIStroke.Parent = ClickFrame
    UIStroke.Thickness = 2
    -- Y aquí también
    UIStroke.Color = Config.ClickEffectColor
    UIStroke.Transparency = 0.4

    local effectInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    local tween = TweenService:Create(ClickFrame, effectInfo, {
        Size = UDim2.new(0, 60, 0, 60),
        BackgroundTransparency = 1
    })
    
    TweenService:Create(UIStroke, effectInfo, {
        Transparency = 1,
        Thickness = 0
    }):Play()

    tween:Play()
    
    tween.Completed:Connect(function()
        ClickFrame:Destroy()
    end)
end

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        CreateGlobalClickEffect(input.Position)
    end
end)

--// 2. LIBRERÍA DE 15 ICONOS COMPLETA
local IconLibrary = {
    ["Home"]          = "rbxassetid://10723351537",
    ["Inicio"]        = "rbxassetid://10734950037",
    ["Usuario"]       = "rbxassetid://10723350291",
    ["Combate"]       = "rbxassetid://10734981358",
    ["Mira"]          = "rbxassetid://10723346959",
    ["Seguridad"]     = "rbxassetid://10734950185",
    ["Visuales"]      = "rbxassetid://10734951102",
    ["Mundo"]         = "rbxassetid://10734951038",
    ["Teleport"]      = "rbxassetid://10723345518",
    ["Configuracion"] = "rbxassetid://10734950309",
    ["Rayos"]         = "rbxassetid://10734980547",
    ["Carpeta"]       = "rbxassetid://10723343321",
    ["Stats"]         = "rbxassetid://10723349253",
    ["Key"]           = "rbxassetid://10723344435",
    ["Tools"]         = "rbxassetid://10723350325"
}

--// 3. FUNCIÓN DE NOTIFICACIÓN
local function Notify(title, text)
    local NotifyFrame = Instance.new("Frame", ScreenGui)
    NotifyFrame.Size = UDim2.new(0, 300, 0, 100)
    NotifyFrame.Position = UDim2.new(1, 10, 1, -115)
    NotifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", NotifyFrame).CornerRadius = Config.CornerSize
    local Stroke = Instance.new("UIStroke", NotifyFrame)
    Stroke.Color = Config.NotifyAccentColor 
    Stroke.Thickness = 2

    local TextContainer = Instance.new("Frame", NotifyFrame)
    TextContainer.Size = UDim2.new(1, -30, 1, -20)
    TextContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    TextContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    TextContainer.BackgroundTransparency = 1

    local TName = Instance.new("TextLabel", TextContainer)
    TName.Size = UDim2.new(1, 0, 0, 25)
    TName.Text = title:upper()
    TName.TextColor3 = Config.NotifyAccentColor 
    TName.Font = Enum.Font.GothamBold
    TName.TextSize = 14
    TName.BackgroundTransparency = 1
    TName.TextXAlignment = Enum.TextXAlignment.Left

    local TText = Instance.new("TextLabel", TextContainer)
    TText.Size = UDim2.new(1, 0, 1, -25)
    TText.Position = UDim2.new(0, 0, 0, 25)
    TText.Text = text
    TText.TextColor3 = Color3.fromRGB(210, 210, 210)
    TText.Font = Enum.Font.Gotham
    TText.TextSize = 12
    TText.TextWrapped = true
    TText.TextXAlignment = Enum.TextXAlignment.Left
    TText.TextYAlignment = Enum.TextYAlignment.Top
    TText.BackgroundTransparency = 1

    NotifyFrame:TweenPosition(UDim2.new(1, -315, 1, -115), "Out", "Back", 0.5, true)
    task.delay(5, function()
        if NotifyFrame then
            NotifyFrame:TweenPosition(UDim2.new(1, 10, 1, -115), "In", "Quad", 0.5, true)
            task.wait(0.5)
            NotifyFrame:Destroy()
        end
    end)
end

--// MAIN RESPONSIVO (ESCALA + LIMITADORES)
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "Main"
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Main.BackgroundTransparency = 1
Main.Draggable = true
Main.Active = true

-- Propiedades de Escala y Centro
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Size = UDim2.new(0.85, 0, 0.85, 0) -- 60% de la pantalla
Main.Position = UDim2.new(0.5, 0, 1.2, 0) -- Posición inicial (Abajo)

-- Estética Original
Instance.new("UICorner", Main).CornerRadius = Config.CornerSize
Instance.new("UIStroke", Main).Color = Color3.fromRGB(40, 40, 40)

-- Limitadores (Imprescindible para PC/Móvil)
local AspectRatio = Instance.new("UIAspectRatioConstraint", Main)
AspectRatio.AspectRatio = 1.666 

local SizeConstraint = Instance.new("UISizeConstraint", Main)
SizeConstraint.MaxSize = Vector2.new(600, 360) 
SizeConstraint.MinSize = Vector2.new(350, 210)

--// SIDEBAR RESPONSIVO (ADAPTADO)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Name = "Sidebar"
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Sidebar.BackgroundTransparency = Config.SidebarTransparency

-- Cambiamos el 180 (fijo) por 0.3 (30% del ancho del Main)
-- Esto hace que siempre se vea igual de bien sin importar el tamaño
Sidebar.Size = UDim2.new(0, 170, 1, 0) 

Instance.new("UICorner", Sidebar).CornerRadius = Config.CornerSize

-- Tip de Top 1: Si usas un UIListLayout adentro, asegúrate de que tenga 
-- un Padding también en Scale para que los botones no se peguen.

local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Text = Config.Title:upper()
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.TextColor3 = Config.TitleColor
Title.BackgroundTransparency = 1

local function animateClick(targetButton)
    -- Guardamos el tamaño original justo cuando se llama a la función
    local originalSize = targetButton.Size

    targetButton.MouseButton1Down:Connect(function()
        -- Usamos un multiplicador (0.95) en lugar de restar píxeles fijos
        -- Esto funciona perfecto tanto en Scale como en Offset
        TweenService:Create(targetButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(originalSize.X.Scale * 0.95, originalSize.X.Offset * 0.95, originalSize.Y.Scale * 0.95, originalSize.Y.Offset * 0.95)
        }):Play()
    end)

    targetButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            -- Efecto de rebote (un poquito más grande que el original)
            TweenService:Create(targetButton, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(originalSize.X.Scale * 1.03, originalSize.X.Offset * 1.03, originalSize.Y.Scale * 1.03, originalSize.Y.Offset * 1.03)
            }):Play()
            
            task.wait(0.15) -- Un poquito más de tiempo para que se note el efecto 'Back'
            
            -- Volver al tamaño original
            TweenService:Create(targetButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = originalSize
            }):Play()
        end
    end)
end

--// BOTÓN DE BLOQUEO DE MOVIMIENTO (/)
local LockBtn = Instance.new("TextButton", Main)
LockBtn.Name = "LockButton"
LockBtn.Size = UDim2.new(0, 30, 0, 30)
LockBtn.Position = UDim2.new(1, -110, 0, 15) 
LockBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LockBtn.Text = "/"
LockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LockBtn.Font = Enum.Font.GothamBold
LockBtn.TextSize = 16 -- Bajé un poco el tamaño para que se vea más centrado
LockBtn.ZIndex = 10

Instance.new("UICorner", LockBtn).CornerRadius = UDim.new(1, 0)

-- Stroke opcional para que combine con tus otros botones
local LockStroke = Instance.new("UIStroke", LockBtn)
LockStroke.Color = Color3.fromRGB(55, 55, 55)
LockStroke.Thickness = 1

animateClick(LockBtn)

--// LÓGICA DE BLOQUEO
local Locked = false

LockBtn.Activated:Connect(function()
    Locked = not Locked -- Cambiamos el estado primero
    
    if Locked then
        Main.Draggable = false
        -- Usamos un verde fijo en lugar de Config.AccentColor
        game:GetService("TweenService"):Create(LockBtn, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(0, 255, 120) -- Verde neón fijo
        }):Play()
        Notify("SISTEMA", "Movimiento bloqueado.")
    else
        Main.Draggable = true
        game:GetService("TweenService"):Create(LockBtn, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(255, 255, 255) -- Vuelve a blanco
        }):Play()
        Notify("SISTEMA", "Movimiento habilitado.")
    end
end)

local OpenBtn = Instance.new("ImageButton", ScreenGui)
OpenBtn.Name = "OpenButton"
OpenBtn.Size = UDim2.new(0, 55, 0, 55)
OpenBtn.Position = UDim2.new(0, 15, 0.5, -27)
OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenBtn.Image = Config.OpenBtnImage 
OpenBtn.Visible = false
OpenBtn.ZIndex = 50
OpenBtn.Draggable = false
OpenBtn.Active = true

Instance.new("UIStroke", OpenBtn).Color = Config.AccentColor 
Instance.new("UICorner", OpenBtn).CornerRadius = Config.OpenBtnCorner

local function elegantClose()
    local closeInfo = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    
    -- Animación: Se encoge al 70% de su tamaño actual y se desvanece
    local closeTween = TweenService:Create(Main, closeInfo, {
        Size = UDim2.new(0.6, 0, 0.6, 0), -- Tamaño reducido al cerrar
        BackgroundTransparency = 1
    })
    
    TweenService:Create(Sidebar, closeInfo, {BackgroundTransparency = 1}):Play()
    
    closeTween:Play()
    closeTween.Completed:Connect(function()
        Main.Visible = false
        Main.Size = UDim2.new(0.85, 0, 0.85, 0) -- Reseteamos al tamaño grande original
        OpenBtn.Visible = true
    end)
end

local function elegantOpen()
    -- Posición central absoluta
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    -- Estado inicial para la animación (Pequeño e invisible)
    Main.Size = UDim2.new(0.6, 0, 0.6, 0)
    Main.BackgroundTransparency = 1
    Sidebar.BackgroundTransparency = 1 
    
    Main.Visible = true
    
    local openInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    -- Animación hacia el tamaño grande (0.85)
    TweenService:Create(Main, openInfo, {
        Size = UDim2.new(0.85, 0, 0.85, 0),
        BackgroundTransparency = 0
    }):Play()
    
    TweenService:Create(Sidebar, openInfo, {BackgroundTransparency = 0}):Play()
    
    OpenBtn.Visible = false
end

--// ACTUALIZACIÓN DEL TOGGLE (Control)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        if Main.Visible then 
            elegantClose() 
            Notify("SISTEMA", "Interfaz Minimizada")
        else 
            elegantOpen() 
            Notify("SISTEMA", "Interfaz Abierta")
        end
    end
end)

animateClick(OpenBtn)

OpenBtn.Activated:Connect(function()
    elegantOpen()
end)

--// BOTÓN DE MINIMIZAR (-)
local MinimizeBtn = Instance.new("TextButton", Main)
MinimizeBtn.Name = "MinimizeButton"
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -75, 0, 15) 
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 20
MinimizeBtn.ZIndex = 10

-- UICorner circular
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)

animateClick(MinimizeBtn)

MinimizeBtn.Activated:Connect(function()
    elegantClose()
end)

--// BOTÓN DE CIERRE (CIRCULAR)
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Name = "CloseButton"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 10
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

animateClick(CloseBtn)

--// CONFIGURACIÓN DEL PANEL DE CONFIRMACIÓN
local ConfirmFrame = Instance.new("Frame", ScreenGui)
ConfirmFrame.Name = "ConfirmClose"
ConfirmFrame.Size = UDim2.new(0, 0, 0, 0) -- Empieza en 0 para la animación
ConfirmFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ConfirmFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ConfirmFrame.Visible = false
ConfirmFrame.ZIndex = 100
ConfirmFrame.BackgroundTransparency = 1 -- Empieza invisible
ConfirmFrame.ClipsDescendants = true -- Para que el contenido no se salga mientras crece

local CornerConfirm = Instance.new("UICorner", ConfirmFrame)
CornerConfirm.CornerRadius = UDim.new(0, 16)

local StrokeConfirm = Instance.new("UIStroke", ConfirmFrame)
StrokeConfirm.Color = Color3.fromRGB(45, 45, 45)
StrokeConfirm.Thickness = 1

--// CONTENIDO DEL PANEL
local Question = Instance.new("TextLabel", ConfirmFrame)
Question.Size = UDim2.new(1, 0, 0, 70)
Question.BackgroundTransparency = 1
Question.Text = "¿DESEAS CERRAR LA UI?"
Question.TextColor3 = Color3.fromRGB(255, 255, 255)
Question.Font = Enum.Font.GothamBold
Question.TextSize = 14
Question.ZIndex = 101
Question.TextTransparency = 1 -- Empieza invisible

local YesBtn = Instance.new("TextButton", ConfirmFrame)
YesBtn.Size = UDim2.new(0, 110, 0, 35)
YesBtn.Position = UDim2.new(0.07, 0, 0.65, 0)
YesBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
YesBtn.Text = "YES"
YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
YesBtn.Font = Enum.Font.GothamBold
YesBtn.ZIndex = 101
YesBtn.BackgroundTransparency = 1
YesBtn.TextTransparency = 1
Instance.new("UICorner", YesBtn).CornerRadius = UDim.new(0, 18)

local NoBtn = Instance.new("TextButton", ConfirmFrame)
NoBtn.Size = UDim2.new(0, 110, 0, 35)
NoBtn.Position = UDim2.new(0.53, 0, 0.65, 0)
NoBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
NoBtn.Text = "NO"
NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoBtn.Font = Enum.Font.GothamBold
NoBtn.ZIndex = 101
NoBtn.BackgroundTransparency = 1
NoBtn.TextTransparency = 1
Instance.new("UICorner", NoBtn).CornerRadius = UDim.new(0, 18)

--// FUNCIONES DE ANIMACIÓN
local function AnimateConfirmOpen()
    ConfirmFrame.Visible = true
    local info = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    TweenService:Create(ConfirmFrame, info, {Size = UDim2.new(0, 280, 0, 140), BackgroundTransparency = 0}):Play()
    TweenService:Create(Question, info, {TextTransparency = 0}):Play()
    TweenService:Create(YesBtn, info, {BackgroundTransparency = 0, TextTransparency = 0}):Play()
    TweenService:Create(NoBtn, info, {BackgroundTransparency = 0, TextTransparency = 0}):Play()
end

local function AnimateConfirmClose(callback)
    local info = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    
    local t = TweenService:Create(ConfirmFrame, info, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
    TweenService:Create(Question, info, {TextTransparency = 1}):Play()
    TweenService:Create(YesBtn, info, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    TweenService:Create(NoBtn, info, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    
    t:Play()
    t.Completed:Connect(function()
        ConfirmFrame.Visible = false
        if callback then callback() end
    end)
end

--// LÓGICA DE CLICS
CloseBtn.Activated:Connect(function()
    AnimateConfirmOpen()
end)

NoBtn.Activated:Connect(function()
    AnimateConfirmClose()
end)

YesBtn.Activated:Connect(function()
    AnimateConfirmClose(function()
        -- Animación de salida de toda la UI
        local exitInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        local exitPos = UDim2.new(0.5, -Main.Size.X.Offset / 2, 1.2, 0) 
        
        TweenService:Create(Main, exitInfo, {Position = exitPos, BackgroundTransparency = 1}):Play()
        TweenService:Create(Sidebar, exitInfo, {BackgroundTransparency = 1}):Play()
        
        task.wait(0.6)
        ScreenGui:Destroy()
    end)
end)

-- Hover Effects
YesBtn.MouseEnter:Connect(function() TweenService:Create(YesBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}):Play() end)
YesBtn.MouseLeave:Connect(function() TweenService:Create(YesBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play() end)

NoBtn.MouseEnter:Connect(function() TweenService:Create(NoBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play() end)
NoBtn.MouseLeave:Connect(function() TweenService:Create(NoBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play() end)

local PagesContainer = Instance.new("Frame", Main)
PagesContainer.Name = "PagesContainer"
PagesContainer.Position = UDim2.new(0, 175, 0, 5)
PagesContainer.Size = UDim2.new(1, -180, 1, -10)
PagesContainer.BackgroundTransparency = 1
PagesContainer.ClipsDescendants = true

local NavScroll = Instance.new("ScrollingFrame", Sidebar)
NavScroll.Position = UDim2.new(0, 0, 0, 65)
NavScroll.Size = UDim2.new(1, 0, 1, -75)
NavScroll.BackgroundTransparency = 1
NavScroll.ScrollBarThickness = 0
NavScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
local NavLayout = Instance.new("UIListLayout", NavScroll)
NavLayout.Padding = UDim.new(0, 8)
NavLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// FUNCIÓN DE CREACIÓN DE PESTAÑAS (ORIGINAL REPARADO)
local function CreateTab(name, iconSource)
    local Page = Instance.new("ScrollingFrame", PagesContainer)
    Page.Name = name .. "_Page" -- Le ponemos nombre para que el sistema lo reconozca
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 0
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local PageLayout = Instance.new("UIListLayout", Page)
    PageLayout.Padding = UDim.new(0, 10)
    PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    -- Este es el que ya tenías y es el que da el espacio arriba
    Instance.new("UIPadding", Page).PaddingTop = UDim.new(0, 50)

    local Btn = Instance.new("TextButton", NavScroll)
    Btn.Size = UDim2.new(0, 160, 0, 42)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Btn.BackgroundTransparency = Config.TabsTransparency
    Btn.Text = ""
    Instance.new("UICorner", Btn).CornerRadius = Config.CornerSize

    local Indicator = Instance.new("Frame", Btn)
    Indicator.Name = "ActiveBar"
    Indicator.Size = UDim2.new(0, 4, 0.5, 0)
    Indicator.Position = UDim2.new(0, 6, 0.25, 0)
    Indicator.BackgroundColor3 = Config.AccentColor
    Indicator.Visible = false
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(0, 2)

    local Icon = Instance.new("ImageLabel", Btn)
    Icon.Size = UDim2.new(0, 18, 0, 18)
    Icon.Position = UDim2.new(0, 15, 0.5, -9)
    Icon.BackgroundTransparency = 1
    Icon.Image = IconLibrary[iconSource] or IconLibrary["Inicio"]
    Icon.ImageColor3 = Config.IconColor

    local Label = Instance.new("TextLabel", Btn)
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name:upper()
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 11
    Label.TextColor3 = Config.TabTextColor
    Label.TextXAlignment = Enum.TextXAlignment.Center

    Btn.Activated:Connect(function()
    -- 1. Ocultar todas las páginas
    for _, p in pairs(PagesContainer:GetChildren()) do 
        if p:IsA("ScrollingFrame") then 
            p.Visible = false 
        end 
    end
    
    -- 2. Resetear estética de los botones
    for _, b in pairs(NavScroll:GetChildren()) do
        if b:IsA("TextButton") then
            -- Usamos FindFirstChild para evitar errores si no hay barra
            if b:FindFirstChild("ActiveBar") then b.ActiveBar.Visible = false end
            b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        end
    end
    
    -- 3. Activar página y botón actual
    Page.Visible = true
    Indicator.Visible = true
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

    -- 4. AQUÍ ESTÁ EL EFECTO (Lo que te faltaba):
    Page.Position = UDim2.new(0, 0, 0, 30) -- La mueve 30px abajo al instante
    game:GetService("TweenService"):Create(Page, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0) -- La sube suavemente a su sitio
    }):Play()
end)

return Page
end

local function AddButton(parentPage, text, callback)
    local _S_SIZE = 40 * _XN_KEY 
    
    local Btn = Instance.new("TextButton", parentPage)
    Btn.Name = "XenoButton_" .. text:sub(1,3)
    
    Btn.Size = UDim2.new(1, -20, 0, _S_SIZE)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    
    Btn.Text = (_XN_KEY == 1) and text:upper() or ""
    
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 12
    Btn.AutoButtonColor = false
    Btn.ClipsDescendants = true
    Btn.Visible = (_XN_KEY == 1)

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Color = Color3.fromRGB(50, 50, 50)
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Transparency = (_XN_KEY == 1) and 0 or 1

    if _XN_KEY == 1 then
        animateClick(Btn)
    end

    Btn.Activated:Connect(function() 
        if _XN_KEY == 1 and callback then 
            callback() 
        end 
    end)
    
    return Btn
end

local function CreateToggle(parent, name, callback)
    local _S_HEIGHT = 40 * _XN_KEY

    local Toggle = Instance.new("TextButton", parent)
    Toggle.Name = name .. "_Toggle"
    
    Toggle.Size = UDim2.new(1, -20, 0, _S_HEIGHT)
    Toggle.Visible = (_XN_KEY == 1)
    Toggle.ClipsDescendants = true
    
    Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    
    Toggle.Text = (_XN_KEY == 1) and ("  " .. name:upper()) or ""
    
    Toggle.TextColor3 = Color3.fromRGB(150, 150, 150)
    Toggle.Font = Enum.Font.GothamSemibold
    Toggle.TextSize = 11
    Toggle.TextXAlignment = Enum.TextXAlignment.Left
    Toggle.AutoButtonColor = false

    if _XN_KEY == 1 then
        animateClick(Toggle)
    end

    local Corner = Instance.new("UICorner", Toggle)
    Corner.CornerRadius = UDim.new(0, 8)

    local Stroke = Instance.new("UIStroke", Toggle)
    Stroke.Color = Color3.fromRGB(55, 55, 55)
    Stroke.Thickness = 1
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local StatusFrame = Instance.new("Frame", Toggle)
    StatusFrame.Size = UDim2.new(0, 34, 0, 18)
    StatusFrame.Position = UDim2.new(1, -44, 0.5, -9)
    StatusFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", StatusFrame).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", StatusFrame)
    Circle.Size = UDim2.new(0, 14, 0, 14)
    Circle.Position = UDim2.new(0, 2, 0.5, -7)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local Enabled = false
    Toggle.Activated:Connect(function()
        Enabled = not Enabled
        
        local targetSwitchColor = Color3.fromRGB(45, 45, 45)
        local targetTextColor = Color3.fromRGB(150, 150, 150)
        
        if Enabled then
            targetTextColor = Color3.fromRGB(255, 255, 255)
            -- Asumiendo que Config.AccentColor existe globalmente
            if Config and Config.AccentColor == Color3.fromRGB(255, 255, 255) then
                targetSwitchColor = Color3.fromRGB(100, 100, 100)
            elseif Config then
                targetSwitchColor = Config.AccentColor
            else
                targetSwitchColor = Color3.fromRGB(0, 170, 255) -- Color azul por defecto si no hay Config
            end
        end

        local targetPos = Enabled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        local info = TweenInfo.new(0.25, Enum.EasingStyle.Quart)
        
        game:GetService("TweenService"):Create(Toggle, info, {TextColor3 = targetTextColor}):Play()
        game:GetService("TweenService"):Create(StatusFrame, info, {BackgroundColor3 = targetSwitchColor}):Play()
        game:GetService("TweenService"):Create(Circle, info, {Position = targetPos}):Play()
        
        callback(Enabled)
    end)
    
    return Toggle
end

local function CreateSlider(parent, name, min, max, default, callback)
    local _S_HEIGHT = 50 * _XN_KEY
    local dragging = false
    
    local SliderFrame = Instance.new("Frame", parent)
    SliderFrame.Name = name .. "Slider"
    
    SliderFrame.Size = UDim2.new(1, -20, 0, _S_HEIGHT)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SliderFrame.Visible = (_XN_KEY == 1)
    SliderFrame.ClipsDescendants = true
    
    local Corner = Instance.new("UICorner", SliderFrame)
    Corner.CornerRadius = UDim.new(0, 8) 

    local Stroke = Instance.new("UIStroke", SliderFrame)
    Stroke.Color = Color3.fromRGB(55, 55, 55)
    Stroke.Thickness = 1
    Stroke.Transparency = 0.5
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local Title = Instance.new("TextLabel", SliderFrame)
    Title.Size = UDim2.new(1, -20, 0, 25)
    Title.Position = UDim2.new(0, 12, 0, 5)
    Title.BackgroundTransparency = 1
    Title.Text = (_XN_KEY == 1) and name:upper() or ""
    Title.TextColor3 = Color3.fromRGB(180, 180, 180)
    Title.Font = Enum.Font.GothamSemibold
    Title.TextSize = 10
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local ValueText = Instance.new("TextLabel", SliderFrame)
    ValueText.Size = UDim2.new(0, 50, 0, 25)
    ValueText.Position = UDim2.new(1, -62, 0, 5)
    ValueText.BackgroundTransparency = 1
    ValueText.Text = tostring(default)
    ValueText.TextColor3 = Color3.fromRGB(150, 150, 150)
    ValueText.Font = Enum.Font.GothamBold
    ValueText.TextSize = 11
    ValueText.TextXAlignment = Enum.TextXAlignment.Right

    local SliderBar = Instance.new("Frame", SliderFrame)
    SliderBar.Size = UDim2.new(1, -24, 0, 4)
    SliderBar.Position = UDim2.new(0, 12, 0, 37)
    SliderBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(1, 0)

    local SliderFill = Instance.new("Frame", SliderBar)
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Config.AccentColor
    Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

    local SliderBtn = Instance.new("Frame", SliderBar)
    SliderBtn.Size = UDim2.new(0, 10, 0, 10)
    SliderBtn.Position = UDim2.new((default - min) / (max - min), -5, 0.5, -5)
    SliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderBtn.ZIndex = 5
    Instance.new("UICorner", SliderBtn).CornerRadius = UDim.new(1, 0)
    
    -- UIStroke para el círculo para que resalte
    local BtnStroke = Instance.new("UIStroke", SliderBtn)
    BtnStroke.Color = Config.AccentColor
    BtnStroke.Thickness = 1.5
    BtnStroke.Transparency = 0.5

    local function move(input)
        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        
        -- Tween de suavidad extrema (Quart Out)
        local moveInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        TweenService:Create(SliderFill, moveInfo, {Size = UDim2.new(pos, 0, 1, 0)}):Play()
        TweenService:Create(SliderBtn, moveInfo, {Position = UDim2.new(pos, -5, 0.5, -5)}):Play()
        
        ValueText.Text = tostring(value)
        callback(value)
    end

    SliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            -- Efecto elegante al activar: se ilumina el título y el valor
            local focusInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad)
            TweenService:Create(Title, focusInfo, {TextColor3 = Config.AccentColor}):Play()
            TweenService:Create(ValueText, focusInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(SliderBtn, focusInfo, {Size = UDim2.new(0, 14, 0, 14), Position = SliderBtn.Position - UDim2.new(0, 2, 0, 2)}):Play()
            TweenService:Create(Stroke, focusInfo, {Transparency = 0, Color = Config.AccentColor}):Play()
            move(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            -- Volver a la normalidad suavemente
            local unfocusInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad)
            TweenService:Create(Title, unfocusInfo, {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()
            TweenService:Create(ValueText, unfocusInfo, {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
            TweenService:Create(SliderBtn, unfocusInfo, {Size = UDim2.new(0, 10, 0, 10)}):Play()
            TweenService:Create(Stroke, unfocusInfo, {Transparency = 0.5, Color = Color3.fromRGB(55, 55, 55)}):Play()
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            move(input)
        end
    end)
end

--// FUNCIÓN DROPDOWN COMPLETA (VERSIÓN PREMIUM)
local function CreateDropdown(parent, name, options, callback)
    local _S_HEIGHT = 40 * _XN_KEY
    local open = false
    
    local DropdownFrame = Instance.new("Frame", parent)
    DropdownFrame.Name = name .. "Dropdown"
    DropdownFrame.Size = UDim2.new(1, -20, 0, _S_HEIGHT)
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    DropdownFrame.ClipsDescendants = true
    DropdownFrame.Visible = (_XN_KEY == 1)
    
    local Corner = Instance.new("UICorner", DropdownFrame)
    Corner.CornerRadius = UDim.new(0, 8) 

    local Stroke = Instance.new("UIStroke", DropdownFrame)
    Stroke.Color = Color3.fromRGB(55, 55, 55)
    Stroke.Thickness = 1
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local MainButton = Instance.new("TextButton", DropdownFrame)
    MainButton.Size = UDim2.new(1, 0, 0, 40)
    MainButton.BackgroundTransparency = 1
    local firstOption = (options and options[1]) or "NONE"
    MainButton.Text = (_XN_KEY == 1) and ("  " .. name:upper() .. ": " .. tostring(firstOption)) or ""
    MainButton.TextColor3 = Color3.fromRGB(180, 180, 180)
    MainButton.Font = Enum.Font.GothamSemibold
    MainButton.TextSize = 11
    MainButton.TextXAlignment = Enum.TextXAlignment.Left
    MainButton.AutoButtonColor = false

    local Arrow = Instance.new("TextLabel", MainButton)
    Arrow.Size = UDim2.new(0, 40, 1, 0)
    Arrow.Position = UDim2.new(1, -40, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.TextColor3 = Color3.fromRGB(180, 180, 180)
    Arrow.TextSize = 10

    local OptionContainer = Instance.new("Frame", DropdownFrame)
    OptionContainer.Size = UDim2.new(1, 0, 0, #options * 30)
    OptionContainer.Position = UDim2.new(0, 0, 0, 40)
    OptionContainer.BackgroundTransparency = 1

    -- Lógica de Abrir/Cerrar
    MainButton.Activated:Connect(function()
        open = not open
        local targetSize = open and UDim2.new(1, -20, 0, 40 + (#options * 30) + 5) or UDim2.new(1, -20, 0, 40)
        game:GetService("TweenService"):Create(DropdownFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = targetSize}):Play()
        Arrow.Text = open and "▲" or "▼"
    end)

    -- Creación de Opciones
    for i, opt in ipairs(options) do
        local OptBtn = Instance.new("TextButton", OptionContainer)
        OptBtn.Size = UDim2.new(1, 0, 0, 30)
        OptBtn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
        OptBtn.BackgroundTransparency = 1
        OptBtn.Text = opt
        OptBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
        OptBtn.Font = Enum.Font.Gotham
        OptBtn.TextSize = 11
        OptBtn.AutoButtonColor = false

        OptBtn.Activated:Connect(function()
            -- Aplicar el AccentColor al texto principal al seleccionar
            MainButton.Text = "  " .. name:upper() .. ": " .. opt
            MainButton.TextColor3 = Config.AccentColor 
            
            open = false
            game:GetService("TweenService"):Create(DropdownFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(1, -20, 0, 40)}):Play()
            Arrow.Text = "▼"
            callback(opt)
        end)

        -- Efectos de Hover
        OptBtn.MouseEnter:Connect(function() 
            game:GetService("TweenService"):Create(OptBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play() 
        end)
        OptBtn.MouseLeave:Connect(function() 
            game:GetService("TweenService"):Create(OptBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(140, 140, 140)}):Play() 
        end)
    end
end

local _XN_KEY = (_G.Xeno_Secret == "XENO_AUTH_2025") and 1 or 0

if _XN_KEY == 0 then 
    warn("XENO OS: ACCESO NO AUTORIZADO")
    return 
end

--// LIBRERÍA: CONECTOR MAESTRO
-- Colocamos esto aquí porque ya se crearon las funciones Toggle, Slider, etc.
local Library = {}

function Library:CreateWindow(titleText)
    Title.Text = titleText:upper()
  
    local Window = {}
    
    function Window:CreateTab(tabName, iconName)
        local PageRef = CreateTab(tabName, iconName)
        
        local Elements = {}
        
        function Elements:AddButton(text, cb)
            return AddButton(PageRef, text, cb)
        end
        
        function Elements:AddToggle(text, cb)
            return CreateToggle(PageRef, text, cb)
        end
        
        function Elements:AddSlider(text, min, max, def, cb)
            return CreateSlider(PageRef, text, min, max, def, cb)
        end
        
        function Elements:AddDropdown(text, list, cb)
            return CreateDropdown(PageRef, text, list, cb)
        end
        
        return Elements
    end
    
    return Window
end

--// INICIO DE TU HUB (CORREGIDO)
local MyHub = Library:CreateWindow(Config.Title)

-- 1. Crear las pestañas
local Tab1 = MyHub:CreateTab("Dashboard", "Home")
local Tab2 = MyHub:CreateTab("Combat", "Combate")

-- 2. Añadir elementos
Tab1:AddButton("Notificación de Prueba", function()
    Notify("SISTEMA", "¡Todo funciona correctamente!")
end)

Tab2:AddToggle("Aimbot Pro", function(state)
    if state then
        Notify("COMBATE", "Aimbot Encendido")
    else
        Notify("COMBATE", "Aimbot Apagado")
    end
end)

Tab2:AddSlider("Velocidad de Aim", 1, 100, 50, function(v) 
    print("Velocidad: " .. v) 
end)

Tab2:AddDropdown("PARTE DEL CUERPO", {"CABEZA", "TORSO", "PIERNAS"}, function(sel)
    print("Objetivo: " .. sel)
end)

-- 3. ACTIVACIÓN AUTOMÁTICA AL CARGAR
-- Buscamos el objeto físico de la página para que los botones sean visibles
local firstPage = PagesContainer:FindFirstChild("Dashboard_Page")
if firstPage then
    firstPage.Visible = true
end

-- Iluminamos el primer botón de la barra lateral
local firstButton = NavScroll:FindFirstChildWhichIsA("TextButton")
if firstButton then
    firstButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    local indicator = firstButton:FindFirstChild("ActiveBar")
    if indicator then
        indicator.Visible = true
    end
end

--// ANIMACIÓN DE ENTRADA DEL MENÚ PRINCIPAL (ADAPTADA)
local tweenInfo = TweenInfo.new(
    0.7, -- Duración de la animación (0.7 segundos)
    Enum.EasingStyle.Quart, -- Estilo de movimiento
    Enum.EasingDirection.Out, -- Dirección
    0, 
    false, 
    0 
)

-- Como ahora usamos AnchorPoint (0.5, 0.5), el centro es 0.5 absoluto
local goalPosition = UDim2.new(0.5, 0, 0.5, 0) 
local goalTransparency = 0 -- Transparencia final

local tween = TweenService:Create(Main, tweenInfo, {
    Position = goalPosition,
    BackgroundTransparency = goalTransparency
})

-- Asegurar visibilidad antes de iniciar
Main.Visible = true

-- ¡Inicia la animación!
tween:Play() 

-- Notificación de éxito
Notify("BIENVENIDO", "Interfaz cargada al 100%.")
