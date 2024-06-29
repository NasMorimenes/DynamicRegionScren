StreamToCoimage(cotype, stream, p1 := "", p2 := "", p*) {

   if (cotype = "Clipboard") ; (stream)
      return StreamToClipboard(stream)

   if (cotype = "EncodedBuffer") ; (stream)
      return StreamToEncodedBuffer(stream)

   if (cotype = "File") ; (stream, filepath)
      return StreamToFile(stream, p1)

   if (cotype = "Hex") ; (stream)
      return StreamToHex(stream)

   if (cotype = "Base64") ; (stream)
      return StreamToBase64(stream)

   if (cotype = "Uri") ; (stream)
      return StreamToUri(stream)

   if (cotype = "Stream")
      return stream

   if (cotype = "RandomAccessStream") ; (stream)
      return StreamToRandomAccessStream(stream)

   if (cotype = "Explorer") ; (stream, default)
      return StreamToExplorer(stream, p1)

   if (cotype = "SafeArray") ; (stream)
      return StreamToSafeArray(stream)

   if (cotype = "FormData") ; (stream, boundary)
      return StreamToFormData(stream, p1)

   throw Error("Conversion from stream to " cotype " is not supported.")
}