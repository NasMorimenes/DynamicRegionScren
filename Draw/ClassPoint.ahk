/**
 * @param "IntX IntY"
 */

Ass := Point( "IntX10 IntY20" )
class Point {
    
    __New( param* ) {
        this.param := param[1]
        this.IsCoordinates()
    }

    CheckParam() {
        NeedleRegEx := Map( "Coordinates", [ "IntX IntY", "\s*(IntX\d*)\s+(IntY\d*)\s*" ], )
    }

    IsCoordinates() {
        if ( Type( this.param = "String" ) ) {
            Posi := RegExMatch( this.param, "\s*(IntX\d*)\s+(IntY\d*)\s*", &Coordinates )
            if ( Coordinates.Count > 1 )
            ;Coordinates := StrSplit( this.param, [ "IntX", "IntY"] )
            this.X := ( ( Type( Coordinates[ 1 ] ) != "Integer" ) ) ; && Coordinates[ 1 ] := 0 )
        }
        
    }
}

;MsgBox( Type( Number( " " ) ) )
    