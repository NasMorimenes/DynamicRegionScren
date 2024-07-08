; Variável global para armazenar a distância total
totalDistance := 0

; Função para calcular a distância usando WHEEL_DELTA
;WheelDeltaHandler(delta) {
;    totalDistance += delta
;    ToolTip( "Total Distance: " totalDistance )
;}

; Hotkey para detectar rotação da roda do mouse
MyGui := Gui("+Resize ", "Example Window")
MyGui.Add("Text",, "Click anywhere in this window.")
;MyGui.Add("", "w200 h800")
MyGui.Show( "w200 h500" )
;Persistent
;hwnd := WinActive( "A" )

OnMessage( 0x020A, WM_MOUSEWHEEL )

WM_MOUSEWHEEL( wParam, lParam, msg, hwnd ) {
    ;X := wParam >> 16
    delta := NumGet( wParam , 2, "short" )
    ToolTip( X )
    ;delta := NumGet( wParam , 0,"Int" ) >> 16
    ;WheelDeltaHandler(delta)
    return
}
