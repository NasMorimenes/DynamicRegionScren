/*
#Include Includes.ahk
hMutex := 0
mutexName := "Global\BufferMutex"
buff := Buffer( 4, 0 )
NumPut( "UInt", 25, buff, 0 )
Values := ReadFromBuffer( mutexName, buff )

MsgBox( Values )

*/


;Esc::ExitApp()
; Nome do mutex no espaço de nomes global
mutexName := "Global\BufferMutex"

; Buffer compartilhado
global buff := Buffer( 4, 0 )

; Função para ler do buffer
ReadFromBuffer() {
    global mutexName, buff

    ; Obter o mutex
    hMutex :=
    DllCall( 
        "CreateMutex",
        "ptr", 0,
        "int", 0,
        "str", mutexName,
        "ptr"
    )
    LastError :=
    DllCall( 
        "GetLastError",
        "UInt"
    )
    if ( LastError = 183 ) {
        ; Outro processo está acessando o buffer
        MsgBox( "Outro processo está acessando o buff. Tente novamente mais tarde." )
        return
    }

    ; Leitura do buffer
    MsgBox( "Conteúdo do buffer: " NumGet( Buff, 0, "UInt") )

    ; Liberar o mutex
    boolMutex :=
    DllCall(
        "ReleaseMutex",
        "ptr", hMutex,
        "Int"
    )
    boolHandle :=
    DllCall(
        "CloseHandle",
        "ptr", hMutex,
        "Int"
    )
}

; Função para escrever no buffer
WriteToBuffer( data ) {
    global mutexName, buff

    ; Obter o mutex
    hMutex :=
    DllCall(
        "CreateMutex",
        "ptr", 0,
        "int", 0,
        "str", mutexName,
        "ptr"
    )

    LastError :=
    DllCall( 
        "GetLastError",
        "UInt"
    )

    if ( LastError = 183) {
        ; Outro processo está acessando o buffer
        MsgBox( "Outro processo está acessando o buff. Tente novamente mais tarde." )
        return
    }

    ; Escrita no buffer
    NumPut( "UInt", data, buff, 0 )
    MsgBox( "Dados escritos no buffer: " data )

    ; Liberar o mutex
    boolMutex :=
    DllCall(
        "ReleaseMutex",
        "ptr", hMutex,
        "Int"
    )
    boolHandle :=
    DllCall(
        "CloseHandle",
        "ptr", hMutex,
        "Int"
    )
}

; Define hotkeys para leitura e escrita
^r::ReadFromBuffer()
^w::WriteToBuffer( 10 )

; Hotkey para encerrar o script
^Esc::ExitApp
