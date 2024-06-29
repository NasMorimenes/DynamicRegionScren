DontVerifyImageType(&image, &keywords := "") {

   ; Sentinel value.
   keywords := {}

   ; Try ImageType.
   if !IsObject(image)
      throw Error("Must be an object.")

   ; Goto ImageType.
   if image.HasProp("image") {
      keywords := image
      image := image.image
      throw Error("Must catch this error with ImageType.")
   }

   ; Skip ImageType.
   for type in inputs
      if image.HasProp(type) {
         keywords := image
         image := image.%type%
         return type
      }

   ; Continue ImageType.
   throw Error("Invalid type.")
}