GetWindowDC( Win ) {
    HDC :=
    DllCall(
        "GetWindowDC",
        "Ptr", Win,
        "Ptr"
    )
    return HDC
}

/*

A função GetWindowDC (winuser.h) recupera o contexto de dispositivo (DC) para a janela inteira, incluindo a barra de título, menus e barras de rolagem. Um contexto de dispositivo de janela permite pintar em qualquer lugar da janela, porque a origem do contexto de dispositivo é o canto superior esquerdo da janela, em vez da área de cliente.

O GetWindowDC atribui atributos padrão ao contexto de dispositivo da janela cada vez que recupera o contexto de dispositivo. Atributos anteriores são perdidos.

Sintaxe
C++

```cpp
HDC GetWindowDC(
  [in] HWND hWnd
);
```

Parâmetros
[in] hWnd

Um identificador para a janela com um contexto de dispositivo que será recuperado. Se este valor for NULL, GetWindowDC recupera o contexto de dispositivo para toda a tela.

Se este parâmetro for NULL, GetWindowDC recupera o contexto de dispositivo para o monitor de exibição primário. Para obter o contexto de dispositivo para outros monitores de exibição, use as funções EnumDisplayMonitors e CreateDC.

Valor de retorno
Se a função for bem-sucedida, o valor de retorno será um identificador para um contexto de dispositivo para a janela especificada.

Se a função falhar, o valor de retorno será NULL, indicando um erro ou um parâmetro hWnd inválido.

Observações
GetWindowDC destina-se a efeitos de pintura especiais dentro da área não cliente de uma janela. Pintar em áreas não cliente de qualquer janela não é recomendado.

A função GetSystemMetrics pode ser usada para recuperar as dimensões de várias partes da área não cliente, como a barra de título, menu e barras de rolagem.

A função GetDC pode ser usada para recuperar um contexto de dispositivo para toda a tela.

Após a conclusão da pintura, a função ReleaseDC deve ser chamada para liberar o contexto de dispositivo. Não liberar o contexto de dispositivo da janela tem efeitos graves na pintura.