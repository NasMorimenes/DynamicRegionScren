#Include BinToDecimal.ahk
/*
aBuff := 0
aColor1 := 0xff920f0f
ab := 0x0f ;15
ag := 0x0f ;15
ar := 0x92 ;146

;MsgBox( ar )
;(iPixel >> 24) & 0xFF
;aa := aColor1
MsgBox( ( aColor1 >> 24 ) & 0xFF )
;ar := ( aColor1 >> 16 ) & 0xFF
MsgBox( ( aColor1 >> 16 ) & 0xFF )
;ar := ( aColor1 >> 16 ) & 0xFF
MsgBox( ( aColor1 >> 8 ) & 0xFF )

;aColor1 := ( aColor1 >> 16 )  15
MsgBox( ar )
Color2 := "ff2713d8"


Bin := [1,1,0,1]
Bin2 := [ 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
Bin3 := StrSplit( 11010000110100000000 )
;MsgBox( Bin3.Length )

Ass1 := BinToDecimal( Bin )
Ass := 13
loop 2
    Ads := aBuff | ( Ass << (16  // A_Index) )
MsgBox( aBuff "`n" Ads )

Esc::ExitApp()

;loop 32
;    MsgBox( GetBitValue( Buff, A_Index- 1 ) )

GetBitValue( number, bitPosition) {
    ; Cria uma máscara com o bit desejado ativado
    mask := 1 << bitPosition
    
    ; Usa uma operação AND para isolar o bit e compara com 0
    return (number & mask) >> bitPosition
}

;MsgBox( NumGet( Buff, 0, "int" ) )
/*

VarSetStrCapacity( &buff, 400 )

_Pixel := [ 80, 255, 100, 255 ]

iPixel := (_Pixel[ 1 ] << 24)        ; R: Desloca 24 bits para a esquerda
           | (_Pixel[ 1 + 1] << 16)    ; G: Desloca 16 bits para a esquerda
           | (_Pixel[ 1 + 2] << 8)     ; B: Desloca 8 bits para a esquerda
           | _Pixel[ 1 + 3]            ; A: Fica nos 8 bits menos significativos

buff  := (iPixel >> 24) & 0xFF    ; Armazena o byte mais significativo (R)
buff  := (iPixel >> 16) & 0xFF ; Armazena o segundo byte (G)
buff  := (iPixel >> 8) & 0xFF  ; Armazena o terceiro byte (B)
buff  := iPixel & 0xFF         ; Armazena o byte menos significativo (A)

MsgBox( buff )