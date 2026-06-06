local running = true
local historico = {}

-- =========================
-- Operações básicas
-- =========================

local function soma(lista)
    local resultado = 0

    for _, numero in ipairs(lista) do
        resultado = resultado + numero
    end

    return resultado
end

local function sub(lista)
    local resultado = lista[1]

    for i = 2, #lista do
        resultado = resultado - lista[i]
    end

    return resultado
end

local function mult(lista)
    local resultado = 1

    for _, numero in ipairs(lista) do
        resultado = resultado * numero
    end

    return resultado
end

local function div(lista)
    local resultado = lista[1]

    for i = 2, #lista do
        if lista[i] == 0 then
            return nil
        end

        resultado = resultado / lista[i]
    end

    return resultado
end

local function power(lista)
    local resultado = lista[#lista]

    for i = #lista - 1, 1, -1 do
        resultado = lista[i] ^ resultado
    end

    return resultado
end

local function sqrt(numero)
    return math.sqrt(numero)
end

-- =========================
-- Trigonométricas
-- =========================

local trigonometria = {
    ["1"] = {
        nome = "sin",
        func = function(x)
            return math.sin(math.rad(x))
        end
    },

    ["2"] = {
        nome = "cos",
        func = function(x)
            return math.cos(math.rad(x))
        end
    },

    ["3"] = {
        nome = "tan",
        func = function(x)
            return math.tan(math.rad(x))
        end
    },

    ["4"] = {
        nome = "asin",
        func = math.asin
    },

    ["5"] = {
        nome = "acos",
        func = math.acos
    },

    ["6"] = {
        nome = "atan",
        func = math.atan
    }
}

-- =========================
-- Operações principais
-- =========================

local operacoes = {
    ["+"] = soma,
    ["-"] = sub,
    ["*"] = mult,
    ["/"] = div,
    ["^"] = power
}

-- =========================
-- Funções auxiliares
-- =========================

local function lerNumeros()
    io.write("Quantos números deseja usar? ")

    local quantidade = tonumber(io.read())

    if quantidade == nil or quantidade <= 0 then
        return nil
    end

    local numeros = {}

    for i = 1, quantidade do
        io.write("Digite o número " .. i .. ": ")

        local numero = tonumber(io.read())

        if numero == nil then
            return nil
        end

        table.insert(numeros, numero)
    end

    return numeros
end

local function mostrarHistorico()
    print("\n===== HISTÓRICO =====")

    if #historico == 0 then
        print("Histórico vazio")
        return
    end

    for i, operacao in ipairs(historico) do
        print(i .. ". " .. operacao)
    end
end

local function menuPrincipal()
    print("\nEscolha uma operação:")
    print("[+] Soma")
    print("[-] Subtração")
    print("[*] Multiplicação")
    print("[/] Divisão")
    print("[^] Potência")
    print("[V] Raiz Quadrada")
    print("[T] Trigonométricas")
    print("[H] Histórico")
    print("[0] Sair")
    io.write("Opção: ")

    return io.read():lower()
end

local function menuTrigonometria()
    print("\n===== TRIGONOMÉTRICAS =====")
    print("[1] seno")
    print("[2] cosseno")
    print("[3] tangente")
    print("[4] arco seno")
    print("[5] arco cosseno")
    print("[6] arco tangente")
    io.write("Opção: ")

    return io.read()
end

-- =========================
-- Programa
-- =========================

print("===============")
print("  Calculadora  ")
print("===============")

while running do

    local op = menuPrincipal()

    if op == "0" then

        running = false

    elseif op == "h" then

        mostrarHistorico()

    elseif op == "v" then

        io.write("Digite um número: ")

        local numero = tonumber(io.read())

        if numero == nil then

            print("[Erro] Número inválido")

        else

            local resultado = sqrt(numero)

            print("√" .. numero .. " = " .. resultado)

            table.insert(
                historico,
                "√" .. numero .. " = " .. resultado
            )
        end

    elseif op == "t" then

        local escolha = menuTrigonometria()

        if trigonometria[escolha] then

            io.write("Digite um valor: ")

            local valor = tonumber(io.read())

            if valor ~= nil then

                local resultado =
                    trigonometria[escolha].func(valor)

                local registro =
                    trigonometria[escolha].nome ..
                    "(" .. valor .. ") = " ..
                    resultado

                print(registro)

                table.insert(historico, registro)

            else

                print("[Erro] Valor inválido")

            end

        else

            print("[Erro] Opção inválida")

        end

    elseif operacoes[op] then

        local numeros = lerNumeros()

        if numeros == nil then

            print("[Erro] Entrada inválida")

        else

            local resultado = operacoes[op](numeros)

            if resultado == nil then

                print("[Erro] Divisão por zero")

            else

                local expressao = ""

                for i, numero in ipairs(numeros) do

                    expressao = expressao .. numero

                    if i < #numeros then
                        expressao = expressao .. " " .. op .. " "
                    end
                end

                expressao =
                    expressao .. " = " .. resultado

                print(expressao)

                table.insert(historico, expressao)

            end
        end

    else

        print("[Erro] Operação inválida")

    end

    if running then

        io.write("\nDeseja fazer outro cálculo (s/n): ")

        local resp = io.read()

        if resp:lower() ~= "s" then
            running = false
        end
    end
end

print("\nPrograma encerrado.")