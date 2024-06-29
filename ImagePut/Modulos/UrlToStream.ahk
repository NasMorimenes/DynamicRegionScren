UrlToStream(image) {
   req := ComObject("WinHttp.WinHttpRequest.5.1")
   req.Open("GET", image, True)
   req.Send()
   req.WaitForResponse()
   IStream := ComObjQuery(req.ResponseStream, "{0000000C-0000-0000-C000-000000000046}"), ObjAddRef(IStream.ptr)
   return IStream.ptr
}