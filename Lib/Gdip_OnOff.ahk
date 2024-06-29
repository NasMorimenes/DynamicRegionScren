#Include <ErroGdi>
class Gdip_OnOff {

    static pToken := 0    

    static Init( flag := 0 ) {
        switch  {
            case flag = 1:
                if ( Gdip_OnOff.pToken ) {
                    Gdip_OnOff.pToken := Gdip_OnOff.Shutdown()
                }
            case flag = 2 :
                if ( !Gdip_OnOff.pToken ) {                    
                    Gdip_OnOff.pToken := Gdip_OnOff.Startup()
                }
            default:
                ; Inicializa GDI+
                if ( Gdip_OnOff.pToken = 0 ) {
                    Gdip_OnOff.pToken := Gdip_OnOff.Startup()
                } 
                else {
                    Gdip_OnOff.pToken := Gdip_OnOff.Shutdown()
                }
        }
    }

    __Delete() {
        ; Finaliza GDI+
        Gdip_OnOff.pToken := Gdip_OnOff.Shutdown()
    }

    static Startup() {
        pToken := 0
        if !DllCall("GetModuleHandle", "str", "gdiplus") {
            DllCall("LoadLibrary", "str", "gdiplus")
        }

        si := Buffer( 16, 0)
        NumPut( "UInt", 1, si, 0 )
        Bool :=
        DllCall(
            "gdiplus\GdiplusStartup",
            "UPtr*", &pToken,
            "UPtr", si.ptr,
            "UPtr", 0
        )
        statup() {

        }
        _Error := ErrorGdi( Bool, statup ) 
        if ( !_Error ) {
            return pToken
        }
    }

    static Shutdown() {
        if ( Gdip_OnOff.pToken ) {
            DllCall(
                "gdiplus\GdiplusShutdown",
                "UPtr", Gdip_OnOff.pToken
            )
            MsgBox( "Saindo GDIP" )
            return 0
        }

    }
}

; Teste on e off
;MsgBox "Criando objeto Gdip_OnOff"
;Gdip := Gdip_OnOff.pToken
;StartGDI := Gdip_OnOff()
;MsgBox "Objeto Gdip_OnOff criado, GDI+ deve estar inicializado"

;MsgBox Gdip_OnOff.pToken

;MsgBox "Liberando objeto Gdip_OnOff"
;
;MsgBox "Objeto Gdip_OnOff liberado, GDI+ deve estar finalizado"
