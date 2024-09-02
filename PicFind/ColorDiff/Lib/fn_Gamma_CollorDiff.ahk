; Aplica correção gamma aos valores RGB
Gamma(x) { 
    return ( x > 0.04045 ) ? ( (x + 0.055) / 1.055 ) ** 2.4 : x / 12.92
}