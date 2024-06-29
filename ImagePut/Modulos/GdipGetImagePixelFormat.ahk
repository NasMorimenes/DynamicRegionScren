/**
 * Obtém o formato de pixel de um bitmap.
 *
 * @param {ptr} pBitmap - Um ponteiro para o bitmap.
 * @returns {int} - O formato de pixel do bitmap.
 */
GdipGetImagePixelFormat(pBitmap) {
    format := 0
    ; Chama a função GdipGetImagePixelFormat da GDI+ para obter o formato de pixel do bitmap
    result := DllCall("gdiplus\GdipGetImagePixelFormat", "ptr", pBitmap, "int*", format)
    if (result != 0) {
        throw Error("Falha ao obter o formato de pixel do bitmap. Código de erro: " . result)
    }
    return format ; Retorna o formato de pixel do bitmap
}
