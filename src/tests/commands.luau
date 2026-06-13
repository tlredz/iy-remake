local commandsController = require("../controllers/commandsController")
local query = "fl"

print("searching for:", query)
	
for _, text in commandsController:search(query) do
	print("\t", text)
end

return true