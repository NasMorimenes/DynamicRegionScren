DesktopToBitmap() {
   ; Find the child window.
   windows := WinGetList("ahk_class WorkerW")
   if (windows.length == 0)
      throw Error("The hidden desktop window has not been initalized. Call ImagePutDesktop() first.")

   loop windows.length
      hwnd := windows[A_Index]
   until DllCall("FindWindowEx", "ptr", hwnd, "ptr", 0, "str", "SHELLDLL_DefView", "ptr", 0)

   ; Maybe this hack gets patched. Tough luck!
   if !(WorkerW := DllCall("FindWindowEx", "ptr", 0, "ptr", hwnd, "str", "WorkerW", "ptr", 0, "ptr"))
      throw Error("Could not locate hidden window behind desktop.")

   ; Get the width and height of the client window.
   try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
   DllCall("GetClientRect", "ptr", WorkerW, "ptr", Rect := Buffer(16)) ; sizeof(RECT) = 16
      , width := NumGet(Rect, 8, "int")
      , height := NumGet(Rect, 12, "int")
   try DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")

   ; Get device context of spawned window.
   sdc := DllCall("GetDCEx", "ptr", WorkerW, "ptr", 0, "int", 0x403, "ptr") ; LockWindowUpdate | Cache | Window

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

   ; Copies a portion of the hidden window to a new device context.
   DllCall("gdi32\BitBlt"
      , "ptr", hdc, "int", 0, "int", 0, "int", width, "int", height
      , "ptr", sdc, "int", 0, "int", 0, "uint", 0x00CC0020) ; SRCCOPY

   ; Convert the hBitmap to a Bitmap using a built in function as there is no transparency.
   DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hbm, "ptr", 0, "ptr*", &pBitmap := 0)

   ; Cleanup the hBitmap and device contexts.
   DllCall("SelectObject", "ptr", hdc, "ptr", obm)
   DllCall("DeleteObject", "ptr", hbm)
   DllCall("DeleteDC", "ptr", hdc)

   ; Release device context of spawned window.
   DllCall("ReleaseDC", "ptr", 0, "ptr", sdc)

   return pBitmap
}