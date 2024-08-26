

SetColorBuff( &buff, color ) {
    static o := 0
    
    mask := 0xFFFFFFFF

    buff := ( buff & ~mask) | (color << o)

    o += 32
    MsgBox( buff )
}