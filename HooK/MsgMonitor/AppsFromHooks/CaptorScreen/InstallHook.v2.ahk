#Include ProcessSharedData.ahk
#Include WaitForSingleObject.ahk

;InstallHookMKV2(  pfnM := "", pfnK := "" ) {
InstallHookMKV2(  hM := 0, hK := 0, pfn? ) {
    global pfnH

    if ( hM ) {
        WH_MOUSE_LL := 14
        andressM := CallbackCreate( LowLevelKeyboardProc )
        hHookMouse := SetHook( WH_MOUSE_LL, andressM )
    }

    ( IsSet( pfn ) && pfnH := pfn )
    /*
    global m_pFn := pfnM
    global k_pFn := pfnK
    global f_flag := 0
    global ghMutex, sharedData
    
    if ( Type( pfnM ) == "Func" ) {
        WH_MOUSE_LL := 14
        andressM := CallbackCreate( LowLevelKeyboardProc )
        hHookMouse := SetHook( WH_MOUSE_LL, andressM )
    }

    if ( Type( pfnK ) == "Func" ) {
        WH_KEYBOARD_LL := 13
        andressK := CallbackCreate( pfnK )
        hHookKeybd := SetHook( WH_KEYBOARD_LL, andressK )
    }
    */

    SetHook( idHook, andress ) {
        hHook :=
        SetWindowsHookEx( idHook, andress )
        if ( !hHook ) {
            MsgBox( "Failed to set hook: " idHook )
            ExitApp()
        }
        return hHook
    }

    LowLevelKeyboardProc( nCode, wParam, lParam ) {

        /*
        global m_pFn
        global k_pFn
        */
        static text := ""
        global f_flag
        global pfnH
        global ghMutex
        global sharedData

        Critical

        if ( nCode >= 0 ) {
            ; Bloqueia o mutex
            
            ;if DllCall("WaitForSingleObject", "ptr", ghMutex, "int", 0xFFFFFFFF, "UInt") = 0x00000000 {
            result := WaitForSingleObject( ghMutex, 0 )
            if ( result = 0 ) {
                text := wParam
                try {
                    ; Compartilha lParam e wParam
                    ;sharedData.wParam := wParam
                    ;sharedData.lParam := lParam

                    NumPut( "Ptr", wParam, sharedData, 0 )
                    NumPut( "Ptr", lParam, sharedData, 8 )
                    Sleep( 1 )

                    ; Sinaliza para processar os dados (pode ser um thread separado)
                    SetTimer( pfnH, -1 )
                } finally {
                    ; Libera o mutex
                    if !DllCall("ReleaseMutex", "ptr", ghMutex)
                        MsgBox( "Erro ao liberar o mutex." )
                    
                    ;Sleep( 1000 )
                }
            }
            else {
                text := result
                ToolTip()
                MsgBox( text )
            }
        }
        ToolTip( Text )
        if ( !f_flag ) {

            return  CallNextHookEx( nCode, wParam, lParam )
        }
        else {
            
            return 1
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
        /*
        if ( IsSet( hHookKeybd ) ){
            BoolKeybd := Unhook( hHookKeybd )
            CallbackFree( andressK )
        }
        */
        if ( IsSet( hHookMouse )){
            BoolMouse := Unhook( hHookMouse )
            CallbackFree( andressM )
        }
        ;ExitApp()
    }

}