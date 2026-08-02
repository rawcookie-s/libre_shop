util.AddNetworkString("LibreShop::BuyItem")
util.AddNetworkString("LibreShop::OptionWindow")


net.Receive("LibreShop::BuyItem", function(ligma, eplayer)
    if !IsValid(eplayer) then return end // shouldnt happen EVER again

    local itemname = net.ReadString()
    local item = LibreShop:GetItem(itemname)

    if !item then return end

    // handle message on client

    if eplayer:GetSocialCredits() < item.Price then 
        // technically, this check should never be triggered
        // since the client will stop them before ever sending a net message

        eplayer:ChatPrint("Nice try.")
        eplayer:Say("im a fat dirty exploiter")
        return 
    end

    if !eplayer:Alive() then
        eplayer:ChatPrint("You're Dead!")
        return 
    end

    if item.Type == "WEAPON" then
        do
            local swepgiven = eplayer:Give(item.Class)
            eplayer:SelectWeapon(item.Class)

            if !IsValid(swepgiven) then
                eplayer:ChatPrint("You already own one!")
                return
            end

            eplayer:SubtractSocialCredits(item.Price)

            if item.Callback then
                item:Callback(eplayer, swepgiven)
            end
        end
    elseif item.Type == "ENTITY" then
        do
            eplayer:SubtractSocialCredits(item.Price)

            local entity = ents.Create(item.Class)

            entity:SetPos(eplayer:GetEyeTrace().HitPos)
            entity:Spawn()
            entity:Activate()

            if _G.CPPISetOwner then
                CPPISetOwner(eplayer)
            end

            undo.Create("SENT")
            undo.SetPlayer(eplayer)
            undo.AddEntity(entity)
            undo.SetCustomUndoText("Undone " .. scripted_ents.GetMember(item.Class, "PrintName"))
            undo.Finish("Scripted Entity (" .. item.Class .. ")")

            entity:SetCreator(eplayer)
            eplayer:AddCleanup("sents", entity)
            eplayer:AddCount("sents", entity)

            if item.Callback then
                item:Callback(eplayer, entity)
            end
        end
    elseif item.Type == "SPECIAL" then
        do
            eplayer:SubtractSocialCredits(item.Price)

            if item.Callback then
                item:Callback(eplayer)
            end
        end
    end
end)


// fuck you leme
LibreSC.Config.commands.shop = "shop"

LibreSC:RegisterCommand("shop", function(self, eplayer, args)
    eplayer:ConCommand("catalog")
end)
