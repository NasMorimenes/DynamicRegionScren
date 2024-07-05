#Include CallNextHookEx.ahk

Teste( nCode, wParam, lParam ) {

    Critical

    static lastMouseMove := A_TickCount

    if ( !nCode ) {
        ;ListVars()
        ToolTip( lParam )
        
    }
    LRESULT := CallNextHookEx( nCode, wParam, lParam )

    return LRESULT
}