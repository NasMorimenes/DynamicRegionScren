IsClipboard(ptr, size) {
   ; When the clipboard is empty, both the pointer and size are zero.
   if (ptr == 0 && size == 0)
      return True

   ; Look for a RIFF-like structure.
   pos := 0
   while (pos < size)
      if (offset := NumGet(ptr + pos + 4, "uint"))
         pos += offset + 8
      else break
   return pos + 4 == size && !NumGet(ptr + pos, "uint") ; 4 byte null terminator
}