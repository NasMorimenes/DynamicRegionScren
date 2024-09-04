Ass := RGB2Hex( 128, 218, 88)

MsgBox( Ass )

RGB2Hex( R, G, B ) {
    result :=
    DllCall(
        "RGB2Hex.dll\RGB2Hex",
        "UInt", R,
        "UInt", G,
        "UInt", B,
        "UInt"
    )
    return Format("0x{:06x}", result )
}