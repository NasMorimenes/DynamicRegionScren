DeleteDC( HGDIOBJ ) {
    DllCall(
        "DeleteDC",
        "Ptr", HGDIOBJ
    )

}
/*
Função DeleteDC (wingdi.h)

A função DeleteDC deleta o contexto de dispositivo (DC) especificado.

Sintaxe
C++

Copy
BOOL DeleteDC(
  [in] HDC hdc
);
Parâmetros
[in] hdc

Um identificador para o contexto de dispositivo.

Valor de retorno
Se a função for bem-sucedida, o valor de retorno é diferente de zero.

Se a função falhar, o valor de retorno é zero.

Observações
Uma aplicação não deve excluir um DC cujo identificador foi obtido chamando a função GetDC. Em vez disso, deve chamar a função ReleaseDC para liberar o DC.