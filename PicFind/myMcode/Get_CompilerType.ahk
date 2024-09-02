Get_CompilerType(cp) {
	if !FileExist(cp)
		cp:=get_where_Path(cp)
	if Is64BitAssembly(cp)
		return "64"
	else
		return "32"
}
