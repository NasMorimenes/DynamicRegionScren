#Include Includes.ahk
GetPadding( biWidth ) {
    global biBitCount
    stride := GetStride(biWidth)
    bytesPerPixel := biBitCount >> 3  ; Divide biBitCount por 8 para obter bytes por pixel
    bytesPerLine := biWidth * bytesPerPixel
    return stride - bytesPerLine
}
