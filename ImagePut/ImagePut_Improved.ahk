
; Script:    ImagePut.ahk
; License:   MIT License
; Author:    Edison Hua (iseahound)
; Github:    https://github.com/iseahound/ImagePut
; Date:      2023-03-02
; Version:   1.10

#Requires AutoHotkey v2.0-beta.13+

; Function: ImagePutBase64
; Description: Converts the image into a base64 encoded string.
; Parameters:
;   image       - Image to be processed.
;   extension   - File encoding type (bmp, gif, jpg, png, tiff).
;   quality     - JPEG quality level (0-100).
; Returns: Base64 encoded string of the image.
ImagePutBase64(image, extension := "", quality := "") {
    if !IsObject(image) {
        MsgBox "Invalid image object"
        return
    }
    if !InStr("bmp,gif,jpg,png,tiff", extension) {
        MsgBox "Invalid extension"
        return
    }
    if (extension = "jpg" && (quality < 0 || quality > 100)) {
        MsgBox "Quality must be between 0 and 100"
        return
    }
    return ImagePut("base64", image, extension, quality)
}

; Function: ImagePutBitmap
; Description: Converts the image into a GDI+ Bitmap and returns a pointer.
; Parameters:
;   image - Image to be processed.
; Returns: Pointer to the GDI+ Bitmap.
ImagePutBitmap(image) {
    if !IsObject(image) {
        MsgBox "Invalid image object"
        return
    }
    return ImagePut("bitmap", image)
}

; Function: ImagePutBuffer
; Description: Converts the image into a GDI+ Bitmap and returns a buffer object with GDI+ scope.
; Parameters:
;   image - Image to be processed.
; Returns: Buffer object with GDI+ scope.
ImagePutBuffer(image) {
    if !IsObject(image) {
        MsgBox "Invalid image object"
        return
    }
    return ImagePut("buffer", image)
}

; Function: ImagePutClipboard
; Description: Places the image onto the clipboard and returns ClipboardAll().
; Parameters:
;   image - Image to be processed.
; Returns: ClipboardAll() containing the image.
ImagePutClipboard(image) {
    if !IsObject(image) {
        MsgBox "Invalid image object"
        return
    }
    return ImagePut("clipboard", image)
}

; Function: ImagePutCursor
; Description: Places the image as the cursor and returns the variable A_Cursor.
; Parameters:
;   image     - Image to be processed.
;   xHotspot  - X click point (0 - width).
;   yHotspot  - Y click point (0 - height).
; Returns: Variable A_Cursor with the new cursor.
ImagePutCursor(image, xHotspot := "", yHotspot := "") {
    if !IsObject(image) {
        MsgBox "Invalid image object"
        return
    }
    if (xHotspot != "" && (xHotspot < 0 || xHotspot > image.Width)) {
        MsgBox "Invalid xHotspot"
        return
    }
    if (yHotspot != "" && (yHotspot < 0 || yHotspot > image.Height)) {
        MsgBox "Invalid yHotspot"
        return
    }
    return ImagePut("cursor", image, xHotspot, yHotspot)
}

; Function: ImagePutDC
; Description: Places the image onto a device context and returns the handle.
; Parameters:
;   image - Image to be processed.
;   alpha - Alpha replacement color (RGB).
; Returns: Handle to the device context.
ImagePutDC(image, alpha := "") {
    if !IsObject(image) {
        MsgBox "Invalid image object"
        return
    }
    return ImagePut("dc", image, alpha)
}

; Function: ImagePutDesktop
; Description: Places the image behind the desktop icons and returns the string "desktop".
; Parameters:
;   image - Image to be processed.
; Returns: String "desktop".
ImagePutDesktop(image) {
    if !IsObject(image) {
        MsgBox "Invalid image object"
        return
    }
    return ImagePut("desktop", image)
}

; Function: ImagePutEncodedBuffer
; Description: Converts the image into an encoded format and returns a binary data object.
; Parameters:
;   image     - Image to be processed.
;   extension - File encoding type (bmp, gif, jpg, png, tiff).
;   quality   - JPEG quality level (0-100).
; Returns: Binary data object with the encoded image.
ImagePutEncodedBuffer(image, extension := "", quality := "") {
    if !IsObject(image) {
        MsgBox "Invalid image object"
        return
    }
    if !InStr("bmp,gif,jpg,png,tiff", extension) {
        MsgBox "Invalid extension"
        return
    }
    if (extension = "jpg" && (quality < 0 || quality > 100)) {
        MsgBox "Quality must be between 0 and 100"
        return
    }
    return ImagePut("EncodedBuffer", image, extension, quality)
}

; Function: ImagePut
; Description: Generic function for image processing.
; Parameters:
;   type      - Type of processing (base64, bitmap, buffer, clipboard, cursor, dc, desktop, EncodedBuffer).
;   image     - Image to be processed.
;   options   - Additional options depending on the type.
; Returns: Processed image based on the type and options.
ImagePut(type, image, options*) {
    ; Implementation of ImagePut function.
}
