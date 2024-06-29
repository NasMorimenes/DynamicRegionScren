ImageType(image) {

      if not IsObject(image)
         goto string

      if image.HasProp("prototype") && image.prototype.HasProp("__class") && image.prototype.__class == "ClipboardAll"
      or type(image) == "ClipboardAll" && IsClipboard(image.ptr, image.size)
         ; A "clipboardpng" is a pointer to a PNG stream saved as the "png" clipboard format.
         if DllCall("IsClipboardFormatAvailable", "uint", DllCall("RegisterClipboardFormat", "str", "png", "uint"))
            return "ClipboardPng"

         ; A "clipboard" is a handle to a GDI bitmap saved as CF_BITMAP.
         else if DllCall("IsClipboardFormatAvailable", "uint", 2)
            return "Clipboard"

         else throw Error("Clipboard format not supported.")




      array:
      ; A "safearray" is a pointer to a SafeArray COM Object.
      if ComObjType(image) and ComObjType(image) & 0x2000
         return "SafeArray"

      ; A "screenshot" is an array of 4 numbers with an optional window.
      if image.HasProp("__Item") && image.HasProp("length") && image.length ~= "4|5"
      && image[1] ~= "^-?\d+$" && image[2] ~= "^-?\d+$" && image[3] ~= "^\d+$" && image[4] ~= "^\d+$"
      && (image.Has(5) ? WinExist(image[5]) : True)
         return "Screenshot"

      object:
      ; A "window" is an object with an hwnd property.
      if image.HasProp("hwnd")
         return "Window"

      ; A "object" has a pBitmap property that points to an internal GDI+ bitmap.
      if image.HasProp("pBitmap")
         try if !DllCall("gdiplus\GdipGetImageType", "ptr", image.pBitmap, "ptr*", &_type:=0) && (_type == 1)
            return "Object"

      if not image.HasProp("ptr")
         goto end

      ; Check if image is a pointer. If not, crash and do not recover.
      ("POINTER IS BAD AND PROGRAM IS CRASH") && NumGet(image.ptr, "char")

      ; An "encodedbuffer" contains a pointer to the bytes of an encoded image format.
      if image.HasProp("ptr") && image.HasProp("size") && IsImage(image.ptr, image.size)
         return "EncodedBuffer"

      ; A "buffer" is an object with a pointer to bytes and properties to determine its 2-D shape.
      if image.HasProp("ptr")
         and ( image.HasProp("width") && image.HasProp("height")
            or image.HasProp("stride") && image.HasProp("height")
            or image.HasProp("size") && (image.HasProp("stride") || image.HasProp("width") || image.HasProp("height")))
         return "Buffer"

      image := image.ptr
      goto pointer

      string:
      if (image == "")
         throw Error("Image data is an empty string.")

      ; A non-zero "monitor" number identifies each display uniquely; and 0 refers to the entire virtual screen.
      if (image ~= "^\d+$" && image >= 0 && image <= MonitorGetCount())
         return "Monitor"

      ; A "desktop" is a hidden window behind the desktop icons created by ImagePutDesktop.
      if (image = "desktop")
         return "Desktop"

      ; A "wallpaper" is the desktop wallpaper.
      if (image = "wallpaper")
         return "Wallpaper"

      ; A "cursor" is the name of a known cursor name.
      if (image ~= "(?i)^A_Cursor|Unknown|(IDC_)?(AppStarting|Arrow|Cross|Hand(writing)?|"
      . "Help|IBeam|No|Pin|Person|SizeAll|SizeNESW|SizeNS|SizeNWSE|SizeWE|UpArrow|Wait)$")
         return "Cursor"

      ; A "url" satisfies the url format.
      if IsUrl(image)
         return "Url"

      ; A "file" is stored on the disk or network.
      if FileExist(image)
         return "File"

      ; A "window" is anything considered a Window Title including ahk_class and "A".
      if WinExist(image)
         return "Window"

      ; A "sharedbuffer" is a file mapping kernel object.
      if DllCall("CloseHandle", "ptr", DllCall("OpenFileMapping", "uint", 2, "int", 0, "str", image, "ptr"))
         return "SharedBuffer"

      ; A "hex" string is binary image data encoded into text using hexadecimal.
      if (StrLen(image) >= 48) && (image ~= "^\s*(?:[A-Fa-f0-9]{2})*+\s*$")
         return "Hex"

      ; A "base64" string is binary image data encoded into text using standard 64 characters.
      if (StrLen(image) >= 32) && (image ~= "^\s*(?:data:image\/[a-z]+;base64,)?"
      . "(?:[A-Za-z0-9+\/]{4})*+(?:[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{2}==)?\s*$")
         return "Base64"

      ; For more helpful error messages: Catch file names without extensions!
      if not (image ~= "^-?\d+$") {
         for extension in ["bmp","dib","rle","jpg","jpeg","jpe","jfif","gif","tif","tiff","png","ico","exe","dll"]
            if FileExist(image "." extension)
               throw Error("A ." extension " file extension is required!", -3)

         goto end
      }

      handle:
      ; A "dc" is a handle to a GDI device context.
      if (DllCall("GetObjectType", "ptr", image, "uint") == 3 || DllCall("GetObjectType", "ptr", image, "uint") == 10)
         return "DC"

      ; An "hBitmap" is a handle to a GDI Bitmap.
      if (DllCall("GetObjectType", "ptr", image, "uint") == 7)
         return "HBitmap"

      ; An "hIcon" is a handle to a GDI icon.
      if DllCall("DestroyIcon", "ptr", DllCall("CopyIcon", "ptr", image, "ptr"))
         return "HIcon"

      ; Check if image is a pointer. If not, crash and do not recover.
      ("POINTER IS BAD AND PROGRAM IS CRASH") && NumGet(image, "char")

      ; A "bitmap" is a pointer to a GDI+ Bitmap. GdiplusStartup exception is caught above.
      try if !DllCall("gdiplus\GdipGetImageType", "ptr", image, "ptr*", &_type:=0) && (_type == 1)
         return "Bitmap"

      ; Note 1: All GDI+ functions add 1 to the reference count of COM objects on 64-bit systems.
      ; Note 2: GDI+ pBitmaps that are queried cease to stay pBitmaps.
      ; Note 3: Critical error for ranges 0-4095 on v1 and 0-65535 on v2.
      (A_PtrSize == 8) && ObjRelease(image) ; Therefore do not move this, it has been tested.

      pointer:
      ; A "stream" is a pointer to the IStream interface.
      try if ComObjQuery(image, "{0000000C-0000-0000-C000-000000000046}")
         return "Stream"

      ; A "randomaccessstream" is a pointer to the IRandomAccessStream interface.
      try if ComObjQuery(image, "{905A0FE1-BC53-11DF-8C49-001E4FC686DA}")
         return "RandomAccessStream"

      ; A "wicbitmap" is a pointer to a IWICBitmapSource.
      try if ComObjQuery(image, "{00000120-A8F2-4877-BA0A-FD2B6645FB94}")
         return "WicBitmap"

      ; A "d2dbitmap" is a pointer to a ID2D1Bitmap.
      try if ComObjQuery(image, "{A2296057-EA42-4099-983B-539FB6505426}")
         return "D2dBitmap"

      end:
      throw Error("Image type could not be identified.")
   }