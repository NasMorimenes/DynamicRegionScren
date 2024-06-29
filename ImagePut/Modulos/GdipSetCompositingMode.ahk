/**
 * Define o modo de composição para um contexto gráfico.
 *
 * @param {ptr} graphics - Um ponteiro para o contexto gráfico.
 * @param {int} mode - O modo de composição a ser definido.
 * @returns {int} - O código de resultado da operação.
 * @example 
 * -; Definir o modo de composição
GdipSetCompositingMode(pGraphics, 1) ; 1 = CompositingModeSourceCopy
 */
GdipSetCompositingMode(graphics, mode) {
    result := DllCall(
        "gdiplus\GdipSetCompositingMode",
        "ptr", graphics,
        "int", mode
    )
    if (result != 0) {
        throw Error("Falha ao definir o modo de composição. Código de erro: " . result)
    }
    return result
}