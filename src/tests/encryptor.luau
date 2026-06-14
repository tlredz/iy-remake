local encryptor = require("../utils/encryptor")
encryptor = encryptor.new(1e6)

local message = "this is my message decrypted"
local encrypted = encryptor:encrypt(message)
local decrypted = encryptor:decrypt(encrypted)

print("original:", message)
print("encrypted:", encrypted)
print("decrypted:", decrypted)