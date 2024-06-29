; Function to Log Debug Information

LogDebug( info ) {

    if ( LOG_TO_FILE ) {
        FileAppend( info "`n", "debug_log.txt" )
    }
    else {
        ToolTip( info )
    }
}


/*

LogDebug( info, lParam ) {

    static lock := false

    Buf

    StrPut StrPut( info )


     time := NumGet(lParam, 12, "Int" )
    ; Esperar até que o arquivo esteja disponível para escrita
    Loop {
        if ( !lock ) {
            lock := True
            break
        }
        Sleep( 50 )  ; Espera por 10ms antes de tentar novamente
    }

    if ( LOG_TO_FILE ) {
        FileAppend(info "`n", "debug_log.txt")
    }
    lock := False
}

/*
LogDebug( info ) {

    static setInfo := ""
    static sync := A_TickCount
    static BufferA := Buffer( 0, 0 )
    static BufferB := Buffer( 0, 0 )

    setInfo .= info

    while ( ( A_TickCount - sync ) <= 150 ) {
        BufferA.Size := StrPut( setInfo )
        StrPut( setInfo, BufferA )
    }
    sync := A_TickCount
    Swap( &BufferA, &BufferB )
    FileAppend( StrGet( BufferB ) "`n", "debug_log.txt")
    setInfo := ""
    BufferA.Size := 0
    BufferB.Size := 0

    Swap( &BufferA, &BufferB ) {
        ;x := StrGet( BufferA )
        ;StrPut( x, BufferB )
        BufferB.Size := StrPut( StrGet( BufferA ) )
        StrPut( StrGet( BufferA ), BufferB )
    }
}