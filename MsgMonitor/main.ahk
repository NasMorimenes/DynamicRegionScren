#Include Includes.ahk
idHook := 0
SelectHooK()
MsgBox( idHook )

OnExit( UnistallHook )

UnistallHook( * ) {
    global

    if ( idHook == 14 ) {
        MsgBox( "Unisntall ")
        InstallMouseHook( false )
    }
    else {
        InstallKeybdHook( false)
    }
    

}