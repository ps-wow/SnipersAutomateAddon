--
local _, addon = ...

addon.LARGEST_BAG = 40
addon.VENDOR_ILVL = 300
addon.SELL_BOE = true

local autosell = {
    -- WoD
    --- Blood Cards
    [113348] = true,
    [113347] = true,
    [113346] = true,
    [113340] = true,
    [113341] = true,
    [113343] = true,
    [113342] = true,
    [113344] = true,
    [113345] = true,
}

addon.autosell = autosell
