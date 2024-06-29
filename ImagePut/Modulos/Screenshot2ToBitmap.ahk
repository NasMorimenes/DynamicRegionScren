Screenshot2ToBitmap(image) {
   obj := read_screen()

   width := obj.width
   height := obj.height
   pBits := obj.ptr
   size := obj.size

   ; Create a destination GDI+ Bitmap that owns its memory. The pixel format is 32-bit pre-multiplied ARGB.
   DllCall("gdiplus\GdipCreateBitmapFromScan0"
      , "int", width, "int", height, "uint", size / height, "uint", 0xE200B, "ptr", 0, "ptr*", &pBitmap := 0)

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

   ; Convert the pARGB pixels copied into the device independent bitmap (hbm) to ARGB.
   DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

   return pBitmap
}