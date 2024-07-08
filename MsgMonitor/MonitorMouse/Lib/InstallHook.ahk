
#Include C:\Users\morim\OneDrive\DynamicRegionScren\\EventMonitorPro\LowLevelMouseProc_wParam.ahk
#Include C:\Users\morim\OneDrive\DynamicRegionScren\\EventMonitorPro\MSLLHOOKSTRUCT.ahk


InstallHookMK( MouseDownUp )

Esc::ExitApp()

MouseDownUp( nCode, wParam, lParam ) {
    static Extenal := Buffer( 16, 0)
    static Text := ""
    static lastMouseMove := A_TickCount
    static dist := 0
    static Count := 0
    static iniButton := "LButton Pressionado"
    static fimButton := "LButton Soltado"
    static dinButton := "Mouse Movido"
    static stats := 0
    static xPosIni := ""
    static yPosIni := ""
    
    if ( !nCode ) {

        info := LowLevelMouseProc_wParam( wParam )

        if ( info == iniButton ) {

            if ( xPosIni == "" && yPosIni == "" ) {
                
                iniButton := dinButton

                NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  0 )
                NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal,  4 )
                NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  8 )
                NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal, 12 )

                xPosIni := NumGet( lParam, 0, "UInt" )
                yPosIni := NumGet( lParam, 4, "UInt" )
                xPosFim := NumGet( lParam, 0, "UInt" )
                yPosFim := NumGet( lParam, 4, "UInt" )
            }
            else {
                NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  8 )
                NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal, 12 )
                xPosFim := NumGet( lParam, 0, "UInt" )
                yPosFim := NumGet( lParam, 4, "UInt" )
            }

            Text := 
            (
                "xPosIni - " xPosIni "`n"
                "yPosIni - " yPosIni "`n"
                "xPosFim - " xPosFim "`n"
                "yPosFim - " yPosFim
            )            
            ToolTip( Text )
    
        }
        else if ( info == fimButton ) {

            NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  8 )
            NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal, 12 )
            
            xPosFim := NumGet( lParam, 0, "UInt" )
            yPosFim := NumGet( lParam, 4, "UInt" )
            iniButton := "LButton Pressionado"
            Text := 
            (
                "xPosIni - " xPosIni "`n"
                "yPosIni - " yPosIni "`n"
                "xPosFim - " xPosFim "`n"
                "yPosFim - " yPosFim
            )
            
            ToolTip()
        }
    }
}



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