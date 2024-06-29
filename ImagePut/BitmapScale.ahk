; BitmapScale.ahk

BitmapScale(pBitmap, width, height) {
    ; Get Graphics From Image
    Graphics := DllCall(
        "gdiplus\GdipGetImageGraphicsContext", 
        "Ptr", pBitmap, "Ptr*"
    )
    
    ; Create New Bitmap
    pNewBitmap := DllCall(
        "gdiplus\GdipCreateBitmapFromScan0", 
        "Int", width, "Int", height, "Int", 0, "Int", 0x26200A, "Ptr", 0, "Ptr*"
    )
    
    ; Get Graphics From New Bitmap
    pGraphics := DllCall(
        "gdiplus\GdipGetImageGraphicsContext", 
        "Ptr", pNewBitmap, "Ptr*"
    )
    
    ; Draw Image
    DllCall(
        "gdiplus\GdipDrawImageRect", 
        "Ptr", pGraphics, "Ptr", pBitmap, 
        "Float", 0, "Float", 0, 
        "Float", width, "Float", height
    )
    
    return pNewBitmap
}