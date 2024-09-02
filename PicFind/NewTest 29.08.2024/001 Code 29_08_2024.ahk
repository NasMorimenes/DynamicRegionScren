/*
#include <stdlib.h>  // Para usar a função abs

// Função para o modo 4 (Color Difference Mode)
int PicFind_ColorDifferenceMode(
    unsigned int c,
    unsigned int n,
    unsigned int *Bmp,
    int Stride,
    int sw,
    int sh,
    unsigned char *ss ) {  // Alterado para unsigned char

    // Variáveis para as componentes R, G, B da cor especificada
    int r, g, b;

    // Variáveis para as componentes R, G, B do limiar de diferença de cor
    int rr, gg, bb;

    // Variáveis para iteração
    int x, y, o, i;

    // Extrai os componentes R, G, B da cor especificada
    r = (c >> 16) & 0xFF;
    g = (c >> 8) & 0xFF;
    b = c & 0xFF;

    // Extrai os componentes R, G, B do limiar de diferença de cor
    rr = (n >> 16) & 0xFF;
    gg = (n >> 8) & 0xFF;
    bb = n & 0xFF;

    // Itera sobre a área de busca na imagem
    o = 0;
    for (y = 0; y < sh; y++) {

        for (x = 0; x < sw; x++, o++) {  // Incremento por 1, pois Bmp[o] já é um uint

            // Calcula o índice do pixel no vetor ss
            i = y * sw + x;

            // Calcula a diferença de cor entre o pixel atual e a cor de referência
            int diff_r = ((Bmp[o] >> 16) & 0xFF) - r;  // Red
            int diff_g = ((Bmp[o] >> 8) & 0xFF) - g;   // Green
            int diff_b = (Bmp[o] & 0xFF) - b;          // Blue

            // Verifica se a diferença de cor está dentro do limiar especificado
            if (diff_r <= rr && diff_r >= -rr &&
                diff_g <= gg && diff_g >= -gg &&
                diff_b <= bb && diff_b >= -bb) {
                
                // Define o valor correspondente no vetor ss como 1
                ss[i] = 1;
            } else {
                // Define o valor correspondente no vetor ss como 0
                ss[i] = 0;
            }
        }
        o += (Stride / 4) - sw;  // Ajusta o offset para pular o padding no final de cada linha, se houver
    }

    // Retorna código de sucesso
    return 0; // OK
}


int NumPut( int sw, int sh, unsigned int *Bmp ) {


     // Variáveis para iteração
    int x, y, o, i;
    
    o = 0;
    for (y = 0; y < sh; y++) {

        for (x = 0; x < sw; x++, o++) {  // Incremento por 1, pois Bmp[o] já é um uint

            // Calcula o índice do pixel no vetor ss
            i = y * sw + x;

            // Calcula a diferença de cor entre o pixel atual e a cor de referência
            int diff_r = ((Bmp[o] >> 16) & 0xFF) - r;  // Red
            int diff_g = ((Bmp[o] >> 8) & 0xFF) - g;   // Green
            int diff_b = (Bmp[o] & 0xFF) - b;          // Blue

            // Verifica se a diferença de cor está dentro do limiar especificado
            if (diff_r <= rr && diff_r >= -rr &&
                diff_g <= gg && diff_g >= -gg &&
                diff_b <= bb && diff_b >= -bb) {
                
                // Define o valor correspondente no vetor ss como 1
                ss[i] = 1;
            } else {
                // Define o valor correspondente no vetor ss como 0
                ss[i] = 0;
            }
        }
        o += (Stride / 4) - sw;  // Ajusta o offset para pular o padding no final de cada linha, se houver
}



*/

c := 4288008348
sw := 19200
sh := 10800

Scan := Buffer( sw * sh * 4. 0 )

loop sw * sh {
    NumPut( "UInt", RandomColor(), Scan, 4 * ( A_Index - 1) )
}

MsgBox( "Ok!" )

n := 0x89CCAF00
;Scan := 0
;ss := Buffer( 16, 0 )


Hex := "4157415641554154555756534883ec388b8424a00000004189cb4189d20fb6f5440fb6f941c1eb100fb6ca0fb6ee41c1ea108b9424a8000000894c2428450fb6db450fb6d24c8984249000000085d20f8e0b0100004585c9418d5103440f48ca41c1f90244894c240c85c00f8eef0000004863f883e801f7d94c8bb424b0000000488944241889e84531ed4531e448897c2410f7d84c89c74883c70489442408894c242c48897c24204489d7f7df6690488b8c24900000004963c5896c2404488d1481488b4c242048034424184c8d0c814c89f1eb1a662e0f1f8400000000004883c204c601004883c1014c39ca74508b1a89d8c1e8100fb6c04429d84139c27cde0fb6ef4189e84129f039c77fd144394424047cca0fb6db4429fb44394424087fbd395c24287cb7395c242c7fb14883c204c601014883c1014c39ca75b1908b6c24044183c40144036c240c4c037424104439a424a80000000f8550ffffff31c04883c4385b5e5f5d415c415d415e415fc3"

code := MCode( Hex )
/*
int PicFind_ColorDifferenceMode(
    unsigned int c,
    unsigned int n,
    unsigned int *Bmp,
    int Stride,
    int sw,
    int sh,
    unsigned int *ss )


result :=
DllCall(
    code,
    "UInt", c,
    "UInt", n,
    "Ptr", Bmp.Ptr,
    "Int", Stride,
    "Int", sw,
    "Int", sh,
    "Ptr", ss.Ptr,
    "Int"
)

loop 4
    MsgBox( NumGet( ss, 4 * ( A_Index -  1) , "Uint" ) )


*/
#x:: {

    global
    time := A_TickCount
    GetbiBitCount()
    ;sh := 2
    ;sw := 600

    GetStride( sw )

    ss := Buffer( sh * sw, 0 )
    
    ;GetBitsFromScreen( 300, 300, sw, sh )
    code := MCode( Hex )

    result := Call( code, c, n, Scan, ss, sw, sh, Stride )

    if !result
        MsgBox( (A_TickCount - time) // 1000 ) ; Viso( ss, sh, sw )
}

Esc::ExitApp()

Call(
    code,
    c,
    n,
    Bmp,
    ss,
    sw,
    sh,
    Stride
)
{

    result :=
    DllCall(
        code,
        "UInt", c,
        "UInt", n,
        "UPtr", Bmp.Ptr,
        "Int", Stride,
        "Int", sw,
        "Int", sh,
        "UPtr", ss.Ptr,
        "Int"
    )

    /*
    DllCall(
        code,
        "Uint", c,
        "UInt", n,
        "UPtr", Bmp.Ptr,
        "Int", Stride,
        "Int", sh,
        "Int", sw,
        "Ptr", ss.Ptr,
        "Int"
    )
    */
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

    Viso( Scan, captureHeight, captureWidth )
}

GetStride( biWidth ) {
    global biBitCount
    ;global Stride
    if ( !IsSet( Stride ) ) {
        global Stride := ( ( biWidth * biBitCount + 31 ) & ~31 ) >> 3
    }
    
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
    FileAppend( Text "`n`n`n" text1, "C:\Users\morim\OneDrive\DynamicRegionScren\PicFind\NewTest 29.08.2024\VisoTest.txt")
    ;MsgBox( Text "`n`n`n" text1 )
}

; Função para gerar uma cor aleatória
RandomColor() {
    return (Random(0x000000, 0xFFFFFF) & 0xFFFFFFFF)
}