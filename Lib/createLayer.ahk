Create_Layered_GUI( &Layered, x, y, w, h ) {

    Layered:= Gui( "-Caption +E0x80000 +LastFound +OwnDialogs +Owner +AlwaysOnTop", "TestGui" )
    ;Implementar criação dinâmicas de Guis
    hwnd := Layered.hwnd
    Layered.Show( "x" x " y" y " w" w " h" h " NA" )
    
}