local tools = {}

local readableChars = "abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUV_0123456789"

local RICH_TEXT_ESCAPE = {
    ["&"] = "&amp;",
    ["<"] = "&lt;",
    [">"] = "&gt;",
    ["\""] = "&quot;",
    ["'"] = "&apos;"
}

function tools.randomString(length: number): string
	local buffer = {}
	for _ = 1, length do
		local index = math.random(1, #readableChars)
		table.insert(buffer, readableChars:sub(index, index))
	end
	return table.concat(buffer)
end

function tools.getDeep(tab: table, path: string): table
	for key in path:gmatch("[^%.]+") do
		tab = tab[key]
	end
	return tab
end

function tools.simpleCreate(className: string, properties: { [string]: any }): Instance
	local object = Instance.new(className)
	for property, value in properties do
		object[property] = value
	end
	return object
end

function tools.chararray(text: string): { string }
	local array = {}
	for key = 1, #text do
		table.insert(array, text:sub(1, 1))
	end
	return array
end

function tools.lookupify(array: { any }): { [any]: true }
	local tab = {}
	for key = 1, #array do
		local value = array[key]
		tab[value] = true
	end
	return tab
end

function tools.unlookupify(tab: { [any]: any }): { any }
	local array = {}
	for key, _ in tab do
		table.insert(array, key)
	end
	return array
end

function tools.escapeRichText(text)
	return text:gsub(".", function(char)
		return RICH_TEXT_ESCAPE[char] or char
	end)
end

function tools.versionToNumber(version: string): number
	local cleanVersion = version:gsub("^v", "")
	
	local versionNumber = 0
	local parts = cleanVersion:split(".")
	
	for index, part in parts do
		local numericPart = tonumber(part) or 0
		versionNumber += numericPart * math.pow(1000, 3 - index)
	end
	
	return versionNumber
end

function tools.colorFromRGB(text, color3)
	return `<font color="#{color3:ToHex()}">{text}</font>`
end

function tools.richFontSize(text, size)
	return `<font size="{size}">{text}</font>`
end

return tools