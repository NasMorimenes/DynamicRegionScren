GetStride( biWidth ) {
    global biBitCount
    ;global Stride
    if ( !IsSet( Stride ) ) {
        global Stride := ( ( biWidth * biBitCount + 31 ) & ~31 ) >> 3
    }
    
}