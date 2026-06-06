local string1 = 'aspas simples'
local string2 = "aspas duplas"
local string3 = [[
    teste com 
    quebra de linha
]]

local numero = 50
local bool = string4

if bool == nil or numero == 50 then
    print("caiu aqui")
else if numero then
    print("numero existe:",  numero)
else
    print("Variaveis falsas")
end
end

while bool == nil do
    if numero == 50 then
        bool = true
    end
    print(bool)
end

repeat
    if numero == 50 then
        bool = true
    end
    print(bool)
until bool

for i = 1, 10 do
    print(i)
end
for i = 10, 1, -1 do
        print(i)
end

function soma(x, y)
    return x + y
end
print(soma(50,10))
