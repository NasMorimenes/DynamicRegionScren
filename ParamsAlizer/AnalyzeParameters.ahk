;Ver Doc no final

AnalyzeParameters( Data* ) {
    ; Inicialização dos parâmetros
    hM := 0
    pfnM := ""
    hK := 0
    pfnK := ""

    ; Atribuição dos valores de acordo com o número de parâmetros passados
    if (Data.MaxIndex() >= 2)
    {
        hM := Data[1]
        pfnM := Data[2]
    }

    if (Data.MaxIndex() >= 4)
    {
        hK := Data[3]
        pfnK := Data[4]
    }

    ; Verificação se pelo menos um dos parâmetros hM ou hK foi definido
    if (hM = 0 and hK = 0)
    {
        MsgBox, "Pelo menos um dos parâmetros hM ou hK deve ser definido."
        return false
    }

    ; Verificação do parâmetro hM e sua função correspondente pfnM
    if (hM != 0)
    {
        if !IsNumber(hM)
        {
            MsgBox, "hM deve ser um número válido."
            return false
        }

        if !IsFunc(pfnM)
        {
            MsgBox, "pfnM deve ser uma função válida."
            return false
        }
    }

    ; Verificação do parâmetro hK e sua função correspondente pfnK
    if (hK != 0)
    {
        if !IsNumber(hK)
        {
            MsgBox, "hK deve ser um número válido."
            return false
        }

        if !IsFunc(pfnK)
        {
            MsgBox, "pfnK deve ser uma função válida."
            return false
        }
    }

    ; Retorna um array com os parâmetros verificados
    return [hM, pfnM, hK, pfnK]
}

InstallHookMKV2(Data*)
{
    ; Chama a função auxiliar para analisar os parâmetros
    result := AnalyzeParameters(Data*)

    ; Verifica se a análise dos parâmetros foi bem-sucedida
    if (result = false)
    {
        return
    }

    ; Extração dos parâmetros verificados
    hM := result[1]
    pfnM := result[2]
    hK := result[3]
    pfnK := result[4]

    ; Chamada da função correspondente a hM
    if (hM != 0)
    {
        %pfnM%()
    }

    ; Chamada da função correspondente a hK
    if (hK != 0)
    {
        %pfnK%()
    }

    ; Continuação da lógica da função com hM, hK, pfnM e pfnK
    ; ...
}

; Exemplo de uso
MyFunctionM()
{
    MsgBox, "Função pfnM foi chamada."
}

MyFunctionK()
{
    MsgBox, "Função pfnK foi chamada."
}

; Chamando a função com hM e pfnM definidos
InstallHookMKV2(1234, "MyFunctionM")

; Chamando a função com hK e pfnK definidos
InstallHookMKV2(0, "", 5678, "MyFunctionK")

; Chamando a função com ambos hM e hK e suas funções correspondentes
InstallHookMKV2(1234, "MyFunctionM", 5678, "MyFunctionK")

/*
Solicitação ao ChatGPT: Considere, 'InstallHookMKV2(Hook*)' seja uma função que instalará um ou mais hooks,
crie o universo de parâmetros possíveis para função quando passados para 'AnalyzeParameters(Hook*)'.

Chat:
Para a função InstallHookMKV2(Hook*), que instalará um ou mais hooks, é essencial definir um conjunto de parâmetros possíveis que a função pode aceitar. Estes parâmetros precisarão ser verificados e processados pela função auxiliar AnalyzeParameters.

Vamos definir um universo de parâmetros possíveis para a instalação de hooks:

Identificador do Hook (hX): Um número identificando o hook.
Função do Hook (pfnX): Uma função associada ao hook que será chamada quando o hook for acionado.
Tipo de Hook: Pode ser útil definir diferentes tipos de hooks, como "Mouse", "Keyboard", etc. (opcional)
Prioridade do Hook: A prioridade ou ordem de execução do hook (opcional).
Estrutura de Parâmetros
Cada hook pode ser definido por:

hX: Identificador do hook.
pfnX: Função associada ao hook.
typeX: Tipo do hook (opcional).
priorityX: Prioridade do hook (opcional).
Implementação da Função AnalyzeParameters
Vamos criar a função AnalyzeParameters para analisar os parâmetros fornecidos na forma Hook*. A função verificará a validade dos parâmetros e retornará uma estrutura organizada.

autohotkey
Copiar código
AnalyzeParameters(Hook*)
{
    ; Inicialização de uma lista para armazenar os hooks
    hooks := []

    ; Iterar sobre os parâmetros fornecidos
    Loop, % Hook.MaxIndex()
    {
        ; Cada hook deve ter pelo menos 2 parâmetros: identificador e função
        if (Mod(A_Index - 1, 2) = 0)
        {
            hX := Hook[A_Index]
            pfnX := Hook[A_Index + 1]

            ; Verificação do identificador do hook
            if !IsNumber(hX)
            {
                MsgBox, "hX deve ser um número válido."
                return false
            }

            ; Verificação da função associada ao hook
            if !IsFunc(pfnX)
            {
                MsgBox, "pfnX deve ser uma função válida."
                return false
            }

            ; Inicialização de um objeto para armazenar as propriedades do hook
            hook := { "id": hX, "func": pfnX }

            ; Verificação e adição de parâmetros opcionais
            if (A_Index + 2 <= Hook.MaxIndex() && IsString(Hook[A_Index + 2]))
            {
                hook.type := Hook[A_Index + 2]
                A_Index++
            }
            
            if (A_Index + 2 <= Hook.MaxIndex() && IsNumber(Hook[A_Index + 2]))
            {
                hook.priority := Hook[A_Index + 2]
                A_Index++
            }

            ; Adicionar o hook à lista
            hooks.Push(hook)
        }
    }

    ; Verificar se pelo menos um hook foi definido
    if (hooks.MaxIndex() = 0)
    {
        MsgBox, "Pelo menos um hook deve ser definido."
        return false
    }

    ; Retornar a lista de hooks verificados
    return hooks
}

InstallHookMKV2(Hook*)
{
    ; Chama a função auxiliar para analisar os parâmetros
    hooks := AnalyzeParameters(Hook*)

    ; Verifica se a análise dos parâmetros foi bem-sucedida
    if (hooks = false)
    {
        return
    }

    ; Iterar sobre os hooks verificados e instalar cada um
    for index, hook in hooks
    {
        ; Chamada da função correspondente ao hook
        %hook.func%()
        
        ; Exemplo de continuação da lógica de instalação do hook
        ; MsgBox, % "Hook instalado: " hook.id " com a função: " hook.func
    }
}

; Exemplo de uso
MyFunctionM()
{
    MsgBox, "Função pfnM foi chamada."
}

MyFunctionK()
{
    MsgBox, "Função pfnK foi chamada."
}

; Chamando a função com múltiplos hooks
InstallHookMKV2(1234, "MyFunctionM", "Mouse", 1, 5678, "MyFunctionK", "Keyboard", 2)
Explicação
Função AnalyzeParameters:

Inicializa uma lista para armazenar os hooks.
Itera sobre os parâmetros fornecidos, agrupando-os em pares (identificador e função).
Verifica a validade dos identificadores e funções.
Adiciona parâmetros opcionais (type e priority) se fornecidos.
Adiciona cada hook verificado à lista de hooks.
Retorna a lista de hooks verificados ou false se houver um erro.
Função Principal InstallHookMKV2:

Chama a função AnalyzeParameters para verificar e processar os parâmetros.
Itera sobre a lista de hooks verificados e instala cada um, chamando as funções associadas.
A lógica de instalação do hook é representada pela chamada da função e pode ser estendida conforme necessário.
Benefícios
Modularidade: A função AnalyzeParameters lida com a verificação e organização dos parâmetros, mantendo a função principal limpa e focada na lógica de instalação.
Flexibilidade: Suporta múltiplos hooks com parâmetros opcionais, permitindo fácil extensão no futuro.
Clareza: Mensagens de erro informativas ajudam a identificar problemas com os parâmetros fornecidos.
