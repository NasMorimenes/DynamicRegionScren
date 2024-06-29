BitmapToCoimage(cotype, pBitmap, p1:="", p2:="", p3:="", p4:="", p5:="", p6:="", p7:="", p*) {

      if (cotype = "Clipboard") ; (pBitmap)
         return BitmapToClipboard(pBitmap)

      if (cotype = "Screenshot") ; (pBitmap, pos, alpha)
         return BitmapToScreenshot(pBitmap, p1, p2)

      if (cotype = "Window") ; (pBitmap, title, pos, style, styleEx, parent, playback, cache)
         return BitmapToWindow(pBitmap, p1, p2, p3, p4, p5, p6, p7)

      if (cotype = "Show") ; (pBitmap, title, pos, style, styleEx, parent, playback, cache)
         return Show(pBitmap, p1, p2, p3, p4, p5, p6, p7)

      if (cotype = "EncodedBuffer") ; (pBitmap, extension, quality)
         return BitmapToEncodedBuffer(pBitmap, p1, p2)

      if (cotype = "Buffer") ; (pBitmap)
         return BitmapToBuffer(pBitmap)

      if (cotype = "SharedBuffer") ; (pBitmap, name)
         return BitmapToSharedBuffer(pBitmap, p1)

      if (cotype = "Desktop") ; (pBitmap)
         return BitmapToDesktop(pBitmap)

      if (cotype = "Wallpaper") ; (pBitmap)
         return BitmapToWallpaper(pBitmap)

      if (cotype = "Cursor") ; (pBitmap, xHotspot, yHotspot)
         return BitmapToCursor(pBitmap, p1, p2)

      if (cotype = "Url") ; (pBitmap)
         return BitmapToUrl(pBitmap)

      if (cotype = "File") ; (pBitmap, filepath, quality)
         return BitmapToFile(pBitmap, p1, p2)

      if (cotype = "Hex") ; (pBitmap, extension, quality)
         return BitmapToHex(pBitmap, p1, p2)

      if (cotype = "Base64") ; (pBitmap, extension, quality)
         return BitmapToBase64(pBitmap, p1, p2)

      if (cotype = "Uri") ; (pBitmap, extension, quality)
         return BitmapToUri(pBitmap, p1, p2)

      if (cotype = "DC") ; (pBitmap, alpha)
         return BitmapToDC(pBitmap, p1)

      if (cotype = "HBitmap") ; (pBitmap, alpha)
         return BitmapToHBitmap(pBitmap, p1)

      if (cotype = "HIcon") ; (pBitmap)
         return BitmapToHIcon(pBitmap)

      if (cotype = "Bitmap")
         return pBitmap

      if (cotype = "Stream") ; (pBitmap, extension, quality)
         return BitmapToStream(pBitmap, p1, p2)

      if (cotype = "RandomAccessStream") ; (pBitmap, extension, quality)
         return BitmapToRandomAccessStream(pBitmap, p1, p2)

      if (cotype = "WicBitmap") ; (pBitmap)
         return BitmapToWicBitmap(pBitmap)

      if (cotype = "Explorer") ; (pBitmap, default)
         return BitmapToExplorer(pBitmap, p1)

      if (cotype = "SafeArray") ; (pBitmap, extension, quality)
         return BitmapToSafeArray(pBitmap, p1, p2)

         if (cotype = "FormData") ; (pBitmap, boundary, extension, quality)
            return BitmapToFormData(pBitmap, p1, p2, p3)

      throw Error("Conversion from bitmap to " cotype " is not supported.")
   }