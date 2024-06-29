BitmapToSharedBuffer(pBitmap, name := "Alice") {
      ; Get Bitmap width and height.
      DllCall("gdiplus\GdipGetImageWidth", "ptr", pBitmap, "uint*", &width:=0)
      DllCall("gdiplus\GdipGetImageHeight", "ptr", pBitmap, "uint*", &height:=0)

      ; Allocate shared memory.
      size := 4 * width * height
      hMap := DllCall("CreateFileMapping", "ptr", -1, "ptr", 0, "uint", 0x4, "uint", 0, "uint", size, "str", name, "ptr")
      pMap := DllCall("MapViewOfFile", "ptr", hMap, "uint", 0x2, "uint", 0, "uint", 0, "uptr", 0, "ptr")

      ; Store width and height in the first 8 bytes.
      NumPut("uint",  width, pMap + 0)
      NumPut("uint", height, pMap + 4)
      ptr := pMap + 8

      ; Target a pixel buffer.
      Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
         NumPut(  "uint",   width, Rect,  8) ; Width
         NumPut(  "uint",  height, Rect, 12) ; Height
      BitmapData := Buffer(16+2*A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
         NumPut(   "int",  4 * width, BitmapData,  8) ; Stride
         NumPut(   "ptr",        ptr, BitmapData, 16) ; Scan0
      DllCall("gdiplus\GdipBitmapLockBits"
               ,    "ptr", pBitmap
               ,    "ptr", Rect
               ,   "uint", 5            ; ImageLockMode.UserInputBuffer | ImageLockMode.ReadOnly
               ,    "int", 0x26200A     ; Format32bppArgb
               ,    "ptr", BitmapData)

      ; Write pixels to buffer.
      DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

      ; Free the pixels later.
      buf := ImagePut.BitmapBuffer(ptr, size, width, height)
      buf.free := [() => DllCall("UnmapViewOfFile", "ptr", pMap), () => DllCall("CloseHandle", "ptr", hMap)]
      buf.name := name
      return buf
   }