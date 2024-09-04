#include <math.h>

// Função auxiliar para linearizar valores RGB
double linearize_rgb(double value) {
    return value > 0.04045 ? pow((value + 0.055) / 1.055, 2.4) : value / 12.92;
}

// Função auxiliar para converter RGB linearizado para XYZ
void rgb_to_xyz(double r, double g, double b, double *X, double *Y, double *Z) {
    *X = r * 0.4124 + g * 0.3576 + b * 0.1805;
    *Y = r * 0.2126 + g * 0.7152 + b * 0.0722;
    *Z = r * 0.0193 + g * 0.1192 + b * 0.9505;
}

// Função auxiliar para converter XYZ para CIELAB
void xyz_to_lab(double X, double Y, double Z, double *L, double *a, double *b) {
    X /= 0.95047;  // Normalização em relação ao ponto branco de referência D65
    Y /= 1.00000;
    Z /= 1.08883;

    double epsilon = 0.008856;
    double kappa = 903.3;

    double fx = (X > epsilon) ? cbrt(X) : (kappa * X + 16.0) / 116.0;
    double fy = (Y > epsilon) ? cbrt(Y) : (kappa * Y + 16.0) / 116.0;
    double fz = (Z > epsilon) ? cbrt(Z) : (kappa * Z + 16.0) / 116.0;

    *L = (Y > epsilon) ? (116.0 * fy - 16.0) : kappa * Y;
    *a = 500.0 * (fx - fy);
    *b = 200.0 * (fy - fz);
}

// Função principal para calcular a diferença de cor usando LAB
double lab_color_difference(unsigned int c1, unsigned int c2) {
    double rgb[6];
    double LBA[6];

    // Separar os valores RGB das duas cores
    rgb[0] = ((c1 >> 16) & 0xFF) / 255.0;  // r1
    rgb[1] = ((c1 >> 8)  & 0xFF) / 255.0;  // g1
    rgb[2] = (c1         & 0xFF) / 255.0;  // b1
    rgb[3] = ((c2 >> 16) & 0xFF) / 255.0;  // r2
    rgb[4] = ((c2 >> 8)  & 0xFF) / 255.0;  // g2
    rgb[5] = (c2         & 0xFF) / 255.0;  // b2

    int m = 0;  // Índice para controlar a iteração

    for (int i = 0; i < 2; i++) {
        // Linearizar os valores RGB
        double r_linear = linearize_rgb(rgb[m + 0]);
        double g_linear = linearize_rgb(rgb[m + 1]);
        double b_linear = linearize_rgb(rgb[m + 2]);

        // Converter para espaço XYZ
        double X, Y, Z;
        rgb_to_xyz(r_linear, g_linear, b_linear, &X, &Y, &Z);

        // Converter para espaço CIELAB
        double L, a, b;
        xyz_to_lab(X, Y, Z, &L, &a, &b);

        // Armazenar os valores L*, a*, b* na matriz LBA
        LBA[m + 0] = L;
        LBA[m + 1] = a;
        LBA[m + 2] = b;

        m += 3;  // Avançar para a próxima cor
    }

    // Calcular a diferença ΔE entre as duas cores no espaço LAB
    double delta_l = LBA[0] - LBA[3];
    double delta_a = LBA[1] - LBA[4];
    double delta_b = LBA[2] - LBA[5];

    return sqrt(delta_l * delta_l + delta_a * delta_a + delta_b * delta_b);
}