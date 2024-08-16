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

                -- Sell low ilvl armor
                if item.itemType == "Armor" then
                    if tonumber(item.ilvl) < tonumber(addon.VENDOR_ILVL) then
                        addon.sellBagItem(container, i)
                    end
                end

                if item.itemSubType == "Artifact Relic" then
                    addon.sellBagItem(container, i)
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