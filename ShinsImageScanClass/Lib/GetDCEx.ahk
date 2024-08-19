GetDCEx( id := 0 ) {
	hDC2 := 
	DllCall(
		"GetDCEx",
		"Ptr", id,
		"Ptr", 0,
		"int", 3,
		"Ptr" 
    )

	return hDC2
}

/*

Função GetDCEx (winuser.h)

A função GetDCEx recupera um identificador para um contexto de dispositivo (DC) para a área do cliente de uma janela especificada ou para toda a tela. Você pode usar o identificador retornado em funções GDI subsequentes para desenhar no DC. O contexto do dispositivo é uma estrutura de dados opaca, cujos valores são usados internamente pelo GDI.

Esta função é uma extensão da função GetDC, que dá a um aplicativo mais controle sobre como e se o recorte ocorre na área do cliente.

Sintaxe
```cpp
HDC GetDCEx(
  [in] HWND  hWnd,
  [in] HRGN  hrgnClip,
  [in] DWORD flags
);
```

Parâmetros
- **hWnd**: Um identificador para a janela cujo DC deve ser recuperado. Se este valor for NULL, GetDCEx recupera o DC para toda a tela.
- **hrgnClip**: Uma região de recorte que pode ser combinada com a região visível do DC. Se o valor de flags for DCX_INTERSECTRGN ou DCX_EXCLUDERGN, então o sistema operacional assume a propriedade da região e a excluirá automaticamente quando não for mais necessária. Nesse caso, o aplicativo não deve usar ou excluir a região após uma chamada bem-sucedida para GetDCEx.
- **flags**: Especifica como o DC é criado. Este parâmetro pode ser um ou mais dos seguintes valores.

Valor	Meaning
DCX_WINDOW
Retorna um DC que corresponde ao retângulo da janela, em vez do retângulo do cliente.
DCX_CACHE
Retorna um DC do cache, em vez do DC da janela OWNDC ou CLASSDC. Essencialmente substitui CS_OWNDC e CS_CLASSDC.
DCX_PARENTCLIP
Usa a região visível da janela pai. Os bits de estilo WS_CLIPCHILDREN e CS_PARENTDC do pai são ignorados. A origem é definida para o canto superior esquerdo da janela identificada por hWnd.
DCX_CLIPSIBLINGS
Exclui as regiões visíveis de todas as janelas irmãs acima da janela identificada por hWnd.
DCX_CLIPCHILDREN
Exclui as regiões visíveis de todas as janelas filhas abaixo da janela identificada por hWnd.
DCX_NORESETATTRS
Esta bandeira é ignorada.
DCX_LOCKWINDOWUPDATE
Permite desenhar mesmo se houver uma chamada LockWindowUpdate em efeito que, de outra forma, excluiria esta janela. Usado para desenhar durante o rastreamento.
DCX_EXCLUDERGN
A região de recorte identificada por hrgnClip é excluída da região visível do DC retornado.
DCX_INTERSECTRGN
A região de recorte identificada por hrgnClip é interseccionada com a região visível do DC retornado.
DCX_INTERSECTUPDATE
Reservado; não use.
DCX_VALIDATE
Reservado; não use.

Valor de Retorno
Se a função for bem-sucedida, o valor de retorno é o identificador do DC para a janela especificada.

Se a função falhar, o valor de retorno é NULL. Um valor inválido para o parâmetro hWnd fará com que a função falhe.

Observações
A menos que o DC de exibição pertença a uma classe de janela, a função ReleaseDC deve ser chamada para liberar o DC após a pintura. Além disso, ReleaseDC deve ser chamado da mesma thread que chamou GetDCEx. O número de DCs é limitado apenas pela memória disponível.

A função retorna um identificador para um DC que pertence à classe da janela se CS_CLASSDC, CS_OWNDC ou CS_PARENTDC foi especificado como um estilo na estrutura WNDCLASS quando a classe foi registrada.