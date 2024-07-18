
coord := "" ;"TopX10 TopY25 BottomX15 BottomY35"
Ass := Rectangle( coord )
MsgBox( Ass.TopX )
Ass.GetParam( "BottomY100")
MsgBox( Ass.BottomY )

class Rectangle {
    __Init() {
       this.TopX := 0
       this.TopY := 0
       this.BottomX := 0
       this.BottomY := 0
    }
    __New( coord* ) {
        RegExP := "^\s*(TopX\d+)\s*(TopY\d+)\s*(BottomX\d+)\s*(BottomY\d+)\s*$"
        result := RegExMatch(coord[ 1 ] , RegExP, &Match)
        if ( result ) {
            loop Match.Count
                this.GetParam( Match.%A_Index% )
        }
    }

    GetParam( Coord_S ) {
        switch  {
            case InStr( Coord_S, "TopX" ):
                    
                this.TopX := SubStr( Coord_S, 5 )

            case InStr( Coord_S, "TopY" ):
                    
                this.TopY := SubStr( Coord_S, 5 )

            case InStr( Coord_S, "BottomX" ):
                    
                this.BottomX := SubStr( Coord_S, 8 )

            case InStr( Coord_S, "BottomY" ):
                    
                this.BottomY := SubStr( Coord_S, 8 )

            }
    }
}
