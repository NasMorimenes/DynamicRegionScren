;http://www.autohotkey.com/board/topic/85709-base64enc-base64dec-base64-encoder-decoder/
Base64enc( &OutData, &InData, InDataLen ) { ; by SKAN

	TChars := 0
	
	DllCall(
		"Crypt32.dll\CryptBinaryToString",			
		"UInt",		InData,
		"UInt",		InDataLen,
		"UInt",		(0x40000000|0x01),
		"UInt",		0,
		"UIntP",	&TChars,
		"CDECL Int"
	)

	Req := TChars * 2

	OutData := Buffer( Req, 0 )
	
	DllCall(
		"Crypt32.dll\CryptBinaryToString",	
		"UInt",		InData,
		"UInt",		InDataLen,
		"UInt",		(0x40000000|0x01),
		"Str",		OutData,
		"UIntP",	Req,
		"CDECL Int"
	)

	Return TChars
}
