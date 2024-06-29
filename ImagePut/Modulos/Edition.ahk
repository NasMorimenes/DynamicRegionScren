BitmapScale( &pBitmap, scale, direction := 0 ) {

    Aa := IsObject( scale )
    Ab := scale[1] ~= "^\d+$" 
    Ac := scale[2] ~= "^\d+$"
    Ad := scale ~= "^\d+(\.\d+)?$"

    Verif := Aa && ( Ab || Ac ) || Ad

    if ( !Verif ) {
        throw Error("Invalid scale.")
    }
    ; Get Bitmap width, height, and format.
    uintWidth :=
    DllCall(
        "gdiplus\GdipGetImageWidth",
        "Ptr", pBitmap,
        "UInt*", &width := 0,
        "UInt"
    )
    uintHeight :=
    DllCall(
        "gdiplus\GdipGetImageHeight",
        "Ptr", pBitmap,
        "UInt*", &height := 0,
        "UInt"
    )
    intFormat :=
    DllCall(
        "gdiplus\GdipGetImagePixelFormat",
        "Ptr", pBitmap,
        "Int*", &format := 0,
        "Int"
    )

    Ab := scale[1] ~= "^\d+$" 
    Ac := scale[2] ~= "^\d+$"
    Ad := scale ~= "^\d+(\.\d+)?$"

    if IsObject(scale) {
        safe_w := ( Ab ) ? scale[1] : Round( width / height * scale[2] )
        safe_h := ( Ac ) ? scale[2] : Round( height / width * scale[1] )
    }
    else {
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
    ptrBitmapScale :=
    DllCall(
        "gdiplus\GdipCreateBitmapFromScan0",
        "Int", safe_w,
        "Int", safe_h,
        "Int", 0,
        "Int", format,
        "Ptr", 0,
        "Ptr*", &pBitmapScale := 0,
        "Ptr"
    )
    ptrGraphics :=
    DllCall(
        "gdiplus\GdipGetImageGraphicsContext",
        "Ptr", pBitmapScale,
        "Ptr*", &pGraphics := 0,
        "Ptr"
    )

    ; Set settings in graphics context.
    DllCall(
        "gdiplus\GdipSetPixelOffsetMode",
        "Ptr", pGraphics,
        "Int", 2
    ) ; Half pixel offset.
    DllCall(
        "gdiplus\GdipSetCompositingMode",
        "Ptr", pGraphics,
        "Int", 1
    ) ; Overwrite/SourceCopy.
    DllCall(
        "gdiplus\GdipSetInterpolationMode",
        "Ptr", pGraphics,
        "Int", 7
    ) ; HighQualityBicubic

    ; Draw Image.
    ptrImageAttr :=
    DllCall(
        "gdiplus\GdipCreateImageAttributes",
        "Ptr*", &ImageAttr := 0,
        "Ptr"
    )
    DllCall(
        "gdiplus\GdipSetImageAttributesWrapMode",
        "Ptr", ImageAttr,
        "Int", 3,
        "UInt", 0,
        "Int", 0
    ) ; WrapModeTileFlipXY
    DllCall(
        "gdiplus\GdipDrawImageRectRectI",
        "Ptr", pGraphics,
        "Ptr", pBitmap,
        "Int", 0,
        "Int", 0,
        "Int", safe_w,
        "Int", safe_h, ; destination rectangle
        "Int", 0,
        "Int", 0,
        "Int", width,
        "Int", height, ; source rectangle
        "Int", 2,
        "Ptr", ImageAttr,
        "Ptr", 0,
        "Ptr", 0
    )
    DllCall("gdiplus\GdipDisposeImageAttributes", "Ptr", ImageAttr)

    ; Clean up the graphics context.
    DllCall("gdiplus\GdipDeleteGraphics", "Ptr", pGraphics)
    DllCall("gdiplus\GdipDisposeImage", "Ptr", pBitmap)

    return pBitmap := pBitmapScale
}










BitmapSprite(&pBitmap) {
    ; Get Bitmap width and height.
    uintWidth :=
    DllCall(
        "gdiplus\GdipGetImageWidth",
        "Ptr", pBitmap,
        "UInt*", &width := 0,
        "UInt"
    )
    uintHeight :=
    DllCall(
        "gdiplus\GdipGetImageHeight",
        "Ptr", pBitmap,
        "UInt*", &height := 0,
        "UInt"
    )

    ; Create a pixel buffer.
    Rect := Buffer(16, 0) ; sizeof(Rect) = 16
    NumPut("UInt", width, Rect, 8) ; Width
    NumPut("UInt", height, Rect, 12) ; Height
    BitmapData := Buffer(16 + 2 * A_PtrSize, 0) ; sizeof(BitmapData) = 24, 32
    DllCall(
        "gdiplus\GdipBitmapLockBits",
        "Ptr", pBitmap,
        "Ptr", Rect,
        "UInt", 3, ; ImageLockMode.ReadWrite
        "Int", 0x26200A, ; Format32bppArgb
        "Ptr", BitmapData
    )
    Scan0 := NumGet(BitmapData, 16, "Ptr")

    ; C source code - https://godbolt.org/z/nrv5Yr3Y3
    static code := 0
    if !code {
        b64 := (A_PtrSize == 4)
            ? "VYnli0UIi1UMi00QOdBzDzkIdQbHAAAAAACDwATr7V3D"
            : "SDnRcw9EOQF1BDHAiQFIg8EE6+zD"
        s64 := StrLen(RTrim(b64, "=")) * 3 // 4
        code := DllCall("GlobalAlloc", "UInt", 0, "Uptr", s64, "Ptr")
        DllCall("crypt32\CryptStringToBinary", "Str", b64, "UInt", 0, "UInt", 0x1, "Ptr", code, "UInt*", s64, "Ptr", 0, "Ptr", 0)
        DllCall("VirtualProtect", "Ptr", code, "Ptr", s64, "UInt", 0x40, "UInt*", 0)
    }

    ; Sample the top-left pixel and set all matching pixels to be transparent.
    DllCall(code, "Ptr", Scan0, "Ptr", Scan0 + 4 * width * height, "UInt", NumGet(Scan0, "UInt"), "cdecl")

    ; Write pixels to bitmap.
    DllCall("gdiplus\GdipBitmapUnlockBits", "Ptr", pBitmap, "Ptr", BitmapData)

    return pBitmap
}

BitmapToBitmap(image) {
    ; Clone and retain a reference to the backing stream.
    ptrBitmap :=
    DllCall(
        "gdiplus\GdipCloneImage",
        "Ptr", image,
        "Ptr*", &pBitmap := 0,
        "Ptr"
    )
    return pBitmap
}

BitmapToBuffer(pBitmap) {
    ; Get Bitmap width and height.
    uintWidth :=
    DllCall(
        "gdiplus\GdipGetImageWidth",
        "Ptr", pBitmap,
        "UInt*", &width := 0,
        "UInt"
    )
    uintHeight :=
    DllCall(
        "gdiplus\GdipGetImageHeight",
        "Ptr", pBitmap,
        "UInt*", &height := 0,
        "UInt"
    )

    ; Allocate global memory.
    size := 4 * width * height
    ptr := DllCall("GlobalAlloc", "UInt", 0, "Uptr", size, "Ptr")

    ; Create a pixel buffer.
    Rect := Buffer(16, 0) ; sizeof(Rect) = 16
    NumPut("UInt", width, Rect, 8) ; Width
    NumPut("UInt", height, Rect, 12) ; Height
    BitmapData := Buffer(16 + 2 * A_PtrSize, 0) ; sizeof(BitmapData) = 24, 32
    NumPut("Int", 4 * width, BitmapData, 8) ; Stride
    NumPut("Ptr", ptr, BitmapData, 16) ; Scan0
    DllCall(
        "gdiplus\GdipBitmapLockBits",
        "Ptr", pBitmap,
        "Ptr", Rect,
        "UInt", 5, ; ImageLockMode.UserInputBuffer | ImageLockMode.ReadOnly
        "Int", 0x26200A, ; Format32bppArgb
        "Ptr", BitmapData
    )

    ; Write pixels to global memory.
    DllCall("gdiplus\GdipBitmapUnlockBits", "Ptr", pBitmap, "Ptr", BitmapData)

    ; Free the pixels later.
    buf := ImagePut.BitmapBuffer(ptr, size, width, height)
    buf.free := [DllCall.bind("GlobalFree", "Ptr", ptr)]
    return buf
}

BitmapToClipboard(pBitmap) {
    ; Standard Clipboard Formats - https://www.codeproject.com/Reference/1091137/Windows-Clipboard-Formats
    ; Synthesized Clipboard Formats - https://docs.microsoft.com/en-us/windows/win32/dataxchg/clipboard-formats

    ; Open the clipboard with exponential backoff.
    loop
        if DllCall("OpenClipboard", "Ptr", A_ScriptHwnd)
            break
        else
            if A_Index < 6
                Sleep (2 ** (A_Index - 1) * 30)
            else throw Error("Clipboard could not be opened.")

    ; Requires a valid window handle via OpenClipboard or the next call to OpenClipboard will crash.
    DllCall("EmptyClipboard")

    ; #1 - PNG holds the transparency and is the most widely supported image format.
    ; Thanks Jochen Arndt - https://www.codeproject.com/Answers/1207927/Saving-an-image-to-the-clipboard#answer3
    ptrStream :=
    DllCall(
        "ole32\CreateStreamOnHGlobal",
        "Ptr", 0,
        "Int", False,
        "Ptr*", &stream := 0,
        "HResult"
    )
    pCodec :=
    DllCall(
        "ole32\CLSIDFromString",
        "WStr", "{557CF406-1A04-11D3-9A73-0000F81EF32E}",
        "Ptr", pCodec := Buffer(16),
        "HResult"
    )
    DllCall(
        "gdiplus\GdipSaveImageToStream",
        "Ptr", pBitmap,
        "Ptr", stream,
        "Ptr", pCodec,
        "Ptr", 0
    )

    ; Set the rescued HGlobal to the clipboard as a shared object.
    uintHandle :=
    DllCall(
        "ole32\GetHGlobalFromStream",
        "Ptr", stream,
        "UInt*", &handle := 0,
        "HResult"
    )
    ObjRelease(stream)

    ; Set the clipboard data. GlobalFree will be called by the system.
    png := DllCall("RegisterClipboardFormat", "Str", "png", "UInt") ; case insensitive
    DllCall("SetClipboardData", "UInt", png, "Ptr", handle)


    ; #2 - Fallback to the CF_DIB format (bottom-up bitmap) for maximum compatibility.
    ; Thanks tic - https://www.autohotkey.com/boards/viewtopic.php?t=6517
    ptrHbm :=
    DllCall(
        "gdiplus\GdipCreateHBITMAPFromBitmap",
        "Ptr", pBitmap,
        "Ptr*", &hbm := 0,
        "UInt", 0
    )

    ; struct DIBSECTION - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-dibsection
    ; struct BITMAP - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmap
    dib := Buffer(64 + 5 * A_PtrSize) ; sizeof(DIBSECTION) = 84, 104
    DllCall(
        "GetObject",
        "Ptr", hbm,
        "Int", dib.size,
        "Ptr", dib
    ),
    pBits := NumGet(dib, A_PtrSize = 4 ? 20 : 24, "Ptr"), ; bmBits
    size := NumGet(dib, A_PtrSize = 4 ? 44 : 52, "UInt") ; biSizeImage

    ; Allocate space for a new device independent bitmap on movable memory.
    hdib := DllCall("GlobalAlloc", "UInt", 0x2, "Uptr", 40 + size, "Ptr") ; sizeof(BITMAPINFOHEADER) = 40
    pdib := DllCall("GlobalLock", "Ptr", hdib, "Ptr")

    ; Copy the BITMAPINFOHEADER and pixel data respectively.
    DllCall("RtlMoveMemory", "Ptr", pdib, "Ptr", dib.ptr + (A_PtrSize = 4 ? 24 : 32), "Uptr", 40)
    DllCall("RtlMoveMemory", "Ptr", pdib + 40, "Ptr", pBits, "Uptr", size)

    ; Unlock to moveable memory because the clipboard requires it.
    DllCall("GlobalUnlock", "Ptr", hdib)
    DllCall("DeleteObject", "Ptr", hbm)

    ; CF_DIB (8) can be synthesized into CF_DIBV5 (17) and CF_BITMAP (2) with delayed rendering.
    DllCall("SetClipboardData", "UInt", 8, "Ptr", hdib)

    ; Close the clipboard.
    DllCall("CloseClipboard")
    return ClipboardAll()
}

BitmapToCoimage(cotype, pBitmap, p1:="", p2:="", p3:="", p4:="", p5:="", p6:="", p7:="", p*) {

    if (cotype = "Clipboard") ; (pBitmap)
        return BitmapToClipboard(pBitmap)

    if (cotype = "Screenshot") ; (pBitmap, pos, alpha)
        return BitmapToScreenshot(pBitmap, p1, p2)

    if (cotype = "Window") ; (pBitmap, title, pos, style, styleEx, parent, playback, cache)
        return BitmapToWindow(pBitmap, p1, p2, p3, p4, p5, p6, p7)

    if (cotype = "Show") ; (pBitmap, title, pos, style, styleEx, parent, playback, cache)
        return Show(pBitmap, p1, p2, p3, p4, p5, p6, p7)

    if (cotype = "EncodedBuffer") ; (pBitmap, extension, quality)
        return BitmapToEncodedBuffer(pBitmap, p1, p2)

    if (cotype = "Buffer") ; (pBitmap)
        return BitmapToBuffer(pBitmap)

    if (cotype = "SharedBuffer") ; (pBitmap, name)
        return BitmapToSharedBuffer(pBitmap, p1)

    if (cotype = "Desktop") ; (pBitmap)
        return BitmapToDesktop(pBitmap)

    if (cotype = "Wallpaper") ; (pBitmap)
        return BitmapToWallpaper(pBitmap)

    if (cotype = "Cursor") ; (pBitmap, xHotspot, yHotspot)
        return BitmapToCursor(pBitmap, p1, p2)

    if (cotype = "Url") ; (pBitmap)
        return BitmapToUrl(pBitmap)

    if (cotype = "File") ; (pBitmap, filepath, quality)
        return BitmapToFile(pBitmap, p1, p2)

    if (cotype = "Hex") ; (pBitmap, extension, quality)
        return BitmapToHex(pBitmap, p1, p2)

    if (cotype = "Base64") ; (pBitmap, extension, quality)
        return BitmapToBase64(pBitmap, p1, p2)

    if (cotype = "Uri") ; (pBitmap, extension, quality)
        return BitmapToUri(pBitmap, p1, p2)

    if (cotype = "DC") ; (pBitmap, alpha)
        return BitmapToDC(pBitmap, p1)

    if (cotype = "HBitmap") ; (pBitmap, alpha)
        return BitmapToHBitmap(pBitmap, p1)

    if (cotype = "HIcon") ; (pBitmap)
        return BitmapToHIcon(pBitmap)

    if (cotype = "Bitmap")
        return pBitmap

    if (cotype = "Stream") ; (pBitmap, extension, quality)
        return BitmapToStream(pBitmap, p1, p2)

    if (cotype = "RandomAccessStream") ; (pBitmap, extension, quality)
        return BitmapToRandomAccessStream(pBitmap, p1, p2)

    if (cotype = "WicBitmap") ; (pBitmap)
        return BitmapToWicBitmap(pBitmap)

    if (cotype = "Explorer") ; (pBitmap, default)
        return BitmapToExplorer(pBitmap, p1)

    if (cotype = "SafeArray") ; (pBitmap, extension, quality)
        return BitmapToSafeArray(pBitmap, p1, p2)

    if (cotype = "FormData") ; (pBitmap, boundary, extension, quality)
        return BitmapToFormData(pBitmap, p1, p2, p3)

    throw Error("Conversion from bitmap to " cotype " is not supported.")
}

