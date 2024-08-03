;#Include ClassMutex.V0.ahk
;Code := 0


Ass := Hook()


;ToolTip( Code )
;ListVars()
;Sleep( 30000 )
;Dss := Hook( 13 )

#z::SetTimer( msg, 20 ) 

msg() {
    MouseGetPos( &nX, &nY)
    ToolTip( code, nX + 150, nY + 150 )
}


#x:: {
    Ass.Set_flag( 1 )
    Sleep( 3000 )
    Ass.Set_flag()
    Sleep( 5000 )
    Ass.UnhookAll( )
}

Esc::ExitApp()

class Hook {

    __New( idHook := 14 , fnApp := "" ) {

        this.andressCallBack := CallbackCreate( ObjBindMethod( this, "Fn"  ), "Fast", 3  )
        this.hModule := this.GetHandle()
        switch idHook {
            case 0 || 14:
                ;this.Name := "MouseHook"
                ;this.Mtx := Mutex( this.Name )
                this.idHook := this.Set_idHook( )
                this.flag := this.Set_flag()
                ;MsgBox( IsObject( appFn ) )
                ;if ( !IsObject( appFn ) ) {
                ;    this.fnApp := this.appFn()
                ;}
                ;( !IsObject( fnApp ) ? this.fnApp := this.appFn() : this.fnApp := fnApp )
                this.SetWindowsHookEx()
            case 13:
                this.idHook := this.Set_idHook( 13 )
                this.flag := this.Set_flag()
                this.SetWindowsHookEx()
            default:
                
        }
    }
       
    

    Set_idHook( i := 0 ) => i == 0 ? this.idHook := 14 : this.idHook := i

    Set_flag( i := 0 ) => i == 0 ? this.flag := 0 : this.flag := i

    ;appFn( i := 0 ) => i == 0 ? ( this.idHook == 14 ? ToolTip( "Set AppFn! 14" ) : ToolTip( "Set AppFn! 13", 100, 150 ) ) : ToolTip( ) 

    appFn( i := 0 ) => i == 0 ? ToolTip( "Set AppFn!" ) : ToolTip( "" )

    GetHandle() {
        handle := 
        DllCall( 
            "GetModuleHandle", 
            "Ptr", 0,
            "Ptr"
        )

        return handle
    }

    Fn( nCode, wParam, lParam ) {

        global Code, paramW, paramL, flag := 0
        ;flag := this.flag
        ;hHook := this.hHook
        ;fnApp := this.appFn 
        ;global
        Critical
        
        if ( nCode >= 0 ) {
            
            code := wParam

            aCode := "x = " NumGet( lParam, 0, "Int" )
            Code := "y = " NumGet( lParam, 4, "Int" )
            ;sssssssssssCode := NumGet( lParam, 20, "Short" )dzzzswr4
            
            
            ;RodaMouse() {
            ;   Code := NumGet( lParam, 10, "Short" )
            ;}
            ;Hora Legível() {
                ;Code := NumGet( lParam, 16, "UInt" )
                ;systemStartTime := A_TickCount - A_NowUTC
                ;eventTime := systemStartTime + Code

                ;return FormatTime( eventTime , "yyyy-MM-dd HH:mm:ss" )
            ;}

            paramW := wParam
            paramL := 0
            ;Code := NumGet( lParam, 0, "uint" )
        }
        else {
            Code := nCode " else"
            ;NumGet( wParam, 0, "ushort" )

            ;ToolTip( Code )
            ;ToolTip( "nCode - " nCode "`nwParam - " wParam "`nlParam - " lParam )
            ;this.fnApp()
            /*
            if ( this.Lock() = 0x00000000 ) {
                ;ListVars()
                try {
                    ; Processa lParam e wParam
                    wParam := NumGet( this.SharedOutput, 0, "Ptr" )
                    lParam := NumGet( this.SharedOutput, 8, "Ptr")
                        ;Text := " lParam: " sharedData.lParam "`nwParam: " sharedData.wParam
                    Text := " lParam: " lParam "`nwParam: " wParam
            
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
                    
                    ; Aqui você pode adicionar processamento complexo
                    ; Por exemplo: 
                    ; - Escrever em um banco de dados
                    ; - Analisar os dados
                    ; - Atualizar uma interface gráfica
                }
                finally {
                    ; Libera o mutex
                    Sleep( 20 )
                    freeMutex := myMutex.ReleaseMutex()
                    if ( !freeMutex ) {
                        Text := "Erro ao liberar o mutex."
                        ;ToolTip( Text )
                    }
                }
            }
            */
            
        }           

        if ( flag == 0 ) {
            CallNextHookEx :=
            DllCall(
                "CallNextHookEx",
                "Ptr", hHooK := 0,
                "int", nCode,
                "UInt", wParam,
                "Ptr", lParam
            )
            return CallNextHookEx
        }
        else {
            return 1
        }    
                
    }
    
    SetWindowsHookEx() {
        if ( this.hModule && this.idHook ) {
            this.hHook :=
            DllCall(
                "SetWindowsHookEx",
                "int", this.idHook,
                "Ptr", this.andressCallBack,
                "Ptr", this.hModule,
                "UInt", 0,
                "Ptr"
            )
        }
        if ( !this.hHook ) {
            MsgBox( "Failed to set hook: " this.idHook )
            ExitApp()
        }
    }
            
    UnhookWindowsHookEx() {

        DllCall(
            "UnhookWindowsHookEx",
            "Ptr", this.hHook,
            "Int"
        )
    }

    UnhookAll() {
        this.UnhookWindowsHookEx()
        if ( this.andressCallBack ) {
            CallbackFree( this.andressCallBack )
            this.andressCallBack := 0
        }
        ;this.appFn( 1 )
    }
    
}