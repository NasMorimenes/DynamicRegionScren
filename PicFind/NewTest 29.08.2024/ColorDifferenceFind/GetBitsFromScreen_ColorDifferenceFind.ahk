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