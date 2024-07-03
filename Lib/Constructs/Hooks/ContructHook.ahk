; https://learn.microsoft.com/pt-br/windows/win32/winmsg/hooks
;instalação do Hook:
InstallHook() {

    idHook := defHook( &idHook )
}
; Defini tipo de gancho a ser instalado - defHook
/**
 * https://learn.microsoft.com/pt-br/windows/win32/api/winuser/nf-winuser-setwindowshookexw
 * @param idHook O tipo de procedimento de gancho a ser instalado
 */
defHook( &idHook ) {

    return idHook
}
/**
 * https://learn.microsoft.com/pt-br/windows/win32/winmsg/hooks
 * @description Um ponteiro para o procedimento de gancho. Se o parâmetro dwThreadId for zero ou especificar o identificador de um thread criado por um processo diferente, o parâmetro lpfn deverá apontar para um procedimento de gancho em uma DLL. Caso contrário, lpfn pode apontar para um procedimento de gancho no código associado ao processo atual.
 * @param lpfn 
 */
HOOKPROC( &lpfn ) {

}

/**
 * https://learn.microsoft.com/pt-br/windows/win32/api/winuser/nf-winuser-setwindowshookexw
 * 
 */
SetWindowsHookEx() {

}


/**
 * https://learn.microsoft.com/pt-br/windows/win32/api/winuser/nf-winuser-callnexthookex
 * 
 * @param hhk Este parâmetro é ignorado.
 * @param nCode O código de gancho passado para o procedimento de gancho atual.
 * @param wParam O valor wParam passado para o procedimento de gancho atual.
 * @param lParam O valor lParam passado para o procedimento de gancho atual.
 * @returns LRESULT Esse valor é retornado pelo próximo procedimento de gancho na cadeia.
*/
CallNextHookEx( &hhk, nCode, wParam, lParam ) {
    hhk := 0
    LRESULT :=
    DllCall(
        "CallNextHookEx",
        "UPtr", hhk,
        "Int", nCode,
        "Ptr", wParam,
        "UPtr", lParam,
        "UInt"
    )

    return LRESULT
}




CallWndProc( nCode, wParam, lParam ) {

    if ( nCode >= 0 ) {
        Processing( uMsg )
    }
    else {
        CallNext
    }

    ; Comparação com MoveMouse que é uma LowLevelMouseProc
}


/**
 * 
 * @param nCode O identificador da mensagem do mouse.
 * @param wParam 
 * @param lParam 
 */
LowLevelMouseProc( nCode, wParam, lParam ) {
    
    
    if ( nCode > 0 ) {
        if ( nCode = 0 ) {
            ;HC_ACTION - Os parâmetros wParam e lParam contêm informações sobre uma mensagem do mouse.
            LowLevelMouseProc_wParam( wParam )
        }
        else {

        }
    }

    LRESULT := CallNextHookEx( &x, nCode, wParam, lParam )

    return LRESULT
}


;MsgBox LowLevelMouseProc_wParam( "WM_LBUTTONDOWN" )

LowLevelMouseProc_wParam( param ) {

    WM_LBUTTONDOWN() {
        
        uMsg := 0x0201

        return "LButton Pressionado"
    }
    
    WM_LBUTTONUP() {
        
        uMsg :=

        return "LButton Soltado"
    }
    
    WM_MOUSEMOVE() {
        
        uMsg :=

        return "Mouse Movido"
    }
    
    WM_MOUSEWHEEL() {
        
        uMsg :=

        return "Roda Mouse "
    }
    
    WM_RBUTTONDOWN() {
        
        uMsg :=

        return "RButton Pressionado"
    }
    
    WM_RBUTTONUP() {
        
        uMsg :=

        return "RButton Soltado"
    }

    return %param%.Call()
}
/*
    MoveMouse( nCode, wParam, lParam ) {
        Critical
        static lastMouseMove := A_TickCount
        if (!nCode && wParam == 0x200)  ; WM_MOUSEMOVE
        {
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

        LRESULT := CallNextHookEx( nCode, wParam, lParam )

        return LRESULT
    }
    */

;tipo de procedimento de gancho a ser instalado.

HooksTypes( type ) {

    WH_CALLWNDPROC() {
        return 2
    }

    WH_MOUSE_LL() {
        return 14
    }

    WH_CALLWNDPROCRET() {
        return 12
    }
}

Processing( uMsg ) {
    return
}
wParam() {

}

lParam() {

}

