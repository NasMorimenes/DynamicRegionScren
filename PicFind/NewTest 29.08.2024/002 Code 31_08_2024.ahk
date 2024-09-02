
c := 4288008348
sw := 19200
sh := 10800

GetbiBitCount()
    ;sh := 2
    ;sw := 600

GetStride( sw )

Scan := Buffer( sw * sh * 4, 0 )
MsgBox( Stride )
RandomColorBuff( Scan, sw, sh, Stride )

;loop sw * sh {
;    NumPut( "UInt", RandomColor(), Scan, 4 * ( A_Index - 1) )
;}

MsgBox( "Ok!" )

n := 0x89CCAF00


Esc::ExitApp()

#x:: {

    global
    time := A_TickCount
    

    ss := Array()
    ss.Capacity := sh * sw
    
    ;GetBitsFromScreen( 300, 300, sw, sh )
    ;code := MCode( Hex )

    result := PicFind_ColorDifferenceMode( c, n, sw, sh, Scan, ss, Stride )
    if !result
        MsgBox( (A_TickCount - time) // 1000 ) ; Viso( ss, sh, sw )
}




PicFind_ColorDifferenceMode( c, n, sw, sh, Bmp, ss, Stride ) {

    i := 1
    x := 0
    y := 0
    o := 0

    r := (c >> 16) & 0xFF
    g := (c >> 8) & 0xFF
    b := c & 0xFF

    rr := (n >> 16) & 0xFF
    gg := (n >> 8) & 0xFF
    bb := n & 0xFF

    loop sh {

        loop sw {
            
            ;// Calcula a diferença de cor entre o pixel atual e a cor de referência
            cc := NumGet( Bmp, o, "UInt" )
            diff_r := ( ( cc >> 16) & 0xFF ) - r  ;// Red
            diff_g := ( ( cc >> 8 ) & 0xFF ) - g   ;// Green
            diff_b := ( cc & 0xFF ) - b          ;// Blue

            ;// Verifica se a diferença de cor está dentro do limiar especificado
            if (diff_r <= rr && diff_r >= -rr &&
                diff_g <= gg && diff_g >= -gg &&
                diff_b <= bb && diff_b >= -bb ) {
                
                ;// Define o valor correspondente no vetor ss como 1
                ss[i] := 1 
            } else {
                ;// Define o valor correspondente no vetor ss como 0
                ss[i] := 0
            }
            o += 4
        }
        o += (Stride / 4) - sw
    }
    return 0
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

RandomColorBuff( buff, sw, sh, Stride ) {

    Hex := "4157415641554154555756534883ec4844898424a000000089d64489cb4989cf31c9ff15000000004889c1e8000000008b8424a000000085c00f8ea600000085db448d7303440f49f341c1fe02448974242c85f60f8e8b000000498d47044531ed4531e448894424388d46ff48894424300f1f80000000004963c5488b5424384d8d34874803442430488d2c820f1f00e8000000004983c60489c3e800000000c1e31889c7e800000000c1e71089c681e70000ff00e800000000c1e6080fb6c00fb7f609c309fb09f341895efc4939ee75be4183c40144036c242c4439a424a0000000759331c04883c4485b5e5f5d415c415d415e415fc3"

    Code := MCode( Hex )

    return Call( Code, buff, sw, sh, Stride  )

    Call( code, buff, sw, sh, Stride  ) {
        ;buff, sw, sh, Stride ) {
        result :=
        DllCall(
            Code,
            "UPtr", Buff.Ptr,
            "Int", sw,
            "Int", sh,
            "Int", Stride,
            "int"
        )

        return result
    }

}

/*
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Função que gera uma cor aleatória no formato 0xAARRGGBB
int RandomColor( unsigned int* buffer, int sw, int sh, int Stride ) {

    unsigned int color,

    // Variáveis para iteração
    int x, y, o, i;

    for (y = 0; y < sh; y++) {

        for (x = 0; x < sw; x++, o++) {
            
            color = rand() & 0xFFFFFFFF;  // Gera um número aleatório de 32 bits (0x00000000 a 0xFFFFFFFF)
            buffer[o] = RandomColor();  // Preenche o buffer com cores aleatórias
        }
    }

    return 0;
   
}

// Função que preenche um buffer com cores aleatórias
void RandomColorBuffer(unsigned int* buffer, size_t size) {
    for (size_t i = 0; i < size; i++) {
        buffer[i] = RandomColor();  // Preenche o buffer com cores aleatórias
    }
}

