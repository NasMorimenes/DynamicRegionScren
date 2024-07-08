#Include  Includes.ahk

InstallHook( pfn := "" ) {
    global idHook
    global andressK
    global andressM

    if ( idHook == 14 ) {
        pfn := Keyboard
        andressK := CallbackCreate( pfn )
    }
    else if ( idHook == 13 ) {        
        pfn := MoveMouse
        andressM := CallbackCreate( pfn )
    }
}