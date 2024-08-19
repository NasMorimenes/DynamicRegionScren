#Include MCode.ahk

/**
 * Calcula o limiar cinza de uma imagem utilizando a mediana dos valores de pixel.
 * 
 * @param buffer  Um ponteiro para o buffer contendo os valores de pixel da imagem.
 * @param largura A largura da imagem em pixels.
 * @param altura  A altura da imagem em pixels.
 * @return O limiar cinza calculado usando a mediana dos valores de pixel na imagem.
 * 
 * Esta função calcula o limiar cinza de uma imagem, representada por um buffer unidimensional
 * de pixels, usando a mediana dos valores de pixel. Primeiro, o buffer é ordenado usando
 * a função qsort_independente. Em seguida, a mediana dos valores é calculada e retornada como
 * o limiar cinza.
 */
/*
int calcularLimiarCinzaMediana(int *buffer, int largura, int altura) 
{
    // Calcular o tamanho total do buffer
    int tamanho = largura * altura;

    // Ordenar os valores
    //qsort_independente(buffer, 0, tamanho - 1);
    
    // Calcular a mediana
    int mediana;
    if (tamanho % 2 == 0) {
        mediana = (buffer[tamanho / 2 - 1] + buffer[tamanho / 2]) / 2;
    } else {
        mediana = buffer[tamanho / 2];
    }
    
    return mediana;
}
*/
mediana( Int_Buf, Int_W, Int_H ) {
    Hex :=
    (
    "440fafc24489c0c1e81f4401c0d1f84183e0014898488d1485000000008b0481750d034411fc89c2c1ea1f01d0d1f8c3"
    )
    code := MCode( Hex )
    msdiana :=
    DllCall(
        Code,
        "Ptr", Int_Buf,
        "Int", Int_W,
        "Int", Int_H,
        "Int"
    )

    return msdiana
}
