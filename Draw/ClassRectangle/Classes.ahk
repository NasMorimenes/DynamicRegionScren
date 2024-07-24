class PosicaoX {
    __New(valor := 0, unidade := "px", min_value := 0, max_value := 1920, is_visible := true, description := "") {
        this.dpi_scale := this.GetDpiScale()
        this.valor := valor * this.dpi_scale
        this.unidade := unidade
        this.min_value := min_value * this.dpi_scale
        this.max_value := max_value * this.dpi_scale
        this.is_visible := is_visible
        this.description := description
    }

    GetDpiScale() {
        hDC := DllCall("GetDC", "Ptr", 0, "Ptr")
        dpi := DllCall("GetDeviceCaps", "Ptr", hDC, "Int", 88)  ; 88 é o índice para LOGPIXELSX (DPI horizontal)
        DllCall("ReleaseDC", "Ptr", 0, "Ptr", hDC)
        return dpi / 96  ; 96 é a DPI padrão
    }
    

    get_value() {
        return this.valor / this.dpi_scale
    }

    set_value(novo_valor) {
        if (novo_valor * this.dpi_scale >= this.min_value && novo_valor * this.dpi_scale <= this.max_value) {
            this.valor := novo_valor * this.dpi_scale
        } else {
            MsgBox "Valor fora dos limites permitidos (" . this.min_value / this.dpi_scale . " - " . this.max_value / this.dpi_scale . ")."
        }
    }

    increment(quantidade) {
        if (this.valor + (quantidade * this.dpi_scale) <= this.max_value) {
            this.valor += quantidade * this.dpi_scale
        } else {
            MsgBox "Incremento excede o valor máximo permitido (" . this.max_value / this.dpi_scale . ")."
        }
    }

    decrement(quantidade) {
        if (this.valor - (quantidade * this.dpi_scale) >= this.min_value) {
            this.valor -= quantidade * this.dpi_scale
        } else {
            MsgBox "Decremento excede o valor mínimo permitido (" . this.min_value / this.dpi_scale . ")."
        }
    }

    get_visibility() {
        return this.is_visible
    }

    set_visibility(is_visible) {
        this.is_visible := is_visible
    }

    to_string() {
        return "Valor: " . this.valor / this.dpi_scale . " " . this.unidade . ", Visível: " . (this.is_visible ? "Sim" : "Não") . ", Descrição: " . this.description
    }
}

class PosicaoY {
    __New(valor := 0, unidade := "px", min_value := 0, max_value := 1080, is_visible := true, description := "") {
        this.dpi_scale := this.GetDpiScale()
        this.valor := valor * this.dpi_scale
        this.unidade := unidade
        this.min_value := min_value * this.dpi_scale
        this.max_value := max_value * this.dpi_scale
        this.is_visible := is_visible
        this.description := description
    }

    GetDpiScale() {
        hDC := DllCall("GetDC", "Ptr", 0, "Ptr")
        dpi := DllCall("GetDeviceCaps", "Ptr", hDC, "Int", 88)  ; 88 é o índice para LOGPIXELSX (DPI horizontal)
        DllCall("ReleaseDC", "Ptr", 0, "Ptr", hDC)
        return dpi / 96  ; 96 é a DPI padrão
    }
    

    get_value() {
        return this.valor / this.dpi_scale
    }

    set_value(novo_valor) {
        if (novo_valor * this.dpi_scale >= this.min_value && novo_valor * this.dpi_scale <= this.max_value) {
            this.valor := novo_valor * this.dpi_scale
        } else {
            MsgBox "Valor fora dos limites permitidos (" . this.min_value / this.dpi_scale . " - " . this.max_value / this.dpi_scale . ")."
        }
    }

    increment(quantidade) {
        if (this.valor + (quantidade * this.dpi_scale) <= this.max_value) {
            this.valor += quantidade * this.dpi_scale
        } else {
            MsgBox "Incremento excede o valor máximo permitido (" . this.max_value / this.dpi_scale . ")."
        }
    }

    decrement(quantidade) {
        if (this.valor - (quantidade * this.dpi_scale) >= this.min_value) {
            this.valor -= quantidade * this.dpi_scale
        } else {
            MsgBox "Decremento excede o valor mínimo permitido (" . this.min_value / this.dpi_scale . ")."
        }
    }

    get_visibility() {
        return this.is_visible
    }

    set_visibility(is_visible) {
        this.is_visible := is_visible
    }

    to_string() {
        return "Valor: " . this.valor / this.dpi_scale . " " . this.unidade . ", Visível: " . (this.is_visible ? "Sim" : "Não") . ", Descrição: " . this.description
    }
}

class Ponto {
    __New(x_valor := 0, y_valor := 0, unidade := "px", is_visible := true, description := "") {
        this.x:= PosicaoX(x_valor, unidade, 0, 1920, is_visible, description)
        this.y:= PosicaoY(y_valor, unidade, 0, 1080, is_visible, description)
    }

    get_x() {
        return this.x.get_value()
    }

    set_x(novo_valor) {
        this.x.set_value(novo_valor)
    }

    get_y() {
        return this.y.get_value()
    }

    set_y(novo_valor) {
        this.y.set_value(novo_valor)
    }

    increment_x(quantidade) {
        this.x.increment(quantidade)
    }

    decrement_x(quantidade) {
        this.x.decrement(quantidade)
    }

    increment_y(quantidade) {
        this.y.increment(quantidade)
    }

    decrement_y(quantidade) {
        this.y.decrement(quantidade)
    }

    get_visibility() {
        return this.x.get_visibility() && this.y.get_visibility()
    }

    set_visibility(is_visible) {
        this.x.set_visibility(is_visible)
        this.y.set_visibility(is_visible)
    }

    to_string() {
        return "Ponto(X: " . this.x.to_string() . ", Y: " . this.y.to_string() . ")"
    }
}

class Retangulo {
    __New(x1 := 0, y1 := 0, x2 := 0, y2 := 0, unidade := "px", is_visible := true, description := "") {
        this.top_left:= Ponto(x1, y1, unidade, is_visible, description)
        this.bottom_right:= Ponto(x2, y2, unidade, is_visible, description)
    }

    ; Métodos para obter e definir a posição do canto superior esquerdo
    get_top_left() {
        return this.top_left
    }

    set_top_left(x_valor, y_valor) {
        this.top_left.set_x(x_valor)
        this.top_left.set_y(y_valor)
    }

    ; Métodos para obter e definir a posição do canto inferior direito
    get_bottom_right() {
        return this.bottom_right
    }

    set_bottom_right(x_valor, y_valor) {
        this.bottom_right.set_x(x_valor)
        this.bottom_right.set_y(y_valor)
    }

    ; Métodos para obter a largura e altura do retângulo
    get_width() {
        return this.bottom_right.get_x() - this.top_left.get_x()
    }

    get_height() {
        return this.bottom_right.get_y() - this.top_left.get_y()
    }

    ; Método para verificar se o retângulo está visível
    get_visibility() {
        return this.top_left.get_visibility() && this.bottom_right.get_visibility()
    }

    ; Método para definir a visibilidade do retângulo
    set_visibility(is_visible) {
        this.top_left.set_visibility(is_visible)
        this.bottom_right.set_visibility(is_visible)
    }

    ; Método para mover o retângulo
    move(dx, dy) {
        this.top_left.increment_x(dx)
        this.top_left.increment_y(dy)
        this.bottom_right.increment_x(dx)
        this.bottom_right.increment_y(dy)
    }

    ; Método para redimensionar o retângulo
    resize(dw, dh) {
        this.bottom_right.increment_x(dw)
        this.bottom_right.increment_y(dh)
    }

    ; Método para retornar uma representação em string do retângulo
    to_string() {
        return "Retângulo(Top Left: " . this.top_left.to_string() . ", Bottom Right: " . this.bottom_right.to_string() . ", Largura: " . this.get_width() . ", Altura: " . this.get_height() . ")"
    }
}

; Exemplo de uso da classe Retangulo
myRetangulo := Retangulo(100, 100, 300, 300, "px", true, "Retângulo inicial")
MsgBox myRetangulo.to_string()  ; Exibe informações do retângulo

myRetangulo.move(50, 50)
MsgBox myRetangulo.to_string()  ; Exibe informações do retângulo após movê-lo

myRetangulo.resize(100, 50)
MsgBox myRetangulo.to_string()  ; Exibe
