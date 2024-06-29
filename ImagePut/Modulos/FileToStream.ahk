FileToStream(image) {
   file := FileOpen(image, "r")
   file.pos := 0
   handle := DllCall("GlobalAlloc", "uint", 0x2, "uptr", file.length, "ptr")
   ptr := DllCall("GlobalLock", "ptr", handle, "ptr")
   file.RawRead(ptr, file.length)
   DllCall("GlobalUnlock", "ptr", handle)
   file.Close()
   DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", True, "ptr*", &stream := 0, "hresult")
   return stream
}