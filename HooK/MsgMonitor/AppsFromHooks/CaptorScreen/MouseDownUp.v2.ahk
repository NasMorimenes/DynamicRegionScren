#Include LowLevelMouseProc_wParam.ahk
;#Include CaptorScreen.ahk
#Include InstallHook.v2.ahk
#Include ProcessSharedData.ahk
#Include C:\Users\morim\OneDrive\DynamicRegionScren\Mutex\ClasseMutex.ahk

; Consulte LeftDownUp.ahk

f_flag := 0
pfn := ProcessSharedData
myMutex := Mutex()
wParam := 0
lParam := 0

;Dados a serem compartilhados via Obj - ProcessSharedData.ahk
;sharedData := {}

;Dados a serem compartilhados via Ponteiro - ProcessSharedData.ahk
sharedData := Buffer( 16, 0 )

; Cria um mutex sem dono inicial - ProcessSharedData.ahk'
ghMutex := myMutex.hMutex
/*
ghMutex := DllCall("CreateMutex", "ptr", 0, "int", 0, "ptr", 0, "ptr")
if !ghMutex {
    MsgBox( "CreateMutex error: " DllCall("GetLastError", "UInt") )
    ExitApp()
}
*/

InstallHookMKV2( 14, , pfn )

Esc::ExitApp()