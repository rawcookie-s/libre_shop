LibreShop.Icons = {}


function LibreShop:InitMenu()
    self.Menu = vgui.Create("DFrame")
    self.Menu:SetSize(682 + 15, 400)
    self.Menu:SetTitle("Catalog - Balance: " .. self:GetDisplayName(self.Balance))
    self.Menu:SetVisible(false)
    self.Menu:SetSizable(true)

    self.Menu:SetDeleteOnClose(false)


    hook.Add("LibreShop::UpdateBalance", "LibreShop::Menu", function(balancer)
        LibreShop.Menu:SetTitle("Catalog - Balance: " .. LibreShop:GetDisplayName(balancer))

        for ligma, icon in pairs(LibreShop.Icons) do
            if IsValid(icon) then
                icon.CanAfford = balancer >= icon.Price
            end
        end
    end)


    local sheet = self.Menu:Add("DPropertySheet")
    sheet:Dock(FILL)

    local weaponpanel = sheet:Add("DPanel")
    weaponpanel.Paint = function(self, w, h) draw.RoundedBox(4, 0, 0, w, h, Color(72, 76, 52, self:GetAlpha())) end
    sheet:AddSheet("Weapons", weaponpanel, "icon16/gun.png")

    local scrollpanel = vgui.Create("DScrollPanel", weaponpanel)
    scrollpanel:Dock(FILL)

    local weaponlayout = scrollpanel:Add("DIconLayout")
    weaponlayout:Dock(FILL)
    weaponlayout:SetSpaceX(4)
    weaponlayout:SetSpaceY(4)

    for ligma, item in pairs(self.Weapons) do
        local swep = weapons.Get(item.Class)
        if !swep then continue end

        local icon = weaponlayout:Add("LibreShop::ItemIcon")
        icon:SetName(swep.PrintName or item.Class)

        local material = swep.IconOverride or ("entities/" .. item.Class .. ".png")

        icon:SetMaterial(material)

        local tooltip = "Price: " .. self:GetDisplayName(item.Price)

        local info = item.Info or swep.Instructions

        if info and info ~= "" then
            tooltip = tooltip .. "\n\n" .. info
        end

        local author = item.Author or swep.Author

        if author and author ~= "" then
            tooltip = tooltip .. "\n\nAuthor: " .. author
        end

        icon:SetTooltip(tooltip)

        local canbuy = self.Balance >= item.Price
        
        icon.Price = item.Price
        icon.CanAfford = canbuy

        icon.DoClick = function(self)
            if self.CanAfford then
                net.Start("LibreShop::BuyItem")
                net.WriteString(item.Class)
                net.SendToServer()

                surface.PlaySound("garrysmod/ui_click.wav")
            else
                LocalPlayer():ChatPrint("You can't afford that!")
                surface.PlaySound("buttons/button10.wav")
            end
        end

        table.insert(self.Icons, icon)
    end


    local entitiespanel = sheet:Add("DPanel")
    entitiespanel.Paint = function(self, w, h) draw.RoundedBox(4, 0, 0, w, h, Color(72, 76, 52, self:GetAlpha())) end
    sheet:AddSheet("Entities", entitiespanel, "icon16/bricks.png")

    local entityscroll = vgui.Create("DScrollPanel", entitiespanel)
    entityscroll:Dock(FILL)

    local entitylayout = entityscroll:Add("DIconLayout")
    entitylayout:Dock(FILL)
    entitylayout:SetSpaceX(4)
    entitylayout:SetSpaceY(4)

    for ligma, item in pairs(self.Entities) do
        local ent = scripted_ents.Get(item.Class)
        if !ent then continue end

        local icon = entitylayout:Add("LibreShop::ItemIcon")
        icon:SetName(ent.PrintName or item.Class)

        local material = ent.IconOverride or ("entities/" .. item.Class .. ".png")

        icon:SetMaterial(material)

        local tooltip = "Price: " .. self:GetDisplayName(item.Price)

        local info = item.Info or ent.Information

        if info and info ~= "" then
            tooltip = tooltip .. "\n\n" .. info
        end

        local author = item.Author or ent.Author

        if author and author ~= "" then
            tooltip = tooltip .. "\n\nAuthor: " .. author
        end

        icon:SetTooltip(tooltip)

        local canbuy = self.Balance >= item.Price

        icon.Price = item.Price
        icon.CanAfford = canbuy

        icon.DoClick = function(self)
            if self.CanAfford then
                net.Start("LibreShop::BuyItem")
                net.WriteString(item.Class)
                net.SendToServer()

                surface.PlaySound("garrysmod/ui_click.wav")
            else
                LocalPlayer():ChatPrint("You can't afford that!")
                surface.PlaySound("buttons/button10.wav")
            end
        end

        table.insert(self.Icons, icon)
    end



    local specialspanel = sheet:Add("DPanel")
    specialspanel.Paint = function(self, w, h) draw.RoundedBox(4, 0, 0, w, h, Color(72, 76, 52, self:GetAlpha())) end
    sheet:AddSheet("Specials", specialspanel, "icon16/ruby.png")

    local specialscroll = vgui.Create("DScrollPanel", specialspanel)
    specialscroll:Dock(FILL)

    local speciallayout = specialscroll:Add("DIconLayout")
    speciallayout:Dock(FILL)
    speciallayout:SetSpaceX(4)
    speciallayout:SetSpaceY(4)

    for ligma, item in pairs(self.Specials) do
        local icon = speciallayout:Add("LibreShop::ItemIcon")

        icon:SetName(item.Name or item.Class)

        local material = item.IconOverride or ("entities/" .. item.Class .. ".png")

        icon:SetMaterial(material)

        local tooltip = "Price: " .. self:GetDisplayName(item.Price)

        if item.Description and item.Description ~= "" then
            tooltip = tooltip .. "\n\n" .. item.Description
        end

        icon:SetTooltip(tooltip)

        local canbuy = self.Balance >= item.Price
        
        icon.Price = item.Price
        icon.CanAfford = canbuy

        icon.DoClick = function(self)
            if self.CanAfford then
                net.Start("LibreShop::BuyItem")
                net.WriteString(item.Class)
                net.SendToServer()

                surface.PlaySound("garrysmod/ui_click.wav")
            else
                LocalPlayer():ChatPrint("You can't afford that!")
                surface.PlaySound("buttons/button10.wav")
            end
        end

        table.insert(self.Icons, icon)
    end
end


function LibreShop.OpenMenu()
    LibreShop.Menu:MakePopup()
    LibreShop.Menu:SetVisible(true)
end

LibreShop:InitMenu()

concommand.Add("catalog", LibreShop.OpenMenu)