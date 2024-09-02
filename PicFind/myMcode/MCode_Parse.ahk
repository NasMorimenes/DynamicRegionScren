MCode_Parse(data,clean:=1) {
	if (clean)
		data:=MCode_ParseClean(data)
	p := 1, m := "", Output := ""
	while p := RegexMatch(data, "`ami)^\s*\d+(\s[\dA-F]{4}\s|\s{6})([\dA-F]+)", m, p + StrLen(m))
		Output .= m2
	return Output
}