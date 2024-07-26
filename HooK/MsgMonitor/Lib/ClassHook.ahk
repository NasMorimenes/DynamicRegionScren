class Hook {
    __New( idHook, andressCallBack ) {
        this.callbackAddress := andressCallBack
        this.idHook := idHook
        this.hookHandle := 0
    }

    SetHook() {
         
        this.hookHandle :=
        DllCall( "SetWindowsHookEx",
            "Int", this.idHook,
            "Ptr", this.callbackAddress,
            "Ptr", DllCall("GetModuleHandle", "Ptr", 0, "Ptr"),
            "UInt", 0,
            "Ptr"
        )
        if ( !this.hookHandle ) {
            MsgBox( "Failed to set hook: " this.idHook )
            ExitApp()
        }
        return this.hookHandle
    }

    Unhook() {
        if ( this.hookHandle ) {
            DllCall("UnhookWindowsHookEx", "Ptr", this.hookHandle)
            CallbackFree( this.callbackAddress )
        }
    }

    __Delete() {
        this.Unhook()
    }
}
