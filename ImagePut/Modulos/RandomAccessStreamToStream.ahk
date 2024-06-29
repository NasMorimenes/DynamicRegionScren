RandomAccessStreamToStream(image) {
   ; Since an IStream returned from CreateStreamOverRandomAccessStream shares a reference count
   ; with the internal IStream of the RandomAccessStream, clone it so that reference counting begins anew.
   IID_IStream := Buffer(16)
   DllCall("ole32\IIDFromString", "wstr", "{0000000C-0000-0000-C000-000000000046}", "ptr", IID_IStream, "hresult")
   DllCall("shcore\CreateStreamOverRandomAccessStream", "ptr", image, "ptr", IID_IStream, "ptr*", &stream := 0, "hresult")
   ComCall(Clone := 13, stream, "ptr*", &ClonedStream := 0)
   return ClonedStream
}