/**
 * Libera um bitmap ou uma imagem.
 *
 * @param {ptr} image - Um ponteiro para o bitmap ou imagem.
 * @returns {int} - O código de resultado da operação.
 */
GdipDisposeImage(image) {
    result :=
    DllCall(
        "gdiplus\GdipDisposeImage",
        "ptr", image
    )
    
    if (result != 0) {
        throw Error("Falha ao liberar a imagem. Código de erro: " . result)
    }
    return result
}