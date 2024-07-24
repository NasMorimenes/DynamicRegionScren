#Include class PosicaoX.ahk
#Include class PosicaoY.ahk

class Ponto {
    __New( x_valor := 0, y_valor := 0, unidade := "px", is_visible := true, description := "") {
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