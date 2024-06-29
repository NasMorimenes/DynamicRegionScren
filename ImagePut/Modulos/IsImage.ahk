IsImage(ptr, size) {
   ; Shortest possible image is 24 bytes.
   if (size < 24)
      return False

   size := min(size, 2048)
   length := VarSetStrCapacity(&str, 2 * size + (size - 1) + 1)
   DllCall("crypt32\CryptBinaryToString", "ptr", ptr, "uint", size, "uint", 0x40000004, "str", str, "uint*", &length)
   if str ~= "(?i)66 74 79 70 61 76 69 66"                                      ; "avif"
      || str ~= "(?i)^42 4d (.. ){36}00 00 .. 00 00 00"                            ; "bmp"
      || str ~= "(?i)^01 00 00 00 (.. ){36}20 45 4D 46"                            ; "emf"
      || str ~= "(?i)^47 49 46 38 (37|39) 61"                                      ; "gif"
      || str ~= "(?i)66 74 79 70 68 65 69 63"                                      ; "heic"
      || str ~= "(?i)^00 00 01 00"                                                 ; "ico"
      || str ~= "(?i)^ff d8 ff"                                                    ; "jpg"
      || str ~= "(?i)^25 50 44 46 2d"                                              ; "pdf"
      || str ~= "(?i)^89 50 4e 47 0d 0a 1a 0a"                                     ; "png"
      || str ~= "(?i)^(((?!3c|3e).. )|3c (3f|21) ((?!3c|3e).. )*3e )*+3c 73 76 67" ; "svg"
      || str ~= "(?i)^(49 49 2a 00|4d 4d 00 2a)"                                   ; "tif"
      || str ~= "(?i)^52 49 46 46 .. .. .. .. 57 45 42 50"                         ; "webp"
      || str ~= "(?i)^d7 cd c6 9a"                                                 ; "wmf"
      return True

   return False
}