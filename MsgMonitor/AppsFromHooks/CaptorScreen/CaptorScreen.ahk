#Include InstallHook.ahk
#Include MouseDownUp.ahk


GuiResize(  xPosIni, yPosIni, xPosFim, yPosFim ) {

    static _Left := 0
	static _Right := 0
	static _Up := 0
	static _Down := 0
	;static dataGui := Buffer( 0, 0 )
	static OptGuiCreate := " -Caption +AlwaysOnTop +E0x000800 "
	static OptGuiShow := "x0 y0 w0 h0"
    static nCapt := 0
	static w := 2
	static h := 2

    if ( ( xPosIni == "" ) && ( yPosIni == "" ) ) {
        ++nCapt
        for i, j in [ "_Left", "_Right", "_Up", "_Down" ] {
            %j% := Gui( OptGuiCreate , j nCapt )
            %j%.BackColor := "FF0000"
            %j%.Show( OptGuiShow )
        }

        return
    }

    Ass :=
	    (
	    ""
	    ( xPosIni < xPosFim and yPosIni < yPosFim ) ""
	    ( xPosIni > xPosFim and yPosIni < yPosFim ) ""
	    ( xPosIni > xPosFim and yPosIni > yPosFim ) ""
	    ( xPosIni < xPosFim and yPosIni > yPosFim )
	    ""
	    )

        XiG := xPosIni
        YiG := yPosIni
        XsG := xPosFim
        YsG := yPosFim

        switch {
            case Ass = "0100":
                Swap( &XiG, &XsG )

            case Ass = "0010":
                Swap( &XiG, &XsG, &YiG, &YsG )

            case Ass = "0001":
                Swap( &YiG, &YsG )
        }

    _Left.Move( 	XiG - w
                  , YiG - h
                  , w
                  , Abs( yPosIni - yPosFim ) + ( 2 * h ) + 1 )
    _Right.Move( 	XsG + 1
                  , YiG - h
                  , w
                  , Abs( yPosIni - yPosFim ) + ( 2 * h ) + 1 )
    _Up.Move( 		XiG - w
                  , YiG - h
                  , Abs( xPosIni -  xPosFim ) + ( 2 * w ) + 1
                  , h )
    _Down.Move( 	XiG - w
                  , YsG + 1
                  , Abs( xPosIni -  xPosFim ) + ( 2 * w ) + 1
                  , h )

    ;NumPut( "Int", XiG
    ;      , "Int", YiG
    ;      , "Int", Abs( xPosFim - xPosIni ) + 1
    ;      , "Int", Abs( yPosFim - yPosIni ) + 1
    ;      , dataGui )



    Swap(s*) {

        Loop ( s.Length // 2 ) {
    
            ssd := ( A_Index - 1 ) * 2
            Ass := Buffer( 8 , 0 )
            NumPut( "Int", %s[ ssd + 1 ]% , Ass, 0 )
            NumPut( "Int", %s[ ssd + 2 ]% , Ass, 4 )
            %s[ ssd + 2 ]%  := NumGet( Ass, 0, "Int" )
            %s[ ssd + 1 ]%  := NumGet( Ass, 4, "Int" )
        }
        Ass := Buffer( 0 )
    }

}



;Usage

/*
assd := fnCaptorScreen()

xG := NumGet( assd, 0, "Int" )
yG := NumGet( assd, 4, "Int" )
wG := NumGet( assd, 8, "Int" )
hG := NumGet( assd, 12, "Int" )

RectGui := Gui(" -Caption +AlwaysOnTop +E0x000800 ")
RectGui.BackColor := "00FF00"
RectGui.Show( "x" xG " y" yG " w" wG " h" hG)

MsgBox( "xG - " xG "`nyG - " yG "`nwG - " wG "`nhG - " hG )
Esc::ExitApp
*

fnCaptorScreen( Key1 := "LButton"
			  , Key2 := "LButton" ) {

	if ( A_CoordModeMouse != "Mouse" ) {
		CoordMode( "Mouse" )
	}

	static _Left := 0
	static _Right := 0
	static _Up := 0
	static _Down := 0
	static dataGui := Buffer( 0, 0 )
	static OptGuiCreate := " -Caption +AlwaysOnTop +E0x000800 "
	static OptGuiShow := "x0 y0 w0 h0"
	static w := 2
	static h := 2


	for i, j in [ "_Left", "_Right", "_Up", "_Down" ] {
		%j% := Gui( OptGuiCreate , j)
		%j%.BackColor := "FF0000"
		%j%.Show( OptGuiShow )
	}

	KeyWait( Key1, "D" )
	if ( Key1 = Key2) {
		Sleep( 150 )
	}

	Loop {

		if ( !KeyWait( Key2, "D T0,1" ) ) {

			MouseGetPos( &xCoordIni, &yCoordIni )

			if ( A_Index = 1 ) {
				xCoordFim := xCoordIni + 1
				yCoordFim := yCoordIni + 1
				dataGui := Buffer( 16, 0 )
			}


			Ass :=
				(
				""
				( xCoordIni < xCoordFim and yCoordIni < yCoordFim ) ""
				( xCoordIni > xCoordFim and yCoordIni < yCoordFim ) ""
				( xCoordIni > xCoordFim and yCoordIni > yCoordFim ) ""
				( xCoordIni < xCoordFim and yCoordIni > yCoordFim )
				""
				)

			XiG := xCoordIni
			YiG := yCoordIni
			XsG := xCoordFim
			YsG := yCoordFim

			switch {
				case Ass = "0100":
					Swap( &XiG, &XsG )

				case Ass = "0010":
					Swap( &XiG, &XsG, &YiG, &YsG )

				case Ass = "0001":
					Swap( &YiG, &YsG )
			}
			;Sleep 50

			_Left.Move( 	XiG - w
							, YiG - h
							, w
							, Abs( yCoordIni - yCoordFim ) + ( 2 * h ) + 1 )
			_Right.Move( 	XsG + 1
							, YiG - h
							, w
							, Abs( yCoordIni - yCoordFim ) + ( 2 * h ) + 1 )
			_Up.Move( 		XiG - w
							, YiG - h
							, Abs(xCoordIni -  xCoordFim ) + ( 2 * w ) + 1
							, h )
			_Down.Move( 	XiG - w
							, YsG + 1
							, Abs(xCoordIni -  xCoordFim ) + ( 2 * w ) + 1
							, h )
			NumPut( "Int", XiG
					, "Int", YiG
					, "Int", Abs( xCoordFim - xCoordIni ) + 1
					, "Int", Abs( yCoordFim - yCoordIni ) + 1
					, dataGui )
		}
		else {
			break
		}
	}

	return dataGui

	Swap(s*) {

		Loop ( s.Length // 2 ) {

			ssd := ( A_Index - 1 ) * 2
			Ass := Buffer( 8 , 0 )
			NumPut( "Int", %s[ ssd + 1 ]% , Ass, 0 )
			NumPut( "Int", %s[ ssd + 2 ]% , Ass, 4 )
			%s[ ssd + 2 ]%  := NumGet( Ass, 0, "Int" )
			%s[ ssd + 1 ]%  := NumGet( Ass, 4, "Int" )
		}
		Ass := Buffer( 0 )
	}
}