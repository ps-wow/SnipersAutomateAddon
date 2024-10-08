---@type string, AddonNS
local _, addon = ...

local SniperFrame = CreateFrame("Frame");

local function Debug(obj, desc)
    if DevTool then
        DevTool:AddData(obj, desc)
    end
end


function SniperFrame:MERCHANT_SHOW()
    local inventory = addon.GetItemsFromBags();

    for i=0,addon.LARGEST_BAG,1 do
        for container=0,4,1 do
            if inventory[container][i] ~= nil then
                local item = inventory[container][i];
                local itemID = item.itemInfo.itemID

                -- Don't sell protected items
                if addon.sellprotect and (addon.sellprotect[itemID] == true) then
                    return
                end

                -- Sell low ilvl armor
                if item.itemType == "Armor" or item.itemType == "Weapon" then
                    if tonumber(item.ilvl) < tonumber(addon.VENDOR_ILVL) then
                        -- Don't sell BoE
                        if (item.itemInfo.isBound == true) or addon.SELL_BOE == true then
                            addon.sellBagItem(container, i)
                        end
                    end
                end

                -- Sell old relics
                if item.itemSubType == "Artifact Relic" then
                    addon.sellBagItem(container, i)
                end

                -- Sell manually typed items
                if addon.autosell and (addon.autosell[itemID] == true) then
                    addon.sellBagItem(container, i)
                end

                if addon.autodelete and (addon.autodelete[itemID] == true) then
                    addon.deleteBagItem(container, i)
                end
            end
        end
    end

end


SniperFrame:RegisterEvent("MERCHANT_SHOW");

-- Set the OnEvent script handler 
SniperFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "MERCHANT_SHOW" then
		SniperFrame:MERCHANT_SHOW()
	elseif event == "ANOTHER_EVENT" then
	end
end)