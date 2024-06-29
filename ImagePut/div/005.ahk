
static WallpaperToBitmap() {
    ; Get the width and height of all monitors.
    try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    width  := DllCall("GetSystemMetrics", "int", 78, "int")
    height := DllCall("GetSystemMetrics", "int", 79, "int")
    try DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")

    ; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
    hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
    bi := Buffer(40, 0)                    ; sizeof(bi) = 40
       NumPut(  "uint",        40, bi,  0) ; Size
       NumPut(   "int",     width, bi,  4) ; Width
       NumPut(   "int",   -height, bi,  8) ; Height - Negative so (0, 0) is top-left.
       NumPut("ushort",         1, bi, 12) ; Planes
       NumPut("ushort",        32, bi, 14) ; BitCount / BitsPerPixel
    hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", bi, "uint", 0, "ptr*", &pBits:=0, "ptr", 0, "uint", 0, "ptr")
    obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")

    ; Paints the wallpaper.
    DllCall("user32\PaintDesktop", "ptr", hdc)

    ; Convert the hBitmap to a Bitmap using a built in function as there is no transparency.
    DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hbm, "ptr", 0, "ptr*", &pBitmap:=0)

    ; Cleanup the hBitmap and device contexts.
    DllCall("SelectObject", "ptr", hdc, "ptr", obm)
    DllCall("DeleteObject", "ptr", hbm)
    DllCall("DeleteDC",     "ptr", hdc)

    return pBitmap
 }

 static CursorToBitmap() {
    ; Thanks 23W - https://stackoverflow.com/a/13295280

    ; struct CURSORINFO - https://docs.microsoft.com/en-us/windows/win32/api/winuser/ns-winuser-cursorinfo
    ci := Buffer(16+A_PtrSize, 0) ; sizeof(CURSORINFO) = 20, 24
       NumPut("int", ci.size, ci)
    DllCall("GetCursorInfo", "ptr", ci)
       ; cShow   := NumGet(ci,  4, "int") ; 0x1 = CURSOR_SHOWING, 0x2 = CURSOR_SUPPRESSED
       , hCursor := NumGet(ci,  8, "ptr")
       ; xCursor := NumGet(ci,  8+A_PtrSize, "int")
       ; yCursor := NumGet(ci, 12+A_PtrSize, "int")

    ; Cursors are the same as icons!
    pBitmap := this.HIconToBitmap(hCursor)

    ; Cleanup the handle to the cursor. Same as DestroyIcon.
    DllCall("DestroyCursor", "ptr", hCursor)

    return pBitmap
 }

 static UrlToBitmap(image) {
    stream := this.UrlToStream(image)
    DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap:=0)
    ObjRelease(stream)
    return pBitmap
 }

 static UrlToStream(image) {
    req := ComObject("WinHttp.WinHttpRequest.5.1")
    req.Open("GET", image, True)
    req.Send()
    req.WaitForResponse()
    IStream := ComObjQuery(req.ResponseStream, "{0000000C-0000-0000-C000-000000000046}"), ObjAddRef(IStream.ptr)
    return IStream.ptr
 }

 static FileToBitmap(image) {
    stream := this.FileToStream(image) ; Faster than GdipCreateBitmapFromFile and does not lock the file.
    DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap:=0)
    ObjRelease(stream)
    return pBitmap
 }

 static FileToStream(image) {
    file := FileOpen(image, "r")
    file.pos := 0
    handle := DllCall("GlobalAlloc", "uint", 0x2, "uptr", file.length, "ptr")
    ptr := DllCall("GlobalLock", "ptr", handle, "ptr")
    file.RawRead(ptr, file.length)
    DllCall("GlobalUnlock", "ptr", handle)
    file.Close()
    DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", True, "ptr*", &stream:=0, "hresult")
    return stream
 }

 static HexToBitmap(image) {
    stream := this.HexToStream(image)
    DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap:=0)
    ObjRelease(stream)
    return pBitmap
 }

 static HexToStream(image) {
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
    DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", True, "ptr*", &stream:=0, "hresult")
    return stream
 }

 static Base64ToBitmap(image) {
    stream := this.Base64ToStream(image)
    DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap:=0)
    ObjRelease(stream)
    return pBitmap
 }

static Base64ToStream(image) {
    ; Trim whitespace and remove mime type.
    image := Trim(image)
    image := RegExReplace(image, "(?i)^data:image\/[a-z]+;base64,")

    ; Retrieve the size of bytes from the length of the base64 string.
    size := StrLen(RTrim(image, "=")) * 3 // 4
    handle := DllCall("GlobalAlloc", "uint", 0x2, "uptr", size, "ptr")
    bin := DllCall("GlobalLock", "ptr", handle, "ptr")

    ; Place the decoded base64 string into a binary buffer.
    flags := 0x1 ; CRYPT_STRING_BASE64
    DllCall("crypt32\CryptStringToBinary", "str", image, "uint", 0, "uint", flags, "ptr", bin, "uint*", size, "ptr", 0, "ptr", 0)

    ; Returns a stream that release the handle on ObjRelease().
    DllCall("GlobalUnlock", "ptr", handle)
    DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", True, "ptr*", &stream:=0, "hresult")
    return stream
 }

 static MonitorToBitmap(image) {
    try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if (image > 0) {
       MonitorGet(image, &Left, &Top, &Right, &Bottom)
       x := Left
       y := Top
       w := Right - Left
       h := Bottom - Top
    } else {
       x := DllCall("GetSystemMetrics", "int", 76, "int")
       y := DllCall("GetSystemMetrics", "int", 77, "int")
       w := DllCall("GetSystemMetrics", "int", 78, "int")
       h := DllCall("GetSystemMetrics", "int", 79, "int")
    }
    try DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")
    return this.ScreenshotToBitmap([x,y,w,h])
 }

 static DCToBitmap(image) {
    ; An application cannot select a single bitmap into more than one DC at a time.
    if !(sbm := DllCall("GetCurrentObject", "ptr", image, "uint", 7))
       throw Error("The device context has no bitmap selected.")

    ; struct DIBSECTION - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-dibsection
    ; struct BITMAP - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmap
    dib := Buffer(64+5*A_PtrSize) ; sizeof(DIBSECTION) = 84, 104
    DllCall("GetObject", "ptr", sbm, "int", dib.size, "ptr", dib)
       , width  := NumGet(dib, 4, "uint")
       , height := NumGet(dib, 8, "uint")
       , bpp    := NumGet(dib, 18, "ushort")
       , pBits  := NumGet(dib, A_PtrSize = 4 ? 20:24, "ptr")

    ; Fallback to built-in method if pixels are not 32-bit ARGB or hBitmap is a device dependent bitmap.
    if (pBits = 0 || bpp != 32) { ; This built-in version is 120% faster but ignores transparency.
       DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", sbm, "ptr", 0, "ptr*", &pBitmap:=0)
       return pBitmap
    }

    ; Create a device independent bitmap with negative height. All DIBs use the screen pixel format (pARGB).
    ; Use hbm to buffer the image such that top-down and bottom-up images are mapped to this top-down buffer.
    ; pBits is the pointer to (top-down) pixel values. The Scan0 will point to the pBits.
    ; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
    hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
    bi := Buffer(40, 0)                    ; sizeof(bi) = 40
       NumPut(  "uint",        40, bi,  0) ; Size
       NumPut(   "int",     width, bi,  4) ; Width
       NumPut(   "int",   -height, bi,  8) ; Height - Negative so (0, 0) is top-left.
       NumPut("ushort",         1, bi, 12) ; Planes
       NumPut("ushort",        32, bi, 14) ; BitCount / BitsPerPixel
    hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", bi, "uint", 0, "ptr*", &pBits:=0, "ptr", 0, "uint", 0, "ptr")
    obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")

    ; Create a destination GDI+ Bitmap that owns its memory to receive the final converted pixels. The pixel format is 32-bit ARGB.
    DllCall("gdiplus\GdipCreateBitmapFromScan0"
             , "int", width, "int", height, "int", 0, "int", 0x26200A, "ptr", 0, "ptr*", &pBitmap:=0)

    ; Create a Scan0 buffer pointing to pBits. The buffer has pixel format pARGB.
    Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
       NumPut(  "uint",   width, Rect,  8) ; Width
       NumPut(  "uint",  height, Rect, 12) ; Height
    BitmapData := Buffer(16+2*A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
       NumPut(   "int",  4 * width, BitmapData,  8) ; Stride
       NumPut(   "ptr",      pBits, BitmapData, 16) ; Scan0

    ; Use LockBits to create a writable buffer that converts pARGB to ARGB.
    DllCall("gdiplus\GdipBitmapLockBits"
             ,    "ptr", pBitmap
             ,    "ptr", Rect
             ,   "uint", 6            ; ImageLockMode.UserInputBuffer | ImageLockMode.WriteOnly
             ,    "int", 0xE200B      ; Format32bppPArgb
             ,    "ptr", BitmapData)  ; Contains the pointer (pBits) to the hbm.

    ; Copies the image (hBitmap) to a top-down bitmap. Removes bottom-up-ness if present.
    DllCall("gdi32\BitBlt"
             , "ptr", hdc, "int", 0, "int", 0, "int", width, "int", height
             , "ptr", image, "int", 0, "int", 0, "uint", 0x00CC0020) ; SRCCOPY

    ; Convert the pARGB pixels copied into the device independent bitmap (hbm) to ARGB.
    DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

    ; Cleanup the hBitmap and device contexts.
    DllCall("SelectObject", "ptr", hdc, "ptr", obm)
    DllCall("DeleteObject", "ptr", hbm)
    DllCall("DeleteDC",     "ptr", hdc)

    return pBitmap
 }

 static HBitmapToBitmap(image) {
    ; struct DIBSECTION - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-dibsection
    ; struct BITMAP - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmap
    dib := Buffer(64+5*A_PtrSize) ; sizeof(DIBSECTION) = 84, 104
    DllCall("GetObject", "ptr", image, "int", dib.size, "ptr", dib)
       , width  := NumGet(dib, 4, "uint")
       , height := NumGet(dib, 8, "uint")
       , bpp    := NumGet(dib, 18, "ushort")
       , pBits  := NumGet(dib, A_PtrSize = 4 ? 20:24, "ptr")

    ; Fallback to built-in method if pixels are not 32-bit ARGB or hBitmap is a device dependent bitmap.
    if (pBits = 0 || bpp != 32) { ; This built-in version is 120% faster but ignores transparency.
       DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", image, "ptr", 0, "ptr*", &pBitmap:=0)
       return pBitmap
    }

    ; Create a device independent bitmap with negative height. All DIBs use the screen pixel format (pARGB).
    ; Use hbm to buffer the image such that top-down and bottom-up images are mapped to this top-down buffer.
    ; pBits is the pointer to (top-down) pixel values. The Scan0 will point to the pBits.
    ; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
    hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
    bi := Buffer(40, 0)                    ; sizeof(bi) = 40
       NumPut(  "uint",        40, bi,  0) ; Size
       NumPut(   "int",     width, bi,  4) ; Width
       NumPut(   "int",   -height, bi,  8) ; Height - Negative so (0, 0) is top-left.
       NumPut("ushort",         1, bi, 12) ; Planes
       NumPut("ushort",        32, bi, 14) ; BitCount / BitsPerPixel
    hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", bi, "uint", 0, "ptr*", &pBits:=0, "ptr", 0, "uint", 0, "ptr")
    obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")

    ; Create a destination GDI+ Bitmap that owns its memory to receive the final converted pixels. The pixel format is 32-bit ARGB.
    DllCall("gdiplus\GdipCreateBitmapFromScan0"
             , "int", width, "int", height, "int", 0, "int", 0x26200A, "ptr", 0, "ptr*", &pBitmap:=0)

    ; Create a Scan0 buffer pointing to pBits. The buffer has pixel format pARGB.
    Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
       NumPut(  "uint",   width, Rect,  8) ; Width
       NumPut(  "uint",  height, Rect, 12) ; Height
    BitmapData := Buffer(16+2*A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
       NumPut(   "int",  4 * width, BitmapData,  8) ; Stride
       NumPut(   "ptr",      pBits, BitmapData, 16) ; Scan0

    ; Use LockBits to create a copy-from buffer on pBits that converts pARGB to ARGB.
    DllCall("gdiplus\GdipBitmapLockBits"
             ,    "ptr", pBitmap
             ,    "ptr", Rect
             ,   "uint", 6            ; ImageLockMode.UserInputBuffer | ImageLockMode.WriteOnly
             ,    "int", 0xE200B      ; Format32bppPArgb
             ,    "ptr", BitmapData)  ; Contains the pointer (pBits) to the hbm.

    ; If the source image cannot be selected onto a device context BitBlt cannot be used.
    sdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")           ; Creates a memory DC compatible with the current screen.
    old := DllCall("SelectObject", "ptr", sdc, "ptr", image, "ptr") ; Returns 0 on failure.

    ; Copies the image (hBitmap) to a top-down bitmap. Removes bottom-up-ness if present.
    if (old) ; Using BitBlt is about 10% faster than GetDIBits.
       DllCall("gdi32\BitBlt"
                , "ptr", hdc, "int", 0, "int", 0, "int", width, "int", height
                , "ptr", sdc, "int", 0, "int", 0, "uint", 0x00CC0020) ; SRCCOPY
    else ; If already selected onto a device context...
       DllCall("GetDIBits", "ptr", hdc, "ptr", image, "uint", 0, "uint", height, "ptr", pBits, "ptr", bi, "uint", 0)

    ; The stock bitmap (obm) can never be leaked.
    DllCall("SelectObject", "ptr", sdc, "ptr", obm)
    DllCall("DeleteDC",     "ptr", sdc)

    ; Write the pARGB pixels from the device independent bitmap (hbm) to the ARGB pBitmap.
    DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

    ; Cleanup the hBitmap and device contexts.
    DllCall("SelectObject", "ptr", hdc, "ptr", obm)
    DllCall("DeleteObject", "ptr", hbm)
    DllCall("DeleteDC",     "ptr", hdc)

    return pBitmap
 }

 static HIconToBitmap(image) {
    ; struct ICONINFO - https://docs.microsoft.com/en-us/windows/win32/api/winuser/ns-winuser-iconinfo
    ii := Buffer(8+3*A_PtrSize)                       ; sizeof(ICONINFO) = 20, 32
    DllCall("GetIconInfo", "ptr", image, "ptr", ii)
       ; xHotspot := NumGet(ii, 4, "uint")
       ; yHotspot := NumGet(ii, 8, "uint")
       , hbmMask  := NumGet(ii, 8+A_PtrSize, "ptr")   ; 12, 16
       , hbmColor := NumGet(ii, 8+2*A_PtrSize, "ptr") ; 16, 24

    ; struct BITMAP - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmap
    bm := Buffer(16+2*A_PtrSize)                      ; sizeof(BITMAP) = 24, 32
    DllCall("GetObject", "ptr", hbmMask, "int", bm.size, "ptr", bm)
       , width  := NumGet(bm, 4, "uint")
       , height := NumGet(bm, 8, "uint") / (hbmColor ? 1 : 2) ; Black and White cursors have doubled height.

    ; Clean up these hBitmaps.
    DllCall("DeleteObject", "ptr", hbmMask)
    DllCall("DeleteObject", "ptr", hbmColor)

    ; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
    hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
    bi := Buffer(40, 0)                    ; sizeof(bi) = 40
       NumPut(  "uint",        40, bi,  0) ; Size
       NumPut(   "int",     width, bi,  4) ; Width
       NumPut(   "int",   -height, bi,  8) ; Height - Negative so (0, 0) is top-left.
       NumPut("ushort",         1, bi, 12) ; Planes
       NumPut("ushort",        32, bi, 14) ; BitCount / BitsPerPixel
    hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", bi, "uint", 0, "ptr*", &pBits:=0, "ptr", 0, "uint", 0, "ptr")
    obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")

    ; Create a destination GDI+ Bitmap that owns its memory to receive the final converted pixels. The pixel format is 32-bit ARGB.
    DllCall("gdiplus\GdipCreateBitmapFromScan0"
             , "int", width, "int", height, "int", 0, "int", 0x26200A, "ptr", 0, "ptr*", &pBitmap:=0)

    ; Create a Scan0 buffer pointing to pBits. The buffer has pixel format pARGB.
    Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
       NumPut(  "uint",   width, Rect,  8) ; Width
       NumPut(  "uint",  height, Rect, 12) ; Height
    BitmapData := Buffer(16+2*A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
       NumPut(   "int",  4 * width, BitmapData,  8) ; Stride
       NumPut(   "ptr",      pBits, BitmapData, 16) ; Scan0

    ; Use LockBits to create a writable buffer that converts pARGB to ARGB.
    DllCall("gdiplus\GdipBitmapLockBits"
             ,    "ptr", pBitmap
             ,    "ptr", Rect
             ,   "uint", 6            ; ImageLockMode.UserInputBuffer | ImageLockMode.WriteOnly
             ,    "int", 0xE200B      ; Format32bppPArgb
             ,    "ptr", BitmapData)  ; Contains the pointer (pBits) to the hbm.

    ; Don't use DI_DEFAULTSIZE to draw the icon like DrawIcon does as it will resize to 32 x 32.
    DllCall("user32\DrawIconEx"
             , "ptr", hdc,   "int", 0, "int", 0
             , "ptr", image, "int", 0, "int", 0
             , "uint", 0, "ptr", 0, "uint", 0x1 | 0x2 | 0x4) ; DI_MASK | DI_IMAGE | DI_COMPAT

    ; Convert the pARGB pixels copied into the device independent bitmap (hbm) to ARGB.
    DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

    ; Cleanup the hBitmap and device contexts.
    DllCall("SelectObject", "ptr", hdc, "ptr", obm)
    DllCall("DeleteObject", "ptr", hbm)
    DllCall("DeleteDC",     "ptr", hdc)

    return pBitmap
 }

 static BitmapToBitmap(image) {
    ; Clone and retain a reference to the backing stream.
    DllCall("gdiplus\GdipCloneImage", "ptr", image, "ptr*", &pBitmap:=0)
    return pBitmap
 }

 static StreamToBitmap(image) {
    stream := this.StreamToStream(image) ; Below adds +3 references and seeks to 4096.
    DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap:=0)
    ObjRelease(stream)
    return pBitmap
 }

 static StreamToStream(image) {
    ; Creates a new, separate stream. Necessary to separate reference counting through a clone.
    ComCall(Clone := 13, image, "ptr*", &stream:=0)
    ; Ensures that a duplicated stream does not inherit the original seek position.
    DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")
    return stream
 }

 static RandomAccessStreamToBitmap(image) {
    stream := this.RandomAccessStreamToStream(image) ; Below adds +3 to the reference count.
    DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap:=0)
    ObjRelease(stream)
    return pBitmap
 }

 static RandomAccessStreamToStream(image) {
    ; Since an IStream returned from CreateStreamOverRandomAccessStream shares a reference count
    ; with the internal IStream of the RandomAccessStream, clone it so that reference counting begins anew.
    IID_IStream := Buffer(16)
    DllCall("ole32\IIDFromString", "wstr", "{0000000C-0000-0000-C000-000000000046}", "ptr", IID_IStream, "hresult")
    DllCall("shcore\CreateStreamOverRandomAccessStream", "ptr", image, "ptr", IID_IStream, "ptr*", &stream:=0, "hresult")
    ComCall(Clone := 13, stream, "ptr*", &ClonedStream:=0)
    return ClonedStream
 }

 static WicBitmapToBitmap(image) {
    ComCall(GetSize := 3, image, "uint*", &width:=0, "uint*", &height:=0)

    ; Create a destination GDI+ Bitmap that owns its memory. The pixel format is 32-bit ARGB.
    DllCall("gdiplus\GdipCreateBitmapFromScan0"
             , "int", width, "int", height, "int", 0, "int", 0x26200A, "ptr", 0, "ptr*", &pBitmap:=0)

    ; Create a pixel buffer.
    Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
       NumPut(  "uint",   width, Rect,  8) ; Width
       NumPut(  "uint",  height, Rect, 12) ; Height
    BitmapData := Buffer(16+2*A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
    DllCall("gdiplus\GdipBitmapLockBits"
             ,    "ptr", pBitmap
             ,    "ptr", Rect
             ,   "uint", 2            ; ImageLockMode.WriteOnly
             ,    "int", 0x26200A     ; Format32bppArgb
             ,    "ptr", BitmapData)
    Scan0 := NumGet(BitmapData, 16, "ptr")
    stride := NumGet(BitmapData, 8, "int")

    ComCall(CopyPixels := 7, image, "ptr", Rect, "uint", stride, "uint", stride * height, "ptr", Scan0)

    ; Write pixels to bitmap.
    DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

    return pBitmap
 }
