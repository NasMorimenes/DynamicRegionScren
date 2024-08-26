MCode1( hex ) {
	len := StrLen( hex) // 2
	code := Buffer( len, 0 )
	DllCall( 
		"crypt32\CryptStringToBinary",
		"Str", hex,
		"uint", 0,
		"uint", 4,
		"Ptr", code,
		"uint*", &len,
		"Ptr", 0,
		"Ptr", 0
	)
		DllCall( 
		"VirtualProtect",
		"Ptr", code,
		"Ptr", len,
		"uint", 0x40,"Ptr*", 0
	)
	return code
}