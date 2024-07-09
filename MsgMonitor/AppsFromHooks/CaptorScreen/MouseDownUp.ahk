#Include LowLevelMouseProc_wParam.ahk
#Include CaptorScreen.ahk

; Consulte LeftDownUp.ahk

InstallHookMK( MouseDownUp )

Esc::ExitApp()

MouseDownUp( nCode, wParam, lParam ) {
    ListLines()
    ;static Extenal := Buffer( 16, 0)
    ;static Text := ""
    ;static lastMouseMove := A_TickCount
    ;static dist := 0
    ;static Count := 0
    static iniButton := "LButton Pressionado"
    static fimButton := "LButton Soltado"
    static dinButton := "Mouse Movido"
    ;static stats := 0
    static xPosIni := ""
    static yPosIni := ""
    static xPosFim := 0
    static yPosFim := 0
    global f_flag
    
    if ( !nCode ) {

        info := LowLevelMouseProc_wParam( wParam )

        if ( info == iniButton ) {

            if ( ( xPosIni == "" ) && ( yPosIni == "" ) ) {
                f_flag := 1
                GuiResize( xPosIni, yPosIni, xPosFim, yPosFim )
                
                iniButton := dinButton

                xPosIni := NumGet( lParam, 0, "UInt" )
                yPosIni := NumGet( lParam, 4, "UInt" )

                xPosFim := xPosIni + 1
                yPosFim := yPosFim + 1

                ;GuiResize( xPosIni, yPosIni, xPosFim, yPosFim )

                /*
                NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  0 )
                NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal,  4 )
                NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  8 )
                NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal, 12 )

                xPosIni := NumGet( lParam, 0, "UInt" )
                yPosIni := NumGet( lParam, 4, "UInt" )
                xPosFim := NumGet( lParam, 0, "UInt" )
                yPosFim := NumGet( lParam, 4, "UInt" )
                */
            }
            else {
                ;NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  8 )
                ;NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal, 12 )

                xPosFim := NumGet( lParam, 0, "UInt" )
                yPosFim := NumGet( lParam, 4, "UInt" )

                GuiResize( xPosIni, yPosIni, xPosFim, yPosFim )
                f_flag := 0
            }
            /*
            Text := 
            (
                "xPosIni - " xPosIni "`n"
                "yPosIni - " yPosIni "`n"
                "xPosFim - " xPosFim "`n"
                "yPosFim - " yPosFim
            )            
            ToolTip( Text )
            */
        }
        else if ( info == fimButton ) {

            ;NumPut( NumGet( lParam, 0, "UInt" ), "UInt", Extenal,  8 )
            ;NumPut( NumGet( lParam, 4, "UInt" ), "UInt", Extenal, 12 )
            
            xPosFim := NumGet( lParam, 0, "UInt" )
            yPosFim := NumGet( lParam, 4, "UInt" )

            GuiResize( xPosIni, yPosIni, xPosFim, yPosFim )

            iniButton := "LButton Pressionado"
            
            xPosIni := ""
            yPosIni := ""            
            f_flag := 0
            /*
            Text := 
            (
                "xPosIni - " xPosIni "`n"
                "yPosIni - " yPosIni "`n"
                "xPosFim - " xPosFim "`n"
                "yPosFim - " yPosFim
            )
            
            ToolTip()
            */
        }
    }
}

;Verf_flag