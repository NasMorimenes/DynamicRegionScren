Ass := CallbackCreate( rgb_to_xyz )

n := 0xFF0000

DllCall( Ass, "UInt", n )

MsgBox( NumGet( XYZ, 16, "float" ) )

rgb_to_xyz( n ) {
    global
    XYZ := Buffer( 3 * 8, 0)

    ;// Normaliza os valores RGB
    r := (n >> 16) & 0xFF
    g := (n >> 8) & 0xFF
    b := n & 0xFF
    
    r := float( r / 255.0 )
    g := Float( g / 255.0 )
    b := Float( b / 255.0 )

    ;// Converte para o espaço linear RGB
    if ( r > 0.04045 ) 
        r := ( ( r + 0.055) / 1.055 ) ** 2.4
    else 
        r := r / 12.92

    if ( g > 0.04045 ) {
        g := ( ( g + 0.055) / 1.055 ) ** 2.4
    }
    else
        g := g / 12.92

    if ( b > 0.04045 ){ 
        b := ( ( b + 0.055 ) / 1.055 ) ** 2.4 
    }
    else
        b := b / 12.92

    NumPut( "float", Float( r * 0.4124 + g * 0.3576 + b * 0.1805 ), XYZ, 0 )
    NumPut( "float", Float( r * 0.2126 + g * 0.7152 + b * 0.0722 ), XYZ, 8 )
    NumPut( "float", Float( r * 0.0193 + g * 0.1192 + b * 0.9505 ), XYZ, 16 )

}