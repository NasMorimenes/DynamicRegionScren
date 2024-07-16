WaitForSingleObject( ghMutex, t ) {
    ;https://learn.microsoft.com/pt-br/windows/win32/api/synchapi/nf-synchapi-waitforsingleobject
    result := 
    DllCall(
        "WaitForSingleObject",
        "ptr", ghMutex,
        "int", t,
        "UInt"
    )
    return result
}