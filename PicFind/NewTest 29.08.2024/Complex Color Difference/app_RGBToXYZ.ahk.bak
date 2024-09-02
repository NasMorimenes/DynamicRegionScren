#Include Includes.ahk
color := 0xFF0000


dn := Buffer( 12, 0 )
NumPut( "float", 250.0, dn, 0 )
NumPut( "float", 0.0, dn, 4 )
NumPut( "float", 0.0, dn, 8 )
R := 255 ;NumGet( dn, 0, "float")
G := 25 ;NumGet( dn, 4, "float")
B := 100 ;NumGet( dn, 8, "float")

MsgBox Type( B )

X := Buffer( 24, 0 )

;MsgBox( 255 // 255)


MsgBox( Call( R, G, B, &X ) ) ;, 0, 0, &X

;MsgBox( Y )

;MsgBox( NumGet( Y, 0, "double") )