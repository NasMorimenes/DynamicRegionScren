#Include <Gdip_OnOff>
#Include <GDIP_V2>
#Include <DesktopFromGui>

; Inicializa GDIP
GraphicalDesktop( &myGui, Opt_E, Title, Opt_S, &HWND := 0 ) {
    
    global pToken

    if !pToken := Gdip_OnOff() {
        MsgBox( "Falha ao iniciar GDIP.", "Erro", 48 )
        ExitApp
    }

    ; Cria a GUI principal
    HWND :=
    DesktopFromGui(
        myGui,
        Opt_E,
        Title,
        Opt_S
    )
    ;myGui.OnEvent( "Close", Func ) ;Não necessário por enquanto
    return HWND
}