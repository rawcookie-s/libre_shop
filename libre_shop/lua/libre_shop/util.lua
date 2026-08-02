if SERVER then
    // I MISS MY NETWORK LIBRARY I HATE THIS PRIMITIVE METHOD
    util.AddNetworkString("LibreShop::GetBalance")
    util.AddNetworkString("LibreShop::UpdateBalance")


    hook.Add("LibreSC::OnBalanceChange", "LibreShop::UpdateBalance", function(steamid, before, now)
        local eplayer = player.GetBySteamID(steamid)
        if !eplayer then return end

        net.Start("LibreShop::UpdateBalance")
        net.WriteInt(now, 32)
        net.Send(eplayer)
    end)

    net.Receive("LibreShop::GetBalance", function(ligma, eplayer)
        if !IsValid(eplayer) then return end // should never happen

        net.Start("LibreShop::UpdateBalance")
        net.WriteInt(eplayer:GetSocialCredits(), 32)
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


function LibreShop:GetDisplayName(amount)
	amount = amount or 1

	return string.Comma(amount) .. " " .. LibreShop:Pluralize("Social Credit", amount)
end


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
        LibreShop.Balance = net.ReadInt(32)

        hook.Run("LibreShop::UpdateBalance", LibreShop.Balance) // not needed but who cares
    end)

    function LibreShop:GetBalance()
        return self.Balance
    end

    timer.Simple(2, function()
        net.Start("LibreShop::GetBalance")
        net.SendToServer()
    end)
end