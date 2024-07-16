fn( "hCasa" )

fn( fn, p* ) {
	MsgBox( )
    AnalyzeParameters( p )
}


AnalyzeParameters( Param, fn ) {
	for i, j in Param
		MsgBox InStr( j, "h", true )
}

HookParams() {
    static id := "h"    
    static hooks := myMap
            myMap := Map(
                { Name : "WH_CALLWNDPROC", 
                  Valor : 4, 
                  Desctitions : "Instala um procedimento de gancho que monitora mensagens antes que o sistema as envie para o procedimento de janela de destino Para obter mais informações, consulte o procedimento de gancho CallWndProc "
				},
                { Name : "WH_CALLWNDPROCRET",
                  Valor : 12,
                  Desctitions : "Instala um procedimento de gancho que monitora mensagens depois que elas são processadas pelo procedimento da janela de destino. Para obter mais informações, consulte o procedimento de gancho [função de retorno de chamada HOOKPROC](nc-winuser-hookproc.md)" 
				},
                { Name : "WH_CBT",
                  Valor : 5,
                  Desctitions : "Instala um procedimento de gancho que recebe notificações úteis para um aplicativo CBT. Para obter mais informações, consulte o procedimento de gancho CBTProc ."
				},
                { Name : "WH_DEBUG",
                  Valor : 9,
                  Desctitions : "Instala um procedimento de gancho útil para depurar outros procedimentos de gancho. Para obter mais informações, consulte o procedimento de gancho DebugProc ."
				},
                { Name : "WH_FOREGROUNDIDLE",
                  Valor : 11,
                  Desctitions : "Instala um procedimento de gancho que será chamado quando o thread em primeiro plano do aplicativo estiver prestes a ficar ocioso. Esse gancho é útil para executar tarefas de baixa prioridade durante o tempo ocioso. Para obter mais informações, consulte o procedimento de gancho ForegroundIdleProc "
				},
                { Name : "WH_GETMESSAGE",
                  Valor : 3,
                  Desctitions : "Instala um procedimento de gancho que monitora mensagens postadas em uma fila de mensagens. Para obter mais informações, consulte o procedimento de gancho GetMsgProc "
				},
                { Name : "WH_JOURNALPLAYBACK",
                  Valor : 1,
                  Desctitions : "AvisoWindows 11 e mais recentes: não há suporte para APIs de gancho de registro em diário. Em vez disso, recomendamos usar a API SendInput TextInput.Instala um procedimento de gancho que posta mensagens registradas anteriormente por um procedimento de gancho de WH_JOURNALRECORD . Para obter mais informações, consulte o procedimento de gancho JournalPlaybackProc "
				},
                { Name : "WH_JOURNALRECORD",
                  Valor : 0,
                  Desctitions : "AvisoWindows 11 e mais recentes: não há suporte para APIs de gancho de registro em diário. Em vez disso, recomendamos usar a API SendInput TextInput.Instala um procedimento de gancho que registra mensagens de entrada postadas na fila de mensagens do sistema. Esse gancho é útil para gravar macros. Para obter mais informações, consulte o procedimento de gancho JournalRecordProc "
				},
                { Name : "WH_KEYBOARD",
                  Valor : 2,
                  Desctitions : "Instala um procedimento de gancho que monitora mensagens de pressionamento de tecla. Para obter mais informações, consulte o procedimento de gancho KeyboardProc ."
				},
                { Name : "WH_KEYBOARD_LL",
                  Valor : 13,
                  Desctitions : "Instala um procedimento de gancho que monitora eventos de entrada de teclado de baixo nível. Para obter mais informações, consulte o procedimento de gancho [LowLevelKeyboardProc](/windows/win32/winmsg/lowlevelkeyboardproc)."
				},
                { Name : "WH_MOUSE",
                  Valor : 7,
                  Desctitions : "Instala um procedimento de gancho que monitora mensagens do mouse. Para obter mais informações, consulte o procedimento de gancho MouseProc "
				},
                { Name : "WH_MOUSE_LL",
                  Valor : 14,
                  Desctitions : "Instala um procedimento de gancho que monitora eventos de entrada de mouse de baixo nível. Para obter mais informações, consulte o procedimento de gancho LowLevelMouseProc "
				},
                { Name : "WH_MSGFILTER",
                  Valor : -1,
                  Desctitions : "Instala um procedimento de gancho que monitora mensagens geradas como resultado de um evento de entrada em uma caixa de diálogo, caixa de mensagem, menu ou barra de rolagem. Para obter mais informações, consulte o procedimento de gancho MessageProc "
				},
                { Name : "WH_SHELL",
                  Valor : 10,
                  Desctitions : "Instala um procedimento de gancho que recebe notificações úteis para aplicativos de shell. Para obter mais informações, consulte o procedimento de gancho ShellProc ."
				},
                { Name : "WH_SYSMSGFILTER",
                  Valor : 6,
                  Desctitions : "Instala um procedimento de gancho que monitora mensagens geradas como resultado de um evento de entrada em uma caixa de diálogo, caixa de mensagem, menu ou barra de rolagem. O procedimento de gancho monitora essas mensagens para todos os aplicativos na mesma área de trabalho que o thread de chamada. Para obter mais informações, consulte o procedimento de gancho SysMsgProc ."
				},
            )
}