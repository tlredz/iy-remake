--!strict
-- src/ui/utils/titleFormatter.luau

local titleFormatter = {}

local fwSettings = require("../../framework/settings") 
local emojis = require("../themes/tokens/emojis")

function titleFormatter.getEasterDate(): string
	local year: number = tonumber(os.date("%Y"))
	
	local century = math.floor(year / 100)
	local correction = math.floor((13 + 8 * century) / 25)
	local solarCorrection = (15 - correction + century - math.floor(century / 4)) % 30
	local lunarCorrection = (4 + century - math.floor(century / 4)) % 7

	local epact = (19 * (year % 19) + solarCorrection) % 30
	local daysToAdd = (2 * (year % 4) + 4 * (year % 7) + 6 * epact + lunarCorrection) % 7
	local paschalFullMoon = 22 + epact + daysToAdd

	if epact == 29 and daysToAdd == 6 then
		return "04 19"
	elseif epact == 28 and daysToAdd == 6 then
		return "04 18"
	end

	if paschalFullMoon > 31 then
		return string.format("04 %02d", paschalFullMoon - 31)
	end

	return string.format("03 %02d", paschalFullMoon)
end

function titleFormatter.getHolidayEmoji(): string?
    local eDate = titleFormatter.getEasterDate()
    
	local holidays = {
		["01 01"] = emojis["NEW_YEAR"],
		["02 14"] = emojis["VALENTINE_DAYS"],
		["03 17"] = emojis["CLOVER"],
		["10 31"] = emojis["HALLOWEEN"],
		["12 25"] = emojis["CHRISTMAS"],
		[eDate]   = emojis["EASTER"]
	}
	
	local today = os.date("%m %d")
	return holidays[today]
end

function titleFormatter.getDisplayName(): string
	local displayName: string = fwSettings.applicationName
	local version: string = fwSettings.version
	
	displayName = string.gsub(displayName, "!VERSION", version)
	
	local holidayEmoji = titleFormatter.getHolidayEmoji()
	
	if holidayEmoji then
		displayName = `{holidayEmoji} {displayName} {holidayEmoji}`
	end
	
	return displayName
end

return titleFormatter