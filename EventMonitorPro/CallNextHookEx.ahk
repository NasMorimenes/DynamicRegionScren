
; Function to Call Next Hook in Chain
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