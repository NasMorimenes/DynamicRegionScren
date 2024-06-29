HexToStream(image) {
   ; Trim whitespace and remove hexadecimal indicator.
   image := Trim(image)
   image := RegExReplace(image, "^(0[xX])")

   ; Retrieve the size of bytes from the length of the hex string.
   size := StrLen(image) / 2
   handle := DllCall("GlobalAlloc", "uint", 0x2, "uptr", size, "ptr")
   bin := DllCall("GlobalLock", "ptr", handle, "ptr")

   ; Place the decoded hex string into a binary buffer.
   flags := 0xC ; CRYPT_STRING_HEXRAW
   DllCall("crypt32\CryptStringToBinary", "str", image, "uint", 0, "uint", flags, "ptr", bin, "uint*", size, "ptr", 0, "ptr", 0)

   ; Returns a stream that release the handle on ObjRelease().
   DllCall("GlobalUnlock", "ptr", handle)
   DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", True, "ptr*", &stream := 0, "hresult")
   return stream
}