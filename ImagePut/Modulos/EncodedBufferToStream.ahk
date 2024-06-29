EncodedBufferToStream(image) {
   handle := DllCall("GlobalAlloc", "uint", 0x2, "uptr", image.size, "ptr")
   ptr := DllCall("GlobalLock", "ptr", handle, "ptr")
   DllCall("RtlMoveMemory", "ptr", ptr, "ptr", image.ptr, "uptr", image.size)
   DllCall("GlobalUnlock", "ptr", handle)
   DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", True, "ptr*", &stream := 0, "hresult")
   return stream
}