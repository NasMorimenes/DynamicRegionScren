/**
 * Cria um stream na memória global.
 *
 * @param {ptr} handle - Um ponteiro para o bloco de memória global.
 * @param {ptr*} stream - Um ponteiro para o stream criado.
 * @returns {int} - O resultado HRESULT da operação.
 */
CreateStreamOnHGlobal( handle, stream := 0 ) {
    hresult :=
    DllCall(
        "ole32\CreateStreamOnHGlobal", 
        "ptr", handle, ; Ponteiro para o bloco de memória global.
        "int", True, ; Indica se o sistema deve liberar o bloco de memória quando o stream for liberado.
        "ptr*", &stream, ; Ponteiro para o stream criado.
        "hresult" ; Resultado da operação.
    )

    return hresult ; Retorna o HRESULT da operação.
}
