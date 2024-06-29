/**
 * Desbloqueia um bloco de memória global.
 *
 * @param {ptr} handle - Um ponteiro para o bloco de memória global a ser desbloqueado.
 */
GlobalUnlock(handle) {
    ; Desbloquear a memória global.
    DllCall(
        "GlobalUnlock",
        "ptr", handle ; Ponteiro para o bloco de memória global.
    )
}
