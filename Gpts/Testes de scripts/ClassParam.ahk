class Param {
    static Call(param1, param2) {
        this.__New(param1, param2)
    }
    
    __New(param1, param2) {
        this.param1 := param1
        this.param2 := param2
    }

    Display() {
        MsgBox, Param1: %this.param1% - Param2: %this.param2%
    }
}

myParam := Param("Value1", "Value2")
myParam.Display()
