#Include MCode1.ahk
;#Include biBitCount.ahk
/**
 * 
 * @returns {String}
 * 
 * #Include MCode1.ahk\
 * code := MCode1( HexToDec() )\
 * CaracterHexadecimal := "d"\
 * Char := Ord( CaracterHexadecimal )\
 * Ass := DllCall( code, "Char", Char, "Int")\
 * MsgBox( Ass ) ;--> 13
 * 
 * // Função para converter um caractere\
 * // hexadecimal em valor decimal\
int hex_to_dec(char c) {\
    if (c >= '0' && c <= '9') return c - '0';\
    if (c >= 'a' && c <= 'f') return c - 'a' + 10;\
    if (c >= 'A' && c <= 'F') return c - 'A' + 10;\
    return -1;\
}
 */
HexToDec() {
    Hex :=
    (
        "8d41d03c0976298d419f3c05761a8d51bf8d41c9b9ffffffff80fa060fbec00f43c1c30f1f44000083e9570fbec1c3"
        "900fbec0c3"
    )

    Code := MCode1( Hex )

    return Code
}



/**
 * 
 * @returns {String} 
 * #Include MCode1.ahk\
code := MCode1( HexPairToByte() )\
CaracterHexadecimal1 := "3"\
CaracterHexadecimal2 := "c"\
Char1 := Ord( CaracterHexadecimal1 )\
Char2 := Ord( CaracterHexadecimal2 )\
Ass :=\
DllCall(\
    code,\
    "char", Char1,\
    "char", Char2,\
    "uchar"\
)\
MsgBox( Ass )
 */
HexPairToByte() {

    Hex :=
    (
        "31c0448d41d04488c04180f809760f448d419f4180f805771f83e95788c88d4ad080f909772988cc89c20fbec4c1e2"
        "0409d0c30f1f440000448d41bf4180f80577dc83e93788c88d4ad080f90976d78d4a9f80f905771083ea5788d489c2"
        "0fbec4c1e20409d0c38d4abf80f90577b983ea3788d489c20fbec4c1e20409d0c3"
    )

    Code := MCode1( Hex )

    return Code
}


ModeProcessColor() {
    Hex := "4157415641554154555756534883ec28448ba424b800000089d78b9424a000000089cb4489c5410fafd185d28d42070f49c28b9424a8000000c1f803f7d8038424b00000008944240c85d20f8e2a0100004585c9418d4107c74424040000000041bdfe050000440f48c88b8424a0000000c7442408000000004531ff4489ce83e801c1fe0389f1897424144c63f6488bb424980000000fafc8488d4406014889442418894c2410660f1f8400000000008b8424a000000085c00f8e8c00000048637424084c8b9424980000004d63c74c038424900000004901f2480374241890410fb65002410fb64001410fb6084189d301da29f84129db0fafc0448d8a0004000029e9450fafcbc1e00b450fafcb4401c84589e94129d14489ca0fafd10fafca01c14439e1410f9e024983c2014d01f04c39d675aa8bb424a00000000174240844037c241444037c2410834424040144037c240c8b442404398424a80000000f854affffff8b4424084883c4285b5e5f5d415c415d415e415fc3c744240800000000ebe1"
    /*
    (
        "4157415641554154555756534881ec980100000f29b424f00000000f29bc2400010000440f29842410010000440f29"
        "8c2420010000440f29942430010000440f299c2440010000440f29a42450010000440f29ac2460010000440f29b424"
        "70010000440f29bc2480010000448ba424080200008b8424180200008bac242002000089cb8b8c241002000089d744"
        "89c6428d14a5000000004c898c24f801000029d085c90f8e2c0800004585e40f8e23080000458d7424ff4c63c0660f"
        "6efb01d0428d0cb500000000660f70ff004d89cf898424c00000004863c90f29bc24d0000000660f6eff66440f6f15"
        "00000000498d4c08044d63c4660f70ff004489b424c400000048898c24b00000004489f14a8d0485ffffffff4183e6"
        "f0c1e90448898424b80000004489e048c1e1060f297c2460660f6efe48c1e002660f70ff0048898c24e0000000428d"
        "0cb5000000000f297c2470660f6efd4c898424a8000000660f70ff004489b424c8000000898c24cc000000c784249c"
        "00000000000000c78424a000000000000000c78424a40000000000000048898424e80000000f29bc24800000000f1f"
        "0048639424a0000000488b8424000200004801d048039424a800000048039424000200004c39fa488b9424b8000000"
        "0f96c14c01fa4839d00f93c208d10f845e07000083bc24c40000000f0f8650070000488b8c24e00000004c89fa6645"
        "0fefff66440f6fb424d00000004c01f90f1f00f30f6f0af30f6f224883c2404883c010f30f6f42d0f30f6f52f06641"
        "0f6ff266450fefdb66410fdbca660f71d40866440f6f44246066410fdbc266410fdbd2660f67c8f30f6f42e0660fdb"
        "f1660f71d10866410fdbc2660f67c266410f6fd2660fdbd0660f71d008660f67c8f30f6f42d0660f67f2f30f6f52f0"
        "66440f6fc966410f68cb660f71d008660f71d20866440f6fe1660f67e0f30f6f42e066410f69cf66450f61e7660f6f"
        "d966410fdbe266410f6ffc660f71d00866410ffade66410ffafe660f67c20f295c241066450f60cb66450ffee66641"
        "0fdbc20f293c2466450f6fe966450f69cf660f67e066450f61ef66410f6fd1660f6fdc66410f68e366410f6fc56641"
        "0f60db660f6ffc66410f69e7660f6feb66410f61ff66410f69df66410f61ef66410ffad866410ffaf866410ffae866"
        "410ffae066440f6fc60f297c242066450f60c366410f68f30f2964243066440f6f5c247066410f6fe0660f6ffe6645"
        "0f61c766410f69e766410f61ff66410f69f766450ffac366410ffae366410ffafb66410ffaf366440f6f1d10000000"
        "66410ffac666450ffeee0f29742440660f6ff166450ffedd66410ffef6660f6fc80f29742450660f73d12066410f6f"
        "f366450ffece66410f73d320660ff4f066410ffad666440ff4d9660f70f60866450f70db0866410f62f366440f6fdd"
        "660ff4c6660f73d62066440ff4dd660ff4f1660f6f0d20000000660f73d520660ff4ed66410ffacd66440f6fac2480"
        "000000660f70c008660f70f608660f62c666410f70f30866450f6fd8660f70ed0866410f73d320660f62f5660f6fe9"
        "660f72f60b66410ff4e8660ffec6660f6ff1660f6f0d10000000660f73d62066410ff4f366410ffec9660f70ed0866"
        "0f70f608660f62ee660f6ff166440ff4c5660f73d52066410ff4eb660f73d62066450f70c008660f70ed0866440f62"
        "c5660f6fe9660f6fcc660ff4ea660f73d12066410ffec066440f6fc266410f66c5660fdf053000000066410f73d020"
        "66410ff4f0660f70ed08660f70f608660f62ee660f6f3424660ff4d5660f73d52066410ff4e8660f70d208660f70ed"
        "08660f62d5660f6feb660ff4eb660f73d320660ff4db660f70ed08660f70db08660f62eb660f72f50b660ffed5660f"
        "6f2d2000000066410ffae9660f6fdd660f73d520660ff4dc660ff4e9660f70db08660f70ed08660f62dd660f6f2d20"
        "000000660ff4e3660f73d320660ff4d9660f6fc866410ffaec660f70e408660f70db08660f62e3660ffed466410f66"
        "d5660fdf1530000000660f61c2660f69ca660f6fd0660f61c1660f69d1660f6f0d10000000660f61c2660f6fd66641"
        "0ffecc66410fdbc2660ff4d1660f6fd9660f6fce660f73d120660f73d320660ff4d9660f70d208660f70db08660f62"
        "d3660f6fde660f6f742420660ff4da660f73d220660ff4d1660f6fce660f73d120660f6fe1660ff4e1660f6f0d1000"
        "0000660f70db08660f70d208660f62da660f6fd6660ff4d6660f6f742450660f70e408660ffece660f70d208660f62"
        "d4660f72f20b660ffeda660f6fd5660ff4d7660f73d520660f6fe2660f6fd7660f73d220660f70e408660ff4ea660f"
        "70ed08660f62e5660ff4fc660f73d420660ff4e2660f70d708660f6f7c2410660f70e408660f6fef660f62d4660ff4"
        "e9660ffed3660f6fd9660f73d32066410f66d5660fdf1530000000660f6fe5660f6fef660f73d520660f70e408660f"
        "f4dd660f70db08660f62e3660f6fdf660ff4dc660f73d420660ff4e5660f70db08660f70e408660f62dc660f6f6424"
        "30660f6fec660ff4ec660f73d420660ff4e4660f70ed08660f70e408660f62ec660f6fe5660f6f2d20000000660f6f"
        "7c2440660f72f40b660ffaee660ffedc660f6ff7660f6fe7660f73d620660ff4e5660f73d520660ff4ee660f70cc08"
        "660f6fe7660f70ed08660f62cd660ff4e1660f73d120660ff4ce660f70e408660f70c908660f62e1660f6fca660ffe"
        "dc66410f66dd660fdf1d30000000660f61d3660f69cb660f6fda660f61d1660f69d9660f61d366410fdbd2660f67c2"
        "0f1140f04839ca0f8526faffff8b8424c8000000448b9424a000000041befe050000448b8424a400000044038424cc"
        "0000004101c24d63c04c038424f80100004d63d24c039424000200004429d04189c5662e0f1f840000000000410fb6"
        "5002410fb64001410fb6084189d301da29f84129db0fafc0448d8a0004000029f1450fafcbc1e00b450fafcb4401c8"
        "4589f14129d14489ca0fafd10fafca01c139cd410f9d024983c2014983c004438d4415004139c47fa58384249c0000"
        "00018b9424c00000004401a424a00000008b84249c000000019424a40000004c03bc24b0000000398424100200000f"
        "85d3f8ffff0f28b424f00000000f28bc2400010000440f28842410010000440f288c2420010000440f289424300100"
        "00440f289c2440010000440f28a42450010000440f28ac2460010000440f28b42470010000440f28bc248001000048"
        "81c4980100005b5e5f5d415c415d415e415fc30f1f8000000000488b8c24e800000041bdfe0500004e8d34394c89f9"
        "0f1f00440fb641020fb65101440fb6094589c34101d829fa4129db0fafd2458d90000400004129f1450fafd3c1e20b"
        "450fafd34401d24589ea4529c2450fafd1450fafca4101d14439cd0f9d004883c1044883c0014c39f175a9e9dffeff"
        "ff90909090ff00ff00ff00ff00ff00ff00ff00ff0000040000000400000004000000040000fe050000fe050000fe05"
        "0000fe05000001000000010000000100000001000000"
    )
    */
    Code := MCode1( Hex )

    return Code
}

/*

colors := [
    0x00, 0x00, 0xFF,  ; Vermelho -> BGR: Azul (0x00), Verde (0x00), Vermelho (0xFF)
    0x00, 0xFF, 0x00,  ; Verde -> BGR: Azul (0x00), Verde (0xFF), Vermelho (0x00)
    0xFF, 0x00, 0x00,  ; Azul -> BGR: Azul (0xFF), Verde (0x00), Vermelho (0x00)
    0xFF, 0xFF, 0x00,  ; Ciano -> BGR: Azul (0xFF), Verde (0xFF), Vermelho (0x00)
    0x00, 0xFF, 0xFF,  ; Amarelo -> BGR: Azul (0x00), Verde (0xFF), Vermelho (0xFF)
    0xFF, 0x00, 0xFF,  ; Magenta -> BGR: Azul (0xFF), Verde (0x00), Vermelho (0xFF)
    0x80, 0x80, 0x80,  ; Cinza -> BGR: Azul (0x80), Verde (0x80), Vermelho (0x80)
    0x00, 0x00, 0xFF,  ; Vermelho -> BGR: Azul (0x00), Verde (0x00), Vermelho (0xFF)
    0x00, 0xFF, 0x00,  ; Verde -> BGR: Azul (0x00), Verde (0xFF), Vermelho (0x00)
    0xFF, 0x00, 0x00,  ; Azul -> BGR: Azul (0xFF), Verde (0x00), Vermelho (0x00)
    0x00, 0xFF, 0xFF,  ; Amarelo -> BGR: Azul (0x00), Verde (0xFF), Vermelho (0xFF)
    0xFF, 0xFF, 0xFF,  ; Branco -> BGR: Azul (0xFF), Verde (0xFF), Vermelho (0xFF)
    0xFF, 0x00, 0xFF,  ; Magenta -> BGR: Azul (0xFF), Verde (0x00), Vermelho (0xFF)
    0x80, 0x80, 0x80,  ; Cinza -> BGR: Azul (0x80), Verde (0x80), Vermelho (0x80)
    0x00, 0x00, 0xFF,  ; Vermelho -> BGR: Azul (0x00), Verde (0x00), Vermelho (0xFF)
    0xFF, 0xFF, 0x00,  ; Ciano -> BGR: Azul (0xFF), Verde (0xFF), Vermelho (0x00)
    0x00, 0xFF, 0x00,  ; Verde -> BGR: Azul (0x00), Verde (0xFF), Vermelho (0x00)
    0xFF, 0x00, 0x00,  ; Azul -> BGR: Azul (0xFF), Verde (0x00), Vermelho (0x00)
    0xFF, 0x00, 0xFF,  ; Magenta -> BGR: Azul (0xFF), Verde (0x00), Vermelho (0xFF)
    0x00, 0xFF, 0xFF,  ; Amarelo -> BGR: Azul (0x00), Verde (0xFF), Vermelho (0xFF)
    0x00, 0x00, 0x00,  ; Preto -> BGR: Azul (0x00), Verde (0x00), Vermelho (0x00)
    0xFF, 0xFF, 0xFF,  ; Branco -> BGR: Azul (0xFF), Verde (0xFF), Vermelho (0xFF)
    0x80, 0x80, 0x80,  ; Cinza -> BGR: Azul (0x80), Verde (0x80), Vermelho (0x80)
    0xFF, 0xFF, 0x00,  ; Ciano -> BGR: Azul (0xFF), Verde (0xFF), Vermelho (0x00)
    0x00, 0xFF, 0xFF   ; Amarelo -> BGR: Azul (0x00), Verde (0xFF), Vermelho (0xFF)
]

bmp := Buffer( 5 * 16, 0)
i := 1
J := 16
Loop ( 5 * 16 ) {
    
    if ( A_index < j ) {
        NumPut( "Uchar", colors[ i ], bmp, A_Index - 1 )
        i++
    }
    else {
        NumPut( "Uchar", 0, bmp, A_Index - 1 )        
        j += 16
    }
    
}

rr := 0x00 ;
gg := 0xFF ;
bb := 0x00 ; 
bpp := 24

sw := 5
sh := 5
n := 10000

ss := Buffer( sw * 5 , 0 )

code := ModeProcessColor()
result :=
DllCall(
code,
    "Int", bb,
    "Int", gg,
    "Int", rr,
    "Int", bpp,
    "Uchar*", Bmp.Ptr,
    "Uchar*", ss.Ptr,
    "Int", sw,
    "int", sh,
    "Int", 16,
    "Int", n   
)
MsgBox( result )

if ( result ) {
    loop sw * 5 {
        MsgBox( NumGet( ss, A_Index - 1, "Char") )
    }
    ExitApp()
}
else {
    ExitApp()
}
*/
Esc::ExitApp()

/**
 * pic - Realiza a busca de uma cor de referência em uma imagem e armazena as posições e cores correspondentes.
 *
 * @param c       Cor de referência a ser encontrada (no formato 0xRRGGBB).
 * @param n       Número de cores no array `cors` para comparação com os pixels da imagem.
 * @param text    Ponteiro para os dados da imagem (provavelmente em formato RGBA ou RGB).
 * @param w       Largura da imagem (em pixels).
 * @param h       Altura da imagem (em pixels).
 * @param Stride  Número de bytes por linha da imagem, incluindo qualquer padding.
 * @param s1      Array de saída para armazenar as posições dos pixels que não correspondem à cor de referência.
 * @param s0      Array de saída para armazenar as cores dos pixels que não correspondem à cor de referência.
 * @param new_w   Nova largura ajustada da imagem (usada para cálculos de posição).
 * @param new_h   Nova altura ajustada da imagem (usada para cálculos de posição).
 *
 * A função `pic` percorre cada pixel da imagem especificada pelo ponteiro `text`, 
 * comparando a cor de cada pixel com uma lista de cores de referência armazenadas em `cors`. 
 * Se a cor de um pixel corresponder a uma das cores em `cors`, a função retorna imediatamente 
 * com o valor -1, indicando que uma correspondência foi encontrada.
 * 
 * Se a cor do pixel não corresponder a nenhuma das cores de referência, a função armazena 
 * a posição do pixel no array `s1` e a cor do pixel no array `s0`.
 * 
 * Após processar todos os pixels, a função retorna 0, indicando que todas as cores foram 
 * processadas sem encontrar uma correspondência.
 *
 * @return int    Retorna -1 se uma correspondência for encontrada, ou 0 se nenhuma correspondência for encontrada.
 *
 *int pic( \
 *    unsigned int c,\
 *    unsigned int n,\
 *    unsigned char *text,\
 *    int w, int h,\
 *    int Stride,\
 *    unsigned int *s1, \
 *    unsigned int *s0,\
 *    int new_w, \
 *    int new_h) \
 *{\
 *    int k, r, g, b, rr, gg, bb, dR, dG, dB;\
 *    int x, y, o = 0, i, len1 = 0, len0 = 0;\
 *    unsigned int *cors;\
 *    \
 *    if (k = (c != 0)) { // FindPic\
 *\
 *        cors = (unsigned int*)(text + w * h * 4); // Ponteiro para o array de cores `cors`\
 *\
 *        // Extrai os componentes RGB da cor de referência `c`\
 *        r = (c >> 16) & 0xFF;\
 *        g = (c >> 8) & 0xFF;\
 *        b = c & 0xFF;\
 *\
 *        // Calcula os quadrados dos componentes RGB da cor de referência\
 *        dR = r * r;\
 *        dG = g * g;\
 *        dB = b * b;\
 *\
 *        // Loop sobre cada linha da imagem\
 *        for (y = 0; y < h; y++) {\
 *\
 *            // Loop sobre cada pixel da linha\
 *            for (x = 0; x < w; x++, o += 4) {\
 *\
 *                // Obtém os componentes RGB do pixel atual\
 *                rr = text[2 + o];\
 *                gg = text[1 + o];\
 *                bb = text[o];\
 *\
 *                // Compara o pixel atual com cada cor no array `cors`\
 *                for (i = 0; i < n; i++) {\
 *\
 *                    // Extrai os componentes RGB da cor atual no array `cors`\
 *                    unsigned int currentColor = cors[i];\
 *                    r = ((currentColor >> 16) & 0xFF) - rr;\
 *                    g = ((currentColor >> 8) & 0xFF) - gg;\
 *                    b = (currentColor & 0xFF) - bb;\
 *\
 *                    // Se o pixel corresponder à cor de referência, retorne -1\
 *                    if (r * r <= dR && g * g <= dG && b * b <= dB) {\
 *                        return -1;\
 *                    }\
 *                }\
 *\
 *                // Armazena a posição do pixel e sua cor se não houver correspondência\
 *                s1[len1] = (y * new_h / h) * Stride + (x * new_w / w) * 4;\
 *                s0[len1++] = (rr << 16) | (gg << 8) | bb;\
 *            }\
 *        }\
 *    }\
 *\
 *    // Retorna 0 após processar todos os pixels sem encontrar correspondências\
 *    return 0;\
 *}
*/
myPic() {

    Hex :=
    (
        "4157415641554154555756534883ec28895424784589ce85c90f84810100008b8424900000000fb6dd0fb6f90fafdb"
        "410fafc14189c98b8c249000000041c1e9100fafff450fb6c9c1e002450fafc94863f04889342485c90f8e42010000"
        "89d0c74424180000000031d283e801c744241c000000004d8d54800431c04901f2418d760148897424104585f60f8e"
        "e30000008d6801480344241083c2044531ed48894424084863ed4863f28b442478410fb64c30fe450fb65c30fd450f"
        "b66430fc85c07448488b04244d8d3c000f1f4000418b1789d0c1e8100fb6c029c80fafc04439c87f1e0fb6c64429d8"
        "0fafc039d87f110fb6d24429e20fafd239fa0f8eb50000004983c7044d39fa75c48b442418c1e11041c1e3084409d9"
        "994109cc488b8c24a8000000f7bc24900000000faf8424980000004189c74489e84403ac24b00000009941f7fe488b"
        "9424a0000000418d04878944aafc4863c589f24883c604448964a9fc4883c50148396c24080f8536ffffff8344241c"
        "01448b9c24b80000008b74241c44015c241839b424900000000f85f1feffff660f1f84000000000031c04883c4285b"
        "5e5f5d415c415d415e415fc30f1f440000b8ffffffffebe3"
    )

    Code := MCode1( Hex )

    return Code
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

;Stride := GetStride( sw )

ColorDifferenceAhk( c, n, pBmp, pss, sy, sx, sw, sh) {
    
    GetbiBitCount()
    global Stride
    ( IsSet( Stride ) && GetStride( 32 ) )
    
    o := sy * Stride + sx * 4
    j := Stride - sw * 4

    rr := ( c >> 16 ) & 0xFF
    gg := ( c >> 8 ) & 0xFF
    bb := c & 0xFF

    r := ( n >> 16 ) & 0xFF
    g := ( n >> 8 ) & 0xFF
    b := n & 0xFF

    dR := r * r
    dG := g * g
    dB := b * b
    
    loop sh {
        
        loop sw {

            r := NumGet( pBmp, 2 + o, "UChar" ) - rr
            g := NumGet( pBmp, 1 + o, "UChar" ) - gg
            b := NumGet( pBmp,     o, "UChar" ) - bb

            aSS := ( r * r <= dR && g * g <= dG && b * b <= dB ) ? 1 : 0 

            NumPut( "UChar", aSS, pss, A_Index - 1  ) 
            o += 4
        }
        o += j
    }
}

/*
// (mode==3) Color Difference Mode
void ColorDifference( int c, int n, unsigned char *Bmp, unsigned char *ss, int sy, int sx, int sw, int sh, int Stride ) {

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
}

*/


GetbiBitCount()

;colors2 := [ 255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158, 0, 0,
;             255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158, 0, 0,
;	         255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158, 0, 0,
 ;            255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158, 0, 0,
;	         255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158, 0, 0,
;	         255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158, 0, 0,
;	         255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158, 0, 0,
;	         255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158, 0, 0,
;	         255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158, 0, 0,
;	         255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158,  255,93,158, 0, 0
;]
;

;Stride2 := 
GetStride( 10 )
;MsgBox( Stride2 )
;12  ; 3 pixels * 4 bytes por pixel

c := 0xFF929E          ; Cor vermelha pura
n := 0xFF569E          ; Limite de diferença
sw := 10               ; Largura da sub-região
sh := 10               ; Altura da sub-região
sy := 0                ; Coordenada y inicial
sx := 0                ; Coordenada x inicial


; Alocar buffers
;MsgBox( Stride )

;Bmp2 := Buffer( Stride * sh , 0) ; Buffer de imagem
ss2 := Buffer( sw * sh, 0)       ; Buffer de saída

;MsgBox( Bmp2.Ptr )
; Preencher Bmp2 com colors2
;Loop (Stride * sh) {
;    NumPut( "Uchar", colors2[ A_Index ], Bmp2, ( A_Index - 1) )
;}

Scan := 0

GetBitsFromScreen( 50,50, 10, 10 )


;MsgBox( "Numget" NumGet( Bmp2, 1, "Uchar") )
; Chamar a função via DllCall
code := ColorDifference()
;gf :=

;ss2 := Buffer( sw * sh, 0 )

;;;;;;;;;;;;;;;;;;Scan := 0
;;;;;;;;;;;;;;;;;;GetBitsFromScreen( 40, 40, sw, sh )

;MsgBox( scan )
;loop sw * sh
    ;MsgBox c := NumGet( Scan, 4 * (A_Index - 1), "UInt" )

;;;;;;;;;;;;;;;;;ColorDifferenceAhk( c, n, scan, ss2, sy, sx, sw, sh )


;unsigned int c, unsigned int n, unsigned char *Bmp, int Stride,
;                                 int sw, int sh, char *ss
DllCall(
    code,                  ; Ponteiro para o código de máquina da função
    "UInt", c,              ; Cor de referência
    "UInt", n,              ; Limite de diferença
    "UPtr", Scan.Ptr,           ; Buffer de imagem
    "Int", Stride,  
    "Int", sw,             ; Largura da sub-região
    "Int", sh,             ; Altura da sub-região
    "Ptr", ss2.Ptr         ; Stride (bytes por linha)
)

;MsgBox( gf )

loop sw * sh {
    MsgBox( NumGet( ss2.Ptr, A_Index - 1, "UChar")  "`nIndice - " A_Index - 1 )
}
; Exibir resultados
;MsgBox("Resultados para Cenário 2: " ss2.RawData )

ColorDifference() {

    Hex := "4157415641554154555756534881ec380100000f29b424900000000f29bc24a0000000440f298424b0000000440f298c24c0000000440f299424d0000000440f299c24e0000000440f29a424f0000000440f29ac2400010000440f29b42410010000440f29bc24200100008bbc24a00100000fb6c589cd89d34c898424900100004189c48b8424a8010000c1ed100fb6f6c1eb10400fb6ed440fb6e9440fb6f20fb6db85c00f8eea04000085ff0f8ee20400008d04bd000000008d57ff660f6ec54863cf4898660f61c08994248c0000004c8b9424b0010000488944247089d0660f70e00066410f6ec4c1e804660f61c048894c246866440f6f3d0000000048c1e004660f70e8000f296424304989c789d00f296c244083e0f0c744245c000000008d1485000000004889442478488d048dffffffff89942488000000c74424580000000048898424800000000f1f008b44245c8d0c8500000000488b8424800000004c01c04939c2488b4424680f93c24c01d04939c048894424600f93c008c20f848104000083bc248c0000000f0f867304000066410f6ec5660f6eeb66450fefd231c0660f61c066440f70f50066410f6eee660f70e00066440f70dd00660fefed0f29642420660f6ee666440f70ec00660fefe466410f6ff566450f6fee66440f6ff60f1f00f3410f6f3c8066410f6ff7f3410f6f448010f3410f6f4c8030f3410f6f54803066410fdbc766410fdbff660f6f5c243066440f6f642420660f67f8f3410f6f44802066410fdbcf660fdbf7660f71d70866410fdbc7660f71d208660f67c166410f6fcf660fdbc8660f71d008660f67f1660f67f8f3410f6f0c80f3410f6f44801066440f6fc766410f68fa660f71d008660f71d10866450f60c2660f67c8f3410f6f44802066440ff9c3660ff9fb66410fdbcf660f71d008660f67c2660f6f54244066410fdbc7660f67c8660f6fc566410ff9c0660f6fd966410f68ca66440feec0660f6fc566410f60da660ff9c7660ff9da660feef8660f6fc5660ff9ca660ff9c3660f6fd666410f68f2660feed8660f6fc566410f60d2660ff9c166410ff9d4660feec8660f6fc566410ff9f4660ff9c266450f6fe0660feed0660f6fc5660ff9c6660feef0660f6fc566410f65c066440f61e00f290424660f6fc366440f69042466450f6fcc66450f66cd66450f66c566450f6fe166440f76c466440f6fcd66440f65cb66440f76e466410f61c1440f294c2410660f695c241066440f6fc866450f66ce66410f66de66410f6fc1660f76dc660f76c466440fdbc366440fdbe0660f6fc266450f6fcc66440f6fe566440f65e266410f69d466410f61c466440f6fe566410f66d366410f66c366440f65e7660f6fda660f76c4660f76dc66410fdbc166440f6fcd66410fdbd866440f65c9660f6fd0660f61c3660f69d3660f6fd8660f61c2660f69da660f61c3660f6fdf66410f69fc66410f61dc66410f66fd66410fdbc766410f66dd660f76fc660f76dc66440f6fc3660f6fd966410f69c966410f61d966410f66ce66410f66de660f76cc660f6fd366410f6fd866440f6fc5660f76d466440f65c6660fdbf9660fdbda660f6fd666410f69f066410f61d066410f66f366410f66d3660f76f4660f76d4660fdbfe660fdbd3660f6fca660f61d7660f69cf660f6fda660f69d9660f61d1660f61d366410fdbd7660f67c2660fdb0510000000410f1104024883c0104939c70f8504fdffff8b8424880000008d1401488b4c24784863d24803942490010000eb1141c6040a004883c1014883c20439cf7e600fb6420229e84189c141c1f91f4431c84429c839c30fb64201410f9dc34429e04189c141c1f91f4431c84429c839c60f9dc04184c374b80fb6024429e84189c141c1f91f4431c84429c84139c67ca041c6040a014883c1014883c20439cf7fa083442458014c8b542460017c245c8b4424584c03442470398424a80100000f85bbfbffff0f28b4249000000031c00f28bc24a0000000440f288424b0000000440f288c24c0000000440f289424d0000000440f289c24e0000000440f28a424f0000000440f28ac2400010000440f28b42410010000440f28bc24200100004881c4380100005b5e5f5d415c415d415e415fc30f1f44000089f84c89c24d8d0c80eb1a0f1f44000041c602004883c2044983c2014939d10f8444ffffff0fb642014429e089c1c1f91f31c829c839c60fb64202410f9dc329e889c1c1f91f31c829c839c30f9dc04184c374bc0fb6024429e889c1c1f91f31c829c84139c67ca841c60201eba690909090909090909090ff00ff00ff00ff00ff00ff00ff00ff0001010101010101010101010101010101"
    /*
    (
            "4157415641554154555756534881ec380100000f29b424900000000f29bc24a0000000440f298424b000000044"
            "0f298c24c0000000440f299424d0000000440f299c24e0000000440f29a424f0000000440f29ac240001000044"
            "0f29b42410010000440f29bc24200100008b8424a8010000448b9424a00100000fb6f64d89cf4189d10fb6d20f"
            "afd24189cb41c1f9100fb6ed41c1fb100fb6c9450fb6c94c89c3894c246c450fafc9450fb6db0faff689542464"
            "85c00f8e7d0500004585d20f8e740500004963c266410f6ec34531f6c7442468000000004889442478498d4480"
            "ff660f61c066440f6f25000000004889842480000000418d42ff660f70e80089c78984248c00000083e0f08984"
            "2488000000c1e002c1ef0448980f296c2430660f6eed48c1e706660f70ed004c01c04c01c70f296c2440660f6e"
            "e94889442470660f70ed000f296c24500f1f4400004963d6498d041748035424784c01fa4839d30f93c1483984"
            "24800000000f96c208d10f845004000083bc248c0000000f0f864204000066410f6ee94889da66450fefff660f"
            "70ed0066450fefc90f292c24660f6eee660f70ed000f296c2410660f6e6c2464660f70ed000f296c242090f30f"
            "6f0af30f6f421066410f6fdc4883c240f30f6f52e0f30f6f62f04883c01066410fdbc466410fdbcc660f6f6c24"
            "30660f6f742440660f67c8f30f6f42f066410fdbd466440f6f442450660f71d40866410fdbc4660f67d066410f"
            "6fc4660fdbda660f71d208660fdbc1660f71d108660f67c3f30f6f5ad0660f67caf30f6f52c0660f71d3086644"
            "0f6fd1660f71d208660f67d3f30f6f5ae066410fdbd4660f71d308660f67dc660fefe466410fdbdc66440f60d4"
            "660f68cc660f67d366440ff9d5660ff9cd660f6fda660f68d466450f6fda660f60dc66450fd5da660f6fea6641"
            "0f69d7660f6ffb66410f61ef66440f6ff2660f6fd066410f61ff660f60d4660f68c466410f69df660ffafe660f"
            "fade660f6fe0660ffaee66440ffaf6660f6ff266410f61f766410f69d766410f61e766410f69c766410ffaf066"
            "410ffad066410ffae066410ffac066440f6fc766440ff4c7660f73d72066450f6feb660ff4ff66450fe5d26645"
            "0f70c008660f70ff0866450f61ea66450f69da66440f6f54241066440f62c766440f662c24660f6ffe660ff4fe"
            "660f73d620660ff4f666440f6644241066450f76e966450f76c1660f70ff08660f70f608660f62fe660f6ff366"
            "450fdbe866440f6f442420660ff4f3660f73d320660ff4db66410f66f866410f76f9660f70f608660f70db0866"
            "0f62f3660f6fda66440fdbef660f6f3c24660ff4da660f73d220660ff4d266440f66df66410f66f266450f76d9"
            "660f70db0866410f76f1660f70d208660f62da66410f6fd566410f66d866440fdbde66410f76d966440fdbdb66"
            "450f61eb66410f69d366410f6fdd66440f61ea660f69da660f6fd5660ff4d5660f73d52066440f61eb660ff4ed"
            "660f6fd966450fdbec660fd5d9660fe5c9660f70d208660f70ed08660f6ff3660f62d5660f6fec660ff4ec660f"
            "61f1660f69d9660f73d420660f66f766410f6fce660ff4e466410f66d266410ff4ce660f66df66410f76f16641"
            "0f76d1660f70ed08660f70e408660fdbf2660f62ec66410f6fd6660f73d22066410f66e8660f6fe3660ff4d266"
            "410f76e1660f70d908660f6fc8660ff4c8660f73d020660ff4c066410f76e9660f70d208660f62da660fdbf566"
            "0f70c90866410f66da660f70c008660f62c8660f6fc166410f76d966410f66c0660fdbdc66410f76c1660fdbd8"
            "660f6fc6660f61f3660f69c3660f6fce660f61f0660f69c8660f61f166410fdbf466440f67ee66440fdb2d1000"
            "0000440f1168f04839d70f856afcffff8b842488000000488b542470458d04064d63c04d01f84429c04189c5eb"
            "330f1f400029e90fafc939ce7c3d442b64246c450fafe444396424640f9dc04188004983c0014883c204438d44"
            "05004439d07d790fb642020fb64a01440fb6224429d80fafc04139c17dba31c0ebd0660f1f4400004489d131d2"
            "48890c240fb64c9302440fb64493014531ed440fb624934429d90fafc94139c97c1e4129e8450fafc04439c67c"
            "12442b64246c450fafe44439642464410f9dc544882c104883c2014839142475b60f1f44000083442468014501"
            "d68b442468398424a80100000f8517fbffff0f28b424900000000f28bc24a0000000440f288424b0000000440f"
            "288c24c0000000440f289424d0000000440f289c24e0000000440f28a424f0000000440f28ac2400010000440f"
            "28b42410010000440f28bc24200100004881c4380100005b5e5f5d415c415d415e415fc3909090909090909090"
            "9090ff00ff00ff00ff00ff00ff00ff00ff0001010101010101010101010101010101"
    )
    */
    Code := MCode1( Hex )

    return Code
}



/**
 * ProcessColorMode - Gera uma imagem binária baseada na correspondência de cor com uma cor de referência.
 *
 * @param rr      Componente vermelho (Red) da cor de referência.
 * @param gg      Componente verde (Green) da cor de referência.
 * @param bb      Componente azul (Blue) da cor de referência.
 * @param Bmp     Ponteiro para o array que contém os dados da imagem original (formato RGB intercalado).
 * @param ss      Ponteiro para o array de saída, onde cada elemento será 1 ou 0, indicando a correspondência.
 * @param sw      Largura da imagem em pixels.
 * @param sh      Altura da imagem em pixels.
 * @param Stride  Número de bytes em uma linha da imagem, incluindo qualquer padding (deslocamento adicional no final de cada linha).
 * @param n       Limiar usado na expressão de comparação para determinar a correspondência de cor.
 *
 * Esta função percorre todos os pixels de uma imagem em formato RGB e verifica se a cor de cada pixel
 * corresponde à cor de referência especificada pelos parâmetros `rr`, `gg`, e `bb`. A correspondência
 * é determinada por uma expressão complexa que pondera as diferenças de cor para cada componente RGB.
 *
 * O resultado da comparação para cada pixel é armazenado no array `ss`, onde:
 * - `1` indica que o pixel corresponde à cor de referência dentro do limiar `n`.
 * - `0` indica que o pixel não corresponde.
 *
 * A função é otimizada para processar a imagem linha por linha, levando em consideração o padding 
 * especificado pelo parâmetro `Stride`.
 *

int ProcessColorMode( int rr, int gg, int bb, int bpp, unsigned char *Bmp, unsigned char *ss, int sw, int sh, int Stride, int n) {
    int r, g, b, v, o = 0, i = 0, x, y;    
    int j = Stride - sw * bpp / 8 ;

    for ( y = 0 ; y < sh; y++, o += ( j + 1 ) ) {

        for ( x = 0 ; x < sw; x++, o += bpp / 8 , i++) {

            r = Bmp[2 + o] - rr;
            g = Bmp[1 + o] - gg;
            b = Bmp[o] - bb;
            v = r + rr + rr;

            ss[i] = ((1024 + v) * r * r + 2048 * g * g + (1534 - v) * b * b <= n) ? 1 : 0;
        }
    }

    return x;
}
*/
;#Include GetStride.ahk
;#Include biBitCount.ahk

ProcessColorMode( rr, gg, bb, sw, sh, Stride, Bmp, n ) {
    ss := Buffer( sw * sh, 0 )
    ;y := 
    ;o :=
}

ExampleImg() {
    Hex :=
    (
        "4883ec5883f9010f85ac00000048b8ff000000ff000000c605490000000048baff00ffffffff00ff48890500000000"
        "48b800ff808080ff00004889051000000048b800ffffffff00ff804889150800000048ba00ff000000ffffff488905"
        "2000000048b800ff000000ffff004889151800000048ba8080ff000000ffff4889053000000048b8ffff80808000ff"
        "ff4889152800000048baffffff00000000ff48890540000000b8ffffffff4889153800000066890548000000488d05"
        "000000004883c458c3"
    )

    Code := MCode1( Hex )

    return Code
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

HelpExampleImg() {
    help :=        
        (
           "unsigned char* ExampleImg(int flag) {

                static unsigned char Bmp[5 * 5 * 3];

                if (flag == 1) {
                    unsigned char temp[5 * 5 * 3] = {
                        // Linha 1
                        0xFF, 0x00, 0x00,   0x00, 0xFF, 0x00,   0x00, 0x00, 0xFF,   0x00, 0xFF, 0xFF,   0xFF, 0xFF, 0x00,
                        // Linha 2
                        0xFF, 0x00, 0xFF,   0x80, 0x80, 0x80,   0xFF, 0x00, 0x00,   0x00, 0xFF, 0x00,   0x00, 0x00, 0xFF,
                        // Linha 3
                        0xFF, 0xFF, 0x00,   0xFF, 0xFF, 0xFF,   0xFF, 0x00, 0xFF,   0x80, 0x80, 0x80,   0xFF, 0x00, 0x00,
                        // Linha 4
                        0x00, 0xFF, 0xFF,   0x00, 0xFF, 0x00,   0x00, 0x00, 0xFF,   0xFF, 0x00, 0xFF,   0xFF, 0xFF, 0x00,
                        // Linha 5
                        0x00, 0x00, 0x00,   0xFF, 0xFF, 0xFF,   0x80, 0x80, 0x80,   0x00, 0xFF, 0xFF,   0xFF, 0xFF, 0x00
                    };
                    // Copia a imagem temporária para o array Bmp estático
                    memcpy(Bmp, temp, sizeof(temp));
                }

                return Bmp;
            }"
    )
}

HelpProcessColorMode() {
    Help :=
    (
        "Sim, a definição de rr como int está correta e é comum em C, especialmente em funções onde você pode precisar realizar operações aritméticas com esses valores, como subtração e multiplicação.

Justificativa para int em vez de unsigned char:
Operações Aritméticas:

Ao definir rr como int, você evita problemas com aritmética de subtração. Se rr fosse definido como unsigned char, a subtração que resulta em um valor negativo poderia causar problemas devido à conversão para um número sem sinal.
Por exemplo:
c
Copiar código
int r = Bmp[2 + o] - rr;
Se Bmp[2 + o] for menor que rr, r será negativo. Se rr fosse um unsigned char, o resultado da subtração poderia não ser intuitivo, pois unsigned char só suporta valores entre 0 e 255.
Flexibilidade:

Usar int permite manipular valores que podem estar fora do intervalo típico de 0-255, como valores intermediários que podem surgir durante o processamento ou para representar erros.
Compatibilidade com Outras Operações:

Em muitas operações, como multiplicações e somas, os valores são automaticamente promovidos para int ou um tipo maior. Definir rr como int garante que não haverá conversão inesperada ou perda de informação durante essas operações.
Considerações:
Uso de Espaço: Um int ocupa mais espaço na memória do que um unsigned char (geralmente 4 bytes vs. 1 byte), mas essa diferença é mínima e geralmente não afeta significativamente o desempenho, especialmente em operações como as que ProcessColorMode realiza.

Consistência: Mantendo rr, gg, e bb como int, você mantém consistência no código, especialmente se n (o limiar) também for um int.

Conclusão:
Definir rr como int é uma escolha sólida e comum em C, permitindo operações seguras e flexíveis com os valores de cor, especialmente em operações que podem resultar em valores fora do intervalo 0-255. Portanto, a definição está correta e apropriada para o contexto em que é usada na função ProcessColorMode.
Na função ProcessColorMode, o parâmetro n é utilizado como um limiar para determinar se um pixel corresponde à cor de referência. Especificamente, n é comparado com o resultado de uma fórmula que envolve as diferenças entre os componentes de cor (R, G, B) do pixel e da cor de referência.

Possíveis Valores de n:
Intervalo e Tipo de n:

n é declarado como um int, o que significa que pode assumir qualquer valor inteiro, tanto positivo quanto negativo, dentro dos limites de um inteiro de 32 bits (normalmente de -2.147.483.648 a 2.147.483.647).
No contexto da função, porém, n é usado como um limiar, e geralmente seria um valor positivo, já que está sendo comparado com uma soma de quadrados e outras operações que normalmente resultam em números positivos.
Significado de n:

Limiar de Correspondência: n representa o valor máximo permitido para a expressão ((1024 + v) * r * r + 2048 * g * g + (1534 - v) * b * b). Se o resultado dessa expressão for menor ou igual a n, o pixel é considerado uma correspondência com a cor de referência.
Controle de Tolerância: Valores menores de n significam que a função é mais restritiva, aceitando apenas pixels que estão muito próximos da cor de referência. Valores maiores de n permitem mais variação nos componentes de cor, tornando a função mais tolerante a desvios.
Exemplos de Valores de n:

Valores Pequenos (e.g., 0 a 1000): A função só consideraria correspondências exatas ou quase exatas. Pixels que diferem significativamente da cor de referência seriam rejeitados.
Valores Moderados (e.g., 1000 a 10000): A função permitiria alguma variação nos componentes de cor, aceitando pixels que são visualmente semelhantes à cor de referência.
Valores Grandes (e.g., 10000 a 100000 ou mais): A função seria muito permissiva, aceitando uma ampla gama de variações de cor como correspondências.
Considerações Específicas:

Se n for muito pequeno, quase nenhuma variação de cor será permitida, o que pode ser útil para buscas de cores exatas.
Se n for muito grande, a função pode aceitar praticamente qualquer cor como uma correspondência, o que pode não ser desejável.
Resumo:
n é um limiar que controla a tolerância da função ao comparar pixels com a cor de referência.
Valores pequenos de n tornam a função mais restritiva, enquanto valores grandes aumentam a tolerância a variações de cor.
O valor de n deve ser escolhido com base na precisão necessária para a correspondência de cor na aplicação específica.
Na prática, a escolha de n depende da aplicação e do grau de correspondência de cor que você deseja alcançar ao processar a imagem."
    )
}

/*

/ Função para converter um caractere hexadecimal em valor decimal
int hex_to_dec(char c) {
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
    return -1;
}

// Função para converter dois caracteres hexadecimais em um byte
unsigned char hex_pair_to_byte(char high, char low) {

    char data[ 2 ];
    char result[ 2 ];
    data[ 0 ] = high;
    data[ 1 ] = low;
    int i;

    for ( i = 0; i < 2; i++ ) {
        
        if (data[ i ] >= '0' && data[ i ] <= '9')
            result[ i ] = data[ i ] - '0';

        if (data[ i ] >= 'a' && data[ i ] <= 'f')
            result[ i ] = data[ i ] - 'a' + 10;

        if (data[ i ] >= 'A' && data[ i ] <= 'F')
            result[ i ] = data[ i ] - 'A' + 10;
        
    }

    return ( result[ 0 ] << 4) | result[ 1 ];
}

