
Ass := 10

Ini:

if ( Ass <= 20 ) {
    GoTo( "x1")
}
else {
    GoTo( "x2" )
}

x1:
    ++Ass
    GoTo( "Ini" )

x2:
    ExitApp()






/*
class region {
    static dpi := A_ScreenDPI / 96
    static cont := 0
    static mouseBuff := Buffer(32, 0)

    __Init() {
        this.flag := 1
        this.layer := Gui("-Caption +LastFound +E0x80000 +AlwaysOnTop")
        this.cont := region.cont
        this.layerWidth := A_ScreenWidth * region.dpi
        this.layerHeight := A_ScreenHeight * region.dpi
        this.layer.Show("x0 y0 w" . this.layerWidth . " h" . this.layerHeight)
        ++region.cont
    }

    __New(regionParams*) {
        if (regionParams.Length) {
            ; this.Show(region)
        } else {
            ; initialization without parameters
        }
    }
    
    Add(x, y, width, height, color := "", opacity := 1) {
        region := Gui()
        region.BackColor := color
        region.Opacity := opacity
        region.Show("x" . x . " y" . y . " w" . width . " h" . height)
    }

    Destroy() {
        this.layer.Destroy()
        this.layer := ""
    }

    __Delete() {
        if (this.layer)
            this.layer.Destroy()
    }   

    select(Key1 := "x", Key2 := "x") {
        static andress := CallbackCreate(this.MouseMove)
        static hHookMouse := 0

        if (this.flag = 1) {
            KeyWait(Key1, "D")        
            if (Key1 = Key2) {
                Sleep(1050)
                SetTimer(this.inSelect.Bind(this), 16)
            }
        } else if (this.flag = 2) {
            this.Capture()
        } else {
            Exit
        }
    }

    Capture() {   
        static andress := CallbackCreate(this.MouseMove)
        hHookMouse := this.SetHook(14, andress)
        Exit
    }

    inSelect() {
        if (!KeyWait(Key2, "D T0.1")) {
            MsgBox("")
            SetTimer(this.inSelect.Bind(this), 0) 
        }
        static andress := CallbackCreate(this.MouseMove)
        hHookMouse := this.SetHook(14, andress)
        ToolTip("mdf")
    }
    
    Exit() {
        if (andress) {
            this.Unhook(andress, hHookMouse)
        }
    }

    SetHook(idHook, pfn) {
        hHook := this.SetWindowsHookEx(idHook, pfn)
        if (!hHook) {
            MsgBox("Failed to set hook: " . idHook)
            ExitApp()
        }
        return hHook
    }

    MouseMove(nCode, wParam, lParam) { 
        Critical
        static lastMouseMove := A_TickCount
        if (!nCode && (wParam = 0x200)) { 
            diffMouseMove := A_TickCount - lastMouseMove
            lastMouseMove := A_TickCount

            NumPut("Int", NumGet(lParam, 0, "Int"), region.mouseBuff, 0)
            NumPut("Int", NumGet(lParam, 0, "Int"), region.mouseBuff, 4)
        }
        return this.CallNextHookEx(nCode, wParam, lParam)
    }

    CallNextHookEx(nCode, wParam, lParam, hHook := 0) {
        LRESULT := DllCall("CallNextHookEx", "Uint", hHook, "int", nCode, "Uint", wParam, "Uint", lParam)
        return LRESULT
    }
    
    SetWindowsHookEx(idHook, pfn) {
        hModule := this.GetModuleHandle()
        hHook := DllCall("SetWindowsHookEx", "int", idHook, "Ptr", pfn, "Ptr", hModule, "UInt", 0)
        return hHook
    }
    
    GetModuleHandle() {
        hModule := DllCall("GetModuleHandle", "Ptr", 0)
        return hModule
    }
    
    UnhookWindowsHookEx(hHook) { 
        bool := DllCall("UnhookWindowsHookEx", "Uint", hHook)
        return bool
    }

    Unhook(andress, hHookMouse) {            
        CallbackFree(andress)
        this.UnhookWindowsHookEx(hHookMouse)
    }
}

; Demonstração de uso
reg := region()
reg.Add(100, 100, 200, 200, "Red", 0.5)
reg.select("L", "L")
