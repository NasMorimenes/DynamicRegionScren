#Include Includes.ahk

ForceReleaseMutex( buff, hMutex, Values := 0 ) {

    try {
        ; Leitura do buffer
        Values := NumGet( buff, 0, "UInt" )
    } 
    finally {
        ; Liberar o mutex
        if ( !ReleaseMutex( hMutex ) ) {
            ;return ""
            MsgBox( "Erro ao liberar o mutex." )
        }
        ; Fechar o identificador do mutex
        if ( !CloseHandle( hMutex ) ) {
            ;return ""
            MsgBox( "Erro ao fechar o identificador do mutex." )
        }
    }

    return values
}