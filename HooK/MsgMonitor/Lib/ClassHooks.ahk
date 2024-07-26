#Include c:\Users\morim\OneDrive\DynamicRegionScren\Mutex\ClasseMutex.ahk
#Include C:\Users\morim\OneDrive\DynamicRegionScren\HooK\MsgMonitor\AppsFromHooks\CaptorScreen\LowLevelMouseProc_wParam.ahk
; Usage:
; O App obterá os dados, do Hook a ser instalado, necessários para sua execução



; AppTest:
;*************************************

;pFnShared := CallbackCreate( FnShared )


flag := 0
ObjMutex := Mutex()
sharedData := Buffer( 16, 0 )
myHook := Hooks( "WH_MOUSE_LL", FnShared )
;,sharedData := Hooks.sharedData
Text := ""

Esc::ExitApp()

FnShared() {

    global

    Lock := ObjMutex.Lock()
    if ( Lock = 0 ) {
        try {
            ; Processa lParam e wParam
            ;swParam := NumGet( sharedData, 0, "uint" )
            ;slParam := NumGet( sharedData, 8, "int64")
            ;Text := " lParam: " sharedData.lParam "`nwParam: " sharedData.wParam
            ;Param := NumGet( sharedData, 0, "Uint" )
            ;wParam := &Param

            ;Text := " lParam: "  LowLevelMouseProc_wParam( wParam ) ;NumGet( swParam, 0, "UInt" ) "`nnwParam: " swParam



            ;ToolTip( Text )
            
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
        }
        finally {
            ; Libera o mutex
            Sleep( 20 )
            freeMutex := ObjMutex.ReleaseMutex()
            if ( !freeMutex ) {
                ;ext := "Erro ao liberar o mutex."
                ;ToolTip( Text )
            }
        }
    }
}



; Fim AppTest.
;*************************************

/** Objetivo
 * -
 * Obter as propriedades wParam e lParam do Hook instalado.
*/
class Hooks {
   
    /** 
     * @param nHook Hook a ser instalado
     * @param pFnShared Endereço para a função que processara sharedData
     */
    __New( nHook, FnShared ) {
        ;this.myMutex := ObjMutex
        ;MsgBox( IsObject( this.myMutex ) )flag
        switch nHook {
            case ( "WH_MOUSE_LL" || 14 ):
                Hooks.andressCallBack := CallbackCreate( Hooks.LowLevelMouseProc )
                idHook := 14
                Hooks.hMouseHook := Hooks.SetHook( idHook, Hooks.andressCallBack )
            default:
                throw( "Hook no Implemented!" )
        }
        ;this.pFnShared := pFnShared
    }

    static SetHook( idHook, andress ) {
        hHook :=
        this.SetWindowsHookEx( idHook, andress )
        if ( !hHook ) {
            MsgBox( "Failed to set hook: " idHook )
            ExitApp()
        }
        return hHook
    }

    static LowLevelMouseProc( nCode, wParam, lParam ) {

        Critical
        ; Se nCode >= 0
        ; Os parâmetros wParam e lParam contêm informações sobre uma mensagem de teclado.
        if ( nCode >= 0 ) {
            ;Text := ""
            ; Bloqueia o mutex
            Lock := ObjMutex.Lock()
            if ( Lock = 0 ) {
                
                try {
                    ; Compartilha lParam e wParam
                    ;sharedData.wParam := wParam
                    ;sharedData.lParam := lParam
                    Text := LowLevelMouseProc_wParam( wParam ) 
                    ;NumPut( "int64", lParam, sharedData, 8 )
                    Sleep( 1 )
                    ToolTip( Text )
                    ; Sinaliza para processar os dados (pode ser um thread separado)
                    SetTimer( FnShared, -1 )
                    ; Para pFnShared consulte:
                    ; Ver:C:\Users\morim\OneDrive\DynamicRegionScren\HooK\MsgMonitor\AppsFromHooks\CaptorScreen\ProcessSharedData.ahk
                }
                finally {
                    ; Libera o mutex
                    boolMutex := ObjMutex.ReleaseMutex()
                    if ( !boolMutex ) {
                        MsgBox( "Erro ao liberar o mutex." )
                    }
                    ;Sleep( 1000 )
                }
            }
        }
        
        if ( !flag ) {
            return  Hooks.CallNextHookEx( nCode, wParam, lParam )
        }
        else {            
            return 1
        }                
    }

    static CallNextHookEx( nCode, wParam, lParam, hHook := 0 ) {
        
        LRESULT :=
        DllCall(
            "CallNextHookEx",
            "Ptr", hHook,
            "int", nCode,
            "UInt", wParam,
            "Ptr", lParam
        )
    
        return LRESULT
    }

    static SetWindowsHookEx( idHook, pfn ) {
        hModule := this.GetModuleHandle()
        hHook :=
        DllCall(
            "SetWindowsHookEx",
            "int", idHook,
            "Ptr", pfn,
            "Ptr", hModule,
            "UInt", 0,
            "Ptr"
        )
        return hHook
    }

    static GetModuleHandle() {
        hModule :=
        DllCall( 
            "GetModuleHandle", 
            "Ptr", 0,
            "Ptr"
        )
    
        return hModule
    }

    static Unhook( hHook ) {
        Bool :=
        DllCall(
            "UnhookWindowsHookEx",
            "Ptr", hHook,
            "Int"
        )
        return Bool
    }

    static UnhookAll() {
        /*
        if ( IsSet( hHookKeybd ) ){
            BoolKeybd := Unhook( hHookKeybd )
            CallbackFree( andressK )
        }
        */
        if ( Hooks.hMouseHook ) {
            BoolMouse := Hooks.Unhook(Hooks.hMouseHook )
            if ( Hooks.andressCallBack ) {
                CallbackFree( Hooks.andressCallBack )
            }
        }
        ;ExitApp()
    }

    __Delete() {
        Hooks.UnhookAll()
    }
}