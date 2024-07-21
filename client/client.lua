local puedeDisparar = false

local function esArmaPermitida(arma)
    for _, armaPermitida in ipairs(Config.armasPermitidas) do
        if arma == GetHashKey(armaPermitida) then
            return true
        end
    end
    return false
end

RegisterCommand("gatillo", function()
    local jugador = PlayerPedId()
    local armaActual = GetSelectedPedWeapon(jugador)
    puedeDisparar = not puedeDisparar
    
    if puedeDisparar then
        ESX.ShowNotification("Tienes el ~y~gatillo desbloqueado~s~, ahora puedes disparar con el arma")
    else
        ESX.ShowNotification("Tienes el ~r~gatillo bloqueado~s~, reitra el dedo del gatillo para desbloquearlo")
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local jugador = PlayerPedId()
        local armaActual = GetSelectedPedWeapon(jugador)
        if not puedeDisparar and not esArmaPermitida(armaActual) then
            DisablePlayerFiring(jugador, true)
        end
    end
end)