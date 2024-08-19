--
local _, addon = ...

local function Debug(obj, desc)
    if DevTool then
        DevTool:AddData(obj, desc)
    end
end

function addon.GetItemTooltipLines(itemID)
    local tooltip = C_TooltipInfo.GetItemByID(itemID)
    return tooltip.lines
end

function addon.sellItem(container, slot)

end

function addon.GetRealILVL(item)
	local realILVL = nil

	if item ~= nil then
		tooltip = tooltip or CreateEmptyTooltip()
		tooltip:ClearLines()
		tooltip:SetHyperlink(item)

        if tooltip.processingInfo == nil then
            return 0
        end
        
        local lines = tooltip.processingInfo.tooltipData.lines

        for i, line in ipairs(lines) do
            if line.leftText ~= nil then
                local lvl = line.leftText:match('Item Level (%d+)')
                if lvl then
                    realILVL = lvl
                end
            end
        end
		tooltip:Hide()

		-- if realILVL is still nil, we couldn't find it in the tooltip - try grabbing it from getItemInfo, even though
		--   that doesn't return upgrade levels
		if realILVL == nil then
			return 0
		end
	end

	if realILVL == nil then
		return 0
	else
		return tonumber(realILVL)
	end
end

-- Inventory
function addon.BuildItemData(itemInfo)
    if itemInfo ~= nil then
        local data = {}
        local itemID = itemInfo.itemID or nil
    
        data.itemInfo = itemInfo
        data.tooltip = addon.GetItemTooltipLines(itemID)
    
        local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subclassID = GetItemInfoInstant(itemID);

        data.itemType = itemType
        data.itemSubType = itemSubType
        data.itemEquipLoc = itemEquipLoc
        data.classID = classID
        data.subclassID = subclassID

        local ilvl = addon.GetRealILVL(itemInfo.hyperlink)

        data.ilvl = ilvl
    
        return data
    end

    return nil
end

function addon.GetItemsFromBags()
    local items = {
        -- Backpack
        [0] = {},
        -- Bags 1-4
        [1] = {},
        [2] = {},
        [3] = {},
        [4] = {}
    };

    -- Container 0 = Backpack
    for i=0,addon.LARGEST_BAG,1 do
        
        items[0][i] = addon.BuildItemData(C_Container.GetContainerItemInfo(0, i))
        items[1][i] = addon.BuildItemData(C_Container.GetContainerItemInfo(1, i))
        items[2][i] = addon.BuildItemData(C_Container.GetContainerItemInfo(2, i))
        items[3][i] = addon.BuildItemData(C_Container.GetContainerItemInfo(3, i))
        items[4][i] = addon.BuildItemData(C_Container.GetContainerItemInfo(4, i))

    end

    return items
end

function addon.sellBagItem(container, i)
    ClearCursor()
    C_Container.PickupContainerItem(container, i)
    SellCursorItem()
end

function addon.deleteBagItem(container, i)
    ClearCursor()
    -- C_Container.PickupContainerItem(container, i)
    -- DeleteCursorItem()
end

-- Character
function addon.GetPlayerClass()
    return UnitClass("player");
end