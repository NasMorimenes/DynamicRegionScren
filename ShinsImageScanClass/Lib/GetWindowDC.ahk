GetWindowDC( Win ) {
  MsgBox( Win )
    HDC :=
    DllCall(
        "GetWindowDC",
        "UPtr", Win,
        "UPtr"
    )
    return HDC
}

/*

Obs.: Para obter o contexto de dispositivo (DC) de tudo o que está sendo exibido na tela física principal, você deve chamar a função GetDC passando como parâmetro o identificador da janela da área de trabalho (desktop), que você pode obter usando a função GetDesktopWindow.

Portanto, o processo seria:

Use a função GetDesktopWindow para obter o identificador da janela da área de trabalho.
Em seguida, passe esse identificador como parâmetro para a função GetDC para obter o contexto de dispositivo.

------------------------------------------------------------------------------------------------

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


************* Chat ************

GetWindowDC (Device Context):

A função GetWindowDC é usada para obter um contexto de dispositivo (DC) para toda a área de uma janela, incluindo qualquer decoração da janela, como barras de rolagem, bordas e títulos.
Quando você obtém um DC usando GetWindowDC, você pode desenhar na janela inteira, incluindo suas partes não-cliente (áreas fora do cliente da janela).
Normalmente, você usaria GetWindowDC quando precisa desenhar em toda a área da janela, incluindo a área decorativa.

GetDC (Device Context):

A função GetDC é usada para obter um contexto de dispositivo (DC) para a área de cliente de uma janela, que é a área dentro das bordas da janela, excluindo qualquer decoração da janela, como barras de rolagem e bordas.
Quando você obtém um DC usando GetDC, você pode desenhar apenas na área de cliente da janela, onde o conteúdo da aplicação é normalmente exibido.
Este contexto DC é frequentemente usado para desenhar gráficos, texto ou realizar outras operações gráficas dentro da área de cliente da janela.

Em resumo, a diferença principal entre GetWindowDC e GetDC é que a primeira é usada para obter um contexto de dispositivo para a área completa de uma janela, incluindo suas partes não-cliente, enquanto a segunda é usada para obter um contexto de dispositivo apenas para a área de cliente da janela.

A área não cliente de uma janela é a região que circunda a área de cliente da janela. Em termos mais simples, é a parte da janela que não contém o conteúdo da aplicação em si, mas sim a decoração e as funcionalidades visuais da janela. Esta área geralmente inclui:

1. **Barras de título**: A barra na parte superior da janela que geralmente contém o título da janela e botões de controle, como minimizar, maximizar e fechar.

2. **Bordas**: As bordas ao redor da janela que a delineiam visualmente e podem ser redimensionadas pelo usuário, dependendo das configurações da janela.

3. **Barras de rolagem**: Se a janela tiver conteúdo que se estende além de sua área de cliente, barras de rolagem vertical e/ou horizontal podem ser exibidas na borda da janela para permitir que o usuário navegue pelo conteúdo.

4. **Área de sistema**: Algumas janelas podem incluir uma área no canto superior esquerdo que pode conter o ícone do aplicativo ou outros controles do sistema.

Essas partes constituem a área não cliente da janela. Enquanto a área de cliente é reservada para o conteúdo da aplicação, a área não cliente contém elementos de interface do usuário que são gerenciados pelo sistema operacional e não pela aplicação em si.

