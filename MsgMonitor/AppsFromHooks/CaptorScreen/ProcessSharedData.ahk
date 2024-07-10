#Include InstallHook.v2.ahk

ProcessSharedData( ) {

    ;global sharedData
    /*
    global m_pFn
    global k_pFn
    global f_flag
    */
    Text := ""
    global ghMutex
    global sharedData

    

    ; Bloqueia o mutex para ler os dados compartilhados
    if DllCall("WaitForSingleObject", "ptr", ghMutex, "int", 0xFFFFFFFF, "UInt") = 0x00000000 {
        try {
            ; Processa lParam e wParam
            Text := " lParam: " sharedData.lParam "`nwParam: " sharedData.wParam
            ToolTip( Text )
            
            /*
            switch {
                case  Type( m_pFn ) == "Func" && Type( k_pFn ) == "Func":
                    m_pFn()
                    k_pFn()
    
                case Type( m_pFn ) == "Func":
                    m_pFn( nCode, wParam, lParam )
    
                case Type( k_pFn ) == "Func" :
                    k_pFn()
                    
            }
            */
            ; Aqui você pode adicionar processamento complexo
            ; Por exemplo: 
            ; - Escrever em um banco de dados
            ; - Analisar os dados
            ; - Atualizar uma interface gráfica
        } finally {
            ; Libera o mutex
            if ( !DllCall("ReleaseMutex", "ptr", ghMutex) ) {
                Text := "Erro ao liberar o mutex."
                ToolTip( Text )
            }
        }
    }
}