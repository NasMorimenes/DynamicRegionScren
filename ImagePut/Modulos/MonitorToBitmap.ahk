MonitorToBitmap(image) {
   try dpi := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
   if (image > 0) {
      MonitorGet(image, &Left, &Top, &Right, &Bottom)
      x := Left
      y := Top
      w := Right - Left
      h := Bottom - Top
   } else {
      x := DllCall("GetSystemMetrics", "int", 76, "int")
      y := DllCall("GetSystemMetrics", "int", 77, "int")
      w := DllCall("GetSystemMetrics", "int", 78, "int")
      h := DllCall("GetSystemMetrics", "int", 79, "int")
   }
   try DllCall("SetThreadDpiAwarenessContext", "ptr", dpi, "ptr")
   return ScreenshotToBitmap([x, y, w, h])
}