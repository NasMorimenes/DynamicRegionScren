/**
 * Function: BitBlt
 * ----------------
 * Copia um bloco de pixels de um contexto de dispositivo (DC) de origem para um DC de destino.
 *
 * * Parameters:
 * @param hdcDest  O identificador do contexto de dispositivo de destino.
 * @param nXDest   A coordenada x da área superior esquerda do retângulo de destino. (opcional, padrão é 0).
 * @param nYDest   A coordenada y da área superior esquerda do retângulo de destino. (opcional, padrão é 0).
 * @param nWidth   A largura do bloco de pixels a ser transferido. (opcional, padrão é a largura da tela).
 * @param nHeight  A altura do bloco de pixels a ser transferido. (opcional, padrão é a altura da tela).
 * @param hdcSrc   O identificador do contexto de dispositivo de origem (opcional, padrão é obtido do bitmap)
 * @param nXSrc    A coordenada X de origem (opcional, padrão é 0).
 * @param nYSrc    A coordenada Y de origem (opcional, padrão é 0).
 * @param dwRop    O código de rasterização (opcional, padrão é 0x00CC0020).
 *             Os valores comuns são:
 *             - SRCCOPY (0x00CC0020): Copia os pixels da origem para o destino.
 *             - SRCPAINT (0x00EE0086): Combina os pixels da origem e do destino usando uma operação OR.
 *             - SRCAND (0x008800C6): Combina os pixels da origem e do destino usando uma operação AND.
 *             - SRCINVERT (0x00660046): Combina os pixels da origem e do destino usando uma operação XOR.
 *             - SRCERASE (0x00440328): Combina os pixels da origem invertida com os pixels do destino usando uma operação AND.
 *             - NOTSRCCOPY (0x00330008): Copia os pixels invertidos da origem para o destino.
 *             - NOTSRCERASE (0x001100A6): Combina os pixels invertidos da origem e do destino usando uma operação OR.
 *             - MERGECOPY (0x00C000CA): Combina os pixels da origem com uma máscara de cor usando uma operação AND.
 *             - MERGEPAINT (0x00BB0226): Combina os pixels invertidos da origem com os pixels do destino usando uma operação OR.
 *
 * Returns:
 *   bool - Retorna true se a operação foi bem-sucedida; caso contrário, false.
 */
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

/**
 * Function: BitBlt
 * ----------------
 * Copia um bloco de pixels de um contexto de dispositivo (DC) de origem para um DC de destino.
 *
 * * Parameters:
 * @param hdcDest  O identificador do contexto de dispositivo de destino.
 * @param nXDest   A coordenada x da área superior esquerda do retângulo de destino. (opcional, padrão é 0).
 * @param nYDest   A coordenada y da área superior esquerda do retângulo de destino. (opcional, padrão é 0).
 * @param nWidth   A largura do bloco de pixels a ser transferido. (opcional, padrão é a largura da tela).
 * @param nHeight  A altura do bloco de pixels a ser transferido. (opcional, padrão é a altura da tela).
 * @param hdcSrc   O identificador do contexto de dispositivo de origem (opcional, padrão é obtido do bitmap)
 * @param nXSrc    A coordenada X de origem (opcional, padrão é 0).
 * @param nYSrc    A coordenada Y de origem (opcional, padrão é 0).
 * @param dwRop    O código de rasterização (opcional, padrão é 0x00CC0020).
 */