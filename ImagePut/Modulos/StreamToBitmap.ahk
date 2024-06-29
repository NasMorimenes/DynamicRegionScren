StreamToBitmap(image) {
   stream := StreamToStream(image) ; Below adds +3 references and seeks to 4096.
   DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap := 0)
   ObjRelease(stream)
   return pBitmap
}