#Include Includes.ahk
GetStride( biWidth ) {
    global biBitCount
    return ( ( biWidth * biBitCount + 31 ) & ~31) >> 3
}