#Include SetColloChannels.ahk
#Include SetColorBuff.ahk

text := Array()
A := A_TickCount
Loop 1366 * 768 * 4
    Rand( 0, 255 )


i := 0
j := 0
buff := 0
;VarSetStrCapacity( &Buff, 1366 * 788 * 4 )
A := A_TickCount
loop text.Length {
    Canais := [ "B", "G", "R", "A"]
    color := 0
    cs := SetColorChannels( &color, text[ A_Index ], Canais[ ++i ] )
    if ( i == 4 ) {
        SetColorBuff( &buff, cs )
        i := 0
        j++
        MsgBox( j )
    }
}

MsgBox( A_TickCount - A )

Rand( min, max, flag := 0 ) {
    global text
    randNum := Random( min, max )
    text.Push (randNum )
    return randNum
}

Esc::ExitApp()
