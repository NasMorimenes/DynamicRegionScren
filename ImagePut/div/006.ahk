
static BitmapToClipboard(pBitmap) {
    ; Standard Clipboard Formats - https://www.codeproject.com/Reference/1091137/Windows-Clipboard-Formats
    ; Synthesized Clipboard Formats - https://docs.microsoft.com/en-us/windows/win32/dataxchg/clipboard-formats

    ; Open the clipboard with exponential backoff.
    loop
       if DllCall("OpenClipboard", "ptr", A_ScriptHwnd)
          break
       else
          if A_Index < 6
             Sleep (2**(A_Index-1) * 30)
          else throw Error("Clipboard could not be opened.")

    ; Requires a valid window handle via OpenClipboard or the next call to OpenClipboard will crash.
    DllCall("EmptyClipboard")

    ; #1 - PNG holds the transparency and is the most widely supported image format.
    ; Thanks Jochen Arndt - https://www.codeproject.com/Answers/1207927/Saving-an-image-to-the-clipboard#answer3
    DllCall("ole32\CreateStreamOnHGlobal", "ptr", 0, "int", False, "ptr*", &stream:=0, "hresult")
    DllCall("ole32\CLSIDFromString", "wstr", "{557CF406-1A04-11D3-9A73-0000F81EF32E}", "ptr", pCodec:=Buffer(16), "hresult")
    DllCall("gdiplus\GdipSaveImageToStream", "ptr", pBitmap, "ptr", stream, "ptr", pCodec, "ptr", 0)

    ; Set the rescued HGlobal to the clipboard as a shared object.
    DllCall("ole32\GetHGlobalFromStream", "ptr", stream, "uint*", &handle:=0, "hresult")
    ObjRelease(stream)

    ; Set the clipboard data. GlobalFree will be called by the system.
    png := DllCall("RegisterClipboardFormat", "str", "png", "uint") ; case insensitive
    DllCall("SetClipboardData", "uint", png, "ptr", handle)


    ; #2 - Fallback to the CF_DIB format (bottom-up bitmap) for maximum compatibility.
    ; Thanks tic - https://www.autohotkey.com/boards/viewtopic.php?t=6517
    DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "ptr", pBitmap, "ptr*", &hbm:=0, "uint", 0)

    ; struct DIBSECTION - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-dibsection
    ; struct BITMAP - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmap
    dib := Buffer(64+5*A_PtrSize) ; sizeof(DIBSECTION) = 84, 104
    DllCall("GetObject", "ptr", hbm, "int", dib.size, "ptr", dib)
       , pBits := NumGet(dib, A_PtrSize = 4 ? 20:24, "ptr")  ; bmBits
       , size  := NumGet(dib, A_PtrSize = 4 ? 44:52, "uint") ; biSizeImage

    ; Allocate space for a new device independent bitmap on movable memory.
    hdib := DllCall("GlobalAlloc", "uint", 0x2, "uptr", 40 + size, "ptr") ; sizeof(BITMAPINFOHEADER) = 40
    pdib := DllCall("GlobalLock", "ptr", hdib, "ptr")

    ; Copy the BITMAPINFOHEADER and pixel data respectively.
    DllCall("RtlMoveMemory", "ptr", pdib, "ptr", dib.ptr + (A_PtrSize = 4 ? 24:32), "uptr", 40)
    DllCall("RtlMoveMemory", "ptr", pdib+40, "ptr", pBits, "uptr", size)

    ; Unlock to moveable memory because the clipboard requires it.
    DllCall("GlobalUnlock", "ptr", hdib)
    DllCall("DeleteObject", "ptr", hbm)

    ; CF_DIB (8) can be synthesized into CF_DIBV5 (17) and CF_BITMAP (2) with delayed rendering.
    DllCall("SetClipboardData", "uint", 8, "ptr", hdib)

    ; Close the clipboard.
    DllCall("CloseClipboard")
    return ClipboardAll()
 }

 
static StreamToClipboard(stream) {
    DllCall("shlwapi\IStream_Size", "ptr", stream, "uint64*", &size:=0, "hresult")
    DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")

    ; 2048 characters should be good enough to identify the file correctly.
    size := min(size, 2048)
    bin := Buffer(size)

    ; Get the first few bytes of the image.
    DllCall("shlwapi\IStream_Read", "ptr", stream, "ptr", bin, "uint", size, "hresult")
    DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")

    ; Allocate enough space for a hexadecimal string with spaces interleaved and a null terminator.
    length := 2*size + (size-1) + 1
    VarSetStrCapacity(&str, length)

    ; Lift the binary representation to hex.
    flags := 0x40000004 ; CRYPT_STRING_NOCRLF | CRYPT_STRING_HEX
    DllCall("crypt32\CryptBinaryToString", "ptr", bin, "uint", size, "uint", flags, "str", str, "uint*", &length)

    ; Determine the extension using herustics. See: http://fileformats.archiveteam.org
    extension := 0                                                              ? ""
    : str ~= "(?i)66 74 79 70 61 76 69 66"                                      ? "avif" ; ftypavif
    : str ~= "(?i)^42 4d (.. ){36}00 00 .. 00 00 00"                            ? "bmp"  ; BM
    : str ~= "(?i)^01 00 00 00 (.. ){36}20 45 4D 46"                            ? "emf"  ; emf
    : str ~= "(?i)^47 49 46 38 (37|39) 61"                                      ? "gif"  ; GIF87a or GIF89a
    : str ~= "(?i)66 74 79 70 68 65 69 63"                                      ? "heic" ; ftypheic
    : str ~= "(?i)^00 00 01 00"                                                 ? "ico"
    : str ~= "(?i)^ff d8 ff"                                                    ? "jpg"
    : str ~= "(?i)^25 50 44 46 2d"                                              ? "pdf"  ; %PDF-
    : str ~= "(?i)^89 50 4e 47 0d 0a 1a 0a"                                     ? "png"  ; PNG
    : str ~= "(?i)^(((?!3c|3e).. )|3c (3f|21) ((?!3c|3e).. )*3e )*+3c 73 76 67" ? "svg"  ; <svg
    : str ~= "(?i)^(49 49 2a 00|4d 4d 00 2a)"                                   ? "tif"  ; II* or MM*
    : str ~= "(?i)^52 49 46 46 .. .. .. .. 57 45 42 50"                         ? "webp" ; RIFF....WEBP
    : str ~= "(?i)^d7 cd c6 9a"                                                 ? "wmf"
    : "" ; Extension must be blank for file pass-through as-is.

    ; Creates a dummy window solely for the purpose of receiving clipboard messages.
    if !(hwnd := DllCall("FindWindow", "str", "AutoHotkey", "str", "_StreamToClipboard", "ptr")) {
       hwnd := DllCall("CreateWindowEx", "uint", 0, "str", "AutoHotkey", "str", "_StreamToClipboard"
       , "uint", 0, "int", 0, "int", 0, "int", 0, "int", 0, "ptr", 0, "ptr", 0, "ptr", 0, "ptr", 0, "ptr")
       DllCall("SetWindowLong" (A_PtrSize=8?"Ptr":""), "ptr", hwnd, "int", -4, "ptr", CallbackCreate(StreamToClipboardProc)) ; GWLP_WNDPROC
    }

    ; Open the clipboard with exponential backoff.
    loop
       if DllCall("OpenClipboard", "ptr", hwnd)
          break
       else
          if A_Index < 6
             Sleep (2**(A_Index-1) * 30)
          else throw Error("Clipboard could not be opened.")

    ; Requires a valid window handle via OpenClipboard or the next call to OpenClipboard will crash.
    DllCall("EmptyClipboard")

    ; #1 - Save PNG directly to the clipboard.
    if (extension = "png") {
       ; Clone the stream. Can't use IStream::Clone because the cloned stream must be released.
       DllCall("shlwapi\IStream_Size", "ptr", stream, "uint64*", &size:=0, "hresult")
       handle := DllCall("GlobalAlloc", "uint", 0x2, "uptr", size, "ptr")
       DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", False, "ptr*", &ClonedStream:=0, "hresult")
       DllCall("shlwapi\IStream_Copy", "ptr", stream, "ptr", ClonedStream, "uint", size, "hresult")
       DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")
       ObjRelease(ClonedStream)

       png := DllCall("RegisterClipboardFormat", "str", "png", "uint") ; case insensitive
       DllCall("SetClipboardData", "uint", png, "ptr", handle)
    }

    ; #2 - Copy other formats to a file and pass a (15) DROPFILES struct.
    if (extension) {
       filepath := A_ScriptDir "\clipboard." extension
       filepath := RTrim(filepath, ".") ; Remove trailing periods.

       ; For compatibility with SHCreateMemStream do not use GetHGlobalFromStream.
       DllCall("shlwapi\SHCreateStreamOnFileEx"
                ,   "wstr", filepath
                ,   "uint", 0x1001          ; STGM_CREATE | STGM_WRITE
                ,   "uint", 0x80            ; FILE_ATTRIBUTE_NORMAL
                ,    "int", True            ; fCreate is ignored when STGM_CREATE is set.
                ,    "ptr", 0               ; pstmTemplate (reserved)
                ,   "ptr*", &FileStream:=0
                ,"hresult")
       DllCall("shlwapi\IStream_Size", "ptr", stream, "uint64*", &size:=0, "hresult")
       DllCall("shlwapi\IStream_Copy", "ptr", stream, "ptr", FileStream, "uint", size, "hresult")
       DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")
       ObjRelease(FileStream)

       ; struct DROPFILES - https://learn.microsoft.com/en-us/windows/win32/api/shlobj_core/ns-shlobj_core-dropfiles
       nDropFiles := 20 + StrPut(filepath, "UTF-16") + 2 ; triple/quadruple null terminated
       hDropFiles := DllCall("GlobalAlloc", "uint", 0x42, "uptr", nDropFiles, "ptr")
       pDropFiles := DllCall("GlobalLock", "ptr", hDropFiles, "ptr")
          NumPut("uint", 20, pDropFiles + 0) ; pFiles
          NumPut("uint", 1, pDropFiles + 16) ; fWide
          StrPut(filepath, pDropFiles + 20, "UTF-16")
       DllCall("GlobalUnlock", "ptr", hDropFiles)

       ; Set the file to the clipboard as a shared object.
       DllCall("SetClipboardData", "uint", 15, "ptr", hDropFiles)

       ; Clean up the file when EmptyClipboard is called by another program.
       obj := {filepath: filepath}
       ptr := ObjPtr(obj)
       ObjAddRef(ptr)
       DllCall("SetWindowLong" (A_PtrSize=8?"Ptr":""), "ptr", hwnd, "int", -21, "ptr", ptr, "ptr") ; GWLP_USERDATA = -21
    }

    ; #3 - Fallback to (8) CF_DIB format (bottom-up bitmap) for maximum compatibility.
    if (extension ~= "^(?i:avif|bmp|emf|gif|heic|ico|jpg|png|tif|webp|wmf)$") {
       ; Convert decodable formats into a DIB.
       DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap:=0)
       DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "ptr", pBitmap, "ptr*", &hbm:=0, "uint", 0)

       ; struct DIBSECTION - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-dibsection
       ; struct BITMAP - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmap
       dib := Buffer(64+5*A_PtrSize)                            ; sizeof(DIBSECTION) = 84, 104
       DllCall("GetObject", "ptr", hbm, "int", dib.size, "ptr", dib)
          , pBits := NumGet(dib, A_PtrSize = 4 ? 20:24, "ptr")  ; bmBits
          , size  := NumGet(dib, A_PtrSize = 4 ? 44:52, "uint") ; biSizeImage

       ; Allocate space for a new device independent bitmap on movable memory.
       hdib := DllCall("GlobalAlloc", "uint", 0x2, "uptr", 40 + size, "ptr") ; sizeof(BITMAPINFOHEADER) = 40
       pdib := DllCall("GlobalLock", "ptr", hdib, "ptr")

       ; Copy the BITMAPINFOHEADER and pixel data respectively.
       DllCall("RtlMoveMemory", "ptr", pdib, "ptr", dib.ptr + (A_PtrSize = 4 ? 24:32), "uptr", 40)
       DllCall("RtlMoveMemory", "ptr", pdib+40, "ptr", pBits, "uptr", size)

       ; Unlock to moveable memory because the clipboard requires it.
       DllCall("GlobalUnlock", "ptr", hdib)
       DllCall("DeleteObject", "ptr", hbm)

       ; CF_DIB (8) can be synthesized into CF_DIBV5 (17), and also CF_BITMAP (2) with delayed rendering.
       DllCall("SetClipboardData", "uint", 8, "ptr", hdib)
    }

    ; Close the clipboard.
    DllCall("CloseClipboard")
    return ClipboardAll()

    StreamToClipboardProc(hwnd, uMsg, wParam, lParam) {

       ; WM_DESTROYCLIPBOARD
       if (uMsg = 0x0307) ; ObjFromPtr self-destructs at end of scope.
          if obj := ObjFromPtr(DllCall("GetWindowLong" (A_PtrSize=8?"Ptr":""), "ptr", hwnd, "int", -21, "ptr"))
             DllCall("DeleteFile", "str", obj.filepath)
    }
 }

 static BitmapToEncodedBuffer(pBitmap, extension := "", quality := "") {
    ; Defaults to PNG for small sizes!
    stream := this.BitmapToStream(pBitmap, (extension) ? extension : "png", quality)

    ; Get a pointer to the encoded image data.
    DllCall("ole32\GetHGlobalFromStream", "ptr", stream, "ptr*", &handle:=0, "hresult")
    ptr := DllCall("GlobalLock", "ptr", handle, "ptr")
    size := DllCall("GlobalSize", "ptr", handle, "uptr")

    ; Copy data into a buffer.
    buf := Buffer(size)
    DllCall("RtlMoveMemory", "ptr", buf.ptr, "ptr", ptr, "uptr", size)

    ; Release binary data and stream.
    DllCall("GlobalUnlock", "ptr", handle)
    ObjRelease(stream)

    return buf
 }

 static StreamToEncodedBuffer(stream) {
    DllCall("shlwapi\IStream_Size", "ptr", stream, "uint64*", &size:=0, "hresult")
    buf := Buffer(size)
    DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")
    DllCall("shlwapi\IStream_Read", "ptr", stream, "ptr", buf.ptr, "uint", size, "hresult")
    DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")
    return buf
 }

 static BitmapToBuffer(pBitmap) {
    ; Get Bitmap width and height.
    DllCall("gdiplus\GdipGetImageWidth", "ptr", pBitmap, "uint*", &width:=0)
    DllCall("gdiplus\GdipGetImageHeight", "ptr", pBitmap, "uint*", &height:=0)

    ; Allocate global memory.
    size := 4 * width * height
    ptr := DllCall("GlobalAlloc", "uint", 0, "uptr", size, "ptr")

    ; Create a pixel buffer.
    Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
       NumPut(  "uint",   width, Rect,  8) ; Width
       NumPut(  "uint",  height, Rect, 12) ; Height
    BitmapData := Buffer(16+2*A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
       NumPut(   "int",  4 * width, BitmapData,  8) ; Stride
       NumPut(   "ptr",        ptr, BitmapData, 16) ; Scan0
    DllCall("gdiplus\GdipBitmapLockBits"
             ,    "ptr", pBitmap
             ,    "ptr", Rect
             ,   "uint", 5            ; ImageLockMode.UserInputBuffer | ImageLockMode.ReadOnly
             ,    "int", 0x26200A     ; Format32bppArgb
             ,    "ptr", BitmapData)

    ; Write pixels to global memory.
    DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

    ; Free the pixels later.
    buf := ImagePut.BitmapBuffer(ptr, size, width, height)
    buf.free := [DllCall.bind("GlobalFree", "ptr", ptr)]
    return buf
 }

 static SharedBufferToSharedBuffer(image) {
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

 static SharedBufferToBitmap(image) {
    hMap := DllCall("OpenFileMapping", "uint", 0x2, "int", 0, "str", image, "ptr")
    pMap := DllCall("MapViewOfFile", "ptr", hMap, "uint", 0x2, "uint", 0, "uint", 0, "uptr", 0, "ptr")

    width := NumGet(pMap + 0, "uint")
    height := NumGet(pMap + 4, "uint")
    size := 4 * width * height
    ptr := pMap + 8

    ; Create a destination GDI+ Bitmap that owns its memory. The pixel format is 32-bit ARGB.
    DllCall("gdiplus\GdipCreateBitmapFromScan0"
             , "int", width, "int", height, "uint", size / height, "uint", 0x26200A, "ptr", 0, "ptr*", &pBitmap:=0)

    ; Create a Scan0 buffer pointing to pBits.
    Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
       NumPut(  "uint",   width, Rect,  8) ; Width
       NumPut(  "uint",  height, Rect, 12) ; Height
    BitmapData := Buffer(16+2*A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
       NumPut(   "int",  4 * width, BitmapData,  8) ; Stride
       NumPut(   "ptr",        ptr, BitmapData, 16) ; Scan0

    ; Use LockBits to create a writable buffer that converts pARGB to ARGB.
    DllCall("gdiplus\GdipBitmapLockBits"
             ,    "ptr", pBitmap
             ,    "ptr", Rect
             ,   "uint", 6            ; ImageLockMode.UserInputBuffer | ImageLockMode.WriteOnly
             ,    "int", 0x26200A     ; Format32bppArgb
             ,    "ptr", BitmapData)  ; Contains the pointer (pBits) to the hbm.

    ; Convert the pARGB pixels copied into the device independent bitmap (hbm) to ARGB.
    DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

    DllCall("UnmapViewOfFile", "ptr", pMap)
    DllCall("CloseHandle", "ptr", hMap)

    return pBitmap
 }

 static BitmapToSharedBuffer(pBitmap, name := "Alice") {
    ; Get Bitmap width and height.
    DllCall("gdiplus\GdipGetImageWidth", "ptr", pBitmap, "uint*", &width:=0)
    DllCall("gdiplus\GdipGetImageHeight", "ptr", pBitmap, "uint*", &height:=0)

    ; Allocate shared memory.
    size := 4 * width * height
    hMap := DllCall("CreateFileMapping", "ptr", -1, "ptr", 0, "uint", 0x4, "uint", 0, "uint", size, "str", name, "ptr")
    pMap := DllCall("MapViewOfFile", "ptr", hMap, "uint", 0x2, "uint", 0, "uint", 0, "uptr", 0, "ptr")

    ; Store width and height in the first 8 bytes.
    NumPut("uint",  width, pMap + 0)
    NumPut("uint", height, pMap + 4)
    ptr := pMap + 8

    ; Target a pixel buffer.
    Rect := Buffer(16, 0)                  ; sizeof(Rect) = 16
       NumPut(  "uint",   width, Rect,  8) ; Width
       NumPut(  "uint",  height, Rect, 12) ; Height
    BitmapData := Buffer(16+2*A_PtrSize, 0)         ; sizeof(BitmapData) = 24, 32
       NumPut(   "int",  4 * width, BitmapData,  8) ; Stride
       NumPut(   "ptr",        ptr, BitmapData, 16) ; Scan0
    DllCall("gdiplus\GdipBitmapLockBits"
             ,    "ptr", pBitmap
             ,    "ptr", Rect
             ,   "uint", 5            ; ImageLockMode.UserInputBuffer | ImageLockMode.ReadOnly
             ,    "int", 0x26200A     ; Format32bppArgb
             ,    "ptr", BitmapData)

    ; Write pixels to buffer.
    DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

    ; Free the pixels later.
    buf := ImagePut.BitmapBuffer(ptr, size, width, height)
    buf.free := [() => DllCall("UnmapViewOfFile", "ptr", pMap), () => DllCall("CloseHandle", "ptr", hMap)]
    buf.name := name
    return buf
 }
