/*
// (mode==3) Color Difference Mode
int ColorDifference( int c, int n, unsigned char *Bmp, unsigned char *ss, int sy, int sx, int sw, int sh, int Stride ) {

    int r, g, b, v, x, y, j, i, o, rr, gg, bb; 
    int  dR, dG, dB;
    o = sy * Stride + sx * 4;
    j = Stride - sw * 4;
    i = 0;
    
    rr = ( c >> 16 ) & 0xFF;
    gg = ( c >> 8 ) & 0xFF;
    bb = c & 0xFF;

    r = ( n >> 16 ) & 0xFF;
    g = ( n >> 8 ) & 0xFF;
    b = n & 0xFF;

    dR = r * r;
    dG = g * g;
    dB = b * b;

    for ( y = 0; y < sh; y++, o += j ) {

        for ( x = 0; x < sw; x++, o += 4, i++ ) {

            r = Bmp[ 2 + o ] - rr;
            g = Bmp[ 1 + o ] - gg;
            b = Bmp[ o ] - bb;

            ss[i] = ( r * r <= dR && g * g <= dG && b * b <= dB ) ? 1 : 0;
        }
    }

    return 0;
}

*/

c :=
n :=
Bmp :=
ss := 
sy :=
sx :=
sw :=
sh := 
Stride :=0

Hex := "4157415641554154555756534881ec580100000f29b424b00000000f29bc24c0000000440f298424d0000000440f298c24e0000000440f299424f0000000440f299c2400010000440f29a42410010000440f29ac2420010000440f29b42430010000440f29bc24400100008b8424e0010000448b9c24d001000089d38b9424c00100000fb6f14189ca8974246c0fb6fd0fb6f789d90fafd00fb6dbc1f9104d89ce4c898424b00100000fafdb41c1fa100fb6c9448b8424c80100000fafc9450fb6d20faff6468d3c82448b8424d8010000428d149d00000000895c247029d04585c00f8e0e0600004585db0f8e05060000418d6bff4c63c801d04531ed448d04ad000000008984249000000066410f6ec266440f6f25000000004d63c089ac24ac000000660f61c04b8d5c08044d63cb660f70e8004189e84a8d048dffffffff41c1e80483e5f04c898c248800000049c1e00648898424980000004489d84c8984248000000048c1e002448d04ad0000000089ac249400000044898424a8000000c74424740000000048898424a000000048895c24784963df48039c24b00100000f296c2450662e0f1f8400000000004c8b8c24980000004963d5498d04164d8d04194c39c0410f93c048039424880000004c01f24839d30f93c24108d00f848c04000083bc24ac0000000f0f867e040000660f6eef66450fefff66450fefc9488b942480000000660f70ed000f296c2420660f6e6c246c4c8d04134889da660f70ed000f296c2430660f6ee9660f70ed000f292c24660f6eee660f70ed000f296c2410660f6e6c2470660f70ed000f296c24400f1f4000f30f6f0af30f6f421066410f6fdc4883c240f30f6f52e0f30f6f62f04883c01066410fdbc466410fdbcc660f6f6c2450660f6f742420660f67c8f30f6f42f066410fdbd466440f6f442430660f71d40866410fdbc4660f67d066410f6fc4660fdbda660f71d208660fdbc1660f71d108660f67c3f30f6f5ad0660f67caf30f6f52c0660f71d30866440f6fd1660f71d208660f67d3f30f6f5ae066410fdbd4660f71d308660f67dc660fefe466410fdbdc66440f60d4660f68cc660f67d366440ff9d5660ff9cd660f6fda660f68d466450f6fda660f60dc66450fd5da660f6fea66410f69d7660f6ffb66410f61ef66440f6ff2660f6fd066410f61ff660f60d4660f68c466410f69df660ffafe660ffade660f6fe0660ffaee66440ffaf6660f6ff266410f61f766410f69d766410f61e766410f69c766410ffaf066410ffad066410ffae066410ffac066440f6fc766440ff4c7660f73d72066450f6feb660ff4ff66450fe5d266450f70c008660f70ff0866450f61ea66450f69da66440f6f54241066440f62c766440f662c24660f6ffe660ff4fe660f73d620660ff4f666440f6644241066450f76e966450f76c1660f70ff08660f70f608660f62fe660f6ff366450fdbe866440f6f442440660ff4f3660f73d320660ff4db66410f66f866410f76f9660f70f608660f70db08660f62f3660f6fda66440fdbef660f6f3c24660ff4da660f73d220660ff4d266440f66df66410f66f266450f76d9660f70db0866410f76f1660f70d208660f62da66410f6fd566410f66d866440fdbde66410f76d966440fdbdb66450f61eb66410f69d366410f6fdd66440f61ea660f69da660f6fd5660ff4d5660f73d52066440f61eb660ff4ed660f6fd966450fdbec660fd5d9660fe5c9660f70d208660f70ed08660f6ff3660f62d5660f6fec660ff4ec660f61f1660f69d9660f73d420660f66f766410f6fce660ff4e466410f66d266410ff4ce660f66df66410f76f166410f76d1660f70ed08660f70e408660fdbf2660f62ec66410f6fd6660f73d22066410f66e8660f6fe3660ff4d266410f76e1660f70d908660f6fc8660ff4c8660f73d020660ff4c066410f76e9660f70d208660f62da660fdbf5660f70c90866410f66da660f70c008660f62c8660f6fc166410f76d966410f66c0660fdbdc66410f76c1660fdbd8660f6fc6660f61f3660f69c3660f6fce660f61f0660f69c8660f61f166410fdbf466440f67ee66440fdb2d10000000440f1168f04939d00f856afcffff8b8424a8000000418d14078b8424940000004863d248039424b0010000458d4c05004d63c94d01f14429c84189c4eb3466904129f8450fafc04439c67c3c2b6c246c0fafed396c24700f9dc04188014983c1014883c204438d040c4439d80f8d7e0000000fb64202440fb642010fb62a4429d00fafc039c17db831c0ebce0f1f4000488b9424a00000004989d84801da48891424410fb65002450fb648014531e4410fb6284429d20fafd239d17c1b4129f9450fafc94439ce7c0f2b6c246c0fafed396c2470410f9dc44488204983c0044883c0014c39042475b90f1f800000000083442474014501dd8b4424744403bc249000000048035c2478398424d80100000f85bafaffff0f28b424b000000031c00f28bc24c0000000440f288424d0000000440f288c24e0000000440f289424f0000000440f289c2400010000440f28a42410010000440f28ac2420010000440f28b42430010000440f28bc24400100004881c4580100005b5e5f5d415c415d415e415fc3909090909090909090909090ff00ff00ff00ff00ff00ff00ff00ff0001010101010101010101010101010101"

code := MCode( Hex )

Call( c,
    n,
    Bmp,
    ss,
    sy,
    sx,
    sw,
    sh,
    Stride ) {

    result :=
    DllCall(
        code,
        "Uint", c,
        "Uint", n,
        "UPtr", Bmp,
        "Ptr" , ss,
        "Int" , sy,
        "Int" , sx,
        "Int" , sw,
        "Int" , sh,
        "Int" , Stride,
        "Int"
    )

    return result
}



MCode( hex ) {
	len := StrLen( hex) // 2
	code := Buffer( len, 0 )
	DllCall( 
		"crypt32\CryptStringToBinary",
		"Str", hex,
		"uint", 0,
		"uint", 4,
		"Ptr", code,
		"uint*", &len,
		"Ptr", 0,
		"Ptr", 0
	)
		DllCall( 
		"VirtualProtect",
		"Ptr", code,
		"Ptr", len,
		"uint", 0x40,"Ptr*", 0
	)
	return code
}

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

etStride( biWidth ) {
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