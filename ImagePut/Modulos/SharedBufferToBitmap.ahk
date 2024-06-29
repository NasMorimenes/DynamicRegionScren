SharedBufferToBitmap(image) {
   hMap := DllCall("OpenFileMapping", "uint", 0x2, "int", 0, "str", image, "ptr")
   pMap := DllCall("MapViewOfFile", "ptr", hMap, "uint", 0x2, "uint", 0, "uint", 0, "uptr", 0, "ptr")

   width := NumGet(pMap + 0, "uint")
   height := NumGet(pMap + 4, "uint")
   size := 4 * width * height
   ptr := pMap + 8

   ; Create a destination GDI+ Bitmap that owns its memory. The pixel format is 32-bit ARGB.
   DllCall("gdiplus\GdipCreateBitmapFromScan0"
      , "int", width, "int", height, "uint", size / height, "uint", 0x26200A, "ptr", 0, "ptr*", &pBitmap := 0)

   ; Create a Scan0 buffer pointing to pBits.
   Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
   NumPut("uint", width, Rect, 8) ; Width
   NumPut("uint", height, Rect, 12) ; Height
   BitmapData := Buffer(16 + 2 * A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
   NumPut("int", 4 * width, BitmapData, 8) ; Stride
   NumPut("ptr", ptr, BitmapData, 16) ; Scan0

   ; Use LockBits to create a writable buffer that converts pARGB to ARGB.
   DllCall("gdiplus\GdipBitmapLockBits"
      , "ptr", pBitmap
      , "ptr", Rect
      , "uint", 6            ; ImageLockMode.UserInputBuffer | ImageLockMode.WriteOnly
      , "int", 0x26200A     ; Format32bppArgb
      , "ptr", BitmapData)  ; Contains the pointer (pBits) to the hbm.

   ; Convert the pARGB pixels copied into the device independent bitmap (hbm) to ARGB.
   DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

   DllCall("UnmapViewOfFile", "ptr", pMap)
   DllCall("CloseHandle", "ptr", hMap)

   return pBitmap
}