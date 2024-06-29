#Include GDIP_V2.ahk
#Include ClassLayer.ahk

class Draw {
    static dpi := A_ScreenDPI / 96    

    __New( type, x1, y1, x2, y2, color, title, name := "Default", pX := 0, pY := 0, width := A_ScreenWidth, height := A_ScreenHeight ) {

        this.type := type
        this.x1 := x1 * Draw.dpi
        this.y1 := y1 * Draw.dpi
        this.x2 := x2 * Draw.dpi
        this.y2 := y2 * Draw.dpi
        this.color := color
        this.title := title
        ObjLayer := Layer( this.title, name, pX := 0, pY := 0, width := A_ScreenWidth, height := A_ScreenHeight )
        this.G := ObjLayer.G
        this.Execute()
    }

    Execute() {
        if (this.type = "Pencil") {
            pen := Gdip_CreatePen(this.color, this.width)
            ;pen := New_Pen(this.color, , this.width )
            Gdip_GraphicsClear( this.g )
            Gdip_DrawLine( this.g, pen, this.x1, this.y1, this.x2, this.y2)
            UpdateLayeredWindow( this.hwnd, this.hdc, )
            Gdip_DeletePen(pen)
        } else if (this.type = "Eraser") {
            pen := Gdip_CreatePen(0xFFFFFFFF, this.width)
            Gdip_GraphicsClear( this.g )
            Gdip_DrawLine(this.g, pen, this.x1, this.y1, this.x2, this.y2)
            UpdateLayeredWindow( this.hwnd, this.hdc, )
            Gdip_DeletePen(pen)
        }
    }
}


/*

#Include Gdip_OnOff.ahk
#Include GDIP_V2.ahk


class Draw {
    static dpi := A_ScreenDPI / 96
    /*
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
