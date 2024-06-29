
call(cotype, image, p*) {

    ; Start!
    gdiplusStartup()

    ; Take a guess as to what the image might be. (>95% accuracy!)
    try type := DontVerifyImageType(&image, &keywords)
    catch
       type := ImageType(image)

    ; Extract options to be directly applied the intermediate representation here.
    crop      := keywords.HasProp("crop")      ? keywords.crop      : ""
    scale     := keywords.HasProp("scale")     ? keywords.scale     : ""
    upscale   := keywords.HasProp("upscale")   ? keywords.upscale   : ""
    downscale := keywords.HasProp("downscale") ? keywords.downscale : ""
    sprite    := keywords.HasProp("sprite")    ? keywords.sprite    : ""
    decode    := keywords.HasProp("decode")    ? keywords.decode    : decode
    render    := keywords.HasProp("render")    ? keywords.render    : render
    validate  := keywords.HasProp("validate")  ? keywords.validate  : validate

    ; Keywords are for (image -> intermediate).
    try index := keywords.index

    cleanup := ""

    ; #1 - Stream as the intermediate representation.
    try stream := ImageToStream(type, image, keywords)
    catch Error as e
       if (e.Message ~= "^Conversion from")
          goto make_bitmap
       else throw
    if not stream
       throw Error("Stream cannot be zero.")

    ; Check the file signature for magic numbers.
    stream:
    DllCall("shlwapi\IStream_Size", "ptr", stream, "uint64*", &size:=0, "hresult")
    DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")

    ; 2048 characters should be good enough to identify the file correctly.
    size := min(size, 2048)
    bin := Buffer(size)
    (ComCall(Seek := 5, stream, "uint64", 0, "uint", 1, "uint64*", &current:=0), current != 0 && MsgBox(current))
    ; Get the first few bytes of the image.
    DllCall("shlwapi\IStream_Read", "ptr", stream, "ptr", bin, "uint", size, "hresult")
    DllCall("shlwapi\IStream_Reset", "ptr", stream, "hresult")

    ; Allocate enough space for a hexadecimal string with spaces interleaved and a null terminator.
    length := 2*size + (size-1) + 1
    VarSetStrCapacity(&str, length)

    ; Lift the binary representation to hex.
    flags := 0x40000004 ; CRYPT_STRING_NOCRLF | CRYPT_STRING_HEX
    DllCall("crypt32\CryptBinaryToString", "ptr", bin, "uint", size, "uint", flags, "str", str, "uint*", &length)

    ; Determine the extension using herustics. See: http://fileformats.archiveteam.org
    extension := 0                                                              ? ""
    : str ~= "(?i)66 74 79 70 61 76 69 66"                                      ? "avif" ; ftypavif
    : str ~= "(?i)^42 4d (.. ){36}00 00 .. 00 00 00"                            ? "bmp"  ; BM
    : str ~= "(?i)^01 00 00 00 (.. ){36}20 45 4D 46"                            ? "emf"  ; emf
    : str ~= "(?i)^47 49 46 38 (37|39) 61"                                      ? "gif"  ; GIF87a or GIF89a
    : str ~= "(?i)66 74 79 70 68 65 69 63"                                      ? "heic" ; ftypheic
    : str ~= "(?i)^00 00 01 00"                                                 ? "ico"
    : str ~= "(?i)^ff d8 ff"                                                    ? "jpg"
    : str ~= "(?i)^25 50 44 46 2d"                                              ? "pdf"  ; %PDF-
    : str ~= "(?i)^89 50 4e 47 0d 0a 1a 0a"                                     ? "png"  ; PNG
    : str ~= "(?i)^(((?!3c|3e).. )|3c (3f|21) ((?!3c|3e).. )*3e )*+3c 73 76 67" ? "svg"  ; <svg
    : str ~= "(?i)^(49 49 2a 00|4d 4d 00 2a)"                                   ? "tif"  ; II* or MM*
    : str ~= "(?i)^52 49 46 46 .. .. .. .. 57 45 42 50"                         ? "webp" ; RIFF....WEBP
    : str ~= "(?i)^d7 cd c6 9a"                                                 ? "wmf"
    : "" ; Extension must be blank for file pass-through as-is.

    ; Convert vectorized formats to rasterized formats.
    if (render && extension ~= "^(?i:pdf|svg)$") {
       (extension = "pdf") && RenderPdf(&stream, index?)
       (extension = "svg") && pBitmap := RenderSvg(&stream, 800, 800)
       goto( IsSet(pBitmap) ? "bitmap" : "stream" )
    }

    ; Determine whether the stream should be decoded into pixels.
    weight := decode || crop || scale || upscale || downscale || sprite ||

       ; Check if the 1st parameter matches the extension.
       !( cotype ~= "^(?i:encodedbuffer|url|hex|base64|uri|stream|randomaccessstream|safearray)$"
          && (!p.Has(1) || p[1] == "" || p[1] = extension)

       ; Check if the 2nd parameter matches the extension.
       || cotype = "formdata"
          && (!p.Has(2) || p[2] == "" || p[2] = extension)

       ; For files, if the desired extension is not supported, it is ignored.
       || cotype = "file"
          && (!p.Has(1) || p[1] == "" || p[1] ~= "(^|:|\\|\.)" extension "$"
             || !(RegExReplace(p[1], "^.*(?:^|:|\\|\.)(.*)$", "$1")
             ~= "^(?i:avif|avifs|bmp|dib|rle|gif|heic|heif|hif|jpg|jpeg|jpe|jfif|png|tif|tiff)$"))

       ; Pass through all other cotypes.
       || cotype)

       ; MsgBox weight ? "convert to pixels" : "stay as stream"

    if weight
       goto clean_stream
    
    ; Attempt conversion using StreamToCoimage.
    try coimage := StreamToCoimage(cotype, stream, p*)
    catch Error as e
       if (e.Message ~= "^Conversion from")
          goto clean_stream
       else throw

    ; Clean up the copy. Export raw pointers if requested.
    if (cotype != "stream")
       ObjRelease(stream)

    goto exit

    ; Otherwise export the image as a stream.
    clean_stream:
    type := "stream"
    image := stream
    cleanup := "stream"

    ; #2 - Fallback to GDI+ bitmap as the intermediate.
    make_bitmap:
    if !(pBitmap := ImageToBitmap(type, image, keywords))
       throw Error("pBitmap cannot be zero.")

    ; GdipImageForceValidation must be called immediately or it fails silently.
    bitmap:
    (validate) && DllCall("gdiplus\GdipImageForceValidation", "ptr", pBitmap)
    (crop) && BitmapCrop(&pBitmap, crop)
    (scale) && BitmapScale(&pBitmap, scale)
    (upscale) && BitmapScale(&pBitmap, upscale, 1)
    (downscale) && BitmapScale(&pBitmap, downscale, -1)
    (sprite) && BitmapSprite(&pBitmap)

    ; Save frame delays and loop count for webp.
    if (type = "stream" && extension = "webp" && cotype ~= "^(?i:show|window)$") {
       ParseWebp(stream, &pDelays, &pCount)
       DllCall("gdiplus\GdipSetPropertyItem", "ptr", pBitmap, "ptr", pDelays)
       DllCall("gdiplus\GdipSetPropertyItem", "ptr", pBitmap, "ptr", pCount)
    }

    ; Attempt conversion using BitmapToCoimage.
    coimage := BitmapToCoimage(cotype, pBitmap, p*)

    ; Clean up the copy. Export raw pointers if requested.
    if (cotype != "bitmap")
       DllCall("gdiplus\GdipDisposeImage", "ptr", pBitmap)

    if (cleanup = "stream")
       ObjRelease(stream)

    exit:
    ; Check for dangling pointers.
    gdiplusShutdown(cotype)

    return coimage
 }