HIconToBitmap(image) {
   ; struct ICONINFO - https://docs.microsoft.com/en-us/windows/win32/api/winuser/ns-winuser-iconinfo
   ii := Buffer(8 + 3 * A_PtrSize)                       ; sizeof(ICONINFO) = 20, 32
   DllCall("GetIconInfo", "ptr", image, "ptr", ii)
      ; xHotspot := NumGet(ii, 4, "uint")
      ; yHotspot := NumGet(ii, 8, "uint")
      , hbmMask := NumGet(ii, 8 + A_PtrSize, "ptr")   ; 12, 16
      , hbmColor := NumGet(ii, 8 + 2 * A_PtrSize, "ptr") ; 16, 24

   ; struct BITMAP - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmap
   bm := Buffer(16 + 2 * A_PtrSize)                      ; sizeof(BITMAP) = 24, 32
   DllCall("GetObject", "ptr", hbmMask, "int", bm.size, "ptr", bm)
      , width := NumGet(bm, 4, "uint")
      , height := NumGet(bm, 8, "uint") / (hbmColor ? 1 : 2) ; Black and White cursors have doubled height.

   ; Clean up these hBitmaps.
   DllCall("DeleteObject", "ptr", hbmMask)
   DllCall("DeleteObject", "ptr", hbmColor)

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

   ; Don't use DI_DEFAULTSIZE to draw the icon like DrawIcon does as it will resize to 32 x 32.
   DllCall("user32\DrawIconEx"
      , "ptr", hdc, "int", 0, "int", 0
      , "ptr", image, "int", 0, "int", 0
      , "uint", 0, "ptr", 0, "uint", 0x1 | 0x2 | 0x4) ; DI_MASK | DI_IMAGE | DI_COMPAT

   ; Convert the pARGB pixels copied into the device independent bitmap (hbm) to ARGB.
   DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

   ; Cleanup the hBitmap and device contexts.
   DllCall("SelectObject", "ptr", hdc, "ptr", obm)
   DllCall("DeleteObject", "ptr", hbm)
   DllCall("DeleteDC", "ptr", hdc)

   return pBitmap
}