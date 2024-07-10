#Include Includes.ahk

global ghMutex
global sharedData := {}

; Callback do hook de teclado
LowLevelKeyboardProc(nCode, wParam, lParam) {
    global ghMutex, sharedData

    if (nCode >= 0) {
        ; Bloqueia o mutex
        if DllCall("WaitForSingleObject", "ptr", ghMutex, "int", 0xFFFFFFFF, "UInt") = 0x00000000 {
            try {
                ; Compartilha lParam e wParam
                sharedData.wParam := wParam
                sharedData.lParam := lParam

                ; Processa os dados compartilhados
                ProcessSharedData()
            } finally {
                ; Libera o mutex
                if !DllCall("ReleaseMutex", "ptr", ghMutex)
                    MsgBox, Erro ao liberar o mutex.
            }
        }
    }
    return DllCall("CallNextHookEx", "ptr", 0, "int", nCode, "uint", wParam, "ptr", lParam)
}

; Função para processar os dados compartilhados
ProcessSharedData() {
    global sharedData
    ; Processa lParam e wParam
    MsgBox, lParam: %sharedData.lParam%`nwParam: %sharedData.wParam%
}

; Instala o hook de teclado
InstallHook() {
    global ghMutex

    ; Cria um mutex sem dono inicial
    ghMutex := DllCall("CreateMutex", "ptr", 0, "int", 0, "ptr", 0, "ptr")
    if !ghMutex {
        MsgBox, CreateMutex error: %DllCall("GetLastError", "UInt")%
        return 1
    }

    ; Instala o hook de teclado
    hookID := DllCall("SetWindowsHookEx", "int", 13, "ptr", RegisterCallback("LowLevelKeyboardProc", "Fast"), "ptr", DllCall("GetModuleHandle", "ptr", 0), "uint", 0, "ptr")
    if !hookID {
        MsgBox, SetWindowsHookEx error: %DllCall("GetLastError", "UInt")%
        return 1
    }

    ; Mantém o script rodando
    OnExit("UninstallHook")
    return hookID
}

; Remove o hook de teclado e fecha o mutex
UninstallHook() {
    global hookID, ghMutex
    DllCall("UnhookWindowsHookEx", "ptr", hookID)
    DllCall("CloseHandle", "ptr", ghMutex)
}

; Chama a função para instalar o hook
InstallHook()

; Hotkey para encerrar o script
^Esc::ExitApp
