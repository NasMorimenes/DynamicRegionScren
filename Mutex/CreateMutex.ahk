#Include Includes.ahk
CreateMutex( mutexName ) {

    hMutex :=
    DllCall( 
        "CreateMutex",
        "ptr", 0,
        "int", 0,
        "str", mutexName,
        "ptr"
    )
    return hMutex
}

/*
#Persistent
#NoEnv

; Nome do mutex no espaço de nomes global
mutexName := "Global\BufferMutex"

; Buffer compartilhado
global buffer := ""

; Função para ler do buffer
ReadFromBuffer() {
    global mutexName, buffer

    ; Obter o mutex
    hMutex := DllCall("CreateMutex", "ptr", 0, "int", 0, "str", mutexName, "ptr")
    if (DllCall("GetLastError") = 183) {
        ; Outro processo está acessando o buffer
        MsgBox, Outro processo está acessando o buffer. Tente novamente mais tarde.
        return
    }

    ; Leitura do buffer
    MsgBox, Conteúdo do buffer: %buffer%

    ; Liberar o mutex
    DllCall("ReleaseMutex", "ptr", hMutex)
    DllCall("CloseHandle", "ptr", hMutex)
}

; Função para escrever no buffer
WriteToBuffer(data) {
    global mutexName, buffer

    ; Obter o mutex
    hMutex := DllCall("CreateMutex", "ptr", 0, "int", 0, "str", mutexName, "ptr")
    if (DllCall("GetLastError") = 183) {
        ; Outro processo está acessando o buffer
        MsgBox, Outro processo está acessando o buffer. Tente novamente mais tarde.
        return
    }

    ; Escrita no buffer
    buffer := data
    MsgBox, Dados escritos no buffer: %data%

    ; Liberar o mutex
    DllCall("ReleaseMutex", "ptr", hMutex)
    DllCall("CloseHandle", "ptr", hMutex)
}

; Define hotkeys para leitura e escrita
^r::ReadFromBuffer()
^w::WriteToBuffer("Novo conteúdo")

; Hotkey para encerrar o script
^Esc::ExitApp
