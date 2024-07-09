MouseDownUp( nCode, wParam, lParam ) {
    static Extenal := Buffer( 16, 0)
    static Text := ""
    static lastMouseMove := A_TickCount
    static dist := 0
    static Count := 0
    static iniButton := "LButton Pressionado"
    static fimButton := "LButton Soltado"
    static dinButton := "Mouse Movido"
    static stats := 0
    static xPosIni := ""
    static yPosIni := ""
    
    if ( !nCode ) {

        info := LowLevelMouseProc_wParam( wParam )

        if ( info == iniButton ) {

            if ( xPosIni == "" && yPosIni == "" ) {
                
                iniButton := dinButton

                NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  0 )
                NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal,  4 )
                NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  8 )
                NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal, 12 )

                xPosIni := NumGet( lParam, 0, "UInt" )
                yPosIni := NumGet( lParam, 4, "UInt" )
                xPosFim := NumGet( lParam, 0, "UInt" )
                yPosFim := NumGet( lParam, 4, "UInt" )
            }
            else {
                NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  8 )
                NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal, 12 )
                xPosFim := NumGet( lParam, 0, "UInt" )
                yPosFim := NumGet( lParam, 4, "UInt" )
            }

            Text := 
            (
                "xPosIni - " xPosIni "`n"
                "yPosIni - " yPosIni "`n"
                "xPosFim - " xPosFim "`n"
                "yPosFim - " yPosFim
            )            
            ToolTip( Text )
    
        }
        else if ( info == fimButton ) {

            NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  8 )
            NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal, 12 )
            
            xPosFim := NumGet( lParam, 0, "UInt" )
            yPosFim := NumGet( lParam, 4, "UInt" )
            iniButton := "LButton Pressionado"
            Text := 
            (
                "xPosIni - " xPosIni "`n"
                "yPosIni - " yPosIni "`n"
                "xPosFim - " xPosFim "`n"
                "yPosFim - " yPosFim
            )
            
            ToolTip()
        }
    }
}
