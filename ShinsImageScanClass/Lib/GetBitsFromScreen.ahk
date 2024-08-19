;#Include EncodeImage 25 09 2023.ahk
#Include <GetDesktopWindow>
#Include <GetWindowDC>
#Include <CreateCompatibleDC>
#Include <StructCPP>
#Include <GetDC>
#Include <CreateDIBSection>
#Include <SelectObject>
#Include <BitBlt>
#Include <RtlMoveMemory1>
#Include <DeleteObject>
#Include <DeleteDC>

SetTitleMatchMode( "RegEx" )

GetBitsFromScreen( captureX, captureY, captureWidth, captureHeight, HWND := 0, &Stride := 0 ) {
    
    ppvBits := 0

    if ( HWND == 0 ) {
        HWND := GetDesktopWindow()
    }
    HDC := GetWindowDC( HWND )
    MDC := CreateCompatibleDC( HDC )
    Members :=
    (
        "DWORD biSize;
        LONG  biWidth;
        LONG  biHeight;
        WORD  biPlanes;
        WORD  biBitCount;"
    )

    BINFO := StructCPP( "BITMAPINFO", Members, [ 40, captureWidth, -captureHeight, 1, 32 ] )
    BI := BINFO.struct
    hBITMAP := CreateDIBSection( MDC, BI, &ppvBits )

    if ( hBITMAP ) {

        OBM := SelectObject( MDC, hBITMAP )
        bool := BitBlt( MDC, captureWidth, captureHeight, HDC, , ,captureX, captureY )        
        Scan0 := RtlMoveMemory( captureWidth, captureHeight, ppvBits )
        SelectObject( MDC, OBM )
        DeleteObject( hBITMAP )
    }

    DeleteDC( MDC )
    ReleaseDC( HWND, HDC )

    return Scan0
}

    /*

    Range := Array()
    cont := 1
    Loop ( captureWidth * captureHeight )  {

        c := NumGet(Scan0.Ptr + 0, 4 * ( A_Index - 1 ), "UInt" )
        color .= c ","
        Range.Push( ( ( ( ( c >> 16 ) & 0xFF ) * 38 + ( ( c >> 8 ) & 0xFF ) * 75 + ( c & 0xFF ) * 15 ) >> 7 ) )
        VV .= ( ( ( ( c >> 16) & 0xFF ) * 38 + ( ( c >> 8 ) & 0xFF ) * 75 + ( c & 0xFF) * 15 ) >> 7 )
        if ( cont <= 199 ) {
            VVi .= ( ( ( ( c >> 16) & 0xFF ) * 38 + ( ( c >> 8 ) & 0xFF ) * 75 + ( c & 0xFF) * 15 ) >> 7 ) " "
            ++cont
        }
        else {
            VVi .= ( ( ( ( c >> 16) & 0xFF ) * 38 + ( ( c >> 8 ) & 0xFF ) * 75 + ( c & 0xFF) * 15 ) >> 7 ) "`n" 
            cont := 1
        }
    }
    ;MsgBox( VV )
    ; FileAppend( c, A_ScriptDir "\color.txt" ) Visualiza��o dos dados

    Av := Map()
    newThreshold := 0
    pIP := 0
    pIS := Range.Length

    for Value in Range {
        if ( Av.Has( Value ) ) {
            Av[ Value ]++
            pIP += Value
        }
        else {
            Av.Set( Value, 1 )
            pIP += Value ;Valor
        }
    }

    newThreshold := Floor(pIP / pIS)
    Bit := ""
    Ones := 0
    Zeros := 0
    for a, b in Range {
        Bit .= b >= newThreshold ? 0 : 1
    }
    A_Clipboard := ""
    A_Clipboard := VVi

    RegExReplace(Bit,"1",,&Ones)
    RegExReplace(Bit,"0",,&Zeros)

    ;imageEncode := EncodeImage(Bit)

    ;return Array(newThreshold, Ones, Zeros, imageEncode, WinGetTitle(ID))
}