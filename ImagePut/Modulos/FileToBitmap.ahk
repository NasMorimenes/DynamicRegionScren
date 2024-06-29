FileToBitmap(image) {
   stream := FileToStream(image) ; Faster than GdipCreateBitmapFromFile and does not lock the file.
   DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap := 0)
   ObjRelease(stream)
   return pBitmap
}