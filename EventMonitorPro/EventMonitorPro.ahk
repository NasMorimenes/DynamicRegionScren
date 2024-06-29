#Include UnhookAll.ahk
#Include SetHook.ahk
#Include Keyboard.ahk
#Include MoveMouse.ahk


Esc::ExitApp()

;Persistent
DEBUG_OUTPUT := TRUE
LOG_TO_FILE := TRUE
WH_KEYBOARD_LL := 13
WH_MOUSE_LL := 14

OnExit( UnhookAll )

; Initialize Hooks
andressK := CallbackCreate( Keyboard )
andressM := CallbackCreate( MoveMouse )
hHookKeybd := SetHook( WH_KEYBOARD_LL, andressK )
hHookMouse := SetHook( WH_MOUSE_LL, andressM )