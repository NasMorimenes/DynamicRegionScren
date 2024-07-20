x := CoordX()
x.xSet( 10 )
MsgBox( x.xGet() )
x.xSet( 11 )
MsgBox( x.xGet() )
/*
CoordY( 25 )
Fdd := Point( x, y )
;Fdd( x, y )
MsgBox(Fdd.x )
x.xSet( 20 )
MsgBox(Fdd.x )
*/
class CoordX {   
    static x := 0 
    __New( x := 0 ) {
        CoordX.x := this.xSet( x )
    }
    xGet() {        
        return CoordX.x
    }
    xSet( x ) {
        CoordX.x := x
    }
}


class CoordY {    
    __New( y := 0 ) {
        this.y := y
    }
    yGet() {
        return this.y
    }
    ySet( y ) {
        this.y := y
    }
}

class Point {

    ;static Call( xPoint, yPoint ) {
    __New( xPoint, yPoint) {
        this.x := xPoint.x
        this.y := yPoint.y
    }
    GetPoint() {
        return [this.x.xGet(), this.y.yGet()]
    }
}



/*

CoordX := { x : Call }
CoordY := { y : Call }
;Point := { x : ObjBindMethod( CoordX, "x", 1 ).x, y : CoordY.y }
;Rect := {}

MsgBox( CoordX.x( 10 ) )
;Point.y( 2 )

;MsgBox( Point.x ) ;* Point.y( 2 ) )

Call( this, x ) {
    this.__New( x ) {
        this.x := x
    }
	
}
