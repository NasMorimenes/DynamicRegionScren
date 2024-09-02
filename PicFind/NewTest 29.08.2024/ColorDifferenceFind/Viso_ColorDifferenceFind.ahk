Viso( x, sh, sw ) {

    Text := ""
    text1 := ""
    loop sh {
        
        loop sw {
            c := NumGet( x.Ptr, ( A_Index - 1 ), "Uchar" )
            ;c := NumGet( x, 4 * ( A_Index - 1 ), "UInt" )
            ;text1 .= NumGet( x, 4 * ( A_Index - 1 ), "UInt" ) ",";
            ;Text .= ( c >> 16 ) & 0xFF ","
            ;Text .= ( c >> 8 ) & 0xFF ","
            ;Text .= c & 0xFF ","
            Text .=  c ","
            sx := A_Index
        }
        c := NumGet( x.Ptr, sx, "UChar" )
        ;text1 .= NumGet( ss, 4 * x, "UInt" )
        ;Text .= ( c >> 16 ) & 0xFF ","
        ;Text .= ( c >> 8 ) & 0xFF ","
        ;Text .= c & 0xFF "`n"
        Text .=  c "`n"
    }
    FileAppend( Text "`n`n`n" text1, A_ScriptDir "\VisoTest.txt" )
    ;MsgBox( Text "`n`n`n" text1 )
}