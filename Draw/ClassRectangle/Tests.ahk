class Array2D extends Array {
    __new(x, y) {
        this.Length := x * y
        this.Width := x
        this.Height := y
    }
    __Item[x, y] {
        get => super.Has(this.i[x, y]) ? super[this.i[x, y]] : false
        set => super[this.i[x, y]] := value
    }
    i[x, y] => this.Width * (y-1) + x
}
/*
grid := Array2D(4, 3)
grid[4, 1] := "#"
grid[3, 2] := "#"
grid[2, 2] := "#"
grid[1, 3] := "#"
gridtext := ""
Loop grid.Height {
    y := A_Index
    Loop grid.Width {
        x := A_Index
        gridtext .= grid[x, y] || "-"
    }
    gridtext .= "`n"
}
MsgBox gridtext
*/

dss := Adf()
MsgBox( dss.Hk( 10 ) )

class Adf {
    __New() {
        ;( "New Object" )
    }
    __Get( name, params ) {
        MsgBox( params.Length )
        for i in params {
            MsgBox i
        }
        MsgBox( name " Access Error " ) ;Type( params ) )
    }
    __Set() {
        ;this.__Get()
    }
    __Call( name, params ) {
        MsgBox( params.Length )
        for i, j in params {
            MsgBox i " " j
        }
    }
}