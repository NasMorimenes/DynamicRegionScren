; Converte valores XYZ para o espaço de cores LAB
XYZ2Lab(X, Y, Z) {
    static param_13 := 1 / 3
        , param_16116 := 16 / 116
        , Xn := 0.950456
        , Yn := 1
        , Zn := 1.088754

    ; Normaliza os valores XYZ em relação ao ponto branco D65
    X /= Xn
    Y /= Yn
    Z /= Zn

    ; Aplica a função LAB
    fY := (Y > 0.008856) ? Y ** param_13 : 7.787 * Y + param_16116
    fX := (X > 0.008856) ? X ** param_13 : 7.787 * X + param_16116
    fZ := (Z > 0.008856) ? Z ** param_13 : 7.787 * Z + param_16116

    L := 116 * fY - 16
    L := (L > 0) ? L : 0
    a := 500 * (fX - fY)
    b := 200 * (fY - fZ)
    return { L: L, a: a, b: b }
}