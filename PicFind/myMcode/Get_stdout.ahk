Get_stdout(command) {
	tmpf:=get_TempFile()
	RunWait, %comspec% /c %command% > "%tmpf%",,Hide
	FileRead,data,%tmpf%
	FileDelete,%tmpf%
	return data
}