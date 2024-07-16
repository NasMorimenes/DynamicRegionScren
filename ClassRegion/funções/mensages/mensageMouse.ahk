WM_CAPTURECHANGED(Values) {
    return ["WM_CAPTURECHANGED: A captura do mouse foi alterada."]
}

WM_LBUTTONDBLCLK(Values) {
    return ["WM_LBUTTONDBLCLK: Duplo clique com o botão esquerdo do mouse."]
}

WM_LBUTTONDOWN(Values) {
    return ["WM_LBUTTONDOWN: Botão esquerdo do mouse pressionado."]
}

WM_LBUTTONUP(Values) {
    return ["WM_LBUTTONUP: Botão esquerdo do mouse liberado."]
}

WM_MBUTTONDBLCLK(Values) {
    return ["WM_MBUTTONDBLCLK: Duplo clique com o botão do meio do mouse."]
}

WM_MBUTTONDOWN(Values) {
    return ["WM_MBUTTONDOWN: Botão do meio do mouse pressionado."]
}

WM_MBUTTONUP(Values) {
    return ["WM_MBUTTONUP: Botão do meio do mouse liberado."]
}

WM_MOUSEACTIVATE(Values) {
    return ["WM_MOUSEACTIVATE: Janela ativada por um evento de mouse."]
}

WM_MOUSEHOVER(Values) {
    return ["WM_MOUSEHOVER: O cursor do mouse está pairando."]
}

WM_MOUSELEAVE(Values) {
    return ["WM_MOUSELEAVE: O cursor do mouse deixou a janela."]
}

WM_MOUSEMOVE(Values) {
    xPos := NumGet(Values["lParam"], 0, "Int")
    yPos := NumGet(Values["lParam"], 4, "Int")
    return ["WM_MOUSEMOVE: Movimento do mouse - X: " xPos ", Y: " yPos]
}

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

    state := Values["wParam"] & 0xFFFF
    wheelDelta := Values["wParam"] >> 16
    result := []

    for key, val in data {
        if (state & val[1]) {
            result.Push(val[2])
        }
    }

    if (wheelDelta > 0) {
        result.Push("A roda do mouse foi rolada para cima.")
    } else if (wheelDelta < 0) {
        result.Push("A roda do mouse foi rolada para baixo.")
    }

    return result
}

WM_NCHITTEST(Values) {
    return ["WM_NCHITTEST: Teste de hit non-client."]
}

WM_NCLBUTTONDBLCLK(Values) {
    return ["WM_NCLBUTTONDBLCLK: Duplo clique com o botão esquerdo do mouse na área non-client."]
}

WM_NCLBUTTONDOWN(Values) {
    return ["WM_NCLBUTTONDOWN: Botão esquerdo do mouse pressionado na área non-client."]
}

WM_NCLBUTTONUP(Values) {
    return ["WM_NCLBUTTONUP: Botão esquerdo do mouse liberado na área non-client."]
}

WM_NCMBUTTONDBLCLK(Values) {
    return ["WM_NCMBUTTONDBLCLK: Duplo clique com o botão do meio do mouse na área non-client."]
}

WM_NCMBUTTONDOWN(Values) {
    return ["WM_NCMBUTTONDOWN: Botão do meio do mouse pressionado na área non-client."]
}

WM_NCMBUTTONUP(Values) {
    return ["WM_NCMBUTTONUP: Botão do meio do mouse liberado na área non-client."]
}

WM_NCMOUSEHOVER(Values) {
    return ["WM_NCMOUSEHOVER: O cursor do mouse está pairando na área non-client."]
}

WM_NCMOUSELEAVE(Values) {
    return ["WM_NCMOUSELEAVE: O cursor do mouse deixou a área non-client."]
}

WM_NCMOUSEMOVE(Values) {
    xPos := NumGet(Values["lParam"], 0, "Int")
    yPos := NumGet(Values["lParam"], 4, "Int")
    return ["WM_NCMOUSEMOVE: Movimento do mouse na área non-client - X: " xPos ", Y: " yPos]
}

WM_NCRBUTTONDBLCLK(Values) {
    return ["WM_NCRBUTTONDBLCLK: Duplo clique com o botão direito do mouse na área non-client."]
}

WM_NCRBUTTONDOWN(Values) {
    return ["WM_NCRBUTTONDOWN: Botão direito do mouse pressionado na área non-client."]
}

WM_NCRBUTTONUP(Values) {
    return ["WM_NCRBUTTONUP: Botão direito do mouse liberado na área non-client."]
}

WM_NCXBUTTONDBLCLK(Values) {
    return ["WM_NCXBUTTONDBLCLK: Duplo clique com um botão X na área non-client."]
}

WM_NCXBUTTONDOWN(Values) {
    return ["WM_NCXBUTTONDOWN: Botão X pressionado na área non-client."]
}

WM_NCXBUTTONUP(Values) {
    return ["WM_NCXBUTTONUP: Botão X liberado na área non-client."]
}

WM_RBUTTONDBLCLK(Values) {
    return ["WM_RBUTTONDBLCLK: Duplo clique com o botão direito do mouse."]
}

WM_RBUTTONDOWN(Values) {
    return ["WM_RBUTTONDOWN: Botão direito do mouse pressionado."]
}

WM_RBUTTONUP(Values) {
    return ["WM_RBUTTONUP: Botão direito do mouse liberado."]
}

WM_XBUTTONDBLCLK(Values) {
    xButton := (Values["wParam"] >> 16) & 0xFFFF
    return ["WM_XBUTTONDBLCLK: Duplo clique com o botão X" xButton " do mouse."]
}

WM_XBUTTONDOWN(Values) {
    xButton := (Values["wParam"] >> 16) & 0xFFFF
    return ["WM_XBUTTONDOWN: Botão X" xButton " do mouse pressionado."]
}

WM_XBUTTONUP(Values) {
    xButton := (Values["wParam"] >> 16) & 0xFFFF
    return ["WM_XBUTTONUP: Botão X" xButton " do mouse liberado."]
}
