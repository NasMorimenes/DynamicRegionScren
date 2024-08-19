

/*

A função GetClientRect (winuser.h) recupera as coordenadas da área cliente de uma janela. As coordenadas do cliente especificam os cantos superior esquerdo e inferior direito da área cliente. Como as coordenadas do cliente são relativas ao canto superior esquerdo da área cliente de uma janela, as coordenadas do canto superior esquerdo são (0,0).

Sintaxe
C++

```cpp
BOOL GetClientRect(
  [in]  HWND   hWnd,
  [out] LPRECT lpRect
);
```

Parâmetros
[in] hWnd

Tipo: HWND

Um identificador para a janela cujas coordenadas do cliente devem ser recuperadas.

[out] lpRect

Tipo: LPRECT

Um ponteiro para uma estrutura RECT que recebe as coordenadas do cliente. Os membros left e top são zero. Os membros right e bottom contêm a largura e altura da janela.

Valor de retorno
Tipo: BOOL

Se a função for bem-sucedida, o valor de retorno será diferente de zero.

Se a função falhar, o valor de retorno será zero. Para obter informações de erro estendidas, chame GetLastError.

Observações
Conforme as convenções para a estrutura RECT, as coordenadas do canto inferior direito do retângulo retornado são exclusivas. Em outras palavras, o pixel em (right, bottom) está imediatamente fora do retângulo.