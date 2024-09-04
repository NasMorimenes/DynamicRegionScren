Is64BitAssembly( appName ) {

	static GetBinaryType := "GetBinaryType" (A_IsUnicode ? "W" : "A")

	static SCS_32BIT_BINARY := 0
	static SCS_64BIT_BINARY := 6

	ret := DllCall(
		GetBinaryType,
		"Str", appName,
		"int*", binaryType
	)

	return binaryType == SCS_64BIT_BINARY
}