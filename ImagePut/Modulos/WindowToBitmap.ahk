WindowToBitmap(image) {
   ; Thanks tic - https://www.autohotkey.com/boards/viewtopic.php?t=6517

   ; Get the handle to the window.
   image := WinExist(image)

   ; Test whether keystrokes can be sent to this window using a reserved virtual key code.
   try PostMessage WM_KEYDOWN := 0x100, 0x88, , , image
   catch OSError
      throw Error("Administrator privileges are required to capture the window.")
   PostMessage WM_KEYUP := 0x101, 0x88, 0xC0000000, , image

   ; Restore the window if minimized! Must be visible for capture.
   if DllCall("IsIconic", "ptr", image)
      DllCall("ShowWindow", "ptr", image, "int", 4)

   ; Get the width and height of the client window.
   try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
   DllCall("GetClientRect", "ptr", image, "ptr", Rect := Buffer(16)) ; sizeof(RECT) = 16
      , width := NumGet(Rect, 8, "int")
      , height := NumGet(Rect, 12, "int")
   try DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")

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

   ; Print the window onto the hBitmap using an undocumented flag. https://stackoverflow.com/a/40042587
   DllCall("user32\PrintWindow", "ptr", image, "ptr", hdc, "uint", 0x3) ; PW_RENDERFULLCONTENT | PW_CLIENTONLY
   ; Additional info on how this is implemented: https://www.reddit.com/r/windows/comments/8ffr56/altprintscreen/

   ; Convert the hBitmap to a Bitmap using a built in function as there is no transparency.
   DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hbm, "ptr", 0, "ptr*", &pBitmap := 0)

   ; Cleanup the hBitmap and device contexts.
   DllCall("SelectObject", "ptr", hdc, "ptr", obm)
   DllCall("DeleteObject", "ptr", hbm)
   DllCall("DeleteDC", "ptr", hdc)

   return pBitmap
}