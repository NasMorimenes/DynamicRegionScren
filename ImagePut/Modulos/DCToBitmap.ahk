DCToBitmap(image) {
   ; An application cannot select a single bitmap into more than one DC at a time.
   if !(sbm := DllCall("GetCurrentObject", "ptr", image, "uint", 7))
      throw Error("The device context has no bitmap selected.")

   ; struct DIBSECTION - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-dibsection
   ; struct BITMAP - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmap
   dib := Buffer(64 + 5 * A_PtrSize) ; sizeof(DIBSECTION) = 84, 104
   DllCall("GetObject", "ptr", sbm, "int", dib.size, "ptr", dib)
      , width := NumGet(dib, 4, "uint")
      , height := NumGet(dib, 8, "uint")
      , bpp := NumGet(dib, 18, "ushort")
      , pBits := NumGet(dib, A_PtrSize = 4 ? 20 : 24, "ptr")

   ; Fallback to built-in method if pixels are not 32-bit ARGB or hBitmap is a device dependent bitmap.
   if (pBits = 0 || bpp != 32) { ; This built-in version is 120% faster but ignores transparency.
      DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", sbm, "ptr", 0, "ptr*", &pBitmap := 0)
      return pBitmap
   }

   ; Create a device independent bitmap with negative height. All DIBs use the screen pixel format (pARGB).
   ; Use hbm to buffer the image such that top-down and bottom-up images are mapped to this top-down buffer.
   ; pBits is the pointer to (top-down) pixel values. The Scan0 will point to the pBits.
   ; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
   hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
   bi := Buffer(40, 0)                    ; sizeof(bi) = 40
   NumPut("uint", 40, bi, 0) ; Size
   NumPut("int", width, bi, 4) ; Width
   NumPut("int", -height, bi, 8) ; Height - Negative so (0, 0) is top-left.
   NumPut("ushort", 1, bi, 12) ; Planes
   NumPut("ushort", 32, bi, 14) ; BitCount / BitsPerPixel
   hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", bi, "uint", 0, "ptr*", &pBits := 0, "ptr", 0, "uint", 0, "ptr")
   obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")

   ; Create a destination GDI+ Bitmap that owns its memory to receive the final converted pixels. The pixel format is 32-bit ARGB.
   DllCall("gdiplus\GdipCreateBitmapFromScan0"
      , "int", width, "int", height, "int", 0, "int", 0x26200A, "ptr", 0, "ptr*", &pBitmap := 0)

   ; Create a Scan0 buffer pointing to pBits. The buffer has pixel format pARGB.
   Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
   NumPut("uint", width, Rect, 8) ; Width
   NumPut("uint", height, Rect, 12) ; Height
   BitmapData := Buffer(16 + 2 * A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
   NumPut("int", 4 * width, BitmapData, 8) ; Stride
   NumPut("ptr", pBits, BitmapData, 16) ; Scan0

   ; Use LockBits to create a writable buffer that converts pARGB to ARGB.
   DllCall("gdiplus\GdipBitmapLockBits"
      , "ptr", pBitmap
      , "ptr", Rect
      , "uint", 6            ; ImageLockMode.UserInputBuffer | ImageLockMode.WriteOnly
      , "int", 0xE200B      ; Format32bppPArgb
      , "ptr", BitmapData)  ; Contains the pointer (pBits) to the hbm.

   ; Copies the image (hBitmap) to a top-down bitmap. Removes bottom-up-ness if present.
   DllCall("gdi32\BitBlt"
      , "ptr", hdc, "int", 0, "int", 0, "int", width, "int", height
      , "ptr", image, "int", 0, "int", 0, "uint", 0x00CC0020) ; SRCCOPY

   ; Convert the pARGB pixels copied into the device independent bitmap (hbm) to ARGB.
   DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

   ; Cleanup the hBitmap and device contexts.
   DllCall("SelectObject", "ptr", hdc, "ptr", obm)
   DllCall("DeleteObject", "ptr", hbm)
   DllCall("DeleteDC", "ptr", hdc)

   return pBitmap
}