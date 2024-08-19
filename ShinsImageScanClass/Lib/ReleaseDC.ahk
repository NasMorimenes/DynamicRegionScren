ReleaseDC(Win, HDC) {
  Bool :=
  DllCall(
    "ReleaseDC",
    "Ptr", Win,
    "Ptr", HDC,
    "UInt"
  )
  return Bool
}

/*

Função ReleaseDC (winuser.h)

A função ReleaseDC libera um contexto de dispositivo (DC), liberando-o para uso por outras aplicações. O efeito da função ReleaseDC depende do tipo de DC. Ela libera apenas DCs comuns e de janela. Não tem efeito sobre DCs de classe ou privados.

Sintaxe
C++

Copy
int ReleaseDC(
  [in] HWND hWnd,
  [in] HDC  hDC
);
Parâmetros
[in] hWnd

Um identificador para a janela cujo DC deve ser liberado.

[in] hDC

Um identificador para o DC a ser liberado.

Valor de retorno
O valor de retorno indica se o DC foi liberado. Se o DC foi liberado, o valor de retorno é 1.

Se o DC não foi liberado, o valor de retorno é zero.

Observações
A aplicação deve chamar a função ReleaseDC para cada chamada à função GetWindowDC e para cada chamada à função GetDC que recupera um DC comum.

Uma aplicação não pode usar a função ReleaseDC para liberar um DC que foi criado chamando a função CreateDC; em vez disso, deve usar a função DeleteDC. ReleaseDC deve ser chamada a partir do mesmo thread que chamou GetDC.
