BitmapToBuffer(pBitmap) {
   ; Get Bitmap width and height.
   DllCall("gdiplus\GdipGetImageWidth", "ptr", pBitmap, "uint*", &width := 0)
   DllCall("gdiplus\GdipGetImageHeight", "ptr", pBitmap, "uint*", &height := 0)

   ; Allocate global memory.
   size := 4 * width * height
   ptr := DllCall("GlobalAlloc", "uint", 0, "uptr", size, "ptr")

   ; Create a pixel buffer.
   Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
   NumPut("uint", width, Rect, 8) ; Width
   NumPut("uint", height, Rect, 12) ; Height
   BitmapData := Buffer(16 + 2 * A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
   NumPut("int", 4 * width, BitmapData, 8) ; Stride
   NumPut("ptr", ptr, BitmapData, 16) ; Scan0
   DllCall("gdiplus\GdipBitmapLockBits"
      , "ptr", pBitmap
      , "ptr", Rect
      , "uint", 5            ; ImageLockMode.UserInputBuffer | ImageLockMode.ReadOnly
      , "int", 0x26200A     ; Format32bppArgb
      , "ptr", BitmapData)

   ; Write pixels to global memory.
   DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

   ; Free the pixels later.
   buf := ImagePut.BitmapBuffer(ptr, size, width, height)
   buf.free := [DllCall.bind("GlobalFree", "ptr", ptr)]
   return buf
}