GetModuleHandle() {
    hModule :=
    DllCall( 
        "GetModuleHandle", 
        "Ptr", 0,
        "Ptr"
    )

    return hModule
}