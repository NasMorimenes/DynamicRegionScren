#Include 
GetMouse() {
    global pointer
    MouseGetPos( &PosX, &PosY, &Win )

    NumPut( "Int", PosX,
            "Int", PosY,
            "Ptr", Win,
            pointer )
}

SetMouse() {
    global pointer
    Msg :=
    (
        "`nx - " NumGet( pointer, 0, "Int" )
        "`ny - " NumGet( pointer, 4, "Int" )
        "`nWindows - " WinGetTitle( "ahk_id " NumGet( pointer, 8, "Int" ) )
    )
    ToolTip( Msg )
}











/*

Ass := Array()
Ass.Push( ExitApp )

CallBack( Ass , "5" )



Class CallBack {
    __New( fn , flags* ) {
        if ( Type( fn ) != "Array" || !fn.Length ) {
            Throw( "Erro param1, Não é uma Array ou Não Possui itens" ) 
        }
        else {
            for id, type1 in fn {                
                if ( Type( type1 ) != "Func" ) {
                    Throw( "Erro param1, Array possui itens que não são Objetos Func" )
                }
                type1
            }
        }  
        MsgBox( flags.Length )
    }
}






/*

CallBack( fn , flags* ) {
    li
}


*/


/*

x := 0
y := 0

CoordMode( "Mouse" )

mCall := CallbackCreate( myCallBack, , 2 )


; SetTimer( myCallBack, 10 ) OK, sem mCall
; SetTimer( DllCall( mCall, "Int", x, "Int", y ) ) ; Erro

SetTimer( CallM, 10 )

CallM() {
    global x, y
    DllCall( mCall, "Int", x, "Int", y )
}

SetTimer( GetMouse, 10 )


OnExit( free )
free(*) {
    global mCall
    CallbackFree( mCall )
}

Esc::ExitApp( )

;Teste

GetMouse() {
    global x, y
    MouseGetPos( &x, &y )
}

;myCallBack() { ;Ok sem mCall
;    global x, y ;Ok sem mCall
myCallBack( x, y ) {
    if ( x > 500 && y > 200 ) {
        ToolTip( "PosX - " x "`nPosiY - " y )
        return
    }
    ToolTip()
    return
}

/*
 * O comando `OnExit` registra uma função para ser chamada automaticamente sempre que o script é encerrado. Vamos entender os detalhes:

- **Callback**: É um objeto de função que você passa como argumento.
- **ExitReason**: Representa o motivo pelo qual o script está saindo (por exemplo, logoff, desligamento, erro etc.).
- **ExitCode**: É o código de saída especificado ao usar `Exit` ou `ExitApp`.

O callback pode ser usado para executar ações antes ou depois do encerramento do script. Por exemplo, você pode salvar dados, limpar recursos ou realizar outras tarefas personalizadas.

Lembre-se de que o callback não deve chamar `ExitApp`, pois isso encerraria o script imediatamente. Além disso, o callback deve ser projetado para terminar rapidamente, a menos que o usuário esteja ciente do que está fazendo¹.

Você pode omitir um ou mais parâmetros do final da lista de parâmetros do callback se as informações correspondentes não forem necessárias, mas, nesse caso, um asterisco deve ser especificado como o último parâmetro, por exemplo, MyCallback(Param1, *).

O callback pode retornar um inteiro diferente de zero para evitar que o script seja encerrado (com algumas exceções raras) e chamar mais callbacks. Caso contrário, o script é encerrado após todos os callbacks registrados serem chamados.
 *
 * Tipo: Inteiro

Se omitido, o valor padrão é 1. Caso contrário, especifique um dos seguintes números:
• 1 = Chamar o callback após quaisquer callbacks registrados anteriormente.
• -1 = Chamar o callback antes de quaisquer callbacks registrados anteriormente.
• 0 = Não chamar o callback.

Observações

Qualquer número de callbacks pode ser registrado. Um callback geralmente não deve chamar ExitApp; se o fizer, o script será encerrado imediatamente.

Os callbacks são chamados quando o script é encerrado por qualquer meio (exceto quando é interrompido por algo como "Finalizar tarefa"). Também são chamados sempre que #SingleInstance e Reload pedem que uma instância anterior seja encerrada.

Um script pode detectar e opcionalmente abortar um desligamento do sistema ou logoff via OnMessage(0x0011, On_WM_QUERYENDSESSION) (consulte o exemplo #2 do OnMessage para um script funcional).

A thread OnExit não obedece a #MaxThreads (ela sempre será iniciada quando necessário). Além disso, enquanto estiver em execução, ela não pode ser interrompida por nenhuma thread, incluindo atalhos de teclado, itens de menu personalizados e sub-rotinas temporizadas. No entanto, ela será interrompida (e o script será encerrado) se o usuário escolher Sair no menu da bandeja ou no menu principal, ou se o script for solicitado a encerrar como resultado de Reload ou #SingleInstance. Por causa disso, um callback deve ser projetado para terminar rapidamente, a menos que o usuário esteja ciente do que ele está fazendo.

Se a thread OnExit encontrar uma condição de falha, como um erro de tempo de execução, o script será encerrado.

Se a thread OnExit foi iniciada devido a Exit ou ExitApp que especificou um código de saída, esse código de saída é usado a menos que um callback retorne 1 (verdadeiro) para evitar a saída ou chame ExitApp.

Sempre que uma tentativa de saída é feita, cada callback começa com os valores padrão para configurações como SendMode. Esses padrões podem ser alterados durante a inicialização do script.

Motivos de Saída


Motivo

Descrição
--------------------------------------------------------------------------------------------------------------------------------------	|
|Logoff		-	|O usuário está fazendo logoff. 																						|
|---------------|---------------------------------------------------------------------------------------------------------------------	|
|Shutdown	-	|O sistema está sendo desligado ou reiniciado, como pela função Shutdown. 												|
|---------------|---------------------------------------------------------------------------------------------------------------------	|
|				|O script recebeu uma mensagem WM_CLOSE ou WM_QUIT, teve um erro crítico ou está sendo fechado de alguma outra forma.	|
|				|Embora todos esses sejam incomuns, WM_CLOSE pode ser causado pelo uso de WinClose na janela principal do script.		|
|				|Para fechar (ocultar) a janela sem encerrar o script, use WinHide.														|
|				|																														|
|Close		-	|Se o script estiver sendo encerrado devido a um erro crítico ou à destruição de sua janela principal, ele será			|
|				|encerrado incondicionalmente após a conclusão da thread OnExit.														|
|				|																														|
|				|Se a janela principal estiver sendo destruída, ela ainda pode existir, mas não pode ser exibida. Essa condição pode	|
|				|ser detectada monitorando a mensagem WM_DESTROY com OnMessage.															|
|---------------|---------------------------------------------------------------------------------------------------------------------	|
|Error		-	|Ocorreu um erro de tempo de execução em um script que não é persistente. Um exemplo de erro de tempo de execução é		|
|				|quando Run/RunWait não consegue iniciar o programa ou documento especificado.											|
|---------------|---------------------------------------------------------------------------------------------------------------------	|
|Menu		-	|O usuário selecionou Sair no menu da janela principal ou no menu padrão da bandeja.									|
|---------------|---------------------------------------------------------------------------------------------------------------------	|
|Exit		-	|Exit ou ExitApp foi usado (inclui itens de menu personalizados).														|
|---------------|---------------------------------------------------------------------------------------------------------------------	|
|Reload		- 	|O script está sendo recarregado via a função Reload ou item de menu													|
|---------------|---------------------------------------------------------------------------------------------------------------------	|
|Single		-	|O script está sendo substituído por uma nova instância de si mesmo como resultado de #SingleInstance.					|
|-------------------------------------------------------------------------------------------------------------------------------------	|




