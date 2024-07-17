
coord := "s10 y25"
Ass := Rectangle(coord)

class Rectangle {
    __New(coord) {
        RegExMatch(coord, "^\s*(\w+\d+)\s*(\w+\d+)\s*$", &Match)
        if ( Match.Count ) {
            ;loop Match.Count
            ;loop Match.Count {
                RegExMatch( Match.1, "\D+", &Var )
                MsgBox( Var.0 )
                xCoord := Match.%A_index%
            ;}
           
            yCoord := Match.2
            MsgBox( "X Coordinate: " xCoord "`nY Coordinate: " yCoord )
        } else {
            MsgBox( "No match found ")
        }
    }
}
