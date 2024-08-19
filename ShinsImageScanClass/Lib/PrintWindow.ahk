PrintWindow( id, mDC2, mode ) {
	result :=
	DllCall(
		"PrintWindow",
		"Ptr"	, id,				; Um identificador para a janela que será copiada.
		"Ptr"	, mDC2,				; Um identificador para o contexto de dispositivo.
		"uint"	, (mode > 3) * 3 	; As opções de desenho. Pode ser um dos seguintes valores.
	)
	return result
}
/*

Função PrintWindow (winuser.h)

A função PrintWindow copia uma janela visual para o contexto de dispositivo (DC) especificado, normalmente um DC de impressora.

Sintaxe
```cpp
BOOL PrintWindow(
  HWND hwnd,
  HDC  hdcBlt,
  UINT nFlags
);
```

Parâmetros
- **hwnd**: Um identificador para a janela que será copiada.
- **hdcBlt**: Um identificador para o contexto de dispositivo.
- **nFlags**: As opções de desenho. Pode ser um dos seguintes valores.

Valor	Significado
PW_CLIENTONLY
Somente a área do cliente da janela é copiada para hdcBlt. Por padrão, toda a janela é copiada.

Valor de Retorno
Se a função for bem-sucedida, ela retorna um valor diferente de zero.

Se a função falhar, ela retorna zero.

Observações
- Esta é uma função de bloqueio ou síncrona e pode não retornar imediatamente. O quão rapidamente esta função retorna depende de fatores de tempo de execução, como status de rede, configuração do servidor de impressão e implementação do driver da impressora — fatores difíceis de prever ao escrever um aplicativo. Chamar esta função de uma thread que gerencia a interação com a interface do usuário pode fazer com que o aplicativo pareça não responder.
- A aplicação que possui a janela referenciada por hWnd processa a chamada PrintWindow e renderiza a imagem no contexto de dispositivo referenciado por hdcBlt. A aplicação recebe uma mensagem WM_PRINT ou, se a flag PW_PRINTCLIENT for especificada, uma mensagem WM_PRINTCLIENT. Para mais informações, consulte WM_PRINT e WM_PRINTCLIENT.