Get_stdout( command ) {

	tmpf:=get_TempFile()

	;RunWait, %comspec% /c %command% > "%tmpf%",,Hide

	RunWait( A_ComSpec "/c " command "> " Chr( 34 ) %tmpf% Chr( 34 ), , "Hide" )
	;A_comspec "/c " command " > " Chr( 34 ) tmpf Chr( 34 )

	data := FileRead( tmpf )

	FileDelete( tmpf )

	return data
}