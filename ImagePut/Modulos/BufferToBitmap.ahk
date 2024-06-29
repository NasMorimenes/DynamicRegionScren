BufferToBitmap(image) {

   if image.HasProp("pitch")
      stride := image.pitch
   else if image.HasProp("stride")
      stride := image.stride
   else if image.HasProp("width")
      stride := image.width * 4
   else if image.HasProp("height") && image.HasProp("size")
      stride := image.size // image.height
   else throw Error("Image buffer is missing a stride or pitch property.")

   if image.HasProp("height")
      height := image.height
   else if stride && image.HasProp("size")
      height := image.size // stride
   else if image.HasProp("width") && image.HasProp("size")
      height := image.size // (4 * image.width)
   else throw Error("Image buffer is missing a height property.")

   if image.HasProp("width")
      width := image.width
   else if stride
      width := stride // 4
   else if height && image.HasProp("size")
      width := image.size // (4 * height)
   else throw Error("Image buffer is missing a width property.")

   ; Could assert a few assumptions, such as stride * height = size.
   ; However, I'd like for the pointer and its size to be as flexable as possible.
   ; User is responsible for underflow.

   ; Check for buffer overflow errors.
   if image.HasProp("size") && (abs(stride * height) > image.size)
      throw Error("Image dimensions exceed the size of the buffer.")

   ; Create a source GDI+ Bitmap that owns its memory. The pixel format is 32-bit ARGB.
   if (height > 0) ; top-down bitmap
      DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", width, "int", height
         , "int", stride, "int", 0x26200A, "ptr", image.ptr, "ptr*", &pBitmap := 0)
   else            ; bottom-up bitmap
      DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", width, "int", height
         , "int", -stride, "int", 0x26200A, "ptr", image.ptr + (height - 1) * stride, "ptr*", &pBitmap := 0)

   return pBitmap
}