#Include GetModuleHandle.ahk
SetWindowsHookEx( idHook, pfn ) {
    hModule := GetModuleHandle()
    hHook :=
    DllCall(
        "SetWindowsHookEx",
        "int", idHook,
        "Ptr", pfn,
        "Ptr", hModule, ; DllCall("GetModuleHandle", "Ptr", 0),
        "UInt", 0,
        "Ptr"
    )
    return hHook
}