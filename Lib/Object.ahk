Ass := soma
dff := soma.Bind( 1 )
MsgBox(  dff(  ) )
;Prototype {__Class: "Func", Bind: Func, Call: Func, IsBuiltIn: 0, IsByRef: Func, IsOptional: Func, IsVariadic: 0, MaxParams: 2, MinParams: 2, Name: "soma"}
;Prototype {__Class: "Func", Bind: Func, Call: Func, IsBuiltIn: 0, IsByRef: Func, IsOptional: Func, IsVariadic: 0, MaxParams: 2, MinParams: 1, Name: "soma"}
;Cria o Objeto
soma( x, y := 0 ) {
    return x + y
}


;b := soma

;ass := b.Bind( x, y )  

/*
for Name, Values in Ass.Base.OwnProps() {
    MsgBox( Name )
    for Name in %Name%.OwnProps() {
        MsgBox( Name )
    }
}
