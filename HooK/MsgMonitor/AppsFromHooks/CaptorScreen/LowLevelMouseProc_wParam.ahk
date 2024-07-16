LowLevelMouseProc_wParam(wParam) {
    switch wParam {
        case 513: ; WM_LBUTTONDOWN (0x0201)
            return WM_LBUTTONDOWN()
        case 514: ; WM_LBUTTONUP (0x0202)
            return WM_LBUTTONUP()
        case 512: ; WM_MOUSEMOVE (0x0200)
            return WM_MOUSEMOVE()
        case 522: ; WM_MOUSEWHEEL (0x020A)
            return WM_MOUSEWHEEL()
        case 516: ; WM_RBUTTONDOWN (0x0204)
            return WM_RBUTTONDOWN()
        case 517: ; WM_RBUTTONUP (0x0205)
            return WM_RBUTTONUP()
        default:
            return ToolTip()
    }


    WM_LBUTTONDOWN() {
        return "LButton Pressionado"
    }

    WM_LBUTTONUP() {
        return "LButton Soltado"
    }

    WM_MOUSEMOVE() {
        return "Mouse Movido"
    }

    WM_MOUSEWHEEL() {
        return "Roda Mouse"
    }

    WM_RBUTTONDOWN() {
        return "RButton Pressionado"
    }

    WM_RBUTTONUP() {
        return "RButton Soltado"
    }
}