#x:: {
global
Scan := 0
GetbiBitCount()

GetBitsFromScreen( 500, 300, 10, 10 )
Text := ""
text1 := ""
loop 10 {

    loop 9 {

        c := NumGet( Scan.Ptr, 4 * ( A_Index - 1 ), "UInt" )
        text1 .= NumGet( Scan.Ptr, 4 * ( A_Index - 1 ), "UInt" ) ","
        Text .= ( c >> 16 ) & 0xFF ","
        Text .= ( c >> 8 ) & 0xFF ","
        Text .= c & 0xFF ","

        x := A_Index
    }
    c := NumGet( Scan.Ptr, 4 * x, "UInt" )    
    text1 .= NumGet( Scan.Ptr, 4 * x, "UInt" )
    Text .= ( c >> 16 ) & 0xFF ","
    Text .= ( c >> 8 ) & 0xFF ","
    Text .= c & 0xFF "`n"
}

MsgBox( Text "`n`n`n" text1 )
}

Esc::ExitApp()

;"FF304A" "FF1630" "FF2B40"


GetBitsFromScreen(captureX, captureY, captureWidth, captureHeight, Setbpp := 32, flag:= 1 ) {
	static ID := 0

	if flag = 0 {
		MsgBox
		(
		"Defina " Chr(34) "Flag" Chr(34)
		)

		ExitApp
	}
	if flag = 1 {
		captureX := captureX - 10
		captureY := captureY - 10
	}

	static Ptr := A_PtrSize ? "UPtr" : "UInt"
	static PtrP := Ptr "*"
	static Bits := 0
	static ppvBits := 0
	global scan
    global biBitCount
    global Stride

    ( Setbpp !=32 && biBitCount := Setbpp )
    ( !IsSet( biBitCount ) && biBitCount := 32 )

	if (!ID ) {
		ID := WinGetID("A")
	}

	sizeScan := captureWidth * captureHeight * 4
	Scan := Buffer( sizeScan, 0 )
    ( !IsSet( Stride ) && GetStride( captureWidth ) )

	Win := DllCall("GetDesktopWindow", Ptr) ;DllCall("GetForegroundWindow",Ptr) -> Janela ativa
	HDC := DllCall("GetWindowDC", Ptr, Win, Ptr)
	MDC := DllCall("CreateCompatibleDC", Ptr, HDC, Ptr)

	BI := Buffer(40, 0)
	NumPut("UInt", 40, BI, 0)
	NumPut("Int", captureWidth, BI, 4)
	NumPut("Int", -captureHeight, BI, 8)
	NumPut("Short", 1, BI, 12)
	NumPut("Short", biBitCount, BI, 14)

	hBM := DllCall("CreateDIBSection"
									, Ptr, MDC
									, Ptr, BI.Ptr
									, "Int", 0
									, PtrP, &ppvBits
									, Ptr, 0
									, "Int", 0
									, Ptr)

	if (hBM) {

		OBM := DllCall("SelectObject", Ptr, MDC, Ptr, hBM, Ptr)

		DllCall( "BitBlt"
			   , Ptr	, MDC
			   , "Int"  , 0
			   , "Int"  , 0
			   , "Int"  , captureWidth
			   , "Int"  , captureHeight
			   , Ptr	, HDC
			   , "Int"  , captureX
			   , "Int"  , captureY
			   , "UInt" , 0x00CC0020 | 0x40000000)

		DllCall("RtlMoveMemory", Ptr, Scan.Ptr, Ptr, ppvBits, Ptr, Stride * captureHeight)

		DllCall("SelectObject", Ptr, MDC, Ptr, OBM)

		DllCall("DeleteObject", Ptr, hBM)
	}
	DllCall("DeleteDC", Ptr, MDC)
	DllCall("ReleaseDC", Ptr, Win, Ptr, HDC)
}

GetStride( biWidth ) {
    global biBitCount
    global Stride
    ( !IsSet( Stride ) &&  Stride := ( ( biWidth * biBitCount + 31 ) & ~31 ) >> 3 ) 
    return 
}

GetbiBitCount( Bits := 32 ) {
    
    static BitCount := Map(
        "1", 1,     ; 
        "2", 3,     ;
        "4", 4,     ;
        "8", 8,     ;
        "16", 16,   ;
        "24", 24,   ;
        "32", 32,   ;
    )

    if ( !IsSet( biBitCount ) ) {

        global biBitCount := BitCount[ String( Bits ) ]
    }
    else {
        global biBitCount := BitCount[ String( Bits ) ]
    }
}

; Função para gerar uma cor aleatória
RandomColor() {
    return (Random(0x000000, 0xFFFFFF) & 0xFFFFFFFF)
}