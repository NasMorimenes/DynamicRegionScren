Get_Compiler(sfile:="") {
	if !FileExist(sfile)
		sfile:=A_scriptFullPath
	IniRead,x,%sfile%,settings,Compilerpath,!NULL
	if !FileExist(x) and !StrLen(get_where_Path(x))
		return get_where_Path("gcc")
	return x
}
