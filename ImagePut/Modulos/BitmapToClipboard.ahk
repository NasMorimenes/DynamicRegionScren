BitmapToClipboard(pBitmap) {
   ; Standard Clipboard Formats - https://www.codeproject.com/Reference/1091137/Windows-Clipboard-Formats
   ; Synthesized Clipboard Formats - https://docs.microsoft.com/en-us/windows/win32/dataxchg/clipboard-formats

   ; Open the clipboard with exponential backoff.
   loop
      if DllCall("OpenClipboard", "ptr", A_ScriptHwnd)
         break
      else
         if A_Index < 6
            Sleep (2 ** (A_Index - 1) * 30)
         else throw Error("Clipboard could not be opened.")

   ; Requires a valid window handle via OpenClipboard or the next call to OpenClipboard will crash.
   DllCall("EmptyClipboard")

   ; #1 - PNG holds the transparency and is the most widely supported image format.
   ; Thanks Jochen Arndt - https://www.codeproject.com/Answers/1207927/Saving-an-image-to-the-clipboard#answer3
   DllCall("ole32\CreateStreamOnHGlobal", "ptr", 0, "int", False, "ptr*", &stream := 0, "hresult")
   DllCall("ole32\CLSIDFromString", "wstr", "{557CF406-1A04-11D3-9A73-0000F81EF32E}", "ptr", pCodec := Buffer(16), "hresult")
   DllCall("gdiplus\GdipSaveImageToStream", "ptr", pBitmap, "ptr", stream, "ptr", pCodec, "ptr", 0)

   ; Set the rescued HGlobal to the clipboard as a shared object.
   DllCall("ole32\GetHGlobalFromStream", "ptr", stream, "uint*", &handle := 0, "hresult")
   ObjRelease(stream)

   ; Set the clipboard data. GlobalFree will be called by the system.
   png := DllCall("RegisterClipboardFormat", "str", "png", "uint") ; case insensitive
   DllCall("SetClipboardData", "uint", png, "ptr", handle)


   ; #2 - Fallback to the CF_DIB format (bottom-up bitmap) for maximum compatibility.
   ; Thanks tic - https://www.autohotkey.com/boards/viewtopic.php?t=6517
   DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "ptr", pBitmap, "ptr*", &hbm := 0, "uint", 0)

   ; struct DIBSECTION - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-dibsection
   ; struct BITMAP - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmap
   dib := Buffer(64 + 5 * A_PtrSize) ; sizeof(DIBSECTION) = 84, 104
   DllCall("GetObject", "ptr", hbm, "int", dib.size, "ptr", dib)
      , pBits := NumGet(dib, A_PtrSize = 4 ? 20 : 24, "ptr")  ; bmBits
      , size := NumGet(dib, A_PtrSize = 4 ? 44 : 52, "uint") ; biSizeImage

   ; Allocate space for a new device independent bitmap on movable memory.
   hdib := DllCall("GlobalAlloc", "uint", 0x2, "uptr", 40 + size, "ptr") ; sizeof(BITMAPINFOHEADER) = 40
   pdib := DllCall("GlobalLock", "ptr", hdib, "ptr")

   ; Copy the BITMAPINFOHEADER and pixel data respectively.
   DllCall("RtlMoveMemory", "ptr", pdib, "ptr", dib.ptr + (A_PtrSize = 4 ? 24 : 32), "uptr", 40)
   DllCall("RtlMoveMemory", "ptr", pdib + 40, "ptr", pBits, "uptr", size)

   ; Unlock to moveable memory because the clipboard requires it.
   DllCall("GlobalUnlock", "ptr", hdib)
   DllCall("DeleteObject", "ptr", hbm)

   ; CF_DIB (8) can be synthesized into CF_DIBV5 (17) and CF_BITMAP (2) with delayed rendering.
   DllCall("SetClipboardData", "uint", 8, "ptr", hdib)

   ; Close the clipboard.
   DllCall("CloseClipboard")
   return ClipboardAll()
}