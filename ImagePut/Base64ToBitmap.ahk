; Base64ToBitmap.ahk

Base64ToBitmap(base64) {
    ; Create Stream
    Stream := DllCall(
        "ole32\CreateStreamOnHGlobal", 
        "Ptr", 0, "Int", True, "Ptr*", pStream
    )
    
    ; Write to Stream
    DllCall(
        "ole32\CoTaskMemAlloc", 
        "UInt", StrLen(base64) // 4 * 3, 
        "Ptr*", pMem
    )
    DllCall(
        "msvcrt\memcpy", 
        "Ptr", pMem, 
        "AStr", base64, 
        "UInt", StrLen(base64) // 4 * 3
    )
    DllCall(
        "ole32\CoTaskMemFree", 
        "Ptr", pMem
    )
    
    ; Create Bitmap
    pBitmap := DllCall(
        "gdiplus\GdipCreateBitmapFromStream", 
        "Ptr", pStream, "Ptr*"
    )
    return pBitmap
}