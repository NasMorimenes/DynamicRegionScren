class GraphicsContext {
    __New( width, height ) {
        this.width := width
        this.height := height
        this.InitGDIPlus()
        this.CreateBitmap()
    }

    InitGDIPlus() {
        if !this.pToken := Gdip_Startup() ; Inicia a biblioteca GDI+
            throw( "Failed to start GDI+" )
    }

    CreateBitmap() {
        this.pBitmap := Gdip_CreateBitmap(this.width, this.height)
        this.g := Gdip_GraphicsFromImage(this.pBitmap)
        Gdip_SetSmoothingMode(this.g, 4) ; Melhor qualidade de desenho
    }

    Show() {
        Gui, New, +AlwaysOnTop
        hBitmap := Gdip_CreateHBITMAPFromBitmap(this.pBitmap)
        Gui, Add, Picture, , HBITMAP:%hBitmap%
        Gui, Show
    }

    Cleanup() {
        Gdip_DeleteGraphics(this.g)
        Gdip_DisposeImage(this.pBitmap)
        Gdip_Shutdown(this.pToken)
    }
}
