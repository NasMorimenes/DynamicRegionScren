; Converte um valor hexadecimal para RGB
Hex2RGB(hex) {
    R := (hex & 0xFF0000) >> 16
    G := (hex & 0x00FF00) >> 8
    B := (hex & 0x0000FF) >> 0
    return { R: R, G: G, B: B }
}