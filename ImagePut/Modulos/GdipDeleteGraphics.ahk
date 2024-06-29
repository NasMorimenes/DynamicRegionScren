/**
 * Exclui um contexto gráfico.
 *
 * @param {ptr} graphics - Um ponteiro para o contexto gráfico.
 * @returns {int} - O código de resultado da operação.
 */
GdipDeleteGraphics(graphics) {
    result := DllCall("gdiplus\GdipDeleteGraphics", "ptr", graphics)
    if (result != 0) {
        throw Error("Falha ao excluir o contexto gráfico. Código de erro: " . result)
    }
    return result
}