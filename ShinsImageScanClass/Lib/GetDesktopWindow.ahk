GetDesktopWindow() {
    Win :=
    DllCall(
        "GetDesktopWindow",
        "Ptr"
    )
    return Win
}

/*
GetDesktopWindow Função (winuser.h)

Recupera um identificador para a janela do desktop. A janela do desktop cobre toda a tela. A janela do desktop é a área sobre a qual outras janelas são pintadas.

Sintaxe
C++

Copy
HWND GetDesktopWindow();
Valor de retorno
Tipo: HWND

O valor de retorno é um identificador para a janela do desktop.