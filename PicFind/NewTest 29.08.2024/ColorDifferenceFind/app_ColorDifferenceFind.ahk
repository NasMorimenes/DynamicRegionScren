#Include Includes_ColorDifferenceFind.ahk

c := 4288008348
n := 0x89CCAF00
sw := 2
sh := 1
captureX := 100
captureY := 300
GetbiBitCount()

GetStride( sw )

Scan := 0
ss := Buffer( sw * sh, 0 )
GetBitsFromScreen( captureX, captureY, sw, sh )
Hex := Hex_ColorDifferenceFind()
code := MCode( Hex )

#x:: {
    global
    result := Call( code, c, n, Scan, ss, sw, sh, Stride )
    if ( !result ) {
        Viso( ss, sh, sw )
    }
}