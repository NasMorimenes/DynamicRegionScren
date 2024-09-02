MCode_ParseClean(data) {
	ndata:=""
	Loop, Parse, data, `n, `r
	{
		if Instr(A_LoopField,".ident	" """" "GCC:")
			return ndata
		ndata .= A_LoopField "`n"
	}
	return ndata
}