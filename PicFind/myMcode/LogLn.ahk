LogLn( line ){
	global
	CompilerLogData .= line "`n"
	;,,CompilerLog, % CompilerLogData
	CompilerLog_LogLn+=1
	;ControlSend,,{PGDN %CompilerLog_LogLn%}{Down 8}{End},ahk_id %hCompilerLog%
}