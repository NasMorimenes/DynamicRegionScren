#Include GDIP_V2.ahk
;#Include ClassLayer.ahk
;#Include GdipManager.ahk

;myRegion := region()
;myRegion.select()

;Esc::ExitApp()

/*

test() {

    Ass := Draw.dpi
    Ads := Draw()
    Ads[ "a" ] := 
    ;MsgBox Ass "`n" Ads.dpi "`n" Ads.Draws[ 1 ] "`n" Ads[ "a" ] 

    class Draw {    

        static dpi := A_ScreenDPI / 96

        dpi := 20

        Draws := [ 100 ]
        
        __Item[ a ] {
            get {
                return this.dpi + this.Draws[ 1 ]   
            }
            static __Item[name] {
                get {
                    return EnvGet(name)
                }
                set {
                    EnvSet(name, value)
                }
            }
            
        }
    }
}

*/



/*

; Drwa - Class {__Init: Func, Prototype: Prototype}
;Class {__Init: Func, Prototype: Prototype}
;Prototype {__Class: "Draw", __Init: Func}
;Class {Call: Func, Prototype: Prototype}
;Prototype {__Class: "Func", Bind: Func, Call: Func, IsBuiltIn: 0, IsByRef: Func, IsOptional: Func, IsVariadic: 0, MaxParams: 1, MinParams: 1, Name: "Draw.__Init"}

    __New( type, x1, y1, x2, y2, color, title, penWidth := 2, name := "Default", pX := 0, pY := 0, width := A_ScreenWidth, height := A_ScreenHeight ) {
        if ( SubStr( type, -1 ) == "D" ) {
            Mode := "Dynamic"
            type := SubStr( type, 1, StrLen( type ) - 1 )
        }
        else {
            Mode := "Normal"
        }
        this.type := type
        this.x1 := x1 * Draw.dpi
        this.y1 := y1 * Draw.dpi
        this.x2 := x2 * Draw.dpi
        this.y2 := y2 * Draw.dpi
        this.color := color
        this.penWidth := penWidth
        this.title := title
        this.Layer := Layer( this.title, name, pX := 0, pY := 0, width := A_ScreenWidth, height := A_ScreenHeight )
        ;this.g := ObjLayer.G
        this.Execute( mode )                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    }

    Execute( mode) {
        if (this.type = "Pencil") {
            pen := New_Pen( this.color, ,1 )
            ;pen := Gdip_CreatePen(this.color, this.penWidth)
            ;pen := New_Pen(this.color, , this.width )
            Gdip_GraphicsClear( this.Layer.g )
            Gdip_DrawLine( this.Layer.g, pen, this.x1, this.y1, this.x2, this.y2)
            UpdateLayeredWindow( this.Layer.hwnd, this.Layer.mhdc, )
            Gdip_DeletePen(pen)
            this.Layer.drawings.Push( { Name:"DrawLine",
                                        WinActi:this.Layer.Win,
                                        penWidth:this.penWidth,
                                        xlCoord:this.x1,
                                        ylCoord:this.y1,
                                        rxCoord:this.x2,
                                        ryCoord:this.y2} )
        }
        else if (this.type = "Eraser") {
            this.color := "00FFFFFF"
            pen := New_Pen( this.color, ,1 )
            ;pen := Gdip_CreatePen(0xFFFFFFFF, this.penWidth)
            Gdip_GraphicsClear( this.Layer.g )
            Gdip_DrawLine(this.Layer.g, pen, this.x1, this.y1, this.x2, this.y2)
            UpdateLayeredWindow( this.Layer.hwnd, this.Layer.mhdc, )
            Gdip_DeletePen(pen)
        }
    }
}


*/



/*
class Draw {

    static dpi := A_ScreenDPI / 96
    /**
     * Construtor: Inicializa um desenho com tipo, coordenadas, cor e largura.
     *
     * Parameters:
     *   type  - Tipo do desenho (e.g., "Pencil", "Eraser").
     *   x1    - Coordenada X inicial.
     *   y1    - Coordenada Y inicial.
     *   x2    - Coordenada X final.
     *   y2    - Coordenada Y final.
     *   color - Cor do desenho.
     *   width - Largura do desenho.
     *

*/
ddd := region.andress
MsgBox( ddd )
region.__Delete()
class region {

    static dpi := A_ScreenDPI / 96
    static cont := 0
    static andress := CallbackCreate( region.MouseMove  )
    static mouseBuff := Buffer( 32, 0 )

    static __Delete() {
        CallbackFree( region.andress )
    }
    

/*
    __Init( ) {
        this.flag := 1
        this.layer := Gui( "-Caption +LastFound +E0x80000 +AlwaysOnTop" )
        this.cont := region.cont
        this.layerWidth := A_ScreenWidth * region.dpi
        this.layerHeight := A_ScreenHeight * region.dpi
        this.layer.Show( "x0 y0 w" this.layerWidth " h" this.layerHeight )
        ++region.Cont
    }

    __New( regionParams* ) {
        if ( regionParams.Length ) {
            ;this.Show( region )
        }
        else {

        }
    }
    
    Add( x, y, width, height, color := "", opacity := 1) {
        region := Gui()
        region.BackColor := color
        region.Opacity := opacity
        region.Show("x" x " y" y " w" width " h" height)
    }
*/
    static MouseMove( nCode, wParam, lParam ) { 

        Critical
        static lastMouseMove := A_TickCount
        If ( !nCode && ( wParam = 0x200 ) ) { 
            
            diffMouseMove := A_TickCount - lastMouseMove
            lastMouseMove := A_TickCount

            NumPut( "Int", NumGet( lParam, 0, "Int" ), region.mouseBuff, 0 )
            NumPut( "Int", NumGet( lParam, 0, "Int" ), region.mouseBuff, 4 )

        }

        LRESULT := 
        DllCall(
            "CallNextHookEx",
            "Uint", 0,
            "int", nCode,
            "Uint", wParam,
            "Uint", lParam
        ) 

        Return LRESULT
    }
}
/*
    Destroy( ) {
        this.layer.Destroy()
        this.layer := ""
        this := ""
    }

    __Delete() {

        if ( this.layer )
            this.layer.Destroy()
    }   

    select( Key1 := "x", Key2 := "x" ) {
        
       
        static hHookMouse := 0
        

        if ( this.flag = 1 ) {

            KeyWait( Key1, "D" )        
            if ( Key1 = Key2) {
                Sleep( 1050 )
                SetTimer( inSelect, 16 )
            }
        }
        else if ( this.flag = 2) {
            Capture()
        }
        else {
            Exit()
        }

        Capture() {   
            hHookMouse:= SetHook( 14, andress )
            Exit()
        }


        inSelect() {
            if ( !KeyWait( Key2, "D T0,1" ) ) {
                MsgBox( "" )
                SetTimer( inSelect, 0 ) 
            }
            ;andress := CallbackCreate( MouseMove )    
            hHookMouse:= SetHook( 14, andress )
            ToolTip( "mdf" )
        }
        
        Exit() {

            if ( andress ) {
                Unhook( &andress, &hHookMouse )
            }

        }



        SetHook( idHook, pfn ) {
            hHook := SetWindowsHookEx( idHook, pfn ) ;DllCall("SetWindowsHookEx", "int", idHook, "Ptr", pfn, "Ptr", DllCall("GetModuleHandle", "Ptr", 0), "UInt", 0, "Ptr")
            if ( !hHook ) {
                MsgBox( "Failed to set hook: " idHook )
                ExitApp()
            }
            return hHook
        }

        

        CallNextHookEx( nCode, wParam, lParam, hHook := 0 ) {
            DllCall(
                "CallNextHookEx",
                "Uint", hHook,
                "int", nCode,
                "Uint", wParam,
                "Uint", lParam
            ) 
            
            Return LRESULT
        }
        
        SetWindowsHookEx( idHook, pfn ) {
            hModule := GetModuleHandle()
                LRESULT :=
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
        
        UnhookWindowsHookEx( hHook ) { 
            bool :=
            DllCall(
                "UnhookWindowsHookEx",
                "Uint", hHook,
                "int"
            )
            Return bool
        }

        Unhook( &andress, &hHookMouse ) {            
            CallbackFree( andress )
            UnhookWindowsHookEx( hHookMouse ) 
        }

    }
    
}
     *
    __New( type, x1, y1, x2, y2, color, width ) {
        this.type := type
        this.x1 := x1 * Draw.dpi
        this.y1 := y1 * Draw.dpi
        this.x2 := x2 * Draw.dpi
        this.y2 := y2 * Draw.dpi
        this.color := color
        this.width := width * Draw.dpi
        ObjLayer := Layer()
        this.g := ObjLayer.g
        this.hbm := ObjLayer.hbm
        this.Execute()
    }

    /*
     * Execute: Executa o desenho no contexto gráfico fornecido (g).
     *
     * Parameters:
     *   g - Contexto gráfico onde o desenho será executado.
     *
    Execute() {
        if ( this.type = "Pencil" ) {
            pen := Gdip_CreatePen( this.color, this.width )
            Gdip_DrawLine( this.g, pen, this.x1, this.y1, this.x2, this.y2 )
            Gdip_DeletePen(pen)
        } else if (this.type = "Eraser") {
            pen := Gdip_CreatePen(0xFFFFFFFF, this.width)
            Gdip_DrawLine(this.g, pen, this.x1, this.y1, this.x2, this.y2)
            Gdip_DeletePen(pen)
        }
    }
}
