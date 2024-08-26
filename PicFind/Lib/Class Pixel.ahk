#Include Includes.ahk

class Pixel {
    ; Propriedades
    x          ; Posição X do pixel
    y          ; Posição Y do pixel
    red        ; Componente de cor vermelha (0-255)
    green      ; Componente de cor verde (0-255)
    blue       ; Componente de cor azul (0-255)
    alpha      ; Componente alfa/transparência (0-255)
    bitDepth   ; Profundidade de cor em bits (1, 4, 8, 16, 24, 32)
    
    ; Construtor
    __New( x := 0, y := 0, red := 0, green := 0, blue := 0, alpha := 255, bitDepth := 24) {
        this.x := x
        this.y := y
        this.red := red
        this.green := green
        this.blue := blue
        this.alpha := alpha
        GetbiBitCount( 24 )
        this.biBitCount := biBitCount
    }
    
    ; Método para definir a cor do pixel
    SetColor(red, green, blue, alpha := 255) {
        this.red := red
        this.green := green
        this.blue := blue
        this.alpha := alpha
    }
    
    ; Método para obter a cor do pixel como uma string hexadecimal
    GetHexColor() {
        if this.bitDepth >= 24
            return Format("{:02X}{:02X}{:02X}", this.red, this.green, this.blue)
        else
            MsgBox, Warning: This method is not accurate for bitDepth less than 24 bits!
    }
    
    ; Método para obter a cor como um valor ARGB (alfa, vermelho, verde, azul)
    GetARGB() {
        if this.bitDepth == 32
            return Format("{:02X}{:02X}{:02X}{:02X}", this.alpha, this.red, this.green, this.blue)
        else
            MsgBox, Warning: ARGB representation is meaningful for 32-bit depth!
    }
    
    ; Método para verificar se o pixel é transparente
    IsTransparent() {
        return (this.alpha = 0)
    }
    
    ; Método para alterar a posição do pixel
    MoveTo(newX, newY) {
        this.x := newX
        this.y := newY
    }
    
    ; Método para representar o pixel como string
    ToString() {
        return "Pixel(" . this.x . "," . this.y . ") - RGB(" . this.red . "," . this.green . "," . this.blue . ") - Alpha: " . this.alpha . " - BitDepth: " . this.bitDepth
    }
}
