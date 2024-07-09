#Include Includes.ahk
ReadFromBuffer( mutexName, buff ) {    
    ; Obter o mutex
    hMutex := CreateMutex( mutexName )
    LastError := 183
    if ( GetError( LastError ) ) {
        return 0
    }

    Values := ForceReleaseMutex( buff, hMutex )

    return Values
}