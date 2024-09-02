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