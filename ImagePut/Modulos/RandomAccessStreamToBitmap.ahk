RandomAccessStreamToBitmap(image) {
   stream := RandomAccessStreamToStream(image) ; Below adds +3 to the reference count.
   DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap := 0)
   ObjRelease(stream)
   return pBitmap
}