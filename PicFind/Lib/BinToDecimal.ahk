;#Include Includes.ahk

;Bit := 2

;Ass := Bit << 1

;Bin := [1,1,0,1]

;Bin.Length

;2 ** ( Bin.Length - 1 )
;2 ** ( Bin.Length - 1 )

;MsgBox( BinToDecimal( Bin) )

BinToDecimal( Bin ) {

    static a := 0 
    static Index := Bin.Length
    static Count :=0
    static _Bin := Bin
    static x

    ++Count
    --Index
    x := _Bin[ Count ] * ( 2 ** ( Index ) )
    a := a + x
    while Index > 0 
        BinToDecimal( Index )

    return a
}

/*

Etapas de conversão de binário para decimal
Primeiro, escreva o número binário fornecido e conte as potências de 2 da direita para a esquerda (potências começando em 0)
Agora, escreva cada dígito binário (da direita para a esquerda) com as potências de 2 correspondentes da direita para a esquerda, de modo que o primeiro dígito binário (MSB) seja multiplicado pela maior potência de 2.
Adicione todos os produtos na etapa acima
A resposta final será o número decimal necessário
Vamos entender essa conversão com a ajuda de um exemplo.

Exemplo de conversão de binário para decimal:

Converta o número binário (1101) 2 em um número decimal.

Solução:

Dado número binário = (1101) 2

Agora, multiplicando cada dígito de MSB para LSB, reduzimos a potência do número base 2.

1 × 2 3 + 1 × 2 2 + 0 × 2 1 + 1 × 2 0

= 8 + 4 + 0 + 1

= 13