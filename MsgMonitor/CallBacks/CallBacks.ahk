#Include C:\Users\morim\OneDrive\DynamicRegionScren\MsgMonitor\Includes.ahk

/*
 * Source MsgMonitor
 * Instalação de um Hook
 * 
 * SetWindowsHookEx( idHook, pfn ) {
    hModule := GetModuleHandle()
    hHook :=
    DllCall(
        "SetWindowsHookEx",
        "int", idHook,
        "Ptr", pfn,
        "Ptr", hModule, ; DllCall("GetModuleHandle", "Ptr", 0),
        "UInt", 0,
        "Ptr"
    )
    return hHook
}
*/
SelectHooK( msg := "" ) {
    global idHook
    if ( idHook != 0 ) {
        return 0
    }

    msgDefalt := "
    (
        Escolha o Hook a ser Instalado
        ( M ) para WH_MOUSE_LL
        ( K ) para WH_KEYBOARD_LL

    )"

    ( msg == "" ) && msg := msgDefalt
    PidHook := ""
    SetTimes( PidHook, msg )

    /*
    A_Ver := 1
    while ( A_Ver ) {
        Ass := GetKeyState( "M", "P")
        Dss := GetKeyState( "K", "P" )
        if ( Ass || Dss ) {
            if ( Ass ) {
                PidHook := "WH_MOUSE_LL"
                idHook := SetTimes( PidHook, msg )
                A_Ver := 0
            }
            else (
                PidHook := "WH_KEYBOARD_LL"
                idHook := SetTimes( PidHook, msg )
                A_Ver := 0
            )
        }
    }
    */

    return 0
    
}