/*
Referências:
- https://www.cnblogs.com/wxl845235800/p/11079403.html
- https://blog.csdn.net/lz0499/article/details/77345166
- https://www.jianshu.com/p/86e8c3acd41d

AutoHotkey v2.0-beta 2

Essa função utiliza o modelo de cor LAB junto com o algoritmo CIEDE2000 para calcular
a diferença de cor entre dois valores. Quanto maior o valor retornado, menor a similaridade entre as cores.
*/

white := 0xffffff
black := 0x000000
gray := 0x808080
deltaE := ColorDiff(white, black)
MsgBox("A diferença de cor entre branco e preto é: " deltaE)
deltaE := ColorDiff(white, gray)
MsgBox("A diferença de cor entre branco e cinza é: " deltaE)

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

    ; Converte um valor hexadecimal para RGB
    Hex2RGB(hex) {
        R := (hex & 0xFF0000) >> 16
        G := (hex & 0x00FF00) >> 8
        B := (hex & 0x0000FF) >> 0
        return { R: R, G: G, B: B }
    }

    ; Converte valores RGB para hexadecimal
    RGB2Hex(r, g, b) => Format("0x{:06x}", (r << 16) + (g << 8) + b)

    ; Converte valores RGB para o espaço de cores XYZ
    RGB2XYZ(R, G, B) {
        ; Aplica correção gamma nos valores RGB
        RR := Gamma(R / 255), GG := Gamma(G / 255), BB := Gamma(B / 255)

        ; Converte os valores para o espaço XYZ utilizando multiplicação matricial
        X := 0.4124564 * RR + 0.3575761 * GG + 0.1804375 * BB
        Y := 0.2126729 * RR + 0.7151522 * GG + 0.0721750 * BB
        Z := 0.0193339 * RR + 0.1191920 * GG + 0.9503041 * BB
        return { X: X, Y: Y, Z: Z }
    }

    ; Aplica correção gamma aos valores RGB
    Gamma(x) => (x > 0.04045) ? ((x + 0.055) / 1.055) ** 2.4 : x / 12.92

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

    ; Calcula a diferença de cor entre dois valores LAB usando a fórmula CIEDE2000
    GetDeltaEByLab(L1, a1, b1, L2, a2, b2) {
        static pi := 3.141592653589793
            , kL := 1
            , kC := 1
            , kH := 1

        ; Calcula a média das cromaticidades
        mean_Cab := (GetChroma(a1, b1) + GetChroma(a2, b2)) / 2
        mean_Cab_pow7 := mean_Cab ** 7

        ; Fator de ajuste G
        G := 0.5 * (1 - (mean_Cab_pow7 / (mean_Cab_pow7 + 25 ** 7)) ** 0.5)

        ; Ajusta os valores a1 e a2 usando G
        aa1 := a1 * (1 + G)
        aa2 := a2 * (1 + G)

        ; Calcula as cromaticidades
        cc1 := GetChroma(aa1, b1)
        cc2 := GetChroma(aa2, b2)

        ; Calcula os ângulos de matiz
        hh1 := GetHueAngle(aa1, b1)
        hh2 := GetHueAngle(aa2, b2)

        ; Calcula as diferenças entre os valores LAB
        delta_LL := L1 - L2
        delta_CC := cc1 - cc2
        delta_hh := hh1 - hh2
        delta_HH := 2 * Sin(pi * delta_hh / 360) * (cc1 * cc2) ** 0.5

        ; Calcula as médias dos valores LAB
        mean_LL := (L1 + L2) / 2
        mean_cc := (cc1 + cc2) / 2
        mean_hh := (hh1 + hh2) / 2

        ; Calcula os fatores de escala
        SL := 1 + 0.015 * ((mean_LL - 50) ** 2) / (20 + (mean_LL - 50) ** 2) ** 0.5
        SC := 1 + 0.045 * mean_cc
        T := 1 - 0.17 * Cos((mean_hh - 30) * pi / 180) + 0.24 * Cos(2 * mean_hh * pi / 180) + 0.32 * Cos((3 * mean_hh + 6) * pi / 180) - 0.2 * Cos((4 * mean_hh - 63) * pi / 180)
        SH := 1 + 0.015 * mean_cc * T

        ; Calcula o fator de rotação RC e o ângulo delta_xita
        RC := 2 * (mean_Cab_pow7 / (mean_Cab_pow7 + 25 ** 7)) ** 0.5
        delta_xita := 30 * Exp(-((mean_hh - 275) / 25) ** 2)
        RT := -Sin(2 * delta_xita * pi / 180) * RC

        ; Calcula os itens L, C e H para a fórmula CIEDE2000
        L_item := delta_LL / (kL * SL)
        C_item := delta_CC / (kC * SC)
        H_item := delta_HH / (kH * SH)

        ; Retorna a diferença de cor
        return (L_item * L_item + C_item * C_item + H_item * H_item + RT * C_item * H_item) ** 0.5
    }

    ; Calcula a cromaticidade (intensidade da cor)
    GetChroma(a, b) => (a * a + b * b) ** 0.5

    ; Calcula o ângulo de matiz (hue angle)
    GetHueAngle(a, b) {
        if a = 0
            return 90

        static pi := 3.141592653589793
        h := (180 / pi) * ATan(b / a)

        if a > 0 and b > 0
            return h
        else if a < 0 and b > 0
            return 180 + h
        else if a < 0 and b < 0
            return 180 + h
        else
            return 360 + h
    }
}
