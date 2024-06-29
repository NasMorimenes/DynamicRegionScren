Ass := Param( "x10" )
pOne := Ass.Get( 1 )

class Param {
    ;params := {}

    __New(input) {
        this.Parse(input)
    }

    Parse( input ) {
        Loop Parse, input, A_Space {
            if RegExMatch( A_LoopField, "([a-z]+)(\d+)", &match) {
                this.params := match
            }
        }
    }

    Get( key ) {
        return this.params[ key ]
    }

    Set(key, value) {
        this.params[key] := value
    }

    ToString() {
        result := ""
        for key, value in this.params
            result .= key . value . " "
        return Trim(result)
    }
}

