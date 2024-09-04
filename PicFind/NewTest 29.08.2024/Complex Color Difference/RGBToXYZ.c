#include <math.h>

// Função para converter RGB para XYZ
void rgb_to_xyz(unsigned int r, unsigned int g, unsigned int b, float *fout ) {
    // Normaliza os valores RGB
    float out[ 3 ];
    float y, x = 2.4;

    out[ 0 ] = r / 255.0;
    out[ 1 ] = g / 255.0;
    out[ 2 ] = b / 255.0;

    int i;
    // Converte para o espaço linear RGB
    for ( i=0; i<3; i++ ) {
        if ( out[ i ] > 0.04045) {
            y = ( out[ i ] + 0.055 ) / 1.055;
            out[ i ] = powf( y, x );
        }
        else {
            y = out[ i ] / 12.92;
            out[ i ] = y;
        }
    }

    // Convertendo para o espaço XYZ
    fout[ 0 ] = out[ 0 ] * 0.4124 + out[ 1 ] * 0.3576 + out[ 2 ] * 0.1805;
    fout[ 1 ] = out[ 0 ] * 0.2126 + out[ 1 ] * 0.7152 + out[ 2 ] * 0.0722;
    fout[ 2 ] = out[ 0 ] * 0.0193 + out[ 1 ] * 0.1192 + out[ 2 ] * 0.9505;
}