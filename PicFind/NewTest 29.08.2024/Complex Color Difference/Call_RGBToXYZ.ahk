Call( R, G, B, &X ) {

    Hex := Hex_RGBToXYZ()
    code := MCode( Hex )

    result :=
    DllCall(
        code,
        "uint", R,
        "uint", G,
        "uint", B,
        "UPtr", X.Ptr
    )
    return result
}

/*  void rgb_to_xyz(double r,
    double g,
    double b,
    double *x,
    double *y,
    double *z ) {