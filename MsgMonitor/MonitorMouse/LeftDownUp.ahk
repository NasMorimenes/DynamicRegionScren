





/*
Text := "Aguarde!"
MouseGetPos( &x, &y )
;ToolTip( Text )
loop {
    if KeyWait( "LButton", "D T0.02" )
        break
    else {
        MouseGetPos( &x1, &y1 )
        if ( Abs( x1 - x ) ) {

        }
    }
        
}

ToolTip()
;Text := "Aguarde!"

Esc::ExitApp()
/*
Ini:
    Ass := KeyWait( "LButton", "D T2" )
    MsgBox( Ass )
GoTo( "Ini")