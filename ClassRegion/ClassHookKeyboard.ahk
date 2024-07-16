
;Test 001

Ass := HookKeyboard( )

Sleep( 20000 )
Ass.__Delete()

Esc::ExitApp()


Class HookKeyboard {

    static dpi := A_ScreenDPI / 96
    static mouseBuff := Buffer( 8, 0 ) 
    static WH_KEYBOARD_LL := 13
    static andress := 0
    static hHookMouse := 0 ;HookKeyboard.SetHook( HookKeyboard.WH_MOUSE_LL, HookKeyboard.andress )
    

    __New() {
        
        HookKeyboard.andress := CallbackCreate( ObjBindMethod( this, "Keyboard" ), , 3 ) ;OK
        MsgBox( HookKeyboard.andress )
        HookKeyboard.hHookMouse := HookKeyboard.SetHook( HookKeyboard.WH_KEYBOARD_LL, HookKeyboard.andress )
        
    }

    
    __Delete() {
        HookKeyboard.Unhook()
        MsgBox( "Saiu" )
        ExitApp()
    }

    ;static Keyboard( nCode, wParam, lParam ) {
    Keyboard( nCode, wParam, lParam ) {

        ;nCode  := nCode >> 0xF 
        ;wParam &= 0XFF
        Critical
        static lastKeyPress := A_TickCount
        ;static lastKeyPress := 0

        ;ListVars()

        if ( !nCode && wParam == 256 ) { ; WM_KEYDOWN

            diffKeyPress := A_TickCount - lastKeyPress
            lastKeyPress := A_TickCount
    
            ; Capture Data Mensage
            
            Text :=
            (
                "Key Pressed: " HookKeyboard.GetKeyDetails( lParam )
                " Last Key Press: " diffKeyPress
            )
            Assd() {
                ToolTip( Text )
            }

            SetTimer( Assd , -2000 )
        }
    
        Resut := HookKeyboard.CallNextHookEx( nCode, wParam, lParam )
    
        return Resut
    }

    static GetKeyDetails( lParam ) {

        vkCode := NumGet( lParam, 0, "Int" )
        scCode := NumGet(lParam, 4, "Int" )
        extended := NumGet(lParam, 8, "Int" ) & 1
        time := NumGet(lParam, 12, "Int" )
    
        Detail :=
        (
            "vkCode: " vkCode
            " scCode: " scCode
            " Extended: " extended
            " Time: " time
        )
    
        return Detail
    }


    static SetHook( idHook, pfn ) {
        
        hHook := HookKeyboard.SetWindowsHookEx( idHook, pfn )
    
        if ( !hHook ) {
            MsgBox( "Failed to set hook: " idHook )
            ExitApp()
        }

        return hHook
    }

    static CallNextHookEx( nCode, wParam, lParam, hHook := 0 ) {
                
        LRESULT :=
        DllCall(
            "CallNextHookEx",
            "Uint", hHook,
            "int", nCode,
            "Uint", wParam,
            "Uint", lParam
        ) 
        
        Return LRESULT
    }

    static SetWindowsHookEx( idHook, pfn ) {

        hModule := HookKeyboard.GetModuleHandle()
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

    static GetModuleHandle() {

        hModule :=
        DllCall(
            "GetModuleHandle",
            "Ptr", 0,
            "Ptr"
        )
    
        return hModule
    }

    static UnhookWindowsHookEx( hHook ) { 
        bool :=
        DllCall(
            "UnhookWindowsHookEx",
            "Uint", hHook,
            "int"
        )
        Return bool
    }

    static Unhook() {
        MsgBox( "Saindo" )
        CallbackFree( HookKeyboard.andress )
        HookKeyboard.UnhookWindowsHookEx( HookKeyboard.hHookMouse ) 
    }
}
