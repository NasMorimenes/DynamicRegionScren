RtlMoveMemory( captureWidth , captureHeight, ppvBits, &Stride := 0 ) {
    sizeScan := captureWidth * captureHeight * 4
    Stride := ( ( captureWidth * 32 + 31 ) // 32) * 4
    Scan := Buffer( sizeScan, 0 )
    DllCall(
        "RtlMoveMemory",
        "Ptr", Scan.Ptr,
        "Ptr", ppvBits,
        "UPtr", Stride * captureHeight
    )

    return Scan
}