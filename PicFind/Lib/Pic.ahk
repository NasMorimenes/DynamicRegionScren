;C:\Users\morim\OneDrive\DynamicRegionScren\PicFind\ChatGPT
void ProcessColorMode(
    int_rr,
    int_gg,
    int_bb,
    unsigned_char_Bmp,
    unsigned_char_ss,
    int_sw,
    int_sh,
    int_Stride,
    int_n ) {
    
    int_r := 0,
    int_g := 0,
    int_b := 0,
    int_v := 0,
    int_o := 0,
    int_i := 0,
    int_j := Stride - sw * 4,
    int_y := 0,
    int_x := 0,
    Offset := [ 0, 4, 8, 12 ],
    o := 0
    Inc := 16
    /*
    Loop 3 {
        Loop 3 {
            ;( z )( A_Index ) + [ 0, 4, 8, 12 ]
            ;Offset := [ 0, 4, 8, 12 ]
            ;MsgBox( ( o ) + Offset[ 3 ]  "`n  - " ( o ) + Offset[ 2 ]  "`n  - " ( o ) + Offset[ 1 ] )
            r := NumGet( Bmp, o + Offset[ 3 ], "Int" )
            g := NumGet( Bmp, o + Offset[ 2 ], "Int" )
            b := NumGet( Bmp, o + Offset[ 1 ], "Int" )
            o += 16
            ++i
            ++x
        }
        ;++y
    }
    }
    */
    
    
    
    Loop ( sh * sw ) {
        a := NumGet( Bmp, o + Offset[ 4 ], "Int" )
        r := NumGet( Bmp, o + Offset[ 3 ], "Int" )
        g := NumGet( Bmp, o + Offset[ 2 ], "Int" )
        b := NumGet( Bmp, o + Offset[ 1 ], "Int" )
        
        v := r + rr + rr
        ss[++i] = ( ( 1024 + v ) * r * r + 2048 * g * g + ( 1534 - v ) * b * b <= n ) ? 1 : 0
        
        o += 16
    }
    
    
    
    
    /*
          for (int y = 0; y < sh; y++, o += j)
    
                for (int x = 0; x < sw; x++, o += 4, i++) {
                      r = Bmp[2 + o] - rr;
                      g = Bmp[1 + o] - gg;
                      b = Bmp[o] - bb;
                      v = r + rr + rr;
                      ss[i] = ((1024 + v) * r * r + 2048 * g * g + (1534 - v) * b * b <= n) ? 1 : 0;
                }
    }
    */
}