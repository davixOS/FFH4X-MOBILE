--[[
    FFH4X MOBILE - LOADER PROTECTED v2
    Status: Stealth Mode | 120 FPS
]]

-- El link de tu GitHub convertido a Bytecode (Nadie puede leer esto)
local _ENC = "\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\100\97\118\105\120\79\83\47\70\70\72\52\88\45\77\79\66\73\76\69\47\109\97\105\110\47\109\97\105\110\46\108\117\97"

local function Boot()
    -- Agregamos un número aleatorio al final para evitar el error 404 del caché
    local finalUrl = _ENC .. "?v=" .. tostring(math.random(1, 999999))
    
    local success, content = pcall(function()
        return game:HttpGet(finalUrl)
    end)
    
    if success and content then
        local func, err = loadstring(content)
        if func then
            task.spawn(func)
        else
            warn("Error en el núcleo. Revisa el main.lua.")
        end
    else
        warn("Error de conexión. El servidor no respondió.")
    end
end

-- Ejecución limpia
Boot()
