/**
 * Obtém o contexto gráfico de um bitmap.
 *
 * @param {ptr} pBitmap - Um ponteiro para o bitmap.
 * @returns {ptr} - Um ponteiro para o contexto gráfico do bitmap.
 */
GdipGetImageGraphicsContext(pBitmap) {
    pGraphics := 0
    ; Chama a função GdipGetImageGraphicsContext da GDI+ para obter o contexto gráfico do bitmap
    result := DllCall("gdiplus\GdipGetImageGraphicsContext", "ptr", pBitmap, "ptr*", pGraphics)
    if (result != 0) {
        throw Error("Falha ao obter contexto gráfico do bitmap. Código de erro: " . result)
    }
    return pGraphics ; Retorna o ponteiro para o contexto gráfico do bitmap
}
