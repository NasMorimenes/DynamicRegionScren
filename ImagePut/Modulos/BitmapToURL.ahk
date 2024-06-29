BitmapToURL(pBitmap, extension := "", quality := "") {
      body := BitmapToSafeArray(pBitmap, extension, quality)

      req := ComObject("WinHttp.WinHttpRequest.5.1")
      req.Open("POST", "https://api.imgur.com/3/image", true)
      req.SetRequestHeader("Authorization", "Client-ID " . "fbf77" "ff49" "c42c8a")
      req.Send(body)
      req.WaitForResponse()

      url := RegExReplace(req.ResponseText, "^.*?link\x22:\x22(.*?)\x22.*$", "$1")
      return url
   }