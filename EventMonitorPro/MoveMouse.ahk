#Include LogDebug.ahk
#Include CallNextHookEx.ahk
#Include QueryMoveMouse.ahk
#Include LowLevelMouseProc_wParam.ahk
#Include MSLLHOOKSTRUCT.ahk

; Mouse Hook Procedure
MoveMouse( nCode, wParam, lParam ) {

    Critical

    static lastMouseMove := A_TickCount
    static dist := 0
    if ( !nCode ) { 
        ;ListVars()
        info := LowLevelMouseProc_wParam( wParam )

        switch info {
            case "Roda Mouse":
                dist := NumGet( lParam, 10, "Short" ) / 120

                if ( dist != dist ) {
                    ToolTip( dist )
                }
                else {
                    ToolTip( dist " s")
                }
                
            default:
                ToolTip()
                
        }
    }

        /*
        if ( info = "Roda Mouse" )  {
            ++dist
            ss:= MSLLHOOKSTRUCT( lParam )
            if ( increment := NumGet( ss, 2, "Short" ) )
            ss1 :=
            (
                NumGet( ss, 0, "Short" ) "`n"
                NumGet( ss, 2, "Short" )
            )
        }
        else {
            dist := 0
        }

        ToolTip( dist )
    }
    
    /*
    if ( !nCode && wParam == 0x200 ) { ; WM_MOUSEMOVE


        xPos := NumGet(lParam, 0, "Int")
        yPos := NumGet(lParam, 4, "Int")
        diffMouseMove := A_TickCount - lastMouseMove
        lastMouseMove := A_TickCount

        ;*************************************************************

        ;if (lastKeyPress = 0) {
        ;    diffMouseMove := 0
        ;}
        ;else{
        ;    diffMouseMove := A_TickCount - lastKeyPress
        ;}
        ;lastKeyPress := A_TickCount
        ;************************************************************

    
        ; Ignorar eventos com Last Move igual a 0
        if (diffMouseMove != 0) {
            info :=
                (
                    "Mouse Moved: X=" xPos
                    " Y=" yPos
                    " Last Move: " diffMouseMove
                )
            SetVar := -1
            QueryMouseMove( SetVar, &lastMouseMove, &xPos, &yPos )

            if ( DEBUG_OUTPUT ) {
                LogDebug(
                    info
                )
            }
        }
        

        ;*************************************************************
        
        info :=
        (
            "Mouse Moved: X=" xPos
            " Y=" yPos
            " Last Move: " diffMouseMove
        )
        if ( DEBUG_OUTPUT ) {
            LogDebug(
                info,
                LOG_TO_FILE
            )
        }
        
    }
    */

    LRESULT := CallNextHookEx( nCode, wParam, lParam )

    return LRESULT
}

/*
MouseMove(nCode, wParam, lParam) {
    Critical
    static lastMouseMove := 0

    if (!nCode && wParam == 0x200) {  ; WM_MOUSEMOVE
        xPos := NumGet(lParam, 0, "Int")
        yPos := NumGet(lParam, 4, "Int")
        if (lastMouseMove = 0) {
            diffMouseMove := 0
        } else {
            diffMouseMove := A_TickCount - lastMouseMove
        }
        lastMouseMove := A_TickCount

        ; Usar QueryMouseMove para definir os valores atuais
        QueryMouseMove(-1, lastMouseMove, xPos, yPos)

        ; Ignorar eventos com Last Move igual a 0
        if (diffMouseMove != 0) {
            info := "Mouse Moved: X=" xPos " Y=" yPos " Last Move: " diffMouseMove
            if (DEBUG_OUTPUT) {
                LogDebug(info, LOG_TO_FILE)
            }
        }
    }

    LRESULT := CallNextHookEx(nCode, wParam, lParam)
    return LRESULT
}