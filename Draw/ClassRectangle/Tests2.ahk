
class Array2D {

    __New( x, y ) {
        this.Array := Array()
        this.Array.Length := x * y
        this.Array.Width := x
        this.Array.Height := y
    }

    __Item[ x, y ] {
        get {
            if ( this.Array.Has( this.i[ x, y ] ) ) {
                return this.Array[ this.i[ x, y ] ]
            }
            else {
                return false
            }
        }
        Set {
            this.Array[ this.i[ x, y ] ] := Value
            return Value
        }
    }

    i[ x, y ] {
        Get {
            return this.Array.Width * ( y - 1 ) + x
        }
    }
}

grid := Array2D(4, 3)
grid[4, 1] := "#"
MsgBox( grid[4, 1] )
/*
grid[3, 2] := "#"
grid[2, 2] := "#"
grid[1, 3] := "#"
gridtext := ""
Loop grid.Array.Height {
    y := A_Index
    Loop grid.Array.Width {
        x := A_Index
        gridtext .= grid[x, y] || "-"
    }
    gridtext .= "`n"
}
MsgBox gridtext