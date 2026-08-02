if SERVER then
    // I MISS MY NETWORK LIBRARY I HATE THIS PRIMITIVE METHOD
    util.AddNetworkString("LibreShop::GetBalance")
    util.AddNetworkString("LibreShop::UpdateBalance")


    hook.Add("LibreSC::OnBalanceChange", "LibreShop::UpdateBalance", function(steamid, before, now)
        local eplayer = player.GetBySteamID(steamid)
        if !eplayer then return end

        net.Start("LibreShop::UpdateBalance")
        net.WriteDouble(now)
        net.Send(eplayer)
    end)

    net.Receive("LibreShop::GetBalance", function(ligma, eplayer)
        net.Start("LibreShop::UpdateBalance")
        net.WriteDouble(eplayer:GetSocialCredits())
        net.Send(eplayer)
    end)
end



function LibreShop:GetItem(itemname)
    return
    self.Weapons[itemname] or
    self.Entities[itemname] or 
    self.Specials[itemname]

    // surely there wont be an item with the exact name in two registries right
end

// doesnt exist on client
function LibreShop:GetDisplayName(amount)
	amount = amount or 1

	return string.Comma(amount) .. " " .. LibreShop:Pluralize("Social Credit", amount)
end

// also doesnt exist on client
function LibreShop:Pluralize(estring, amount, suffix)
	if amount == 1 then
		return estring
	else
		if !suffix then
			suffix = "s"
		end

		return estring .. suffix
	end
end



if CLIENT then
    net.Receive("LibreShop::UpdateBalance", function()
        LibreShop.Balance = net.ReadDouble()

        hook.Run("LibreShop::UpdateBalance", LibreShop.Balance) // not needed but who cares
    end)

    function LibreShop:GetBalance()
        return self.Balance
    end

    hook.Add("CreateMove", "LibreShop::Initialized", function(eplayer, ucmd)
        if ucmd:GetButtons() ~= 0 and ucmd:TickCount() ~= 0 then
            hook.Remove("CreateMove", "LibreShop::Initialized")

            net.Start("LibreShop::GetBalance")
            net.SendToServer()
        end
    end)
end
