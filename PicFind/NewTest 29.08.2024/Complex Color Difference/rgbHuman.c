#include <math.h>

// Função para converter RGB para XYZ
void rgb_to_xyz(double r, double g, double b, double *x, double *y, double *z) {
    // Normaliza os valores RGB
    r = r / 255.0;
    g = g / 255.0;
    b = b / 255.0;

    // Converte para o espaço linear RGB
    if (r > 0.04045) r = pow((r + 0.055) / 1.055, 2.4);
    else r = r / 12.92;

    if (g > 0.04045) g = pow((g + 0.055) / 1.055, 2.4);
    else g = g / 12.92;

    if (b > 0.04045) b = pow((b + 0.055) / 1.055, 2.4);
    else b = b / 12.92;

    // Convertendo para o espaço XYZ
    *x = r * 0.4124 + g * 0.3576 + b * 0.1805;
    *y = r * 0.2126 + g * 0.7152 + b * 0.0722;
    *z = r * 0.0193 + g * 0.1192 + b * 0.9505;
}

// Função para converter XYZ para CIELAB
void xyz_to_lab(double x, double y, double z, double *l, double *a, double *b) {
    // Valores de referência para o branco (D65)
    double xr = x / 0.95047;
    double yr = y / 1.00000;
    double zr = z / 1.08883;

    // Convertendo para L*a*b*
    if (xr > 0.008856) xr = pow(xr, 1.0 / 3.0);
    else xr = (7.787 * xr) + (16.0 / 116.0);

    if (yr > 0.008856) yr = pow(yr, 1.0 / 3.0);
    else yr = (7.787 * yr) + (16.0 / 116.0);

    if (zr > 0.008856) zr = pow(zr, 1.0 / 3.0);
    else zr = (7.787 * zr) + (16.0 / 116.0);

    *l = (116.0 * yr) - 16.0;
    *a = 500.0 * (xr - yr);
    *b = 200.0 * (yr - zr);
}

// Função para calcular a diferença ΔE*ab entre duas cores em CIELAB
double delta_e(double l1, double a1, double b1, double l2, double a2, double b2) {
    double delta_l = l1 - l2;
    double delta_a = a1 - a2;
    double delta_b = b1 - b2;
    return sqrt(delta_l * delta_l + delta_a * delta_a + delta_b * delta_b);
}

// Função principal para calcular a diferença perceptual entre duas cores RGB
double color_difference(double r1, double g1, double b1, double r2, double g2, double b2) {
    double x1, y1, z1;
    double x2, y2, z2;
    double l1, a1, b1_lab;
    double l2, a2, b2_lab;

    // Converter as duas cores de RGB para XYZ
    rgb_to_xyz(r1, g1, b1, &x1, &y1, &z1);
    rgb_to_xyz(r2, g2, b2, &x2, &y2, &z2);

    // Converter as duas cores de XYZ para CIELAB
    xyz_to_lab(x1, y1, z1, &l1, &a1, &b1_lab);
    xyz_to_lab(x2, y2, z2, &l2, &a2, &b2_lab);

    // Calcular e retornar a diferença ΔE*ab
    return delta_e(l1, a1, b1_lab, l2, a2, b2_lab);
}