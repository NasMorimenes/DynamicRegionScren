InstallHookMK(  pfnM := "", pfnK := "", flag := 0 ) {

    global m_pFn := pfnM
    global k_pFn := pfnK
    global f_flag := flag

    if ( Type( pfnM ) == "Func" ) {
        WH_MOUSE_LL := 14
        andressM := CallbackCreate( PFNs )
        hHookMouse := SetHook( WH_MOUSE_LL, andressM )
    }

    if ( Type( pfnK ) == "Func" ) {
        WH_KEYBOARD_LL := 13
        andressK := CallbackCreate( pfnK )
        hHookKeybd := SetHook( WH_KEYBOARD_LL, andressK )
    }

    SetHook( idHook, andress ) {
        hHook :=
        SetWindowsHookEx( idHook, andress )
        if ( !hHook ) {
            MsgBox( "Failed to set hook: " idHook )
            ExitApp()
        }
        return hHook
    }

    PFNs( nCode, wParam, lParam ) {
        global m_pFn
        global k_pFn
        global f_flag

        Critical

        switch {
            case  Type( m_pFn ) == "Func" && Type( k_pFn ) == "Func":
                m_pFn()
                k_pFn()

            case Type( m_pFn ) == "Func":
                m_pFn( nCode, wParam, lParam )

            case Type( k_pFn ) == "Func" :
                k_pFn()
                
        }

        if ( !f_flag ) {

            return  CallNextHookEx( nCode, wParam, lParam )
        }
    }

    CallNextHookEx( nCode, wParam, lParam, hHook := 0 ) {
        
        LRESULT :=
        DllCall(
            "CallNextHookEx",
            "Ptr", hHook,
            "int", nCode,
            "UInt", wParam,
            "Ptr", lParam
        )
    
        return LRESULT
    }

    SetWindowsHookEx( idHook, pfn ) {
        hModule := GetModuleHandle()
        hHook :=
        DllCall(
            "SetWindowsHookEx",
            "int", idHook,
            "Ptr", pfn,
            "Ptr", hModule,
            "UInt", 0,
            "Ptr"
        )
        return hHook
    }

    GetModuleHandle() {
        hModule :=
        DllCall( 
            "GetModuleHandle", 
            "Ptr", 0,
            "Ptr"
        )
    
        return hModule
    }

    Unhook( hHook ) {
        Bool :=
        DllCall(
            "UnhookWindowsHookEx",
            "Ptr", hHook,
            "Int"
        )
        return Bool
    }

    OnExit( UnhookAll )

    UnhookAll( s, n ) {

        if ( IsSet( hHookKeybd ) ){
            BoolKeybd := Unhook( hHookKeybd )
            CallbackFree( andressK )
        }

        if ( IsSet( hHookMouse )){
            BoolMouse := Unhook( hHookMouse )
            CallbackFree( andressM )
        }
        ;ExitApp()
    }

}