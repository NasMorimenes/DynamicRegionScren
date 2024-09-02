Hex2Base64(hex) {
	sz:=StringToBinary(b,hex)
	Base64enc(out,b,sz)
	VarSetCapacity(out,-1) ; Strip everything after first null byte
	;return SubStr(out,1,sz) ; Strip garbage at the end
	return out
}