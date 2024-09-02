MCode_Generate(file,cp,flags:="") {
	global @PATH_VAR
	tmpf_a:=get_TempFile()
	tmpf_b:=tmpf_a "_b"
	tmpf_c:=tmpf_a "_c"
	SplitPath, cp,, cpDir
	if !FileExist(cp) {
		cpPath:=get_where_Path(cp)
		SplitPath, cpPath,, cpDir
	}
	EnvSet, Path, %cpDir% ;Update path environment var
	RunWait, %comspec% /c %cp% %flags% -Wa`,-aln="%tmpf_a%" "%file%" -o "%tmpf_b%" 2> "%tmpf_c%",, UseErrorLevel Hide
	cpRunEL:=ErrorLevel, ReturnVar:=""
	EnvSet, Path, %@PATH_VAR% ;Restore env var
	if cpRunEL = ERROR
	{
		LogLn("<Error : Could not launch GCC! @ " """" cp """")
	} else {
		FileRead,data,%tmpf_a%
		FileRead,out,%tmpf_c%
		if StrLen(out:=Trim(out)) {
			StringReplace,out,out,%file%,SOURCEFILE,All
			out:="`n<Stderr output>:`n============================================================`n" out
			LogLn(out "`r============================================================")
			if Instr(out,"WinMain") ;ignore error: "undefined reference to 'WinMain'" or similar
			{
				LogLn("<Error ignored: undefined reference to 'WinMain'>")
				ReturnVar := MCode_Parse(data)
			}
		} else {
			ReturnVar := MCode_Parse(data)
		}
	}
	FileDelete,%tmpf_a%
	FileDelete,%tmpf_b%
	FileDelete,%tmpf_c%
	return ReturnVar
}