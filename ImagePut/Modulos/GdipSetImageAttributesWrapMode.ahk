/**
 * Define o modo de empacotamento de imagem para um objeto de atributos de imagem.
 *
 * @param {ptr} ImageAttr - Um ponteiro para o objeto de atributos de imagem.
 * @param {int} wrapMode - O modo de empacotamento a ser definido.
 * @param {uint} argb - A cor de empacotamento.
 * @param {int} clamp - Valor de clamp.
 * @returns {int} - O código de resultado da operação.
 */
GdipSetImageAttributesWrapMode(ImageAttr, wrapMode, argb := 0, clamp := 0) {
    result := DllCall("gdiplus\GdipSetImageAttributesWrapMode", "ptr", ImageAttr, "int", wrapMode, "uint", argb, "int", clamp)
    if (result != 0) {
        throw Error("Falha ao definir o modo de empacotamento de imagem. Código de erro: " . result)
    }
    return result
}
