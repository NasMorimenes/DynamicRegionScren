#Include Includes.ahk
/**
 * Clona um bitmap para criar um novo bitmap.
 *
 * @param {ptr} image - Um ponteiro para o bitmap original.
 * @returns {ptr} - Um ponteiro para o novo bitmap clonado.
 */
BitmapToBitmap(image) {
   ; Inicializar o ponteiro do novo bitmap como 0
   newBitmap := 0

   ; Obter a largura, altura e formato do bitmap original

   width := GdipGetImageWidth( image )
   height := GdipGetImageWidth( image )
   pformat := GdipGetImagePixelFormat( image )

   ; Clonar o bitmap original para criar um novo bitmap
   result := DllCall(
       "gdiplus\GdipCloneBitmapAreaI", ; Nome da função na DLL GDI+
       "int", 0, ; Coordenada x do canto superior esquerdo da área de recorte (0 para clonar todo o bitmap)
       "int", 0, ; Coordenada y do canto superior esquerdo da área de recorte (0 para clonar todo o bitmap)
       "int", width, ; Largura da área de recorte (largura total do bitmap)
       "int", height, ; Altura da área de recorte (altura total do bitmap)
       "int", pformat, ; Formato de pixel do bitmap
       "ptr", image, ; Ponteiro para o bitmap original
       "ptr*", newBitmap ; Ponteiro para o ponteiro do novo bitmap
   )

   ; Verificar o resultado da chamada da função
   if (result != 0) {
       ; Se a função não retornar 0, houve um erro
       throw Error("Falha ao clonar o bitmap. Código de erro: " . result)
   }

   return newBitmap ; Retorna o ponteiro para o novo bitmap clonado
}
