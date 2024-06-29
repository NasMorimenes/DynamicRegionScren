EncodedBufferToBitmap(image) {
   stream := EncodedBufferToStream(image)
   DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap := 0)
   ObjRelease(stream)
   return pBitmap
}