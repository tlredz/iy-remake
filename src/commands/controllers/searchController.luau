local searchController = {}

-- Case-insensitive substring search. Matches at the start of the text come first.
function searchController:searchAtArray(
	array: { string },
	query: string,
	onlyBests: boolean
): { string }
	if query == "" then return {} end
	
	local lowerQuery = query:lower()
	local bestMatches = {}
	local regularMatches = {}
	
	for _, text in array do
		local lowerText = tostring(text):lower()
		
		if #lowerText < #lowerQuery then continue end
		
		local startPos = lowerText:find(lowerQuery, 1, true)
		
		if startPos == 1 then
			table.insert(bestMatches, text)
		elseif startPos and not onlyBests then
			table.insert(regularMatches, text)
		end
	end
	
	for _, text in regularMatches do
		table.insert(bestMatches, text)
	end
	
	return bestMatches
end

return searchController
