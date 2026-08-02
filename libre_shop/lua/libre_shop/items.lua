
LibreShop:RegisterWeapon({
    Class = "m9k_davy_crockett",
    Price = 2500, // small price to pay for some destruction
})

LibreShop:RegisterWeapon({
    Class = "weapon_bas_ball_shooter_admin",
    Price = 500,
})

LibreShop:RegisterWeapon({
    Class = "weapon_tbfusrodah2",
    Price = 500,
})

LibreShop:RegisterWeapon({
    Class = "weapon_crasher",
    Price = 500,
})

LibreShop:RegisterWeapon({
    Class = "weapon_dearsistah",
    Price = 5000, // dangerous
})

LibreShop:RegisterWeapon({
    Class = "weapon_vape_dragon",
    Price = 500,
})

LibreShop:RegisterWeapon({
    Class = "m9k_orbital_strike",
    Price = 500,
})

LibreShop:RegisterWeapon({
    Class = "weapon_extinguisher_infinite",
    Price = 50, // shouldbe free honestly
})

LibreShop:RegisterWeapon({
    Class = "weapon_popcorn_spam",
    Price = 50, // shouldbe free honestly
})


// lenn weapons (why are these admin)
LibreShop:RegisterWeapon({
    Class = "weapon_v2lenn_physics_gun_the_real_fridge_2025",
    Price = 100,
})


LibreShop:RegisterWeapon({
    Class = "weapon_v2lenn_physics_gun_the_real_original_2025",
    Price = 100,
})


LibreShop:RegisterWeapon({
    Class = "weapon_v2lenn_physics_gun_tidegates_2025",
    Price = 100,
})


LibreShop:RegisterWeapon({
    Class = "weapon_v2lenn_physics_gun_breendesk_2025",
    Price = 100,
})


LibreShop:RegisterWeapon({
    Class = "weapon_v2lenn_physics_gun_fridge_2025",
    Price = 100,
})


LibreShop:RegisterWeapon({
    Class = "weapon_v2lenn_howdoesitfeelliketoobeoverpowered_2025",
    Price = 100,
})


LibreShop:RegisterWeapon({
    Class = "manhack_welder",
    Price = 100,
})


LibreShop:RegisterWeapon({
    Class = "weapon_flechettegun",
    Price = 100,
})




// now we're getting juicy
LibreShop:RegisterEntity({
    Class = "edit_fog",
    Price = 1000,
})


LibreShop:RegisterEntity({
    Class = "edit_sky",
    Price = 1000,
})


LibreShop:RegisterEntity({
    Class = "edit_sun",
    Price = 1000,
})


LibreShop:RegisterEntity({
    Class = "sent_she_turret3",
    Price = 2500,
})


LibreShop:RegisterEntity({
    Class = "sent_she_manhole",
    Price = 7500, // dangerous
})


LibreShop:RegisterEntity({
    Class = "sent_she_mogeko",
    Price = 5000,
})


LibreShop:RegisterEntity({
    Class = "lvs_vehicle_spammer",
    Price = 1000,
})


LibreShop:RegisterEntity({
    Class = "monster_nihilanth", // i know its an npc fuck off
    Price = 2500,
})

LibreShop:RegisterEntity({
    Class = "m9k_ammo_nuke",
    Price = 1000,
})

LibreShop:RegisterEntity({
    Class = "m9k_ammo_40mm",
    Price = 500,
})

LibreShop:RegisterEntity({
    Class = "m9k_ammo_nervegas",
    Price = 500,
})

LibreShop:RegisterEntity({
    Class = "m9k_ammo_stickynades",
    Price = 500,
})

LibreShop:RegisterEntity({
    Class = "m9k_ammo_c4",
    Price = 500,
})

LibreShop:RegisterEntity({
    Class = "m9k_ammo_frags",
    Price = 500,
})

LibreShop:RegisterEntity({
    Class = "m9k_ammo_proxmines",
    Price = 500,
})

LibreShop:RegisterEntity({
    Class = "m9k_ammo_ieds",
    Price = 500,
})

LibreShop:RegisterEntity({
    Class = "m9k_ammo_rockets",
    Price = 500,
})


LibreShop:RegisterSpecial({
    Class = "Clean Map",
    Price = 5000,
    Callback = function(self, eplayer)
        game.CleanUpMap()

        if sv_PProtect then
            sv_PProtect.Notify(eplayer, 'Cleaned Map.', 'info')
        end
    end
})