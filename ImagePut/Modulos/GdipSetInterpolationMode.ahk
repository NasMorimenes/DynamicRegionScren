/**
 * Define o modo de interpolação para um contexto gráfico.
 *
 * @param {ptr} graphics - Um ponteiro para o contexto gráfico.
 * @param {int} mode - O modo de interpolação a ser definido.
 * @returns {int} - O código de resultado da operação.
 * @example 1: ; Definir o modo de interpolação
GdipSetInterpolationMode(pGraphics, 7) ; 7 = InterpolationModeHighQualityBicubic
 */
GdipSetInterpolationMode(graphics, mode) {

    result :=
    DllCall(
        "gdiplus\GdipSetInterpolationMode",
        "ptr", graphics,
        "int", mode
    )
    if (result != 0) {
        throw Error("Falha ao definir o modo de interpolação. Código de erro: " . result)
    }
    return result
}