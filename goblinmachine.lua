-- Base de dados de receitas e reagentes com códigos
local baseDeDadosReceitas = {
    ["cura"] = {["Poção de Cura"] = {["Erva"] = 2, ["Água"] = 1}},
    ["couro"] = {["Couro Tratado"] = {["Couro"] = 4, ["Sal"] = 2}},
    -- Adicione mais receitas conforme necessário
}

-- Função que lê a base de dados e retorna a lista de receitas e seus códigos
local function LerBaseDeDados()
    -- Simulando a leitura da base de dados
    return {
        ["cura"] = "Poção de Cura",
        ["couro"] = "Couro Tratado",
        -- Adicione mais códigos e receitas conforme necessário
    }
end

-- Função que calcula a quantidade de reagentes necessários para uma receita de profissão
local function CalcularReagentes(receita, quantidade)
    local reagentes = receita
    local reagentesNecessarios = {}

    for reagente, quantidadeRequerida in pairs(reagentes) do
        reagentesNecessarios[reagente] = quantidadeRequerida * quantidade
    end

    return reagentesNecessarios
end

-- Função que mostra a lista de códigos e receitas disponíveis
local function MostrarListaReceitas()
    local listaReceitas = LerBaseDeDados()
    print("Receitas disponíveis:")
    for codigo, receita in pairs(listaReceitas) do
        print("- Código: " .. codigo .. ", Receita: " .. receita)
    end
end

-- Função principal que mostra os reagentes necessários para uma receita específica
local function MostrarReagentesParaReceita(codigo, quantidade)
    local receita = baseDeDadosReceitas[codigo]
    if not receita then
        print("Código não encontrado: " .. codigo)
        return
    end

    -- Como temos a receita como um sub-dicionário, pegamos a primeira chave
    local nomeReceita = next(receita)
    print("Quantidade de reagentes para: " .. nomeReceita)
    local reagentesNecessarios = CalcularReagentes(receita[nomeReceita], quantidade)
    for reagente, quantidade in pairs(reagentesNecessarios) do
        print(reagente .. ": " .. quantidade)
    end
    print("-------------------------------------------")
end

-- Função para lidar com comandos de barra
local function SlashCommandHandler(msg)
    local args = {}
    for word in msg:gmatch("%S+") do
        table.insert(args, word)
    end

    if args[1] == "list" then
        MostrarListaReceitas()
    elseif args[1] == "calc" then
        local codigo = args[2]
        local quantidade = tonumber(args[3]) or 1
        MostrarReagentesParaReceita(codigo, quantidade)
    else
        print("Uso: /goblin list | /goblin calc <código> [quantidade]")
    end
end

-- Registrar o comando de barra "/goblin"
SLASH_GOBLIN1 = "/goblin"
SlashCmdList["GOBLIN"] = SlashCommandHandler

