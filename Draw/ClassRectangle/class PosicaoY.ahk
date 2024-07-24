Ass := PosicaoY( 10, , 20 )
MsgBox( Ass.to_string() )

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
