; Utility Function to Get Key Details
GetKeyDetails1( lParam ) {

    if ( wPointer <= 9 ) {

        NumPut( "Int", NumGet( lParam,  0, "Int" )     ,Buff,  0 + ( 16 * wPointer ) )
        NumPut( "Int", NumGet( lParam,  4, "Int" )     ,Buff,  4 + ( 16 * wPointer ) )
        NumPut( "Int", NumGet( lParam,  8, "Int" ) & 1 ,Buff,  8 + ( 16 * wPointer ) )
        NumPut( "Int", NumGet( lParam, 12, "Int" )     ,Buff, 12 + ( 16 * wPointer ) )

        Authorization.InsertAt( wPointer + 1, true )

        if ( wPointer = 9 ) {
            wPointer := 0
        }
        ++wPointer
    }

}

/*