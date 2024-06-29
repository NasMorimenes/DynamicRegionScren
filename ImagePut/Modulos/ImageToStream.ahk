ImageToStream(type, image, keywords := "") {

      try index := keywords.index

      if (type = "ClipboardPng")
         return ClipboardPngToStream()

      if (type = "SafeArray")
         return SafeArrayToStream(image)

      if (type = "EncodedBuffer")
         return EncodedBufferToStream(image)

      if (type = "Url")
         return UrlToStream(image)

      if (type = "File")
         return FileToStream(image)

      if (type = "Hex")
         return HexToStream(image)

      if (type = "Base64")
         return Base64ToStream(image)

      if (type = "Stream")
         return StreamToStream(image)

      if (type = "RandomAccessStream")
         return RandomAccessStreamToStream(image)

      throw Error("Conversion from " type " to stream is not supported.")
   }