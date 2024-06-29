read_screen() {

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
      DllCall("DXGI\CreateDXGIFactory1", "ptr", IID_IDXGIFactory1, "ptr*", &IDXGIFactory1 := 0, "hresult")
      return IDXGIFactory1
   }

   ; Get monitor?
   loop {
      ComCall(EnumAdapters := 7, IDXGIFactory, "uint", A_Index - 1, "ptr*", &IDXGIAdapter := 0)

      loop {
         try ComCall(EnumOutputs := 7, IDXGIAdapter, "uint", A_Index - 1, "ptr*", &IDXGIOutput := 0)
         catch OSError as e
            if e.number = 0x887A0002 ; DXGI_ERROR_NOT_FOUND
               break
            else throw

         ComCall(GetDesc := 7, IDXGIOutput, "ptr", DXGI_OUTPUT_DESC := Buffer(88 + A_PtrSize, 0))
         Width := NumGet(DXGI_OUTPUT_DESC, 72, "int")
         Height := NumGet(DXGI_OUTPUT_DESC, 76, "int")
         AttachedToDesktop := NumGet(DXGI_OUTPUT_DESC, 80, "int")
         if (AttachedToDesktop = 1)
            break 2
      }
   }

   ; Ensure the desktop is connected.
   assert AttachedToDesktop, "No adapter attached to desktop."

   ; Load direct3d
   DllCall("D3D11\D3D11CreateDevice"
      , "ptr", IDXGIAdapter                 ; pAdapter
      , "int", D3D_DRIVER_TYPE_UNKNOWN := 0 ; DriverType
      , "ptr", 0                            ; Software
      , "uint", 0                            ; Flags
      , "ptr", 0                            ; pFeatureLevels
      , "uint", 0                            ; FeatureLevels
      , "uint", D3D11_SDK_VERSION := 7       ; SDKVersion
      , "ptr*", &d3d_device := 0               ; ppDevice
      , "ptr*", 0                            ; pFeatureLevel
      , "ptr*", &d3d_context := 0              ; ppImmediateContext
      , "hresult")

   ; Retrieve the desktop duplication API
   IDXGIOutput1 := ComObjQuery(IDXGIOutput, "{00cddea8-939b-4b83-a340-a685226666cc}")
   ComCall(DuplicateOutput := 22, IDXGIOutput1, "ptr", d3d_device, "ptr*", &Duplication := 0)
   ComCall(GetDesc := 7, Duplication, "ptr", DXGI_OUTDUPL_DESC := Buffer(36, 0))
   DesktopImageInSystemMemory := NumGet(DXGI_OUTDUPL_DESC, 32, "uint")
   Sleep 50   ; As I understand - need some sleep for successful connecting to IDXGIOutputDuplication interface

   ; Create the texture onto which the desktop will be copied to.
   D3D11_TEXTURE2D_DESC := Buffer(44, 0)
   NumPut("uint", width, D3D11_TEXTURE2D_DESC, 0)   ; Width
   NumPut("uint", height, D3D11_TEXTURE2D_DESC, 4)   ; Height
   NumPut("uint", 1, D3D11_TEXTURE2D_DESC, 8)   ; MipLevels
   NumPut("uint", 1, D3D11_TEXTURE2D_DESC, 12)   ; ArraySize
   NumPut("uint", DXGI_FORMAT_B8G8R8A8_UNORM := 87, D3D11_TEXTURE2D_DESC, 16)   ; Format
   NumPut("uint", 1, D3D11_TEXTURE2D_DESC, 20)   ; SampleDescCount
   NumPut("uint", 0, D3D11_TEXTURE2D_DESC, 24)   ; SampleDescQuality
   NumPut("uint", D3D11_USAGE_STAGING := 3, D3D11_TEXTURE2D_DESC, 28)   ; Usage
   NumPut("uint", 0, D3D11_TEXTURE2D_DESC, 32)   ; BindFlags
   NumPut("uint", D3D11_CPU_ACCESS_READ := 0x20000, D3D11_TEXTURE2D_DESC, 36)   ; CPUAccessFlags
   NumPut("uint", 0, D3D11_TEXTURE2D_DESC, 40)   ; MiscFlags
   ComCall(CreateTexture2D := 5, d3d_device, "ptr", D3D11_TEXTURE2D_DESC, "ptr", 0, "ptr*", &staging_tex := 0)


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
            try ComCall(AcquireNextFrame := 8, Duplication, "uint", 0, "ptr", DXGI_OUTDUPL_FRAME_INFO, "ptr*", &desktop_resource := 0)
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
         try ComCall(AcquireNextFrame := 8, Duplication, "uint", timeout, "ptr", DXGI_OUTDUPL_FRAME_INFO, "ptr*", &desktop_resource := 0)
         catch OSError as e
            if e.number = 0x887A0027 ; DXGI_ERROR_WAIT_TIMEOUT
               return this ; Remember to enable method chaining.
            else throw

         if NumGet(DXGI_OUTDUPL_FRAME_INFO, 0, "int64") = 0
            return this ; Remember to enable method chaining.
      }

      ; map new resources.
      if (DesktopImageInSystemMemory = 1) {
         static DXGI_MAPPED_RECT := Buffer(A_PtrSize * 2, 0)
         ComCall(MapDesktopSurface := 12, Duplication, "ptr", DXGI_MAPPED_RECT)
         pitch := NumGet(DXGI_MAPPED_RECT, 0, "int")
         pBits := NumGet(DXGI_MAPPED_RECT, A_PtrSize, "ptr")
      }
      else {
         tex := ComObjQuery(desktop_resource, "{6f15aaf2-d208-4e89-9ab4-489535d34f9c}") ; ID3D11Texture2D
         ComCall(CopyResource := 47, d3d_context, "ptr", staging_tex, "ptr", tex)
         static D3D11_MAPPED_SUBRESOURCE := Buffer(8 + A_PtrSize, 0)
         ComCall(_Map := 14, d3d_context, "ptr", staging_tex, "uint", 0, "uint", D3D11_MAP_READ := 1, "uint", 0, "ptr", D3D11_MAPPED_SUBRESOURCE)
         pBits := NumGet(D3D11_MAPPED_SUBRESOURCE, 0, "ptr")
         pitch := NumGet(D3D11_MAPPED_SUBRESOURCE, A_PtrSize, "uint")
      }

      ptr := pBits
      size := pitch * height

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

   return { x: x, y: y, width: width,
      height: height,
      Update: Update,
      Cleanup: Cleanup }.update() ; init ptr && size.
}