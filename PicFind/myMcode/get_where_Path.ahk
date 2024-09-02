get_where_Path(item) {
	data:=Get_stdout("where " item)
	Loop, parse, data, `n, `r
		return A_loopField
}