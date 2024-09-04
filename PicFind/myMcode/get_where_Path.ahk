get_where_Path( item ) {


	data := Get_stdout("where " item )

	loop parse data, "`n","`r"
		return A_loopField
	;Loop, parse, data, `n, `r
	;	return A_loopField
}