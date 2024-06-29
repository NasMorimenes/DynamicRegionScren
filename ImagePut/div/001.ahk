; Script:    ImagePut.ahk
; License:   MIT License
; Author:    Edison Hua (iseahound)
; Github:    https://github.com/iseahound/ImagePut
; Date:      2023-03-02
; Version:   1.10

#Requires AutoHotkey v2.0-beta.13+


; Puts the image into a file format and returns a base64 encoded string.
;   extension  -  File Encoding           |  string   ->   bmp, gif, jpg, png, tiff
;   quality    -  JPEG Quality Level      |  integer  ->   0 - 100
ImagePutBase64(image, extension := "", quality := "") {
   return ImagePut("base64", image, extension, quality)
}

; Puts the image into a GDI+ Bitmap and returns a pointer.
ImagePutBitmap(image) {
   return ImagePut("bitmap", image)
}

; Puts the image into a GDI+ Bitmap and returns a buffer object with GDI+ scope.
ImagePutBuffer(image) {
   return ImagePut("buffer", image)
}

; Puts the image onto the clipboard and returns ClipboardAll().
ImagePutClipboard(image) {
   return ImagePut("clipboard", image)
}

; Puts the image as the cursor and returns the variable A_Cursor.
;   xHotspot   -  X Click Point           |  pixel    ->   0 - width
;   yHotspot   -  Y Click Point           |  pixel    ->   0 - height
ImagePutCursor(image, xHotspot := "", yHotspot := "") {
   return ImagePut("cursor", image, xHotspot, yHotspot)
}

; Puts the image onto a device context and returns the handle.
;   alpha      -  Alpha Replacement Color |  RGB      ->   0xFFFFFF
ImagePutDC(image, alpha := "") {
   return ImagePut("dc", image, alpha)
}

; Puts the image behind the desktop icons and returns the string "desktop".
ImagePutDesktop(image) {
   return ImagePut("desktop", image)
}

; Puts the image as an encoded format into a binary data object.
;   extension  -  File Encoding           |  string   ->   bmp, gif, jpg, png, tiff
;   quality    -  JPEG Quality Level      |  integer  ->   0 - 100
ImagePutEncodedBuffer(image, extension := "", quality := "") {
   return ImagePut("EncodedBuffer", image, extension, quality)
}

; Puts the image into the most recently active explorer window.
ImagePutExplorer(image, default := "") {
   return ImagePut("explorer", image, default)
}

; Puts the image into a file and returns its filepath.
;   filepath   -  Filepath + Extension    |  string   ->   *.bmp, *.gif, *.jpg, *.png, *.tiff
;   quality    -  JPEG Quality Level      |  integer  ->   0 - 100
ImagePutFile(image, filepath := "", quality := "") {
   return ImagePut("file", image, filepath, quality)
}

; Puts the image into a multipart/form-data in binary and returns a SafeArray COM Object.
;   boundary   -  Content-Type            |  string   ->   multipart/form-data; boundary=something
ImagePutFormData(image, boundary := "--ImagePut abc 321 xyz--") {
   return ImagePut("formdata", image, boundary)
}

; Puts the image into a device independent bitmap and returns the handle.
;   alpha      -  Alpha Replacement Color |  RGB      ->   0xFFFFFF
ImagePutHBitmap(image, alpha := "") {
   return ImagePut("hBitmap", image, alpha)
}

; Puts the image into a file format and returns a hexadecimal encoded string.
;   extension  -  File Encoding           |  string   ->   bmp, gif, jpg, png, tiff
;   quality    -  JPEG Quality Level      |  integer  ->   0 - 100
ImagePutHex(image, extension := "", quality := "") {
   return ImagePut("hex", image, extension, quality)
}

; Puts the image into an icon and returns the handle.
ImagePutHIcon(image) {
   return ImagePut("hIcon", image)
}

; Puts the image into a file format and returns a pointer to a RandomAccessStream.
;   extension  -  File Encoding           |  string   ->   bmp, gif, jpg, png, tiff
;   quality    -  JPEG Quality Level      |  integer  ->   0 - 100
ImagePutRandomAccessStream(image, extension := "", quality := "") {
   return ImagePut("RandomAccessStream", image, extension, quality)
}

; Puts the image into a file format and returns a SafeArray COM Object.
;   extension  -  File Encoding           |  string   ->   bmp, gif, jpg, png, tiff
;   quality    -  JPEG Quality Level      |  integer  ->   0 - 100
ImagePutSafeArray(image, extension := "", quality := "") {
   return ImagePut("safeArray", image, extension, quality)
}

; Puts the image on the shared screen device context and returns an array of coordinates.
;   screenshot -  Screen Coordinates      |  array    ->   [x,y,w,h] or [0,0]
;   alpha      -  Alpha Replacement Color |  RGB      ->   0xFFFFFF
ImagePutScreenshot(image, screenshot := "", alpha := "") {
   return ImagePut("screenshot", image, screenshot, alpha)
}

; Puts the image into a file mapping and returns a buffer object sharable across processes.
;   name       -  Global Name             |  string   ->   "Alice"
ImagePutSharedBuffer(image, name := "") {
   return ImagePut("SharedBuffer", image, name)
}

; Puts the image into a file format and returns a pointer to a stream.
;   extension  -  File Encoding           |  string   ->   bmp, gif, jpg, png, tiff
;   quality    -  JPEG Quality Level      |  integer  ->   0 - 100
ImagePutStream(image, extension := "", quality := "") {
   return ImagePut("stream", image, extension, quality)
}

; Puts the image into a file format and returns a URI string.
;   extension  -  File Encoding           |  string   ->   bmp, gif, jpg, png, tiff
;   quality    -  JPEG Quality Level      |  integer  ->   0 - 100
ImagePutURI(image, extension := "", quality := "") {
   return ImagePut("uri", image, extension, quality)
}

; Puts the image as the desktop wallpaper and returns the string "wallpaper".
ImagePutWallpaper(image) {
   return ImagePut("wallpaper", image)
}

; Puts the image into a WICBitmap and returns the pointer to the interface.
ImagePutWICBitmap(image) {
   return ImagePut("wicBitmap", image)
}

; Puts the image in a window and returns a handle to a window.
;   title      -  Window Title            |  string   ->   MyTitle
;   pos        -  Window Coordinates      |  array    ->   [x,y,w,h] or [0,0]
;   style      -  Window Style            |  uint     ->   WS_VISIBLE
;   styleEx    -  Window Extended Style   |  uint     ->   WS_EX_LAYERED
;   parent     -  Window Parent           |  ptr      ->   hwnd
;   playback   -  Animate Window?         |  bool     ->   True
;   cache      -  Cache Animation Frames? |  bool     ->   False
ImagePutWindow(image, title := "", pos := "", style := 0x82C80000, styleEx := 0x9, parent := "", playback := True, cache := False) {
   return ImagePut("window", image, title, pos, style, styleEx, parent, playback, cache)
}


;   title      -  Window Title            |  string   ->   MyTitle
;   pos        -  Window Coordinates      |  array    ->   [x,y,w,h] or [0,0]
;   style      -  Window Style            |  uint     ->   WS_VISIBLE
;   styleEx    -  Window Extended Style   |  uint     ->   WS_EX_LAYERED
;   parent     -  Window Parent           |  ptr      ->   hwnd
;   playback   -  Animate Window?         |  bool     ->   True
;   cache      -  Cache Animation Frames? |  bool     ->   False
ImageShow(image, title := "", pos := "", style := 0x90000000, styleEx := 0x80088, parent := "", playback := True, cache := False) {
   return ImagePut("show", image, title, pos, style, styleEx, parent, playback, cache)
}

ImageDestroy(image) {
   return ImagePut.Destroy(image)
}

ImageWidth(image) {
   return ImagePut.Dimensions(image)[1]
}

ImageHeight(image) {
   return ImagePut.Dimensions(image)[2]
}
/*
ImagePut(cotype, image, p*) {
   return ImagePut.call(cotype, image, p*)
}

ImageEqual(images*) {
   return ImageEqual.call(images*)
}
*/
