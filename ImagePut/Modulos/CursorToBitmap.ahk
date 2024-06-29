CursorToBitmap() {
   ; Thanks 23W - https://stackoverflow.com/a/13295280

   ; struct CURSORINFO - https://docs.microsoft.com/en-us/windows/win32/api/winuser/ns-winuser-cursorinfo
   ci := Buffer(16 + A_PtrSize, 0) ; sizeof(CURSORINFO) = 20, 24
   NumPut("int", ci.size, ci)
   DllCall("GetCursorInfo", "ptr", ci)
      ; cShow   := NumGet(ci,  4, "int") ; 0x1 = CURSOR_SHOWING, 0x2 = CURSOR_SUPPRESSED
      , hCursor := NumGet(ci, 8, "ptr")
   ; xCursor := NumGet(ci,  8+A_PtrSize, "int")
   ; yCursor := NumGet(ci, 12+A_PtrSize, "int")

   ; Cursors are the same as icons!
   pBitmap := HIconToBitmap(hCursor)

   ; Cleanup the handle to the cursor. Same as DestroyIcon.
   DllCall("DestroyCursor", "ptr", hCursor)

   return pBitmap
}