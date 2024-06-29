ClipboardPngToBitmap() {
   stream := ClipboardPngToStream()
   DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap := 0)
   ObjRelease(stream)
   return pBitmap
}