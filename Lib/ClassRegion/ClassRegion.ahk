
;Test 001

Ass := region( "WH_KEYBOARD_LL" )

Sleep( 20000 )
Ass.__Delete()

Esc::ExitApp()


Class region {

    static dpi := A_ScreenDPI / 96
    static mouseBuff := Buffer( 8, 0 )    
    static WH_MOUSE_LL := 14
    static WH_KEYBOARD_LL := 13
    static andress := 0
    static hHookMouse := 0 ;region.SetHook( region.WH_MOUSE_LL, region.andress )
    

    __New( phook ) {
        if ( phook = "WH_MOUSE_LL" ) {
            hook := region.WH_MOUSE_LL
            fn := "MoveMouse"
        }
        else if ( phook = "WH_KEYBOARD_LL" ) {
            hook := region.WH_KEYBOARD_LL
            fn := "Keyboard"
        }
        ;region.andress := CallbackCreate( region.%fn% )
        region.andress := CallbackCreate( ObjBindMethod( this, fn ), , 3 ) ;OK
        MsgBox( region.andress )
        region.hHookMouse := region.SetHook( hook, region.andress )
        ;this.andress := region.andress
    }

    
    __Delete() {
        region.Unhook()
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

        Return region.CallNextHookEx( nCode, wParam, lParam ) 
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
                "Key Pressed: " region.GetKeyDetails( lParam )
                " Last Key Press: " diffKeyPress
            )
            Assd() {
                ToolTip( Text )
            }

            SetTimer( Assd , -2000 )
        }
    
        Resut := region.CallNextHookEx( nCode, wParam, lParam )
    
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
        
        hHook := region.SetWindowsHookEx( idHook, pfn )
    
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

        hModule := region.GetModuleHandle()
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
        CallbackFree( region.andress )
        region.UnhookWindowsHookEx( region.hHookMouse ) 
    }
}
