#include <math.h>
double lab_color_difference( unsigned int c1, unsigned int c2 ) {

	double rgb[ 6 ], LBA[ 6];
	int i, m = 0;
	
    rgb[ 0 ] = ( ( c1 >> 16 ) & 0xFF ) / 255.0;	//r1
    rgb[ 1 ] = ( ( c1 >> 8 )  & 0xFF ) / 255.0;		//g1
    rgb[ 2 ] =   ( c1         & 0xFF ) / 255.0;			//b1	
	rgb[ 3 ] = ( ( c2 >> 16 ) & 0xFF ) / 255.0;	//r2
    rgb[ 4 ] = ( ( c2 >> 8 )  & 0xFF ) / 255.0;		//g2
    rgb[ 5 ] =   ( c2         & 0xFF ) / 255.0;			//b2
	
	
	for ( i = 0; i < 2; i++) {

		// Converte para o espaço linear RGB
		
		LBA[ m + 0 ] = ( 116.0 * ( rgb[ m + 0 ] * 0.2126 + 
								   rgb[ m + 1 ] * 0.7152 + 
								   rgb[ m + 2 ] * 0.0722 ) / 1.00000 ) - 16.0;
								   
								   
		LBA[ m + 1 ] = 500.0 * ( ( ( rgb[ m + 0 ] * 0.4124 + 
									 rgb[ m + 1 ] * 0.3576 + 
									 rgb[ m + 2 ] * 0.1805 ) / 0.95047 ) - ( rgb[ m + 0 ] * 0.2126 + 
																			 rgb[ m + 1 ] * 0.7152 + 
																			 rgb[ m + 2 ] * 0.0722 ) / 1.00000 ) - 16.0; 
												  
		LBA[ m + 2 ] = 200.0 * ( ( ( rgb[ m + 0 ] * 0.2126 + 
									 rgb[ m + 1 ] * 0.7152 + 
									 rgb[ m + 2 ] * 0.0722 ) / 1.00000 ) - ( ( rgb[ m + 0 ] * 0.0193 + 
																			   rgb[ m + 1 ] * 0.1192 + 
																			   rgb[ m + 2 ] * 0.9505 ) / 1.08883 ) );
		
		m += 3;
		
		
	}
	
	double delta_l = LBA[ 0 ] - LBA[ 3 ];
    double delta_a = LBA[ 1 ] - LBA[ 4 ];
    double delta_b = LBA[ 2 ] - LBA[ 5 ];
	
    return sqrt(delta_l * delta_l + delta_a * delta_a + delta_b * delta_b);
}