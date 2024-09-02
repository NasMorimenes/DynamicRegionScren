; Converte valores RGB para hexadecimal
RGB2Hex(r, g, b) {
    return Format("0x{:06x}", (r << 16) + (g << 8) + b)
}