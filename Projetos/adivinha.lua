math.randomseed(os.time())

local numeroSecreto = math.random(1, 100)

local tentativas = 0
local nEscolhidos = {}

local minimo = 1
local maximo = 100

local function mostrarTentativas(lista)
    print("\nNúmeros tentados:")

    if #lista == 0 then
        print("Nenhum")
        return
    end

    for _, numero in ipairs(lista) do
        io.write(numero .. " ")
    end

    print()
end

while true do

    mostrarTentativas(nEscolhidos)

    print("\nIntervalo atual: " .. minimo .. " - " .. maximo)

    io.write("Escolha um número: ")
    local chute = tonumber(io.read())

    if chute == nil then
        print("Digite um número válido!")

    elseif chute < 1 or chute > 100 then
        print("Digite um número entre 1 e 100!")

    else

        local repetido = false

        for _, numero in ipairs(nEscolhidos) do
            if numero == chute then
                repetido = true
                break
            end
        end

        if repetido then

            print("Você já tentou esse número!")

        else

            table.insert(nEscolhidos, chute)

            tentativas = tentativas + 1

            if chute == numeroSecreto then

                print("\n🎉 Acertou!")
                print("Número secreto: " .. numeroSecreto)
                print("Tentativas: " .. tentativas)

                break

            elseif chute < numeroSecreto then

                print("O número secreto é maior.")

                if chute + 1 > minimo then
                    minimo = chute + 1
                end

            else

                print("O número secreto é menor.")

                if chute - 1 < maximo then
                    maximo = chute - 1
                end

            end
        end
    end
end