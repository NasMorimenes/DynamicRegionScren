/** 
 * https://learn.microsoft.com/pt-br/windows/win32/winmsg/hooks
 * 
 * instalação do Hook:
 * ----
 * ilustration
 * ---
 * param idHook \
 * \
 * hook \
 * msgSource ---------
 */
InstallHook( &idHook ) {
    if (Type(idHook) = "String") {
        switch idHook {
            case "WH_CALLWNDPROC":               ;XXXXXXXXXXXXXXXXXXXXX Pilha1 XXXXXXXXXXXXXXXXXXXX
                idHook := 4
                CallWndProc()
            case "WH_CALLWNDPROCRET":
                idHook := 12
            case "WH_CBT":
                idHook := 5
            case "WH_DEBUG":
                idHook := 9
            case "WH_FOREGROUNDIDLE":
                idHook := 11
            case "WH_GETMESSAGE":
                idHook := 3
            case "WH_JOURNALPLAYBACK":
                idHook := 1
            case "WH_JOURNALRECORD":
                idHook := 0
            case "WH_KEYBOARD":
                idHook := 2
            case "WH_KEYBOARD_LL":
                idHook := 13
            case "WH_MOUSE":
                idHook := 7
            case "WH_MOUSE_LL":
                idHook := 14
            case "WH_MSGFILTER":
                idHook := -1
            case "WH_SHELL":
                idHook := 10
            case "WH_SYSMSGFILTER":
                idHook := 6
        }
    } else if (Type(idHook) = "Integer") {
        ; Caso idHook seja um número, não é necessário fazer nada, pois já é o valor correto
        ; Adicione aqui, se necessário, algum processamento adicional para valores numéricos
    }
    idHook := defHook( &idHook )
}

/**
 * https://learn.microsoft.com/pt-br/windows/win32/winmsg/callwndproc
 */
CallWndProc( nCode, wParam, lParam ) {               ;XXXXXXXXXXXXXXXXXXXXX Pilha2 XXXXXXXXXXXXXXXXXXXX

    sintaxe := "
    (
        LRESULT CALLBACK CallWndProc(
            _In_ int    nCode,
            _In_ WPARAM wParam,
            _In_ LPARAM lParam 
        `);
    )"

    HookStructs()             ;XXXXXXXXXXXXXXXXXXXXX Pilha3 XXXXXXXXXXXXXXXXXXXX

    return CallNextHookEx( &hhk, nCode, wParam, lParam )
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

HookStructs() {
    CWPSTRUCT()               ;XXXXXXXXXXXXXXXXXXXXX Pilha4 XXXXXXXXXXXXXXXXXXXX
}


/**
 * https://learn.microsoft.com/pt-br/windows/win32/api/winuser/ns-winuser-cwpstruct
 * 
 */
CWPSTRUCT()  {               ;XXXXXXXXXXXXXXXXXXXXX Pilha5 XXXXXXXXXXXXXXXXXXXX

    sintaxe := "
    (
        typedef struct tagCWPSTRUCT {
            LPARAM lParam;
            WPARAM wParam;
            UINT   message;
            HWND   hwnd;
        } CWPSTRUCT, *PCWPSTRUCT, *NPCWPSTRUCT, *LPCWPSTRUCT;
    )"

    get() {

    }
    lParam := Buffer( 8, 0 )
    wParam := Buffer( 8, 0 )
    message := Buffer( 8, 0 )
    hwnd := Buffer( 8, 0 )

    ObjAdHoks() {               ;XXXXXXXXXXXXXXXXXXXXX Pilha6 XXXXXXXXXXXXXXXXXXXX
        Set_LPARAM() {

        }
        CWPSTRUCT := { _LPARAM : lParam, _WPARAM : wParam, _message: message, _HDND : hwnd }    
    }

    _CWPSTRUCT := Buffer( 32, 0 )

    MsgBox( sintaxe )
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

