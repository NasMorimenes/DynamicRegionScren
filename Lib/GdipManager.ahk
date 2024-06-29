class GdipManager {
    static pToken := 0
    static refCount := 0

    __New() {
        if ( GdipManager.refCount = 0 ) {
            this.Startup()
        }
        GdipManager.refCount++
    }

    __Delete() {
        GdipManager.refCount--
        if (GdipManager.refCount = 0) {
            this.Shutdown()
        }
    }

    Startup() {
        pToken := GdipManager.pToken
        if !DllCall("GetModuleHandle", "str", "gdiplus") {
            DllCall("LoadLibrary", "str", "gdiplus")
        }

        si := Buffer( 16, 0 )
        NumPut( "UInt", 1, si, 0 )
        DllCall( 
            "gdiplus\GdiplusStartup",
            "UPtr*", &pToken,
            "UPtr", si.ptr,
            "UPtr", 0
        )
        GdipManager.pToken := pToken
    }

    Shutdown() {
        
        if ( GdipManager.pToken ) {
            DllCall(
                "gdiplus\GdiplusShutdown",
                "UPtr", GdipManager.pToken
            )
            GdipManager.pToken := 0
        }
    }
}

/*
; Exemplo de função que usa a classe GdipManager
showMessageUsingGDI() {
    gdip := GdipManager()
    ; Inicializar GDI+ e realizar operações aqui
    ; ...

    ; Quando a função termina, GDI+ é finalizado automaticamente se não for mais necessário
}

; Teste as funções
showMessageUsingGDI()
; Outras chamadas para funções que usam GDI+ podem ser feitas aqui
showMessageUsingGDI()
