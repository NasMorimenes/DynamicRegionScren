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