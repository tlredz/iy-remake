function foo1()end
function foo2()end

setfenv(foo1, setmetatable({ teste = 10 }, { __index = getfenv(foo1) }))

print(getfenv(foo1).teste, getfenv(foo2).teste)