
static BitmapToCoimage(cotype, pBitmap, p1 := "", p2 := "", p3 := "", p4 := "", p5 := "", p6 := "", p7 := "", p*) {

    if (cotype = "Clipboard") ; (pBitmap)
        return this.BitmapToClipboard(pBitmap)

    if (cotype = "Screenshot") ; (pBitmap, pos, alpha)
        return this.BitmapToScreenshot(pBitmap, p1, p2)

    if (cotype = "Window") ; (pBitmap, title, pos, style, styleEx, parent, playback, cache)
        return this.BitmapToWindow(pBitmap, p1, p2, p3, p4, p5, p6, p7)

    if (cotype = "Show") ; (pBitmap, title, pos, style, styleEx, parent, playback, cache)
        return this.Show(pBitmap, p1, p2, p3, p4, p5, p6, p7)

    if (cotype = "EncodedBuffer") ; (pBitmap, extension, quality)
        return this.BitmapToEncodedBuffer(pBitmap, p1, p2)

    if (cotype = "Buffer") ; (pBitmap)
        return this.BitmapToBuffer(pBitmap)

    if (cotype = "SharedBuffer") ; (pBitmap, name)
        return this.BitmapToSharedBuffer(pBitmap, p1)

    if (cotype = "Desktop") ; (pBitmap)
        return this.BitmapToDesktop(pBitmap)

    if (cotype = "Wallpaper") ; (pBitmap)
        return this.BitmapToWallpaper(pBitmap)

    if (cotype = "Cursor") ; (pBitmap, xHotspot, yHotspot)
        return this.BitmapToCursor(pBitmap, p1, p2)

    if (cotype = "Url") ; (pBitmap)
        return this.BitmapToUrl(pBitmap)

    if (cotype = "File") ; (pBitmap, filepath, quality)
        return this.BitmapToFile(pBitmap, p1, p2)

    if (cotype = "Hex") ; (pBitmap, extension, quality)
        return this.BitmapToHex(pBitmap, p1, p2)

    if (cotype = "Base64") ; (pBitmap, extension, quality)
        return this.BitmapToBase64(pBitmap, p1, p2)

    if (cotype = "Uri") ; (pBitmap, extension, quality)
        return this.BitmapToUri(pBitmap, p1, p2)

    if (cotype = "DC") ; (pBitmap, alpha)
        return this.BitmapToDC(pBitmap, p1)

    if (cotype = "HBitmap") ; (pBitmap, alpha)
        return this.BitmapToHBitmap(pBitmap, p1)

    if (cotype = "HIcon") ; (pBitmap)
        return this.BitmapToHIcon(pBitmap)

    if (cotype = "Bitmap")
        return pBitmap

    if (cotype = "Stream") ; (pBitmap, extension, quality)
        return this.BitmapToStream(pBitmap, p1, p2)

    if (cotype = "RandomAccessStream") ; (pBitmap, extension, quality)
        return this.BitmapToRandomAccessStream(pBitmap, p1, p2)

    if (cotype = "WicBitmap") ; (pBitmap)
        return this.BitmapToWicBitmap(pBitmap)

    if (cotype = "Explorer") ; (pBitmap, default)
        return this.BitmapToExplorer(pBitmap, p1)

    if (cotype = "SafeArray") ; (pBitmap, extension, quality)
        return this.BitmapToSafeArray(pBitmap, p1, p2)

    if (cotype = "FormData") ; (pBitmap, boundary, extension, quality)
        return this.BitmapToFormData(pBitmap, p1, p2, p3)

    throw Error("Conversion from bitmap to " cotype " is not supported.")
}

static BitmapToFormData(bitmap, boundary := "", extension := "", quality := "") {
    if (boundary = "")
        boundary := "----WebKitFormBoundary" A_TickCount A_Now

    ; Converte o bitmap em um stream
    stream := this.BitmapToStream(bitmap, extension, quality)
    return this.StreamToFormData(stream, boundary)
}

static ImageToStream(type, image, keywords := "") {

    try index := keywords.index

    if (type = "ClipboardPng")
        return this.ClipboardPngToStream()

    if (type = "SafeArray")
        return this.SafeArrayToStream(image)

    if (type = "EncodedBuffer")
        return this.EncodedBufferToStream(image)

    if (type = "Url")
        return this.UrlToStream(image)

    if (type = "File")
        return this.FileToStream(image)

    if (type = "Hex")
        return this.HexToStream(image)

    if (type = "Base64")
        return this.Base64ToStream(image)

    if (type = "Stream")
        return this.StreamToStream(image)

    if (type = "RandomAccessStream")
        return this.RandomAccessStreamToStream(image)

    throw Error("Conversion from " type " to stream is not supported.")
}

static StreamToCoimage(cotype, stream, p1 := "", p2 := "", p*) {

    if (cotype = "Clipboard") ; (stream)
        return this.StreamToClipboard(stream)

    if (cotype = "EncodedBuffer") ; (stream)
        return this.StreamToEncodedBuffer(stream)

    if (cotype = "File") ; (stream, filepath)
        return this.StreamToFile(stream, p1)

    if (cotype = "Hex") ; (stream)
        return this.StreamToHex(stream)

    if (cotype = "Base64") ; (stream)
        return this.StreamToBase64(stream)

    if (cotype = "Uri") ; (stream)
        return this.StreamToUri(stream)

    if (cotype = "Stream")
        return stream

    if (cotype = "RandomAccessStream") ; (stream)
        return this.StreamToRandomAccessStream(stream)

    if (cotype = "Explorer") ; (stream, default)
        return this.StreamToExplorer(stream, p1)

    if (cotype = "SafeArray") ; (stream)
        return this.StreamToSafeArray(stream)

    if (cotype = "FormData") ; (stream, boundary)
        return this.StreamToFormData(stream, p1)

    throw Error("Conversion from stream to " cotype " is not supported.")
}

;***********************************************************************************

; StreamToFormData converte um stream em form data para requisições HTTP POST
static StreamToFormData(stream, boundary) {
    ; Cria o boundary se não for fornecido
    if !boundary
        boundary := "----WebKitFormBoundary" A_TickCount A_Now

    formData := ""

    ; Cria a parte do cabeçalho do form data
    formData .= "--" boundary "`r`n"
    ;formData .= "Content-Disposition: form-data; name=""" stream.name """; filename=""file.bin""`r`n"
    formData .= 'Content-Disposition: form-data; name="' stream.name '"; filename=""file.bin""`r`n'

    formData .= "Content-Type: application/octet-stream`r`n`r`n"

    ; Lê do stream e adiciona ao form data
    while !stream.AtEOF {
        buffer := stream.Read(1024)  ; Ajuste o tamanho do buffer conforme necessário
        formData .= buffer
    }

    ; Cria a parte do rodapé do form data
    formData .= "`r`n--" boundary "--`r`n"

    ; Retorna o form data completo e o boundary
    return { formData: formData, boundary: boundary }
}

static BitmapToURL(pBitmap, extension := "", quality := "") {
    body := this.BitmapToSafeArray(pBitmap, extension, quality)

    req := ComObject("WinHttp.WinHttpRequest.5.1")
    req.Open("POST", "https://api.imgur.com/3/image", true)
    req.SetRequestHeader("Authorization", "Client-ID " . "fbf77" "ff49" "c42c8a")
    req.Send(body)
    req.WaitForResponse()

    url := RegExReplace(req.ResponseText, "^.*?link\x22:\x22(.*?)\x22.*$", "$1")
    return url
}

static BitmapCrop(&pBitmap, crop) {
    if not (IsObject(crop)
        && crop[1] ~= "^-?\d+(\.\d*)?%?$" && crop[2] ~= "^-?\d+(\.\d*)?%?$"
        && crop[3] ~= "^-?\d+(\.\d*)?%?$" && crop[4] ~= "^-?\d+(\.\d*)?%?$")
        throw Error("Invalid crop.")

    ; Get Bitmap width, height, and format.
    DllCall("gdiplus\GdipGetImageWidth", "ptr", pBitmap, "uint*", &width := 0)
    DllCall("gdiplus\GdipGetImageHeight", "ptr", pBitmap, "uint*", &height := 0)
    DllCall("gdiplus\GdipGetImagePixelFormat", "ptr", pBitmap, "int*", &format := 0)

    ; Abstraction Shift.
    ; Previously, real values depended on abstract values.
    ; Now, real values have been resolved, and abstract values depend on reals.

    ; Are the numbers percentages?
    (crop[1] ~= "%$") && crop[1] := SubStr(crop[1], 1, -1) * 0.01 * width
    (crop[2] ~= "%$") && crop[2] := SubStr(crop[2], 1, -1) * 0.01 * height
    (crop[3] ~= "%$") && crop[3] := SubStr(crop[3], 1, -1) * 0.01 * width
    (crop[4] ~= "%$") && crop[4] := SubStr(crop[4], 1, -1) * 0.01 * height

    ; If numbers are negative, subtract the values from the edge.
    crop[1] := Abs(crop[1])
    crop[2] := Abs(crop[2])
    crop[3] := (crop[3] < 0) ? width - Abs(crop[3]) - Abs(crop[1]) : crop[3]
        crop[4] := (crop[4] < 0) ? height - Abs(crop[4]) - Abs(crop[2]) : crop[4]

            ; Round to the nearest integer. Reminder: width and height are distances, not coordinates.
            crop[1] := Round(crop[1])
            crop[2] := Round(crop[2])
            crop[3] := Round(crop[1] + crop[3]) - Round(crop[1])
            crop[4] := Round(crop[2] + crop[4]) - Round(crop[2])

            ; Avoid cropping if no changes are detected.
            if (crop[1] = 0 && crop[2] = 0 && crop[3] == width && crop[4] == height)
                return pBitmap

            ; Minimum size is 1 x 1. Ensure that coordinates can never exceed the expected Bitmap area.
            safe_x := (crop[1] >= width)
            safe_y := (crop[2] >= height)
            safe_w := (crop[3] <= 0 || crop[1] + crop[3] > width)
            safe_h := (crop[4] <= 0 || crop[2] + crop[4] > height)

            ; Abort cropping if any of the changes would exceed a safe bound.
            if (safe_x || safe_y || safe_w || safe_h)
                return pBitmap

            ; Clone and retain a reference to the backing stream.
            DllCall("gdiplus\GdipCloneBitmapAreaI"
                , "int", crop[1]
                , "int", crop[2]
                , "int", crop[3]
                , "int", crop[4]
                , "int", format
                , "ptr", pBitmap
                , "ptr*", &pBitmapCrop := 0)

            DllCall("gdiplus\GdipDisposeImage", "ptr", pBitmap)

            return pBitmap := pBitmapCrop
}

static BitmapScale(&pBitmap, scale, direction := 0) {
    if not (IsObject(scale) && ((scale[1] ~= "^\d+$") || (scale[2] ~= "^\d+$")) || (scale ~= "^\d+(\.\d+)?$"))
       throw Error("Invalid scale.")

    ; Get Bitmap width, height, and format.
    DllCall("gdiplus\GdipGetImageWidth", "ptr", pBitmap, "uint*", &width:=0)
    DllCall("gdiplus\GdipGetImageHeight", "ptr", pBitmap, "uint*", &height:=0)
    DllCall("gdiplus\GdipGetImagePixelFormat", "ptr", pBitmap, "int*", &format:=0)

    if IsObject(scale) {
       safe_w := (scale[1] ~= "^\d+$") ? scale[1] : Round(width / height * scale[2])
       safe_h := (scale[2] ~= "^\d+$") ? scale[2] : Round(height / width * scale[1])
    } else {
       safe_w := Ceil(width * scale)
       safe_h := Ceil(height * scale)
    }

    ; Avoid drawing if no changes detected.
    if (safe_w = width && safe_h = height)
       return pBitmap

    ; Force upscaling.
    if (direction > 0 and (safe_w < width && safe_h < height))
       return pBitmap

    ; Force downscaling.
    if (direction < 0 and (safe_w > width && safe_h > height))
       return pBitmap

    ; Create a destination GDI+ Bitmap that owns its memory.
    DllCall("gdiplus\GdipCreateBitmapFromScan0"
             , "int", safe_w, "int", safe_h, "int", 0, "int", format, "ptr", 0, "ptr*", &pBitmapScale:=0)
    DllCall("gdiplus\GdipGetImageGraphicsContext", "ptr", pBitmapScale, "ptr*", &pGraphics:=0)

    ; Set settings in graphics context.
    DllCall("gdiplus\GdipSetPixelOffsetMode",    "ptr", pGraphics, "int", 2) ; Half pixel offset.
    DllCall("gdiplus\GdipSetCompositingMode",    "ptr", pGraphics, "int", 1) ; Overwrite/SourceCopy.
    DllCall("gdiplus\GdipSetInterpolationMode",  "ptr", pGraphics, "int", 7) ; HighQualityBicubic

    ; Draw Image.
    DllCall("gdiplus\GdipCreateImageAttributes", "ptr*", &ImageAttr:=0)
    DllCall("gdiplus\GdipSetImageAttributesWrapMode", "ptr", ImageAttr, "int", 3, "uint", 0, "int", 0) ; WrapModeTileFlipXY
    DllCall("gdiplus\GdipDrawImageRectRectI"
             ,    "ptr", pGraphics
             ,    "ptr", pBitmap
             ,    "int", 0, "int", 0, "int", safe_w, "int", safe_h ; destination rectangle
             ,    "int", 0, "int", 0, "int",  width, "int", height ; source rectangle
             ,    "int", 2
             ,    "ptr", ImageAttr
             ,    "ptr", 0
             ,    "ptr", 0)
    DllCall("gdiplus\GdipDisposeImageAttributes", "ptr", ImageAttr)

    ; Clean up the graphics context.
    DllCall("gdiplus\GdipDeleteGraphics", "ptr", pGraphics)
    DllCall("gdiplus\GdipDisposeImage", "ptr", pBitmap)

    return pBitmap := pBitmapScale
 }

 static BitmapSprite(&pBitmap) {
    ; Get Bitmap width and height.
    DllCall("gdiplus\GdipGetImageWidth", "ptr", pBitmap, "uint*", &width:=0)
    DllCall("gdiplus\GdipGetImageHeight", "ptr", pBitmap, "uint*", &height:=0)

    ; Create a pixel buffer.
    Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
       NumPut(  "uint",   width, Rect,  8) ; Width
       NumPut(  "uint",  height, Rect, 12) ; Height
    BitmapData := Buffer(16+2*A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
    DllCall("gdiplus\GdipBitmapLockBits"
             ,    "ptr", pBitmap
             ,    "ptr", Rect
             ,   "uint", 3            ; ImageLockMode.ReadWrite
             ,    "int", 0x26200A     ; Format32bppArgb
             ,    "ptr", BitmapData)
    Scan0 := NumGet(BitmapData, 16, "ptr")

    ; C source code - https://godbolt.org/z/nrv5Yr3Y3
    static code := 0
    if !code {
       b64 := (A_PtrSize == 4)
          ? "VYnli0UIi1UMi00QOdBzDzkIdQbHAAAAAACDwATr7V3D"
          : "SDnRcw9EOQF1BDHAiQFIg8EE6+zD"
       s64 := StrLen(RTrim(b64, "=")) * 3 // 4
       code := DllCall("GlobalAlloc", "uint", 0, "uptr", s64, "ptr")
       DllCall("crypt32\CryptStringToBinary", "str", b64, "uint", 0, "uint", 0x1, "ptr", code, "uint*", s64, "ptr", 0, "ptr", 0)
       DllCall("VirtualProtect", "ptr", code, "ptr", s64, "uint", 0x40, "uint*", 0)
    }

    ; Sample the top-left pixel and set all matching pixels to be transparent.
    DllCall(code, "ptr", Scan0, "ptr", Scan0 + 4*width*height, "uint", NumGet(Scan0, "uint"), "cdecl")

    ; Write pixels to bitmap.
    DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

    return pBitmap
 }

 
 static IsClipboard(ptr, size) {
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

 static IsImage(ptr, size) {
    ; Shortest possible image is 24 bytes.
    if (size < 24)
       return False

    size := min(size, 2048)
    length := VarSetStrCapacity(&str, 2*size + (size-1) + 1)
    DllCall("crypt32\CryptBinaryToString", "ptr", ptr, "uint", size, "uint", 0x40000004, "str", str, "uint*", &length)
    if str ~= "(?i)66 74 79 70 61 76 69 66"                                      ; "avif"
    || str ~= "(?i)^42 4d (.. ){36}00 00 .. 00 00 00"                            ; "bmp"
    || str ~= "(?i)^01 00 00 00 (.. ){36}20 45 4D 46"                            ; "emf"
    || str ~= "(?i)^47 49 46 38 (37|39) 61"                                      ; "gif"
    || str ~= "(?i)66 74 79 70 68 65 69 63"                                      ; "heic"
    || str ~= "(?i)^00 00 01 00"                                                 ; "ico"
    || str ~= "(?i)^ff d8 ff"                                                    ; "jpg"
    || str ~= "(?i)^25 50 44 46 2d"                                              ; "pdf"
    || str ~= "(?i)^89 50 4e 47 0d 0a 1a 0a"                                     ; "png"
    || str ~= "(?i)^(((?!3c|3e).. )|3c (3f|21) ((?!3c|3e).. )*3e )*+3c 73 76 67" ; "svg"
    || str ~= "(?i)^(49 49 2a 00|4d 4d 00 2a)"                                   ; "tif"
    || str ~= "(?i)^52 49 46 46 .. .. .. .. 57 45 42 50"                         ; "webp"
    || str ~= "(?i)^d7 cd c6 9a"                                                 ; "wmf"
       return True

    return False
 }

 static IsUrl(url) {
    ; Thanks dperini - https://gist.github.com/dperini/729294
    ; Also see for comparisons: https://mathiasbynens.be/demo/url-regex
    ; Modified to be compatible with AutoHotkey. \u0000 -> \x{0000}.
    ; Force the declaration of the protocol because WinHttp requires it.
    return url ~= "^(?i)"
       . "(?:(?:https?|ftp):\/\/)" ; protocol identifier (FORCE)
       . "(?:\S+(?::\S*)?@)?" ; user:pass BasicAuth (optional)
       . "(?:"
          ; IP address exclusion
          ; private & local networks
          . "(?!(?:10|127)(?:\.\d{1,3}){3})"
          . "(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})"
          . "(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})"
          ; IP address dotted notation octets
          ; excludes loopback network 0.0.0.0
          ; excludes reserved space >= 224.0.0.0
          ; excludes network & broadcast addresses
          ; (first & last IP address of each class)
          . "(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])"
          . "(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}"
          . "(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))"
       . "|"
          ; host & domain names, may end with dot
          ; can be replaced by a shortest alternative
          ; (?![-_])(?:[-\\w\\u00a1-\\uffff]{0,63}[^-_]\\.)+
          . "(?:(?:[a-z0-9\x{00a1}-\x{ffff}][a-z0-9\x{00a1}-\x{ffff}_-]{0,62})?[a-z0-9\x{00a1}-\x{ffff}]\.)+"
          ; TLD identifier name, may end with dot
          . "(?:[a-z\x{00a1}-\x{ffff}]{2,}\.?)"
       . ")"
       . "(?::\d{2,5})?" ; port number (optional)
       . "(?:[/?#]\S*)?$" ; resource path (optional)
 }

 static ClipboardToBitmap() {
    ; Open the clipboard with exponential backoff.
    loop
       if DllCall("OpenClipboard", "ptr", A_ScriptHwnd)
          break
       else
          if A_Index < 6
             Sleep (2**(A_Index-1) * 30)
          else throw Error("Clipboard could not be opened.")

    ; Check for CF_DIB to retrieve transparent pixels when possible.
    if DllCall("IsClipboardFormatAvailable", "uint", 8)
       if !(handle := DllCall("GetClipboardData", "uint", 8, "ptr"))
          throw Error("Shared clipboard data has been deleted.")

    ; Adjust Scan0 for top-down or bottom-up bitmaps.
    ptr := DllCall("GlobalLock", "ptr", handle, "ptr")
    width := NumGet(ptr + 4, "int")
    height := NumGet(ptr + 8, "int")
    bpp := NumGet(ptr + 14, "ushort")
    stride := ((height < 0) ? 1 : -1) * (width * bpp + 31) // 32 * 4
    pBits := ptr + 40
    Scan0 := (height < 0) ? pBits : pBits - stride*(height-1)

    ; Create a destination GDI+ Bitmap that owns its memory. The pixel format is 32-bit ARGB.
    DllCall("gdiplus\GdipCreateBitmapFromScan0"
             , "int", width, "int", height, "int", 0, "uint", 0x26200A, "ptr", 0, "ptr*", &pBitmap:=0)

    ; Describe the current buffer holding the pixel data.
    Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
       NumPut(  "uint",   width, Rect,  8) ; Width
       NumPut(  "uint",  height, Rect, 12) ; Height
    BitmapData := Buffer(16+2*A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
       NumPut(   "int",     stride, BitmapData,  8) ; Stride
       NumPut(   "ptr",      Scan0, BitmapData, 16) ; Scan0

    ; Use LockBits to copy pixel data from an external buffer into the internal GDI+ Bitmap.
    DllCall("gdiplus\GdipBitmapLockBits"
             ,    "ptr", pBitmap
             ,    "ptr", Rect
             ,   "uint", 6            ; ImageLockMode.UserInputBuffer | ImageLockMode.WriteOnly
             ,    "int", 0x26200A     ; Format32bppArgb (external buffer)
             ,    "ptr", BitmapData)  ; Contains the pointer to the external buffer.
    DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

    DllCall("CloseClipboard")
    return pBitmap
 }

 static ClipboardPngToBitmap() {
    stream := this.ClipboardPngToStream()
    DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap:=0)
    ObjRelease(stream)
    return pBitmap
 }
