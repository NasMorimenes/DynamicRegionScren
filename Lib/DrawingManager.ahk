;#Include <ClassDraw>
;#Include <ClassLayered>
;#Include <UpdateGui>
;#Include GE1.ahk

class DrawingManager {
    __New() {
        this.drawings := []
        this.currentDrawing := []
        this.layered := Layered()
        this.InitGui()
    }

    InitGui() {
        myG := 0
        Opt_E := "-Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs -DPIScale"
        this.HWND := GraphicalDesktop( &myG, Opt_E, "DrawingApp", "w" A_ScreenWidth " h" A_ScreenHeight )
        if !this.HWND {
            MsgBox "Falha ao criar a janela gráfica."
            ExitApp
        }
    }

    StartNewDrawing() {
        if !this.currentDrawing.Empty() {
            this.EndCurrentDrawing()
        }
        this.currentDrawing := []
        MsgBox "Nova seção de desenho iniciada."
    }

    EndCurrentDrawing() {
        if this.currentDrawing.Empty() {
            MsgBox "Nenhuma seção de desenho em andamento."
            return
        }
        newMap := {}
        for _, line in this.currentDrawing {
            newMap.Push(line)
        }
        this.drawings.Push(newMap)
        this.currentDrawing := []
        MsgBox "Seção de desenho encerrada e armazenada."
    }

    AddLine(x, y) {
        if this.currentDrawing.Empty() {
            MsgBox "Inicie uma nova seção de desenho antes de adicionar linhas."
            return
        }
        if !this.prevX {
            this.prevX := x
            this.prevY := y
            return
        }
        draw1 := Draw("Pencil", this.prevX, this.prevY, x, y, 0xFF000000, 3 )
        this.currentDrawing.Push(draw1)
        this.layered.AddLayer().AddDrawing(draw1)
        this.prevX := x
        this.prevY := y
        UpdateGUI(this.HWND, draw1.hbm)
    }
}
