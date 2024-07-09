#Include Includes.ahk
CloseHandle( hMutex ) {
    boolHandle :=
    DllCall(
        "CloseHandle",
        "ptr", hMutex,
        "Int"
    )
    return boolHandle
}