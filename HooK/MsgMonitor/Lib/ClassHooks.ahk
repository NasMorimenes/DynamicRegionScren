#Include c:\Users\morim\OneDrive\DynamicRegionScren\Mutex\ClasseMutex.ahk

; Usage:
; O App obterá os dados, do Hook a ser instalado, necessários para sua execução



; AppTest:
;*************************************

pFnShared := CallbackCreate( FnShared )
ObjMutex := Mutex()
myHook := Hooks( "WH_MOUSE_LL", &pFnShared, &ObjMutex )
sharedData := Hooks.sharedData

Esc::ExitApp()

FnShared( &ObjMutex, sharedData ) {
    Lock := ObjMutex.Lock()
    if ( Lock  = 0x00000000 ) {
        try {
            ; Processa lParam e wParam
            wParam := NumGet( sharedData, 0, "Ptr" )
            lParam := NumGet( sharedData, 8, "Ptr")
            ;Text := " lParam: " sharedData.lParam "`nwParam: " sharedData.wParam
            Text := " lParam: " lParam "`nwParam: " wParam

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
        }
        finally {
            ; Libera o mutex
            Sleep( 20 )
            freeMutex := ObjMutex.ReleaseMutex()
            if ( !freeMutex ) {
                Text := "Erro ao liberar o mutex."
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
     * @description sharedData - Dados compartilhados com Fn
     * @description Fn - função que processará sharedData
     * @global Por exemplo, x := y := 1 definiria this.x e uma variável local y (que seria liberada assim que todos os inicializadores fossem avaliados).
     */
    __Init() {
        Hooks.flag := 0
        Hooks.sharedData := Buffer( 16, 0 )
        Hooks.wParam := 0
        Hooks.lParam := 0
        ;Hooks.myMutex := Mutex()
        ;hooks.hMutex := Hooks.myMutex.hMutex
        NumPut( "Ptr", Hooks.wParam,
                "Ptr", Hooks.lParam, 
                Hooks.sharedData )
        ; Deverá ser implementado um método estático retorne a CallBack adequada ao nHook
        ; Hooks.andressCallBack( nHook ) => this.andressCallBack
        Hooks.andressCallBack := CallbackCreate( this.LowLevelKeyboardProc )
    }
    /** 
     * @param nHook Hook a ser instalado
     * @param pFnShared Endereço para a função que processara sharedData
     */
    __New( nHook, &pFnShared, &ObjMutex ) {
        ;this.myMutex := ObjMutex
        ;MsgBox( IsObject( this.myMutex ) )
        this.flag := 0
        switch nHook {
            case ( "WH_MOUSE_LL" || 14 ):
                idHook := 14
                this.andressCallBack := Hooks.andressCallBack
                this.hMouseHook := this.SetHook( idHook, this.andressCallBack )
            default:
                throw( "Hook no Implemented!" )
        }
        ;this.pFnShared := pFnShared
    }

    SetHook( idHook, andress ) {
        hHook :=
        this.SetWindowsHookEx( idHook, andress )
        if ( !hHook ) {
            MsgBox( "Failed to set hook: " idHook )
            ExitApp()
        }
        return hHook
    }

    LowLevelKeyboardProc( nCode, wParam, lParam ) {

        Critical
        ; Se nCode >= 0
        ; Os parâmetros wParam e lParam contêm informações sobre uma mensagem de teclado.
        if ( nCode >= 0 ) {

            ; Bloqueia o mutex
            Lock := ObjMutex.Lock()
            if ( Lock = 0 ) {
                
                try {
                    ; Compartilha lParam e wParam
                    ;sharedData.wParam := wParam
                    ;sharedData.lParam := lParam

                    NumPut( "Ptr", Hooks.wParam,
                            "Ptr", Hooks.lParam,
                            Hooks.sharedData )
                    Sleep( 1 )

                    ; Sinaliza para processar os dados (pode ser um thread separado)
                    SetTimer( pFnShared, -1 )
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

        if ( this.flag ) {
            return  this.CallNextHookEx( nCode, wParam, lParam )
        }
        else {            
            return 1
        }                
    }

    CallNextHookEx( nCode, wParam, lParam, hHook := 0 ) {
        
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

    SetWindowsHookEx( idHook, pfn ) {
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

    GetModuleHandle() {
        hModule :=
        DllCall( 
            "GetModuleHandle", 
            "Ptr", 0,
            "Ptr"
        )
    
        return hModule
    }

    Unhook( hHook ) {
        Bool :=
        DllCall(
            "UnhookWindowsHookEx",
            "Ptr", hHook,
            "Int"
        )
        return Bool
    }

    UnhookAll() {
        /*
        if ( IsSet( hHookKeybd ) ){
            BoolKeybd := Unhook( hHookKeybd )
            CallbackFree( andressK )
        }
        */
        if ( this.hMouseHook ) {
            BoolMouse := this.Unhook( this.hMouseHook )
            if ( hooks.andressCallBack ) {
                CallbackFree( hooks.andressCallBack )
            }
        }
        ;ExitApp()
    }

    __Delete() {
        this.UnhookAll()
    }
}