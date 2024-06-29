/**
 * Converte uma string Base64 em dados binários.
 *
 * @param {str} image - A string Base64 a ser convertida.
 * @param {ptr} bin - Um ponteiro para o buffer onde os dados binários serão armazenados.
 * @param {uint*} size - Um ponteiro para o tamanho dos dados binários.
 * @param {uint} flags - As bandeiras de conversão (padrão é 0x1 para CRYPT_STRING_BASE64).
 */
CryptStringToBinary(image, bin, size, flags := 0x1) {
    ; CRYPT_STRING_BASE64
    DllCall(
        "crypt32\CryptStringToBinary",
        "Str", image, ; A string Base64.
        "UInt", 0, ; O comprimento da string (0 para auto-detectar).
        "UInt", flags, ; As bandeiras de conversão.
        "Ptr", bin, ; O buffer onde os dados binários serão armazenados.
        "UInt*", size, ; O tamanho dos dados binários.
        "Ptr", 0, ; Reservado, deve ser NULL.
        "Ptr", 0 ; Reservado, deve ser NULL.
    )
}
