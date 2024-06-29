BitmapToEncodedBuffer(pBitmap, extension := "", quality := "") {
   ; Defaults to PNG for small sizes!
   stream := this.BitmapToStream(pBitmap, (extension) ? extension : "png", quality)

   ; Get a pointer to the encoded image data.
   DllCall("ole32\GetHGlobalFromStream", "ptr", stream, "ptr*", &handle := 0, "hresult")
   ptr := DllCall("GlobalLock", "ptr", handle, "ptr")
   size := DllCall("GlobalSize", "ptr", handle, "uptr")

   ; Copy data into a buffer.
   buf := Buffer(size)
   DllCall("RtlMoveMemory", "ptr", buf.ptr, "ptr", ptr, "uptr", size)

   ; Release binary data and stream.
   DllCall("GlobalUnlock", "ptr", handle)
   ObjRelease(stream)

   return buf
}