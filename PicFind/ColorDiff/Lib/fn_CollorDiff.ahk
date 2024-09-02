ColorDiff(hex1, hex2) {
    ; Converte os valores hexadecimais para RGB
    RGB1 := Hex2RGB(hex1)
    RGB2 := Hex2RGB(hex2)

    ; Converte os valores RGB para o espaço de cores XYZ
    XYZ1 := RGB2XYZ(RGB1.R, RGB1.G, RGB1.B)
    XYZ2 := RGB2XYZ(RGB2.R, RGB2.G, RGB2.B)

    ; Converte os valores XYZ para o espaço de cores LAB
    Lab1 := XYZ2Lab(XYZ1.X, XYZ1.Y, XYZ1.Z)
    Lab2 := XYZ2Lab(XYZ2.X, XYZ2.Y, XYZ2.Z)

    ; Calcula e retorna a diferença de cor usando a fórmula CIEDE2000
    return GetDeltaEByLab(Lab1.L, Lab1.a, Lab1.b, Lab2.L, Lab2.a, Lab2.b)
}