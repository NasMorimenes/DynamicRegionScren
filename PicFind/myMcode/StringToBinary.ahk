; BinaryToString() / StringToBinary() from laszlo, updated by joedf
; http://ahkscript.org/forum/viewtopic.php?p=304556#304556
; fmt = 1:base64, 4:hex-table, 5:hex+ASCII, 10:offs+hex, 11:offs+hex+ASCII, 12:raw-hex
StringToBinary(ByRef bin, hex, fmt=12) {    ; return length, result in bin
	DllCall("Crypt32.dll\CryptStringToBinary","Str",hex,"UInt",StrLen(hex),"UInt",fmt,"UInt",0,"UInt*",cp,"UInt",0,"UInt",0,"CDECL UInt") ; get size
	VarSetCapacity(bin,cp)
	DllCall("Crypt32.dll\CryptStringToBinary","Str",hex,"UInt",StrLen(hex),"UInt",fmt,"UInt",&bin,"UInt*",cp,"UInt",0,"UInt",0,"CDECL UInt")
	Return cp
}
