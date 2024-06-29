DEBUG_OUTPUT := false
WH_MOUSE_LL := 14
Assd := false

#x:: {
    global Assd
    Assd := !Assd
}

andress := CallbackCreate(MouseMove)
hHookMouse := SetHook( WH_MOUSE_LL , andress)


OnExit( Unhook )

Esc::ExitApp() ; Gera loop continuo, semellhante a 'Persistent'

SetHook( idHook, pfn ) {
    hHook := SetWindowsHookEx(idHook, pfn)
    if (!hHook) {
        MsgBox("Failed to set hook: " idHook)
        ExitApp()
    }

    return hHook
}

MouseMove(nCode, wParam, lParam) {
    global Assd
    
    Critical

    if ( Assd == false )
        Return CallNextHookEx(nCode, wParam, lParam)

    ListVars()    
    static lastMouseMove := A_TickCount
    If (!nCode && (wParam = 0x200)) {

        diffMouseMove := A_TickCount - lastMouseMove
        lastMouseMove := A_TickCount

        ; NumPut("Int", NumGet(lParam, 0, "Int"), region.mouseBuff, 0)
        ; NumPut("Int", NumGet(lParam, 0, "Int"), region.mouseBuff, 4)

    }

    Return CallNextHookEx(nCode, wParam, lParam)
}

CallNextHookEx(nCode, wParam, lParam, hHook := 0) {

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

SetWindowsHookEx(idHook, pfn) {

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

UnhookWindowsHookEx(hHook) {
    bool :=
    DllCall(
        "UnhookWindowsHookEx",
        "Uint", hHook,
        "int"
    )
    Return bool
}

Unhook( * ) {
    global andress, hHookMouse
    CallbackFree(andress)
    UnhookWindowsHookEx(hHookMouse)
}