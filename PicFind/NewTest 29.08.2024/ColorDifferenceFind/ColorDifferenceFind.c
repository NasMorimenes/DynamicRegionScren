// Função ColorDifferenceFind
int ColorDifferenceFind(
    unsigned int c,
    unsigned int n,
    unsigned int *Bmp,
    int Stride,
    int sw,
    int sh,
    unsigned char *ss ) {  // Alterado para unsigned char

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

    // Itera sobre a área de busca na imagem
    o = 0;
    for (y = 0; y < sh; y++) {

        for (x = 0; x < sw; x++, o++) {  // Incremento por 1, pois Bmp[o] já é um uint

            // Calcula o índice do pixel no vetor ss
            i = y * sw + x;

            // Calcula a diferença de cor entre o pixel atual e a cor de referência
            int diff_r = ((Bmp[o] >> 16) & 0xFF) - r;  // Red
            int diff_g = ((Bmp[o] >> 8) & 0xFF) - g;   // Green
            int diff_b = (Bmp[o] & 0xFF) - b;          // Blue

            // Verifica se a diferença de cor está dentro do limiar especificado
            if (diff_r <= rr && diff_r >= -rr &&
                diff_g <= gg && diff_g >= -gg &&
                diff_b <= bb && diff_b >= -bb) {
                
                // Define o valor correspondente no vetor ss como 1
                ss[i] = 1;
            } else {
                // Define o valor correspondente no vetor ss como 0
                ss[i] = 0;
            }
        }
        o += (Stride / 4) - sw;  // Ajusta o offset para pular o padding no final de cada linha, se houver
    }

    // Retorna código de sucesso
    return 0; // OK
}