/**
 * Obtém a altura de um bitmap.
 *
 * @param {ptr} pBitmap - Um ponteiro para o bitmap.
 * @returns {uint} - A altura do bitmap.
 */
GdipGetImageHeight( pBitmap ) {
    height := 0
    ; Chama a função GdipGetImageHeight da GDI+ para obter a altura do bitmap
    result := DllCall("gdiplus\GdipGetImageHeight", "ptr", pBitmap, "uint*", height)
    if (result != 0) {
        throw Error("Falha ao obter a altura do bitmap. Código de erro: " . result)
    }
    return height ; Retorna a altura do bitmap
}