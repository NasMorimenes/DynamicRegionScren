StreamToEncodedBuffer(stream) {
   DllCall("shlwapi\IStream_Size", "ptr", stream, "uint64*", &size := 0, "hresult")
   buf := Buffer(size)
   DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")
   DllCall("shlwapi\IStream_Read", "ptr", stream, "ptr", buf.ptr, "uint", size, "hresult")
   DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")
   return buf
}