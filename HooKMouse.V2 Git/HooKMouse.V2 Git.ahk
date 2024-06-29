
DEBUG_OUTPUT := false
WH_MOUSE_LL := 14

   
andress := CallbackCreate( MouseMove )
hHookMouse:= SetHook( WH_MOUSE_LL, andress )

OnExit( Unhook )

;Esc::ExitApp() ; Gera loop continuo, semellhante a 'Persistent'


SetHook( idHook, pfn ) {
    hHook := SetWindowsHookEx( idHook, pfn ) ;DllCall("SetWindowsHookEx", "int", idHook, "Ptr", pfn, "Ptr", DllCall("GetModuleHandle", "Ptr", 0), "UInt", 0, "Ptr")
    if ( !hHook ) {
        MsgBox( "Failed to set hook: " idHook )
        ExitApp()
    }
    return hHook
}

MouseMove( nCode, wParam, lParam ) { 

    Critical
    static lastMouseMove := A_TickCount
	If ( !nCode && ( wParam = 0x200 ) ) { 
        
		diffMouseMove := A_TickCount - lastMouseMove
		lastMouseMove := A_TickCount

        Text := 
        (
            " X: " NumGet( lParam , 0, "Int" )
            " Y: " NumGet( lParam , 4, "Int" )
            " Last keypress: " diffMouseMove
        )
        ;ListVars()
		;OutputDebug( Text )

        ;ToolTip( Text )

        setVars := -1
        currTime := A_TickCount
        xPos := NumGet( lParam, 0, "int" )
        yPos := NumGet( lParam, 4, "int" )

        ;ToolTip( QueryMouseMove( setVars, currTime , xPos, yPos ) )

		QueryMouseMove( setVars, currTime , xPos, yPos )
	}
	Return CallNextHookEx( nCode, wParam, lParam ) 
}

CallNextHookEx( nCode, wParam, lParam, hHook := 0 ) {
    ;ListLines()
    
	LRESULT :=
    DllCall(
        "CallNextHookEx",
        "Uint", hHook,
        "int", nCode,
        "Uint", wParam,
        "Uint", lParam
    ) 
    
    Return LRESULT
}

SetWindowsHookEx( idHook, pfn ) {
    hModule := GetModuleHandle()
    hHook :=
    DllCall(
        "SetWindowsHookEx",
        "int", idHook,
        "Ptr", pfn,
        "Ptr", hModule,
        "UInt", 0,
        "Ptr"
    )
    return hHook
}

GetModuleHandle() {

    hModule :=
    DllCall(
        "GetModuleHandle",
        "Ptr", 0,
        "Ptr"
    )

    return hModule
}

UnhookWindowsHookEx( hHook ) { 
    bool :=
    DllCall(
        "UnhookWindowsHookEx",
        "Uint", hHook,
        "int"
    )
	Return bool
} 

Unhook(*) {
    global andress, hHookMouse
    MsgBox( "Saindo" )
    CallbackFree( andress )
    UnhookWindowsHookEx( hHookMouse ) 
}



/*
*   QueryMouseMove()
*       Param[1]: setVars ==  0 --> Consulta as variáveis estáticas QMM
*       Param[1]: setVars == -1 --> Define as variáveis estáticas QMM com os valores fornecidos
*       Param[1]: setVars == -2 --> Limpa (reseta) as variáveis estáticas QMM
*
*   Example, QueryMouseMove(0, lmm, x, y)
*       To retrieve all 3 variables.
*/

QueryMouseMove( setVars := 0, lastMouseMove := 0, xPos := 0, yPos := 0 ) {
    
    global DEBUG_OUTPUT

    static QMM_xPos := 0
    static QMM_yPos := 0
    static QMM_lastMouseMove := 0

    ; Consulta as variáveis estáticas
    if (setVars == 0) {
        xPos := QMM_xPos
        yPos := QMM_yPos
        lastMouseMove := QMM_lastMouseMove
        return lastMouseMove
    }

    ; Define as variáveis estáticas
    if (setVars == -1) {

        QMM_xPos := xPos
        QMM_yPos := yPos
        QMM_diffMouseMove := lastMouseMove - QMM_lastMouseMove
        QMM_lastMouseMove := lastMouseMove
        if (DEBUG_OUTPUT) {
            ToolTip( "X: " xPos " Y: " yPos " Last mouseMove: " QMM_diffMouseMove )
        }
        return TRUE
    }

    ; Limpa as variáveis estáticas
    if (setVars == -2) {
        QMM_xPos := 0
        QMM_yPos := 0
        QMM_lastMouseMove := 0
        return TRUE
    }

    return FALSE ; Caso nenhum dos valores esperados seja fornecido, retorna FALSE
}
/* Explicação das Modificações e Documentação:
Documentação Inicial:

Comentários no início da função explicam o propósito e os parâmetros aceitos pela função QueryMouseMove.
Parâmetros:

setVars: Controla o comportamento da função (0 para consulta, -1 para definir valores, -2 para limpar valores).
byRef lastMouseMove: Variável referenciada que armazenará ou definirá o tempo desde o último movimento do mouse.
byRef xPos: Variável referenciada que armazenará ou definirá a posição X do mouse.
byRef yPos: Variável referenciada que armazenará ou definirá a posição Y do mouse.
Consulta das Variáveis Estáticas (setVars == 0):

Atribui os valores das variáveis estáticas QMM_xPos, QMM_yPos e QMM_lastMouseMove às variáveis referenciadas xPos, yPos e lastMouseMove.
Retorna lastMouseMove.
Definição das Variáveis Estáticas (setVars == -1):

Define as variáveis estáticas QMM_xPos, QMM_yPos e QMM_lastMouseMove com os valores fornecidos.
Calcula QMM_diffMouseMove como a diferença entre lastMouseMove atual e o último QMM_lastMouseMove.
Se DEBUG_OUTPUT estiver ativado, exibe um ToolTip com a posição do mouse e o tempo desde o último movimento.
Retorna TRUE.
Limpeza das Variáveis Estáticas (setVars == -2):

Reseta as variáveis estáticas QMM_xPos, QMM_yPos e QMM_lastMouseMove para 0.
Retorna TRUE.
Caso Padrão:

Se setVars não for nenhum dos valores esperados (0, -1, -2), a função retorna FALSE.