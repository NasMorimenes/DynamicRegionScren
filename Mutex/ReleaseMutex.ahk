#Include Includes.ahk

ReleaseMutex( hMutex ) {

    boolMutex :=
    DllCall(
        "ReleaseMutex",
        "ptr", hMutex,
        "Int"
    )
    return boolMutex
}