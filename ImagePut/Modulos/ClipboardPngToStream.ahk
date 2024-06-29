ClipboardPngToStream() {
   ; Open the clipboard with exponential backoff.
   loop
      if DllCall("OpenClipboard", "ptr", A_ScriptHwnd)
         break
      else
         if A_Index < 6
            Sleep (2 ** (A_Index - 1) * 30)
         else throw Error("Clipboard could not be opened.")

   png := DllCall("RegisterClipboardFormat", "str", "png", "uint")
   if !DllCall("IsClipboardFormatAvailable", "uint", png)
      throw Error("Clipboard does not have PNG stream data.")

   if !(handle := DllCall("GetClipboardData", "uint", png, "ptr"))
      throw Error("Shared clipboard PNG has been deleted.")

   ; Create a new stream from the clipboard data.
   size := DllCall("GlobalSize", "ptr", handle, "uptr")
   DllCall("ole32\CreateStreamOnHGlobal", "ptr", handle, "int", False, "ptr*", &PngStream := 0, "hresult")
   DllCall("ole32\CreateStreamOnHGlobal", "ptr", 0, "int", True, "ptr*", &stream := 0, "hresult")
   DllCall("shlwapi\IStream_Copy", "ptr", PngStream, "ptr", stream, "uint", size, "hresult")

   DllCall("CloseClipboard")
   return stream
}