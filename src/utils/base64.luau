-- src/utils/base64.luau
-- Turns base64 text back into the bytes it stands for. The images built into the code are kept as base64 text
-- (ui/themes/icons/raw, made by build.bash), so they fit in a Lua string, and are read back here as the PNG files they were.

local ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local VALUES = {}
for index = 1, #ALPHABET do
	VALUES[string.byte(ALPHABET, index)] = index - 1
end

local base64 = {}

-- the bytes of a base64 text. Characters that are not in the alphabet (line breaks, the = padding) are skipped
function base64.decode(text: string): string
	local bytes = {}
	local group = 0 -- the 6-bit values read so far, in the group of 4 characters that is being filled
	local count = 0

	for index = 1, #text do
		local value = VALUES[string.byte(text, index)]
		if value == nil then continue end

		group = group * 64 + value
		count += 1

		if count == 4 then
			table.insert(bytes, string.char(group // 65536, (group // 256) % 256, group % 256))
			group, count = 0, 0
		end
	end

	-- the last characters make fewer bytes: 2 characters make 1 byte, 3 characters make 2
	if count >= 2 then
		group *= 2 ^ (6 * (4 - count))

		table.insert(bytes, string.char(group // 65536))

		if count == 3 then
			table.insert(bytes, string.char((group // 256) % 256))
		end
	end

	return table.concat(bytes)
end

return base64
