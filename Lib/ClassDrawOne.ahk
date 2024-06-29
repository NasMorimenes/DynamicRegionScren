Ads := region()
Ads.select(  )
Sleep( 12000 )
Ads.select( "ss" )
Sleep( 12000 )
Ads.select( "s1" )

class region {

    static dpi := A_ScreenDPI / 96
    static cont := 0
    static mouseBuff := Buffer(32, 0)

    __Init() {
        this.flag := "ss"
        this.layer := Gui("-Caption +LastFound +E0x80000 +AlwaysOnTop")
        this.cont := region.cont
        this.layerWidth := A_ScreenWidth * region.dpi
        this.layerHeight := A_ScreenHeight * region.dpi
        this.layer.Show("x0 y0 w" this.layerWidth " h" this.layerHeight)
        ++region.Cont
    }

    __New(regionParams*) {
        if (regionParams.Length) {
            ;this.Show( region )
        }
        else {

        }
    }

    Add(x, y, width, height, color := "", opacity := 1) {
        region := Gui()
        region.BackColor := color
        region.Opacity := opacity
        region.Show("x" x " y" y " w" width " h" height)
    }

    Destroy() {
        this.layer.Destroy()
        this.layer := ""
        this := ""
    }

    __Delete() {

        if (this.layer)
            this.layer.Destroy()
    }

    select( flag := "", DEBUG_OUTPUT := false, WH_MOUSE_LL := 14 ) {

        ( flag != ""  &&  this.flag := flag )

        static andress := CallbackCreate( MouseMove )
        static hHookMouse := SetHook( WH_MOUSE_LL, andress )

        SetHook(idHook, pfn) {
            hHook := SetWindowsHookEx(idHook, pfn) ;DllCall("SetWindowsHookEx", "int", idHook, "Ptr", pfn, "Ptr", DllCall("GetModuleHandle", "Ptr", 0), "UInt", 0, "Ptr")
            if (!hHook) {
                MsgBox("Failed to set hook: " idHook)
                ExitApp()
            }
            return hHook
        }

        MouseMove(nCode, wParam, lParam) {

            Critical

            if ( this.flag = "ss" ) {
                Return CallNextHookEx(nCode, wParam, lParam)
            }
            else if ( this.flag = "s1" ) {
                return Unhook( &andress, &hHookMouse )
            }

            static lastMouseMove := A_TickCount
            If (!nCode && (wParam = 0x200)) {

                diffMouseMove := A_TickCount - lastMouseMove
                lastMouseMove := A_TickCount

                Text :=
                    (
                        " X: " NumGet(lParam, 0, "Int")
                        " Y: " NumGet(lParam, 4, "Int")
                        " Last keypress: " diffMouseMove
                    )
                ;ListVars()
                OutputDebug( Text )

                ToolTip( Text )

                setVars := -1
                currTime := A_TickCount
                xPos := NumGet(lParam, 0, "int")
                yPos := NumGet(lParam, 4, "int")

                ;ToolTip( QueryMouseMove( setVars, currTime , xPos, yPos ) )

                QueryMouseMove(setVars, currTime, xPos, yPos)
            }

            Return CallNextHookEx(nCode, wParam, lParam)
        }

        CallNextHookEx(nCode, wParam, lParam, hHook := 0) {
            ;ListLines()

            LRESULT :=
                DllCall(
                    "CallNextHookEx",
                    "Uint", hHook,
                    "int", nCode,
                    "Uint", wParam,
                    "Uint", lParam
                )

            Return LRESULT
        }

        SetWindowsHookEx(idHook, pfn) {
            hModule := GetModuleHandle()
            hHook :=
                DllCall(
                    "SetWindowsHookEx",
                    "int", idHook,
                    "Ptr", pfn,
                    "Ptr", hModule,
                    "UInt", 0,
                    "Ptr"
                )
            return hHook
        }

        GetModuleHandle() {

            hModule :=
                DllCall(
                    "GetModuleHandle",
                    "Ptr", 0,
                    "Ptr"
                )

            return hModule
        }

        UnhookWindowsHookEx(hHook) {
            bool :=
                DllCall(
                    "UnhookWindowsHookEx",
                    "Uint", hHook,
                    "int"
                )
            Return bool
        }

        Unhook( &andress, &hHookMouse ) {

            ;MsgBox("Saindo")
            CallbackFree(andress)
            UnhookWindowsHookEx(hHookMouse)
        }


        /*
        *   QueryMouseMove()
        *       Param[1]: setVars ==  0 --> Consulta as variáveis estáticas QMM
        *       Param[1]: setVars == -1 --> Define as variáveis estáticas QMM com os valores fornecidos
        *       Param[1]: setVars == -2 --> Limpa (reseta) as variáveis estáticas QMM
        *
        *   Example, QueryMouseMove(0, lmm, x, y)
        *       To retrieve all 3 variables.
        */

        QueryMouseMove( setVars := 0, lastMouseMove := 0, xPos := 0, yPos := 0, DEBUG_OUTPUT := "" )  {

            static QMM_xPos := 0
            static QMM_yPos := 0
            static QMM_lastMouseMove := 0

            ; Consulta as variáveis estáticas
            if (setVars == 0) {
                xPos := QMM_xPos
                yPos := QMM_yPos
                lastMouseMove := QMM_lastMouseMove
                return lastMouseMove
            }

            ; Define as variáveis estáticas
            if (setVars == -1) {

                QMM_xPos := xPos
                QMM_yPos := yPos
                QMM_diffMouseMove := lastMouseMove - QMM_lastMouseMove
                QMM_lastMouseMove := lastMouseMove
                if (DEBUG_OUTPUT) {
                    ToolTip("X: " xPos " Y: " yPos " Last mouseMove: " QMM_diffMouseMove)
                }
                return TRUE
            }

            ; Limpa as variáveis estáticas
            if (setVars == -2) {
                QMM_xPos := 0
                QMM_yPos := 0
                QMM_lastMouseMove := 0
                return TRUE
            }

            return FALSE ; Caso nenhum dos valores esperados seja fornecido, retorna FALSE
        }

    }
}