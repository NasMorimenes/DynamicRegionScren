;https://learn.microsoft.com/pt-br/windows/win32/winmsg/callwndproc
CallWndProc( nCode, wParam, lParam ) {
    /** nCode
     * -
     * Se nCode for HC_ACTION, o procedimento de gancho deverá processar a mensagem
     */
    if ( nCode = 0 ) {
        ;msgProcessing()
        return
    }
    /** nCode
     * -
     * Se nCode for menor que zero, o procedimento de gancho deverá passar a mensagem para
     * a função CallNextHookEx sem processamento adicional e deverá retornar o valor retornado
     * por CallNextHookEx.
     */
    else if ( nCode < 0 ) {

    }

}