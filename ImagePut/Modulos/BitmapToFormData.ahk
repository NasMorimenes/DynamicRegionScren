BitmapToFormData(bitmap, boundary := "", extension := "", quality := "") {
      if (boundary = "")
          boundary := "----WebKitFormBoundary" A_TickCount A_Now

      ; Converte o bitmap em um stream
      stream := BitmapToStream(bitmap, extension, quality)
      return StreamToFormData(stream, boundary)
   }