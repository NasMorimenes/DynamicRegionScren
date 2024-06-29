#Include GDIP_V2.ahk
#Include GdipManager.ahk


Ass := _Layer( "tTeste m5", "CAsa" )

Class _Layer extends Gui {

    static dpi := A_ScreenDPI / 96

    __New( config* ) {
        if( config.Length  > 0 ) {
            for j in config {
                FoundPos := InStr( j, "t" , 1 )
                EndPos := InStr( j, " ", , FoundPos + 1)
                MsgBox( SubStr( j, FoundPos + 1 , ( EndPos - 1 ) - FoundPos ))
            }
        }
        super.__New( "-Caption +LastFound +E0x80000 +AlwaysOnTop" )
        this.Show( "x10 y50 w100 h50")
    }
}

class Layer {

    static dpi := A_ScreenDPI / 96

    __New( title, Name, pX, pY, width, heigth ) {
        
        this.hwnd := this.Surface( title, Name, pX, pY, width, heigth )
        this.setup()
        this.Win := WinGetTitle( WinActive( "A" ) )
        this.drawings := []
    }

    Surface( title, Name, pX, pY, width, heigth ) {

        mySurface := Gui( "-Caption +LastFound +E0x80000 +AlwaysOnTop", title )
        mySurface.Show( "x" pX " y" pY " w" width " h" heigth )
        return mySurface.Hwnd
    }

    setup() {
        this.hdc := GetDC( this.hwnd )
        this.hbm := CreateDIBSection(A_ScreenWidth * Layer.dpi, A_ScreenHeight * Layer.dpi)
        this.mhdc := CreateCompatibleDC( this.hdc )
        this.obm := SelectObject(this.mhdc, this.hbm)
        this.g := Gdip_GraphicsFromHDC( this.mhdc )
        Gdip_SetSmoothingMode(this.g, 4)
    }

    AddDrawing(draw) {
        this.drawings.Push(draw)
        draw.Execute(this.g)
    }

    Draw( hdc ) {
        Gdip_DrawImage(hdc, this.hbm, 0, 0, A_ScreenWidth * Layer.dpi, A_ScreenHeight * Layer.dpi)
    }

    Clear() {
        Gdip_GraphicsClear(this.g, 0xFFFFFFFF)
    }

    __Delete() {
        Gdip_DeleteGraphics(this.g)
        SelectObject(this.mhdc, this.obm)
        DeleteObject(this.hbm)
        DeleteDC(this.mhdc)
    }

}
/*
#Include Gdip_OnOff.ahk
#Include GDIP_V2.ahk
#Include ClassDraw.ahk
#Include ClassLayered.ahk

class Layer {
    static dpi := A_ScreenDPI / 96
    static g := 0
    /*
     * Construtor: Inicializa uma camada com um bitmap e um contexto gráfico.
     */
    /*
    __New() {
        this.drawings := []
        ; Cria um bitmap para a camada
        this.hbm := CreateDIBSection( A_ScreenWidth * Layer.dpi, A_ScreenHeight * Layer.dpi )
        this.hdc := CreateCompatibleDC()
        this.obm := SelectObject( this.hdc, this.hbm )
        this.g := Gdip_GraphicsFromHDC( this.hdc )
        Gdip_GraphicsClear( this.g, 0xFFFFFFFF )
        Gdip_SetSmoothingMode( this.g, 4 )

    }

    /*
     * AddDrawing: Adiciona um desenho à camada e executa o desenho no contexto gráfico da camada.
     *
     * Parameters:
     *   draw - Objeto Draw a ser adicionado à camada.
     *
    AddDrawing( draw ) {
        this.drawings.Push( draw )
        draw.Execute( this.g )
    }

    /*
     * Draw: Desenha a camada na tela fornecida (hdc).
     *
     * Parameters:
     *   hdc - Contexto de dispositivo da tela onde a camada será desenhada.
     *
    Draw(hdc) {
        Gdip_DrawImage( hdc, this.hbm, 0, 0, A_ScreenWidth * Layer.dpi, A_ScreenHeight * Layer.dpi)
    }

    /*
     * Clear: Limpa o conteúdo da camada.
     *
    Clear() {
        Gdip_GraphicsClear(this.g, 0xFFFFFFFF)
    }

    /*
     * Destrutor: Libera recursos gráficos quando o objeto é destruído.
     *
    __Delete() {
        Gdip_DeleteGraphics(this.g)
        SelectObject(this.hdc, this.obm)
        DeleteObject(this.hbm)
        DeleteDC(this.hdc)
    }
}
