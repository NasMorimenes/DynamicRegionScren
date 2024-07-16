GetLastError( ) {

    LastError :=
    DllCall( 
        "GetLastError",
        "UInt"
    )
    
    return LastError
}