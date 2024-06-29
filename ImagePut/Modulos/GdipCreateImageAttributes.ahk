/**
 * Cria um objeto de atributos de imagem.
 *
 * @returns {ptr} - Um ponteiro para o objeto de atributos de imagem criado.
 */
GdipCreateImageAttributes() {
    ImageAttr := 0
    result := DllCall("gdiplus\GdipCreateImageAttributes", "ptr*", ImageAttr)
    if (result != 0) {
        throw Error("Falha ao criar atributos de imagem. Código de erro: " . result)
    }
    return ImageAttr
}
