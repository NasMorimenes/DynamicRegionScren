unsigned int GetColorDifference(
    unsigned int c,
    unsigned int n ) {  

    // Variáveis para as componentes R, G, B da cor especificada
    int r, g, b;

    // Variáveis para as componentes R, G, B do limiar de diferença de cor
    int rr, gg, bb;

    // Variáveis para iteração
    int x, y, o, i;

    // Extrai os componentes R, G, B da cor especificada
    r = (c >> 16) & 0xFF;
    g = (c >> 8) & 0xFF;
    b = c & 0xFF;

    // Extrai os componentes R, G, B do limiar de diferença de cor
    rr = (n >> 16) & 0xFF;
    gg = (n >> 8) & 0xFF;
    bb = n & 0xFF;

    int diff_r = (( rr >> 16) & 0xFF) - r;  // Red
    int diff_g = (( gg >> 8) & 0xFF) - g;   // Green
    int diff_b = ( bb & 0xFF) - b;          // Blue

    

    return 

}