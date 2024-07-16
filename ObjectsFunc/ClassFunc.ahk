mySoma := soma
;MsgBox( soma.Prototype.Call( 10, 5 ) )
;MsgBox mySoma.name

class soma {
    /*
    __New( a, b ) {
        return this.Call( a, b )
    }

    Call( a, b ) {
        return a + b
    }
    static name := soma.__Class
    */
}

;Prototype {__Class: "soma"}
;Class {__Init: Func, Prototype: Prototype }
;mySoma := Class {__Init: Func, Prototype: Prototype}
;Prototype := {__Class: "soma"}
;<base> := Class {Call: Func, Prototype: Prototype}
;Soma := Class {__Init: Func, Prototype: Prototype}
; <base> Class {Call: Func, Prototype: Prototype}