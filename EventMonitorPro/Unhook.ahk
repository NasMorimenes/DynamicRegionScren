Unhook( hHook ) {
    Bool :=
    DllCall(
        "UnhookWindowsHookEx",
        "Ptr", hHook,
        "Int"
    )
    return Bool
}