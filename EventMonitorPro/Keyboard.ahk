#Include CallNextHookEx.ahk
#Include LogDebug.ahk
#Include GetKeyDetails.ahk

Keyboard( nCode, wParam, lParam ) {
    Critical
    static lastKeyPress := A_TickCount

    if ( !nCode && wParam == 256 ) { ; WM_KEYDOWN
        diffKeyPress := A_TickCount - lastKeyPress
        lastKeyPress := A_TickCount

        ; Capture Data Mensage

        
        if ( DEBUG_OUTPUT ) {

            info :=
            (
                "Key Pressed: " GetKeyDetails( lParam )
                " Last Key Press: " diffKeyPress
            )

            LogDebug( info )
        }
    }

    Resut := CallNextHookEx( nCode, wParam, lParam )

    return Resut
}