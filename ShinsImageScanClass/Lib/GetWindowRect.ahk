
/*
A função GetWindowRect (winuser.h) recupera as dimensões do retângulo delimitador da janela especificada. As dimensões são fornecidas em coordenadas de tela que são relativas ao canto superior esquerdo da tela.

Sintaxe
C++

```cpp
BOOL GetWindowRect(
  [in]  HWND   hWnd,
  [out] LPRECT lpRect
);
```

Parâmetros
[in] hWnd

Tipo: HWND

Um identificador para a janela.

[out] lpRect

Tipo: LPRECT

Um ponteiro para uma estrutura RECT que recebe as coordenadas de tela dos cantos superior esquerdo e inferior direito da janela.

Valor de retorno
Tipo: BOOL

Se a função for bem-sucedida, o valor de retorno será diferente de zero.

Se a função falhar, o valor de retorno será zero. Para obter informações de erro estendidas, chame GetLastError.

Observações
Em conformidade com as convenções para a estrutura RECT, as coordenadas do canto inferior direito do retângulo retornado são exclusivas. Em outras palavras, o pixel em (right, bottom) está imediatamente fora do retângulo.

GetWindowRect é virtualizado para DPI.

No Windows Vista e posterior, o retângulo da janela agora inclui a área ocupada pela sombra.

Chamar GetWindowRect terá comportamentos diferentes dependendo se a janela já foi mostrada ou não. Se a janela ainda não foi mostrada, GetWindowRect não incluirá a área da sombra.

Para obter os limites da janela excluindo a sombra, use DwmGetWindowAttribute, especificando DWMWA_EXTENDED_FRAME_BOUNDS. Observe que, ao contrário do retângulo da janela, os limites do Quadro Estendido do DWM não são ajustados para DPI. Obter os limites do quadro estendido só pode ser feito após a janela ter sido mostrada pelo menos uma vez.