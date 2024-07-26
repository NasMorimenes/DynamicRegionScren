#Include ClassHook.ahk
#Include ClassMutex.V0.ahk
class MouseHook extends Hook {
    __New( andressCallBack, sharedData ) {
        this.andressCallBack := andressCallBack
        super.__New( 14, andressCallBack )  ; 14 é o ID para WH_MOUSE_LL
        this.sharedData := sharedData ; 8 bytes para wParam e 8 bytes para lParam
        this.mutex := Mutex()
    }

    LowLevelMouseProc( nCode, wParam, lParam ) {
        Critical
        if (nCode >= 0) {
            Lock := this.mutex.Lock()
            if (Lock) {
                try {
                    NumPut("UPtr", wParam, this.sharedData, 0)
                    NumPut("Ptr", lParam, this.sharedData, 8)
                    ListVars()
                    SetTimer( this.andressCallBack, -1)
                } finally {
                    this.mutex.Unlock()
                }
            }
        }
        return DllCall("CallNextHookEx", "Ptr", 0, "Int", nCode, "UIntPtr", wParam, "Ptr", lParam)
    }

    SetMouseHook() {
        return this.SetHook()
    }

    UnhookMouse() {
        this.Unhook()
    }

    __Delete() {
        this.UnhookMouse()
        super.__Delete()
    }
}