#Include GDILib.ahk
/************************************************************************\
 Função: GetBitsFromScreen\
Descrição:\
A função GetBitsFromScreen captura uma área específica da tela e armazena os bits que representam a imagem capturada em um buffer. Ela utiliza chamadas para funções da API do Windows para capturar a tela, gerenciar a memória e processar os pixels.\
\
Parâmetros:\
captureX (Integer):\
\
Coordenada X do canto superior esquerdo da área da tela que você deseja capturar.\
captureY (Integer):\
\
Coordenada Y do canto superior esquerdo da área da tela que você deseja capturar.\
captureWidth (Integer):\
\
Largura da área da tela a ser capturada.\
captureHeight (Integer):\
\
Altura da área da tela a ser capturada.\
Setbpp (Integer, opcional):\
\
Bits por pixel para a imagem capturada. O padrão é 32 bits. Se for diferente de 32, biBitCount será ajustado de acordo.\
flag (Integer, opcional):\
\
Sinalizador que ajusta as coordenadas de captura. Se flag for 1, as coordenadas captureX e captureY são ajustadas em -10 pixels. O padrão é 1.\
Variáveis Globais:\
scan:\
\
Buffer global que armazena os bits da imagem capturada.\
biBitCount:\
\
Define o número de bits por pixel (bpp) para a imagem capturada.\
Stride:\
\
Comprimento de cada linha da imagem em bytes. Usado para determinar como os dados da imagem são armazenados na memória.\
Variáveis Estáticas:\
ID:\
\
Identificador estático da janela ativa. Usado para capturar a tela da janela ativa.\
Ptr, PtrP:\
\
Define o tipo de ponteiro com base no tamanho da arquitetura (32 bits ou 64 bits). Ptr refere-se ao tipo de ponteiro, e PtrP refere-se ao tipo de ponteiro para múltiplos ponteiros.\
Bits, ppvBits:\
\
Variáveis estáticas usadas para armazenar os bits e o ponteiro para os bits capturados.\
Fluxo de Execução:\
Validação do flag:\
\
Se flag for 0, a função exibe uma mensagem de erro e termina. Se flag for 1, ajusta as coordenadas captureX e captureY em -10 pixels.\
Validação das Coordenadas e Dimensões:\
\
Verifica se captureX, captureY, captureWidth e captureHeight são valores válidos. Se qualquer um for negativo ou captureWidth ou captureHeight forem menores ou iguais a zero, a função exibe uma mensagem de erro e retorna.\
Verificação dos Limites da Tela:\
\
Verifica se a área de captura excede os limites da tela. Se exceder, a função exibe uma mensagem de erro e retorna.\
Configuração de biBitCount:\
\
Define biBitCount com o valor de Setbpp ou assume 32 bits por pixel se não estiver definido.\
Inicialização de ID:\
\
Obtém o identificador da janela ativa, se ainda não tiver sido obtido.\
Criação do Buffer para Captura:\
\
Calcula o tamanho do buffer necessário para armazenar a imagem capturada (em bytes) e cria esse buffer.\
Obtenção do Contexto de Dispositivo (DC):\
\
Usa GetDesktopWindow para capturar a tela completa e depois cria um contexto de dispositivo compatível (MDC) para a imagem capturada.\
Configuração da Estrutura BITMAPINFO:\
\
Prepara a estrutura BITMAPINFO que contém as informações sobre o formato do bitmap (largura, altura, profundidade de cor).\
Criação do DIB Section:\
\
Cria um DIBSection (uma área de memória compartilhada que contém os bits do bitmap) e obtém um ponteiro para os bits.\
Captura da Imagem com BitBlt:\
\
Copia os pixels da área de captura especificada para o contexto de dispositivo compatível (MDC).\
Movimentação da Memória com RtlMoveMemory:\
\
Copia os bits capturados da seção DIB para o buffer scan.\
Liberação de Recursos:\
\
Seleciona o objeto anterior de volta ao contexto de dispositivo, depois deleta o objeto bitmap e libera os contextos de dispositivo.\
Mensagens de Erro:\
"Defina 'Flag'":\
\
Exibida se o flag for 0.\
"Erro: Coordenadas ou dimensões inválidas.":\
\
Exibida se as coordenadas ou dimensões de captura forem inválidas.\
"Erro: A área de captura excede os limites da tela.":\
\
Exibida se a área de captura exceder os limites da tela.\
"Erro ao obter a janela da área de trabalho.":\
\
Exibida se a função falhar ao obter a janela da área de trabalho.\
"Erro ao obter o DC da janela.":\
\
Exibida se a função falhar ao obter o contexto de dispositivo (DC) da janela.\
"Erro ao criar DC compatível.":\
\
Exibida se a função falhar ao criar um DC compatível.\
"Erro ao criar DIBSection.":\
\
Exibida se a função falhar ao criar o DIBSection.\
"Erro ao copiar bits da tela.":\
\
Exibida se a função falhar ao copiar os bits da tela.\
Retorno:
A função não possui um retorno explícito, mas preenche o buffer scan com os bits capturados da área da tela especificada. Em caso de erro, a função retorna imediatamente após exibir a mensagem de erro correspondente, sem preencher o buffer./
*/
gptGetBitsFromScreen(captureX, captureY, captureWidth, captureHeight, Setbpp := 32, flag:= 1 ) {
    static ID := 0

    if flag = 0 {
        MsgBox("Defina 'Flag'")
        ExitApp
    }

    ; Validação de Entradas
    if (captureX < 0 || captureY < 0 || captureWidth <= 0 || captureHeight <= 0) {
        MsgBox("Erro: Coordenadas ou dimensões inválidas.")
        return
    }

    ; Verifica se a captura excede os limites da tela
    screenWidth := SysGet( 78 )
    screenHeight := SysGet( 79 )

    if (captureX + captureWidth > screenWidth || captureY + captureHeight > screenHeight) {
        MsgBox("Erro: A área de captura excede os limites da tela.")
        return
    }

    if ( flag = 1 ) {
        captureX := captureX - 10
        captureY := captureY - 10
    }

    static Ptr := A_PtrSize ? "UPtr" : "UInt"
    static PtrP := Ptr "*"
    static Bits := 0
    static ppvBits := 0
    global scan
    global biBitCount
    global Stride

    ( Setbpp != 32 && biBitCount := Setbpp )
    ( !IsSet( biBitCount ) && biBitCount := 32 )

    if (!ID) {
        ID := WinGetID("A")
    }

    sizeScan := captureWidth * captureHeight * 4
    Scan := Buffer(sizeScan, 0)
    ( !IsSet(Stride) && GetStride(captureWidth) )

    Win := GetDesktopWindow()
    HDC := GetWindowDC( Win )
    if (!HDC) {
        MsgBox("Erro ao obter o DC da janela.")
        return
    }

    MDC := CreateCompatibleDC( Win, HDC )
    if (!MDC) {
        ReleaseDC( Win, HDC )
        MsgBox("Erro ao criar DC compatível.")
        return
    }

    BI := CreateBitmapInfo( captureWidth, captureHeight )

    hBM := CreateDIBSection( MDC, BI, &Bits )
    if (!hBM) {
        DeleteDC( HDC )
        ReleaseDC( Win, HDC )
        MsgBox("Erro ao criar DIBSection.")
        return
    }

    OBM := SelectObject( HDC, hBM )
    Result :=
    BitBlt(
        HDC,
        0, 0,
        captureWidth, captureHeight,
        MDC,
        captureX, captureY
    )

    if (!Result ) {
        SelectObject( HDC, hBM )
        DeleteObject( hBM )
        DeleteDC( MDC )
        ReleaseDC( Win, HDC )

        MsgBox("Erro ao copiar bits da tela.")
        return
    }

   
    if( !RtlMoveMemory( &Scan, &ppvBits, Stride * captureHeight ) )
        MsgBox( "Erro Copy")
    clearT:
    hBM := SelectObject( MDC, OBM )

    if( ! DeleteObject( hbM ) )
        MsgBox( "Erro del")

    If !DeleteDC( MDC )
        MsgBox( "Erro del MDC")

    if !ReleaseDC( Win, HDC )
        MsgBox( "Erro free")
}
