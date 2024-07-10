#Include LowLevelMouseProc_wParam.ahk
;#Include CaptorScreen.ahk
#Include InstallHook.v2.ahk
#Include ProcessSharedData.ahk

; Consulte LeftDownUp.ahk

f_flag := 0

;Dados a serem compartilhados - ProcessSharedData.ahk
sharedData := {}

; Cria um mutex sem dono inicial - ProcessSharedData.ahk
ghMutex := DllCall("CreateMutex", "ptr", 0, "int", 0, "ptr", 0, "ptr")
if !ghMutex {
    MsgBox( "CreateMutex error: " DllCall("GetLastError", "UInt") )
    ExitApp()
}

InstallHookMKV2( 14 )

Esc::ExitApp()