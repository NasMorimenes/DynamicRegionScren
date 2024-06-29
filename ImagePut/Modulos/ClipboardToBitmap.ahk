ClipboardToBitmap() {
      ; Open the clipboard with exponential backoff.
      loop
         if DllCall("OpenClipboard", "ptr", A_ScriptHwnd)
            break
         else
            if A_Index < 6
               Sleep (2**(A_Index-1) * 30)
            else throw Error("Clipboard could not be opened.")

      ; Check for CF_DIB to retrieve transparent pixels when possible.
      if DllCall("IsClipboardFormatAvailable", "uint", 8)
         if !(handle := DllCall("GetClipboardData", "uint", 8, "ptr"))
            throw Error("Shared clipboard data has been deleted.")

      ; Adjust Scan0 for top-down or bottom-up bitmaps.
      ptr := DllCall("GlobalLock", "ptr", handle, "ptr")
      width := NumGet(ptr + 4, "int")
      height := NumGet(ptr + 8, "int")
      bpp := NumGet(ptr + 14, "ushort")
      stride := ((height < 0) ? 1 : -1) * (width * bpp + 31) // 32 * 4
      pBits := ptr + 40
      Scan0 := (height < 0) ? pBits : pBits - stride*(height-1)

      ; Create a destination GDI+ Bitmap that owns its memory. The pixel format is 32-bit ARGB.
      DllCall("gdiplus\GdipCreateBitmapFromScan0"
               , "int", width, "int", height, "int", 0, "uint", 0x26200A, "ptr", 0, "ptr*", &pBitmap:=0)

      ; Describe the current buffer holding the pixel data.
      Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
         NumPut(  "uint",   width, Rect,  8) ; Width
         NumPut(  "uint",  height, Rect, 12) ; Height
      BitmapData := Buffer(16+2*A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
         NumPut(   "int",     stride, BitmapData,  8) ; Stride
         NumPut(   "ptr",      Scan0, BitmapData, 16) ; Scan0

      ; Use LockBits to copy pixel data from an external buffer into the internal GDI+ Bitmap.
      DllCall("gdiplus\GdipBitmapLockBits"
               ,    "ptr", pBitmap
               ,    "ptr", Rect
               ,   "uint", 6            ; ImageLockMode.UserInputBuffer | ImageLockMode.WriteOnly
               ,    "int", 0x26200A     ; Format32bppArgb (external buffer)
               ,    "ptr", BitmapData)  ; Contains the pointer to the external buffer.
      DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

      DllCall("CloseClipboard")
      return pBitmap
   }