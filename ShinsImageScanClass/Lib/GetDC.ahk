
GetDC( hWin ) {
    HDC :=
    DllCall(
        "GetDC",
        "Ptr", hWin,
        "UInt"
    )
    return HDC
}

/*


A função GetDC recupera um identificador para um contexto de dispositivo (DC) para a área cliente de uma janela especificada ou para toda a tela. Você pode usar o identificador retornado em funções subsequentes do GDI para desenhar no DC. O contexto do dispositivo é uma estrutura de dados opaca, cujos valores são usados internamente pelo GDI.

A função GetDCEx é uma extensão do GetDC, que dá a uma aplicação mais controle sobre como e se ocorre o recorte na área cliente.

Sintaxe

```cpp
HDC GetDC(
  [in] HWND hWnd
);
```

Parâmetros

[in] hWnd

Um identificador para a janela cujo DC deve ser recuperado. Se este valor for NULL, GetDC recupera o DC para toda a tela.

Valor de retorno

Se a função for bem-sucedida, o valor de retorno será um identificador para o DC da área cliente da janela especificada.

Se a função falhar, o valor de retorno será NULL.

Observações

A função GetDC recupera um DC comum, de classe ou privado, dependendo do estilo de classe da janela especificada. Para DCs de classe e privados, GetDC deixa os atributos previamente atribuídos inalterados. No entanto, para DCs comuns, GetDC atribui atributos padrão ao DC cada vez que ele é recuperado. Por exemplo, a fonte padrão é System, que é uma fonte bitmap. Devido a isso, o identificador para um DC comum retornado por GetDC não informa qual fonte, cor ou pincel foram usados quando a janela foi desenhada. Para determinar a fonte, chame GetTextFace.

Observe que o identificador para o DC só pode ser usado por uma única thread de cada vez.

Após pintar com um DC comum, a função ReleaseDC deve ser chamada para liberar o DC. DCs de classe e privados não precisam ser liberados. ReleaseDC deve ser chamada da mesma thread que chamou GetDC. O número de DCs é limitado apenas pela memória disponível.