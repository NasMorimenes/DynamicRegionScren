/**
 * Cria um bitmap a partir de um stream usando ICM (Image Color Management).
 *
 * @param {ptr} stream - Um ponteiro para o stream de entrada contendo a imagem.
 * @returns {ptr} - Um ponteiro para o bitmap criado.
 */
CreateBitmapFromStreamICM( stream, pBitmap := 0 ) {
    ; Inicializar o ponteiro do bitmap como 0
    
    ; Chamar a função GdipCreateBitmapFromStreamICM da GDI+ para criar um bitmap a partir do stream
    result :=
    DllCall(
        "gdiplus\GdipCreateBitmapFromStreamICM", ; Nome da função na DLL GDI+
        "ptr", stream, ; Ponteiro para o stream de entrada
        "ptr*", &pBitmap ; Ponteiro para o ponteiro do bitmap que será criado
    )

    ; Verificar o resultado da chamada da função
    if (result != 0) {
        ; Se a função não retornar 0, houve um erro
        throw Error("Falha ao criar bitmap a partir do stream. Código de erro: " . result)
    }

    return pBitmap ; Retorna o ponteiro para o bitmap criado
}
