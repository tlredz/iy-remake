local searchController = {}

function searchController:searchAtArray(
    array: { string },
    query: string,
    onlyBests: boolean
): { string }
    if query == "" then return {} end
    
    local bestMatches = {}
    local regularMatches = {}
    
    for _, text in array do
        if #text < #query then continue end
        
        local startPos = text:find(query, 1, true)
        
        if startPos then
            if startPos == 1 then
                table.insert(bestMatches, text)
            elseif not onlyBests then
                table.insert(regularMatches, text)
            end
        end
    end
    
    for _, text in regularMatches do
        table.insert(bestMatches, text)
    end
    
    return bestMatches
end

return searchController