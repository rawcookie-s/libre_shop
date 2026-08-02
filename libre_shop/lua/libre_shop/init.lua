LibreShop = {
    Specials = {},
    Entities = {},
    Weapons = {},

    Balance = 0, //client only
}


/*
    Class = "weapon_dearsistah",
    Price = 5000,
    Info = "hey hi hello", // this will be replaced with weapon's data in the menu if it doesnt exist
    Author = "hi hey hello 👋🏻", // same with tis one

    // called when player purchases the item
    Callback = function(self, eplayer, entity) end),
    
    self = item table, used to get access to price n stuff
    eplayer = player who purchased the item, duh
    entity = the item spawned, doesnt exist for special items
*/

function LibreShop:RegisterWeapon(etable)
    etable.Type = "WEAPON"

    self.Weapons[etable.Class] = etable
end

// same as wweapon basically
function LibreShop:RegisterEntity(etable)
    etable.Type = "ENTITY"

    self.Entities[etable.Class] = etable
end

//basically the same as weapon but class is just a name now and callback does whatever you want to
function LibreShop:RegisterSpecial(etable)
    etable.Type = "SPECIAL"

    self.Specials[etable.Class] = etable
end





function LibreShop.Load()
    timer.Simple(0.5, function() // delay needed so functions can be detoured
        include("libre_shop/util.lua")
        include("libre_shop/items.lua")

        if SERVER then
            include("libre_shop/detours.lua")
            include("libre_shop/handler.lua")
        end

        if CLIENT then
            include("libre_shop/vgui.lua")
            include("libre_shop/menu.lua")
        end
    end)
end

// curse you leme for loading sc with this hook
hook.Add("InitPostEntity", "LibreShop::Load", LibreShop.Load)