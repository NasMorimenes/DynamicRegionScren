SetTimes( PidHook := "", msg := ""  ) {
    global idHook
    switch PidHook {

        case "":

            ;ToolTip( msg, 16 )
            tim := 100
            SetTimer(  sTime, Tim )

            A_Ver := 1
            while ( A_Ver ) {                
                Ass := GetKeyState( "M", "P")
                Dss := GetKeyState( "K", "P" )
                if ( Ass || Dss ) {
                    if ( Ass ) {
                        PidHook := "WH_MOUSE_LL"
                        ;End()
                        ;tim := 0
                        ToolTip( )
                        ;SetTimer(  sTime, Tim )
                        A_Ver := 0
                    }
                    else {
                        PidHook := "WH_KEYBOARD_LL"
                        ;End()
                        ;tim := 0
                        ToolTip( )
                        ;SetTimer(  sTime, Tim )
                        A_Ver := 0
                    }
                }
            }

            SetTimes( PidHook, msg )

            End() {
                tim := 0
                ;ToolTip( )
                SetTimer(  sTime, Tim )                
            }

            sTime() {
                static timerIni := A_TickCount
                static timer := 0
                static iCount := 1
                if ( iCount == 1 ) {
                    ToolTip( msg, 700, 200 )
                    ++iCount
                }

                if ( timer < 5000 ) {
                    timer := A_TickCount - timerIni
                }
                else {
                    ToolTip()
                    End()
                }
            }
        ;Para mais opções consulte:
        ;C:\Users\morim\OneDrive\DynamicRegionScren\Lib\Constructs\Hooks\ContructHook.ahk
        case  "WH_KEYBOARD_LL":
            idHook := 13
            istallHook()
            return 0

        case "WH_MOUSE_LL":
            idHook := 14
            istallHook()
            return 0

        default:
            
    }
}