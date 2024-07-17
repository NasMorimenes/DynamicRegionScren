; Proj: Cria um objeto que poderá ou não ser um modelo.
; 
/*
Rectangle := { Call: CallRect2 }

CallRect2( Rectangle, xTop, yTop, xBotton, yBotton ) {

    Top := {}
    Top.Call := Point.Call
    Rectangle.Top := Top( xTop, yTop )
    Top := ""
    Botton := {}
    Botton.Call := Point.Call
    Rectangle.Botton := Botton( xBotton, yBotton )
    Botton := ""

    return Rectangle
}

CallRect( Rectangle, xTop, yTop, xBotton, yBotton ) {

    Rectangle.Top := Point( xTop, yTop )
    Point := ""
    
    Rectangle.Botton := Point( xBotton, yBotton )
    Point := ""

    return Rectangle
}

Point := { Call: CallPoint }

CallPoint( Point, x, y  ) {
    static RefPoint := 0
    Point.x := x
    Point.y := y

    return Point
}
Rect := Rectangle( 10, 20, 15, 25 )
TopX := Rect.Top.x
MsgBox( Rect.Top.x "`n" Rect.Top.y "`n" Rect.Botton.x "`n" Rect.Botton.y ) ;"`n" Rectangle.Top.y )
*/

;ProtoPoint := { Call:Call }

;Call( param* ) {
;    RegExMatch( param[ 2 ], "((\w+)\d+)+", &match )
;    MsgBox( match[ 0 ] )
;        }
;
;ProtoPoint( "xt10 cg20" )   

; Define a string desconhecida
text := "d28 rel10"

; Define a expressão regular para localizar padrões como \w+\d+
pattern := "((\w+\d+)\s*)* "
RegExMatch(text, pattern, &match )
