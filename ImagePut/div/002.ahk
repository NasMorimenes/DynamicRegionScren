class ImagePut {

    static decode := False    ; Decompresses image to a pixel buffer. Any encoding such as JPG will be lost.
    static render := True     ; Determines whether vectorized formats such as SVG and PDF are rendered to pixels.
    static validate := False  ; Always copies pixels to new memory immediately instead of copy-on-read/write.

    static call(cotype, image, p*) {

        ; Start!
        this.gdiplusStartup()

        ; Take a guess as to what the image might be. (>95% accuracy!)
        try type := this.DontVerifyImageType(&image, &keywords)
        catch
            type := this.ImageType(image)

        ; Extract options to be directly applied the intermediate representation here.
        crop := keywords.HasProp("crop") ? keywords.crop : ""
        scale := keywords.HasProp("scale") ? keywords.scale : ""
        upscale := keywords.HasProp("upscale") ? keywords.upscale : ""
        downscale := keywords.HasProp("downscale") ? keywords.downscale : ""
        sprite := keywords.HasProp("sprite") ? keywords.sprite : ""
        decode := keywords.HasProp("decode") ? keywords.decode : this.decode
        render := keywords.HasProp("render") ? keywords.render : this.render
        validate := keywords.HasProp("validate") ? keywords.validate : this.validate

        ; Keywords are for (image -> intermediate).
        try index := keywords.index

        cleanup := ""

        ; #1 - Stream as the intermediate representation.
        try stream := this.ImageToStream(type, image, keywords)
        catch Error as e
            if (e.Message ~= "^Conversion from")
                goto make_bitmap
            else throw
        if not stream
            throw Error("Stream cannot be zero.")

        ; Check the file signature for magic numbers.
stream:
        DllCall("shlwapi\IStream_Size", "ptr", stream, "uint64*", &size := 0, "hresult")
        DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")

        ; 2048 characters should be good enough to identify the file correctly.
        size := min(size, 2048)
        bin := Buffer(size)
        (ComCall(Seek := 5, stream, "uint64", 0, "uint", 1, "uint64*", &current := 0), current != 0 && MsgBox(current))
        ; Get the first few bytes of the image.
        DllCall("shlwapi\IStream_Read", "ptr", stream, "ptr", bin, "uint", size, "hresult")
        DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")

        ; Allocate enough space for a hexadecimal string with spaces interleaved and a null terminator.
        length := 2 * size + (size - 1) + 1
        VarSetStrCapacity(&str, length)

        ; Lift the binary representation to hex.
        flags := 0x40000004 ; CRYPT_STRING_NOCRLF | CRYPT_STRING_HEX
        DllCall("crypt32\CryptBinaryToString", "ptr", bin, "uint", size, "uint", flags, "str", str, "uint*", &length)

        ; Determine the extension using herustics. See: http://fileformats.archiveteam.org
        extension := 0 ? ""
            : str ~= "(?i)66 74 79 70 61 76 69 66" ? "avif" ; ftypavif
                : str ~= "(?i)^42 4d (.. ){36}00 00 .. 00 00 00" ? "bmp"  ; BM
                    : str ~= "(?i)^01 00 00 00 (.. ){36}20 45 4D 46" ? "emf"  ; emf
                        : str ~= "(?i)^47 49 46 38 (37|39) 61" ? "gif"  ; GIF87a or GIF89a
                            : str ~= "(?i)66 74 79 70 68 65 69 63" ? "heic" ; ftypheic
                                : str ~= "(?i)^00 00 01 00" ? "ico"
                                    : str ~= "(?i)^ff d8 ff" ? "jpg"
                                        : str ~= "(?i)^25 50 44 46 2d" ? "pdf"  ; %PDF-
                                            : str ~= "(?i)^89 50 4e 47 0d 0a 1a 0a" ? "png"  ; PNG
                                                : str ~= "(?i)^(((?!3c|3e).. )|3c (3f|21) ((?!3c|3e).. )*3e )*+3c 73 76 67" ? "svg"  ; <svg
                                                    : str ~= "(?i)^(49 49 2a 00|4d 4d 00 2a)" ? "tif"  ; II* or MM*
                                                        : str ~= "(?i)^52 49 46 46 .. .. .. .. 57 45 42 50" ? "webp" ; RIFF....WEBP
                                                            : str ~= "(?i)^d7 cd c6 9a" ? "wmf"
                                                                : "" ; Extension must be blank for file pass-through as-is.

        ; Convert vectorized formats to rasterized formats.
        if (render && extension ~= "^(?i:pdf|svg)$") {
            (extension = "pdf") && this.RenderPdf(&stream, index?)
            (extension = "svg") && pBitmap := this.RenderSvg(&stream, 800, 800)
            goto(IsSet(pBitmap) ? "bitmap" : "stream")
        }

        ; Determine whether the stream should be decoded into pixels.
        weight := decode || crop || scale || upscale || downscale || sprite ||
            ; Check if the 1st parameter matches the extension.
            !(cotype ~= "^(?i:encodedbuffer|url|hex|base64|uri|stream|randomaccessstream|safearray)$"
                && (!p.Has(1) || p[1] == "" || p[1] = extension)
                ; Check if the 2nd parameter matches the extension.
                || cotype = "formdata"
                && (!p.Has(2) || p[2] == "" || p[2] = extension)
                ; For files, if the desired extension is not supported, it is ignored.
                || cotype = "file"
                && (!p.Has(1) || p[1] == "" || p[1] ~= "(^|:|\\|\.)" extension "$"
                    || !(RegExReplace(p[1], "^.*(?:^|:|\\|\.)(.*)$", "$1")
                        ~= "^(?i:avif|avifs|bmp|dib|rle|gif|heic|heif|hif|jpg|jpeg|jpe|jfif|png|tif|tiff)$"))
                ; Pass through all other cotypes.
                || cotype)

        ; MsgBox weight ? "convert to pixels" : "stay as stream"

        if weight
            goto clean_stream

        ; Attempt conversion using StreamToCoimage.
        try coimage := this.StreamToCoimage(cotype, stream, p*)
        catch Error as e
            if (e.Message ~= "^Conversion from")
                goto clean_stream
            else throw

        ; Clean up the copy. Export raw pointers if requested.
        if (cotype != "stream")
            ObjRelease(stream)

        goto exit

        ; Otherwise export the image as a stream.
clean_stream:
        type := "stream"
        image := stream
        cleanup := "stream"

        ; #2 - Fallback to GDI+ bitmap as the intermediate.
make_bitmap:
        if !(pBitmap := this.ImageToBitmap(type, image, keywords))
            throw Error("pBitmap cannot be zero.")

        ; GdipImageForceValidation must be called immediately or it fails silently.
bitmap:
        (validate) && DllCall("gdiplus\GdipImageForceValidation", "ptr", pBitmap)
        (crop) && this.BitmapCrop(&pBitmap, crop)
        (scale) && this.BitmapScale(&pBitmap, scale)
        (upscale) && this.BitmapScale(&pBitmap, upscale, 1)
        (downscale) && this.BitmapScale(&pBitmap, downscale, -1)
        (sprite) && this.BitmapSprite(&pBitmap)

        ; Save frame delays and loop count for webp.
        if (type = "stream" && extension = "webp" && cotype ~= "^(?i:show|window)$") {
            this.ParseWebp(stream, &pDelays, &pCount)
            DllCall("gdiplus\GdipSetPropertyItem", "ptr", pBitmap, "ptr", pDelays)
            DllCall("gdiplus\GdipSetPropertyItem", "ptr", pBitmap, "ptr", pCount)
        }

        ; Attempt conversion using BitmapToCoimage.
        coimage := this.BitmapToCoimage(cotype, pBitmap, p*)

        ; Clean up the copy. Export raw pointers if requested.
        if (cotype != "bitmap")
            DllCall("gdiplus\GdipDisposeImage", "ptr", pBitmap)

        if (cleanup = "stream")
            ObjRelease(stream)

exit:
        ; Check for dangling pointers.
        this.gdiplusShutdown(cotype)

        return coimage
    }

    static Inputs :=
        [
            "ClipboardPng",
            "Clipboard",
            "SafeArray",
            "Screenshot",
            "Window",
            "Object",
            "EncodedBuffer",
            "Buffer",
            "Monitor",
            "Desktop",
            "Wallpaper",
            "Cursor",
            "Url",
            "File",
            "SharedBuffer",
            "Hex",
            "Base64",
            "DC",
            "HBitmap",
            "HIcon",
            "Bitmap",
            "Stream",
            "RandomAccessStream",
            "WicBitmap",
            "D2dBitmap"
        ]

    static DontVerifyImageType(&image, &keywords := "") {

        ; Sentinel value.
        keywords := {}

        ; Try ImageType.
        if !IsObject(image)
            throw Error("Must be an object.")

        ; Goto ImageType.
        if image.HasProp("image") {
            keywords := image
            image := image.image
            throw Error("Must catch this error with ImageType.")
        }

        ; Skip ImageType.
        for type in this.inputs
            if image.HasProp(type) {
                keywords := image
                image := image.%type%
                return type
            }

        ; Continue ImageType.
        throw Error("Invalid type.")
    }

    static ImageType(image) {

        if not IsObject(image)
            goto string

        if image.HasProp("prototype") && image.prototype.HasProp("__class") && image.prototype.__class == "ClipboardAll"
            or type(image) == "ClipboardAll" && this.IsClipboard(image.ptr, image.size)
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
            try if !DllCall("gdiplus\GdipGetImageType", "ptr", image.pBitmap, "ptr*", &_type := 0) && (_type == 1)
                return "Object"

        if not image.HasProp("ptr")
            goto end

        ; Check if image is a pointer. If not, crash and do not recover.
        ("POINTER IS BAD AND PROGRAM IS CRASH") && NumGet(image.ptr, "char")

        ; An "encodedbuffer" contains a pointer to the bytes of an encoded image format.
        if image.HasProp("ptr") && image.HasProp("size") && this.IsImage(image.ptr, image.size)
            return "EncodedBuffer"

        ; A "buffer" is an object with a pointer to bytes and properties to determine its 2-D shape.
        if image.HasProp("ptr")
            and (image.HasProp("width") && image.HasProp("height")
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
        if this.IsUrl(image)
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
            for extension in ["bmp", "dib", "rle", "jpg", "jpeg", "jpe", "jfif", "gif", "tif", "tiff", "png", "ico", "exe", "dll"]
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
        try if !DllCall("gdiplus\GdipGetImageType", "ptr", image, "ptr*", &_type := 0) && (_type == 1)
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

    static ImageToBitmap(type, image, keywords := "") {

        try index := keywords.index

        if (type = "ClipboardPng")
            return this.ClipboardPngToBitmap()

        if (type = "Clipboard")
            return this.ClipboardToBitmap()

        if (type = "SafeArray")
            return this.SafeArrayToBitmap(image)

        if (type = "Screenshot")
            return this.ScreenshotToBitmap(image)

        if (type = "Window")
            return this.WindowToBitmap(image)

        if (type = "Object")
            return this.BitmapToBitmap(image.pBitmap)

        if (type = "EncodedBuffer")
            return this.EncodedBufferToBitmap(image)

        if (type = "Buffer")
            return this.BufferToBitmap(image)

        if (type = "SharedBuffer")
            return this.SharedBufferToBitmap(image)

        if (type = "Monitor")
            return this.MonitorToBitmap(image)

        if (type = "Desktop")
            return this.DesktopToBitmap()

        if (type = "Wallpaper")
            return this.WallpaperToBitmap()

        if (type = "Cursor")
            return this.CursorToBitmap()

        if (type = "Url")
            return this.UrlToBitmap(image)

        if (type = "File")
            return this.FileToBitmap(image)

        if (type = "Hex")
            return this.HexToBitmap(image)

        if (type = "Base64")
            return this.Base64ToBitmap(image)

        if (type = "DC")
            return this.DCToBitmap(image)

        if (type = "HBitmap")
            return this.HBitmapToBitmap(image)

        if (type = "HIcon")
            return this.HIconToBitmap(image)

        if (type = "Bitmap")
            return this.BitmapToBitmap(image)

        if (type = "Stream")
            return this.StreamToBitmap(image)

        if (type = "RandomAccessStream")
            return this.RandomAccessStreamToBitmap(image)

        if (type = "WicBitmap")
            return this.WicBitmapToBitmap(image)

        if (type = "D2dBitmap")
            return this.D2dBitmapToBitmap(image)

        throw Error("Conversion from " type " to bitmap is not supported.")
    }

    static D2dBitmapToBitmap(d2dBitmap) {
        ; Implementação para converter um D2dBitmap em um bitmap
        ; Esta é uma implementação de exemplo e deve ser ajustada conforme necessário

        ; Obtém o HDC do bitmap D2D
        hdc := DllCall("GetDC", "ptr", d2dBitmap, "ptr")

        ; Obtém as dimensões do bitmap D2D
        width := DllCall("GetBitmapWidth", "ptr", d2dBitmap, "int")
        height := DllCall("GetBitmapHeight", "ptr", d2dBitmap, "int")
        ; Cria um bitmap a partir de D2dBitmap
        bitmap := DllCall("CreateCompatibleBitmap", "ptr", hdc, "int", width, "int", height, "ptr")

        ; Seleciona o bitmap para um DC de memória
        memDC := DllCall("CreateCompatibleDC", "ptr", hdc, "ptr")
        oldBmp := DllCall("SelectObject", "ptr", memDC, "ptr", bitmap, "ptr")

        ; Copia o conteúdo do D2dBitmap para o bitmap
        DllCall("BitBlt", "ptr", memDC, "int", 0, "int", 0, "int", width, "int", height, "ptr", d2dBitmap, "int", 0, "int", 0, "uint", 0x00CC0020)

        ; Restaura o antigo bitmap
        DllCall("SelectObject", "ptr", memDC, "ptr", oldBmp)
        DllCall("DeleteDC", "ptr", memDC)

        return bitmap
    }

