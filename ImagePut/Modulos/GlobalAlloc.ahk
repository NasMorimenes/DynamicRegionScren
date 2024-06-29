/**
 * Aloca memória global.
 *
 * @param {uptr} size - O tamanho em bytes da memória a ser alocada.
 * @returns {ptr} - Um ponteiro para a memória alocada.
 */
GlobalAlloc( size ) {
    ; Alocar memória global com as bandeiras especificadas.
    handle := DllCall(
        "GlobalAlloc",
        "UInt", 0x2, ; GMEM_MOVEABLE: A memória pode ser movida.
        "UPtr", size, ; Tamanho da memória a ser alocada.
        "Ptr"
    )
    return handle ; Retorna o ponteiro para a memória alocada.
}