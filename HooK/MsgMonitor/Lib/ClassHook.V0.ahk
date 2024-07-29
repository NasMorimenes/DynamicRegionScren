Ass := Hook
;Ass.Set_idHook( 13 )
Ass( )
;Ass.

#x:: {
    Hook.Set_flag( 1 )
    Sleep( 3000 )
    Hook.Set_flag()
    Sleep( 5000 )
    Hook.UnhookAll( Hook.hHooK, Hook.andressCallBack )
}

Esc::ExitApp()

class Hook {

    static Set_idHook( i := 0 ) => i == 0 ? Hook.idHook := 14 : Hook.idHook := i
    static Set_flag( i := 0 ) => i == 0 ? Hook.flag := 0 : Hook.flag := i
    static SharedOutput := 0
    static andressCallBack := CallbackCreate( Hook.Fn )
    static appFn( i := 0 ) => i == 0 ? ( this.idHook == 14 ? ToolTip( "Set AppFn! 14" ) : ToolTip( "Set AppFn! 13", 100, 150 ) ) : ToolTip( )
    ;appFn( i := 0 ) => i == 0 ? ToolTip( "Set AppFn!" ) : ToolTip( )
    static hModule := 
    DllCall( 
        "GetModuleHandle", 
        "Ptr", 0,
        "Ptr"
    )

    static Fn( nCode, wParam, lParam ) {
        Hook.nCode := nCode
        Hook.wParam := wParam
        Hook.lParam := lParam
        Critical
        if ( nCode >= 0 ) {
            Hook.appFn()
        }           

        if ( Hook.flag == 0 ) {
            return Hook.CallNextHookEx( nCode, wParam, lParam, Hook.hHooK )
        }
        else {
            return 1
        }    
                
    }

    static CallNextHookEx( nCode, wParam, lParam, hHooK := 0 ) {
        resul :=
        DllCall(
            "CallNextHookEx",
            "Ptr", hHooK,
            "int", nCode,
            "UInt", wParam,
            "Ptr", lParam
        )
        return resul
    }
    
    static SetWindowsHookEx( hModule, andressCallBack, idHook ) {
        if ( hModule && idHook ) {
            Hook.hHook :=
            DllCall(
                "SetWindowsHookEx",
                "int", idHook,
                "Ptr", andressCallBack,
                "Ptr", hModule,
                "UInt", 0,
                "Ptr"
            )
        }
        if ( !Hook.hHook ) {
            MsgBox( "Failed to set hook: " idHook )
            ExitApp()
        }
    }
            
    static UnhookWindowsHookEx( hHook ) {

        DllCall(
            "UnhookWindowsHookEx",
            "Ptr", hHook,
            "Int"
        )
    }

    static UnhookAll( ) {
        Hook.UnhookWindowsHookEx( Hook.hHook )
        if ( Hook.andressCallBack ) {
            CallbackFree( Hook.andressCallBack )
            Hook.andressCallBack := 0
        }
        Hook.appFn( 1 )
    }

    __Init() {
        ;Hook.hHook := 0
        Hook.Set_idHook()
        Hook.Set_flag()
        Hook.SetWindowsHookEx( Hook.hModule, Hook.andressCallBack, Hook.idHook )
    }
    
    __New( idHook := 14, SharedOutput := 0, flag := 0 ) {
        if ( idHook != 14 ) {
            Hook.idHook := idHook
        }
        this.SharedOutput := SharedOutput       
        this.SetSharedOutput()
    }

    SetSharedOutput() {
        ;ii
    }
    __Delete() {
        hook.UnhookAll( Hook.hHook, Hook.andressCallBack )
    }
}