SharedBufferToSharedBuffer(image) {
   hMap := DllCall("OpenFileMapping", "uint", 0x2, "int", 0, "str", image, "ptr")
   pMap := DllCall("MapViewOfFile", "ptr", hMap, "uint", 0x2, "uint", 0, "uint", 0, "uptr", 0, "ptr")

   width := NumGet(pMap + 0, "uint")
   height := NumGet(pMap + 4, "uint")
   size := 4 * width * height
   ptr := pMap + 8

   ; Free the pixels later.
   buf := ImagePut.BitmapBuffer(ptr, size, width, height)
   buf.free := [() => DllCall("UnmapViewOfFile", "ptr", pMap), () => DllCall("CloseHandle", "ptr", hMap)]
   buf.name := image
   return buf
}