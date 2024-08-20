--
local _, addon = ...

addon.LARGEST_BAG = 40
addon.VENDOR_ILVL = 300
addon.SELL_BOE = true

local autosell = {
    -- WoD
    --- Blood Cards (Inscription)
    [113348] = true,
    [113347] = true,
    [113346] = true,
    [113340] = true,
    [113341] = true,
    [113343] = true,
    [113342] = true,
    [113344] = true,
    [113345] = true,
    [113352] = true,
    [113351] = true,
}

-- TODO: This doesn't work yet
local autodelete = {
    -- WoD
    [113289] = true, -- Volatile Crystal (Inscription)
    -- Other
    [97985] = true, -- Dusty Old Robot
}

local sellprotect = {
    [63353] = true, -- Shroud of Cooperation
}

addon.autosell = autosell
addon.autodelete = autodelete
addon.sellprotect = sellprotect