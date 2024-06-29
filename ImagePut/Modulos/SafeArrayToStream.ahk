SafeArrayToStream(image) {
   ; Expects a 1-D safe array of bytes. (VT_UI1)
   size := image.MaxIndex()
   pvData := NumGet(ComObjValue(image), 8 + A_PtrSize, "ptr")

   ; Copy data to a new stream.
   handle := DllCall("GlobalAlloc", "uint", 0x2, "uptr", size, "ptr")
   ptr := DllCall("GlobalLock", "ptr", handle, "ptr")
   DllCall("RtlMoveMemory", "ptr", ptr, "ptr", pvData, "uptr", size)
   DllCall("GlobalUnlock", "ptr", handle)
   DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", True, "ptr*", &stream := 0, "hresult")
   return stream
}