/**
 * Define o modo de deslocamento de pixel para um contexto gráfico.
 *
 * @param {ptr} graphics - Um ponteiro para o contexto gráfico.
 * @param {int} mode - O modo de deslocamento de pixel a ser definido.
 * @returns {int} - O código de resultado da operação.
 * @example 
 * -Definir o modo de deslocamento de pixel
    GdipSetPixelOffsetMode(pGraphics, 2) ; 2 = PixelOffsetModeHalf
 */
GdipSetPixelOffsetMode( graphics, mode ) {
    result :=
    DllCall(
        "gdiplus\GdipSetPixelOffsetMode",
        "ptr", graphics,
        "int", mode
    )
    if (result != 0) {
        throw Error("Falha ao definir o modo de deslocamento de pixel. Código de erro: " . result)
    }
    return result
}