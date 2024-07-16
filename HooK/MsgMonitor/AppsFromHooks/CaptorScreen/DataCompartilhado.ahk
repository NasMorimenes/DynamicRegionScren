if ( nCode >= 0 ) {
    ; Bloqueia o mutex

    if DllCall("WaitForSingleObject", "ptr", ghMutex, "int", 0xFFFFFFFF, "UInt") = 0x00000000 {
        try {
            ; Compartilha lParam e wParam
            ;sharedData.wParam := wParam
            ;sharedData.lParam := lParam

            NumPut( "Ptr", wParam, sharedData, 0 )
            NumPut( "Ptr", lParam, sharedData, 8 )

            ; Sinaliza para processar os dados (pode ser um thread separado)
            SetTimer( pfnH, -1 )
        } finally {
            ; Libera o mutex
            if !DllCall("ReleaseMutex", "ptr", ghMutex)
                MsgBox( "Erro ao liberar o mutex." )
        }
    }



WaitForSingleObject( ghMutex ) {
    ;https://learn.microsoft.com/pt-br/windows/win32/api/synchapi/nf-synchapi-waitforsingleobject
    result := 
    DllCall(
        "WaitForSingleObject",
        "ptr", ghMutex,
        "int", 0xFFFFFFFF,
        "UInt"
    )
    return result
}