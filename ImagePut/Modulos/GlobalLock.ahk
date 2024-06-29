/**
 * Bloqueia um bloco de memória global.
 *
 * @param {ptr} handle - Um ponteiro para o bloco de memória global a ser bloqueado.
 * @returns {ptr} - Um ponteiro para a memória bloqueada.
 */
GlobalLock(handle) {
    ; Bloquear a memória global para obter um ponteiro para a memória.
    bin := 
    DllCall(
        "GlobalLock",
        "ptr", handle, ; Ponteiro para o bloco de memória global.
        "ptr" ; Retorna um ponteiro para a memória bloqueada.
    )
    return bin ; Retorna o ponteiro para a memória bloqueada.
}
