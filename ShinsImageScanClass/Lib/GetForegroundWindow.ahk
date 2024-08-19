GetForegroundWindow() {
    HWND :=
    DllCall(
        "GetForegroundWindow",
        "Ptr"
    )
    return HWND
}

/*
A função GetForegroundWindow (winuser.h) recupera um identificador para a janela em primeiro plano (a janela com a qual o usuário está trabalhando atualmente). O sistema atribui uma prioridade ligeiramente maior à thread que cria a janela em primeiro plano do que às outras threads.

Sintaxe
C++

```cpp
HWND GetForegroundWindow();
```

Valor de retorno
Tipo: HWND

O valor de retorno é um identificador para a janela em primeiro plano. A janela em primeiro plano pode ser NULL em certas circunstâncias, como quando uma janela está perdendo a ativação.