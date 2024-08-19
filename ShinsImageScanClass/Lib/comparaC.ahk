#Include MCode.ahk
/**
 * Função de comparação para ser usada como critério de ordenação em algoritmos de ordenação.
 * 
 * Esta função compara dois valores apontados por 'a' e 'b' e retorna um valor inteiro que indica
 * a relação entre eles.
 * 
 * @param a Ponteiro para o primeiro elemento a ser comparado.
 * @param b Ponteiro para o segundo elemento a ser comparado.
 * @return Um valor negativo se o elemento apontado por 'a' for menor que o elemento apontado por 'b',
 *         zero se forem iguais, ou um valor positivo se o elemento apontado por 'a' for maior que o 
 *         elemento apontado por 'b'.
 */
/*
int comparar(const void *a, const void *b) 
{
    // Converte os ponteiros para inteiros e compara os valores
    
    return (*(int*)a - *(int*)b);
}
*/

Hex := "8b012b02c3"
code := MCode( Hex )
;_a :=Buffer( 4, 0 )
;NumPut( "Int", 10, _a, 0 )
;_b := Buffer( 4, 0 )
;NumPut( "Int", 20, _a, 0 )
_a := 20
_b := 10
Assd :=
DllCall(
    code,
    "Ptr*", &_a,
    "Ptr*", &_b,
    "Int"
)
;Assd := NumGet( Ass, 0, "Int" )
MsgBox( Assd )