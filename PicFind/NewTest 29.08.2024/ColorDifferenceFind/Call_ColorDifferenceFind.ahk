
Call( code, c, n, Bmp, ss, sw, sh, Stride ) {
    result :=
    DllCall(
        code,
        "UInt", c,
        "UInt", n,
        "UPtr", Bmp.Ptr,
        "Int", Stride,
        "Int", sw,
        "Int", sh,
        "UPtr", ss.Ptr,
        "Int"
    )

    return result
}