
;Test 001

Ass := HookMouse( "ss" )

#x::Ass.__Delete()

Esc::ExitApp()

#Include ..\ClassRegion\funções\mensages\WM_MOUSEWHEEL\WM_MOUSEWHEEL.ahk

Class HookMouse {

    static dpi := A_ScreenDPI / 96
    static mouseBuff := Buffer( 8, 0 )    
    static WH_MOUSE_LL := 14
    static andress := 0
    static hHookMouse := 0 ;HookMouse.SetHook( HookMouse.WH_MOUSE_LL, HookMouse.andress )
    static LowLevelMouseProc := "MoveMouse"
    

    __New( msg ) {
        
        HookMouse.andress :=
        CallbackCreate(
            ObjBindMethod(
                this,
                HookMouse.LowLevelMouseProc
            ),
            "",
            3 
        ) ;OK
            
        HookMouse.hHookMouse :=
        HookMouse.SetHook(
            HookMouse.WH_MOUSE_LL,
            HookMouse.andress
        )
        
    }

    
    __Delete() {
        HookMouse.Unhook()
        MsgBox( "Saiu" )
        ExitApp()
    }

    ;static MoveMouse( wParam, lParam, nCode ) { 
    /**
     * LowLevelMouseProc
     * -
     * @description Uma função de retorno de chamada definida pelo aplicativo ou definida pela biblioteca usada com a função SetWindowsHookExA/SetWindowsHookExW . O sistema chama essa função sempre que um novo evento de entrada do mouse está prestes a ser postado em uma fila de entrada de thread.
     * @param [in] nCode Um código que o procedimento de gancho usa para determinar como processar a mensagem.
     * Se nCode for menor que zero, o procedimento de gancho deverá passar a mensagem para a função CallNextHookEx sem processamento adicional e deverá retornar o valor retornado por CallNextHookEx.
     * Esse parâmetro pode usar um dos valores a seguir.     * 
     * @HC_ACTION 
     * @valor 0	Os parâmetros wParam e lParam contêm informações sobre uma mensagem do Mouse
     * @param [in] wParam 
     * @param lParam 
     * 
     * @return LRESULT 
     * 
     */
    MoveMouse( nCode ,wParam, lParam) {

        Critical 
        
        static lastMouseMove := A_TickCount
        ListVars()
        
        if ( !nCode  && ( wParam = 0x200 ) ) { 
            
            diffMouseMove := A_TickCount - lastMouseMove
            lastMouseMove := A_TickCount
            ListVars()
            Text := 
            (
            " X: " NumGet( lParam , 0, "Int" ) "`n"
                " Y: " NumGet( lParam , 4, "Int" ) "`n"
                " Z: `n" 
                " Last keypress: " diffMouseMove
            )
            ;OutputDebug( Text )
    
            ToolTip( Text )
    
            setVars := -1
            currTime := A_TickCount
            xPos := NumGet( lParam, 0, "int" )
            yPos := NumGet( lParam, 4, "int" )
    
            ;ToolTip( QueryMouseMove( setVars, currTime , xPos, yPos ) )
    
            ;QueryMouseMove( setVars, currTime , xPos, yPos )
        }

        Return HookMouse.CallNextHookEx( nCode, wParam, lParam ) 
    }
    /**
     * SetHook
     * -
     * https://learn.microsoft.com/pt-br/windows/win32/api/winuser/nf-winuser-setwindowshookexa
     * @param idHook O tipo de procedimento de gancho a ser instalado. 
     * @param pfn Um ponteiro para o procedimento de gancho. Se o parâmetro dwThreadId for zero ou especificar o identificador de um thread criado por um processo diferente, o parâmetro lpfn deverá apontar para um procedimento de gancho em uma DLL. Caso contrário, lpfn pode apontar para um procedimento de gancho no código associado ao processo atual.
     */
    static SetHook( idHook, pfn ) {
        
        hHook :=
        HookMouse.SetWindowsHookEx(
            idHook,
            pfn
        )
    
        if ( !hHook ) {
            MsgBox( "Failed to set hook: " idHook )
            ExitApp()
        }

        return hHook
    }

    static CallNextHookEx( nCode, wParam, lParam, hHook := 0 ) {
                
        LRESULT :=
        DllCall(
            "CallNextHookEx",
            "Uint", hHook,
            "int", nCode,
            "Uint", wParam,
            "Uint", lParam
        ) 
        
        Return LRESULT
    }

    static SetWindowsHookEx( idHook, pfn ) {

        hModule := HookMouse.GetModuleHandle()
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

    static UnhookWindowsHookEx( hHook ) { 
        bool :=
        DllCall(
            "UnhookWindowsHookEx",
            "Uint", hHook,
            "int"
        )
        Return bool
    }

    static Unhook() {
        MsgBox( "Saindo" )
        CallbackFree( HookMouse.andress )
        HookMouse.UnhookWindowsHookEx( HookMouse.hHookMouse ) 
    }
}


;Doc
/*
Função LowLevelMouseProc
Artigo
01/07/2023
5 colaboradores
Neste artigo
Descrição
Parâmetros
Retornos
Comentários
Confira também
Descrição
Uma função de retorno de chamada definida pelo aplicativo ou definida pela biblioteca usada com a função SetWindowsHookExA/SetWindowsHookExW . O sistema chama essa função sempre que um novo evento de entrada do mouse está prestes a ser postado em uma fila de entrada de thread.

O tipo HOOKPROC define um ponteiro para essa função de retorno de chamada. LowLevelMouseProc é um espaço reservado para o nome da função definida pelo aplicativo ou definida pela biblioteca.

LowLevelMouseProc é um espaço reservado para o nome da função definida pelo aplicativo ou definida pela biblioteca.

C++

Copiar
LRESULT CALLBACK LowLevelMouseProc(
  _In_ int    nCode,
  _In_ WPARAM wParam,
  _In_ LPARAM lParam
);
Parâmetros
nCode [in]
Tipo: int

Um código que o procedimento de gancho usa para determinar como processar a mensagem.

Se nCode for menor que zero, o procedimento de gancho deverá passar a mensagem para a função CallNextHookEx sem processamento adicional e deverá retornar o valor retornado por CallNextHookEx.

Esse parâmetro pode usar um dos valores a seguir.

Valor	Significado
HC_ACTION 0	Os parâmetros wParam e lParam contêm informações sobre uma mensagem do mouse.
wParam [in]
Tipo: WPARAM

O identificador da mensagem do mouse.

Esse parâmetro pode ser uma das seguintes mensagens: WM_LBUTTONDOWN, WM_LBUTTONUP, WM_MOUSEMOVE, WM_MOUSEWHEEL, WM_RBUTTONDOWN ou WM_RBUTTONUP.

lParam [in]
Tipo: LPARAM

Um ponteiro para uma estrutura MSLLHOOKSTRUCT .

Retornos
Tipo: LRESULT

Se nCode for menor que zero, o procedimento de gancho deverá retornar o valor retornado por CallNextHookEx.

Se nCode for maior ou igual a zero e o procedimento de gancho não processar a mensagem, é altamente recomendável que você chame CallNextHookEx e retorne o valor retornado; caso contrário, outros aplicativos que instalaram ganchos de WH_MOUSE_LL não receberão notificações de gancho e poderão se comportar incorretamente como resultado.

Se o procedimento de gancho tiver processado a mensagem, ele poderá retornar um valor diferente de zero para impedir que o sistema passe a mensagem para o restante da cadeia de ganchos ou o procedimento da janela de destino.

Comentários
Um aplicativo instala o procedimento de gancho especificando o tipo de gancho WH_MOUSE_LL e um ponteiro para o procedimento de gancho em uma chamada para a função SetWindowsHookExA/SetWindowsHookExW .

Esse gancho é chamado no contexto do thread que o instalou. A chamada é feita enviando uma mensagem para o thread que instalou o gancho. Portanto, o thread que instalou o gancho deve ter um loop de mensagem.

A entrada do mouse pode vir do driver do mouse local ou de chamadas para a função mouse_event . Se a entrada vier de uma chamada para mouse_event, a entrada foi "injetada". No entanto, o gancho de WH_MOUSE_LL não é injetado em outro processo. Em vez disso, o contexto volta para o processo que instalou o gancho e é chamado em seu contexto original. Em seguida, o contexto volta para o aplicativo que gerou o evento.

O procedimento de gancho deve processar uma mensagem em menos tempo do que a entrada de dados especificada no valor LowLevelHooksTimeout na seguinte chave do Registro:

HKEY_CURRENT_USER\Control Panel\Desktop

O valor está em milissegundos. Se o procedimento de gancho atingir o tempo limite, o sistema passará a mensagem para o próximo gancho. No entanto, no Windows 7 e posterior, o gancho é removido silenciosamente sem ser chamado. Não há como o aplicativo saber se o gancho foi removido.

Windows 10 versão 1709 e posterior O valor máximo de tempo limite que o sistema permite é 1000 milissegundos (1 segundo). O sistema usará um tempo limite de 1000 milissegundos por padrão se o valor LowLevelHooksTimeout for definido como um valor maior que 1000.