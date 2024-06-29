#Include SetWindowsHookEx.ahk
;  Function to Set a Hook
SetHook( idHook, pfn ) {
    hHook := SetWindowsHookEx( idHook, pfn ) ;DllCall("SetWindowsHookEx", "int", idHook, "Ptr", pfn, "Ptr", DllCall("GetModuleHandle", "Ptr", 0), "UInt", 0, "Ptr")
    if ( !hHook ) {
        MsgBox( "Failed to set hook: " idHook )
        ExitApp()
    }
    return hHook
}