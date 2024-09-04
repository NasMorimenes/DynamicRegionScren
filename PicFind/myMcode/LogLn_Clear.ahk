LogLn_Clear() {
	global
	CompilerLogData := ""
	;GuiControl,,CompilerLog, % CompilerLogData
	CompilerLog_LogLn:=0
	;ControlSend,,{PGDN}{Down}{End},ahk_id %hCompilerLog%
}
