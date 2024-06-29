#Include Unhook.ahk
UnhookAll( s, n ) {

    BoolKeybd := Unhook( hHookKeybd )
    BoolMouse := Unhook( hHookMouse )
    CallbackFree( andressK )
    CallbackFree( andressM )
    ;ExitApp()
}