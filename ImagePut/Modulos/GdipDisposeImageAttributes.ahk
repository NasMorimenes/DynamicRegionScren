/**
 * Libera um objeto de atributos de imagem.
 *
 * @param {ptr} ImageAttr - Um ponteiro para o objeto de atributos de imagem.
 * @returns {int} - O código de resultado da operação.
 */
GdipDisposeImageAttributes(ImageAttr) {
    result := DllCall("gdiplus\GdipDisposeImageAttributes", "ptr", ImageAttr)
    if (result != 0) {
        throw Error("Falha ao liberar os atributos de imagem. Código de erro: " . result)
    }
    return result
}
