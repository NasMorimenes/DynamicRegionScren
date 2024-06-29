; Base64ToStream.ahk

Base64ToStream(base64) {
    ; Allocate memory
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
    
    ; Create Stream
    Stream := DllCall(
        "ole32\CreateStreamOnHGlobal", 
        "Ptr", pMem, 
        "Int", True, 
        "Ptr*", pStream
    )
    return pStream
}