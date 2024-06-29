BitmapSprite(&pBitmap) {
   ; Get Bitmap width and height.
   DllCall("gdiplus\GdipGetImageWidth", "ptr", pBitmap, "uint*", &width := 0)
   DllCall("gdiplus\GdipGetImageHeight", "ptr", pBitmap, "uint*", &height := 0)

   ; Create a pixel buffer.
   Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
   NumPut("uint", width, Rect, 8) ; Width
   NumPut("uint", height, Rect, 12) ; Height
   BitmapData := Buffer(16 + 2 * A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
   DllCall("gdiplus\GdipBitmapLockBits"
      , "ptr", pBitmap
      , "ptr", Rect
      , "uint", 3            ; ImageLockMode.ReadWrite
      , "int", 0x26200A     ; Format32bppArgb
      , "ptr", BitmapData)
   Scan0 := NumGet(BitmapData, 16, "ptr")

   ; C source code - https://godbolt.org/z/nrv5Yr3Y3
   static code := 0
   if !code {
      b64 := (A_PtrSize == 4)
         ? "VYnli0UIi1UMi00QOdBzDzkIdQbHAAAAAACDwATr7V3D"
            : "SDnRcw9EOQF1BDHAiQFIg8EE6+zD"
      s64 := StrLen(RTrim(b64, "=")) * 3 // 4
      code := DllCall("GlobalAlloc", "uint", 0, "uptr", s64, "ptr")
      DllCall("crypt32\CryptStringToBinary", "str", b64, "uint", 0, "uint", 0x1, "ptr", code, "uint*", s64, "ptr", 0, "ptr", 0)
      DllCall("VirtualProtect", "ptr", code, "ptr", s64, "uint", 0x40, "uint*", 0)
   }

   ; Sample the top-left pixel and set all matching pixels to be transparent.
   DllCall(code, "ptr", Scan0, "ptr", Scan0 + 4 * width * height, "uint", NumGet(Scan0, "uint"), "cdecl")

   ; Write pixels to bitmap.
   DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

   return pBitmap
}