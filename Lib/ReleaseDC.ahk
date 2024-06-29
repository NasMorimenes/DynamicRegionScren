/*
 * Function: ReleaseDC
 * -------------------
 * Libera o contexto de dispositivo (DC) de uma janela específica.
 *
 * Parameters:
 *   hwnd - O identificador da janela cuja DC deve ser liberada.
 *   hdc  - O identificador do contexto de dispositivo a ser liberado.
 *
 * Returns:
 *   int - Retorna 1 se a função for bem-sucedida; caso contrário, 0.
 *
 * Description:
 *   A função `ReleaseDC` libera o contexto de dispositivo (DC) obtido com `GetDC`
 *   para a janela especificada por `hwnd`. Esta função deve ser chamada para cada
 *   chamada bem-sucedida de `GetDC` para liberar o DC e evitar vazamentos de recursos.
 */
ReleaseDC( hwnd, hdc ) {
    bool :=
    DllCall(
        "user32.dll\ReleaseDC",
        "Ptr", hwnd,
        "Ptr", hdc,
        "Int"
    )
    return bool
}