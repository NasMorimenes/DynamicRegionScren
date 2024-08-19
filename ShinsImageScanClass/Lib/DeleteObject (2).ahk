DeleteObject( hBM ) {
    DllCall(
        "DeleteObject",
        "Ptr", hBM
    )
}

/*
Função DeleteObject (wingdi.h)

A função DeleteObject deleta uma caneta lógica, pincel, fonte, bitmap, região ou paleta, liberando todos os recursos do sistema associados ao objeto. Após a exclusão do objeto, o identificador especificado não é mais válido.

Sintaxe
C++

Copy
BOOL DeleteObject(
  [in] HGDIOBJ ho
);
Parâmetros
[in] ho

Um identificador para uma caneta lógica, pincel, fonte, bitmap, região ou paleta.

Valor de retorno
Se a função for bem-sucedida, o valor de retorno é diferente de zero.

Se o identificador especificado não for válido ou estiver atualmente selecionado em um DC, o valor de retorno é zero.

Observações
Não exclua um objeto de desenho (caneta ou pincel) enquanto ele estiver selecionado em um DC.

Quando um pincel de padrão é excluído, o bitmap associado ao pincel não é excluído. O bitmap deve ser excluído independentemente.