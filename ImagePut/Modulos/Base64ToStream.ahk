#Include Includes.ahk
/**
 * Converte uma string Base64 em um stream binário.
 *
 * @param {string} image - A string Base64 que representa a imagem.
 * @returns {ptr} - Um ponteiro para o stream binário.
 */
Base64ToStream( image ) {
    stream := 0
    ; Remover espaços em branco e o tipo MIME da string.
    image := Trim( image )
    image := RegExReplace( image, "(?i)^data:image\/[a-z]+;base64," )
    ; Recuperar o tamanho em bytes a partir do comprimento da string Base64.
    size := StrLen( RTrim( image, "=") ) * 3 // 4    
    ; Alocar memória global para armazenar os dados binários.
    handle := GlobalAlloc( size )
    ; Bloquear a memória global para obter um ponteiro para a memória.
    bin := GlobalLock( handle )
    CryptStringToBinary( image, bin, size )
    ; Desbloquear a memória global.
    GlobalUnlock( handle )
    ; Criar um stream na memória global que será liberado com ObjRelease().
    hresult := CreateStreamOnHGlobal(handle, stream)
    if (hresult != 0) {
        throw Error("Falha ao criar stream na memória global. Código de erro: " . hresult)
    }

    return stream
}