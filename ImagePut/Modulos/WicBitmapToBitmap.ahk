WicBitmapToBitmap(image) {
   ComCall(GetSize := 3, image, "uint*", &width := 0, "uint*", &height := 0)

   ; Create a destination GDI+ Bitmap that owns its memory. The pixel format is 32-bit ARGB.
   DllCall("gdiplus\GdipCreateBitmapFromScan0"
      , "int", width, "int", height, "int", 0, "int", 0x26200A, "ptr", 0, "ptr*", &pBitmap := 0)

   ; Create a pixel buffer.
   Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
   NumPut("uint", width, Rect, 8) ; Width
   NumPut("uint", height, Rect, 12) ; Height
   BitmapData := Buffer(16 + 2 * A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
   DllCall("gdiplus\GdipBitmapLockBits"
      , "ptr", pBitmap
      , "ptr", Rect
      , "uint", 2            ; ImageLockMode.WriteOnly
      , "int", 0x26200A     ; Format32bppArgb
      , "ptr", BitmapData)
   Scan0 := NumGet(BitmapData, 16, "ptr")
   stride := NumGet(BitmapData, 8, "int")

   ComCall(CopyPixels := 7, image, "ptr", Rect, "uint", stride, "uint", stride * height, "ptr", Scan0)

   ; Write pixels to bitmap.
   DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

   return pBitmap
}