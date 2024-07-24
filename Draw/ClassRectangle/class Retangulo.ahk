#Include class Ponto.ahk

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

myRetangulo.set_visibility(false)
MsgBox myRetangulo.to_string()  ; Exibe informações do retângulo após definir visibilidade