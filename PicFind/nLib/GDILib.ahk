/**Documentação da Função GetDesktopWindow
Função: GetDesktopWindow\
Descrição:\
A função GetDesktopWindow chama a função da API do Windows GetDesktopWindow para obter o identificador da janela da área de trabalho (desktop). Esse identificador pode ser usado em operações subsequentes que requerem uma referência à janela do desktop.\
\
Parâmetros:\
Nenhum\
Retorno:\
Sucesso: Retorna o identificador da janela da área de trabalho.\
Falha: Retorna 0 e exibe uma mensagem de erro se a chamada à função falhar.\
Fluxo de Execução:\
Chamada à API GetDesktopWindow:\
\
A função faz a chamada à API do Windows GetDesktopWindow usando DllCall, solicitando o identificador da janela da área de trabalho.\
Verificação de Sucesso:\
\
Verifica se a chamada foi bem-sucedida. Se o identificador retornado for inválido (0), a função exibe uma mensagem de erro e retorna 0.\
Retorno do Identificador:\
\
Se a chamada for bem-sucedida, a função retorna o identificador da janela da área de trabalho.\
Mensagens de Erro:\
"Erro: Falha ao obter o identificador da janela da área de trabalho.":\
Exibida se a função falhar ao obter o identificador da janela da área de trabalho. A função retorna 0 nesse caso.
 */
GetDesktopWindow() {
    ; Função: GetDesktopWindow
    ; Descrição: Obtém o identificador (handle) da janela da área de trabalho (desktop).
    ; Retorno: Retorna o identificador da janela da área de trabalho ou 0 em caso de falha.

    hWnd :=
    DllCall(
        "GetDesktopWindow",
        "Ptr"
    )
    
    ; Verificação se a chamada foi bem-sucedida
    if !hWnd {
        MsgBox("Erro: Falha ao obter o identificador da janela da área de trabalho.")
        return 0  ; Retorna 0 em caso de falha
    }
    
    return hWnd
}

/**
Função: GetWindowDC\
Descrição:\
A função GetWindowDC obtém o contexto de dispositivo (Device Context - DC) de uma janela especificada. O DC de uma janela permite que você desenhe gráficos e manipule a aparência da janela.\
\
Parâmetros:\
Win: Handle da janela da qual deseja obter o contexto de dispositivo. Esse valor deve ser do tipo Ptr.\
Retorno:\
HDC: O contexto de dispositivo da janela especificada. Este é um handle do contexto de dispositivo, que pode ser usado em operações gráficas. Se a função falhar, o valor retornado será NULL.\
Exemplo de Uso:\
autohotkey\
Copiar código\
Win := GetDesktopWindow()  ; Obtém o handle da janela da área de trabalho.\
HDC := GetWindowDC(Win)    ; Obtém o contexto de dispositivo da janela da área de trabalho.\
Notas:\
Após terminar de usar o DC, você deve liberá-lo usando a função ReleaseDC para evitar vazamentos de recursos.\
Implementação:\
autohotkey
Copiar código
*/
GetWindowDC(Win) {
    HDC :=
    DllCall(
        "GetWindowDC",
        "Ptr", Win,
        "Ptr"
    )
    return HDC
}

/**
Função: CreateCompatibleDC\
Descrição:\
A função CreateCompatibleDC cria um contexto de dispositivo (DC) de memória que é compatível com o contexto de dispositivo especificado. Este DC de memória pode ser usado para criar bitmaps em memória que podem ser manipulados antes de serem exibidos.\
\
Parâmetros:\
Nenhum parâmetro explícito: O DC de memória criado é compatível com o DC atualmente selecionado no dispositivo de saída padrão.\
Retorno:\
MemDC: Um handle para o contexto de dispositivo de memória compatível. Se a função falhar, o valor retornado será NULL.\
Exemplo de Uso:\
autohotkey\
Copiar código\
MemDC := CreateCompatibleDC()\
Notas:\
O DC de memória criado não contém um bitmap até que um seja selecionado usando a função SelectObject.\
Implementação:\
autohotkey\
Copiar código
*/
CreateCompatibleDC( Win, HDC ) {
    MemDC :=
    DllCall(
        "CreateCompatibleDC",
        "Ptr", HDC,
        "Ptr"
    )

    if ( !MemDC ) {
        ReleaseDC( Win, HDC )
        MsgBox("Erro ao criar DC compatível.")
        return 0
    }
    return MemDC
}
/**
Função: CreateDIBSection\
Descrição:\
A função CreateDIBSection cria um bitmap independente de dispositivo (DIB) que permite acesso direto aos bits da imagem, facilitando operações de manipulação de pixel.\
\
Parâmetros:\
HDC: Handle do contexto de dispositivo (opcional).\
BMI: Ponteiro para uma estrutura BITMAPINFO que define o formato do bitmap.\
Usage: Especifica como a informação de cores é usada. Normalmente, DIB_RGB_COLORS.\
Bits: Ponteiro que receberá o endereço de memória onde os bits do bitmap são armazenados.\
Section: Handle de uma seção de memória (opcional).\
Offset: Offset do início da seção de memória (geralmente 0).\
Retorno:\
Bitmap: Handle para o DIB criado. Se a função falhar, o valor retornado será NULL.\
Exemplo de Uso:\
autohotkey\
Copiar código\
Bitmap := CreateDIBSection(HDC, BMI, DIB_RGB_COLORS, Bits, 0, 0)\
Implementação:\
autohotkey\
Copiar código
*/
CreateDIBSection(HDC, BMI, &Bits, Usage := 0, Section := 0, Offset := 0) {
    Bitmap :=
    DllCall(
        "CreateDIBSection",
        "Ptr", HDC,
        "Ptr", BMI,
        "UInt", Usage,
        "PtrP", Bits,
        "Ptr", Section,
        "UInt", Offset,
        "Ptr"
    )
    return Bitmap
}
/**
Função: SelectObject\
Descrição:\
A função SelectObject seleciona um objeto gráfico em um contexto de dispositivo (DC). O objeto pode ser um bitmap, uma caneta, uma fonte, ou uma paleta de cores.\
\
Parâmetros:\
HDC: Handle do contexto de dispositivo onde o objeto será selecionado.\
Obj: Handle do objeto a ser selecionado no contexto de dispositivo.\
Retorno:\
PrevObj: Handle para o objeto anteriormente selecionado no DC. Se a função falhar, o valor retornado será NULL.\
Exemplo de Uso:\
autohotkey\
Copiar código\
PrevObj := SelectObject(MemDC, Bitmap)\
Implementação:\
autohotkey\
Copiar código
*/
SelectObject(HDC, Obj) {
    PrevObj :=
    DllCall(
        "SelectObject",
        "Ptr", HDC,
        "Ptr", Obj,
        "Ptr"
    )
    return PrevObj
}
/**
Função: BitBlt\
Descrição:\
A função BitBlt realiza uma cópia de uma área de bits de um contexto de dispositivo (DC) de origem para um DC de destino, permitindo operações de transferência de imagem.\
\
Parâmetros:\
HDC: Handle do contexto de dispositivo de destino.\
x: Coordenada x do canto superior esquerdo da área de destino.\
y: Coordenada y do canto superior esquerdo da área de destino.\
Width: Largura da área a ser copiada.\
Height: Altura da área a ser copiada.\
SrcDC: Handle do contexto de dispositivo de origem.\
SrcX: Coordenada x do canto superior esquerdo da área de origem.\
SrcY: Coordenada y do canto superior esquerdo da área de origem.\
Rop: Código da operação raster que define como as cores de origem e destino são combinadas.\
Retorno:\
Success: Um valor booleano indicando sucesso (True) ou falha (False).\
Exemplo de Uso:\
autohotkey\
Copiar código\
Success := BitBlt(HDC, 0, 0, 100, 100, MemDC, 0, 0, SRCCOPY)\
Implementação:\
autohotkey\
Copiar código
*/
BitBlt(HDC, x, y, Width, Height, SrcDC, SrcX, SrcY ) {
    static Rop := 0x00CC0020 | 0x40000000
    Success :=
    DllCall(
        "BitBlt",
        "Ptr", HDC,
        "Int", x,
        "Int", y,
        "Int", Width,
        "Int", Height,
        "Ptr", SrcDC,
        "Int", SrcX,
        "Int", SrcY,
        "UInt", Rop,
        "Int"
    )
    return Success
}
/**
Função: RtlMoveMemory\
Descrição:\
A função RtlMoveMemory copia um bloco de memória de uma localização para outra. É similar à função memcpy em C.\
\
Parâmetros:\
Dest: Ponteiro para o buffer de destino.\
Src: Ponteiro para o buffer de origem.\
Size: O número de bytes a serem copiados.\
Retorno:\
Nenhum retorno: A função não retorna valor, pois a cópia é feita diretamente na memória.\
Exemplo de Uso:\
autohotkey\
Copiar código\
RtlMoveMemory(Dest, Src, 1024)\
Implementação:\
autohotkey\
Copiar código
*/
RtlMoveMemory( &Dest, &Src, Size) {
    bool :=
    DllCall(
        "RtlMoveMemory",
        "Ptr", Dest,
        "Ptr", Src,
        "UInt", Size,
        "Int"
    )
    return bool
}
/**
Função: DeleteObject\
Descrição:\
A função DeleteObject deleta um objeto gráfico, como um bitmap, uma caneta, ou uma fonte, liberando a memória associada a ele.\
\
Parâmetros:\
Obj: Handle do objeto gráfico a ser deletado.\
Retorno:\
Success: Um valor booleano indicando sucesso (True) ou falha (False).\
Exemplo de Uso:\
autohotkey\
Copiar código\
Success := DeleteObject(Bitmap)\
Implementação:\
autohotkey\
Copiar código
*/
DeleteObject(Obj) {
    Success :=
    DllCall(
        "DeleteObject",
        "Ptr", Obj,
        "Int"
    )
    return Success
}
/**
Função: DeleteDC\
Descrição:\
A função DeleteDC deleta um contexto de dispositivo (DC) de memória, liberando os recursos alocados para ele.\
\
Parâmetros:\
HDC: Handle do contexto de dispositivo a ser deletado.\
Retorno:\
Success: Um valor booleano indicando sucesso (True) ou falha (False).\
Exemplo de Uso:\
autohotkey\
Copiar código\
Success := DeleteDC(MemDC)\
Implementação:\
autohotkey\
Copiar código
*/
DeleteDC(HDC) {
    Success :=
    DllCall(
        "DeleteDC",
        "Ptr", HDC,
        "Int"
    )
    return Success
}
/**
Função: ReleaseDC\
Descrição:\
A função ReleaseDC libera o contexto de dispositivo (DC) associado a uma janela, que foi obtido anteriormente com GetWindowDC ou GetDC.\
\
Parâmetros:\
Win: Handle da janela associada ao DC.\
HDC: Handle do contexto de dispositivo a ser liberado.\
Retorno:\
Success: Um valor booleano indicando sucesso (True) ou falha (False).\
Exemplo de Uso:\
autohotkey\
Copiar código\
Success := ReleaseDC(Win, HDC)\
Implementação:\
autohotkey\
Copiar código
*/
ReleaseDC(Win, HDC) {
    Success :=
    DllCall(
        "ReleaseDC",
        "Ptr", Win,
        "Ptr", HDC,
        "Int"
    )
    return Success
}

/**Explicação da Função:
Buffer(40, 0):\
\
Cria um espaço na memória de 40 bytes, preenchido inicialmente com zeros. Este espaço será usado para armazenar informações sobre o bitmap, como largura, altura e profundidade de cor.\
NumPut:\
\
NumPut é uma função usada para colocar valores específicos em posições específicas dentro do buffer infoBitmap.\
NumPut("UInt", 40, infoBitmap, 0): Coloca o valor 40 (tamanho do cabeçalho BITMAPINFOHEADER) na posição inicial do buffer.\
NumPut("Int", largura, infoBitmap, 4): Coloca a largura do bitmap na posição 4 do buffer.\
NumPut("Int", -altura, infoBitmap, 8): Coloca a altura do bitmap na posição 8 do buffer. O valor negativo indica que o bitmap é armazenado de cima para baixo (top-down).\
NumPut("Short", 1, infoBitmap, 12): Define o número de planos de cor como 1 (valor fixo para bitmaps).\
NumPut("Short", bitsPorPixel, infoBitmap, 14): Define a profundidade de cor (bits por pixel), que pode variar de 1 a 32 bits.\
Retorno:\
\
A função retorna o buffer infoBitmap, que contém todas as informações necessárias para definir as propriedades de um bitmap.\
Documentação da Função CreateBitmapInfo\
Função: CreateBitmapInfo\
Descrição:\
A função CreateBitmapInfo cria e preenche uma estrutura de informações sobre um bitmap, necessária para definir suas propriedades, como largura, altura e profundidade de cor (bits por pixel). Essa estrutura é usada em operações de captura de tela e criação de bitmaps.\
\
Parâmetros:\
largura (Integer):\
\
A largura da área que será capturada na tela.\
altura (Integer):\
\
A altura da área que será capturada na tela.\
bitsPorPixel (Integer, opcional):\
\
A quantidade de bits por pixel para a imagem capturada. O valor padrão é 32 bits.\
Retorno:\
Sucesso: Retorna um buffer contendo a estrutura BITMAPINFO configurada, que pode ser usada em operações de manipulação de bitmaps.\
Exemplo de Uso:\
ahk\
Copiar código\
largura := 800\
altura := 600\
bitsPorPixel := 32\
\
infoBitmap := CreateBitmapInfo(largura, altura, bitsPorPixel)
*/
CreateBitmapInfo(largura, altura, bitsPorPixel := 32) {
; Função: CreateBitmapInfo
; Descrição: Cria um buffer que contém as informações necessárias sobre o bitmap para operações de captura de tela.
; Parâmetros:
;   largura  - A largura da área de captura.
;   altura   - A altura da área de captura.
;   bitsPorPixel - O número de bits por pixel (bpp) para a imagem capturada. (Padrão é 32)
; Retorno:
;   Retorna um buffer contendo a estrutura BITMAPINFO configurada.

    ; Cria um buffer para a estrutura BITMAPINFO (40 bytes de tamanho)
    infoBitmap := Buffer(40, 0)
    
    ; Preenche os campos da estrutura BITMAPINFO
    NumPut("UInt", 40, infoBitmap, 0)  ; Define o tamanho do cabeçalho BITMAPINFOHEADER como 40 bytes
    NumPut("Int", largura, infoBitmap, 4)  ; Define a largura do bitmap
    NumPut("Int", -altura, infoBitmap, 8)  ; Define a altura do bitmap (negativa para indicar top-down)
    NumPut("Short", 1, infoBitmap, 12)  ; Define o número de planos de cor (sempre 1)
    NumPut("Short", bitsPorPixel, infoBitmap, 14)  ; Define o número de bits por pixel (1, 4, 8, 16, 24, 32)
    
    return infoBitmap
}
