#Requires AutoHotkey v2.0

Esc::ExitApp

OnMessage 0x0200, WM_LBUTTONDOWN

hwnd := WinActive( "A" )


WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {

	dpi := A_ScreenDPI / 96
    X := ( lParam & 0xFFFF ) * dpi
    Y := ( lParam >> 16 ) * dpi

}