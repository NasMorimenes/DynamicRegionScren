ScreenshotToBitmap(image) {
   ; Thanks tic - https://www.autohotkey.com/boards/viewtopic.php?t=6517

   ; Allow the image to be a window handle.
   if !IsObject(image) and WinExist(image) {
      try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
      WinGetClientPos &x, &y, &w, &h, image
      try DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")
      image := [x, y, w, h]
   }


   ; Adjust coordinates relative to specified window.
   if image.Has(5) and WinExist(image[5]) {
      try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
      WinGetClientPos &xr, &yr, , , image[5]
      try DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")
      image[1] += xr
      image[2] += yr
   }


   ; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
   hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
   bi := Buffer(40, 0)                    ; sizeof(bi) = 40
   NumPut("uint", 40, bi, 0) ; Size
   NumPut("int", image[3], bi, 4) ; Width
   NumPut("int", -image[4], bi, 8) ; Height - Negative so (0, 0) is top-left.
   NumPut("ushort", 1, bi, 12) ; Planes
   NumPut("ushort", 32, bi, 14) ; BitCount / BitsPerPixel
   hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", bi, "uint", 0, "ptr*", &pBits := 0, "ptr", 0, "uint", 0, "ptr")
   obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")

   ; Retrieve the device context for the screen.
   sdc := DllCall("GetDC", "ptr", 0, "ptr")

   ; Copies a portion of the screen to a new device context.
   DllCall("gdi32\BitBlt"
      , "ptr", hdc, "int", 0, "int", 0, "int", image[3], "int", image[4]
      , "ptr", sdc, "int", image[1], "int", image[2], "uint", 0x00CC0020 | 0x40000000) ; SRCCOPY | CAPTUREBLT

   ; Release the device context to the screen.
   DllCall("ReleaseDC", "ptr", 0, "ptr", sdc)

   ; Convert the hBitmap to a Bitmap using a built in function as there is no transparency.
   DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hbm, "ptr", 0, "ptr*", &pBitmap := 0)

   ; Cleanup the hBitmap and device contexts.
   DllCall("SelectObject", "ptr", hdc, "ptr", obm)
   DllCall("DeleteObject", "ptr", hbm)
   DllCall("DeleteDC", "ptr", hdc)

   return pBitmap
}