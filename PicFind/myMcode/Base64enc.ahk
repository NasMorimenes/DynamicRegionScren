;http://www.autohotkey.com/board/topic/85709-base64enc-base64dec-base64-encoder-decoder/
Base64enc( ByRef OutData, ByRef InData, InDataLen ) { ; by SKAN
	DllCall("Crypt32.dll\CryptBinaryToString" (A_IsUnicode?"W":"A")
		,UInt,&InData,UInt,InDataLen,UInt,(0x40000000|0x01),UInt,0,UIntP,TChars,"CDECL Int")
	VarSetCapacity(OutData,Req:=TChars*(A_IsUnicode?2:1))
	DllCall("Crypt32.dll\CryptBinaryToString" (A_IsUnicode?"W":"A")
		,UInt,&InData,UInt,InDataLen,UInt,(0x40000000|0x01),Str,OutData,UIntP,Req,"CDECL Int")
	Return TChars
}
