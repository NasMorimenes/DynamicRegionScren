ImageToBitmap(type, image, keywords := "") {

   try index := keywords.index

   if (type = "ClipboardPng")
      return ClipboardPngToBitmap()

   if (type = "Clipboard")
      return ClipboardToBitmap()

   if (type = "SafeArray")
      return SafeArrayToBitmap(image)

   if (type = "Screenshot")
      return ScreenshotToBitmap(image)

   if (type = "Window")
      return WindowToBitmap(image)

   if (type = "Object")
      return BitmapToBitmap(image.pBitmap)

   if (type = "EncodedBuffer")
      return EncodedBufferToBitmap(image)

   if (type = "Buffer")
      return BufferToBitmap(image)

   if (type = "SharedBuffer")
      return SharedBufferToBitmap(image)

   if (type = "Monitor")
      return MonitorToBitmap(image)

   if (type = "Desktop")
      return DesktopToBitmap()

   if (type = "Wallpaper")
      return WallpaperToBitmap()

   if (type = "Cursor")
      return CursorToBitmap()

   if (type = "Url")
      return UrlToBitmap(image)

   if (type = "File")
      return FileToBitmap(image)

   if (type = "Hex")
      return HexToBitmap(image)

   if (type = "Base64")
      return Base64ToBitmap(image)

   if (type = "DC")
      return DCToBitmap(image)

   if (type = "HBitmap")
      return HBitmapToBitmap(image)

   if (type = "HIcon")
      return HIconToBitmap(image)

   if (type = "Bitmap")
      return BitmapToBitmap(image)

   if (type = "Stream")
      return StreamToBitmap(image)

   if (type = "RandomAccessStream")
      return RandomAccessStreamToBitmap(image)

   if (type = "WicBitmap")
      return WicBitmapToBitmap(image)

   if (type = "D2dBitmap")
      return D2dBitmapToBitmap(image)

   throw Error("Conversion from " type " to bitmap is not supported.")
}