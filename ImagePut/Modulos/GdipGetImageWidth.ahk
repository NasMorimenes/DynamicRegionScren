/**
 * Obtém a largura de um bitmap.
 *
 * @param {ptr} pBitmap - Um ponteiro para o bitmap.
 * @returns {uint} - A largura do bitmap.
 */
GdipGetImageWidth(pBitmap) {
    width := 0
    ; Chama a função GdipGetImageWidth da GDI+ para obter a largura do bitmap
    result := DllCall("gdiplus\GdipGetImageWidth", "ptr", pBitmap, "uint*", width)
    if (result != 0) {
        throw Error("Falha ao obter a largura do bitmap. Código de erro: " . result)
    }
    return width ; Retorna a largura do bitmap
}