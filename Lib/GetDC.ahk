/*
 * Function: GetDC
 * ---------------
 * Obtém o contexto de dispositivo (DC) para a janela especificada.
 *
 * Parameters:
 *   hwnd - O identificador da janela cuja DC deve ser obtida.
 *
 * Returns:
 *   hdc - O identificador do contexto de dispositivo da janela especificada. 
 *         Retorna NULL se a função falhar.
 *
 * Description:
 *   A função `GetDC` obtém o contexto de dispositivo (DC) para a janela especificada
 *   por `hwnd`. O contexto de dispositivo é um objeto que define um conjunto de atributos
 *   gráficos e os modos de saída gráfica para o dispositivo de exibição. 
 *   Esta função é usada para realizar operações de desenho em uma janela específica.
 */
GetDC( hwnd ) {
    hdc :=
    DllCall(
        "user32.dll\GetDC",
        "Ptr", hwnd,
        "Ptr"
    )
    return hdc
}