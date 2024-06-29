StreamToStream(image) {
   ; Creates a new, separate stream. Necessary to separate reference counting through a clone.
   ComCall(Clone := 13, image, "ptr*", &stream := 0)
   ; Ensures that a duplicated stream does not inherit the original seek position.
   DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")
   return stream
}