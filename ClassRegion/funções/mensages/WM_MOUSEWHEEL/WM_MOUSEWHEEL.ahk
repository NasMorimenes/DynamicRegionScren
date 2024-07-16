WM_MOUSEWHEEL(Values) {
    
    data := Map(
        "MK_CONTROL", [0x0008, "A tecla CTRL está inativa."],
        0x0008, ["MK_CONTROL", "A tecla CTRL está inativa."],
        "MK_LBUTTON", [0x0001, "O botão esquerdo do mouse está desativado."],
        0x0001, ["MK_LBUTTON", "O botão esquerdo do mouse está desativado."],        
        "MK_MBUTTON", [0x0010, "O botão do meio do mouse está desativado."],
        0x0010, ["MK_MBUTTON", "O botão do meio do mouse está desativado."],
        "MK_RBUTTON", [0x0002, "O botão direito do mouse está para baixo."],
        0x0002, ["MK_RBUTTON", "O botão direito do mouse está para baixo."],
        "MK_SHIFT", [0x0004, "A tecla SHIFT está inativa."],
        0x0004, ["MK_SHIFT", "A tecla SHIFT está inativa."],
        "MK_XBUTTON1", [0x0020, "O primeiro botão X está inativo."],
        0x0020, ["MK_XBUTTON1", "O primeiro botão X está inativo."],
        "MK_XBUTTON2", [0x0040, "O segundo botão X está inativo."],
        0x0040, ["MK_XBUTTON2", "O segundo botão X está inativo."]
    )
    
    ; Extraindo informações de wParam
    state := Values["wParam"] & 0xFFFF  ; Estado dos botões e teclas modificadoras
    wheelDelta := Values["wParam"] >> 16 ; Delta da roda do mouse
    
    ; Analisando o estado dos botões e teclas modificadoras
    result := []
    for key, val in data {
        if (state & val[1]) {
            result.Push(val[2])
        }
    }
    
    ; Direção da rolagem da roda do mouse
    if (wheelDelta > 0) {
        result.Push("A roda do mouse foi rolada para cima.")
    } else if (wheelDelta < 0) {
        result.Push("A roda do mouse foi rolada para baixo.")
    }
    
    return result
}
