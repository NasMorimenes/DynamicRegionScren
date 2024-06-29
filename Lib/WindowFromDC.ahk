/*
 * Function: WindowFromDC
 * ----------------------
 * Obtém o identificador da janela a partir de um contexto de dispositivo (DC).
 *
 * Parameters:
 *   hdc - O identificador do contexto de dispositivo (DC).
 *
 * Returns:
 *   hwnd - O identificador da janela associada ao DC.
 */
WindowFromDC( hdc ) {
    hwnd :=
    DllCall(
        "gdi32\WindowFromDC",
        "Ptr", hdc,
        "Ptr"
    )
    return hwnd
}