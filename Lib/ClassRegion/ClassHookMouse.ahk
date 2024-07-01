
;Test 001

Ass := HookMouse( )

Sleep( 20000 )
Ass.__Delete()

Esc::ExitApp()


Class HookMouse {

    static dpi := A_ScreenDPI / 96
    static mouseBuff := Buffer( 8, 0 )    
    static WH_MOUSE_LL := 14
    static andress := 0
    static hHookMouse := 0 ;HookMouse.SetHook( HookMouse.WH_MOUSE_LL, HookMouse.andress )
    

    __New() {
        
        HookMouse.andress := CallbackCreate( ObjBindMethod( this, "MoveMouse" ), , 3 ) ;OK
        MsgBox( HookMouse.andress )
        HookMouse.hHookMouse := HookMouse.SetHook( HookMouse.WH_MOUSE_LL, HookMouse.andress )
        
    }

    
    __Delete() {
        HookMouse.Unhook()
        MsgBox( "Saiu" )
        ExitApp()
    }

    ;static MoveMouse( wParam, lParam, nCode ) { 
    MoveMouse( nCode ,wParam, lParam) {

        Critical        

        static lastMouseMove := A_TickCount
        ;ListVars()

        if ( !nCode  && ( wParam = 0x200 ) ) { 
            
            diffMouseMove := A_TickCount - lastMouseMove
            lastMouseMove := A_TickCount
    
            Text := 
            (
                " X: " NumGet( lParam , 0, "Int" )
                " Y: " NumGet( lParam , 4, "Int" )
                " Last keypress: " diffMouseMove
            )
            ;OutputDebug( Text )
    
            ToolTip( Text )
    
            setVars := -1
            currTime := A_TickCount
            xPos := NumGet( lParam, 0, "int" )
            yPos := NumGet( lParam, 4, "int" )
    
            ;ToolTip( QueryMouseMove( setVars, currTime , xPos, yPos ) )
    
            ;QueryMouseMove( setVars, currTime , xPos, yPos )
        }

        Return HookMouse.CallNextHookEx( nCode, wParam, lParam ) 
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
                "Key Pressed: " HookMouse.GetKeyDetails( lParam )
                " Last Key Press: " diffKeyPress
            )
            Assd() {
                ToolTip( Text )
            }

            SetTimer( Assd , -2000 )
        }
    
        Resut := HookMouse.CallNextHookEx( nCode, wParam, lParam )
    
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
        
        hHook := HookMouse.SetWindowsHookEx( idHook, pfn )
    
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

        hModule := HookMouse.GetModuleHandle()
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
        CallbackFree( HookMouse.andress )
        HookMouse.UnhookWindowsHookEx( HookMouse.hHookMouse ) 
    }
}
