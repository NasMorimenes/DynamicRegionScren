#Include <ClassHook>
#Include <ClassMouseHook>
#Include <ClassMutex.V0>

sharedData := Buffer( 16, 0)  ; 8 bytes para wParam e 8 bytes para lParam
andressCallBack := CallbackCreate( ProcessSharedData )

; Instanciar e definir o hook de mouse
myMouseHook := MouseHook( andressCallBack, sharedData )
myMouseHook.SetMouseHook()

ProcessSharedData() {
    global sharedData
    wParam := NumGet(sharedData, 0, "UIntPtr")
    lParam := NumGet(sharedData, 8, "Ptr")
    ; Processar os dados conforme necessário
    ToolTip("wParam: " wParam "`nlParam: " lParam)
}


; Mantém o script em execução
/*
Loop {
    Sleep( 100 )
    if ( A_PriorHotkey = "Escape" ) {
        Break
    }
}
*/
Esc::ExitApp()
