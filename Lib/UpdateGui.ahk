#Include GDIP_V2.ahk
#Include BitBlt.ahk

/**
 * Function: UpdateGUI
 * -------------------
 * Atualiza a interface gráfica copiando o conteúdo do bitmap (armazenado em hdc)
 * para o contexto de dispositivo da janela (hdcDest).
 *
 * Parameters:
 * @param hdcDest  O identificador do contexto de dispositivo de destino.
 * @param hbm      O identificador do bitmap.
 * @param hwnd     O identificador da janela GUI (opcional, padrão é a janela ativa).
 * @param hdcSrc   O identificador do contexto de dispositivo de origem (opcional, padrão é obtido do bitmap).
 * @param nXDest   A coordenada X de destino (opcional, padrão é 0).
 * @param nYDest   A coordenada Y de destino (opcional, padrão é 0).
 * @param nWidth   A largura da área a ser copiada (opcional, padrão é a largura da tela).
 * @param nHeight  A altura da área a ser copiada (opcional, padrão é a altura da tela).
 * @param nXSrc    A coordenada X de origem (opcional, padrão é 0).
 * @param nYSrc    A coordenada Y de origem (opcional, padrão é 0).
 * @param dwRop    O código de rasterização (opcional, padrão é 0x00CC0020).
 *
 * Returns:
 *   None
 *
 * Description:
 *   A função `UpdateGUI` é responsável por atualizar a janela GUI com o conteúdo
 *   atual do bitmap. Ela usa a função `BitBlt` para transferir os pixels do 
 *   contexto de dispositivo do bitmap para o contexto de dispositivo da janela.
 *   Isso garante que os desenhos realizados no bitmap sejam refletidos na janela GUI.
 *   A função é chamada frequentemente, especialmente após eventos de desenho e
 *   redimensionamento, para garantir que a janela esteja sempre atualizada.
 */
UpdateGUI(
    hdcDest, hbm, hwnd := 0, hdcSrc := 0,
    nXDest := 0, nYDest := 0,
    nWidth := A_ScreenWidth, nHeight := A_ScreenHeight,
    nXSrc := 0, nYSrc := 0,
    dwRop := 0x00CC0020
) {
    if !hwnd
        hwnd := WinExist()               ; Obtém o identificador da janela GUI ativa se não fornecido.
    if !hdcSrc
        hdcSrc := CreateCompatibleDC(hdcDest) ; Cria um contexto de dispositivo compatível se não fornecido.

    SelectObject( hdcSrc, hbm )             ; Seleciona o bitmap no contexto de dispositivo de origem.

    ; Copia os pixels do DC de origem (hdcSrc) para o DC de destino (hdcDest).
    trans :=
    BitBlt( hdcDest,nXDest, nYDest, nWidth, nHeight, hdcSrc, nXSrc, nYSrc, dwRop )

    DeleteDC(hdcSrc)                     ; Deleta o contexto de dispositivo de origem se foi criado.
}


/*
 * Function: BitBlt
 * ----------------
 * Copia um bloco de pixels de um contexto de dispositivo (DC) de origem para um DC de destino.
 *
 * Parameters:
 *   @hdcDest - O identificador do contexto de dispositivo de destino.
 *   nXDest  - A coordenada x, em unidades lógicas, da área superior esquerda do retângulo de destino.
 *   nYDest  - A coordenada y, em unidades lógicas, da área superior esquerda do retângulo de destino.
 *   nWidth  - A largura, em unidades lógicas, do bloco de pixels a ser transferido.
 *   nHeight - A altura, em unidades lógicas, do bloco de pixels a ser transferido.
 *   hdcSrc  - O identificador do contexto de dispositivo de origem.
 *   nXSrc   - A coordenada x, em unidades lógicas, da área superior esquerda do bloco de pixels de origem.
 *   nYSrc   - A coordenada y, em unidades lógicas, da área superior esquerda do bloco de pixels de origem.
 *   dwRop   - O código de operação raster que define como os pixels da origem são combinados com os pixels de destino.
 *
 * Returns:
 *   bool - Retorna true se a operação foi bem-sucedida; caso contrário, false.
 *
BitBlt( hdcDest, nXDest, nYDest, nWidth, nHeight, hdcSrc, nXSrc, nYSrc, dwRop ) {
    bool :=
    DllCall(
        "gdi32\BitBlt",
        "ptr", hdcDest,
        "int", nXDest,
        "int", nYDest,
        "int", nWidth,
        "int", nHeight,
        "ptr", hdcSrc,
        "int", nXSrc,
        "int", nYSrc,
        "uint", dwRop,
        "Int"
    )

    return bool
}

/*
 * Function: GetDC
 * ---------------
 * Obtém o contexto de dispositivo (DC) para a janela especificada.
 *
 * Parameters:
 *   hwnd - O identificador da janela cuja DC deve ser obtida.
 *
 * Returns:
 *   hdc - O identificador do contexto de dispositivo da janela especificada. 
 *         Retorna NULL se a função falhar.
 *
 * Description:
 *   A função `GetDC` obtém o contexto de dispositivo (DC) para a janela especificada
 *   por `hwnd`. O contexto de dispositivo é um objeto que define um conjunto de atributos
 *   gráficos e os modos de saída gráfica para o dispositivo de exibição. 
 *   Esta função é usada para realizar operações de desenho em uma janela específica.
 *
GetDC( hwnd ) {
    hdc :=
    DllCall(
        "user32.dll\GetDC",
        "Ptr", hwnd,
        "Ptr"
    )
    return hdc
}

/*
 * Function: ReleaseDC
 * -------------------
 * Libera o contexto de dispositivo (DC) de uma janela específica.
 *
 * Parameters:
 *   hwnd - O identificador da janela cuja DC deve ser liberada.
 *   hdc  - O identificador do contexto de dispositivo a ser liberado.
 *
 * Returns:
 *   int - Retorna 1 se a função for bem-sucedida; caso contrário, 0.
 *
 * Description:
 *   A função `ReleaseDC` libera o contexto de dispositivo (DC) obtido com `GetDC`
 *   para a janela especificada por `hwnd`. Esta função deve ser chamada para cada
 *   chamada bem-sucedida de `GetDC` para liberar o DC e evitar vazamentos de recursos.
 *
ReleaseDC( hwnd, hdc ) {
    bool :=
    DllCall(
        "user32.dll\ReleaseDC",
        "ptr", hwnd,
        "ptr", hdc, 
        "int"
    )
    return bool
}




/* ChatGPT- BitBlt
 *
 * Explicação da Documentação
 * Função: BitBlt
 * Descrição:
 * 
 * A função BitBlt copia um bloco de pixels de um contexto de dispositivo (DC) de origem para um DC de destino. É comumente usada para operações de desenho e atualização de janelas em interfaces gráficas.
 * Parâmetros:
 * 
 * hdcDest: O identificador do contexto de dispositivo de destino. Representa a área onde os pixels serão copiados.
 * nXDest: A coordenada x da área superior esquerda do retângulo de destino.
 * nYDest: A coordenada y da área superior esquerda do retângulo de destino.
 * nWidth: A largura do bloco de pixels a ser transferido.
 * nHeight: A altura do bloco de pixels a ser transferido.
 * hdcSrc: O identificador do contexto de dispositivo de origem. Representa a área de onde os pixels serão copiados.
 * nXSrc: A coordenada x da área superior esquerda do bloco de pixels de origem.
 * nYSrc: A coordenada y da área superior esquerda do bloco de pixels de origem.
 * dwRop: O código de operação raster. Define como os pixels da origem são combinados com os pixels de destino. O valor comum é SRCCOPY (0x00CC0020), que simplesmente copia os pixels.
 * Retorno:
 * 
 * bool: Retorna true se a operação foi bem-sucedida; caso contrário, retorna false.
 * Uso da Função BitBlt no Script
 * No script, a função BitBlt é usada dentro da função UpdateGUI para copiar o conteúdo do bitmap (armazenado em hdc) para o contexto de dispositivo da janela (armazenado em hdc2). Isso atualiza a interface gráfica com os desenhos feitos pelo usuário.
 */


/* ChatGPT  - UpdateGUI
 * Função: UpdateGUI
 * 
 * Descrição:
 * A função UpdateGUI atualiza a janela GUI copiando o conteúdo do bitmap (armazenado no contexto de dispositivo hdc) para o contexto de dispositivo da janela (armazenado em hdc2). Isso garante que os desenhos realizados no bitmap sejam refletidos na janela GUI.
 * 
 * Parâmetros:
 * Nenhum.
 * 
 * Retorno:
 * Nenhum.
 * 
 * Detalhes de Implementação:
 * 
 * global hdc, hbm: Declaração das variáveis globais hdc (contexto de dispositivo do bitmap) e hbm (bitmap).
 * hwnd := WinExist(): Obtém o identificador da janela GUI ativa.
 * hdc2 := GetDC(hwnd): Obtém o contexto de dispositivo (DC) da janela.
 * BitBlt(hdc2, 0, 0, A_ScreenWidth, A_ScreenHeight, hdc, 0, 0, 0x00CC0020): Copia os pixels do contexto de dispositivo do bitmap (hdc) para o contexto de dispositivo da janela (hdc2). O código de operação raster 0x00CC0020 (SRCCOPY) indica que os pixels da origem devem ser copiados diretamente para o destino.
 * ReleaseDC(hwnd, hdc2): Libera o contexto de dispositivo da janela.
 * Conclusão
 * A função UpdateGUI é crucial para garantir que a interface gráfica da janela GUI seja atualizada corretamente com os desenhos realizados pelo usuário. A documentação detalhada no estilo da linguagem C fornece uma visão clara de seu propósito, parâmetros, retorno e detalhes de implementação.
 */
