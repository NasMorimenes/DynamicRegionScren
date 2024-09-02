removeWhitespaceChars(str) {
	if InStr(str, "`r")
		str := StrReplace(str, "`r", "")
	if InStr(str, "`n")
		str := StrReplace(str, "`n", "")
	if InStr(str, "`t")
		str := StrReplace(str, "`t", "")
	if InStr(str, " ")
		str := StrReplace(str, " ", "")
	return str
}