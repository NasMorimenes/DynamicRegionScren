;#Include Includes.ahk

;GetbiBitCount( 24 )

;MsgBox( Bit )

;MsgBox( GetPadding( 3 ) )
;ExempleDataImage( )

ExempleDataImage( sw, sh) {

    static buff := Buffer( GetStride( sw ) * sh , 0)
    static ConstAccess := 16    

    Offiset := [ 0, 4, 8, 12 ]

    MsgBox( "Padding -> " GetPadding( sw ) )

    MsgBox "buff.Size - > " buff.Size

    return Buff.Ptr
}

