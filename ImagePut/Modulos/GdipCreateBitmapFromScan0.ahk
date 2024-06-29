/**
 * Cria um bitmap vazio com as dimensões e formato especificados.
 *
 * @param {int} width - A largura do bitmap a ser criado.
 * @param {int} height - A altura do bitmap a ser criado.
 * @param {int} pixelFormat - O formato de pixel do bitmap.
 * @param {ptr} scan0 - Um ponteiro para os dados de varredura da imagem (pode ser 0 para criar um bitmap vazio).
 * @param {int} stride - O comprimento de cada linha de varredura (scan line) em bytes (padrão é 0).
 * @returns {ptr} - Um ponteiro para o bitmap criado.
 */
GdipCreateBitmapFromScan0(width, height, pixelFormat, scan0 := 0, stride := 0) {
    pBitmap := 0
    ; Chama a função GdipCreateBitmapFromScan0 da GDI+ para criar um bitmap vazio
    result :=
    DllCall(
        "gdiplus\GdipCreateBitmapFromScan0",
        "int", width,
        "int", height,
        "int", stride,
        "int", pixelFormat,
        "ptr", scan0,
        "ptr*", pBitmap
    )
    
    if (result != 0) {
        throw Error("Falha ao criar bitmap. Código de erro: " . result)
    }
    return pBitmap ; Retorna o ponteiro para o bitmap criado
}
