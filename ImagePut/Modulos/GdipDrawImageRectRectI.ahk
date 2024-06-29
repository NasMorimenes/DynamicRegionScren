/**
 * Desenha uma imagem redimensionada com um retângulo de origem e destino especificados.
 *
 * @param {ptr} graphics - Um ponteiro para o contexto gráfico.
 * @param {ptr} image - Um ponteiro para a imagem a ser desenhada.
 * @param {int} dstX - Coordenada X do retângulo de destino.
 * @param {int} dstY - Coordenada Y do retângulo de destino.
 * @param {int} dstWidth - Largura do retângulo de destino.
 * @param {int} dstHeight - Altura do retângulo de destino.
 * @param {int} srcX - Coordenada X do retângulo de origem.
 * @param {int} srcY - Coordenada Y do retângulo de origem.
 * @param {int} srcWidth - Largura do retângulo de origem.
 * @param {int} srcHeight - Altura do retângulo de origem.
 * @param {int} srcUnit - Unidade do retângulo de origem.
 * @param {ptr} ImageAttr - Um ponteiro para o objeto de atributos de imagem.
 * @param {ptr} callback - Ponteiro para um callback (pode ser 0).
 * @param {ptr} callbackData - Ponteiro para dados do callback (pode ser 0).
 * @returns {int} - O código de resultado da operação.
 */
GdipDrawImageRectRectI(graphics, image, dstX, dstY, dstWidth, dstHeight, srcX, srcY, srcWidth, srcHeight, srcUnit, ImageAttr, callback := 0, callbackData := 0) {
    result := DllCall("gdiplus\GdipDrawImageRectRectI"
                      , "ptr", graphics
                      , "ptr", image
                      , "int", dstX, "int", dstY, "int", dstWidth, "int", dstHeight
                      , "int", srcX, "int", srcY, "int", srcWidth, "int", srcHeight
                      , "int", srcUnit
                      , "ptr", ImageAttr
                      , "ptr", callback
                      , "ptr", callbackData)
    if (result != 0) {
        throw Error("Falha ao desenhar a imagem. Código de erro: " . result)
    }
    return result
}