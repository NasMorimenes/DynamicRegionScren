
static ClipboardPngToStream() {
    ; Open the clipboard with exponential backoff.
    loop
       if DllCall("OpenClipboard", "ptr", A_ScriptHwnd)
          break
       else
          if A_Index < 6
             Sleep (2**(A_Index-1) * 30)
          else throw Error("Clipboard could not be opened.")

    png := DllCall("RegisterClipboardFormat", "str", "png", "uint")
    if !DllCall("IsClipboardFormatAvailable", "uint", png)
       throw Error("Clipboard does not have PNG stream data.")

    if !(handle := DllCall("GetClipboardData", "uint", png, "ptr"))
       throw Error("Shared clipboard PNG has been deleted.")

    ; Create a new stream from the clipboard data.
    size := DllCall("GlobalSize", "ptr", handle, "uptr")
    DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", False, "ptr*", &PngStream:=0, "hresult")
    DllCall("ole32\CreateStreamOnHGlobal", "ptr", 0, "int", True, "ptr*", &stream:=0, "hresult")
    DllCall("shlwapi\IStream_Copy", "ptr", PngStream, "ptr", stream, "uint", size, "hresult")

    DllCall("CloseClipboard")
    return stream
 }

 static SafeArrayToBitmap(image) {
    stream := this.SafeArrayToStream(image)
    DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap:=0)
    ObjRelease(stream)
    return pBitmap
 }

 static SafeArrayToStream(image) {
    ; Expects a 1-D safe array of bytes. (VT_UI1)
    size := image.MaxIndex()
    pvData := NumGet(ComObjValue(image), 8 + A_PtrSize, "ptr")

    ; Copy data to a new stream.
    handle := DllCall("GlobalAlloc", "uint", 0x2, "uptr", size, "ptr")
    ptr := DllCall("GlobalLock", "ptr", handle, "ptr")
    DllCall("RtlMoveMemory", "ptr", ptr, "ptr", pvData, "uptr", size)
    DllCall("GlobalUnlock", "ptr", handle)
    DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", True, "ptr*", &stream:=0, "hresult")
    return stream
 }

 static EncodedBufferToBitmap(image) {
    stream := this.EncodedBufferToStream(image)
    DllCall("gdiplus\GdipCreateBitmapFromStreamICM", "ptr", stream, "ptr*", &pBitmap:=0)
    ObjRelease(stream)
    return pBitmap
 }

 static EncodedBufferToStream(image) {
    handle := DllCall("GlobalAlloc", "uint", 0x2, "uptr", image.size, "ptr")
    ptr := DllCall("GlobalLock", "ptr", handle, "ptr")
    DllCall("RtlMoveMemory", "ptr", ptr, "ptr", image.ptr, "uptr", image.size)
    DllCall("GlobalUnlock", "ptr", handle)
    DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", True, "ptr*", &stream:=0, "hresult")
    return stream
 }

 static BufferToBitmap(image) {

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
       , "int", stride, "int", 0x26200A, "ptr", image.ptr, "ptr*", &pBitmap:=0)
    else            ; bottom-up bitmap
       DllCall("gdiplus\GdipCreateBitmapFromScan0", "int", width, "int", height
       , "int", -stride, "int", 0x26200A, "ptr", image.ptr + (height-1)*stride, "ptr*", &pBitmap:=0)

    return pBitmap
 }


static read_screen() {

    assert(statement, message) {
       if !statement
          throw ValueError(message, -1, statement)
    }

    ; Load DirectX
    assert IDXGIFactory := CreateDXGIFactory(), "Create IDXGIFactory failed."

    CreateDXGIFactory() {
       if !DllCall("GetModuleHandle", "str", "DXGI")
          DllCall("LoadLibrary", "str", "DXGI")
       if !DllCall("GetModuleHandle", "str", "D3D11")
          DllCall("LoadLibrary", "str", "D3D11")

       IID_IDXGIFactory1 := Buffer(16)
       DllCall("ole32\IIDFromString", "wstr", "{770aae78-f26f-4dba-a829-253c83d1b387}", "ptr", IID_IDXGIFactory1, "hresult")
       DllCall("DXGI\CreateDXGIFactory1", "ptr", IID_IDXGIFactory1, "ptr*", &IDXGIFactory1:=0, "hresult")
       return IDXGIFactory1
    }

    ; Get monitor?
    loop {
       ComCall(EnumAdapters := 7, IDXGIFactory, "uint", A_Index-1, "ptr*", &IDXGIAdapter:=0)

       loop {
          try ComCall(EnumOutputs := 7, IDXGIAdapter, "uint", A_Index-1, "ptr*", &IDXGIOutput:=0)
          catch OSError as e
             if e.number = 0x887A0002 ; DXGI_ERROR_NOT_FOUND
                break
             else throw

          ComCall(GetDesc := 7, IDXGIOutput, "ptr", DXGI_OUTPUT_DESC := Buffer(88+A_PtrSize, 0))
          Width             := NumGet(DXGI_OUTPUT_DESC, 72, "int")
          Height            := NumGet(DXGI_OUTPUT_DESC, 76, "int")
          AttachedToDesktop := NumGet(DXGI_OUTPUT_DESC, 80, "int")
          if (AttachedToDesktop = 1)
             break 2
       }
    }

    ; Ensure the desktop is connected.
    assert AttachedToDesktop, "No adapter attached to desktop."

    ; Load direct3d
    DllCall("D3D11\D3D11CreateDevice"
             ,    "ptr", IDXGIAdapter                 ; pAdapter
             ,    "int", D3D_DRIVER_TYPE_UNKNOWN := 0 ; DriverType
             ,    "ptr", 0                            ; Software
             ,   "uint", 0                            ; Flags
             ,    "ptr", 0                            ; pFeatureLevels
             ,   "uint", 0                            ; FeatureLevels
             ,   "uint", D3D11_SDK_VERSION := 7       ; SDKVersion
             ,   "ptr*", &d3d_device:=0               ; ppDevice
             ,   "ptr*", 0                            ; pFeatureLevel
             ,   "ptr*", &d3d_context:=0              ; ppImmediateContext
             ,"hresult")

    ; Retrieve the desktop duplication API
    IDXGIOutput1 := ComObjQuery(IDXGIOutput, "{00cddea8-939b-4b83-a340-a685226666cc}")
    ComCall(DuplicateOutput := 22, IDXGIOutput1, "ptr", d3d_device, "ptr*", &Duplication:=0)
    ComCall(GetDesc := 7, Duplication, "ptr", DXGI_OUTDUPL_DESC := Buffer(36, 0))
    DesktopImageInSystemMemory := NumGet(DXGI_OUTDUPL_DESC, 32, "uint")
    Sleep 50   ; As I understand - need some sleep for successful connecting to IDXGIOutputDuplication interface

    ; Create the texture onto which the desktop will be copied to.
    D3D11_TEXTURE2D_DESC := Buffer(44, 0)
       NumPut("uint",                            width, D3D11_TEXTURE2D_DESC,  0)   ; Width
       NumPut("uint",                           height, D3D11_TEXTURE2D_DESC,  4)   ; Height
       NumPut("uint",                                1, D3D11_TEXTURE2D_DESC,  8)   ; MipLevels
       NumPut("uint",                                1, D3D11_TEXTURE2D_DESC, 12)   ; ArraySize
       NumPut("uint", DXGI_FORMAT_B8G8R8A8_UNORM := 87, D3D11_TEXTURE2D_DESC, 16)   ; Format
       NumPut("uint",                                1, D3D11_TEXTURE2D_DESC, 20)   ; SampleDescCount
       NumPut("uint",                                0, D3D11_TEXTURE2D_DESC, 24)   ; SampleDescQuality
       NumPut("uint",         D3D11_USAGE_STAGING := 3, D3D11_TEXTURE2D_DESC, 28)   ; Usage
       NumPut("uint",                                0, D3D11_TEXTURE2D_DESC, 32)   ; BindFlags
       NumPut("uint", D3D11_CPU_ACCESS_READ := 0x20000, D3D11_TEXTURE2D_DESC, 36)   ; CPUAccessFlags
       NumPut("uint",                                0, D3D11_TEXTURE2D_DESC, 40)   ; MiscFlags
    ComCall(CreateTexture2D := 5, d3d_device, "ptr", D3D11_TEXTURE2D_DESC, "ptr", 0, "ptr*", &staging_tex:=0)


    ; Persist the concept of a desktop_resource as a closure???
    local desktop_resource

    Update(this, timeout := unset) {
       ; Unbind resources.
       Unbind()

       ; Allocate a shared buffer for all calls of AcquireNextFrame.
       static DXGI_OUTDUPL_FRAME_INFO := Buffer(48, 0)

       if !IsSet(timeout) {
          ; The following loop structure repeatedly checks for a new frame.
          loop {
             ; Ask if there is a new frame available immediately.
             try ComCall(AcquireNextFrame := 8, Duplication, "uint", 0, "ptr", DXGI_OUTDUPL_FRAME_INFO, "ptr*", &desktop_resource:=0)
             catch OSError as e
                if e.number = 0x887A0027 ; DXGI_ERROR_WAIT_TIMEOUT
                   continue
                else throw

             ; Exclude mouse movement events by ensuring LastPresentTime is greater than zero.
             if NumGet(DXGI_OUTDUPL_FRAME_INFO, 0, "int64") > 0
                break

             ; Continue the loop by releasing resources.
             ObjRelease(desktop_resource)
             ComCall(ReleaseFrame := 14, Duplication)
          }
       } else {
          try ComCall(AcquireNextFrame := 8, Duplication, "uint", timeout, "ptr", DXGI_OUTDUPL_FRAME_INFO, "ptr*", &desktop_resource:=0)
          catch OSError as e
             if e.number = 0x887A0027 ; DXGI_ERROR_WAIT_TIMEOUT
                return this ; Remember to enable method chaining.
             else throw

          if NumGet(DXGI_OUTDUPL_FRAME_INFO, 0, "int64") = 0
             return this ; Remember to enable method chaining.
       }

       ; map new resources.
       if (DesktopImageInSystemMemory = 1) {
          static DXGI_MAPPED_RECT := Buffer(A_PtrSize*2, 0)
          ComCall(MapDesktopSurface := 12, Duplication, "ptr", DXGI_MAPPED_RECT)
          pitch := NumGet(DXGI_MAPPED_RECT, 0, "int")
          pBits := NumGet(DXGI_MAPPED_RECT, A_PtrSize, "ptr")
       }
       else {
          tex := ComObjQuery(desktop_resource, "{6f15aaf2-d208-4e89-9ab4-489535d34f9c}") ; ID3D11Texture2D
          ComCall(CopyResource := 47, d3d_context, "ptr", staging_tex, "ptr", tex)
          static D3D11_MAPPED_SUBRESOURCE := Buffer(8+A_PtrSize, 0)
          ComCall(_Map := 14, d3d_context, "ptr", staging_tex, "uint", 0, "uint", D3D11_MAP_READ := 1, "uint", 0, "ptr", D3D11_MAPPED_SUBRESOURCE)
          pBits := NumGet(D3D11_MAPPED_SUBRESOURCE, 0, "ptr")
          pitch := NumGet(D3D11_MAPPED_SUBRESOURCE, A_PtrSize, "uint")
       }

       this.ptr := pBits
       this.size := pitch * height

       ; Remember to enable method chaining.
       return this
    }

    Unbind() {
       if IsSet(desktop_resource) && desktop_resource != 0 {
          if (DesktopImageInSystemMemory = 1)
             ComCall(UnMapDesktopSurface := 13, Duplication)
          else
             ComCall(Unmap := 15, d3d_context, "ptr", staging_tex, "uint", 0)

          ObjRelease(desktop_resource)
          ComCall(ReleaseFrame := 14, Duplication)
       }
    }

    Cleanup(this) {
       Unbind()
       ObjRelease(staging_tex)
       ObjRelease(duplication)
       ObjRelease(d3d_context)
       ObjRelease(d3d_device)
       IDXGIOutput1 := ""
       ObjRelease(IDXGIOutput)
       ObjRelease(IDXGIAdapter)
       ObjRelease(IDXGIFactory)
    }

    ; Get true virtual screen coordinates.
    try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    x := DllCall("GetSystemMetrics", "int", 76, "int")
    y := DllCall("GetSystemMetrics", "int", 77, "int")
    width := DllCall("GetSystemMetrics", "int", 78, "int")
    height := DllCall("GetSystemMetrics", "int", 79, "int")
    try DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")

    return {x:x, y:y, width: width,
       height: height,
       Update: Update,
    Cleanup : Cleanup}.update() ; init ptr && size.
 }

 static Screenshot2ToBitmap(image) {
    obj := this.read_screen()

    width := obj.width
    height := obj.height
    pBits := obj.ptr
    size := obj.size

    ; Create a destination GDI+ Bitmap that owns its memory. The pixel format is 32-bit pre-multiplied ARGB.
    DllCall("gdiplus\GdipCreateBitmapFromScan0"
             , "int", width, "int", height, "uint", size / height, "uint", 0xE200B, "ptr", 0, "ptr*", &pBitmap:=0)

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

    ; Convert the pARGB pixels copied into the device independent bitmap (hbm) to ARGB.
    DllCall("gdiplus\GdipBitmapUnlockBits", "ptr", pBitmap, "ptr", BitmapData)

    return pBitmap
 }

 static ScreenshotToBitmap(image) {
    ; Thanks tic - https://www.autohotkey.com/boards/viewtopic.php?t=6517

    ; Allow the image to be a window handle.
    if !IsObject(image) and WinExist(image) {
       try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
       WinGetClientPos &x, &y, &w, &h, image
       try DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")
       image := [x, y, w, h]
    }




    ; Adjust coordinates relative to specified window.
    if image.Has(5) and WinExist(image[5]) {
       try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
       WinGetClientPos &xr, &yr,,, image[5]
       try DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")
       image[1] += xr
       image[2] += yr
    }




    ; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
    hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
    bi := Buffer(40, 0)                    ; sizeof(bi) = 40
       NumPut(  "uint",        40, bi,  0) ; Size
       NumPut(   "int",  image[3], bi,  4) ; Width
       NumPut(   "int", -image[4], bi,  8) ; Height - Negative so (0, 0) is top-left.
       NumPut("ushort",         1, bi, 12) ; Planes
       NumPut("ushort",        32, bi, 14) ; BitCount / BitsPerPixel
    hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", bi, "uint", 0, "ptr*", &pBits:=0, "ptr", 0, "uint", 0, "ptr")
    obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")

    ; Retrieve the device context for the screen.
    sdc := DllCall("GetDC", "ptr", 0, "ptr")

    ; Copies a portion of the screen to a new device context.
    DllCall("gdi32\BitBlt"
             , "ptr", hdc, "int", 0, "int", 0, "int", image[3], "int", image[4]
             , "ptr", sdc, "int", image[1], "int", image[2], "uint", 0x00CC0020 | 0x40000000) ; SRCCOPY | CAPTUREBLT

    ; Release the device context to the screen.
    DllCall("ReleaseDC", "ptr", 0, "ptr", sdc)

    ; Convert the hBitmap to a Bitmap using a built in function as there is no transparency.
    DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hbm, "ptr", 0, "ptr*", &pBitmap:=0)

    ; Cleanup the hBitmap and device contexts.
    DllCall("SelectObject", "ptr", hdc, "ptr", obm)
    DllCall("DeleteObject", "ptr", hbm)
    DllCall("DeleteDC",     "ptr", hdc)

    return pBitmap
 }

 static WindowToBitmap(image) {
    ; Thanks tic - https://www.autohotkey.com/boards/viewtopic.php?t=6517

    ; Get the handle to the window.
    image := WinExist(image)

    ; Test whether keystrokes can be sent to this window using a reserved virtual key code.
    try PostMessage WM_KEYDOWN := 0x100, 0x88,,, image
    catch OSError
       throw Error("Administrator privileges are required to capture the window.")
    PostMessage WM_KEYUP := 0x101, 0x88, 0xC0000000,, image

    ; Restore the window if minimized! Must be visible for capture.
    if DllCall("IsIconic", "ptr", image)
       DllCall("ShowWindow", "ptr", image, "int", 4)

    ; Get the width and height of the client window.
    try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    DllCall("GetClientRect", "ptr", image, "ptr", Rect := Buffer(16)) ; sizeof(RECT) = 16
       , width  := NumGet(Rect, 8, "int")
       , height := NumGet(Rect, 12, "int")
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

    ; Print the window onto the hBitmap using an undocumented flag. https://stackoverflow.com/a/40042587
    DllCall("user32\PrintWindow", "ptr", image, "ptr", hdc, "uint", 0x3) ; PW_RENDERFULLCONTENT | PW_CLIENTONLY
    ; Additional info on how this is implemented: https://www.reddit.com/r/windows/comments/8ffr56/altprintscreen/

    ; Convert the hBitmap to a Bitmap using a built in function as there is no transparency.
    DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hbm, "ptr", 0, "ptr*", &pBitmap:=0)

    ; Cleanup the hBitmap and device contexts.
    DllCall("SelectObject", "ptr", hdc, "ptr", obm)
    DllCall("DeleteObject", "ptr", hbm)
    DllCall("DeleteDC",     "ptr", hdc)

    return pBitmap
 }

 static DesktopToBitmap() {
    ; Find the child window.
    windows := WinGetList("ahk_class WorkerW")
    if (windows.length == 0)
       throw Error("The hidden desktop window has not been initalized. Call ImagePutDesktop() first.")

    loop windows.length
       hwnd := windows[A_Index]
    until DllCall("FindWindowEx", "ptr", hwnd, "ptr", 0, "str", "SHELLDLL_DefView", "ptr", 0)

    ; Maybe this hack gets patched. Tough luck!
    if !(WorkerW := DllCall("FindWindowEx", "ptr", 0, "ptr", hwnd, "str", "WorkerW", "ptr", 0, "ptr"))
       throw Error("Could not locate hidden window behind desktop.")

    ; Get the width and height of the client window.
    try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    DllCall("GetClientRect", "ptr", WorkerW, "ptr", Rect := Buffer(16)) ; sizeof(RECT) = 16
       , width  := NumGet(Rect, 8, "int")
       , height := NumGet(Rect, 12, "int")
    try DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")

    ; Get device context of spawned window.
    sdc := DllCall("GetDCEx", "ptr", WorkerW, "ptr", 0, "int", 0x403, "ptr") ; LockWindowUpdate | Cache | Window

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

    ; Copies a portion of the hidden window to a new device context.
    DllCall("gdi32\BitBlt"
             , "ptr", hdc, "int", 0, "int", 0, "int", width, "int", height
             , "ptr", sdc, "int", 0, "int", 0, "uint", 0x00CC0020) ; SRCCOPY

    ; Convert the hBitmap to a Bitmap using a built in function as there is no transparency.
    DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hbm, "ptr", 0, "ptr*", &pBitmap:=0)

    ; Cleanup the hBitmap and device contexts.
    DllCall("SelectObject", "ptr", hdc, "ptr", obm)
    DllCall("DeleteObject", "ptr", hbm)
    DllCall("DeleteDC",     "ptr", hdc)

    ; Release device context of spawned window.
    DllCall("ReleaseDC", "ptr", 0, "ptr", sdc)

    return pBitmap
 }
