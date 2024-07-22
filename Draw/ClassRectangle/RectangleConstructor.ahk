;GdipC( 20, 10, 15 )

;_CoordX := CoordX(  )
;_CoordY := CoordY( 5 )
;MsgBox( _CoordX.GetCoordX() )
;_CoordX.SetCoordX( 20 )
;_CoordX[ 1 ] := 20
;_CoordX.SetCoordX( 5 )
;MsgBox( _CoordX.GetCoordX() )


;PontoA := Point( _CoordX, _CoordY )
;PontoA.X := 30
;MsgBox( PontoA.X )


;#x:: {
;}

;PontoA.SetPointX( _CoordX )
;PontoA.GetPointX()
;PointA.SetPointY( _CoordY )
;PointA.

/*
New( params* ) {
    switch params.Length {
        case 0:
            MsgBox( "Vazio" )
        case 3:
            MsgBox( "Vazio" )
        case 2:
            ;if ( ( params[1].__Class == "GdipC.Point") && (params[2].__Class == "GdipC.Size")) {
            if ( IsObject( params[ 1 ] ) && IsObject( params[ 2 ] ) ) {
                MsgBox( "Objects" )
            }

        default:
            throw "Incorrect number of parameters for "  A_ThisFunc
    }
}

Class GdipC {
    static Size := 0
    static Point := { x : 0, y : 0}
    __New( ds, xp, yp ) {
        this.dsSet( ds )
        this.xpSet( xp )        
        this.ypSet( yp )
    }
    dsGet() {
        return GdipC.Size
    }
    xpGet() {
        return GdipC.Point.x
    }
    ypGet() {
        return GdipC.Point.y
    }
    dsSet( ds ) {
        GdipC.Size := ds
    }
    ypSet( yp ) {
        GdipC.Point.y := yp
    }
    xpSet( xp ) {
        GdipC.Point.x := xp
    }
}
*/
class Point {

    __New( objCoordX, objCoordY ) {

        this.ObjPointCoordX := objCoordX
        this.ObjPointCoordY := objCoordY

        this.SetPointX( objCoordX.x )
        this.SetPointY( objCoordY.y )
    }

    SetPointX( x := 0 ) {        
        this.ObjPointCoordX.SetCoordX( x )
    }

    GetPointX() {
        return this.ObjPointCoordX.GetCoordX()
    }

    SetPointY( y := 0 ) {
        this.Y := this.ObjPointCoordY.Y
    }

    GetPointY() {
        return this.Y
    }
}

xTop := CoordX()
MsgBox( xTop[1] )
xTop[ 1 ] := 10
MsgBox( xTop[1] )

class CoordX {

    __New() {
        this.Access := false
        this[ 1 ] := 0
    }

    __Item[ x ] {
        Get {
            ;static _x := 0            
            ;;if ( this.Access == true ) {
            ;;    this.Access := false
            ;;    if ( HasProp( this, "x" ) ) {
            ;;        _x := this.x
            ;;        this.DeleteProp( "x" )
            ;;        return 0
            ;;    }
            ;;    else {
                    Value := this.x
                    return Value
            ;;    }
            ;;}
            ;;else {
            ;;   throw( "Erro ao atribuir Propriedade")
            ;;}
        }
        Set {
            ;;if ( this.Access == false ) {
            ;;    this.Access := true
               ;this[ x ] := Value
               this.x := Value
            ;    this[ 1 ]
            ;;}
        }
    }


    /*
    SetCoordX( x ) {
        
        if ( this.Access == false ) {
            this.Access := true
            this.x := x
            this.GetCoordX()
        }
    }
    
    GetCoordX() {
        
        static x := 0

        if ( this.Access == true ) {
            this.Access := false
            if ( HasProp( this, "x" ) ) {
                x := this.x
                this.DeleteProp( "x" )
                return 0
            }
            else {
                return x
            }
        }
        else {
            throw( "Erro ao atribuir Propriedade")
        }    
    }
    */
}

class CoordY {

    __New( y ) {
        this.Access := false
        this.SetCoordY( y )
    }

    SetCoordY( y ) {
        
        if ( this.Access == false ) {
            this.Access := true
            this.y := y
            this.GetCoordY()
        }
    }
    
    GetCoordY() {
        
        static y := 0

        if ( this.Access == true ) {
            this.Access := false
            if ( HasProp( this, "y" ) ) {
                y := this.y
                this.DeleteProp( "y" )
                return 0
            }
            else {
                return y
            }
        }
        else {
            throw( "Erro ao atribuir Propriedade")
        }
    }
}
    

/*
__New(params*) {
			c := params.MaxIndex()
			if (c == "") {
				this.x := 0
				this.y := 0
				this.Width := 0
				this.Height := 0
			}
			else if (c == 4)
			{
				this.x := params[1]
				this.y := params[2]
				this.width := params[3]
				this.height := params[4]
			}
			else if (c == 2)
			{
				if ((params[1].__Class == "GdipC.Point") && (params[2].__Class == "GdipC.Size")) {
					this.x := params[1].x
					this.y := params[1].y
					this.width := params[2].width
					this.height := params[2].height
				}
				Else
					throw "Wrong parameter types for "  A_ThisFunc
			}
			else
				throw "Incorrect number of parameters for "  A_ThisFunc
			
		}