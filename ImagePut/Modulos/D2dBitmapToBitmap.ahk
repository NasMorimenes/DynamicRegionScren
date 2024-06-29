D2dBitmapToBitmap(d2dBitmap) {
   ; Implementação para converter um D2dBitmap em um bitmap
   ; Esta é uma implementação de exemplo e deve ser ajustada conforme necessário

   ; Obtém o HDC do bitmap D2D
   hdc := DllCall("GetDC", "ptr", d2dBitmap, "ptr")

   ; Obtém as dimensões do bitmap D2D
   width := DllCall("GetBitmapWidth", "ptr", d2dBitmap, "int")
   height := DllCall("GetBitmapHeight", "ptr", d2dBitmap, "int")
   ; Cria um bitmap a partir de D2dBitmap
   bitmap := DllCall("CreateCompatibleBitmap", "ptr", hdc, "int", width, "int", height, "ptr")

   ; Seleciona o bitmap para um DC de memória
   memDC := DllCall("CreateCompatibleDC", "ptr", hdc, "ptr")
   oldBmp := DllCall("SelectObject", "ptr", memDC, "ptr", bitmap, "ptr")

   ; Copia o conteúdo do D2dBitmap para o bitmap
   DllCall("BitBlt", "ptr", memDC, "int", 0, "int", 0, "int", width, "int", height, "ptr", d2dBitmap, "int", 0, "int", 0, "uint", 0x00CC0020)

   ; Restaura o antigo bitmap
   DllCall("SelectObject", "ptr", memDC, "ptr", oldBmp)
   DllCall("DeleteDC", "ptr", memDC)

   return bitmap
}