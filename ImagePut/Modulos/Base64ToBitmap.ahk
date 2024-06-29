#Include Includes.ahk
/**
 * Converte uma string Base64 em um bitmap.
 *
 * @param {string} image - A string Base64 que representa a imagem.
 * @returns {ptr} - Um ponteiro para o bitmap criado.
 */
Base64ToBitmap( image ) {
   
   stream := Base64ToStream( image )

   ; Criar um bitmap a partir do stream
   pBitmap := CreateBitmapFromStreamICM(stream)

   ObjRelease(stream)  

   return pBitmap ; Retorna o ponteiro para o bitmap criado
}